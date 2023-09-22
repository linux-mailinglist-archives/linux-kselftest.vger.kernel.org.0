Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B737AB15B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjIVLz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVLz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 07:55:29 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 04:55:22 PDT
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 417FF102
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3ECeT
        ms73oQ314eFlcWNV/9g/AX5Sa2AGwed/TGeJzQ=; b=PH9xk2/jjyBQuf7l4OAqB
        MB805uh5MZPSLJyxc4bd4VBTD1qbgGYIS0rHSkj1g77JsOjE9kknuIcWaCyPd7sr
        cOEkgBY8QosoiBGRTQ5xD7BUY2nuXFLwR4Tgjtj7oIA+l3Y+Gu6ZFJrVVq8u7WOQ
        4Wg7yGpq9LXirChmyvCIxE=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wBXb+7ufA1lBbMoCw--.11211S4;
        Fri, 22 Sep 2023 19:39:37 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v2] list: test: potential dereference of null pointer
Date:   Fri, 22 Sep 2023 19:39:23 +0800
Message-Id: <20230922113923.3621959-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXb+7ufA1lBbMoCw--.11211S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWkJw47Ary3AFy3GFWUtwb_yoWfXrg_Za
        4xAr1kWr1kJFZ7tF98AF48Z34qyws7ZFn2vF93tryfGFyUuwnak34Yvr4rA3y3WryfC39F
        krs7Cr17G3WDCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMeHqJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRDyC2B9oN+wbwAAsB
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid the failure of alloc, we could check the return value of
kmalloc() and kzalloc().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 lib/list-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 0cc27de9cec8..70e898976dbf 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -27,9 +27,18 @@ static void list_test_list_init(struct kunit *test)
 	INIT_LIST_HEAD(&list2);
 
 	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	if (!list4) {
+		KUNIT_FAIL(test, "Initialising list4 failed.\n");
+		return;
+	}
 	INIT_LIST_HEAD(list4);
 
 	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	if (!list5) {
+		kfree(list4);
+		KUNIT_FAIL(test, "Initialising list5 failed.\n");
+		return;
+	}
 	memset(list5, 0xFF, sizeof(*list5));
 	INIT_LIST_HEAD(list5);
 
-- 
2.37.2

