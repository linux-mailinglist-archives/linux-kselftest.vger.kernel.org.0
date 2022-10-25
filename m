Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D518860C867
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiJYJhB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiJYJgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55674103272
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZFCOV+iQMD38Sz/86soYzk1fmjxLoiOzEXcv1GrreU=;
        b=TQZyMLDVDxHnSPQ0eFJ9yzBclj1Xx8li+Jklz60GUOCRHM+M6oKII28DyTd8Lb1yoasQ8v
        VfjRAcJH7AKWalGVognYCfRlcEykIH9GwjwyK9/S0yrip6r1KGLYv28ysbHTgBvWPUMNbF
        xF8Fc/LJpnbC0FNVou/bGRCKrLa7dZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-ocSb-t8-MNm5EHq9P0nGfA-1; Tue, 25 Oct 2022 05:35:25 -0400
X-MC-Unique: ocSb-t8-MNm5EHq9P0nGfA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05335833A09;
        Tue, 25 Oct 2022 09:35:25 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC13492CA4;
        Tue, 25 Oct 2022 09:35:23 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 10/14] selftests/hid: add report descriptor fixup tests
Date:   Tue, 25 Oct 2022 11:34:54 +0200
Message-Id: <20221025093458.457089-11-benjamin.tissoires@redhat.com>
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

Simple report descriptor override in HID: replace part of the report
descriptor from a static definition in the bpf kernel program.

Note that this test should be run last because we disconnect/reconnect
the device, meaning that it changes the overall uhid device.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v11:
- use the new facility from selftests/hid

no changes in v10

no changes in v9

no changes in v8

no changes in v7

no changes in v6

changes in v5:
- amended for the new API

not in v4

changes in v3:
- added a comment to mention that this test needs to be run last

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 tools/testing/selftests/hid/hid_bpf.c   | 32 +++++++++++++++
 tools/testing/selftests/hid/progs/hid.c | 53 +++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 7cd976b469b7..fc2ad0443803 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -741,6 +741,38 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 	ASSERT_EQ(args.data[1], 2);
 }
 
+/*
+ * Attach hid_rdesc_fixup to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * check that the hidraw report descriptor has been updated.
+ */
+TEST_F(hid_bpf, test_rdesc_fixup)
+{
+	struct hidraw_report_descriptor rpt_desc = {0};
+	const struct test_program progs[] = {
+		{ .name = "hid_rdesc_fixup" },
+	};
+	int err, desc_size;
+
+	LOAD_PROGRAMS(progs);
+
+	/* check that hid_rdesc_fixup() was executed */
+	ASSERT_EQ(self->skel->data->callback2_check, 0x21);
+
+	/* read the exposed report descriptor from hidraw */
+	err = ioctl(self->hidraw_fd, HIDIOCGRDESCSIZE, &desc_size);
+	ASSERT_GE(err, 0) TH_LOG("error while reading HIDIOCGRDESCSIZE: %d", err);
+
+	/* ensure the new size of the rdesc is bigger than the old one */
+	ASSERT_GT(desc_size, sizeof(rdesc));
+
+	rpt_desc.size = desc_size;
+	err = ioctl(self->hidraw_fd, HIDIOCGRDESC, &rpt_desc);
+	ASSERT_GE(err, 0) TH_LOG("error while reading HIDIOCGRDESC: %d", err);
+
+	ASSERT_EQ(rpt_desc.value[4], 0x42);
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index fde76f63927b..815ff94321c9 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -99,3 +99,56 @@ int hid_user_raw_request(struct hid_hw_request_syscall_args *args)
 
 	return 0;
 }
+
+static const __u8 rdesc[] = {
+	0x05, 0x01,				/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x32,				/* USAGE (Z) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x81, 0x06,				/* INPUT (Data,Var,Rel) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x91, 0x02,				/* Output (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x06,				/* USAGE_MINIMUM (6) */
+	0x29, 0x08,				/* USAGE_MAXIMUM (8) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0xb1, 0x02,				/* Feature (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0xc0,				/* END_COLLECTION */
+	0xc0,			/* END_COLLECTION */
+};
+
+SEC("?fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	callback2_check = data[4];
+
+	/* insert rdesc at offset 73 */
+	__builtin_memcpy(&data[73], rdesc, sizeof(rdesc));
+
+	/* Change Usage Vendor globally */
+	data[4] = 0x42;
+
+	return sizeof(rdesc) + 73;
+}
-- 
2.36.1

