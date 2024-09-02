Return-Path: <linux-kselftest+bounces-16997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3222968BE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040D31C21B49
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54721C175;
	Mon,  2 Sep 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9J9lYBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79D21C16D;
	Mon,  2 Sep 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293719; cv=none; b=iSX8gJ4ZoIzA1Od9XCSZyQMIqez4vFj4cM0ZYm+thnkCtqb5FvNZNjK78rZHirUpcoujBbI1r2GQ7yZQPcac6Z6pNvGV8Uzn1M4iQCTUX+UzSyuX7ke0cImfAIn+CbSa8PYf6sZu6meWxV1uTG7H89SuT5wcTybgEsAMt/19f1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293719; c=relaxed/simple;
	bh=xtOdecYiKB5InvoL/YSqFAGZREGEyiVcgfttpziwedM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HoSaIqk94GMV59VwSEGSnlu0tZNFkjx72hREJVeUw7cH3mlKcc+8GmH0jeUIIJ6282OTukElz79sRfKytz4NJqCzBxMWZJn8HQ+gHORly5wfuFStPaqujza1xHUd802xQZyIRbqtigkf5cXMhCWIQnDNbD0bEZXuoRBzow0LaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9J9lYBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9320FC4CECB;
	Mon,  2 Sep 2024 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293718;
	bh=xtOdecYiKB5InvoL/YSqFAGZREGEyiVcgfttpziwedM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X9J9lYBA64rSQShxUiGuKSRL22BP/KcyYHeJ5LlD2d+U3JbXJX4HphKInc20le8Ct
	 D5ZMVkcnyKVO+XiEz092j1U/7VIxyKQIduc8SwwcNJWueU3YY4lwvllhMbwd3eAKPf
	 98Ap58Z5HS05CBvnARK1iGnssmA7ixbC/6zKKDxGt8K1rt64G5YjFegiY1zPNKxmmd
	 81mHjaRVGHegi9VIOMXOT4VqFQ4z1BvaTpwdyxN5SUdtGlpNKR+b7563Z5tYDnaMOE
	 l5/W8755n6N1X0sskiFjSlO9ek5mN551rKf+YHlrKRiBMTC2BbUix6PfxksYeigTDb
	 8luG5fGEGdxHQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 03 Sep 2024 01:14:37 +0900
Subject: [PATCH HID 7/7] selftests/hid: add test to disable hid-input
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-hid-bpf-hid-generic-v1-7-9511a565b2da@kernel.org>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
In-Reply-To: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725293696; l=5770;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xtOdecYiKB5InvoL/YSqFAGZREGEyiVcgfttpziwedM=;
 b=GE/tgxdBkatX9tmF7AXHOU/jlAbMce5qGP3SxP2mtW5A9+4VoYudbDiOQAuLD+ESHP/ByppSx
 eeIohiS/C/ADzvR+NR2IhXu7ICiStGPD39RAaNnmcWow5MdY5GSG6eQ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Add a test for the newly enabled feature to control the connect_mask
of hid-generic.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c              | 60 +++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            |  6 ++-
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  2 +
 3 files changed, 65 insertions(+), 3 deletions(-)

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
index 883d09498351..c81d5eb18211 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -606,10 +606,12 @@ void BPF_PROG(hid_test_driver_probe, struct hid_device *hdev, struct hid_bpf_dri
 	static const char hid_generic[] = "hid-generic";
 
 	bpf_printk("test_driver_probe, %s", hdrv->name);
-	if (!__builtin_memcmp(hdrv->name, hid_generic, sizeof(hid_generic)))
+	if (!__builtin_memcmp(hdrv->name, hid_generic, sizeof(hid_generic))) {
 		hdrv->force_driver = 1;
-	else
+		id->driver_data &= ~HID_CONNECT_INPUT;
+	} else {
 		hdrv->ignore_driver = 1;
+	}
 }
 
 SEC("?struct_ops.s/hid_rdesc_fixup")
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 6b0f870d0727..9447233d7a3d 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -90,6 +90,8 @@ struct hid_bpf_ops {
 #define BPF_F_BEFORE (1U << 3)
 #endif
 
+#define HID_CONNECT_INPUT (1U << 0)
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,

-- 
2.46.0


