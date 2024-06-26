Return-Path: <linux-kselftest+bounces-12810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28D918343
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699861F21190
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4D18EFE8;
	Wed, 26 Jun 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7TgyvOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F818E755;
	Wed, 26 Jun 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409635; cv=none; b=YEGf4G0SDa+C1d2gy5fYZd8yIcziu92VBT6xALJkG/6NiOcjGbxUKRAeG9PQPhdOGnGv4tAYCgnxd5yBAcJkddX/h+ascP3nZnbbAayH4BgpgiQRfsfOCw/1pkTDM5nkW9aK0RDzvpW3xjLfRqFmFrANbi3d0EEg/eLx01L5gOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409635; c=relaxed/simple;
	bh=coSvairEXZ/UoBj93IfzT1BpGcOK/jnPrORkflCNJ84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPqwuL+s//UYPAZ8sBkQ2mDNJw94M/bHi+uageZJGGa+WtL3j5nq6J6H2kvaSdILv75kIcC/7+TD7WUQIYYLe/xi+2BZZJKcs7SzIb+6C55UyeV7uaIt418zdA+5NA6Y9HrzwgG0G1B71NNzWSyi3bps2U7mfDkAdJpF4eGvExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7TgyvOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F55BC4AF07;
	Wed, 26 Jun 2024 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409635;
	bh=coSvairEXZ/UoBj93IfzT1BpGcOK/jnPrORkflCNJ84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M7TgyvOqh+G8JBHZHxNOGoIIsb0OsioBMMg+gOn3TNV2PLOLkJ4AFX/7QXQhW2132
	 XYagHiEHIDF3QcAPTMADf7q5VPdhGTK7+owjeNWkzBJ1cXERnJ/1h1iykUccDUp4PE
	 kuD1m9RrzITqb69QiZOIi/HxAY299c+0rPcgtu0J3NNyRRKFeEt6ndbKgLrReKiIKC
	 wguo+WVHSMkOPKQiq7dWMNaB4ardr+pcIv2Rpi4IsAoT+ONvZ+YBv5mbuX82d2JhHw
	 KXt2QnVFzV2gGVnLVKrRtAA2ERheboepDnc0EgKd8WTobmRObueqSzVRoAdBmWSofZ
	 hIdu+Z7T9P6Fg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:34 +0200
Subject: [PATCH HID v2 13/13] selftests/hid: add an infinite loop test for
 hid_bpf_try_input_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-13-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=3521;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=coSvairEXZ/UoBj93IfzT1BpGcOK/jnPrORkflCNJ84=;
 b=y3R38nLnIx95jobpAICJH1TPSo58IZ3qiL3BnUPgxNlYvk6mTJ8bIWv2euPxrMe7T3qg3vOGa
 jOkMsJiAcShAU0XVpvS0VDk6ymvazKa9awoDZgpz/V6UVXz4BJjAvYA
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We don't want this call to allow an infinite loop in HID-BPF, so let's
have some tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c   | 41 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c | 37 +++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 36bbad8e0f9f..dc0408a831d0 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -1204,6 +1204,47 @@ TEST_F(hid_bpf, test_multiply_events)
 	ASSERT_EQ(buf[1], 52);
 }
 
+/*
+ * Call hid_bpf_input_report against the given uhid device,
+ * check that the program is not making infinite loops.
+ */
+TEST_F(hid_bpf, test_hid_infinite_loop_input_report_call)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_infinite_loop_input_report" },
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
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 3);
+
+	/* read the data from hidraw: hid_bpf_try_input_report should work exactly one time */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 4);
+
+	/* read the data from hidraw: there should be none */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 46feeb91d1d5..ee9bbbcf751b 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -561,3 +561,40 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_multiply_events = {
 	.hid_device_event = (void *)hid_test_multiply_events,
 };
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_test_infinite_loop_input_report, struct hid_bpf_ctx *hctx,
+	     enum hid_report_type report_type, __u64 source)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 6 /* size */);
+	__u8 buf[6];
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/*
+	 * we have to use an intermediate buffer as hid_bpf_input_report
+	 * will memset data to \0
+	 */
+	__builtin_memcpy(buf, data, sizeof(buf));
+
+	/* always forward the request as-is to the device, hid-bpf should prevent
+	 * infinite loops.
+	 * the return value is ignored so the event is passing to userspace.
+	 */
+
+	hid_bpf_try_input_report(hctx, report_type, buf, sizeof(buf));
+
+	/* each time we process the event, we increment by one data[1]:
+	 * after each successful call to hid_bpf_try_input_report, buf
+	 * has been memcopied into data by the kernel.
+	 */
+	data[1] += 1;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_infinite_loop_input_report = {
+	.hid_device_event = (void *)hid_test_infinite_loop_input_report,
+};

-- 
2.44.0


