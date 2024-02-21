Return-Path: <linux-kselftest+bounces-5196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD485E34A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CA2877CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4D85941;
	Wed, 21 Feb 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9NRW3Pe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D81AAA;
	Wed, 21 Feb 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532782; cv=none; b=HjEIRNV0V50um2Xkr8HLNtBH2Hu7kZf0QNkfvVeI+4BBamm4uComMPIk5TzYy0wkUbIwkjF3xjxG1jCmOJklTACgzJ3WiIPUnTkT/+vGNRs/qn+Jkp5j2wfzKIBsf7H+DDoPl+ktaLcau6Adl+qx7IQEiRbKMe+k4wpS2ymGYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532782; c=relaxed/simple;
	bh=+rMCilTz6LtxI50aPniz+3/TXiw2f8owICLVx5G6iGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dK9N+Dk6JshmijLBTqxZokC+wcBuOW6Kf/YM62iqdq7VdMcSuXzINk1r3be4ZzI7P+VBNTp5uOEE19KbMoHMiz6jbr5jKK/e9YQt7juqPSJQr9xU0RrkbwJf/5oPR2lGLYlAhYX2KYrecXMf8YStW+kiXhF6nYyyGaCEOdoql40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9NRW3Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09698C43394;
	Wed, 21 Feb 2024 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532782;
	bh=+rMCilTz6LtxI50aPniz+3/TXiw2f8owICLVx5G6iGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C9NRW3PeX1w+SeD9HHF8O1LkDNYGHkkLapUGtyUB9ZUzkBzEtme4dRJQF4+qRz6ZX
	 hAu5tUJbDeTlpEfPuw0SIWJkTca4QmRb7IyOjs15yCRMF36r4l158UJ59+hBfqDAKG
	 N3GkND8wtgaKLKk6tu8BXniBrHuO9yoP8pRo3d+dBgQ5fSskDDUTpVI6mDiMpIvRIF
	 IAnDVk2vcy5JIlhq+1qzG6gU0Om1U9m1KS79yrzi6b375aAZaU4mPXVZD4VqmFRDXI
	 Ysjy3op6azJhIE1uz7vuJXdEUCoKYji3Z82r5z/OVU+bTk8lP8Hh9ZX/C/F0cTHzG7
	 1AXPiYtubkyTw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:29 +0100
Subject: [PATCH RFC bpf-next v3 13/16] selftests/hid: add tests for
 hid_bpf_input_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-13-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=4226;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=+rMCilTz6LtxI50aPniz+3/TXiw2f8owICLVx5G6iGI=;
 b=LYROSoJi4yNche7QagjMXbKZa7M8HPI9SmacfOXgiTAgyJB85n1lNL7I6QyiyuXsjBU32S9QJ
 B2JZ21bgLeBDWmTz3ymzFsDfmU62sQai7VfNgkoA6/dNT2DOWVv7vvp
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Usual way of testing, we call the function and ensures we receive
the event

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c              | 49 +++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c            | 22 ++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  4 ++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 8332014838b0..f825623e3edc 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -749,6 +749,52 @@ TEST_F(hid_bpf, test_hid_change_report)
 	ASSERT_EQ(buf[2], 0) TH_LOG("leftovers_from_previous_test");
 }
 
+/*
+ * Call hid_bpf_input_report against the given uhid device,
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_user_input_report_call)
+{
+	struct hid_hw_request_syscall_args args = {
+		.retval = -1,
+		.size = 10,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+	__u8 buf[10] = {0};
+	int err, prog_fd;
+
+	LOAD_BPF;
+
+	args.hid = self->hid_id;
+	args.data[0] = 1; /* report ID */
+	args.data[1] = 2; /* report ID */
+	args.data[2] = 42; /* report ID */
+
+	prog_fd = bpf_program__fd(self->skel->progs.hid_user_input_report);
+
+	/* check that there is no data to read from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+
+	ASSERT_OK(err) TH_LOG("error while calling bpf_prog_test_run_opts");
+
+	ASSERT_EQ(args.retval, 0);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 2);
+	ASSERT_EQ(buf[2], 42);
+}
+
 /*
  * Call hid_bpf_hw_output_report against the given uhid device,
  * check that the program is called and does the expected.
@@ -797,8 +843,7 @@ TEST_F(hid_bpf, test_hid_user_output_report_call)
 }
 
 /*
- * Attach hid_user_raw_request to the given uhid device,
- * call the bpf program from userspace
+ * Call hid_hw_raw_request against the given uhid device,
  * check that the program is called and does the expected.
  */
 TEST_F(hid_bpf, test_hid_user_raw_request_call)
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 2c2b679a83b1..f67d35def142 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -125,6 +125,28 @@ int hid_user_output_report(struct hid_hw_request_syscall_args *args)
 	return 0;
 }
 
+SEC("syscall")
+int hid_user_input_report(struct hid_hw_request_syscall_args *args)
+{
+	struct hid_bpf_ctx *ctx;
+	const size_t size = args->size;
+	int i, ret = 0;
+
+	if (size > sizeof(args->data))
+		return -7; /* -E2BIG */
+
+	ctx = hid_bpf_allocate_context(args->hid);
+	if (!ctx)
+		return -1; /* EPERM check */
+
+	ret = hid_bpf_input_report(ctx, HID_INPUT_REPORT, args->data, size);
+	args->retval = ret;
+
+	hid_bpf_release_context(ctx);
+
+	return 0;
+}
+
 static const __u8 rdesc[] = {
 	0x05, 0x01,				/* USAGE_PAGE (Generic Desktop) */
 	0x09, 0x32,				/* USAGE (Z) */
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 50c6a0d5765e..9cd56821d0f1 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -96,5 +96,9 @@ extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
 			      enum hid_class_request reqtype) __ksym;
 extern int hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx,
 				    __u8 *buf, size_t buf__sz) __ksym;
+extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
+				enum hid_report_type type,
+				__u8 *data,
+				size_t buf__sz) __ksym;
 
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.43.0


