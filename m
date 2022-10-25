Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BDE60C84E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJYJgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiJYJfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678DF986C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvftHeHNcOf08pZv57LiQDWcQo1a9iOMgED/XOW2Ols=;
        b=ZaP6wLr8G6xHXQhDYdEn/pWYOO0QCUjgENCrOzT8lQDseubtiBTfY6ZTuwrEJB+TqZBjol
        us1WGvn4KQnNbZhg4fU4fg/Q82bF7ob6YL68TchoQ5vzCyCdFH5h+BGQ+rl0tbRQzV2nV3
        +0pbA4hOK7DkHO68jwIw9fEYrOEiCuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-h-Yn7lLqN3WrM13r2N4ehg-1; Tue, 25 Oct 2022 05:35:20 -0400
X-MC-Unique: h-Yn7lLqN3WrM13r2N4ehg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D41811E75;
        Tue, 25 Oct 2022 09:35:20 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CBE9492CA2;
        Tue, 25 Oct 2022 09:35:18 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 08/14] selftests/hid: add tests for bpf_hid_hw_request
Date:   Tue, 25 Oct 2022 11:34:52 +0200
Message-Id: <20221025093458.457089-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

changes in v11:
- use the new facility from selftests/hid

no changes in v10

no changes in v9

no changes in v8

no changes in v7

changes in v6:
- fixed copy/paste in prog_tests when calling ASSERT_OK
- removed the need for memcpy now that kfuncs can access ctx

changes in v5:
- use the new hid_bpf_allocate_context() API
- remove the need for ctx_in for syscall TEST_RUN

changes in v3:
- use the new hid_get_data API
- directly use HID_FEATURE_REPORT and HID_REQ_GET_REPORT from uapi

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 tools/testing/selftests/hid/hid_bpf.c   | 56 ++++++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c | 43 +++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index a6daaadccfb5..7cd976b469b7 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -83,12 +83,23 @@ static unsigned char rdesc[] = {
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
 #define ASSERT_OK(data) ASSERT_FALSE(data)
 #define ASSERT_OK_PTR(ptr) ASSERT_NE(NULL, ptr)
 
@@ -156,7 +167,7 @@ static void uhid_destroy(struct __test_metadata *_metadata, int fd)
 
 static int uhid_event(struct __test_metadata *_metadata, int fd)
 {
-	struct uhid_event ev;
+	struct uhid_event ev, answer;
 	ssize_t ret;
 
 	memset(&ev, 0, sizeof(ev));
@@ -197,6 +208,15 @@ static int uhid_event(struct __test_metadata *_metadata, int fd)
 		break;
 	case UHID_GET_REPORT:
 		UHID_LOG("UHID_GET_REPORT from uhid-dev");
+
+		answer.type = UHID_GET_REPORT_REPLY;
+		answer.u.get_report_reply.id = ev.u.get_report.id;
+		answer.u.get_report_reply.err = ev.u.get_report.rnum == 1 ? 0 : -EIO;
+		answer.u.get_report_reply.size = sizeof(feature_data);
+		memcpy(answer.u.get_report_reply.data, feature_data, sizeof(feature_data));
+
+		uhid_write(_metadata, fd, &answer);
+
 		break;
 	case UHID_SET_REPORT:
 		UHID_LOG("UHID_SET_REPORT from uhid-dev");
@@ -687,6 +707,40 @@ TEST_F(hid_bpf, test_hid_change_report)
 	ASSERT_EQ(buf[2], 0) TH_LOG("leftovers_from_previous_test");
 }
 
+/*
+ * Attach hid_user_raw_request to the given uhid device,
+ * call the bpf program from userspace
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_user_raw_request_call)
+{
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
+	int err, prog_fd;
+
+	LOAD_BPF;
+
+	args.hid = self->hid_id;
+	args.data[0] = 1; /* report ID */
+
+	prog_fd = bpf_program__fd(self->skel->progs.hid_user_raw_request);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+	ASSERT_OK(err) TH_LOG("error while calling bpf_prog_test_run_opts");
+
+	ASSERT_EQ(args.retval, 2);
+
+	ASSERT_EQ(args.data[1], 2);
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index ee7529c47ad8..fde76f63927b 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -10,6 +10,13 @@ extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
 			      const size_t __sz) __ksym;
 extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
+extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
+extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
+			      __u8 *data,
+			      size_t buf__sz,
+			      enum hid_report_type type,
+			      enum hid_class_request reqtype) __ksym;
 
 struct attach_prog_args {
 	int prog_fd;
@@ -56,3 +63,39 @@ int attach_prog(struct attach_prog_args *ctx)
 					  0);
 	return 0;
 }
+
+struct hid_hw_request_syscall_args {
+	/* data needs to come at offset 0 so we can use it in calls */
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
+	ret = hid_bpf_hw_request(ctx,
+				 args->data,
+				 size,
+				 args->type,
+				 args->request_type);
+	args->retval = ret;
+
+	hid_bpf_release_context(ctx);
+
+	return 0;
+}
-- 
2.36.1

