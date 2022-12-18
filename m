Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7164FE29
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Dec 2022 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLRJ34 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Dec 2022 04:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLRJ3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Dec 2022 04:29:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35EDE87;
        Sun, 18 Dec 2022 01:29:54 -0800 (PST)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NZcwJ43lXzmWMl;
        Sun, 18 Dec 2022 17:28:48 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 18 Dec 2022 17:29:51 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <broonie@kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/2] kselftest/arm64: Correct buffer size for SME ZA storage
Date:   Sun, 18 Dec 2022 17:29:42 +0800
Message-ID: <20221218092942.1940-2-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20221218092942.1940-1-yuzenghui@huawei.com>
References: <20221218092942.1940-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It looks like a copy-paste error to describe the ZA buffer size using (the
number of P registers * the maximum size of a Z register). This doesn't
have practical impact though as we're always allocating enough space even
for the architectural maximum ZA storage, with SVL equals to 2048 bits.

Switch to use ZA_SIG_REGS_SIZE(SVE_VQ_MAX). setup_za() will need to
initialize two 64MB arraies with this change and can be optimized later (if
someone complain).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index 24a498029c78..4adeb21f500e 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -282,8 +282,8 @@ static int check_svcr(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 	return errors;
 }
 
-uint8_t za_in[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
-uint8_t za_out[SVE_NUM_PREGS * __SVE_ZREG_SIZE(SVE_VQ_MAX)];
+uint8_t za_in[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
+uint8_t za_out[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
 
 static void setup_za(struct syscall_cfg *cfg, int sve_vl, int sme_vl,
 		     uint64_t svcr)
-- 
2.33.0

