Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF51936D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 04:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgCZDZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 23:25:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:53303 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgCZDZc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 23:25:32 -0400
IronPort-SDR: 2ZvOUvFipgrtC/+/70ki8SQTCD2EciENnR1DkuLtrmxuJkLUe2ZZIelbXkoam92TicHItSBPgI
 oSHgj8ykiqJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 20:25:32 -0700
IronPort-SDR: SMMRikgTPE1BcG7jtXIb5vkDyaUwV+cFjknm+8Pef9Wx1N2s5y6KaUmgAuJjGnWo4Z1wP4+mWG
 cRwc21N7b/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="446842824"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2020 20:25:30 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [RFC v3 2/3] kvm: selftests: Use the right INSTALL_HDR_PATH when OUTPUT specified and MAKELEVEL is 0
Date:   Thu, 26 Mar 2020 11:07:49 +0800
Message-Id: <20200326030750.173972-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326030750.173972-1-xiaoyao.li@intel.com>
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Assume linux headers exist in linux_src/usr works with OUTPUT specified
currently, even though headers are installed to $(OUTPUT)/usr based on
lib.mk. Because there are building output in linux_src/usr when
"make headers_install" to prepare headers and they are not cleaned.

Assign the correct path to INSTALL_HDR_PATH is always not bad.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 91b41092def6..6a95878b2ab7 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -43,7 +43,15 @@ TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
-INSTALL_HDR_PATH = $(top_srcdir)/usr
+ifeq (0,$(MAKELEVEL))
+    ifneq ($(OUTPUT),)
+	INSTALL_HDR_PATH := $(OUTPUT)/usr
+    else
+	INSTALL_HDR_PATH := $(top_srcdir)/usr
+    endif
+else
+	INSTALL_HDR_PATH := $(top_srcdir)/usr
+endif
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
-- 
2.20.1

