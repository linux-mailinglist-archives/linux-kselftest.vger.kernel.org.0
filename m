Return-Path: <linux-kselftest+bounces-12802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA8918316
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BF11C22700
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD11187357;
	Wed, 26 Jun 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn6jEX7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BE18732F;
	Wed, 26 Jun 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409619; cv=none; b=QN9QAIzQqkeBZn4qwMYvS+eToiyduZwqlP7yfBpf5zTj01bjtv4UQZD690kv3/a/Q0W8cAeQw0c004PxhnOSvXSPzYxFGmkoXjoiJkGJBpLcUEfLrzZwDTXm76a2n53akzbyuHxqBtUGNh5ll5f9G9BtLm8cx2GzHRUxSgdD8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409619; c=relaxed/simple;
	bh=jrGb1XosYynHCDb0fEHEmq8mfYlpvC5f5ygZfOeVxXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWik7kkyzD9Md7zEjW0EjW3fEIBYKcpnvWXn9K9zScAYDf61xGz4A7GdqnXnis/3rg4mDtYtNy97PZ76DGlJ8HIuUgadQosPhJzsEPd/NyQbQZuM/5xfKXhzAfF5M2Av9qf0G6/LupLwjj03q8W18sPfORa0VpG2nTaKYKCpjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn6jEX7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF69C32782;
	Wed, 26 Jun 2024 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409618;
	bh=jrGb1XosYynHCDb0fEHEmq8mfYlpvC5f5ygZfOeVxXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jn6jEX7WpVVkLtLAYHU2DipG1dxYJJV6z5zBW6izMMG4kgMV6suJBuO+FeDUEOSNC
	 AmGpg1Q8Go2e+/aRZpDQYd5ZgibJzyri/mRd1vGpn6ws40uypbKoaNmiksZlDoWBnf
	 hDm/MCmQT0cQkxwiqp5VPUyDqotBGAFtyGrKV3ZzYVuqaMhIoz/2+v6rX1bXLMKkzt
	 69yq+S3p6IZLpC1Kh86CcTBTAtxdEHfNcPWpuBjTYXgy4OaZeOJ2dRAFBIhajQsWk+
	 vR0FGdYzdzb7e1yvCcTTmVfhmqai2zeLx90Va2ym3Vac8QL2CyX3Af1MWWue1fNsiS
	 frSB7tevY9qiw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:27 +0200
Subject: [PATCH HID v2 06/13] selftests/hid: add tests for
 hid_hw_raw_request HID-BPF hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-6-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=7406;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=jrGb1XosYynHCDb0fEHEmq8mfYlpvC5f5ygZfOeVxXg=;
 b=hieq1TemhrcUUJNP2ybL5EDuoMHEG87jWAqEJplqsSoC5QIqotz4BrQvJRYXUTCZEUkhd3kNC
 RNZLqZGZWZQC1235Z/QLGKwAKjX837NsNTqPYMh/J8a//Y24nqlCSUz
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

no changes in v2
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


