Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE83457AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 07:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCWGQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 02:16:33 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:57756 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWGQQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 02:16:16 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A9B1F9803CD;
        Tue, 23 Mar 2021 14:16:11 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v2] tools: testing: Remove duplicate includes
Date:   Tue, 23 Mar 2021 14:15:59 +0800
Message-Id: <20210323061604.289958-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHkkaGU5OTBgaT0hCVkpNSk1PQ0tKTEpCT01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6OQw*Sz8cPDoCThYiQwFO
        ATEaFFFVSlVKTUpNT0NLSkxJSU5OVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJQktKNwY+
X-HM-Tid: 0a785db9f75cd992kuwsa9b1f9803cd
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sched.h has been included at line 33, so remove the 
duplicate one at line 36.
inttypes.h has been included at line 19, so remove the 
duplicate one at line 23.
pthread.h has been included at line 17,so remove the 
duplicate one at line 20.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/testing/selftests/powerpc/mm/tlbie_test.c     | 1 -
 tools/testing/selftests/powerpc/tm/tm-poison.c      | 1 -
 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index f85a0938ab25..48344a74b212 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -33,7 +33,6 @@
 #include <sched.h>
 #include <time.h>
 #include <stdarg.h>
-#include <sched.h>
 #include <pthread.h>
 #include <signal.h>
 #include <sys/prctl.h>
diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
index 29e5f26af7b9..27c083a03d1f 100644
--- a/tools/testing/selftests/powerpc/tm/tm-poison.c
+++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
@@ -20,7 +20,6 @@
 #include <sched.h>
 #include <sys/types.h>
 #include <signal.h>
-#include <inttypes.h>
 
 #include "tm.h"
 
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
-- 
2.25.1

