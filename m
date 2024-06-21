Return-Path: <linux-kselftest+bounces-12421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954BF911FA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF2628BC2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71216F85B;
	Fri, 21 Jun 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arqvCC9P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9E16F851;
	Fri, 21 Jun 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960197; cv=none; b=so+aHk3anfiiF+TVb1vxErBg4f76R4Lzi5Ry/pQFejxk0RBA/XgkvL9UIsvVjiMdALmxHmDQcSX7Pr/n/5aMhBTGbIGHC3/jKLvNLlPgUmqR4YYRQo7duV3Q667OhlYmVMtFmem7FY4+R2u/Bx2ST6V1i8FqaPMAzbvAD2bxFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960197; c=relaxed/simple;
	bh=MxMkuADZzmbb/em9A6sYu6ONT5jyr5EOmXwu5TDHno0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgDKBbi8WflQjeznFmiVXO4nzZh1q7J5BgBh+88w9wFTLrArPxzohTxdsFYiWfcJbQxqEebbLuT9c9jvBH47FWyTbugUGNvB+ggv/E0HCHJsw+BFP4Use7NYClClvC48NRkus49ZB4oXjW98b1Zq+MobqkSCeiZb2e8KFlhcpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arqvCC9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF9DC2BBFC;
	Fri, 21 Jun 2024 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960197;
	bh=MxMkuADZzmbb/em9A6sYu6ONT5jyr5EOmXwu5TDHno0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=arqvCC9PXrocQPv0cMzAupNiJEk+ZWOsvmvyWT/GhKblgGtZYTXqo3FyUV3JTESF0
	 PBdVT8BZztGpxhPmFfskLuFiWzmfRtyM4WvvCCL2heBCa8A4iN5NoBLpNWchRNmUuV
	 nEX050yDhVIVfVAY0HKmrPirBWJBNr2E0mfd0+d1yeq3gomNrU2f7oX80qwNXXpv13
	 gHtWJPzhD0Ys8aeoDIOIYVyBs7RigakwKNUa+lMj1uKagep72CPY2KdzxYE5vpQFZj
	 fLzASjShuRrctAd9ReaSzgOx0noYDRAujF3l683aqiLdh2hqgEiDsSyAtEEZ+cY+Ph
	 JumShnv5t9k1g==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:52 +0200
Subject: [PATCH HID 07/12] selftests/hid: add tests for
 hid_hw_output_report HID-BPF hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-7-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=6961;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=MxMkuADZzmbb/em9A6sYu6ONT5jyr5EOmXwu5TDHno0=;
 b=6EPs8vyP84navHyatk0LX+wODgJBFDR8Tq+ULWo6sg2qZtJRU0j4o9ctNipQKmAbUfAXtENPG
 MHI8dQYa/QYDoIu1WUYQKIEwnz7Z6Q10vpRcdnYx/C6mIvMSBDVWZ6X
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We add 3 new tests:
- first, we make sure we can prevent the output_report to happen
- second, we make sure that we can detect that a given hidraw client
  was actually doing the request, and for that client only, call ourself
  hid_bpf_hw_output_report(), returning a custom value
- last, we ensure that we can not loop between hooks for
  hid_hw_output_report() and manual calls to hid_bpf_hw_output_report()
  from that same hook

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c      |   5 ++
 tools/testing/selftests/hid/hid_bpf.c   | 102 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c |  58 ++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 2a29a0625a3b..709403340fd7 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -457,11 +457,16 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 __bpf_kfunc int
 hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 {
+	struct hid_bpf_ctx_kern *ctx_kern;
 	struct hid_device *hdev;
 	size_t size = buf__sz;
 	u8 *dma_data;
 	int ret;
 
+	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+	if (ctx_kern->from_bpf)
+		return -EDEADLOCK;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, HID_OUTPUT_REPORT);
 	if (ret)
diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index f97d56337d8a..40aedd1d9dc5 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -1028,6 +1028,108 @@ TEST_F(hid_bpf, test_hid_infinite_loop_raw_request_call)
 	ASSERT_EQ(err, 3) TH_LOG("unexpected returned size while reading HIDIOCGFEATURE: %d", err);
 }
 
+/*
+ * Call hid_hw_output_report against the given uhid device,
+ * check that the program is called and prevents the
+ * call to uhid.
+ */
+TEST_F(hid_bpf, test_hid_filter_output_report_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_filter_output_report" },
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
+	/* now check that our program is preventing hid_hw_output_report() */
+
+	buf[0] = 1; /* report ID */
+	buf[1] = 2;
+	buf[2] = 42;
+
+	err = write(self->hidraw_fd, buf, 3);
+	ASSERT_LT(err, 0) TH_LOG("unexpected success while sending hid_hw_output_report: %d", err);
+	ASSERT_EQ(errno, 25) TH_LOG("unexpected error code while sending hid_hw_output_report: %d",
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
+	err = write(self->hidraw_fd, buf, 3);
+	ASSERT_GE(err, 0) TH_LOG("error while sending hid_hw_output_report: %d", err);
+}
+
+/*
+ * Call hid_hw_output_report against the given uhid device,
+ * check that the program is called and can issue the call
+ * to uhid and transform the answer.
+ */
+TEST_F(hid_bpf, test_hid_change_output_report_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_hidraw_output_report" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* emit hid_hw_output_report from hidraw */
+	buf[0] = 1; /* report ID */
+	buf[1] = 2;
+	buf[2] = 42;
+
+	err = write(self->hidraw_fd, buf, 10);
+	ASSERT_EQ(err, 2) TH_LOG("unexpected returned size while sending hid_hw_output_report: %d",
+				 err);
+}
+
+/*
+ * Call hid_hw_output_report against the given uhid device,
+ * check that the program is not making infinite loops.
+ */
+TEST_F(hid_bpf, test_hid_infinite_loop_output_report_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_infinite_loop_output_report" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* emit hid_hw_output_report from hidraw */
+	buf[0] = 1; /* report ID */
+	buf[1] = 2;
+	buf[2] = 42;
+
+	err = write(self->hidraw_fd, buf, 8);
+	ASSERT_EQ(err, 2) TH_LOG("unexpected returned size while sending hid_hw_output_report: %d",
+				 err);
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 0ad452fcca58..1fa288b76cd5 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -385,3 +385,61 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_infinite_loop_raw_request = {
 	.hid_hw_request = (void *)hid_test_infinite_loop_raw_request,
 };
+
+SEC("?struct_ops/hid_hw_output_report")
+int BPF_PROG(hid_test_filter_output_report, struct hid_bpf_ctx *hctx, unsigned char reportnum,
+	     enum hid_report_type rtype, enum hid_class_request reqtype, __u64 source)
+{
+	return -25;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_filter_output_report = {
+	.hid_hw_output_report = (void *)hid_test_filter_output_report,
+};
+
+SEC("?struct_ops.s/hid_hw_output_report")
+int BPF_PROG(hid_test_hidraw_output_report, struct hid_bpf_ctx *hctx, __u64 source)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 3 /* size */);
+	int ret;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* check if the incoming request comes from our hidraw operation */
+	if (source == (__u64)current_file)
+		return hid_bpf_hw_output_report(hctx, data, 2);
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_hidraw_output_report = {
+	.hid_hw_output_report = (void *)hid_test_hidraw_output_report,
+};
+
+SEC("?struct_ops.s/hid_hw_output_report")
+int BPF_PROG(hid_test_infinite_loop_output_report, struct hid_bpf_ctx *hctx, __u64 source)
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
+
+	ret = hid_bpf_hw_output_report(hctx, data, 2);
+	if (ret == 2)
+		return 2;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_infinite_loop_output_report = {
+	.hid_hw_output_report = (void *)hid_test_infinite_loop_output_report,
+};

-- 
2.44.0


