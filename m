Return-Path: <linux-kselftest+bounces-10780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C188D1C73
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36676284F82
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39916FF48;
	Tue, 28 May 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwkX8cqi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811F16FF3D;
	Tue, 28 May 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902130; cv=none; b=Ygd4BTBln7fsYTsB8P0EjYVLpzyVeH90Wb4ucb0JN4Zt0w56TR/VJTqONQAYzn0OEjWtyBZf/T8JFfL3RfKVmQjWZzTNU6QfyD6fihJgmDFzYT2ijksHpU/HtBPDzRUL5SVpAQzb1ME1YV8WvOA0eHrjpAnGBVvMH4629/sTCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902130; c=relaxed/simple;
	bh=ASYT7C4PzdLCyYUiHYyqygWpOHzADQG5pEoKYjPNpLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdeH+PdTxRnAJTePcNy5+X8zv2zFLOvsPzlYdEDb68tlY/AnndYNYaLg2oCxB+CZX6hWUgaMhCfyaEtzvYAD/sOhJJRSy7sE4GYcR7MQhyfuvYbo4w/ts9W8aQYUKHolEsY2b9lff04hMRTs3Qw2P+BUf/Ho9lDtsqKJCyXFcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwkX8cqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FE1C4AF0E;
	Tue, 28 May 2024 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902130;
	bh=ASYT7C4PzdLCyYUiHYyqygWpOHzADQG5pEoKYjPNpLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bwkX8cqijGiQ/QYWGGcZDZ/scvEanb4LC1M1wvbOzItZ/DBxSNMkAL8VmjUBMr/Qb
	 jk61eakf0gpJNvEXaVVicwfbhyNfuIa1yUATV2UbaWFjIDYVvHsvwHod0uKBl8HhU7
	 Ltjv/nqJiQsDdX9EVNWk1mPDKRNhuYEaV9gt/o1nIrc+XOYsz1ejr6ZgN7ZKpJB5/b
	 rzhX69BW+HxsHwlGLAXV6jdsrUqzh15l1kqgjKJ9rjcODb4+xiqe3y2tJ3so12nQZv
	 grLDLE8AbTkmhIXc11Y0EZkUMBvqWlGxTB0IK2ua0vlO1PGGRSZOc/1wImYjwyoX9g
	 ovTMUBIU07vDA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:44 +0200
Subject: [PATCH HID 06/13] HID: bpf: add defines for HID-BPF SEC in in-tree
 bpf fixes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-6-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=8046;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ASYT7C4PzdLCyYUiHYyqygWpOHzADQG5pEoKYjPNpLw=;
 b=n25Uu3EJwKcRP7Hcut64lnYNaZZh3KCE0KPUUCQS6VwdqQ+aOA9q/cx7D+6Iromo5BwuCEJVz
 F6QGNfzhS05AQx7i32p/JuXvBpiOaaXzWU16RgTYMJWvQcd0lXk1PaH
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We are going to switch over struct_ops, so instead of having to manually
replace all fields one by one, let's have a common place to change it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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


