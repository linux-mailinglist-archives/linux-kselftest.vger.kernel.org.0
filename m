Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295D052C548
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbiERVCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiERVBG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 17:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57D63259F86
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652907635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gC0dx605l5WeGGnTBbF9J16eadz0PSMt0gS7tJITGSE=;
        b=Rwa0Pdlr8KsOTUrI5dMpYjbwjwZprevClEQZj0nsmJ1luBFhkXql32IrZZZDbKNVZjYcX/
        pI2pUpW+4LSymx4Ul0k4YWbCnVQNFe+PlZqG+DKkg/X3GgMl14hEh+wKvfvGDQTM4inbdK
        U66k27ZBrjr/MwymJUGiyhrAQfmTtEc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-pVi_G_J8Nyy_ic7mB6udZg-1; Wed, 18 May 2022 17:00:29 -0400
X-MC-Unique: pVi_G_J8Nyy_ic7mB6udZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB9E8381078F;
        Wed, 18 May 2022 21:00:27 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94DB82166B25;
        Wed, 18 May 2022 21:00:18 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH bpf-next v5 12/17] selftests/bpf: add tests for bpf_hid_hw_request
Date:   Wed, 18 May 2022 22:59:19 +0200
Message-Id: <20220518205924.399291-13-benjamin.tissoires@redhat.com>
In-Reply-To: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
References: <20220518205924.399291-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for the newly implemented function.
We test here only the GET_REPORT part because the other calls are pure
HID protocol and won't infer the result of the test of the bpf hook.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v5:
- use the new hid_bpf_allocate_context() API
- remove the need for ctx_in for syscall TEST_RUN

changes in v3:
- use the new hid_get_data API
- directly use HID_FEATURE_REPORT and HID_REQ_GET_REPORT from uapi

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 tools/testing/selftests/bpf/prog_tests/hid.c | 114 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/hid.c      |  59 ++++++++++
 2 files changed, 155 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/hid.c b/tools/testing/selftests/bpf/prog_tests/hid.c
index 47bc0a30c275..54c0a0fcd54d 100644
--- a/tools/testing/selftests/bpf/prog_tests/hid.c
+++ b/tools/testing/selftests/bpf/prog_tests/hid.c
@@ -77,12 +77,23 @@ static unsigned char rdesc[] = {
 	0xc0,			/* END_COLLECTION */
 };
 
+static u8 feature_data[] = { 1, 2 };
+
 struct attach_prog_args {
 	int prog_fd;
 	unsigned int hid;
 	int retval;
 };
 
+struct hid_hw_request_syscall_args {
+	__u8 data[10];
+	unsigned int hid;
+	int retval;
+	size_t size;
+	enum hid_report_type type;
+	__u8 request_type;
+};
+
 static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
 
@@ -142,7 +153,7 @@ static void destroy(int fd)
 
 static int uhid_event(int fd)
 {
-	struct uhid_event ev;
+	struct uhid_event ev, answer;
 	ssize_t ret;
 
 	memset(&ev, 0, sizeof(ev));
@@ -183,6 +194,15 @@ static int uhid_event(int fd)
 		break;
 	case UHID_GET_REPORT:
 		fprintf(stderr, "UHID_GET_REPORT from uhid-dev\n");
+
+		answer.type = UHID_GET_REPORT_REPLY;
+		answer.u.get_report_reply.id = ev.u.get_report.id;
+		answer.u.get_report_reply.err = ev.u.get_report.rnum == 1 ? 0 : -EIO;
+		answer.u.get_report_reply.size = sizeof(feature_data);
+		memcpy(answer.u.get_report_reply.data, feature_data, sizeof(feature_data));
+
+		uhid_write(fd, &answer);
+
 		break;
 	case UHID_SET_REPORT:
 		fprintf(stderr, "UHID_SET_REPORT from uhid-dev\n");
@@ -391,6 +411,7 @@ static int open_hidraw(int dev_id)
 struct test_params {
 	struct hid *skel;
 	int hidraw_fd;
+	int hid_id;
 };
 
 static int prep_test(int dev_id, const char *prog_name, struct test_params *test_data)
@@ -419,27 +440,33 @@ static int prep_test(int dev_id, const char *prog_name, struct test_params *test
 	if (!ASSERT_OK_PTR(hid_skel, "hid_skel_open"))
 		goto cleanup;
 
-	prog = bpf_object__find_program_by_name(*hid_skel->skeleton->obj, prog_name);
-	if (!ASSERT_OK_PTR(prog, "find_prog_by_name"))
-		goto cleanup;
+	if (prog_name) {
+		prog = bpf_object__find_program_by_name(*hid_skel->skeleton->obj, prog_name);
+		if (!ASSERT_OK_PTR(prog, "find_prog_by_name"))
+			goto cleanup;
 
-	bpf_program__set_autoload(prog, true);
+		bpf_program__set_autoload(prog, true);
 
-	err = hid__load(hid_skel);
-	if (!ASSERT_OK(err, "hid_skel_load"))
-		goto cleanup;
+		err = hid__load(hid_skel);
+		if (!ASSERT_OK(err, "hid_skel_load"))
+			goto cleanup;
 
-	attach_fd = bpf_program__fd(hid_skel->progs.attach_prog);
-	if (!ASSERT_GE(attach_fd, 0, "locate attach_prog")) {
-		err = attach_fd;
-		goto cleanup;
-	}
+		attach_fd = bpf_program__fd(hid_skel->progs.attach_prog);
+		if (!ASSERT_GE(attach_fd, 0, "locate attach_prog")) {
+			err = attach_fd;
+			goto cleanup;
+		}
 
-	args.prog_fd = bpf_program__fd(prog);
-	err = bpf_prog_test_run_opts(attach_fd, &tattr);
-	snprintf(buf, sizeof(buf), "attach_hid(%s)", prog_name);
-	if (!ASSERT_EQ(args.retval, 0, buf))
-		goto cleanup;
+		args.prog_fd = bpf_program__fd(prog);
+		err = bpf_prog_test_run_opts(attach_fd, &tattr);
+		snprintf(buf, sizeof(buf), "attach_hid(%s)", prog_name);
+		if (!ASSERT_EQ(args.retval, 0, buf))
+			goto cleanup;
+	} else {
+		err = hid__load(hid_skel);
+		if (!ASSERT_OK(err, "hid_skel_load"))
+			goto cleanup;
+	}
 
 	hidraw_fd = open_hidraw(dev_id);
 	if (!ASSERT_GE(hidraw_fd, 0, "open_hidraw"))
@@ -447,6 +474,7 @@ static int prep_test(int dev_id, const char *prog_name, struct test_params *test
 
 	test_data->skel = hid_skel;
 	test_data->hidraw_fd = hidraw_fd;
+	test_data->hid_id = hid_id;
 
 	return 0;
 
@@ -693,6 +721,54 @@ static int test_hid_change_report(int uhid_fd, int dev_id)
 	return ret;
 }
 
+/*
+ * Attach hid_user_raw_request to the given uhid device,
+ * call the bpf program from userspace
+ * check that the program is called and does the expected.
+ */
+static int test_hid_user_raw_request_call(int uhid_fd, int dev_id)
+{
+	struct test_params params;
+	int err, prog_fd;
+	int ret = -1;
+	struct hid_hw_request_syscall_args args = {
+		.retval = -1,
+		.type = HID_FEATURE_REPORT,
+		.request_type = HID_REQ_GET_REPORT,
+		.size = 10,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+
+	err = prep_test(dev_id, NULL, &params);
+	if (!ASSERT_EQ(err, 0, "prep_test()"))
+		goto cleanup;
+
+	args.hid = params.hid_id;
+	args.data[0] = 1; /* report ID */
+
+	prog_fd = bpf_program__fd(params.skel->progs.hid_user_raw_request);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+	if (!ASSERT_EQ(err, 0, "bpf_prog_test_run_opts"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(args.retval, 2, "bpf_prog_test_run_opts_retval"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(args.data[1], 2, "hid_user_raw_request_check_in"))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	cleanup_test(&params);
+
+	return ret;
+}
+
 void serial_test_hid_bpf(void)
 {
 	int err, uhid_fd;
@@ -720,6 +796,8 @@ void serial_test_hid_bpf(void)
 	ASSERT_OK(err, "hid_attach_detach");
 	err = test_hid_change_report(uhid_fd, dev_id);
 	ASSERT_OK(err, "hid_change_report");
+	err = test_hid_user_raw_request_call(uhid_fd, dev_id);
+	ASSERT_OK(err, "hid_change_report");
 
 	destroy(uhid_fd);
 
diff --git a/tools/testing/selftests/bpf/progs/hid.c b/tools/testing/selftests/bpf/progs/hid.c
index ee7529c47ad8..e3444d444303 100644
--- a/tools/testing/selftests/bpf/progs/hid.c
+++ b/tools/testing/selftests/bpf/progs/hid.c
@@ -10,6 +10,13 @@ extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
 			      const size_t __sz) __ksym;
 extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
+extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
+extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
+			      __u8 *data,
+			      size_t len,
+			      enum hid_report_type type,
+			      int reqtype) __ksym;
 
 struct attach_prog_args {
 	int prog_fd;
@@ -56,3 +63,55 @@ int attach_prog(struct attach_prog_args *ctx)
 					  0);
 	return 0;
 }
+
+struct hid_hw_request_syscall_args {
+	/* data needs to come at offset 0 so we can do a memcpy into it */
+	__u8 data[10];
+	unsigned int hid;
+	int retval;
+	size_t size;
+	enum hid_report_type type;
+	__u8 request_type;
+};
+
+SEC("syscall")
+int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
+{
+	struct hid_bpf_ctx *ctx;
+	int i, ret = 0;
+	__u8 *data;
+
+	ctx = hid_bpf_allocate_context(args->hid);
+	if (!ctx)
+		return 0; /* EPERM check */
+
+	/* We can not use the context data memory directly in the hid_bpf call,
+	 * so we rely on the PTR_TO_MEM allocated in the hid_bpf_context
+	 */
+	data = hid_bpf_get_data(ctx, 0 /* offset */, 10 /* size */);
+	if (!data)
+		goto out; /* EPERM check */
+
+	__builtin_memcpy(data, args->data, sizeof(args->data));
+
+	if (args->size <= sizeof(args->data)) {
+		ret = hid_bpf_hw_request(ctx,
+					 data,
+					 args->size,
+					 args->type,
+					 args->request_type);
+		args->retval = ret;
+		if (ret < 0)
+			goto out;
+	} else {
+		ret = -7; /* -E2BIG */
+		goto out;
+	}
+
+	__builtin_memcpy(args->data, data, sizeof(args->data));
+
+ out:
+	hid_bpf_release_context(ctx);
+
+	return ret;
+}
-- 
2.36.1

