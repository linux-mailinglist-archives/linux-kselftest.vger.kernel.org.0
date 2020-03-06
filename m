Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1415E17B4D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 04:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFDSI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 22:18:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgCFDSI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 22:18:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9C69BC1D71A2CBE3C756;
        Fri,  6 Mar 2020 11:18:04 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 11:17:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <shuah@kernel.org>, <tglx@linutronix.de>, <yuehaibing@huawei.com>,
        <0x7f454c46@gmail.com>, <avagin@gmail.com>, <dima@arista.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] selftests/timens: Remove duplicated include <time.h>
Date:   Fri, 6 Mar 2020 11:17:05 +0800
Message-ID: <20200306031705.25008-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 tools/testing/selftests/timens/exec.c   | 1 -
 tools/testing/selftests/timens/procfs.c | 1 -
 tools/testing/selftests/timens/timens.c | 1 -
 tools/testing/selftests/timens/timer.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index 87b47b5..e40dc5b 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -11,7 +11,6 @@
 #include <sys/wait.h>
 #include <time.h>
 #include <unistd.h>
-#include <time.h>
 #include <string.h>
 
 #include "log.h"
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 43d93f4..7f14f0f 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -12,7 +12,6 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
-#include <time.h>
 
 #include "log.h"
 #include "timens.h"
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 559d26e..098be7c 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -10,7 +10,6 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
-#include <time.h>
 #include <string.h>
 
 #include "log.h"
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 0cca7aa..96dba11 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -11,7 +11,6 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <signal.h>
-#include <time.h>
 
 #include "log.h"
 #include "timens.h"
-- 
2.7.4


