Return-Path: <linux-kselftest+bounces-12426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE454911FC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F557B24317
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E57C171643;
	Fri, 21 Jun 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey8y0Uab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF35171095;
	Fri, 21 Jun 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960209; cv=none; b=rUHODeVzLLvEF1Gm6OB9JGSgONAr+Id4cn97RAghnhz5MYpAY/oRGR/O7YCaN4SEbqeMqPSpJXqJvmIM0iksLbY0IaVcrxSVjb+T8HhW71js6iFR9yE658H0BtFBToAnElOJEXVtNRuHiG6kTtMTDWIyrW0e66XNxuNNXhG0hxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960209; c=relaxed/simple;
	bh=WPwwooXuS0nED9cpstCdU7FofrWc0SoDAgoa3tF7+20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mq3zy3+caYpMh6yTzMOo3iEpx0adGbA6gwlqvN4gHTCSTxM3sQJJr6+nrcRpwc2qLk+qI/UzndOuldP8rFRHc+EcbTgz6sVD/K9WLhkdV297HtElCSQgXh9V8DGukmHhT6HZ3ucX6yT8+GzHhjwV4hupc2W4Jlxp/JIoKXVEhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey8y0Uab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5AEC2BBFC;
	Fri, 21 Jun 2024 08:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960208;
	bh=WPwwooXuS0nED9cpstCdU7FofrWc0SoDAgoa3tF7+20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ey8y0UabeBMU1e33nxDCEliEpC8rrOPQgBGpFsGLxANChlv+eEFGh+jin2Ndil9dL
	 PyDOez+cp6agxasrgSQuuFtMaWlYcmJrol6SmaGvE3bkFpiWI9P214tlD87oL+ZiVV
	 IrYS96oSq/PLfxsJXh6Dkiq52vBq5yuxll02ehegSwd340pq9T6/DBqnhwofq/L8t7
	 OH/vixx0NyjTfDu8rCP6kD9dgJPWTDysefpevzDGInm53uGww73gcE83qF88ZccfsQ
	 PqTyCCQFSrO6q0B9v1N3OjFOT9zzL9Ic0Ljr7CFrE4qq7Qkhq8iupzOzNQ/7fiMX/4
	 eQBZDl+wERBYA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:57 +0200
Subject: [PATCH HID 12/12] selftests/hid: add an infinite loop test for
 hid_bpf_try_input_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-12-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=3494;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=WPwwooXuS0nED9cpstCdU7FofrWc0SoDAgoa3tF7+20=;
 b=JO0XVVeFfVMpLeLZiaGS6NFxHyeNtErIO5sz7tAcfM4yo8HsZG6i6XbwzHI0HOsDA/dzv9I50
 l2GmNJU714XAGEkgs2h8lO5x7DEcZJd5ilC27YDPsZGHAKYVpjSoBpi
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We don't want this call to allow an infinite loop in HID-BPF, so let's
have some tests.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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


