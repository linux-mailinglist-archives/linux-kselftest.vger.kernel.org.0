Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A798AF94
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfHMGMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfHMGMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68uMj021972;
        Tue, 13 Aug 2019 06:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=gq6T668rkWls/bxZrbwyu380I/xpVBippRU1jyjSOOg=;
 b=d/573iIpCX9yPFLlxk1CgqdR4610RRj0mAF5cWpbaB0bIrd4se+eZexwhA1mCf66xYEO
 CsPxmkJeMxBzS3SmeEZGsWPbtkzeobJU+CBLiP72OPRgEoZRx9lUmDh63M5eJSZwE5jT
 B2yddnuNpLgBZ60qwUqmfbOedRcJVd81zKD4esydlZunooXGtAXfynMASGJMYwtZ+dps
 J5gyh2NlIF8ReoaQCiGuzEWw+AQDS3TaZT5AUJSiNewgbnkDjdV6ja8+qdLTxtcuh1sj
 yYHR8nqRaqCw73FNli6D0ww3rCaD/xXCtUsiMMHcwASBclq2mr5zDPXQzlqtnpJOhIQD 8g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=gq6T668rkWls/bxZrbwyu380I/xpVBippRU1jyjSOOg=;
 b=RenkVvOiBOTkk1/wEhNe2wlXEWi74QJwkZzEHHDf388OZhzhGP33qV2AbLfjbW48hhzL
 u+v+hCJLPYVB7hCiKKTnn0To9BxG7nlAeKp4V/6r8xttNDWTP6XpAxGSUnLd8XX5+BR6
 +GqmBFcyX4Z5Kszt6G1woLwp+9ENHtJFcL7WmXX3BFyl2ycELdLdvtLLMlNCHmLh4kSg
 hXzLriprsvUv0PlYGq2sTiHH5aotkfM3+EwGiOr4H+fd2jC/DKBQyiEwEn4uBKKsxkkl
 wDmWrk7YAiEJVjXgXMwgbeaW0bO02Huacz7YqN0riVSPsXQ+uAieoaRj2DRkXxrL3/pW Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68YNc049789;
        Tue, 13 Aug 2019 06:11:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u9k1w41vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6BqwY011407;
        Tue, 13 Aug 2019 06:11:52 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:51 -0700
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
Subject: [RFC 16/19] ktf: Some user applications to run tests
Date:   Tue, 13 Aug 2019 08:09:31 +0200
Message-Id: <c8c6df6d7b068c2103475f28056ab9a6df3fda4c.1565676440.git-series.knut.omang@oracle.com>
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

Some minimal user land executables to run tests and to enable/disable
coverage:

ktfrun:		Simple generic test runner for generic ktf tests
ktftest:	A test runner for the ktf selftests. Contains code to
		configure specific selftest context objects.
ktfcov:		A utility to selectively enable coverage support for
		a kernel module. Coverage support can also be enabled
		in code by tests, if desired.
hybrun:		A test that implements a hybrid test runner.

hybrid.cc:      User mode part of the hybrid_self
ktfrun.cc:      Generic user level application to run kernel tests

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/user/Makefile   | 26 ++++++++-
 tools/testing/selftests/ktf/user/hybrid.cc  | 39 +++++++++++++-
 tools/testing/selftests/ktf/user/ktfcov.cc  | 68 ++++++++++++++++++++++-
 tools/testing/selftests/ktf/user/ktfrun.cc  | 20 ++++++-
 tools/testing/selftests/ktf/user/ktftest.cc | 46 +++++++++++++++-
 5 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/user/Makefile
 create mode 100644 tools/testing/selftests/ktf/user/hybrid.cc
 create mode 100644 tools/testing/selftests/ktf/user/ktfcov.cc
 create mode 100644 tools/testing/selftests/ktf/user/ktfrun.cc
 create mode 100644 tools/testing/selftests/ktf/user/ktftest.cc

diff --git a/tools/testing/selftests/ktf/user/Makefile b/tools/testing/selftests/ktf/user/Makefile
new file mode 100644
index 0000000..04c8e7e
--- /dev/null
+++ b/tools/testing/selftests/ktf/user/Makefile
@@ -0,0 +1,26 @@
+
+GTEST_CFLAGS ?= -I$(GTEST_PATH)/include -DGTEST_HAS_PTHREAD=1 -lpthread
+GTEST_LIBS ?= -L$(GTEST_PATH)/lib64 -lgtest -lpthread
+NETLINK_CFLAGS ?= $(shell pkgconf --cflags libnl-genl-3.0)
+HOST_EXTRACFLAGS = -I$(srctree)/$(src)/../lib $(NETLINK_CFLAGS) $(GTEST_CFLAGS) \
+		-Wall -Werror \
+		-Wno-packed-bitfield-compat -D_GNU_SOURCE
+
+HOST_EXTRACXXFLAGS = -I$(srctree)/$(src)/../lib $(NETLINK_CFLAGS) $(GTEST_CFLAGS) \
+		-Wall \
+		-Wno-packed-bitfield-compat \
+		-Wno-pointer-arith -Werror \
+		-D__FILENAME__=\"`basename $<`\"
+NETLINK_LIBS ?= $(shell pkgconf --libs libnl-genl-3.0)
+KBUILD_HOSTLDLIBS =	-L$(obj)/../lib -lktf $(NETLINK_LIBS) $(GTEST_LIBS)
+
+hostprogs-y := ktfrun ktfcov ktftest
+
+__build: $(addprefix $(obj)/,$(hostprogs-y))
+
+## Simple kernel test runner sample program:
+ktfrun-cxxobjs = ktfrun.o
+ktfcov-cxxobjs = ktfcov.o
+
+## Configure and run the KTF selftests:
+ktftest-cxxobjs = ktftest.o hybrid.o
diff --git a/tools/testing/selftests/ktf/user/hybrid.cc b/tools/testing/selftests/ktf/user/hybrid.cc
new file mode 100644
index 0000000..6aa5ad2
--- /dev/null
+++ b/tools/testing/selftests/ktf/user/hybrid.cc
@@ -0,0 +1,39 @@
+/* Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * hybrid.cpp: User mode part of the hybrid_self
+ * test in selftests
+ */
+
+#include "ktf.h"
+#include <string.h>
+
+extern "C" {
+#include "../selftest/hybrid_self.h"
+}
+
+/* User side of a simple hybrid test that just sends an out-of-band message
+ * to the kernel side - the kernel implementation picks it up and verifies
+ * that it is the expected string and integer values.
+ *
+ * This form of test allows the mixing of normal gtest user land assertions
+ * with one or more calls to the kernel side to run tests there:
+ */
+
+HTEST(selftest, msg)
+{
+  KTF_USERDATA(self, hybrid_self_params, data);
+
+  strcpy(data->text_val, HYBRID_MSG);
+  data->val = HYBRID_MSG_VAL;
+
+  /* assertions can be specified here: */
+  EXPECT_TRUE(true);
+
+  ktf::run(self);
+
+  /* and here.. */
+  EXPECT_TRUE(true);
+}
diff --git a/tools/testing/selftests/ktf/user/ktfcov.cc b/tools/testing/selftests/ktf/user/ktfcov.cc
new file mode 100644
index 0000000..d5a9ef4
--- /dev/null
+++ b/tools/testing/selftests/ktf/user/ktfcov.cc
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2011, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Alan Maguire <alan.maguire@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktfcov.cpp:
+ *   User level application to enable/disable coverage of kernel modules.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "ktf.h"
+#include "../kernel/ktf_unlproto.h"
+
+using namespace std;
+
+void
+usage(char *progname)
+{
+	cerr << "Usage: " << progname << " [-e module[-m]] [-d module]\n";
+}
+
+int main (int argc, char** argv)
+{
+  int opt, nopts = 0;
+  unsigned int cov_opts = 0;
+  std::string modname = std::string();
+  bool enable = false;
+
+  ktf::setup();
+  testing::InitGoogleTest(&argc,argv);
+
+  if (argc < 3) {
+	usage(argv[0]);
+	return -1;
+  }
+
+  while ((opt = getopt(argc, argv, "e:d:m")) != -1) {
+	switch (opt) {
+	case 'e':
+		nopts++;
+		enable = true;
+		modname = optarg;
+		break;
+	case 'd':
+		nopts++;
+		enable = false;
+		modname = optarg;
+		break;
+	case 'm':
+		cov_opts |= KTF_COV_OPT_MEM;
+		break;
+	default:
+		cerr << "Unknown option '" << char(optopt) << "'";
+		return -1;
+	}
+  }
+  /* Either enable or disable must be specified, and -m is only valid
+   * for enable.
+   */
+  if (modname.size() == 0 || nopts != 1 || (cov_opts && !enable)) {
+	usage(argv[0]);
+	return -1;
+  }
+  return ktf::set_coverage(modname, cov_opts, enable);
+}
diff --git a/tools/testing/selftests/ktf/user/ktfrun.cc b/tools/testing/selftests/ktf/user/ktfrun.cc
new file mode 100644
index 0000000..9229b21
--- /dev/null
+++ b/tools/testing/selftests/ktf/user/ktfrun.cc
@@ -0,0 +1,20 @@
+/*
+ * Copyright (c) 2011, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktfrun.cpp: Generic user level application to run kernel tests
+ *   provided by modules subscribing to ktf services.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <ktf.h>
+
+int main (int argc, char** argv)
+{
+  ktf::setup();
+  testing::InitGoogleTest(&argc,argv);
+
+  return RUN_ALL_TESTS();
+}
diff --git a/tools/testing/selftests/ktf/user/ktftest.cc b/tools/testing/selftests/ktf/user/ktftest.cc
new file mode 100644
index 0000000..fda625d
--- /dev/null
+++ b/tools/testing/selftests/ktf/user/ktftest.cc
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2011, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktfrun.cpp: Generic user level application to run kernel tests
+ *   provided by modules subscribing to ktf services.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <ktf.h>
+
+extern "C" {
+#include "../selftest/context_self.h"
+}
+
+void selftest_configure()
+{
+  struct test_parameter_block p;
+  memset(&p, 0, sizeof(p));
+  strcpy(p.s, CONTEXT_MSG);
+
+  /* First configure two contexts provided by the kernel part: */
+  p.magic = CONTEXT_MAGIC1;
+  KTF_CONTEXT_CFG("context1", "context_type_1", test_parameter_block, &p);
+  p.magic = CONTEXT_MAGIC2;
+  KTF_CONTEXT_CFG("context2", "context_type_2", test_parameter_block, &p);
+
+  /* Configure a 3rd, dynamically created context, using CONTEXT3_TYPE_ID
+   * which the kernel part has enabled for dynamic creation of contexts
+   * from user space (see kernel/context.c: add_context_tests()
+   * for details of setup)
+   */
+  p.magic = CONTEXT_MAGIC3;
+  KTF_CONTEXT_CFG("context3", "context_type_3", test_parameter_block, &p);
+}
+
+
+int main (int argc, char** argv)
+{
+  ktf::setup(selftest_configure);
+  testing::InitGoogleTest(&argc,argv);
+
+  return RUN_ALL_TESTS();
+}
-- 
git-series 0.9.1
