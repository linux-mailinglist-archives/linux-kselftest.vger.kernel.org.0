Return-Path: <linux-kselftest+bounces-4664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C4854FE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6229A1C296DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081585C48;
	Wed, 14 Feb 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2zabjis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10EC83A0D;
	Wed, 14 Feb 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931167; cv=none; b=Fel07LpRkIvN+qR2c8KXIbnqYTQG7ixLeRXJsSgETNX7EcQMe9c+CXZIqn/NZpetbne5523JorV7/sc55isP9CLgqpFeVWLl2EF9GGEiomc3k3YQ9udr1pzHYDAKpWNvrjWbuwouJMOw5Aq5nhM7U7JeSoiE/xvDTnaIJ4aV4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931167; c=relaxed/simple;
	bh=u4iXnzdoA4mM6lNoRPFZIX10P/cAGd0s0q48JL6pfuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=no83B1vawPKCDMI4pTgouGLb5jsI5qgdsacs3sQBYeFfvZ8R6giOAx3MmuNI95rkma+wEZ7IK+7dTgMTQ7Q2zdMf6EpJCFqTdBQgnGXZD31CCqzrji9LNq6LtRrkVU+l+4Xub7QMG9OIXIauWrK8sKULaHuMj80c73Y7ETx6uGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2zabjis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAF9C433C7;
	Wed, 14 Feb 2024 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931166;
	bh=u4iXnzdoA4mM6lNoRPFZIX10P/cAGd0s0q48JL6pfuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H2zabjisaWGRVZESJnRayQZrBXL4OYIm1FeDg8Kl3f3ZNvmQoUxWRp31ewazAudXR
	 x1IZI97KaV9FYL8A6kUuYmRjdLAnYqQbndv0e2JJzNRLjnmPK1sulxf2aYrqcuHPSK
	 /H9BOEEtc3RZJUqS4//rYGU1mS8SrGU/JcXIvOyayj9V5E4G7M+CqM4jHBy4r2TCLy
	 7NFeKF9dYxkGutyhh/lFuUjWyc9cAFmaC0rxWTn8p6e7aSLT3rwyG5wrLZlSLzuhYY
	 ELKD0aLiILzvCZ2X0/i7O1UCARIQ3ABPjtZf7lu4npFgHErBTZyRNb1i80YwCZMa73
	 8Hu3jN17Qc5Hg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 14 Feb 2024 18:18:35 +0100
Subject: [PATCH RFC bpf-next v2 06/10] selftests/hid: Add test for
 hid_bpf_hw_output_report
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hid-bpf-sleepable-v2-6-5756b054724d@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=5125;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=u4iXnzdoA4mM6lNoRPFZIX10P/cAGd0s0q48JL6pfuo=;
 b=t3jtm7WgNcD5AFL7lQvZQ6FGh87fIV2KVForxhXJo9RVtvnzXFEKCRagnTBVfDNMQhLsfHMIR
 7u5OoUszUXjDpODiB5ppJm3/oPLJzSk/N9DEYw4aaVdIH946+gFUjMC
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This time we need to ensure uhid receives it, thus the new mutex and
condition.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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


