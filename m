Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6C61837B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 17:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiKCQBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiKCQBI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 12:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC81B1D5
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667491120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tCNK0UeoKQBPhiAGZt8SXAYU5K9Oj/kDqj8STM9dwI=;
        b=KjvCBl7Bl4NN20aFZLFo29ntqx8qAaq0cVv6YZc3VV03e08h+SK3tfuTO4qa+ch+W5ZcU9
        WimEzWuCQs04mMt/eHgrIu+36kDcpVwtSrhM7JIP6W6rL7/uR7WngVeE3DImhoXmcyBmIt
        NCN5YBS0L1ZN9Ye1M38UlbrtydDSBlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-WjXVIvoZP2aHHzsckiaDiw-1; Thu, 03 Nov 2022 11:58:37 -0400
X-MC-Unique: WjXVIvoZP2aHHzsckiaDiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 195A6800B23;
        Thu,  3 Nov 2022 15:58:36 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 701594A9254;
        Thu,  3 Nov 2022 15:58:34 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v12 09/15] selftests/hid: add tests for bpf_hid_hw_request
Date:   Thu,  3 Nov 2022 16:57:50 +0100
Message-Id: <20221103155756.687789-10-benjamin.tissoires@redhat.com>
In-Reply-To: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

changes in v12:
- use __u8 instead of u8 in hid_bpf.c

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
 tools/testing/selftests/hid/hid_bpf.c         | 56 ++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c       | 36 ++++++++++++
 .../selftests/hid/progs/hid_bpf_helpers.h     |  7 +++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 6c1f43ec4bdd..f77ee7fe4af4 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -82,12 +82,23 @@ static unsigned char rdesc[] = {
 	0xc0,			/* END_COLLECTION */
 };
 
+static __u8 feature_data[] = { 1, 2 };
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
 
@@ -155,7 +166,7 @@ static void uhid_destroy(struct __test_metadata *_metadata, int fd)
 
 static int uhid_event(struct __test_metadata *_metadata, int fd)
 {
-	struct uhid_event ev;
+	struct uhid_event ev, answer;
 	ssize_t ret;
 
 	memset(&ev, 0, sizeof(ev));
@@ -196,6 +207,15 @@ static int uhid_event(struct __test_metadata *_metadata, int fd)
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
@@ -686,6 +706,40 @@ TEST_F(hid_bpf, test_hid_change_report)
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
index b69c3f8e1ac3..7e35bb8e1abf 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -52,3 +52,39 @@ int attach_prog(struct attach_prog_args *ctx)
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
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index b9fa33f7d580..4fff31dbe0e7 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -10,5 +10,12 @@ extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
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
 
 #endif /* __HID_BPF_HELPERS_H */
-- 
2.36.1

