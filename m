Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A360234A1E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 07:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCZGeq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 02:34:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14147 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhCZGe0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 02:34:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6Bvr3sWsznWnR;
        Fri, 26 Mar 2021 14:31:52 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:34:18 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zhengyongjun3@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>,
        "Shuah Khan" <shuah@kernel.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kselftest@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] treewide: Remove duplicated include from tm-vmx-unavail.c
Date:   Fri, 26 Mar 2021 14:48:12 +0800
Message-ID: <20210326064812.3262659-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove duplicated include.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
index e2a0c07e8362..9ef37a9836ac 100644
--- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
+++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
@@ -17,7 +17,6 @@
 #include <pthread.h>
 #include <sys/mman.h>
 #include <unistd.h>
-#include <pthread.h>
 
 #include "tm.h"
 #include "utils.h"

