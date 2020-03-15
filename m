Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B53185BB2
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgCOJwT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Mar 2020 05:52:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:35235 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgCOJwS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Mar 2020 05:52:18 -0400
IronPort-SDR: dIffU8Q2LOE5vcyXK1LVWzC56NaARurmpf4b217Vp3nt8S0U0cjKuOMPfvv/mjZwnEchbEuHKV
 nm7hGB22a0MQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 02:52:18 -0700
IronPort-SDR: bG92V6x9NMRAyU/obRt+rtVwK/dscnZrlXiJ1BPqlcGSGDAPg6yUzQKXE0UvHpwWxBlsQAWWy1
 Kj1411CZnb/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,556,1574150400"; 
   d="scan'208";a="416800340"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.160])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2020 02:52:16 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/2] kvm: selftests: Fix no directory error when OUTPUT specified
Date:   Sun, 15 Mar 2020 17:34:24 +0800
Message-Id: <20200315093425.33600-2-xiaoyao.li@intel.com>
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

When build kvm selftests to an specified directory with

	make OUTPUT=~/kvm-selftests

it encouters following error：

/usr/bin/ld: cannot open output file
/home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test: No such file or
directory
collect2: error: ld returned 1 exit status
make: *** [../lib.mk:141:
/home/lxy/kvm-selftests/x86_64/cr4_cpuid_sync_test] Error 1

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d91c53b726e6..86797e0242d4 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -66,6 +66,7 @@ LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
 include ../lib.mk
+x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 
 STATIC_LIBS := $(OUTPUT)/libkvm.a
 LIBKVM_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM))
-- 
2.20.1

