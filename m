Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B67B10EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 04:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjI1Cn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjI1Cny (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 22:43:54 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD294;
        Wed, 27 Sep 2023 19:43:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vt.rlIY_1695869028;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlIY_1695869028)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:49 +0800
From:   Yuanhe Shu <xiangzao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yuanhe Shu <xiangzao@linux.alibaba.com>,
        Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH 4/5] pstore: remove the module parameter "backend"
Date:   Thu, 28 Sep 2023 10:42:43 +0800
Message-Id: <20230928024244.257687-5-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since all enabled backends have corresponding subdir in
/sys/fs/pstore, and the logic of finding unexpected is
changed by using psinfo_list rather than parameter backend,
it is not necessary to retain the parameter backend.

Remove the unnecessary module parameter "backend".

Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 fs/pstore/platform.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d576ee48527c..90c33c1ca39f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -77,10 +77,6 @@ static DECLARE_WORK(pstore_work, pstore_dowork);
 DEFINE_MUTEX(psback_lock);
 struct pstore_backends *psback;
 
-static char *backend;
-module_param(backend, charp, 0444);
-MODULE_PARM_DESC(backend, "specific backend to use");
-
 static char *compress =
 #ifdef CONFIG_PSTORE_COMPRESS_DEFAULT
 		CONFIG_PSTORE_COMPRESS_DEFAULT;
@@ -675,12 +671,6 @@ int pstore_register(struct pstore_info *psi)
 	/* Start watching for new records, if desired. */
 	pstore_timer_kick();
 
-	/*
-	 * Update the module parameter backend, so it is visible
-	 * through /sys/module/pstore/parameters/backend
-	 */
-	backend = kstrdup(psi->name, GFP_KERNEL);
-
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
 	mutex_unlock(&psback_lock);
-- 
2.39.3

