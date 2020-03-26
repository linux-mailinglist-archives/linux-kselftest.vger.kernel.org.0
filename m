Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765601936D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 04:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgCZDZc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 23:25:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:53303 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgCZDZb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 23:25:31 -0400
IronPort-SDR: A0ca+m0uqk9CJSzqnYPy6jmOuyV3xfxzkHJ1fPWbxxVjBOo++XfBqmPbPq0iJfsmkH63Oc/0lr
 m8r2mBIHAuZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 20:25:30 -0700
IronPort-SDR: QUWJw+k2SY1p2euzekEuWODO1srN4VcPBN5w3SVYTpBm5hdqfTmPNWSMrZB6PcwIzxiMLBhgGB
 6bFumWCvIg/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="446842817"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga005.fm.intel.com with ESMTP; 25 Mar 2020 20:25:29 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [RFC v3 1/3] kvm: selftests: Fix no directory error when OUTPUT specified
Date:   Thu, 26 Mar 2020 11:07:48 +0800
Message-Id: <20200326030750.173972-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326030750.173972-1-xiaoyao.li@intel.com>
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When build kvm selftests to an specified directory with

	make OUTPUT=/home/lxy/kvm-selftests

it encouters following error：

  /usr/bin/ld: cannot open output file
  /home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test: No such file or
  directory
  collect2: error: ld returned 1 exit status
  make: *** [../lib.mk:141:
  /home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test] Error 1

Use "mkdir -p" to create the directory to fix this issue.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 67abc1dd50ee..91b41092def6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -65,6 +65,7 @@ LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
 include ../lib.mk
+x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 
 STATIC_LIBS := $(OUTPUT)/libkvm.a
 LIBKVM_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM))
-- 
2.20.1

