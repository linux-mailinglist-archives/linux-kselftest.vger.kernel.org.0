Return-Path: <linux-kselftest+bounces-12419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3EF911FA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10B61F20F34
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299F16F26B;
	Fri, 21 Jun 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ1Ac5HG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE116DEA2;
	Fri, 21 Jun 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960192; cv=none; b=Gu2OoR7kJxH+3iURJNDA0eyNymad4tLkcIh5CNLMVx3MP/5T1suVe3StFfZu0DVWqp5CQlAUwc/9/K6omYIUgAlGQonQDj5HYmnPRGqVIZ9Z+3reDadlbkHdrNILphBLaB87wIyhEw0SYHa27+iDif2z1OJtNIG4b4MgjDbZpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960192; c=relaxed/simple;
	bh=y33ev/OTZs7XXrfVAbnT4fpGU9UPD2zKcmYgHXfHD8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xtam+aGC9BuewwtJDbTIlxNBGl2fvhEQ3zurBQRNGpBIHzGivBCpi59HHltQ6H76DHi3a4I3a8Slig9vieM64dmaTJFvwEmJZ05C4L1UG9H3ALySTLerPPfncGHu7sCABpY0g0FPArSVNrXGFr09+xZCeNNRE2Qq6JKg9Ao76x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ1Ac5HG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A114CC2BBFC;
	Fri, 21 Jun 2024 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960192;
	bh=y33ev/OTZs7XXrfVAbnT4fpGU9UPD2zKcmYgHXfHD8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TQ1Ac5HGez8vRd2m/g1WYsx8H+U4gwwuFYzjMqmtJxmt600JjquO6p2JeO+MC/JXE
	 bSOEklcyCoNFhAiJKMbXwD1TCPVQVIuNOxKh4SV+4t1PIjeuZZUjLoALqiNoAouA+s
	 k7E67EWyCwO1LzHmfznKvGQpOSCgNjgJIEBHlK2QOybhAugqJVyz+v4yPPr2Qjgkz+
	 dNND+0yGHHnMU+J6sHDcKv05VviyPJChBMbC7oDVdaQ9lKjXepiSzKixhhKh7NDmni
	 9PlyjnE+IxCB59nj5vpMrcefW/ld5Sa9uq8a8KXat/M06ID16M2IXLhyz25QpuJdhF
	 LOLmLAZAUh4Rw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:50 +0200
Subject: [PATCH HID 05/12] selftests/hid: add tests for hid_hw_raw_request
 HID-BPF hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-5-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=7379;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=y33ev/OTZs7XXrfVAbnT4fpGU9UPD2zKcmYgHXfHD8k=;
 b=IRKBtNvBa4FiwpYHW7rS9BCgSRmJ4Epg6dh8Fvr+fFLfrwNFfcrEXnrUi3Eq547UuzR8h7381
 QDFr7pJTJmwBJRuNu7jpK/Qtxu1m4mr6NF2oMKs8NPDMX1U16TrKCHp
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We add 3 new tests:
- first, we make sure we can prevent the raw_request to happen
- second, we make sure that we can detect that a given hidraw client
  was actually doing the request, and for that client only, call ourself
  hid_bpf_hw_request(), returning a custom value
- last, we ensure that we can not loop between hooks for
  hid_hw_raw_request() and manual calls to hid_bpf_hw_request() from that
  hook

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c   | 109 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c |  79 +++++++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 45e173db35bd..f97d56337d8a 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -470,6 +470,11 @@ static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
 		close(self->hidraw_fd);
 	self->hidraw_fd = 0;
 
+	if (!self->skel)
+		return;
+
+	hid__detach(self->skel);
+
 	for (i = 0; i < ARRAY_SIZE(self->hid_links); i++) {
 		if (self->hid_links[i])
 			bpf_link__destroy(self->hid_links[i]);
@@ -575,6 +580,8 @@ static void load_programs(const struct test_program programs[],
 							 programs[i].name + 4);
 	}
 
+	hid__attach(self->skel);
+
 	self->hidraw_fd = open_hidraw(self->dev_id);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 }
@@ -919,6 +926,108 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 	ASSERT_EQ(args.data[1], 2);
 }
 
+/*
+ * Call hid_hw_raw_request against the given uhid device,
+ * check that the program is called and prevents the
+ * call to uhid.
+ */
+TEST_F(hid_bpf, test_hid_filter_raw_request_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_filter_raw_request" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* first check that we did not attach to device_event */
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 42);
+	ASSERT_EQ(buf[2], 0) TH_LOG("leftovers_from_previous_test");
+
+	/* now check that our program is preventing hid_hw_raw_request() */
+
+	/* emit hid_hw_raw_request from hidraw */
+	/* Get Feature */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 0x1; /* Report Number */
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_LT(err, 0) TH_LOG("unexpected success while reading HIDIOCGFEATURE: %d", err);
+	ASSERT_EQ(errno, 20) TH_LOG("unexpected error code while reading HIDIOCGFEATURE: %d",
+				    errno);
+
+	/* remove our bpf program and check that we can now emit commands */
+
+	/* detach the program */
+	detach_bpf(self);
+
+	self->hidraw_fd = open_hidraw(self->dev_id);
+	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
+
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_GE(err, 0) TH_LOG("error while reading HIDIOCGFEATURE: %d", err);
+}
+
+/*
+ * Call hid_hw_raw_request against the given uhid device,
+ * check that the program is called and can issue the call
+ * to uhid and transform the answer.
+ */
+TEST_F(hid_bpf, test_hid_change_raw_request_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_hidraw_raw_request" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* emit hid_hw_raw_request from hidraw */
+	/* Get Feature */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 0x1; /* Report Number */
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_EQ(err, 3) TH_LOG("unexpected returned size while reading HIDIOCGFEATURE: %d", err);
+
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 3);
+	ASSERT_EQ(buf[2], 4);
+}
+
+/*
+ * Call hid_hw_raw_request against the given uhid device,
+ * check that the program is not making infinite loops.
+ */
+TEST_F(hid_bpf, test_hid_infinite_loop_raw_request_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_infinite_loop_raw_request" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* emit hid_hw_raw_request from hidraw */
+	/* Get Feature */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 0x1; /* Report Number */
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_EQ(err, 3) TH_LOG("unexpected returned size while reading HIDIOCGFEATURE: %d", err);
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 2e7e5a736dc6..0ad452fcca58 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -306,3 +306,82 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_insert3 = {
 	.hid_device_event = (void *)hid_test_insert3,
 };
+
+SEC("?struct_ops/hid_hw_request")
+int BPF_PROG(hid_test_filter_raw_request, struct hid_bpf_ctx *hctx, unsigned char reportnum,
+	     enum hid_report_type rtype, enum hid_class_request reqtype, __u64 source)
+{
+	return -20;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_filter_raw_request = {
+	.hid_hw_request = (void *)hid_test_filter_raw_request,
+};
+
+static struct file *current_file;
+
+SEC("fentry/hidraw_open")
+int BPF_PROG(hidraw_open, struct inode *inode, struct file *file)
+{
+	current_file = file;
+	return 0;
+}
+
+SEC("?struct_ops.s/hid_hw_request")
+int BPF_PROG(hid_test_hidraw_raw_request, struct hid_bpf_ctx *hctx, unsigned char reportnum,
+	     enum hid_report_type rtype, enum hid_class_request reqtype, __u64 source)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 3 /* size */);
+	int ret;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* check if the incoming request comes from our hidraw operation */
+	if (source == (__u64)current_file) {
+		data[0] = reportnum;
+
+		ret = hid_bpf_hw_request(hctx, data, 2, rtype, reqtype);
+		if (ret != 2)
+			return -1;
+		data[0] = reportnum + 1;
+		data[1] = reportnum + 2;
+		data[2] = reportnum + 3;
+		return 3;
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_hidraw_raw_request = {
+	.hid_hw_request = (void *)hid_test_hidraw_raw_request,
+};
+
+SEC("?struct_ops.s/hid_hw_request")
+int BPF_PROG(hid_test_infinite_loop_raw_request, struct hid_bpf_ctx *hctx, unsigned char reportnum,
+	     enum hid_report_type rtype, enum hid_class_request reqtype, __u64 source)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 3 /* size */);
+	int ret;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* always forward the request as-is to the device, hid-bpf should prevent
+	 * infinite loops.
+	 */
+	data[0] = reportnum;
+
+	ret = hid_bpf_hw_request(hctx, data, 2, rtype, reqtype);
+	if (ret == 2)
+		return 3;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_infinite_loop_raw_request = {
+	.hid_hw_request = (void *)hid_test_infinite_loop_raw_request,
+};

-- 
2.44.0


