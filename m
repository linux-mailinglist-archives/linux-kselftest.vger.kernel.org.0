Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB27A02FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjINLrb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjINLrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 07:47:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE79B
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 04:47:27 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rmb9L5XgmzgZg8;
        Thu, 14 Sep 2023 19:45:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 14 Sep
 2023 19:47:25 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <skhan@linuxfoundation.org>, <dlatypov@google.com>,
        <rmoar@google.com>, <janusz.krzysztofik@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>
Subject: [PATCH 2/4] kunit: Fix the wrong kfree of copy for kunit_filter_suites()
Date:   Thu, 14 Sep 2023 19:46:27 +0800
Message-ID: <20230914114629.1517650-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914114629.1517650-1-ruanjinjie@huawei.com>
References: <20230914114629.1517650-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the outer layer for loop is iterated more than once and it fails not
in the first iteration, the copy pointer has been moved. So it should free
the original copy's backup copy_start.

Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_suites()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 lib/kunit/executor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index a037a46fae5e..9358ed2df839 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -243,7 +243,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 
 free_copy:
 	if (*err)
-		kfree(copy);
+		kfree(copy_start);
 
 	return filtered;
 }
-- 
2.34.1

