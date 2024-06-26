Return-Path: <linux-kselftest+bounces-12804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C0F91831F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676D11F212F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5A188CAD;
	Wed, 26 Jun 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAZnXEcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1398187568;
	Wed, 26 Jun 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409624; cv=none; b=Zu+pUvMLqq1cubESSu/8iFy7pqA0Nu9vPxg1W4G42sv7qOX2t18dpUtrUTxZHjsbN6GW01Yy4xw1V3eoWCTitkhuLr9sSm0lVMuVTVlSiYFEVTekbQEJEsxy0mGz+qWk4GsW9pBg21WZ8zSw354UOzS45eBGKf/yaWEdsO+4nQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409624; c=relaxed/simple;
	bh=JZObegxagyPRgI3IWA8hj5O10mhsN7UzKEHnUkVEJs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipoWeu299u46NUJupZSja3aELK8M9rH+0+Rp/jgTM9VP7eMf30LWqskoZWj3jqsL0scvtH+Md3ET0NvvD430UlqNrWp2MN0G1UgEq9NEN0eBGQNs8ZgJPLl3V0x9YaTicnz5KxdebhQS78QC34vFAMmRP1qXnJF7TAjxjBGyv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAZnXEcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FA3C32782;
	Wed, 26 Jun 2024 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409623;
	bh=JZObegxagyPRgI3IWA8hj5O10mhsN7UzKEHnUkVEJs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RAZnXEcCNJFwxXiqf8QqktBdhSVAOAq3ZjattCMLZM3REizJvM6OndUA2ANulyQJR
	 n5YIjorv2QbWTDxRuASA98sE1m4i61x3zhLWqws4rzrCXR0JjygjaO24r86oCN73FB
	 R0nBa/0Z59cfgzZ3XM0qIUPMAUHTJJRe/D1ClWKVqmGgcgj5yieEcqfP/8P/DVcqdG
	 7Y94ZgDK1qKQ+ihaxM38Bxzb/Lh48PpCA7b1sqLwwxide75NWLOA/9H5xbG1HT08YA
	 je87BL6r4FcHpjQauabjANmEedBKcE387XF8Zq8d5Qp/HE47KresP0gOAbZOA/gdCl
	 UnvRmz53rA8ig==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:29 +0200
Subject: [PATCH HID v2 08/13] selftests/hid: add tests for
 hid_hw_output_report HID-BPF hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-8-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=6988;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JZObegxagyPRgI3IWA8hj5O10mhsN7UzKEHnUkVEJs8=;
 b=BvcwpPMLAxxNBDFI90RPw8gatIQeiL+35KHX8d0UtB73rt+LFjSs6Xeuj69uGWdaU3ccScpQB
 XF1d0kfbggDChubQUTGt0X5wNZg6vk6qoc4effeWN2GepI9szQpqHp0
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

no changes in v2
---
 drivers/hid/bpf/hid_bpf_dispatch.c      |   5 ++
 tools/testing/selftests/hid/hid_bpf.c   | 102 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c |  58 ++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 49f261054418..0aab49a2b869 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -459,11 +459,16 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
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


