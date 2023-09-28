Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810D77B16F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjI1JPk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjI1JPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:15:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D86180
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 02:15:36 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rx77K3YwYzrT9V;
        Thu, 28 Sep 2023 17:13:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:15:34 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <rmoar@google.com>,
        <marpagan@redhat.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH RESEND 1/3] kunit: Make the cases sequence more reasonable for kunit_module_notify()
Date:   Thu, 28 Sep 2023 17:14:44 +0800
Message-ID: <20230928091446.1209703-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928091446.1209703-1-ruanjinjie@huawei.com>
References: <20230928091446.1209703-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The module has a normal sequence from MODULE_STATE_COMING to
MODULE_STATE_LIVE and to MODULE_STATE_GOING, and eventually
MODULE_STATE_UNFORMED. The original order of cases is confusing
and misleading.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..29a5f5ea8112 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -783,14 +783,14 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 	struct module *mod = data;
 
 	switch (val) {
+	case MODULE_STATE_COMING:
+		kunit_module_init(mod);
+		break;
 	case MODULE_STATE_LIVE:
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
 		break;
-	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
-		break;
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-- 
2.34.1

