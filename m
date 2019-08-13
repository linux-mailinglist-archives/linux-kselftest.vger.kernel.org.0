Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623C08AF78
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfHMGLc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37120 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfHMGLb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68wnv022022;
        Tue, 13 Aug 2019 06:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Xgef0XFFFPz0RPMRvPeUpqgM+lNFsR5792wofX4MhfM=;
 b=QTBRw1J8EwzFKxTiUFmLQgNu5gJSIlHqxIXINo/GKFDy5+tNbI6IEjURZfo8AowNa2RE
 HRbAaqZ3IYt5aDtt8KrnQa56YdCAoa+U49qwVSN8n0bSTuFfvXX7Y4DsSvTCR5Cpk4/h
 QW8xlED9BzhsCmcmoD4sny1+qHo8meLw4/wvHZvHdZ5fdwneMqAJ6ZjLSQ2GcWJCnpKz
 Bs1ZQOHbykMMpo+/94Mrav4hM7xrrhKy8Oqgloat9Bc3tGiTHL2WrqaqV93a61puONki
 3C6OFymR8D7IcthR2aE/6Sb7TZAzwTm7hgQAPry4VsOOY3jZ4UfCCITlQwgzJjtA0ZzW ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Xgef0XFFFPz0RPMRvPeUpqgM+lNFsR5792wofX4MhfM=;
 b=Q/qjpYmChiHk6d3bxVVA9c4vw6ca/+dFQ+6gPMWpmbcZWJ5JmZhA1UWn0q+h3la2ajSX
 6PiUwAACJVI0nHX4sH2xeyFtNHhRz3o+j5R2TM5sfGE7zXMtf6z+59Q6rXYzu3JyWXfC
 tYG//zJAueUGNN0T3aQW6eZ+8a9lqxx8MV3lM68DYYiSDuJ57UbDBAcy8xSJo/OMbLRI
 fPclPxgYrktrriyOddNXcJ375J3loPtH73vPBgHPiRGZ5HHbBPuhbKmLWtbcNJe4ZtM5
 F+GJDpeoORDqdBjgmRiFWoqAzL8okVGvjn4CYJxDiy1AY+0oNVDk/Xt8+idc5jFlV54M zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67Q1i096475;
        Tue, 13 Aug 2019 06:11:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u9m0aydn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:10 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6B9SB026468;
        Tue, 13 Aug 2019 06:11:09 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:09 -0700
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
Subject: [RFC 05/19] ktf: Implementation of ktf support for overriding function entry and return.
Date:   Tue, 13 Aug 2019 08:09:20 +0200
Message-Id: <1fccfe3062ba6c7a2c8171df8e41975e28dae9ec.1565676440.git-series.knut.omang@oracle.com>
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

From: Alan Maguire <alan.maguire@oracle.com>

This is a very powerful and yet simple way to verify or modify
behaviour of kernel calls. It uses the same technique as the error
injection framework in kernel/fail_function.c to to override function
entry and return. In addition to error injection, this is very useful
to for instance verify that a particular API actually ends up being
called, and in the right way, as an effect of a test.

ktf_override.c:  support for overriding function entry.
ktf_override.h:  Function override support interface for KTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/kernel/ktf_override.c | 45 ++++++++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_override.h | 15 +++++-
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_override.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_override.h

diff --git a/tools/testing/selftests/ktf/kernel/ktf_override.c b/tools/testing/selftests/ktf/kernel/ktf_override.c
new file mode 100644
index 0000000..7f046c8
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_override.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_override.c: support for overriding function entry.
+ */
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include "ktf.h"
+#include "ktf_override.h"
+
+asmlinkage void ktf_just_return_func(void);
+
+asm(
+	".type ktf_just_return_func, @function\n"
+	".globl ktf_just_return_func\n"
+	"ktf_just_return_func:\n"
+	"	ret\n"
+	".size ktf_just_return_func, .-ktf_just_return_func\n"
+);
+
+void ktf_post_handler(struct kprobe *kp, struct pt_regs *regs,
+		      unsigned long flags)
+{
+	/*
+	 * A dummy post handler is required to prohibit optimizing, because
+	 * jump optimization does not support execution path overriding.
+	 */
+}
+EXPORT_SYMBOL(ktf_post_handler);
+
+void ktf_override_function_with_return(struct pt_regs *regs)
+{
+	KTF_SET_INSTRUCTION_POINTER(regs, (unsigned long)&ktf_just_return_func);
+}
+EXPORT_SYMBOL(ktf_override_function_with_return);
+NOKPROBE_SYMBOL(ktf_override_function_with_return);
+
+int ktf_register_override(struct kprobe *kp)
+{
+	return register_kprobe(kp);
+}
+EXPORT_SYMBOL(ktf_register_override);
diff --git a/tools/testing/selftests/ktf/kernel/ktf_override.h b/tools/testing/selftests/ktf/kernel/ktf_override.h
new file mode 100644
index 0000000..8a9cf39
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_override.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_override.h: Function override support interface for KTF.
+ */
+#include <linux/kprobes.h>
+#include "ktf.h"
+
+void ktf_post_handler(struct kprobe *kp, struct pt_regs *regs,
+		      unsigned long flags);
+void ktf_override_function_with_return(struct pt_regs *regs);
+int ktf_register_override(struct kprobe *kp);
-- 
git-series 0.9.1
