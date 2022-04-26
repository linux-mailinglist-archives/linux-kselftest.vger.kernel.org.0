Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C150F171
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiDZGtf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 02:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiDZGtf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 02:49:35 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2D186FD;
        Mon, 25 Apr 2022 23:46:27 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 Apr
 2022 14:46:27 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 26 Apr
 2022 14:46:25 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <kjain@linux.ibm.com>
CC:     <baihaowen@meizu.com>, <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <shuah@kernel.org>
Subject: [PATCH V2] selftests/powerpc/pmu: Fix unsigned function returning negative constant
Date:   Tue, 26 Apr 2022 14:46:23 +0800
Message-ID: <1650955583-29581-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0e4b0f8e-6c45-8d14-303f-2168f5004a12@linux.ibm.com>
References: <0e4b0f8e-6c45-8d14-303f-2168f5004a12@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The function __perf_reg_mask has an unsigned return type, but returns a
negative constant to indicate an error condition. So we change unsigned
to int.

Fixes: 5f6c3061af7c ("selftests/powerpc/pmu: Add utility functions to post
process the mmap buffer")

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: add fix tag.

 tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
index fca054bbc094..c01a31d5f4ee 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
@@ -274,7 +274,7 @@ u64 *get_intr_regs(struct event *event, void *sample_buff)
 	return intr_regs;
 }
 
-static const unsigned int __perf_reg_mask(const char *register_name)
+static const int __perf_reg_mask(const char *register_name)
 {
 	if (!strcmp(register_name, "R0"))
 		return 0;
-- 
2.7.4

