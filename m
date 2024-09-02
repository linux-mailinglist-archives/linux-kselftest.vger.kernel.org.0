Return-Path: <linux-kselftest+bounces-16995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B3968BD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C667C1C2180E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4B2101B1;
	Mon,  2 Sep 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiogrxRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EC1AB6C0;
	Mon,  2 Sep 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293713; cv=none; b=giJ7xijiHZ5pycQr5AJKCm5vjoSOS6VYYs9GluhVnx4mTSWXf6HnRY3YGVXIw7HkZXL2qpe7sXmBsBdLy2Kx8jXZoyrOYzvGl/QwLKonsV7L2cJLAllABRsq+tedghYXQ8WARzTQ58lwN5EV5qnmeptBZeSefSDlLH0qiVFcMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293713; c=relaxed/simple;
	bh=bCMnwRpHi66cFH/lCsEid/oKr2HghP0ARsPCue09C2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bynj1YEbs6EHDOxTLcfBVooRMQ4ULxj1OI3dsScaNV/xnzt2TNSJa866ngIeS1kQwvZEfJoy3ZtsgVtdRsX1BoZJF4UqxSKTvUIGZ6WOOuJ9LuPiCmSlBc8DbTm+VJ7DER6qk6fEDiLTEbMlZFwVtYaFiewg5MGOMJrbYhDd9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiogrxRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DD0C4CEC2;
	Mon,  2 Sep 2024 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293713;
	bh=bCMnwRpHi66cFH/lCsEid/oKr2HghP0ARsPCue09C2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hiogrxRFyn8vQQfhGNJ/drW4qbwWXwEEu+Dd5WhXG6olMKDiFN8hf7mfXh716j+Nt
	 pZEadSoeHP7P01LgCx6sxgA0v14AgoOSB+CVNLP2gPDxIuASdkeC2n7VH7Lyi77SCJ
	 77HABY9Yw1XdmFAM3pceLtWlbIueNanAlWwEqoWC6Cg6e+4uWJSir6Y4Sk7pRKTAiP
	 o2Wzl+sPcsH/mkO8HXePqQu6OQUARzsSWNYBLjW2Akkv4BfId6967yJJd8QgdPWL5L
	 p1nPkDDxZuW0ROzghllns9AwjWRsI068jmIAl3H6AY5UaTOcvyINeP2umSOk2ou9TB
	 2cFwtmVG5CGjw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 03 Sep 2024 01:14:35 +0900
Subject: [PATCH HID 5/7] selftests/hid: add test for assigning a given
 device to hid-generic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-hid-bpf-hid-generic-v1-5-9511a565b2da@kernel.org>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
In-Reply-To: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725293696; l=5135;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=bCMnwRpHi66cFH/lCsEid/oKr2HghP0ARsPCue09C2M=;
 b=Fq51Mhtp6XwSlsUtSdLSeedwjleE6cg3NOpcXRnxuSFQIC9FgLEV+4LSzRgH15TeB4rKXfyLB
 aKDVQtAT9jOAOS8f2qq1Ec0OJv/wWjgaml16hs+DactyKIIezB33DVF
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We use a well known VID/PID on a driver that doesn't need to talk to
the device, ensures we created the device against the target driver,
then load our program and ensure we have unbound to this driver and use
hid-generic instead.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c              | 80 +++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            | 29 ++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  2 +
 3 files changed, 110 insertions(+), 1 deletion(-)

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
index 5ecc845ef792..883d09498351 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -598,3 +598,32 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_infinite_loop_input_report = {
 	.hid_device_event = (void *)hid_test_infinite_loop_input_report,
 };
+
+SEC("?struct_ops/hid_driver_probe")
+void BPF_PROG(hid_test_driver_probe, struct hid_device *hdev, struct hid_bpf_driver *hdrv,
+				     struct hid_device_id *id)
+{
+	static const char hid_generic[] = "hid-generic";
+
+	bpf_printk("test_driver_probe, %s", hdrv->name);
+	if (!__builtin_memcmp(hdrv->name, hid_generic, sizeof(hid_generic)))
+		hdrv->force_driver = 1;
+	else
+		hdrv->ignore_driver = 1;
+}
+
+SEC("?struct_ops.s/hid_rdesc_fixup")
+int BPF_PROG(hid_rdesc_fixup_2, struct hid_bpf_ctx *hid_ctx)
+{
+	/*
+	 * We need an empty report descriptor fixup to force detach/reattach
+	 * the device when we load the BPF program.
+	 */
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_driver_probe = {
+	.hid_driver_probe = (void *)hid_test_driver_probe,
+	.hid_rdesc_fixup = (void *)hid_rdesc_fixup_2,
+};
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index e5db897586bb..6b0f870d0727 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -81,6 +81,8 @@ struct hid_bpf_ops {
 			       enum hid_report_type rtype, enum hid_class_request reqtype,
 			       u64 source);
 	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, u64 source);
+	void (*hid_driver_probe)(struct hid_device *hdev, struct hid_bpf_driver *hdrv,
+				 struct hid_device_id *id);
 	struct hid_device *hdev;
 };
 

-- 
2.46.0


