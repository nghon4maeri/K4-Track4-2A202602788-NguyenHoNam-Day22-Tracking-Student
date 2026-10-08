# Báo cáo lab: chọn tracker cho 5 video

**Nhóm:** Cá nhân **Thành viên:** Nguyễn Hồ Nam (MSSV: 2A202602788)

Detector cố định: `yolo26n.pt`, ảnh 640 px, Re-ID `osnet_x0_25_msmt17`. Không đổi các mục này trong bài nộp chính.

## 1. Cấu hình đã chọn

Mỗi video: tracker bạn nộp, `conf`, `iou`, điều bạn **nhìn thấy** trên video, và một cấu hình đã thử rồi loại.

| Video | Tracker | conf | iou | Quan sát khi xem video | Đã thử nhưng loại |
|---|---|---|---|---|---|
| video_1 (quảng trường, tĩnh, ban ngày) | bytetrack | 0.3 | 0.5 | Ít bị nhảy ID khi người đi bộ không bị che khuất. Bám người tốt vì camera tĩnh. | ocsort (cùng conf, iou) - không cải thiện đáng kể nhưng tốc độ chậm hơn một chút. |
| video_2 (phố đêm, tĩnh, rất đông) | ocsort | 0.2 | 0.4 | Rất đông người và che khuất nhiều, ocsort khôi phục ID tốt hơn sau khi bị che khuất nhờ thuật toán OC. | botsort - do quá đông, Re-ID bị nhiễu và nối nhầm ID giữa những người mặc đồ tối màu giống nhau. |
| video_3 (camera di động, ảnh nhỏ) | botsort | 0.25 | 0.5 | Có bù trừ chuyển động camera nên box ổn định, kết hợp Re-ID giúp giữ ID tốt dù ảnh nhỏ. | bytetrack - mất ID liên tục và tạo ID mới do camera di chuyển làm lệch tọa độ hộp. |
| video_4 (trong nhà, camera di chuyển) | deepocsort | 0.3 | 0.5 | Khắc phục được lỗi bóng kính và chuyển động camera tiến tới. Giữ được ID khi người đi qua vùng sáng phản chiếu. | strongsort - xử lý chậm hơn và Re-ID đôi khi bắt nhầm bóng trong kính. |
| video_5 (trên xe bus, giao lộ đông) | botsort | 0.3 | 0.5 | Camera rung lắc mạnh, thuật toán GMC của BoTSORT giúp liên kết hộp chính xác hơn, tránh bị đứt quãng ID. | ocsort - không có bù trừ chuyển động camera (GMC) tốt như botsort nên dễ đứt ID khi xe giật. |

## 2. Số liệu video_1

Dán bảng HOTA / MOTA / IDF1 do `scripts/evaluate_practice.py` in ra.

```text
Eval for: video_1 (ByteTrack)
HOTA: 26.912
MOTA: 17.292
IDF1: 25.713
```

`video_2` đến `video_5` không có nhãn trong gói lab. Không điền số cho các video đó.

## 3. Phân tích

Với **ít nhất hai video** (nên gồm một video bạn chỉ đánh giá bằng mắt), viết 3–5 câu:

- Ở `video_3` (camera di động, quay ngang), tracker **BoTSORT** giữ ID tốt hơn hẳn so với ByteTrack nhờ khả năng bù trừ chuyển động camera (Camera Motion Compensation). Khi camera quét ngang, ByteTrack chỉ dựa vào IoU tĩnh nên liên tục gán nhầm hoặc tạo ID mới, trong khi BoTSORT dùng thêm đặc trưng ngoại hình (Re-ID) và dịch chuyển tọa độ nên vẫn bám được mục tiêu dù ảnh mờ nhỏ.
- Ở `video_2` (phố đêm rất đông), tracker **OC-SORT** lại thể hiện ưu thế. Vì cảnh quá đông đúc và tối, đặc trưng ngoại hình không còn tin cậy (nhiễu Re-ID), OC-SORT sử dụng tốt động học phi tuyến tính để khôi phục ID cho những người bị đám đông che lấp một lúc rồi xuất hiện lại, ít hộp giả hơn so với các tracker dùng Re-ID.

## 4. Nếu có thêm thời gian

Nếu có thêm thời gian, mình sẽ thử tinh chỉnh mịn hơn ngưỡng `conf` (ví dụ 0.25 đến 0.4) cho các cảnh bị bóng kính lóa (video 4) và thử các mô hình Re-ID lớn hơn để xem có cải thiện nhận diện ngoại hình ở các video đông đúc hay không.
