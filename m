Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37437F656
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhEMLGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 07:06:14 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59547 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233125AbhEMLE6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 07:04:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UYkPCOJ_1620903821;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UYkPCOJ_1620903821)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 19:03:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] selftests/powerpc: Fix duplicate included pthread.h
Date:   Thu, 13 May 2021 19:03:40 +0800
Message-Id: <1620903820-68213-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Clean up the following includecheck warning:

./tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c: pthread.h is
included more than once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
index e2a0c07..9ef37a9 100644
--- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
+++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
@@ -17,7 +17,6 @@
 #include <pthread.h>
 #include <sys/mman.h>
 #include <unistd.h>
-#include <pthread.h>
 
 #include "tm.h"
 #include "utils.h"
-- 
1.8.3.1

