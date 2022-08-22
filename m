Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6D59BEE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiHVLv0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiHVLuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 07:50:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F34B862;
        Mon, 22 Aug 2022 04:50:17 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MB9Yz4dSfz1N7Tt;
        Mon, 22 Aug 2022 19:46:47 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 19:50:14 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next 5/5] landlock: update chmod and chown support in document
Date:   Mon, 22 Aug 2022 19:47:01 +0800
Message-ID: <20220822114701.26975-6-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822114701.26975-1-xiujianfeng@huawei.com>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

update LANDLOCK_ACCESS_FS_{CHMOD, CHOWN} support and add abi change
in the document.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 Documentation/userspace-api/landlock.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 2509c2fbf98f..05ab338db529 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -61,7 +61,9 @@ the need to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
-            LANDLOCK_ACCESS_FS_TRUNCATE,
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_CHMOD |
+            LANDLOCK_ACCESS_FS_CHOWN
     };
 
 Because we may not know on which kernel version an application will be
@@ -90,6 +92,10 @@ the ABI.
     case 2:
             /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
             ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
+    case 3:
+            /* Removes LANDLOCK_ACCESS_FS_{CHMOD, CHOWN} for ABI < 4 */
+            ruleset_attr.handled_access_fs &= ~(LANDLOCK_ACCESS_FS_CHMOD |
+                                                LANDLOCK_ACCESS_FS_CHOWN);
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
-- 
2.17.1

