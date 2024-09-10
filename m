Return-Path: <linux-kselftest+bounces-17599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3635973A6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E72A1F260C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D21A3A8D;
	Tue, 10 Sep 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1a24Ert"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE371A38F9;
	Tue, 10 Sep 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979454; cv=none; b=qb3lleWqEeSihxYgvx3ocQlOKGEVuwWIO58yDdurvEF1juVeeNoGGGFlNgUIB63DtzKaTduhj+6JweAyK+pX8KIAbiKYT/3N62tAWI5TaFF+Mj5ccp4EH7Iz7fH6NZ8uMV0PW1tsh/VClbduSBk9jEcur+LqOUUb0+yVPdvVawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979454; c=relaxed/simple;
	bh=LmBG5BHGYdWXIOucMdHZKe5DqBhFcqK07cXblfY/l0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGPjdzdkS3RXHs3L3wc36SQsbeWpb5oY/ptTnwa6NO5ABskypcqMF8oarKUHaW8OfVjDEiQCp8ehWp+ibNY8+XHCHjLPdzV7wJ8VTpwmf34hO8DTvvPtfOPqO9FyixTjFaiwNdLHekxSaqmkw3HkgZwy8RUHs4d1x7MfNU8LqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1a24Ert; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A45C4CECE;
	Tue, 10 Sep 2024 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979453;
	bh=LmBG5BHGYdWXIOucMdHZKe5DqBhFcqK07cXblfY/l0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d1a24ErtDm70VPJ1/SWrFe5tAMR7WPpUaynaU3xdzRJTFV6sMH/ZMS2vVQVQ5ybcm
	 XKSbbcnmgj7TU6/AKRlHMD2reEwlnm35yz5Hoo78ogb05GU+YWQZYO4O6pw8uIfkqj
	 3CpU2eVxPebHErmS4Wr79PocLsi3ugvrBl7mKq0u8U4wzQpc3cclViAhEcypGaydvp
	 MbI7w+7erasZTqeKKwRJ0Bq1DpUF9QhqtWKa9Bgu5bDki1q6jIsIXa/NHtN+ervRu/
	 B21zyh92Tlv+1p4aMJiRmo1eNfDuTQkH882m7B8bfE1tcM8jYdc/nCE5q81cwYojM5
	 klx6jykHzcasg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:47 +0900
Subject: [PATCH HID v2 11/11] selftests/hid: add test to disable hid-input
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-11-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=5547;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=LmBG5BHGYdWXIOucMdHZKe5DqBhFcqK07cXblfY/l0Y=;
 b=0EYf1JyMDXPcGWcDKNKveACXh9M/f/oJ1DKRuDRxRsjir8szlhhgA+1DLiD8hRQ+kSHCgpOMe
 56E2fUVaOkdAO24gPrhGHVcCacPQRl0wHVtYn6ZvXktAWdBnt9hJer/
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Add a test for the newly enabled feature to control the connect_mask
of hid-generic.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- amended for the new API
---
 tools/testing/selftests/hid/hid_bpf.c              | 60 +++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            |  1 +
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  1 +
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index edc061b38528..41cacc30ef8b 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -4,6 +4,38 @@
 #include "hid_common.h"
 #include <bpf/bpf.h>
 
+static const __u8 mouse_rdesc[] = {
+	0x05, 0x01,  /* .Usage Page (Generic Desktop)        0  */
+	0x09, 0x02,  /* .Usage (Mouse)                       2  */
+	0xa1, 0x01,  /* .Collection (Application)            4  */
+	0x09, 0x02,  /* ..Usage (Mouse)                      6  */
+	0xa1, 0x02,  /* ..Collection (Logical)               8  */
+	0x09, 0x01,  /* ...Usage (Pointer)                   10 */
+	0xa1, 0x00,  /* ...Collection (Physical)             12 */
+	0x05, 0x09,  /* ....Usage Page (Button)              14 */
+	0x19, 0x01,  /* ....Usage Minimum (1)                16 */
+	0x29, 0x03,  /* ....Usage Maximum (3)                18 */
+	0x15, 0x00,  /* ....Logical Minimum (0)              20 */
+	0x25, 0x01,  /* ....Logical Maximum (1)              22 */
+	0x75, 0x01,  /* ....Report Size (1)                  24 */
+	0x95, 0x03,  /* ....Report Count (3)                 26 */
+	0x81, 0x02,  /* ....Input (Data,Var,Abs)             28 */
+	0x75, 0x05,  /* ....Report Size (5)                  30 */
+	0x95, 0x01,  /* ....Report Count (1)                 32 */
+	0x81, 0x03,  /* ....Input (Cnst,Var,Abs)             34 */
+	0x05, 0x01,  /* ....Usage Page (Generic Desktop)     36 */
+	0x09, 0x30,  /* ....Usage (X)                        38 */
+	0x09, 0x31,  /* ....Usage (Y)                        40 */
+	0x15, 0x81,  /* ....Logical Minimum (-127)           42 */
+	0x25, 0x7f,  /* ....Logical Maximum (127)            44 */
+	0x75, 0x08,  /* ....Report Size (8)                  46 */
+	0x95, 0x02,  /* ....Report Count (2)                 48 */
+	0x81, 0x06,  /* ....Input (Data,Var,Rel)             50 */
+	0xc0,        /* ...End Collection                    52 */
+	0xc0,        /* ..End Collection                     53 */
+	0xc0,        /* .End Collection                      54 */
+};
+
 struct hid_hw_request_syscall_args {
 	__u8 data[10];
 	unsigned int hid;
@@ -59,6 +91,8 @@ struct specific_device {
 	__u16 bus;
 	__u32 vid;
 	__u32 pid;
+	const __u8 *rdesc;
+	const size_t rdesc_size;
 };
 
 FIXTURE_SETUP(hid_bpf)
@@ -72,11 +106,15 @@ FIXTURE_SETUP(hid_bpf)
 		.bus = BUS_BLUETOOTH,
 		.vid = 0x05ac,  /* USB_VENDOR_ID_APPLE */
 		.pid = 0x022c,  /* USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI */
+		.rdesc = mouse_rdesc,
+		.rdesc_size = sizeof(mouse_rdesc),
 	}, {
 		.test_name = "*",
 		.bus = BUS_USB,
 		.vid = 0x0001,
 		.pid = 0x0a36,
+		.rdesc = rdesc,
+		.rdesc_size = sizeof(rdesc),
 	}};
 
 	for (int i = 0; i < ARRAY_SIZE(devices); i++) {
@@ -88,7 +126,7 @@ FIXTURE_SETUP(hid_bpf)
 	ASSERT_OK_PTR(match);
 
 	err = setup_uhid(_metadata, &self->hid, match->bus, match->vid, match->pid,
-			 rdesc, sizeof(rdesc));
+			 match->rdesc, match->rdesc_size);
 	ASSERT_OK(err);
 }
 
@@ -914,6 +952,24 @@ static bool is_using_driver(struct __test_metadata *_metadata, struct uhid_devic
 	return found;
 }
 
+static bool has_hid_input(struct uhid_device *hid)
+{
+	char input[1024];
+	DIR *d;
+
+	sprintf(input, "/sys/bus/hid/devices/%04X:%04X:%04X.%04X/input",
+		hid->bus, hid->vid, hid->pid, hid->hid_id);
+
+	d = opendir(input);
+	if (d) {
+		closedir(d);
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Attach hid_driver_probe to the given uhid device,
  * check that the device is now using hid-generic.
@@ -927,10 +983,12 @@ TEST_F(hid_bpf, test_hid_driver_probe)
 	};
 
 	ASSERT_TRUE(is_using_driver(_metadata, &self->hid, "apple"));
+	ASSERT_TRUE(has_hid_input(&self->hid)) TH_LOG("input node not found");
 
 	LOAD_PROGRAMS(progs);
 
 	ASSERT_TRUE(is_using_driver(_metadata, &self->hid, "hid-generic"));
+	ASSERT_FALSE(has_hid_input(&self->hid)) TH_LOG("input node unexpectly found");
 }
 
 /*
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 9b22e9a0e658..7e24bec8ef43 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -603,6 +603,7 @@ SEC("?struct_ops.s/hid_rdesc_fixup")
 int BPF_PROG(hid_test_driver_probe, struct hid_bpf_ctx *hid_ctx)
 {
 	hid_ctx->hid->quirks |= HID_QUIRK_IGNORE_SPECIAL_DRIVER;
+	hid_ctx->hid->quirks |= HID_QUIRK_IGNORE_HIDINPUT;
 	return 0;
 }
 
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 1a645684a117..9c3cfd61d992 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -91,6 +91,7 @@ struct hid_bpf_ops {
 #endif
 
 #define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
+#define HID_QUIRK_IGNORE_HIDINPUT		BIT(23)
 
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,

-- 
2.46.0


