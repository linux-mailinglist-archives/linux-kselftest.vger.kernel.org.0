Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53413784F38
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 05:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHWDWp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 23:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHWDWo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 23:22:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22E137;
        Tue, 22 Aug 2023 20:22:43 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVs1f3DYGz1L9KR;
        Wed, 23 Aug 2023 11:21:10 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:22:38 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <j.vosburgh@gmail.com>, <andy@greyhouse.net>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net-next] selftests: bonding: delete link1_1 in the cleanup path
Date:   Wed, 23 Aug 2023 11:26:40 +0800
Message-ID: <20230823032640.3609934-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If failed to set link1_1 to netns client, we should delete link1_1 in the
cleanup path. But if set link1_1 to netns client successfully, delete
link1_1 will report warning. So delete link1_1 in the cleanup path and
drop any warning message.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
index 7b2d421f09cf..2b3c678c5205 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
@@ -11,6 +11,7 @@ finish()
 {
 	ip netns delete server || true
 	ip netns delete client || true
+	ip link del link1_1 >/dev/null 2>&1
 }
 
 trap finish EXIT
-- 
2.34.1

