Return-Path: <linux-kselftest+bounces-11399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCF9008FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3217528E39D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90019B5B4;
	Fri,  7 Jun 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBeekmKQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654319B5A5;
	Fri,  7 Jun 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774129; cv=none; b=qE3vgeZbIMFxHMEqU3M+EFM2sRwQX91FoVx3np0mr/ANs52GhBQPRwinhfM9qulv8qTaRAetVWolRAItOFQDNwF1lmVjdEoFDxtindhkZ9JSkszrjDOMJ08cPxP7b+EegjOIk0kktT2QQTJLjcDiV9w7mqiD5doc4qu90NTpGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774129; c=relaxed/simple;
	bh=xDiJ7qs8pxu9w+efkjy6gUreOG2CooQnViEhPZP++/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjEbVoEPgFe0epmWsn6F1aV1trxGwjpk64Psf+GtA84L3PGDhx2IIrdfo5mNPPoTemXQ0cgrKe4P8TxUOJiNVNXpqE02o79tMoGS1XULh30pJK3mIB/Sg6dMYVV6kDFqpL4EWbhgrUP9kn2YLwF1MNUE5t6lBdJyxIWrrBf90O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBeekmKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F9C2BBFC;
	Fri,  7 Jun 2024 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774128;
	bh=xDiJ7qs8pxu9w+efkjy6gUreOG2CooQnViEhPZP++/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lBeekmKQlCA6z6YffF24kLEv7qgrGrN1r1esijynEY3O4BFkBexlmohN9bHc5OXOy
	 rOGxbdtLpkqYunZ8QgnWJ0uhIdmWROjOXX6sFGDg1UaaaKsefIaNjcfB7hNPaSVDse
	 3pcW4BEE5gLY1Xqea+0ppM/HBU0Nu9Pc1uhXzsbYYqBqaUIg4Xx2dBbQZNsnFtH13S
	 CbpniU3B2iekEI/JFcupjKk1BKLAR2VGYch8Ts3JBnhUuGb56CCcgycShNdSbTHJ4D
	 ZamlT6dm8upttiaicQRjyOMWapJRoQQWaLoxFDHAHASqzxTxOcI/rTVBUN4+lGtfeo
	 99OYC11G9SRlw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:27 +0200
Subject: [PATCH HID v2 07/16] HID: bpf: convert in-tree fixes into
 struct_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-7-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=7084;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xDiJ7qs8pxu9w+efkjy6gUreOG2CooQnViEhPZP++/c=;
 b=/JaQbPzxEvpjk4ZGuIRhdZCdrkRrJMtjNEVdbcWPHykopaIzDWEI/EtkdlB4tFF7+uNgZ2a8V
 lfnyNn7+SkvAZLh9VYM9ohxb99QTzTz3oEcfftzr2oOSqOwQg1FC+AI
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Very mechanical:
- Change HID_BPF_DEVICE_EVENT and HID_BPF_RDESC_FIXUP #defines
- add a matching SEC(".struct_ops.link")
- in ArtistPro16Gen2 make the 2 functions static and have a new one
  calling them

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c  |  5 +++++
 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c    |  4 ++++
 drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c   |  5 +++++
 .../hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c  |  4 ++++
 .../hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c    |  4 ++++
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c          |  4 ++++
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c        |  5 +++++
 drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c | 22 ++++++++++++++++++----
 drivers/hid/bpf/progs/hid_bpf.h                    |  6 ++++--
 9 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c b/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
index 2c2c1637ade8..caec91391d32 100644
--- a/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
+++ b/drivers/hid/bpf/progs/FR-TEC__Raptor-Mach-2.bpf.c
@@ -168,6 +168,11 @@ int BPF_PROG(raptor_mach_2_fix_hat_switch, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(raptor_mach_2) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc_raptor_mach_2,
+	.hid_device_event = (void *)raptor_mach_2_fix_hat_switch,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
index 17fc55f6f02c..c2413fa80543 100644
--- a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
+++ b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
@@ -45,6 +45,10 @@ int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(hp_elite_presenter) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c b/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
index 24b8a5aa05f3..a4a4f324aedd 100644
--- a/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
+++ b/drivers/hid/bpf/progs/Huion__Kamvas-Pro-19.bpf.c
@@ -255,6 +255,11 @@ int BPF_PROG(kamvas_pro_19_fix_3rd_button, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(huion_Kamvas_pro_19) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc_huion_kamvas_pro_19,
+	.hid_device_event = (void *)kamvas_pro_19_fix_3rd_button,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
index bee37872ee8c..82f1950445dd 100644
--- a/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
+++ b/drivers/hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c
@@ -45,6 +45,10 @@ int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(iogear_kaliber_momentum) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c b/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
index f9ad33f4a373..70b16edfb59a 100644
--- a/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
+++ b/drivers/hid/bpf/progs/Microsoft__XBox-Elite-2.bpf.c
@@ -114,6 +114,10 @@ int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(xbox_elite_2) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
index 39d77c5e9172..2da680bc4e11 100644
--- a/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
+++ b/drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c
@@ -139,6 +139,10 @@ int BPF_PROG(artpen_pressure_interpolate, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(wacom_artpen) = {
+	.hid_device_event = (void *)artpen_pressure_interpolate,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
index c938808bd589..bc0b85c38445 100644
--- a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
@@ -209,6 +209,11 @@ int BPF_PROG(xppen_24_fix_eraser, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+HID_BPF_OPS(xppen_artist_24) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc_xppen_artist24,
+	.hid_device_event = (void *)xppen_24_fix_eraser,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c b/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
index 77ef8b95d52e..a669525691aa 100644
--- a/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__ArtistPro16Gen2.bpf.c
@@ -105,8 +105,7 @@ int BPF_PROG(hid_fix_rdesc_xppen_artistpro16gen2, struct hid_bpf_ctx *hctx)
 	return sizeof(fixed_rdesc);
 }
 
-SEC(HID_BPF_DEVICE_EVENT)
-int BPF_PROG(xppen_16_fix_eraser, struct hid_bpf_ctx *hctx)
+static int xppen_16_fix_eraser(struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
 
@@ -207,8 +206,7 @@ static void compensate_coordinates_by_tilt(__u8 *data, const __u8 idx,
 	data[idx+1] = coords >> 8;
 }
 
-SEC(HID_BPF_DEVICE_EVENT)
-int BPF_PROG(xppen_16_fix_angle_offset, struct hid_bpf_ctx *hctx)
+static int xppen_16_fix_angle_offset(struct hid_bpf_ctx *hctx)
 {
 	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 10 /* size */);
 
@@ -254,6 +252,22 @@ int BPF_PROG(xppen_16_fix_angle_offset, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+SEC(HID_BPF_DEVICE_EVENT)
+int BPF_PROG(xppen_artist_pro_16_device_event, struct hid_bpf_ctx *hctx)
+{
+	int ret = xppen_16_fix_angle_offset(hctx);
+
+	if (ret)
+		return ret;
+
+	return xppen_16_fix_eraser(hctx);
+}
+
+HID_BPF_OPS(xppen_artist_pro_16) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc_xppen_artistpro16gen2,
+	.hid_device_event = (void *)xppen_artist_pro_16_device_event,
+};
+
 SEC("syscall")
 int probe(struct hid_bpf_probe_args *ctx)
 {
diff --git a/drivers/hid/bpf/progs/hid_bpf.h b/drivers/hid/bpf/progs/hid_bpf.h
index 1970faf84310..8c1cd9e25bc3 100644
--- a/drivers/hid/bpf/progs/hid_bpf.h
+++ b/drivers/hid/bpf/progs/hid_bpf.h
@@ -5,8 +5,10 @@
 #ifndef ____HID_BPF__H
 #define ____HID_BPF__H
 
-#define HID_BPF_DEVICE_EVENT "fmod_ret/hid_bpf_device_event"
-#define HID_BPF_RDESC_FIXUP  "fmod_ret/hid_bpf_rdesc_fixup"
+#define HID_BPF_DEVICE_EVENT "struct_ops/hid_device_event"
+#define HID_BPF_RDESC_FIXUP  "struct_ops/hid_rdesc_fixup"
+#define HID_BPF_OPS(name) SEC(".struct_ops.link") \
+	struct hid_bpf_ops name
 
 struct hid_bpf_probe_args {
 	unsigned int hid;

-- 
2.44.0


