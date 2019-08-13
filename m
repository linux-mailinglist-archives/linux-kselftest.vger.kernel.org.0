Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BDC8AF85
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfHMGMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbfHMGMB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D690jC022084;
        Tue, 13 Aug 2019 06:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=d0uU65Z04im+BrtimXWGyB6YZa/jBywtmtJQJXOqv7E=;
 b=HkRnfsIO/EN5rfLivPXtBjOrKEnDUTWwo1Veec7kOoSQI+113RzqCUtaVxKYAonmbj6s
 e1mnqEEldeEqx/bJAvBk4ctZt+As+YzpKp59ymGj9VvaW2jTbwsZS9lWiljFjXBEgLAJ
 0pvXgOecdB+Ed0qXc/UfldfL8tXqMFmMA66qHv697NdvsMnIyA0hG8fvx22Fs1IZfGmE
 XviXlGChg8qY6ugUU/d8pCG/qDAilMuvgnd4JgSBya1Il1WP0PE0lQ3mOwfz5afdinKj
 LN4eLRrtntCpoIUidv4qjcTkmOHRBcqzCXLr5LrLjy79cgOlo45BByzwaeGdvbSee5HO aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=d0uU65Z04im+BrtimXWGyB6YZa/jBywtmtJQJXOqv7E=;
 b=PSpUlK/ikqLNeuQQltf+DgLyJBJcWWu3Iwp9nFmMQnG9/ALsbuXD2pyphmqxLbOJ2FqL
 Qy6U4elNXd52nesqzG7+aa+p6WSNz0qmb9Tu8O5DI5m2FZIFlVPMsHT4f5scLzu1jHAx
 2L/die7wqSIthSCB1ES96oQsJ2yY232utujPOEO81evLj/AI3ZjIt1MfI3fXUHUukyZx
 qodzVLlfiYNJCc15FGmqBxVnBDCIp8A6sONf3x1qfPBQyvpLOigkSWO35/ALQU83XG0S
 n5hPpQm5VpmuvfDKJtlvM7EKP/6/zxCC/Y5z7aCDb+BnD2xGIAyCCNWvEOl/Ki4FsOJr tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqbvms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68YLF049765;
        Tue, 13 Aug 2019 06:11:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u9k1w41j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:37 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6BawQ026730;
        Tue, 13 Aug 2019 06:11:36 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:36 -0700
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
Subject: [RFC 12/19] ktf: Main part of user land library for executing tests
Date:   Tue, 13 Aug 2019 08:09:27 +0200
Message-Id: <45a49a1c8c826254db169e104f1d50b389e02a03.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implementation of the main part of the user library to communicate
with the kernel side of ktf about tests, configuration and test
results.

ktf.h:           User mode side of KTF extensions to the gtest unit test framework.
ktf_int.cc:     Implementation of Gtest user land test management
ktf_int.h:       User mode side of extension to the gtest unit test framework:

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/lib/Makefile   |   21 +-
 tools/testing/selftests/ktf/lib/ktf.h      |  114 ++-
 tools/testing/selftests/ktf/lib/ktf_int.cc | 1031 +++++++++++++++++++++-
 tools/testing/selftests/ktf/lib/ktf_int.h  |   84 ++-
 4 files changed, 1250 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/lib/Makefile
 create mode 100644 tools/testing/selftests/ktf/lib/ktf.h
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_int.cc
 create mode 100644 tools/testing/selftests/ktf/lib/ktf_int.h

diff --git a/tools/testing/selftests/ktf/lib/Makefile b/tools/testing/selftests/ktf/lib/Makefile
new file mode 100644
index 0000000..c2be04b
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/Makefile
@@ -0,0 +1,21 @@
+
+GTEST_CFLAGS ?= -I$(GTEST_PATH)/include -DGTEST_HAS_PTHREAD=1 -lpthread
+GTEST_LIBS ?= -L$(GTEST_PATH)/lib64 -lgtest -lpthread
+NETLINK_CFLAGS ?= $(shell pkgconf --cflags libnl-genl-3.0)
+HOST_EXTRACFLAGS = -I$(srctree)/$(src)/.. $(NETLINK_CFLAGS) $(GTEST_CFLAGS) \
+		-Wall -Werror -Wno-packed-bitfield-compat -D_GNU_SOURCE
+HOST_EXTRACXXFLAGS = -I$(srctree)/$(src)/.. $(NETLINK_CFLAGS) $(GTEST_CFLAGS) \
+		-Wall \
+		-Wno-packed-bitfield-compat \
+		-Wno-pointer-arith -Werror \
+		-D__FILENAME__=\"`basename $<`\"
+
+hostcxxlibs-y := libktf.so
+libktf-cshobjs = ktf_unlproto.o
+libktf-cxxshobjs = ktf_int.o ktf_run.o ktf_debug.o
+
+targets := $(addprefix $(obj)/,$(libktf-cshobjs)) \
+	   $(addprefix $(obj)/,$(libktf-cxxshobjs)) \
+	   $(addprefix $(obj)/,$(hostcxxlibs-y))
+
+__build: $(targets)
diff --git a/tools/testing/selftests/ktf/lib/ktf.h b/tools/testing/selftests/ktf/lib/ktf.h
new file mode 100644
index 0000000..942eb28
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf.h
@@ -0,0 +1,114 @@
+/*
+ * Copyright (c) 2011, 2018, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf.h: User mode side of KTF extensions to the gtest unit test framework.
+ * Include this to write hybrid tests
+ *
+ */
+#ifndef _KTF_H
+#define _KTF_H
+#include <gtest/gtest.h>
+
+namespace ktf
+{
+
+  /* Interfaces intended to be used directly by programs:
+   * ----------------------------------------------------
+   */
+  class KernelTest;
+
+  /* Invoke the kernel test - to be called directly from user mode
+   * hybrid tests:
+   */
+  void run(KernelTest* kt, std::string ctx = "");
+
+  /* Function for enabling/disabling coverage for module */
+  int set_coverage(std::string module, unsigned int opts, bool enabled);
+
+  typedef void (*configurator)(void);
+
+  // Initialize KTF:
+  // If necessary, supply a callback that uses the KTF_CONTEXT_CFG* macros below
+  // to configure any necessary contexts:
+  void setup(configurator c = NULL);
+
+} // end namespace ktf
+
+/* HTEST: Define user part of a hybrid test.
+ * Hybrid tests are tests that have a user and a kernel counterpart,
+ * to allow testing of interaction between user mode and the kernel:
+ */
+#define HTEST(__setname,__testname)	\
+  class __setname ## _ ## __testname : public ktf::test_cb	\
+  {\
+  public:\
+    __setname ## _ ## __testname() {\
+      ktf::add_wrapper(#__setname,#__testname,as_test_cb()); \
+    }\
+    virtual void fun(ktf::KernelTest* kt);	\
+  }; \
+  __setname ## _ ## __testname \
+     __setname ## _ ## __testname ## _value;\
+  void __setname ## _ ## __testname::fun(ktf::KernelTest* self)
+
+
+/* Part of KTF support for hybrid tests: allocate/get a reference to
+ * an out-of-band user data pointer:
+ */
+#define KTF_USERDATA(__kt_ptr, __priv_datatype, __priv_data) \
+  struct __priv_datatype *__priv_data =	\
+    (struct __priv_datatype *)get_priv(__kt_ptr, sizeof(struct __priv_datatype)); \
+  ASSERT_TRUE(__priv_data); \
+  ASSERT_EQ(get_priv_sz(__kt_ptr), sizeof(struct __priv_datatype))
+
+/* KTF support for configurable contexts:
+ * Send a configuation data structure to the given context name.
+ */
+#define KTF_CONTEXT_CFG(__context_name, __context_type_name, __priv_datatype, __priv_data) \
+  ktf::configure_context(__context_name, __context_type_name, \
+  			 (struct __priv_datatype *)__priv_data, \
+			 sizeof(__priv_datatype))
+/* Alternative to KTF_CONTEXT_CFG: If there are multiple contexts with the same name
+ * (but with different handles) use a test name to identify the context to be configured
+ */
+#define KTF_CONTEXT_CFG_FOR_TEST(__test_name, __context_type_name, __priv_datatype, __priv_data) \
+  ktf::configure_context_for_test(__test_name, __context_type_name, \
+				  (struct __priv_datatype *)__priv_data, \
+				  sizeof(__priv_datatype))
+
+
+
+/* Private interfaces (needed by macro definitions above)
+ * ------------------------------------------------------
+ */
+
+namespace ktf {
+  class test_cb
+  {
+  public:
+    virtual ~test_cb() {}
+    virtual test_cb* as_test_cb() { return this; }
+    virtual void fun(KernelTest* kt) {}
+  };
+
+  /* Function for adding a user level test wrapper */
+  void add_wrapper(const std::string setname, const std::string testname,
+		   test_cb* tcb);
+
+  /* get a priv pointer of the given size, allocate if necessary */
+  void* get_priv(KernelTest* kt, size_t priv_sz);
+
+  /* Get the size of the existing priv data */
+  size_t get_priv_sz(KernelTest *kt);
+
+  // Configure ktf context - to be used via KTF_CONTEXT_CFG*():
+  void configure_context(const std::string context, const std::string type_name,
+			 void *data, size_t data_sz);
+  void configure_context_for_test(const std::string testname, const std::string type_name,
+				  void *data, size_t data_sz);
+} // end namespace ktf
+
+#endif
diff --git a/tools/testing/selftests/ktf/lib/ktf_int.cc b/tools/testing/selftests/ktf/lib/ktf_int.cc
new file mode 100644
index 0000000..6ac1f54
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf_int.cc
@@ -0,0 +1,1031 @@
+/*
+ * Copyright (c) 2012, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_int.cpp: Implementation of Gtest user land test management
+ * for kernel and hybrid test functionality provided by KTF.
+ */
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <unistd.h>
+#include "kernel/ktf_unlproto.h"
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <map>
+#include <set>
+#include <string>
+#include "ktf_int.h"
+#include "ktf_debug.h"
+
+#include <netlink/version.h>
+
+int devcnt = 0;
+
+namespace ktf
+{
+
+struct nl_sock* sock = NULL;
+int family = -1;
+
+int printed_header = 0;
+
+typedef std::map<std::string, KernelTest*> testmap;
+typedef std::map<std::string, test_cb*> wrappermap;
+
+class testset
+{
+public:
+  testset() : setnum(0)
+  { }
+
+  ~testset()
+  {
+    for (testmap::iterator it = tests.begin(); it != tests.end(); ++it)
+      delete it->second;
+  }
+
+  testmap tests;
+  stringvec test_names;
+  wrappermap wrapper;
+  int setnum;
+};
+
+/* ConfigurableContext keeps track of a ktf_context that requires configuration.
+ * Context names are unique within a handle, so a handle ID is necessary to
+ * identify the context. The actual configuration data must be agreed upon between
+ * user mode and kernel mode on a per context basis. They can use type_id
+ * to identify which type of parameter a context needs.
+ * The type_id is also used to create new contexts in the kernel.
+ * The kernel implementation must enable such dynamically extensible context sets
+ * on a per type_id basis.
+ */
+class ConfigurableContext
+{
+public:
+  ConfigurableContext(const std::string& name, const std::string& type_name,
+		      unsigned int hid, int cfg_stat);
+
+  std::string str_state();
+  int Configure(void *data, size_t data_sz);
+
+  const std::string& Type()
+  {
+    return type_name;
+  }
+
+  std::string name;
+  int handle_id;
+  std::string type_name;
+  int cfg_stat;
+};
+
+typedef std::map<std::string, testset> setmap;
+typedef std::set<std::string> stringset;
+typedef std::vector<ConfigurableContext*> context_vector;
+
+struct name_iter
+{
+  setmap::iterator it;
+  std::string setname;
+};
+
+class ContextType
+{
+public:
+  ContextType(int handle_id, const std::string& type_name);
+  int handle_id;
+  std::string type_name;
+};
+
+  ContextType::ContextType(int hid, const std::string& tn)
+  : handle_id(hid),
+    type_name(tn)
+{}
+
+/* We trick the gtest template framework
+ * to get a new set of test names as a side effect of
+ * invocation of get_test_names()
+ */
+
+/* Wrap globals in an object to control init order and
+ * memory cleanup:
+ */
+class KernelTestMgr
+{
+public:
+  KernelTestMgr() : next_set(0), cur(NULL)
+  { }
+
+  ~KernelTestMgr();
+
+  testset& find_add_set(std::string& setname);
+  testset& find_add_test(std::string& setname, std::string& testname);
+  void add_test(const std::string& setname, const char* tname, unsigned int handle_id);
+  KernelTest* find_test(const std::string&setname, const std::string& testname, std::string* ctx);
+  void add_wrapper(const std::string setname, const std::string testname, test_cb* tcb);
+
+  stringvec& get_set_names() { return set_names; }
+  stringvec get_test_names();
+
+  stringvec get_testsets()
+  {
+    return set_names;
+  }
+
+  std::string get_current_setname()
+  {
+    return cur->setname;
+  }
+
+  stringvec& get_contexts(unsigned int id)
+  {
+    return handle_to_ctxvec[id];
+  }
+
+  void add_cset(unsigned int hid, stringvec& ctxs);
+  void add_ctype(unsigned int hid, const std::string& type_name);
+  std::vector<ConfigurableContext*> add_configurable_context(const std::string& ctx,
+							     const std::string& type_name,
+							     unsigned int hid, int cfg_stat);
+  std::vector<ConfigurableContext*> add_configurable_contexts(const std::string& ctx,
+							      std::vector<ContextType*> type_vec);
+  std::vector<ConfigurableContext*> find_contexts(const std::string& ctx, const std::string& type_name);
+
+  /* Contexts may be created on the fly if the kernel supports it for this type_name: */
+  std::vector<ConfigurableContext*> maybe_create_context(const std::string& ctx,
+							 const std::string& type_name);
+
+  /* Update the list of contexts returned from the kernel with a newly created one */
+  void add_context(unsigned int hid, const std::string& ctx);
+private:
+  setmap sets;
+  stringvec test_names;
+  stringvec set_names;
+  stringset kernelsets;
+  std::map<unsigned int, stringvec> handle_to_ctxvec;
+  std::map<std::string, context_vector> cfg_contexts;
+
+  // Context types that allows dynamically created contexts:
+  std::map<std::string, std::vector<ContextType*> > ctx_types;
+  int next_set;
+  name_iter* cur;
+};
+
+KernelTestMgr::~KernelTestMgr()
+{
+  std::map<std::string, context_vector>::iterator it;
+  for (it = cfg_contexts.begin(); it != cfg_contexts.end(); ++it)
+  {
+    context_vector::iterator vit;
+    for (vit = it->second.begin(); vit != it->second.end(); ++vit)
+      delete *vit;
+  }
+
+  std::map<std::string, std::vector<ContextType*> >::iterator tit;
+  for (tit = ctx_types.begin(); tit != ctx_types.end(); ++tit)
+  {
+    std::vector<ContextType*>::iterator ttit;
+    for (ttit = tit->second.begin(); ttit != tit->second.end(); ++ttit)
+      delete *ttit;
+  }
+}
+
+context_vector KernelTestMgr::find_contexts(const std::string& ctx, const std::string& type_name)
+{
+  std::map<std::string,context_vector>::iterator it;
+  it = cfg_contexts.find(ctx);
+  if (it == cfg_contexts.end())
+    return maybe_create_context(ctx, type_name);
+  else
+    return it->second;
+}
+
+context_vector KernelTestMgr::maybe_create_context(const std::string& ctx, const std::string& type_name)
+{
+  std::map<std::string, std::vector<ContextType*> >::iterator it;
+  it = ctx_types.find(type_name);
+  if (it == ctx_types.end())
+    return context_vector();
+  else
+    return add_configurable_contexts(ctx, it->second);
+}
+
+void KernelTestMgr::add_context(unsigned int hid, const std::string& ctx)
+{
+  handle_to_ctxvec[hid].push_back(ctx);
+}
+
+
+KernelTestMgr& kmgr()
+{
+  static KernelTestMgr kmgr_;
+  return kmgr_;
+}
+
+testset& KernelTestMgr::find_add_test(std::string& setname, std::string& testname)
+{
+  testset& ts(find_add_set(setname));
+  test_names.push_back(testname);
+  return ts;
+}
+
+testset& KernelTestMgr::find_add_set(std::string& setname)
+{
+  bool new_set = false;
+
+  log(KTF_DEBUG, "find_add_set(%s)\n", setname.c_str());
+
+  stringset::iterator it = kernelsets.find(setname);
+  if (it == kernelsets.end()) {
+    kernelsets.insert(setname);
+    set_names.push_back(setname);
+    new_set = true;
+  }
+
+  /* This implicitly adds a new testset to sets, if it's not there: */
+  testset& ts = sets[setname];
+  if (new_set)
+  {
+    ts.setnum = next_set++;
+    log(KTF_INFO, "added %s (set %d) total %lu sets\n", setname.c_str(), ts.setnum, sets.size());
+  }
+  return ts;
+}
+
+
+void KernelTestMgr::add_test(const std::string& setname, const char* tname,
+			     unsigned int handle_id)
+{
+  log(KTF_INFO_V, "add_test: %s.%s", setname.c_str(),tname);
+  logs(KTF_INFO_V,
+       if (handle_id)
+	 fprintf(stderr, " [id %d]\n", handle_id);
+       else
+	 fprintf(stderr, "\n"));
+  std::string name(tname);
+  new KernelTest(setname, tname, handle_id);
+}
+
+
+/* Here we might get called with test names expanded with context names */
+KernelTest* KernelTestMgr::find_test(const std::string&setname,
+				     const std::string& testname,
+				     std::string* pctx)
+{
+  size_t pos;
+  log(KTF_DEBUG, "find test %s.%s\n", setname.c_str(), testname.c_str());
+
+  /* Try direct lookup first: */
+  KernelTest* kt = sets[setname].tests[testname];
+  if (kt) {
+    *pctx = std::string();
+    return kt;
+  }
+
+  /* If we don't have any contexts set, no need to parse name: */
+  if (handle_to_ctxvec.empty())
+    return NULL;
+
+  pos = testname.find_last_of('_');
+  while (pos >= 0) {
+    std::string tname = testname.substr(0,pos);
+    std::string ctx = testname.substr(pos + 1, testname.npos);
+    *pctx = ctx;
+    kt = sets[setname].tests[tname];
+    if (kt)
+      return kt;
+    /* context name might contain an '_' , iterate on: */
+    pos = tname.find_last_of('_');
+  }
+  return NULL;
+}
+
+
+void KernelTestMgr::add_cset(unsigned int hid, stringvec& ctxs)
+{
+  log(KTF_INFO, "hid %d: ", hid);
+  logs(KTF_INFO, for (stringvec::iterator it = ctxs.begin(); it != ctxs.end(); ++it)
+	 fprintf(stderr, "%s ", it->c_str());
+       fprintf(stderr, "\n"));
+  handle_to_ctxvec[hid] = ctxs;
+}
+
+void KernelTestMgr::add_ctype(unsigned int hid, const std::string& type_name)
+{
+  log(KTF_INFO, "hid %d: dynamical type: %s\n", hid, type_name.c_str());
+  ctx_types[type_name].push_back(new ContextType(hid, type_name));
+}
+
+std::vector<ConfigurableContext*> KernelTestMgr::add_configurable_context(const std::string& ctx,
+									  const std::string& type_name,
+									  unsigned int hid, int cfg_stat)
+{
+  cfg_contexts[ctx].push_back(new ConfigurableContext(ctx, type_name, hid, cfg_stat));
+  return cfg_contexts[ctx];
+}
+
+/* Function for adding a wrapper user level test */
+void KernelTestMgr::add_wrapper(const std::string setname, const std::string testname,
+				test_cb* tcb)
+{
+  log(KTF_DEBUG, "add_wrapper: %s.%s\n", setname.c_str(),testname.c_str());
+  testset& ts = sets[setname];
+
+  /* Depending on C++ initialization order which vary between compiler version
+   * (sigh!) either the kernel tests have already been processed or we have to store
+   * this object in wrapper for later insertion:
+   */
+  KernelTest *kt = ts.tests[testname];
+  if (kt) {
+    log(KTF_DEBUG_V, "Assigning user_test for %s.%s\n",
+	setname.c_str(), testname.c_str());
+    kt->user_test = tcb;
+  } else {
+    log(KTF_DEBUG_V, "Set wrapper for %s.%s\n",
+	setname.c_str(), testname.c_str());
+    ts.wrapper[testname] = tcb;
+  }
+}
+
+std::vector<ConfigurableContext*> KernelTestMgr::add_configurable_contexts(const std::string& ctx,
+									   std::vector<ContextType*> type_vec)
+{
+  std::vector<ContextType*>::iterator it = type_vec.begin();
+  for (; it != type_vec.end(); ++it) {
+    /* We use ENODEV (instead of the kernel's ENOENT to indicate to ConfigurableContext that
+     * this context was not reported in the query, and thus need to be added locally upon a
+     * successful configuration:
+     */
+    cfg_contexts[ctx].push_back(new ConfigurableContext(ctx, (*it)->type_name, (*it)->handle_id, ENODEV));
+  }
+  return cfg_contexts[ctx];
+}
+
+
+stringvec KernelTestMgr::get_test_names()
+{
+  if (!cur) {
+    cur = new name_iter();
+    cur->it = sets.begin();
+  }
+
+  /* Filter out any combined tests that do not have a kernel counterpart loaded */
+  while (cur->it->second.wrapper.size() != 0 && cur->it != sets.end()) {
+    if (cur->it->second.test_names.size() == 0)
+      log(KTF_INFO, "Note: Skipping test suite %s which has combined tests with no kernel counterpart\n",
+	  cur->it->first.c_str());
+    ++(cur->it);
+  }
+
+  if (cur->it == sets.end()) {
+    delete cur;
+    cur = NULL;
+    return stringvec();
+  }
+
+  stringvec& v = cur->it->second.test_names;
+  cur->setname = cur->it->first;
+
+  ++(cur->it);
+  return v;
+}
+
+ConfigurableContext::ConfigurableContext(const std::string& name_, const std::string& type_name_,
+                                         unsigned int hid, int cfg_stat_)
+  : name(name_),
+    handle_id(hid),
+    type_name(type_name_),
+    cfg_stat(cfg_stat_)
+{
+  log(KTF_INFO, "%s[%s] (hid %d): state: %s\n",
+      name.c_str(), type_name.c_str(), hid, str_state().c_str());
+}
+
+std::string ConfigurableContext::str_state()
+{
+  switch (cfg_stat) {
+  case 0:
+    return std::string("READY");
+  case ENOENT:
+    return std::string("UNCONFIGURED");
+  case ENODEV:
+    return std::string("UNCREATED");
+  default:
+    char tmp[100];
+    sprintf(tmp, "ERROR(%d)", cfg_stat);
+    return std::string(tmp);
+  }
+}
+
+int ConfigurableContext::Configure(void *data, size_t data_sz)
+{
+  struct nl_msg *msg = nlmsg_alloc();
+  int err;
+
+  log(KTF_INFO, "%s, data_sz %lu\n", name.c_str(), data_sz);
+  genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_REQUEST,
+              KTF_C_REQ, 1);
+  nla_put_u32(msg, KTF_A_TYPE, KTF_CT_CTX_CFG);
+  nla_put_u64(msg, KTF_A_VERSION, KTF_VERSION_LATEST);
+  nla_put_string(msg, KTF_A_STR, name.c_str());
+  nla_put_u32(msg, KTF_A_HID, handle_id);
+  nla_put_string(msg, KTF_A_FILE, type_name.c_str());
+  nla_put(msg, KTF_A_DATA, data_sz, data);
+
+  // Send message over netlink socket
+  nl_send_auto_complete(sock, msg);
+
+  // Free message
+  nlmsg_free(msg);
+
+  // Wait for acknowledgement:
+  // This function also returns error status if the message
+  // was not deemed ok by the kernel, but the error status
+  // does not resemble what the netlink recipient returned.
+  //
+  // This message receives no response beyond the error code.
+  //
+  err = nl_wait_for_ack(sock);
+
+  if (!err && cfg_stat == ENODEV) {
+    // Successfully added a new context, update it's state and
+    // tell kmgr() about it:
+    kmgr().add_context(handle_id, name);
+    cfg_stat = 0;
+  }
+  return err;
+}
+
+void *get_priv(KernelTest *kt, size_t sz)
+{
+  return kt->get_priv(sz);
+}
+
+size_t get_priv_sz(KernelTest *kt)
+{
+  return kt->user_priv_sz;
+}
+
+int set_coverage(std::string module, unsigned int opts, bool enabled)
+{
+  struct nl_msg *msg;
+  int err;
+
+  msg = nlmsg_alloc();
+  genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_REQUEST,
+              KTF_C_REQ, 1);
+  nla_put_u32(msg, KTF_A_TYPE,
+  	      enabled ? KTF_CT_COV_ENABLE : KTF_CT_COV_DISABLE);
+  nla_put_u32(msg, KTF_A_COVOPT, opts);
+  nla_put_u64(msg, KTF_A_VERSION, KTF_VERSION_LATEST);
+  nla_put_string(msg, KTF_A_MOD, module.c_str());
+
+  // Send message over netlink socket
+  nl_send_auto_complete(sock, msg);
+
+  // Free message
+  nlmsg_free(msg);
+
+  //Wait for acknowledgement:
+  // This function also returns error status if the message
+  // was not deemed ok by the kernel.
+  //
+  err = nl_wait_for_ack(sock);
+  if (err == 0) {
+	// Then wait for the answer and receive it
+	nl_recvmsgs_default(sock);
+  }
+  return err;
+}
+
+  KernelTest::KernelTest(const std::string& sn, const char* tn, unsigned int handle_id)
+  : setname(sn),
+    testname(tn),
+    setnum(0),
+    testnum(0),
+    user_priv(NULL),
+    user_priv_sz(0),
+    user_test(NULL),
+    file(NULL),
+    line(-1)
+{
+
+  name = setname;
+  name.append(".");
+  name.append(testname);
+
+  testset& ts(kmgr().find_add_test(setname, testname));
+  setnum = ts.setnum;
+  ts.tests[testname] = this;
+
+  if (!handle_id)
+    ts.test_names.push_back(testname);
+  else {
+    stringvec& ctxv = kmgr().get_contexts(handle_id);
+    for (stringvec::iterator it = ctxv.begin(); it != ctxv.end(); ++it)
+      ts.test_names.push_back(testname + "_" + *it);
+  }
+  testnum = ts.tests.size();
+
+  wrappermap::iterator hit = ts.wrapper.find(testname);
+  if (hit != ts.wrapper.end()) {
+    log(KTF_DEBUG_V, "Assigning user_test from wrapper for %s.%s\n",
+	setname.c_str(), testname.c_str());
+    user_test = hit->second;
+    /* Clear out wrapper entry as we skip any test sets
+     * with nonempty wrapper lists during test execution:
+     */
+    ts.wrapper.erase(hit);
+  }
+}
+
+
+KernelTest::~KernelTest()
+{
+  if (user_priv)
+    free(user_priv);
+}
+
+void* KernelTest::get_priv(size_t p_sz)
+{
+  if (!user_priv) {
+    user_priv = malloc(p_sz);
+    if (user_priv)
+      user_priv_sz = p_sz;
+  }
+  return user_priv;
+}
+
+static int parse_cb(struct nl_msg *msg, void *arg);
+static int debug_cb(struct nl_msg *msg, void *arg);
+static int error_cb(struct nl_msg *msg, void *arg);
+
+int nl_connect(void)
+{
+  /* Allocate a new netlink socket */
+  sock = nl_socket_alloc();
+  if (sock == NULL){
+    fprintf(stderr, "Failed to allocate a nl socket");
+    exit(1);
+  }
+
+  /* Connect to generic netlink socket on kernel side */
+  int stat = genl_connect(sock);
+  if (stat) {
+    fprintf(stderr, "Failed to open generic netlink connection");
+    exit(1);
+  }
+
+  /* Ask kernel to resolve family name to family id */
+  family = genl_ctrl_resolve(sock, "ktf");
+  if (family <= 0) {
+    fprintf(stderr, "Netlink protocol family for ktf not found - is the ktf module loaded?\n");
+    exit(1);
+  }
+
+  /* Specify the generic callback functions for messages */
+  nl_socket_modify_cb(sock, NL_CB_VALID, NL_CB_CUSTOM, parse_cb, NULL);
+  nl_socket_modify_cb(sock, NL_CB_INVALID, NL_CB_CUSTOM, error_cb, NULL);
+  return 0;
+}
+
+
+void default_test_handler(int result,  const char* file, int line, const char* report)
+{
+  if (result >= 0) {
+    fprintf(stderr, "default_test_handler: Result %d: %s,%d\n",result,file,line);
+  } else {
+    fprintf(stderr, "default_test_handler: Result %d\n",result);
+  }
+}
+
+test_handler handle_test = default_test_handler;
+
+bool setup(test_handler ht)
+{
+  ktf_debug_init();
+  handle_test = ht;
+  return nl_connect() == 0;
+}
+
+
+configurator do_context_configure = NULL;
+
+void set_configurator(configurator c)
+{
+  do_context_configure = c;
+}
+
+/* Query kernel for available tests in index order */
+stringvec& query_testsets()
+{
+  struct nl_msg *msg;
+  int err;
+
+  msg = nlmsg_alloc();
+  genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_REQUEST,
+	      KTF_C_REQ, 1);
+  nla_put_u32(msg, KTF_A_TYPE, KTF_CT_QUERY);
+  nla_put_u64(msg, KTF_A_VERSION, KTF_VERSION_LATEST);
+
+  // Send message over netlink socket
+  nl_send_auto_complete(sock, msg);
+
+  // Free message
+  nlmsg_free(msg);
+
+  // Wait for acknowledgement:
+  // This function also returns error status if the message
+  // was not deemed ok by the kernel.
+  //
+  err = nl_wait_for_ack(sock);
+  if (err < 0) {
+    errno = -err;
+    return kmgr().get_set_names();
+  }
+
+  // Then wait for the answer and receive it
+  nl_recvmsgs_default(sock);
+  return kmgr().get_set_names();
+}
+
+stringvec get_test_names()
+{
+  return kmgr().get_test_names();
+}
+
+std::string get_current_setname()
+{
+  return kmgr().get_current_setname();
+}
+
+KernelTest* find_test(const std::string&setname, const std::string& testname, std::string* ctx)
+{
+  return kmgr().find_test(setname, testname, ctx);
+}
+
+void add_wrapper(const std::string setname, const std::string testname, test_cb* tcb)
+{
+  kmgr().add_wrapper(setname, testname, tcb);
+}
+
+void run_test(KernelTest* kt, std::string& ctx)
+{
+  if (kt->user_test)
+    kt->user_test->fun(kt);
+  else
+    run(kt, ctx);
+}
+
+/* Run the kernel test */
+void run(KernelTest* kt, std::string context)
+{
+  struct nl_msg *msg;
+
+  log(KTF_DEBUG_V, "START kernel test (%ld,%ld): %s\n", kt->setnum,
+		kt->testnum, kt->name.c_str());
+
+  msg = nlmsg_alloc();
+  genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_REQUEST,
+	      KTF_C_REQ, 1);
+  nla_put_u32(msg, KTF_A_TYPE, KTF_CT_RUN);
+  nla_put_u64(msg, KTF_A_VERSION, KTF_VERSION_LATEST);
+  nla_put_string(msg, KTF_A_SNAM, kt->setname.c_str());
+  nla_put_string(msg, KTF_A_TNAM, kt->testname.c_str());
+
+  if (!context.empty())
+    nla_put_string(msg, KTF_A_STR, context.c_str());
+
+  /* Send any test specific out-of-band data */
+  if (kt->user_priv)
+    nla_put(msg, KTF_A_DATA, kt->user_priv_sz, kt->user_priv);
+
+  // Send message over netlink socket
+  nl_send_auto_complete(sock, msg);
+
+  // Free message
+  nlmsg_free(msg);
+
+  // Wait for acknowledgement - otherwise
+  // nl_recvmsg_default will sometimes take the ack for the next message..
+  int err = nl_wait_for_ack(sock);
+  if (err < 0) {
+    errno = -err;
+    return;
+  }
+
+  // Wait for the answer and receive it
+  nl_recvmsgs_default(sock);
+
+  log(KTF_DEBUG_V, "END   ktf::run_kernel_test %s\n", kt->name.c_str());
+}
+
+
+void configure_context(const std::string context, const std::string type_name, void *data, size_t data_sz)
+{
+  context_vector ct = kmgr().find_contexts(context, type_name);
+  ASSERT_GE(ct.size(), 1UL) << " - no context found named " << context;
+  ASSERT_EQ(ct.size(), 1UL) << " - More than one context named " << context
+			  << " - use KTF_CONTEXT_CFG_FOR_TEST to uniquely identify context.";
+  ASSERT_EQ(type_name, ct[0]->Type());
+  ASSERT_EQ(ct[0]->Configure(data, data_sz), 0);
+}
+
+void configure_context_for_test(const std::string& setname, const std::string& testname,
+				const std::string& type_name, void *data, size_t data_sz)
+{
+  std::string context;
+  KernelTest *kt = kmgr().find_test(setname, testname, &context);
+  context_vector ct = kmgr().find_contexts(context, type_name);
+  ASSERT_TRUE(kt) << " Could not find test " << setname << "." << testname;
+  int handle_id = kt->handle_id;
+  ASSERT_NE(handle_id, 0) << " test " << setname << "." << testname << " does not have a context";
+
+  for (context_vector::iterator it = ct.begin(); it != ct.end(); ++it)
+    if ((*it)->handle_id == handle_id)
+    {
+      ASSERT_EQ(type_name, (*it)->Type());
+      ASSERT_EQ((*it)->Configure(data, data_sz), 0);
+      return;
+    }
+  ASSERT_TRUE(false) << " unconfigurable context found for test " << setname << "." << testname << "?";
+}
+
+
+static nl_cb_action parse_one_set(std::string& setname,
+				  std::string& testname, struct nlattr* attr)
+{
+  int rem = 0;
+  struct nlattr *nla;
+  const char* msg;
+  unsigned int handle_id = 0;
+
+  nla_for_each_nested(nla, attr, rem) {
+    switch (nla_type(nla)) {
+    case KTF_A_HID:
+      handle_id = nla_get_u32(nla);
+      break;
+    case KTF_A_STR:
+      msg = nla_get_string(nla);
+      kmgr().add_test(setname, msg, handle_id);
+      handle_id = 0;
+      break;
+    default:
+      fprintf(stderr,"parse_result: Unexpected attribute type %d\n", nla_type(nla));
+      return NL_SKIP;
+    }
+  }
+  return NL_OK;
+}
+
+
+
+static int parse_query(struct nl_msg *msg, struct nlattr** attrs)
+{
+  int alloc = 0, rem = 0, rem2 = 0, cfg_stat;
+  nl_cb_action stat;
+  std::string setname,testname,ctx;
+
+  /* Version 0.1.0.0 did not report version back from the kernel */
+  uint64_t kernel_version = (KTF_VERSION_SET(MAJOR, 0ULL) | KTF_VERSION_SET(MINOR, 1ULL));
+
+  if (attrs[KTF_A_VERSION])
+    kernel_version = nla_get_u64(attrs[KTF_A_VERSION]);
+
+  /* We only got here if we were compatible enough, log that we had differences */
+  if (kernel_version != KTF_VERSION_LATEST)
+  {
+    const char* note = "Note";
+    bool is_compatible =
+      KTF_VERSION(MAJOR, KTF_VERSION_LATEST) == KTF_VERSION(MAJOR, kernel_version) &&
+      KTF_VERSION(MINOR, KTF_VERSION_LATEST) == KTF_VERSION(MINOR, kernel_version);
+    if (!is_compatible)
+      note = "Error";
+
+    fprintf(stderr,
+	    "%s: KTF version difference - user lib %llu.%llu.%llu.%llu, kernel has %llu.%llu.%llu.%llu\n",
+	    note,
+	    KTF_VERSION(MAJOR, KTF_VERSION_LATEST),
+	    KTF_VERSION(MINOR, KTF_VERSION_LATEST),
+	    KTF_VERSION(MICRO, KTF_VERSION_LATEST),
+	    KTF_VERSION(BUILD, KTF_VERSION_LATEST),
+	    KTF_VERSION(MAJOR, kernel_version),
+	    KTF_VERSION(MINOR, kernel_version),
+	    KTF_VERSION(MICRO, kernel_version),
+	    KTF_VERSION(BUILD, kernel_version));
+    if (!is_compatible)
+      return NL_SKIP;
+  }
+
+  if (attrs[KTF_A_HLIST]) {
+    struct nlattr *nla, *nla2;
+    stringvec contexts;
+    unsigned int handle_id = 0;
+    const char* type_name = NULL;
+
+    /* Parse info on handle IDs and associated contexts and/or
+     * types that allows dynamical creation of new contexts
+     * (defined here via KTF_A_FILE):
+     */
+    nla_for_each_nested(nla, attrs[KTF_A_HLIST], rem) {
+      switch (nla_type(nla)) {
+      case KTF_A_HID:
+	handle_id = nla_get_u32(nla);
+	break;
+      case KTF_A_LIST:
+	nla_for_each_nested(nla2, nla, rem2) {
+	  switch (nla_type(nla2)) {
+	  case KTF_A_FILE:
+	    type_name = nla_get_string(nla2);
+	    kmgr().add_ctype(handle_id, type_name);
+	    break;
+	  case KTF_A_STR:
+	    ctx = nla_get_string(nla2);
+	    contexts.push_back(ctx);
+	    break;
+	  case KTF_A_MOD:
+	    type_name = nla_get_string(nla2);
+	    break;
+	  case KTF_A_STAT:
+	    cfg_stat = nla_get_u32(nla2);
+	    kmgr().add_configurable_context(ctx, type_name, handle_id, cfg_stat);
+	    break;
+	  }
+	}
+	/* Add this set of contexts for the handle_id */
+	kmgr().add_cset(handle_id, contexts);
+	handle_id = 0;
+	contexts.clear();
+	break;
+      default:
+	fprintf(stderr,"parse_query[HLIST]: Unexpected attribute type %d\n", nla_type(nla));
+	return NL_SKIP;
+      }
+    }
+  }
+
+  // Now we know enough about contexts and type_ids to actually configure
+  // any contexts that needs to be configured, and this must be
+  // done before the list of tests gets spanned out because addition
+  // of new contexts can lead to more tests being "generated":
+  //
+  if (do_context_configure)
+    do_context_configure();
+
+  if (attrs[KTF_A_NUM]) {
+    alloc = nla_get_u32(attrs[KTF_A_NUM]);
+    log(KTF_DEBUG, "Kernel offers %d test sets:\n", alloc);
+  } else {
+    fprintf(stderr,"No test set count in kernel response??\n");
+    return -1;
+  }
+
+  if (attrs[KTF_A_LIST]) {
+    struct nlattr *nla;
+
+    /* Parse info on test sets */
+    nla_for_each_nested(nla, attrs[KTF_A_LIST], rem) {
+      switch (nla_type(nla)) {
+      case KTF_A_STR:
+	setname = nla_get_string(nla);
+	break;
+      case KTF_A_TEST:
+	stat = parse_one_set(setname, testname, nla);
+	if (stat != NL_OK)
+	  return stat;
+	break;
+      default:
+	fprintf(stderr,"parse_query[LIST]: Unexpected attribute type %d\n", nla_type(nla));
+	return NL_SKIP;
+      }
+      kmgr().find_add_set(setname); /* Just to make sure empty sets are also added */
+    }
+  }
+
+  return NL_OK;
+}
+
+
+static enum nl_cb_action parse_result(struct nl_msg *msg, struct nlattr** attrs)
+{
+  int assert_cnt = 0, fail_cnt = 0;
+  int rem = 0, stat;
+  const char *file = "no_file",*report = "no_report";
+
+  if (attrs[KTF_A_STAT]) {
+    stat = nla_get_u32(attrs[KTF_A_STAT]);
+    log(KTF_DEBUG, "parsed test status %d\n", stat);
+    if (stat) {
+      fprintf(stderr, "Failed to execute test in kernel - status %d\n", stat);
+    }
+  }
+  if (attrs[KTF_A_LIST]) {
+    /* Parse list of test results */
+    struct nlattr *nla;
+    int result = -1, line = 0;
+    nla_for_each_nested(nla, attrs[KTF_A_LIST], rem) {
+      switch (nla_type(nla)) {
+      case KTF_A_STAT:
+	/* Flush previous test, if any */
+	handle_test(result,file,line,report);
+	result = nla_get_u32(nla);
+	/* Our own count and report since check does such a lousy
+	 * job in counting individual checks */
+	if (result)
+	  assert_cnt += result;
+	else {
+	  fail_cnt++;
+	  assert_cnt++;
+	}
+	break;
+      case KTF_A_FILE:
+	file = nla_get_string(nla);
+	if (!file)
+	  file = "no_file";
+	break;
+      case KTF_A_NUM:
+	line = nla_get_u32(nla);
+	break;
+      case KTF_A_STR:
+	report = nla_get_string(nla);
+	if (!report)
+	  report = "no_report";
+	break;
+      default:
+	fprintf(stderr,"parse_result: Unexpected attribute type %d\n", nla_type(nla));
+	return NL_SKIP;
+      }
+    }
+    /* Handle last test */
+    handle_test(result,file,line,report);
+  }
+
+  return NL_OK;
+}
+
+static enum nl_cb_action parse_cov_endis(struct nl_msg *msg, struct nlattr** attrs)
+{
+  enum ktf_cmd_type type = (ktf_cmd_type)nla_get_u32(attrs[KTF_A_TYPE]);
+  const char *cmd = type == KTF_CT_COV_ENABLE ? "enable" : "disable";
+  int retval = nla_get_u32(attrs[KTF_A_STAT]);
+
+  if (retval)
+    fprintf(stderr, "Coverage %s operation failed with status %d\n", cmd, retval);
+  return NL_OK;
+}
+
+static int parse_cb(struct nl_msg *msg, void *arg)
+{
+  struct nlmsghdr *nlh = nlmsg_hdr(msg);
+  int maxtype = KTF_A_MAX+10;
+  struct nlattr *attrs[maxtype];
+  enum ktf_cmd_type type;
+
+  //  memset(attrs, 0, sizeof(attrs));
+
+  /* Validate message and parse attributes */
+  int err = genlmsg_parse(nlh, 0, attrs, KTF_A_MAX, ktf_get_gnl_policy());
+  if (err < 0) return err;
+
+  if (!attrs[KTF_A_TYPE]) {
+    fprintf(stderr, "Received kernel response without a type\n");
+    return NL_SKIP;
+  }
+
+  type = (ktf_cmd_type)nla_get_u32(attrs[KTF_A_TYPE]);
+  switch (type) {
+  case KTF_CT_QUERY:
+    return parse_query(msg, attrs);
+  case KTF_CT_RUN:
+    return parse_result(msg, attrs);
+  case KTF_CT_COV_ENABLE:
+  case KTF_CT_COV_DISABLE:
+    return parse_cov_endis(msg, attrs);
+  default:
+    debug_cb(msg, attrs);
+  }
+  return NL_SKIP;
+}
+
+
+static int error_cb(struct nl_msg *msg, void *arg)
+{
+  struct nlmsghdr *nlh = nlmsg_hdr(msg);
+  fprintf(stderr, "Received invalid netlink message - type %d\n", nlh->nlmsg_type);
+  return NL_OK;
+}
+
+
+static int debug_cb(struct nl_msg *msg, void *arg)
+{
+  struct nlmsghdr *nlh = nlmsg_hdr(msg);
+  fprintf(stderr, "[Received netlink message of type %d]\n", nlh->nlmsg_type);
+    nl_msg_dump(msg, stderr);
+    return NL_OK;
+}
+
+} // end namespace ktf
diff --git a/tools/testing/selftests/ktf/lib/ktf_int.h b/tools/testing/selftests/ktf/lib/ktf_int.h
new file mode 100644
index 0000000..1a06533
--- /dev/null
+++ b/tools/testing/selftests/ktf/lib/ktf_int.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (c) 2011, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_int.h: User mode side of extension to the gtest unit test framework:
+ *  1) Kernel test support via netlink
+ *  2) Standard command line parameters
+ *
+ * This file exposes some internals - for users of hybrid tests including
+ * ktf.h should be sufficient:
+ */
+
+#ifndef KTF_INT_H
+#define KTF_INT_H
+#include <string>
+#include <vector>
+#include "ktf.h"
+
+typedef std::vector<std::string> stringvec;
+
+namespace ktf
+{
+
+  /* A callback handler to be called for each assertion result */
+  typedef void (*test_handler)(int result,  const char* file, int line, const char* report);
+
+  class KernelTest
+  {
+  public:
+    KernelTest(const std::string& setname, const char* testname, unsigned int handle_id);
+    ~KernelTest();
+    void* get_priv(size_t priv_sz);
+    size_t get_priv_sz(KernelTest *kt);
+    std::string setname;
+    std::string testname;
+    unsigned int handle_id;
+    std::string name;
+    size_t setnum;  /* This test belongs to this set in the kernel */
+    size_t testnum; /* This test's index (test number) in the kernel */
+    void* user_priv;  /* Optional private data for the test */
+    size_t user_priv_sz; /* Size of the user_priv data if used */
+    test_cb* user_test;  /* Optional user level wrapper function for the kernel test */
+    char* file;
+    int line;
+  };
+
+  void *get_priv(KernelTest *kt, size_t priv_sz);
+
+  // Set up connection to the kernel test driver:
+  // @handle_test contains the test framework's handling code for test assertions */
+  bool setup(test_handler handle_test);
+
+  void set_configurator(configurator c);
+
+  // Parse command line args (call after gtest arg parsing)
+  char** parse_opts(int argc, char** argv);
+
+  /* Query kernel for available tests in index order */
+  stringvec& query_testsets();
+
+  stringvec get_testsets();
+  std::string get_current_setname();
+  stringvec get_test_names();
+
+  KernelTest* find_test(const std::string& setname, const std::string& testname,
+			std::string* ctx);
+
+  /* "private" - only run from gtest framework */
+  void run_test(KernelTest* test, std::string& ctx);
+} // end namespace ktf
+
+
+/* Redefine for C++ until we can get it patched - type mismatch by default */
+#ifdef nla_for_each_nested
+#undef nla_for_each_nested
+#endif
+#define nla_for_each_nested(pos, nla, rem) \
+  for (pos = (struct nlattr*)nla_data(nla), rem = nla_len(nla);	\
+             nla_ok(pos, rem); \
+             pos = nla_next(pos, &(rem)))
+
+#endif
-- 
git-series 0.9.1
