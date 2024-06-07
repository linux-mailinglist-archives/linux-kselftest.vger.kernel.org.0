Return-Path: <linux-kselftest+bounces-11398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A19008F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F93B2359A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF819B3DE;
	Fri,  7 Jun 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2mlF8nH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAC19B3D3;
	Fri,  7 Jun 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774126; cv=none; b=RCLLZP/NgFysmBL9dnJDOyTuQ7Jr9fxIgCP4mwRDzEO1hgioWcUDx6qrF2rqNnZtL18XKqGk9YkJ5tMKuRWfEW1ZFaX9Af/VWIynOLtRXOXThh6zeeQBXt8D6MSrlBqUx8BBqca6I0oUEHaqTt8d4667WgijBoUsqN4D3EpVpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774126; c=relaxed/simple;
	bh=zd07BUkHYN6/AvY0aQb8XK+PXOssdNdK8iLI/fHXBMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usXOW/0lHCbVkj1ufmuudG7r31KUiU5REgXOnbVPgkskrlV8A/9J4cdr4BiuzeDSZLBb9gXE+A2U4sI+cUanLpO4MW1mC+/XLRWCVmw+xnxaG7E0x6fsnNH+3HImHMRY/qc3EtjmahEcZvPITSZqWNoDAfNd+2+5KkTF+quzlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2mlF8nH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7A6C4AF07;
	Fri,  7 Jun 2024 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774126;
	bh=zd07BUkHYN6/AvY0aQb8XK+PXOssdNdK8iLI/fHXBMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G2mlF8nHz+uO0nnZiKgIugRn6K5cJdTEG2JyehwSX6KKq39qRq45/sEaXTZBEmavl
	 UydKdtv/h+li5BBY+LbYbqC69QyNHsoxX2NCZnVaPHgPap6sCYbOVKkLtZP48Sl2yT
	 rPItAGXVZSp9SUiUHA/IlnFzo9zftbD/MODllCXnxMTwXhE+VhsCi0bYgy2FOwBNzf
	 EMnAr80Xo+XYjJS+pCXVZZpSeu8VGQJ8LVMytb6SlfEkzy31RnC6aKzeCUGVY4xD6F
	 oFG7k204eDVvHVfJvaODtby8H/vQXKYLLVhC7fICvpwCGdm5J3/zntm+cVgJTgvaaZ
	 tfq7g3rKIBkRw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:26 +0200
Subject: [PATCH HID v2 06/16] HID: bpf: add defines for HID-BPF SEC in
 in-tree bpf fixes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-6-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=8073;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=zd07BUkHYN6/AvY0aQb8XK+PXOssdNdK8iLI/fHXBMw=;
 b=fThSJlGi/OR5fcR7xrdUPJKIRuCSi6t/P6yBcG71OSIpBnYIs7M0mTTIS/7H2GusByCEIqj+Q
 jw8dUkRflHUC+aLZQ7knuGyo4qDtXyqdEY0XSB5oGZigc9KfxtBlG4P
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We are going to switch over struct_ops, so instead of having to manually
replace all fields one by one, let's have a common place to change it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c     | 4 ++--
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c       | 2 +-
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c      | 4 ++--
 drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c | 2 +-
 drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c   | 2 +-
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c             | 2 +-
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c           | 4 ++--
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c    | 6 +++---
 drivers/hid/bpf/progs/hid_bpf.h                       | 3 +++
 9 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c b/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
index dc26a7677d36..2c2c1637ade8 100644
--- a/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
+++ b/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
@@ -133,7 +133,7 @@ HID_BPF_CONFIG(
  *   integer. We thus divide it by 30 to match what other joysticks are
  *   doing
  */
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc_raptor_mach_2, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, HID_MAX_DESCRIPTOR_SIZE /* size */);
@@ -152,7 +152,7 @@ int BPF_PROG(hid_fix_rdesc_raptor_mach_2, struct hid_bpf_ctx *hctx)
  * divide it by 30.
  * Byte 34 is always null, so it is ignored.
  */
-SEC("fmod_ret/hid_bpf_device_event")
+SEC(HID_BPF_DEVICE_EVENT)
 int BPF_PROG(raptor_mach_2_fix_hat_switch, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 64 /* size */);
diff --git a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
index 3d14bbb6f276..17fc55f6f02c 100644
--- a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
+++ b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
@@ -30,7 +30,7 @@ HID_BPF_CONFIG(
  * pointer.
  */
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
diff --git a/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c b/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
index ff759f2276f9..24b8a5aa05f3 100644
--- a/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
+++ b/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
@@ -191,7 +191,7 @@ static const __u8 fixed_rdesc[] = {
 	0xc0,                          // End Collection                      327
 };
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc_huion_kamvas_pro_19, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, HID_MAX_DESCRIPTOR_SIZE /* size */);
@@ -215,7 +215,7 @@ int BPF_PROG(hid_fix_rdesc_huion_kamvas_pro_19, struct hid_bpf_ctx *hctx)
  * - if there was this out-of-proximity event, we are entering
  *   eraser mode, and we will until the next out-of-proximity.
  */
-SEC("fmod_ret/hid_bpf_device_event")
+SEC(HID_BPF_DEVICE_EVENT)
 int BPF_PROG(kamvas_pro_19_fix_3rd_button, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
diff --git a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
index 225cbefdbf0e..bee37872ee8c 100644
--- a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
+++ b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
@@ -21,7 +21,7 @@ HID_BPF_CONFIG(
  * We just fix the report descriptor to enable those missing 7 buttons.
  */
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 {
 	const u8 offsets[] = {84, 112, 140};
diff --git a/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c b/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
index c04abecab8ee..f9ad33f4a373 100644
--- a/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
+++ b/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
@@ -93,7 +93,7 @@ _Static_assert(sizeof(rdesc_assign_selection) == sizeof(fixed_rdesc_assign_selec
 _Static_assert(sizeof(rdesc_assign_selection) + OFFSET_ASSIGN_SELECTION < ORIGINAL_RDESC_SIZE,
 	       "Rdesc at given offset is too big");
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
diff --git a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
index dc05aa48faa7..39d77c5e9172 100644
--- a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
+++ b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
@@ -101,7 +101,7 @@ static inline __u8 *get_u8(__u8 *data, unsigned int offset)
 	return (__u8 *)get_bits(data, offset);
 }
 
-SEC("fmod_ret/hid_bpf_device_event")
+SEC(HID_BPF_DEVICE_EVENT)
 int BPF_PROG(artpen_pressure_interpolate, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, PEN_REPORT_LEN /* size */);
diff --git a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
index e1be6a12bb75..c938808bd589 100644
--- a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
@@ -91,7 +91,7 @@ static const __u8 fixed_rdesc[] = {
 
 #define U16(index) (data[index] | (data[index + 1] << 8))
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc_xppen_artist24, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
@@ -152,7 +152,7 @@ static __u8 prev_state = 0;
  *     E: TipSwitch                     InRange
  *
  */
-SEC("fmod_ret/hid_bpf_device_event")
+SEC(HID_BPF_DEVICE_EVENT)
 int BPF_PROG(xppen_24_fix_eraser, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
diff --git a/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c b/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
index 65ef10036126..77ef8b95d52e 100644
--- a/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
@@ -82,7 +82,7 @@ static const __u8 fixed_rdesc[] = {
 	0xc0,                          // End Collection                      112
 };
 
-SEC("fmod_ret/hid_bpf_rdesc_fixup")
+SEC(HID_BPF_RDESC_FIXUP)
 int BPF_PROG(hid_fix_rdesc_xppen_artistpro16gen2, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
@@ -105,7 +105,7 @@ int BPF_PROG(hid_fix_rdesc_xppen_artistpro16gen2, struct hid_bpf_ctx *hctx)
 	return sizeof(fixed_rdesc);
 }
 
-SEC("fmod_ret/hid_bpf_device_event")
+SEC(HID_BPF_DEVICE_EVENT)
 int BPF_PROG(xppen_16_fix_eraser, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
@@ -207,7 +207,7 @@ static void compensate_coordinates_by_tilt(__u8 *data, const __u8 idx,
 	data[idx+1] = coords >> 8;
 }
 
-SEC("fmod_ret/hid_bpf_device_event")
+SEC(HID_BPF_DEVICE_EVENT)
 int BPF_PROG(xppen_16_fix_angle_offset, struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
diff --git a/drivers/hid/bpf/progs/hid_bpf.h b/drivers/hid/bpf/progs/hid_bpf.h
index 7ee371cac2e1..1970faf84310 100644
--- a/drivers/hid/bpf/progs/hid_bpf.h
+++ b/drivers/hid/bpf/progs/hid_bpf.h
@@ -5,6 +5,9 @@
 #ifndef ____HID_BPF__H
 #define ____HID_BPF__H
 
+#define HID_BPF_DEVICE_EVENT "fmod_ret/hid_bpf_device_event"
+#define HID_BPF_RDESC_FIXUP  "fmod_ret/hid_bpf_rdesc_fixup"
+
 struct hid_bpf_probe_args {
 	unsigned int hid;
 	unsigned int rdesc_size;

-- 
2.44.0


