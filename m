Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373956DF31A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDLLXF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLLXD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 07:23:03 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5EC10CF;
        Wed, 12 Apr 2023 04:22:38 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id IHZ00139;
        Wed, 12 Apr 2023 19:12:39 +0800
Received: from localhost.localdomain.com (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.21; Wed, 12 Apr 2023 19:12:38 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <shuah@kernel.org>, <mpe@ellerman.id.au>
CC:     <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] selftests/powerpc: Replace obsolete memalign() with posix_memalign()
Date:   Wed, 12 Apr 2023 07:12:37 -0400
Message-ID: <20230412111237.2007-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2023412191239017fc8024cbab55b7953522593d5685e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

memalign() is obsolete according to its manpage.

Replace memalign() with posix_memalign() and remove malloc.h include
that was there for memalign().

As a pointer is passed into posix_memalign(), initialize *s to NULL
to silence a warning about the function's return value being used as
uninitialized (which is not valid anyway because the error is properly
checked before p is returned).

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 tools/testing/selftests/powerpc/stringloops/strlen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/stringloops/strlen.c b/tools/testing/selftests/powerpc/stringloops/strlen.c
index 9055ebc484d0..f9c1f9cc2d32 100644
--- a/tools/testing/selftests/powerpc/stringloops/strlen.c
+++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <malloc.h>
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
@@ -51,10 +50,11 @@ static void bench_test(char *s)
 static int testcase(void)
 {
 	char *s;
+	int ret;
 	unsigned long i;
 
-	s = memalign(128, SIZE);
-	if (!s) {
+	ret = posix_memalign((void **)&s, 128, SIZE);
+	if (ret < 0) {
 		perror("memalign");
 		exit(1);
 	}
-- 
2.27.0

