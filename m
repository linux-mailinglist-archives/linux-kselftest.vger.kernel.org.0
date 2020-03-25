Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D6192AFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCYOTO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 10:19:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgCYOTN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:13 -0400
IronPort-SDR: BVfOXygjUs27JU5dfykGrBJyiWV/fneE3FhEteFNCYtVgPZtcHMLGsiKW+KeNHvqJAL9GKy1Su
 5sc2eTj9NERg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:13 -0700
IronPort-SDR: SDkxVKOvB38VMkJiYWvbZ6iaVl6FimGKpYU/8lim85lOR8OdDR/jtTKip8gnEXHGmtjKgM8M4D
 whp6ZdZ9/SZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811083"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:11 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 2/6] selftests: kvm: Include lib.mk earlier
Date:   Wed, 25 Mar 2020 22:01:29 +0800
Message-Id: <20200325140133.103236-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Include lib.mk a little bit earlier so that common lib.mk can setup
environment earlier.

This is for the following patch to prepare INSTALL_HDR_PATH earlier.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 67abc1dd50ee..504a5fb0fa71 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -43,6 +43,10 @@ TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
+# After inclusion, $(OUTPUT) is defined and
+# $(TEST_GEN_PROGS) starts with $(OUTPUT)/
+include ../lib.mk
+
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
@@ -62,9 +66,6 @@ pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
 
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
-# After inclusion, $(OUTPUT) is defined and
-# $(TEST_GEN_PROGS) starts with $(OUTPUT)/
-include ../lib.mk
 
 STATIC_LIBS := $(OUTPUT)/libkvm.a
 LIBKVM_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM))
-- 
2.20.1

