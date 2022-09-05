Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADFE5AD33F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiIEMtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiIEMtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 08:49:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B0E30;
        Mon,  5 Sep 2022 05:49:11 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLpDY3ytzznV2Z;
        Mon,  5 Sep 2022 20:46:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 20:49:09 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <akinobu.mita@gmail.com>, Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next v2 1/5] selftests/cpu-hotplug: Correct log info
Date:   Mon, 5 Sep 2022 20:45:21 +0800
Message-ID: <20220905124525.130067-2-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905124525.130067-1-zhaogongyi@huawei.com>
References: <20220905124525.130067-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Correct the log info to match the test.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index 0d26b5e3f966..1169ef82b55e 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -196,7 +196,7 @@ if [ $allcpus -eq 0 ]; then
 	online_cpu_expect_success $online_max

 	if [[ $offline_cpus -gt 0 ]]; then
-		echo -e "\t offline to online to offline: cpu $present_max"
+		echo -e "\t online to offline to online: cpu $present_max"
 		online_cpu_expect_success $present_max
 		offline_cpu_expect_success $present_max
 		online_cpu $present_max
--
2.17.1

