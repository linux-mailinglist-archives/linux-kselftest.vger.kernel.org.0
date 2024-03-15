Return-Path: <linux-kselftest+bounces-6360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20987CF4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1E1C222BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7543B789;
	Fri, 15 Mar 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ0dtYY+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDF46544;
	Fri, 15 Mar 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513903; cv=none; b=dTSZpX0mvoUord0wmCYmVRJSzFgc2FGd1b+zGdSsUJ9k0iNfapA1KJz+5g3PvD3Ye6lx9bks2VAqDEF1H71uzfirgL24+XSeWL5EMkDdKSqzP56PkqbAyAbQKX0ySbDAhrkNGlz7erZ/aUTR2vDuB9ZaTtnXwINRduM/bOHLWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513903; c=relaxed/simple;
	bh=lYHlpbXv8wmdpHJLSDMirre3aCp7tdPr2ucjfV4U1U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVnAUiyDtn/Km7TkC+jS/Nd03N0BNn4mVo0qy7+gf5yQxDFjF5/Hv0/z/XFYRF1D4++pRtNcJE9AAXnahsYL0WznPcMUQ72BLbhWjhalQm6kxLUIfnNfhU8sUHno7PqSpbZem38JSYe/U0gxzkdvEpBbQH1OkwAGWilAgT1QasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ0dtYY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1B9C433F1;
	Fri, 15 Mar 2024 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513902;
	bh=lYHlpbXv8wmdpHJLSDMirre3aCp7tdPr2ucjfV4U1U8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZ0dtYY+oDlLwucql1aC6sy0cTEuCi3fEdRQ4dhwzugjxByCeHGKnflp42Ed7KxaY
	 /Sew4SrSWKD9HTtgtOWPVNdjg9vCJMObMdB8BoVfQPP/9P+PSVVUQgivmI5lt/FyAf
	 bKtztad+76f9XD2tJglys/BBvB3Pt1dKtC8o6gbcmHJQXdVx7jHqs5qEg8U9GWw9kT
	 iyqCDEXc4p9g8yRQSFHFfMv4nYnA8uFOizaq0t7Mao4xPdwfbpG3VTPv+9pZi4bI7D
	 RsVbvd1ayJJ4BUOxGSExeLI6cHpj9Drh7YBIDOn38qIXpuHiOjNg8+7MqVAuYc4d1J
	 IAF25MZJamuuA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:44:43 +0100
Subject: [PATCH v4 6/7] selftests/hid: add tests for hid_bpf_input_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-hid-bpf-new-funcs-v4-6-079c282469d3@kernel.org>
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710513885; l=4246;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lYHlpbXv8wmdpHJLSDMirre3aCp7tdPr2ucjfV4U1U8=;
 b=IIe/kVEZQ/jDRK2mnYLrzNf7zUvgbeEt3ejpPJX82UWsH0HVPIsWT8VFNroSxg7DNnzBPLM7f
 +FeZxznY/E1C+j3MsVXYOul9vrKfmH5SKdVsrwesBLPOJ9SfWllyd1h
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Usual way of testing, we call the function and ensures we receive
the event

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v4

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
2.44.0


