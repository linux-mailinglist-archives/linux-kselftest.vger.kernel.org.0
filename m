Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A565192AFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 15:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCYOTM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 10:19:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbgCYOTL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:11 -0400
IronPort-SDR: gXYpgOiS8QxktuKIAtLDG3QsmRtve/otHRnsBw45b99XqkJFW9q33QdVhTiX+I1kcLoSWc21E0
 NJfWVzeB4kmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:11 -0700
IronPort-SDR: AbZJ1HHcIw0fp+5/Lfc/do6mA+kSLGmHIYjxgBaP2nI33NpXdYsbbyawUwK1AD3HfREyBq2Hnx
 tUg5Eavt/Scw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811075"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:10 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 1/6] selftests: Create directory when OUTPUT specified
Date:   Wed, 25 Mar 2020 22:01:28 +0800
Message-Id: <20200325140133.103236-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When OUTPUT specified, it may encounter no directory error if there is
subdir in $TARGET for any of TEST_GEN_PROGS, TEST_GEN_PROGS_EXTENDED, or
TEST_GEN_FILES.

This issue is found by running

	make OUTPUT=/path/to/output

in tools/testing/selftests/kvm

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/lib.mk | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..78fb00bdf5c4 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,6 +20,16 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+ifneq ($(TEST_GEN_PROGS),)
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+endif
+ifneq ($(TEST_GEN_PROGS_EXTENDED),)
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS_EXTENDED))))
+endif
+ifneq ($(TEST_GEN_FILES),)
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_FILES))))
+endif
+
 ifdef KSFT_KHDR_INSTALL
 top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
-- 
2.20.1

