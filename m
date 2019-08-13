Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154758AFA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfHMGMp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfHMGL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68qNb021612;
        Tue, 13 Aug 2019 06:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=ejlUs24YGrV79jcN352Y8l7jHkjpvnNttU06LwDBubY=;
 b=ixpGsi+O3VJleSP15ikG8DnVPfw1bgBu5FUuB5N5uvhqhduEomHnyeaEBlIeogY6LPbg
 P6c9QmNrxCCQCfhm6QXI/Jtf3rI/HpEyrwd6Dotqv2oX4l37UJTEB21JsRzA0iPdaqHG
 lgqDnsszVVkBDktpxpPsGRd6AF3XTZWKbgOIjLECaYaQ/uJI3ralpC56QOiT1sxZX124
 E9pUHQU5yNn4RSVLYU3sXNMBTdNputCLl6qL8dte6DAgJwVzRXiVwHDR31ZutudaCAaC
 ZwByunbLN1tEsaUjiTARCGzn7Wkjno0duR9wyVvLaqQd+i1Izu016iHv8MpaV9Op/Sma oQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ejlUs24YGrV79jcN352Y8l7jHkjpvnNttU06LwDBubY=;
 b=oks5hyZuQI3+W8D3FxxKvELSS5HyiK1rP0bJnQgVdZ6wy1I2Aa4o+hC2BEYFzej7joV6
 Pa7WfQXv73I3LfwRYN8JGmfr1vAZVeXqPw/gDMUyiBxZLvLLGbNkoOl9GCkxv6iIQ5ga
 HTjzgK13AKXLmrH/87HER4YJi1crnSBme7MFcXRxVwl3hRtlMvW1s5d892KWEfbxuSxW
 6ZUa7rftxZRsU/bZasqQv30o5zVs+VX/+JGOUNBMWjo/PTkCAzRts3d0ARQcmH3FEGQy
 rNgARtAXp+yLf7LKUSa7OMCc6bjmssUAcQdhDRllo/Xt9nbE5A0TgvHvIVMSwFv8Fid6 UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68PHb056292;
        Tue, 13 Aug 2019 06:11:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u9n9hs2yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6BeC8026485;
        Tue, 13 Aug 2019 06:11:40 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:40 -0700
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
Subject: [RFC 13/19] ktf: Integration logic for running ktf tests from googletest
Date:   Tue, 13 Aug 2019 08:09:28 +0200
Message-Id: <e3c629ef5f77dceefc5136e590bfc0c4bac664c3.1565676440.git-series.knut.omang@oracle.com>
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

Currently ktf only supports integration with googletest on the user
side, but there's nothing that prevents integration towards other user
land frameworks for running and reporting, if so desired.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/lib/ktf_run.cc     | 177 ++++++++++++++++++-
 tools/testing/selftests/ktf/lib/ktf_unlproto.c |  21 ++-
 2 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_run.cc
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_unlproto.c

diff --git a/tools/testing/selftests/ktf/lib/ktf_run.cc b/tools/testing/selftests/ktf/lib/ktf_run.cc
new file mode 100644
index 0000000..a26e04c
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf_run.cc
@@ -0,0 +1,177 @@
+/*
+ * Copyright (c) 2012, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_run.cpp:
+ *  Gtest integration of ktf kernel tests -
+ *  e.g. tests that are fully implemented on the test driver side
+ *  and only initiated via run_test below
+ */
+
+#include "ktf_int.h"
+#include <assert.h>
+#include <errno.h>
+#include "ktf_debug.h"
+
+namespace ktf
+{
+
+class KernelMetaFactory;
+
+class Kernel : public ::testing::TestWithParam<std::string>
+{
+public:
+  Kernel()
+  {
+    assert(false); // Should not be hit but is needed for template resolving
+  }
+
+  Kernel(std::string& setname, std::string& testname)
+  {
+    log(KTF_INFO, "%s.%s\n", setname.c_str(), testname.c_str());
+
+    ukt = ktf::find_test(setname,testname,&ctx);
+    if (!ukt) {
+      fprintf(stderr, "**** Internal error: Could not find test %s.%s (set %s, name %s) ****\n",
+	      setname.c_str(), testname.c_str(), setname.c_str(), testname.c_str());
+      exit(7);
+    }
+    log(KTF_INFO, "### Kernel ctor %s (%ld,%ld)\n", ukt->name.c_str(), ukt->setnum, ukt->testnum);
+  }
+
+  virtual ~Kernel()
+  {
+    log(KTF_INFO, "### Kernel dtor %s\n", ukt->name.c_str());
+
+    /* For some reason errno sometimes get set
+     * TBD: Figure out why - for now just reset it to avoid confusing the next test!
+     */
+    if (errno) {
+      log(KTF_INFO, "### %s: errno was set to %d - resetting..\n", ukt->name.c_str(), errno);
+      errno = 0;
+    }
+  }
+
+  virtual void TestBody();
+private:
+  ktf::KernelTest* ukt;
+  std::string ctx;
+  friend void setup(configurator c);
+  static int AddToRegistry();
+  static configurator configurator_;
+};
+
+
+
+class TFactory : public ::testing::internal::ParameterizedTestFactory<Kernel>
+{
+public:
+  TFactory(std::string s, ParamType parameter)
+    : ::testing::internal::ParameterizedTestFactory<Kernel>(parameter),
+      setname(s)
+  {
+    testname = parameter.c_str();
+  }
+
+  virtual ::testing::Test* CreateTest()
+  {
+    return new Kernel(setname,testname);
+  }
+
+private:
+  std::string setname;
+  std::string testname;
+};
+
+
+class KernelMetaFactory : public ::testing::internal::TestMetaFactory<Kernel>
+{
+public:
+  virtual ::testing::internal::TestFactoryBase* CreateTestFactory(ParamType parameter) {
+    TFactory* tf;
+    std::string setname = get_current_setname();
+    tf = new TFactory(setname, parameter.c_str());
+    return tf;
+  }
+};
+
+testing::internal::ParamGenerator<Kernel::ParamType> gtest_query_tests(void);
+std::string gtest_name_from_info(const testing::TestParamInfo<Kernel::ParamType>&);
+void gtest_handle_test(int result,  const char* file, int line, const char* report);
+
+#ifndef INSTANTIATE_TEST_SUITE_P
+/* This rename happens in Googletest commit 3a460a26b7.
+ * Make sure we compile both before and after it:
+ */
+#define AddTestSuiteInstantiation AddTestCaseInstantiation
+#endif
+
+int Kernel::AddToRegistry()
+{
+  if (!ktf::setup(ktf::gtest_handle_test)) return 1;
+
+  /* Run query against kernel to figure out which tests that exists: */
+  stringvec& t = ktf::query_testsets();
+
+  ::testing::internal::ParameterizedTestCaseInfo<Kernel>* tci =
+      ::testing::UnitTest::GetInstance()->parameterized_test_registry()
+      .GetTestCasePatternHolder<Kernel>( "Kernel", ::testing::internal::CodeLocation("", 0));
+
+  for (stringvec::iterator it = t.begin(); it != t.end(); ++it)
+  {
+    ::testing::internal::TestMetaFactory<Kernel>* mf = new KernelMetaFactory();
+    tci->AddTestPattern(it->c_str(), "", mf);
+  }
+
+  tci->AddTestSuiteInstantiation("", &gtest_query_tests, &gtest_name_from_info, NULL, 0);
+  return 0;
+}
+
+void setup(configurator c)
+{
+  ktf::set_configurator(c);
+  Kernel::AddToRegistry();
+}
+
+
+void Kernel::TestBody()
+{
+  run_test(ukt, ctx);
+}
+
+
+void gtest_handle_test(int result,  const char* file, int line, const char* report)
+{
+  if (result >= 0) {
+    const ::testing::AssertionResult gtest_ar =
+      !result ? (testing::AssertionFailure() << report) : testing::AssertionSuccess();
+
+    if (result) {
+      /* We might get multiple partial results from the kernel in one positive
+       * result report:
+       */
+#if HAVE_ASSERT_COUNT
+      ::testing::UnitTest::GetInstance()->increment_success_assert_count(result);
+#else
+      GTEST_SUCCEED();
+#endif
+    } else {
+      ::testing::internal::AssertHelper(::testing::TestPartResult::kNonFatalFailure,
+					file, line, gtest_ar.failure_message()) = ::testing::Message();
+    }
+  }
+}
+
+testing::internal::ParamGenerator<Kernel::ParamType> gtest_query_tests()
+{
+  return testing::ValuesIn(ktf::get_test_names());
+}
+
+std::string gtest_name_from_info(const testing::TestParamInfo<Kernel::ParamType>& info)
+{
+  return info.param;
+}
+
+} // end namespace ktf
diff --git a/tools/testing/selftests/ktf/lib/ktf_unlproto.c b/tools/testing/selftests/ktf/lib/ktf_unlproto.c
new file mode 100644
index 0000000..3929b03
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf_unlproto.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2012, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * unlproto.c: This file is needed because the C struct init
+ * used in kernel/unlproto.h is not allowed in C++
+ */
+
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#define NL_INTERNAL 1
+#include "kernel/ktf_unlproto.h"
+
+
+struct nla_policy *ktf_get_gnl_policy(void)
+{
+  return ktf_gnl_policy;
+}
-- 
git-series 0.9.1
