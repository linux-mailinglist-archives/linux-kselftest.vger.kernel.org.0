Return-Path: <linux-kselftest+bounces-17597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF7973A63
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81BA2825D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FA1A2C2D;
	Tue, 10 Sep 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Trrra9ZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFC1A2C25;
	Tue, 10 Sep 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979449; cv=none; b=J7HDGu1V23WhP2sAY6N32nMK1Z7jepoXYRitP6+clGBDM386RP69J438GHknl/P5zhFP86yd6HqHymyl+scm1BrFhcOVRGIEKWDcXFPAPWSpa31sddFowrrQxHEIL7jBIoXmp4q2gJWKWjX1bK2zvXM4j56ccBDLQCuGKvWx9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979449; c=relaxed/simple;
	bh=RC0OcZWXYp36gijPOdDycz5WVWZVh9ovwtf2TjypL1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZ4auBadlcqAkvw7MsJSnExDYzTm6XNFlTD2xdFJGZ7SSGJx1SSNBFyqAxM6aUlLYy28yQyie5VNHsYOowZfuggiCUGmAeK3CHxhKeVnqyFwVpvQuEBpV3w3A4no0Y8IjMmle2zyB+DQmpecpVkRlpdQt/geXx0vOK0uoE7k9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Trrra9ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B05C4CECD;
	Tue, 10 Sep 2024 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979449;
	bh=RC0OcZWXYp36gijPOdDycz5WVWZVh9ovwtf2TjypL1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Trrra9ZH6To3Y9ufxjR1LwEemwbKI6KZqedfrsWBthdBig+b/poPOc4OavedR+0C9
	 n1xXHKnTy8tRCYi9RF7aSXy+I+/VrczFojJLArgf9KkAvSlc+Ig2ewgpOF1H2ej3nN
	 sj50c2u4o34qi8kz2cMp5ommctEM7SvGN0eb5jAoCXmv+8Q8Ul470JrhM3+c/5LAlF
	 zZTkEqWOTAOe6sC2GNccg0AhOFrj06MGcjnODMdNcKVJU28d7B+3MY9ESHeQC4Dpc1
	 JysRVZLAae4t79awU4cqmtaJeINfNjfB83OPxqoOM2fz/plbEwBUV5DoLDghVHSzRt
	 h//7usybeD25Q==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:45 +0900
Subject: [PATCH HID v2 09/11] selftests/hid: add test for assigning a given
 device to hid-generic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-9-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=4691;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=RC0OcZWXYp36gijPOdDycz5WVWZVh9ovwtf2TjypL1c=;
 b=K1T3X/S3FcETPm5Afe9U7NGYx0EE4aQ22NbRrEZ7Ug/ASedd5wDVzOy44sw68LpR1PRdGols/
 usgMKApzaUyDH+xCDisOMdXZobf/jZu5BtdE3a/4Mm/jSJwy/r9b6X4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We use a well known VID/PID on a driver that doesn't need to talk to
the device, ensures we created the device against the target driver,
then load our program and ensure we have unbound to this driver and use
hid-generic instead.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- amended for the new API
---
 tools/testing/selftests/hid/hid_bpf.c              | 80 +++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            | 12 ++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  6 +-
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 7eb15da62bdc..edc061b38528 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -54,11 +54,41 @@ FIXTURE_TEARDOWN(hid_bpf) {
 	hid_bpf_teardown(_metadata, self, variant); \
 } while (0)
 
+struct specific_device {
+	const char test_name[64];
+	__u16 bus;
+	__u32 vid;
+	__u32 pid;
+};
+
 FIXTURE_SETUP(hid_bpf)
 {
+	const struct specific_device *match = NULL;
 	int err;
 
-	err = setup_uhid(_metadata, &self->hid, BUS_USB, 0x0001, 0x0a36, rdesc, sizeof(rdesc));
+	const struct specific_device devices[] = {
+	{
+		.test_name = "test_hid_driver_probe",
+		.bus = BUS_BLUETOOTH,
+		.vid = 0x05ac,  /* USB_VENDOR_ID_APPLE */
+		.pid = 0x022c,  /* USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI */
+	}, {
+		.test_name = "*",
+		.bus = BUS_USB,
+		.vid = 0x0001,
+		.pid = 0x0a36,
+	}};
+
+	for (int i = 0; i < ARRAY_SIZE(devices); i++) {
+		match = &devices[i];
+		if (!strncmp(_metadata->name, devices[i].test_name, sizeof(devices[i].test_name)))
+			break;
+	}
+
+	ASSERT_OK_PTR(match);
+
+	err = setup_uhid(_metadata, &self->hid, match->bus, match->vid, match->pid,
+			 rdesc, sizeof(rdesc));
 	ASSERT_OK(err);
 }
 
@@ -855,6 +885,54 @@ TEST_F(hid_bpf, test_hid_attach_flags)
 	ASSERT_EQ(buf[3], 3);
 }
 
+static bool is_using_driver(struct __test_metadata *_metadata, struct uhid_device *hid,
+			    const char *driver)
+{
+	char driver_line[512];
+	char uevent[1024];
+	char temp[512];
+	int fd, nread;
+	bool found = false;
+
+	sprintf(uevent, "/sys/bus/hid/devices/%04X:%04X:%04X.%04X/uevent",
+		hid->bus, hid->vid, hid->pid, hid->hid_id);
+
+	fd = open(uevent, O_RDONLY | O_NONBLOCK);
+	if (fd < 0) {
+		TH_LOG("couldn't open '%s': %d, %d", uevent, fd, errno);
+		return false;
+	}
+
+	sprintf(driver_line, "DRIVER=%s", driver);
+
+	nread = read(fd, temp, ARRAY_SIZE(temp));
+	if (nread > 0 && (strstr(temp, driver_line)) != NULL)
+		found = true;
+
+	close(fd);
+
+	return found;
+}
+
+/*
+ * Attach hid_driver_probe to the given uhid device,
+ * check that the device is now using hid-generic.
+ */
+TEST_F(hid_bpf, test_hid_driver_probe)
+{
+	const struct test_program progs[] = {
+		{
+			.name = "hid_test_driver_probe",
+		},
+	};
+
+	ASSERT_TRUE(is_using_driver(_metadata, &self->hid, "apple"));
+
+	LOAD_PROGRAMS(progs);
+
+	ASSERT_TRUE(is_using_driver(_metadata, &self->hid, "hid-generic"));
+}
+
 /*
  * Attach hid_rdesc_fixup to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 5ecc845ef792..9b22e9a0e658 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -598,3 +598,15 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_infinite_loop_input_report = {
 	.hid_device_event = (void *)hid_test_infinite_loop_input_report,
 };
+
+SEC("?struct_ops.s/hid_rdesc_fixup")
+int BPF_PROG(hid_test_driver_probe, struct hid_bpf_ctx *hid_ctx)
+{
+	hid_ctx->hid->quirks |= HID_QUIRK_IGNORE_SPECIAL_DRIVER;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_driver_probe = {
+	.hid_rdesc_fixup = (void *)hid_test_driver_probe,
+};
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index e5db897586bb..1a645684a117 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -84,10 +84,14 @@ struct hid_bpf_ops {
 	struct hid_device *hdev;
 };
 
+#define BIT(n) (1U << n)
+
 #ifndef BPF_F_BEFORE
-#define BPF_F_BEFORE (1U << 3)
+#define BPF_F_BEFORE BIT(3)
 #endif
 
+#define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,

-- 
2.46.0


