Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99397618396
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKCQCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 12:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKCQCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 12:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D53A1B1F5
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667491125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ+Gt0f7T2nBDHQtWdYFlnwx+hGS8wyYXHZUBk23Ajo=;
        b=EzPGOQflPAC4nHjVGpIblpP9AU6pREckI60mSIJkcxMc4XBOYIwE6jxFZaSDHRQPtz+D5x
        oljUuMBpzRNs4/JzM9cjiHWOUEZDIaldFkA8uQxsyLzwTPcq/IjK5gTHF/3saw8lmdfqA8
        hIiToxFI2tT9wHVv9PlfYLQcgqE5Z/0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-Q1ltfYEmNIy2aO95j13a4Q-1; Thu, 03 Nov 2022 11:58:42 -0400
X-MC-Unique: Q1ltfYEmNIy2aO95j13a4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF3901C0A111;
        Thu,  3 Nov 2022 15:58:41 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21F8249BB60;
        Thu,  3 Nov 2022 15:58:40 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v12 12/15] selftests/hid: Add a test for BPF_F_INSERT_HEAD
Date:   Thu,  3 Nov 2022 16:57:53 +0100
Message-Id: <20221103155756.687789-13-benjamin.tissoires@redhat.com>
In-Reply-To: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Insert 3 programs to check that we are doing the correct thing:
'2', '1', '3' are inserted, but '1' is supposed to be executed first.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v12:
- use __u8 instead of u8 in hid_bpf.c
- do not rely on uapi for HIF_BPF_FLAGS_*

changes in v11:
- use the new facility from selftests/hid

no changes in v10

no changes in v9

no changes in v8

no changes in v7

changes in v6:
- fixed copy/paste in ASSERT_OK and test execution order

changes in v5:
- use the new API

not in v4

changes in v3:
- use the new hid_get_data API

new in v2

fix test attach_flags
---
 tools/testing/selftests/hid/hid_bpf.c   | 43 +++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c | 55 ++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index eb329b5d299f..6615c26fb5dd 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -88,6 +88,7 @@ struct attach_prog_args {
 	int prog_fd;
 	unsigned int hid;
 	int retval;
+	int insert_head;
 };
 
 struct hid_hw_request_syscall_args {
@@ -490,6 +491,7 @@ FIXTURE_SETUP(hid_bpf)
 
 struct test_program {
 	const char *name;
+	int insert_head;
 };
 #define LOAD_PROGRAMS(progs) \
 	load_programs(progs, ARRAY_SIZE(progs), _metadata, self, variant)
@@ -539,6 +541,7 @@ static void load_programs(const struct test_program programs[],
 
 		args.prog_fd = bpf_program__fd(prog);
 		args.hid = self->hid_id;
+		args.insert_head = programs[i].insert_head;
 		err = bpf_prog_test_run_opts(attach_fd, &tattr);
 		ASSERT_OK(args.retval) TH_LOG("attach_hid(%s): %d", programs[i].name, args.retval);
 	}
@@ -740,6 +743,46 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 	ASSERT_EQ(args.data[1], 2);
 }
 
+/*
+ * Attach hid_insert{0,1,2} to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the programs have been inserted in the correct order.
+ */
+TEST_F(hid_bpf, test_hid_attach_flags)
+{
+	const struct test_program progs[] = {
+		{
+			.name = "hid_test_insert2",
+			.insert_head = 0,
+		},
+		{
+			.name = "hid_test_insert1",
+			.insert_head = 1,
+		},
+		{
+			.name = "hid_test_insert3",
+			.insert_head = 0,
+		},
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* inject one event */
+	buf[0] = 1;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[1], 1);
+	ASSERT_EQ(buf[2], 2);
+	ASSERT_EQ(buf[3], 3);
+}
+
 /*
  * Attach hid_rdesc_fixup to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 5758366a90e6..6a86af0aa545 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -11,6 +11,7 @@ struct attach_prog_args {
 	int prog_fd;
 	unsigned int hid;
 	int retval;
+	int insert_head;
 };
 
 __u64 callback_check = 52;
@@ -49,7 +50,8 @@ int attach_prog(struct attach_prog_args *ctx)
 {
 	ctx->retval = hid_bpf_attach_prog(ctx->hid,
 					  ctx->prog_fd,
-					  0);
+					  ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :
+							     HID_BPF_FLAG_NONE);
 	return 0;
 }
 
@@ -141,3 +143,54 @@ int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
 
 	return sizeof(rdesc) + 73;
 }
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* we need to be run first */
+	if (data[2] || data[3])
+		return -1;
+
+	data[1] = 1;
+
+	return 0;
+}
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_test_insert2, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* after insert0 and before insert2 */
+	if (!data[1] || data[3])
+		return -1;
+
+	data[2] = 2;
+
+	return 0;
+}
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* at the end */
+	if (!data[1] || !data[2])
+		return -1;
+
+	data[3] = 3;
+
+	return 0;
+}
-- 
2.36.1

