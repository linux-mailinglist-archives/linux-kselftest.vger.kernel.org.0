Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4985B96E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIOJCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIOJCV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 05:02:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019C985B0;
        Thu, 15 Sep 2022 02:02:16 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSrgk1rHwzNmGF;
        Thu, 15 Sep 2022 16:57:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 17:01:51 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
CC:     <akinobu.mita@gmail.com>, <corbet@lwn.net>, <david@redhat.com>,
        <osalvador@suse.de>, <shuah@kernel.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v2 5/5] docs: notifier-error-inject: Correct test's name
Date:   Thu, 15 Sep 2022 16:57:57 +0800
Message-ID: <20220915085757.258608-6-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915085757.258608-1-zhaogongyi@huawei.com>
References: <20220915085757.258608-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Correct test's name for mem-on-off-test.sh/cpu-on-off-test.sh.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/fault-injection/notifier-error-inject.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fault-injection/notifier-error-inject.rst b/Documentation/fault-injection/notifier-error-inject.rst
index 0e2790122166..170c583eb5bc 100644
--- a/Documentation/fault-injection/notifier-error-inject.rst
+++ b/Documentation/fault-injection/notifier-error-inject.rst
@@ -95,8 +95,8 @@ For more usage examples
 There are tools/testing/selftests using the notifier error injection features
 for CPU and memory notifiers.

- * tools/testing/selftests/cpu-hotplug/on-off-test.sh
- * tools/testing/selftests/memory-hotplug/on-off-test.sh
+ * tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+ * tools/testing/selftests/memory-hotplug/mem-on-off-test.sh

 These scripts first do simple online and offline tests and then do fault
 injection tests if notifier error injection module is available.
--
2.17.1

