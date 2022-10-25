Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DD960C84F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiJYJgF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiJYJfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDEB100BDB
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TpbgNcrLQg8txBsUUaYzs/Vlq7YdZrtaeFNot3mLLo=;
        b=jEh0o9XrnZTLlnFEyeUMMYRGwJW2u7PhTz1Efs7XNLPW7m4NbVhutPEFPDFHYLNzdUvG52
        Y0cDCM76MpGWperTXk+Aq4Yn1+3vMcfz1q7uHtsosLGEvuAQ3xNSgDGfgsLqIWytUU/hxB
        cMEi6TaqWzJoRd5N4gTPfnm6AeSqY38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-bd5BeAJePe2jbnqRx0_ELQ-1; Tue, 25 Oct 2022 05:35:16 -0400
X-MC-Unique: bd5BeAJePe2jbnqRx0_ELQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB69C185A78F;
        Tue, 25 Oct 2022 09:35:15 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9A4492CA2;
        Tue, 25 Oct 2022 09:35:14 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 06/14] selftests/hid: add test to change the report size
Date:   Tue, 25 Oct 2022 11:34:50 +0200
Message-Id: <20221025093458.457089-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use a different report with a bigger size and ensures we are doing
things properly.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v11:
- use the new facility from selftests/hid

no changes in v10

no changes in v9

no changes in v8

no changes in v7

no changes in v6

new in v5
---
 tools/testing/selftests/hid/hid_bpf.c   | 41 +++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c | 15 ++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 3012fb95e6fc..a6daaadccfb5 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -23,6 +23,17 @@ static unsigned char rdesc[] = {
 	0xa1, 0x01,		/* COLLECTION (Application) */
 	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
 	0xa1, 0x00,			/* COLLECTION (Physical) */
+	0x85, 0x02,				/* REPORT_ID (2) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x08,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0xff,				/* LOGICAL_MAXIMUM (255) */
+	0x95, 0x08,				/* REPORT_COUNT (8) */
+	0x75, 0x08,				/* REPORT_SIZE (8) */
+	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
+	0xc0,				/* END_COLLECTION */
+	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
+	0xa1, 0x00,			/* COLLECTION (Physical) */
 	0x85, 0x01,				/* REPORT_ID (1) */
 	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
 	0x19, 0x01,				/* USAGE_MINIMUM (1) */
@@ -646,6 +657,36 @@ TEST_F(hid_bpf, test_attach_detach)
 	ASSERT_EQ(buf[2], 47);
 }
 
+/*
+ * Attach hid_change_report_id to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can change the data
+ */
+TEST_F(hid_bpf, test_hid_change_report)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_change_report_id" },
+	};
+	u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 9) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 42);
+	ASSERT_EQ(buf[2], 0) TH_LOG("leftovers_from_previous_test");
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index fc0a4241643a..ee7529c47ad8 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -32,7 +32,20 @@ int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
 
 	rw_data[2] = rw_data[1] + 5;
 
-	return 0;
+	return hid_ctx->size;
+}
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_change_report_id, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
+
+	if (!rw_data)
+		return 0; /* EPERM check */
+
+	rw_data[0] = 2;
+
+	return 9;
 }
 
 SEC("syscall")
-- 
2.36.1

