Return-Path: <linux-kselftest+bounces-11476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166789010BF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEDC282D91
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8C17B41C;
	Sat,  8 Jun 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTUodsGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7A176FB8;
	Sat,  8 Jun 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837296; cv=none; b=aJunGQ2+hpa6jKPxH8DIaxhO9f1zt5JOTZyKFzCVnb0FFltlPoG1CJvSH/dx3PbhFNrfMde5AP8N8GeFHAYyD6AVJTSBEXamcJpkAWkfKjhiJYi5ZINDP56ROIzGTEjYyLCgmyeKrSPozsL0OvdUf6l7HHzfk4tY92q7hOKM+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837296; c=relaxed/simple;
	bh=yG1pGkZtC9Anfz5EEv/yx6g2z75uDkKpVPn27LPVJiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyFdGXmnH48G+5rStIe0MMPny0ZxdNDfeMmT1/4MoOkRqi6do3kEjBcQSnImNeJC83M13rK4b1HSs7xSbgtBeAxuuQxLfcBDP/c6DEoEcC8hAHt04kSAwr/yDsCKCyFZTHCSa35iFevhjfgcSmE+GLWR8IE75V5O6c0MDeAKu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTUodsGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2949C2BD11;
	Sat,  8 Jun 2024 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837295;
	bh=yG1pGkZtC9Anfz5EEv/yx6g2z75uDkKpVPn27LPVJiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oTUodsGoZi8+kJ0TMURTzyRYjsRat4+kM7rE5qTYIwE8nVZHpPXWVGXphnpmS7EVm
	 31ZvFTTn3kTkY1m8T86q3g/1UgRTmcQAlSd3/7nnULBIhVO9NR8SbmUggwdW9lzYPV
	 mPffj5k90lLTzrKGhgbdznEvtZCgNfjbsPZIvB4OFrEColaVztXh91eAVaoZypbDNN
	 p/rO8Gq52iph38riISvvz7bHsWySFH7nb1qsxsEQbIh+la3fbgbe3DSzeFuyBpYWEW
	 FKODyO3mUKGULVjreW6zfNNO0iBtiDi+HX5iayN8eixd8rXogRvqwVrkrTlhbNExu2
	 n+VuyCWkGq3MA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:18 +0200
Subject: [PATCH HID v3 06/16] HID: bpf: add defines for HID-BPF SEC in
 in-tree bpf fixes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-6-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=8093;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=yG1pGkZtC9Anfz5EEv/yx6g2z75uDkKpVPn27LPVJiI=;
 b=y2ruVxmIfdZaADC4Dt0SFM02Fo3Ln8e4T1SbHzyVfn34BbP2CkJnPBFZD4iP/bnpQuNGVm41/
 UdIoRi3f5MeAQa4IUZWj7BVcSyCPdkxnHTrtXqkbAhiC9L2HBy5YyTF
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We are going to switch over struct_ops, so instead of having to manually
replace all fields one by one, let's have a common place to change it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

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


