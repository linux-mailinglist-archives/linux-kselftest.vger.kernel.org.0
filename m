Return-Path: <linux-kselftest+bounces-5194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF385E341
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC83E1C22BD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571E8563A;
	Wed, 21 Feb 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a534VnN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5182C71;
	Wed, 21 Feb 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532773; cv=none; b=HzNFrCHgQ3rZKIyBTVJ49XcC4wAEhHpBX5SXVEpsfUXjmbPStfVw97Giz5ol3LCyIXh+xPnlalhKbgX2M2dshgK6zuizR2eBsHH/WIc/qXegyMpU93zvk6HJQu26a9XZQCiLhWenzLMbkN8jETtBtE1JTrXHOW9/L2Qui7cr5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532773; c=relaxed/simple;
	bh=n/qD1PdO7BQm/8CDbkc4TE5R/ZFI6LEuZyfg0DJrltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+0m+IYef1rlp8hN44YX0W+7hxGFI50kRVX8WNhKmn15eaQGZfNftu9GdG4CW72/zLYizh25QoyzvmKpfCJObS3cfgcJx9ZryIMNbhJfPrS4X3XWtbR6a5kQcUCJqZwuxmzu18aP4+PNB78QPVjJKqabcQyLV1OtEZ7X0aoW7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a534VnN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F76C43394;
	Wed, 21 Feb 2024 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532773;
	bh=n/qD1PdO7BQm/8CDbkc4TE5R/ZFI6LEuZyfg0DJrltg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a534VnN2cGSeFyzIcpebXICpan9hM8BisFiN8Ia4R6qcDOpuI8hWiXFnGuh15mhIU
	 v6YJ3ZeRpzN014bN/T49uchEN9LFhfVMFAiLFnakh2WBJHvm0xPv8Tb7h8v2xrNspW
	 8ovrEsiWZY0z3spVITTJagkodApH2PdybEIB2ZOF1ye04D2sohxKrU2sV0VMlXEPdj
	 GxlHhEzoQPAcfVz/Jsoxl63PjfuWfQlVPvv4+Pd0ITwaboWI/hrqez/ptrJhcMp3F5
	 ihNpBR0dRfG/xzOdaOo7l8JVNqipf90mBgmDwqySc4xC4nNapFZKYXt4jQfzijjGa0
	 3AoWzog+4TTnw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:27 +0100
Subject: [PATCH RFC bpf-next v3 11/16] selftests/hid: Add test for
 hid_bpf_hw_output_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-11-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=5145;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=n/qD1PdO7BQm/8CDbkc4TE5R/ZFI6LEuZyfg0DJrltg=;
 b=uTCXux7/N75Sc+Frx3otA1/fe9LmjEsIOavqXLV3OMI6U7KGkj3LyXgOs88x3SdDjw/HhGEyQ
 UkoVASZtZvKAkzP928AWaaJ4HroRpVImDKaTaGgD9Ypa9EM7wGx5K6M
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This time we need to ensure uhid receives it, thus the new mutex and
condition.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c              | 63 ++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 24 +++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  2 +
 3 files changed, 89 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 2cf96f818f25..8332014838b0 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -16,6 +16,11 @@
 
 #define SHOW_UHID_DEBUG 0
 
+#define min(a, b) \
+	({ __typeof__(a) _a = (a); \
+	__typeof__(b) _b = (b); \
+	_a < _b ? _a : _b; })
+
 static unsigned char rdesc[] = {
 	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
 	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
@@ -111,6 +116,10 @@ struct hid_hw_request_syscall_args {
 static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
 
+static pthread_mutex_t uhid_output_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t uhid_output_cond = PTHREAD_COND_INITIALIZER;
+static unsigned char output_report[10];
+
 /* no need to protect uhid_stopped, only one thread accesses it */
 static bool uhid_stopped;
 
@@ -205,6 +214,13 @@ static int uhid_event(struct __test_metadata *_metadata, int fd)
 		break;
 	case UHID_OUTPUT:
 		UHID_LOG("UHID_OUTPUT from uhid-dev");
+
+		pthread_mutex_lock(&uhid_output_mtx);
+		memcpy(output_report,
+		       ev.u.output.data,
+		       min(ev.u.output.size, sizeof(output_report)));
+		pthread_cond_signal(&uhid_output_cond);
+		pthread_mutex_unlock(&uhid_output_mtx);
 		break;
 	case UHID_GET_REPORT:
 		UHID_LOG("UHID_GET_REPORT from uhid-dev");
@@ -733,6 +749,53 @@ TEST_F(hid_bpf, test_hid_change_report)
 	ASSERT_EQ(buf[2], 0) TH_LOG("leftovers_from_previous_test");
 }
 
+/*
+ * Call hid_bpf_hw_output_report against the given uhid device,
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_user_output_report_call)
+{
+	struct hid_hw_request_syscall_args args = {
+		.retval = -1,
+		.size = 10,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+	int err, cond_err, prog_fd;
+	struct timespec time_to_wait;
+
+	LOAD_BPF;
+
+	args.hid = self->hid_id;
+	args.data[0] = 1; /* report ID */
+	args.data[1] = 2; /* report ID */
+	args.data[2] = 42; /* report ID */
+
+	prog_fd = bpf_program__fd(self->skel->progs.hid_user_output_report);
+
+	pthread_mutex_lock(&uhid_output_mtx);
+
+	memset(output_report, 0, sizeof(output_report));
+	clock_gettime(CLOCK_REALTIME, &time_to_wait);
+	time_to_wait.tv_sec += 2;
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+	cond_err = pthread_cond_timedwait(&uhid_output_cond, &uhid_output_mtx, &time_to_wait);
+
+	ASSERT_OK(err) TH_LOG("error while calling bpf_prog_test_run_opts");
+	ASSERT_OK(cond_err) TH_LOG("error while calling waiting for the condition");
+
+	ASSERT_EQ(args.retval, 3);
+
+	ASSERT_EQ(output_report[0], 1);
+	ASSERT_EQ(output_report[1], 2);
+	ASSERT_EQ(output_report[2], 42);
+
+	pthread_mutex_unlock(&uhid_output_mtx);
+}
+
 /*
  * Attach hid_user_raw_request to the given uhid device,
  * call the bpf program from userspace
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 1e558826b809..2c2b679a83b1 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -101,6 +101,30 @@ int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
 	return 0;
 }
 
+SEC("syscall")
+int hid_user_output_report(struct hid_hw_request_syscall_args *args)
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
+	ret = hid_bpf_hw_output_report(ctx,
+				       args->data,
+				       size);
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
index 65e657ac1198..50c6a0d5765e 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -94,5 +94,7 @@ extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
 			      size_t buf__sz,
 			      enum hid_report_type type,
 			      enum hid_class_request reqtype) __ksym;
+extern int hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx,
+				    __u8 *buf, size_t buf__sz) __ksym;
 
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.43.0


