Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24866DB589
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 20:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395430AbfJQSIQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 14:08:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395417AbfJQSIQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 14:08:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI4cTL161556;
        Thu, 17 Oct 2019 18:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=uSEqo1vwzdjctc96LUNCD5ybeWnPpZ9dSMDULQK9zAI=;
 b=ChcLJCkVNG6Ap9oj9/s302DKsvV+w8wUg/0Wq7hNc+kLy4O48SwF3b0eFkzqHquudFjH
 AQvaAGi1+KWhR0FBqRK5C67kByMYd0jsTfdWXpHm/UIhpDuuqnwrem2vAODL/k3TPuJB
 bu2X65hLP0+Z3AjbOHO1Je/X/ii0p4a65pt3BMpmAJzGAUFhbLm5y8Ty6XgN+Knn9nQR
 Uf3vMuU3pO4y+xl4dIEmxrYJ5t58M7wgfxBO0a4dF5Mn+7F9+VDv3r86tHrze2j6wXRQ
 VsyJtRAnwjvTuogtpiMDN8kHbNiKh1Y94DQiSEQBvAMcspVZO/tiXYSVM8Jr37GrPcW1 Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vk68v052g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:07:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI7uSV041991;
        Thu, 17 Oct 2019 18:07:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vpf14dv69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:07:58 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HI7rFx021918;
        Thu, 17 Oct 2019 18:07:53 GMT
Received: from dhcp-10-175-161-223.vpn.oracle.com (/10.175.161.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:07:53 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v3 linux-kselftest-test 3/6] kunit: add kunit_find_symbol() function for symbol lookup
Date:   Thu, 17 Oct 2019 19:07:16 +0100
Message-Id: <1571335639-21675-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=851 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for module support for kunit and kunit tests,
we need a way of retrieving non-exported symbols from the
core kernel and modules.  kunit_find_symbol() supports this.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 include/kunit/test.h  |  8 ++++++++
 lib/kunit/test-test.c | 19 +++++++++++++++++++
 lib/kunit/test.c      | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index dba4830..c645d18 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -339,6 +339,14 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
 
 void kunit_cleanup(struct kunit *test);
 
+/**
+ * kunit_find_symbol() - lookup un-exported symbol in kernel or modules.
+ * @sym: symbol name.
+ *
+ * Returns symbol or ERR_PTR value on error.
+ */
+void *kunit_find_symbol(const char *sym);
+
 #define kunit_printk(lvl, test, fmt, ...) \
 	printk(lvl "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
 
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
index c4162a9..7f09dd0 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/test-test.c
@@ -330,3 +330,22 @@ static void kunit_resource_test_exit(struct kunit *test)
 	.test_cases = kunit_resource_test_cases,
 };
 kunit_test_suite(kunit_resource_test_suite);
+
+/*
+ * Find non-exported kernel symbol; we use the modules list as a safe
+ * choice that should always be present.
+ */
+static void kunit_find_symbol_kernel(struct kunit *test)
+{
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kunit_find_symbol("modules"));
+}
+
+static struct kunit_case kunit_find_symbol_test_cases[] = {
+	KUNIT_CASE(kunit_find_symbol_kernel),
+};
+
+static struct kunit_suite kunit_find_symbol_test_suite = {
+	.name = "kunit-find-symbol",
+	.test_cases = kunit_find_symbol_test_cases,
+};
+kunit_test_suite(kunit_find_symbol_test_suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49ac5fe..a2b1b46 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <kunit/try-catch.h>
+#include <linux/kallsyms.h>
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 #include "string-stream-impl.h"
@@ -478,3 +479,38 @@ void kunit_cleanup(struct kunit *test)
 		kunit_resource_free(test, resource);
 	}
 }
+
+/*
+ * Support for looking up kernel/module internal symbols to enable testing.
+ */
+void *kunit_find_symbol(const char *sym)
+{
+	unsigned long (*modlookup)(const char *name);
+	unsigned long addr = 0;
+
+	if (!sym || strlen(sym) > KSYM_NAME_LEN)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Try for kernel-internal symbol first; fall back to modules
+	 * if that fails.
+	 */
+	addr = kallsyms_lookup_name(sym);
+	if (addr)
+		return (void *)addr;
+	modlookup = (void *)kallsyms_lookup_name("module_kallsyms_lookup_name");
+	if (modlookup)
+		addr = modlookup(sym);
+	if (addr)
+		return (void *)addr;
+
+#ifndef CONFIG_KALLSYMS_ALL
+	WARN_ONCE(true,
+		  "CONFIG_KALLSYMS_ALL is not set, so unexported symbols like '%s' are not available\n",
+		  sym);
+	return ERR_PTR(-ENOTSUPP);
+#else
+	WARN_ONCE(true, "symbol '%s' is not available\n", sym);
+#endif
+	return ERR_PTR(-ENOENT);
+}
-- 
1.8.3.1

