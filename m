Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C377ABCDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Sep 2023 02:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjIWAzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 20:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjIWAzV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 20:55:21 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58693B9;
        Fri, 22 Sep 2023 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iDdID
        +mUbQqXmzWzgfAKYDj+iqF4rEcFDTg8Favomh0=; b=O/v7DGkp6qzTXQG7g2Rlf
        ux+K1pd8QCc3utMyeaub9ITi6//M9FuwEQpbB2wJKNx/KwFrwjDGwACyUOk2l8hL
        2bFWHEYhDqWjRJuni8KrDzk+QsOM3IPEXUbRSjZEuGem4iu9Z7MJtATKNuH7qnB+
        X9WvAdWFgplnnv9Vg/m39c=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wCnzvMuNw5lHGodBA--.12688S4;
        Sat, 23 Sep 2023 08:54:17 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v3] list: test: potential dereference of null pointer
Date:   Sat, 23 Sep 2023 08:54:04 +0800
Message-Id: <20230923005404.3633619-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnzvMuNw5lHGodBA--.12688S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWkJw47urWxGw15uw47XFb_yoWkJFX_Za
        yxAr1kWr1UJrWxtFn5Jr4rZ3WkKw1kZF1vqa93Kry3AFy7Cr18C3W2vr4fJ3y3WrWfCa9I
        kw4DCr1UGw1DGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRnzC2B9oOTR4gAAse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid the failure of alloc, we could check the return value of
kmalloc() and kzalloc().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 lib/list-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index 0cc27de9cec8..a0b478042477 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -26,10 +26,12 @@ static void list_test_list_init(struct kunit *test)
 
 	INIT_LIST_HEAD(&list2);
 
-	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	list4 = kunit_kzalloc(test, sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	KUNIT_ASSERT_NOT_NULL(test, list4);
 	INIT_LIST_HEAD(list4);
 
 	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	KUNIT_ASSERT_NOT_NULL(test, list5);
 	memset(list5, 0xFF, sizeof(*list5));
 	INIT_LIST_HEAD(list5);
 
@@ -40,7 +42,6 @@ static void list_test_list_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(list4));
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(list5));
 
-	kfree(list4);
 	kfree(list5);
 }
 
-- 
2.37.2

