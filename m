Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4D185BB4
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgCOJwU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Mar 2020 05:52:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:35235 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgCOJwU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Mar 2020 05:52:20 -0400
IronPort-SDR: 3FhIF57IeQ1GUbr0RUlfWAorz1B9/Tf5M5T24QJQtxWq2yA7Kjas6jlbga4/Uw/erZFoqiBsG1
 OLZTsFkaa7WQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 02:52:20 -0700
IronPort-SDR: JpQOzDZRbO3fy47qbbqN5NnJJLo+3ecnApXfgUlxWX1PTLQ0/rUCjW8BEU7YgqVZAn6vAQQxJe
 u7JJs6/duXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,556,1574150400"; 
   d="scan'208";a="416800351"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.160])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2020 02:52:18 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 2/2] selftests: export INSTALL_HDR_PATH if using "O" to specify output dir
Date:   Sun, 15 Mar 2020 17:34:25 +0800
Message-Id: <20200315093425.33600-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200315093425.33600-1-xiaoyao.li@intel.com>
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When build kvm selftests in tools/testing/selftests directory with

	make O=~/kselftests TARGETS=kvm

it fails building some kvm test binaries due to lack of header files,
e.g.,

x86_64/vmx_set_nested_state_test.c: In function ‘set_default_vmx_state’:
x86_64/vmx_set_nested_state_test.c:85:7: error: ‘struct
kvm_nested_state’ has no member named ‘hdr’
  state->hdr.vmx.vmxon_pa = 0x1000;

kvm's Makefile unconditionally thinks kernel headers are installed
in the "kernel-src/usr" with "INSTALL_HDR_PATH = $(top_srcdir)/usr".
However, with "O" is specified, it also takes effect on
"make headers_install", that causes no header files generated in
"kernel-src/usr".

Export INSTALL_HDR_PATH when "O" is specified, so that kvm get the right
kernel headers by checking if INSTALL_HDR_PATH is defined.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/Makefile     | 6 +++++-
 tools/testing/selftests/kvm/Makefile | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6ec503912bea..5fd72d955e24 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -116,6 +116,10 @@ ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 
+ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
+export	INSTALL_HDR_PATH := $(BUILD)/usr
+endif
+
 # build and run gpio when output directory is the src dir.
 # gpio has dependency on tools/gpio and builds tools/gpio
 # objects in the src directory in all cases making the src
@@ -148,7 +152,7 @@ khdr:
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
 	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
+	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$(INSTALL_HDR_PATH) \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 86797e0242d4..c14d23c978d5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -44,7 +44,7 @@ TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
-INSTALL_HDR_PATH = $(top_srcdir)/usr
+INSTALL_HDR_PATH ?= $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
-- 
2.20.1

