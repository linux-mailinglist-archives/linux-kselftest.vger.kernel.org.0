Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A7A8AF8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfHMGMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfHMGME (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68sFA010844;
        Tue, 13 Aug 2019 06:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=tfjxeCtOt/zjkP/k6+2p52MgrQfqToiEPXPQHRk3l/0=;
 b=SI1H4ybBHfNsYu/Iq7509UOI1VugUK3iV4C2jN5o9Uhac0JNJ5it4UX5QPSrxZf2oGwj
 RgoEUetbN1autivZAxCizMV0pdEiZIP1cs4cCamatDBjsbUNirmTF2NLi1kQZsfJJobe
 kkaHIt4nCocvIrRkxPgSCvWDCH6Owzy7rK+my4nThcBKzl+lTWRJ0Co/xM3G3FqpDK+7
 AWyaCQWaDGQcZI0GPy8NitoNK5HE9n/UEQkv4RZfMTNf8tQDpfeEdGC6XF4QEKtl6Img
 gOe94eUzCaozXo25qnIpufC9qIGBjOMClQWqDDMLbmJvCnsqYZB48QT/FFhRRpGqcCFG Bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=tfjxeCtOt/zjkP/k6+2p52MgrQfqToiEPXPQHRk3l/0=;
 b=hWzOqaGXKwpzIdSDdWIddVoqjiwHK+49GsjUFU8opMFYOQuSPlN+ZgJPKMDvR1M3gfg+
 d2qRY4wIZVnjuCQqSII+S5LQozuTfzSNb2KGWogQbeWS4zxqoEiZ9rfOtfsdkmcyN9Xl
 V/cMLDe5JB4Uu3koOm/K3WJaWHPmnvx+c7/ESMgCzjvcVYyKlyO9Ue0xaNJLHiDOxsCW
 Irbhua8yDqmDBf+qCnix/kxI+UZnuklVMk1nZi+qTkFyzd/UrdEWNVaVEUKk7/wxruor
 ZHmvkm4wzvdBbv3pB1jbz9R7x20sT6lHImhDN9KjjiwEVCKqe+eZlFwmHHfQlCksWtkS Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u9nbtc13t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67Txc157148;
        Tue, 13 Aug 2019 06:11:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u9nrenmd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6Bif7013702;
        Tue, 13 Aug 2019 06:11:44 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:43 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 14/19] ktf: Internal debugging facilities
Date:   Tue, 13 Aug 2019 08:09:29 +0200
Message-Id: <2e0a915bf97d241eced54efa540c9a11a1996c27.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Utilities for convenient and runtime enabled/disabled
printk debugging mainly intended for debugging ktf itself and subtle
early issues with execution/running of tests.

ktf_debug.h:     User mode debug function definitions

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/lib/ktf_debug.cc | 20 +++++++-
 tools/testing/selftests/ktf/lib/ktf_debug.h  | 59 +++++++++++++++++++++-
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_debug.cc
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_debug.h

diff --git a/tools/testing/selftests/ktf/lib/ktf_debug.cc b/tools/testing/selftests/ktf/lib/ktf_debug.cc
new file mode 100644
index 0000000..18ff443
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf_debug.cc
@@ -0,0 +1,20 @@
+/* Copyright (c) 2012 Oracle Corporation. All rights reserved
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "ktf_debug.h"
+#include <stdlib.h>
+
+unsigned long ktf_debug_mask = 0;
+
+
+void ktf_debug_init()
+{
+  ktf_debug_mask = 0;
+  char* dbg_mask_str = getenv("KTF_DEBUG_MASK");
+  if (dbg_mask_str) {
+    ktf_debug_mask = strtol(dbg_mask_str, NULL, 0);
+    log(KTF_INFO_V, "debug mask set to 0x%lx\n", ktf_debug_mask);
+  }
+}
diff --git a/tools/testing/selftests/ktf/lib/ktf_debug.h b/tools/testing/selftests/ktf/lib/ktf_debug.h
new file mode 100644
index 0000000..dc761a4
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf_debug.h
@@ -0,0 +1,59 @@
+/* Copyright (c) 2012 Oracle Corporation. All rights reserved
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_debug.h: User mode debug function definitions
+ * - intended for test debugging.
+ *
+ * Enabled by setting bits in the environment variable KTF_DEBUG_MASK
+ */
+
+#ifndef _KTF_DEBUG_H
+#define _KTF_DEBUG_H
+#include <time.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+extern unsigned long ktf_debug_mask;
+
+
+#define KTF_ERR             0x1
+#define KTF_WARN            0x2
+#define KTF_INFO            0x4
+#define KTF_INFO_V        0x100
+#define KTF_MR           0x2000
+#define KTF_DEBUG       0x10000
+#define KTF_POLL        0x20000
+#define KTF_EVENT       0x40000
+#define KTF_DEBUG_V   0x1000000
+#define KTF_DUMP      0x2000000
+
+/* Call this to initialize the debug logic from
+ * environment KTF_DEBUG_MASK
+ */
+void ktf_debug_init();
+
+#define log(level, format, arg...)		\
+do {\
+  if (level & ktf_debug_mask) {\
+    char _tm[30]; \
+    time_t _tv = time(NULL);\
+    ctime_r(&_tv,_tm);\
+    _tm[24] = '\0';\
+    fprintf(stderr, "%s [%ld] %s: " format, \
+            _tm, (long unsigned int) pthread_self(), __func__, ## arg);     \
+  }\
+} while (0)
+
+#define logs(class, stmt_list) \
+  do {							    \
+    if (ktf_debug_mask & class) { \
+      stmt_list;  \
+    }   \
+  } while (0)
+
+#endif
-- 
git-series 0.9.1
