Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76240CDF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhIOUce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:13812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231535AbhIOUcd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109358"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109358"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092772"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:12 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] selftests/x86/sgx: Fix a benign linker warning
Date:   Wed, 15 Sep 2021 13:30:51 -0700
Message-Id: <84b02b56d45792971cabf8ba832a9862fb20990e.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Pass a build id of "none" to the linker to suppress a warning about the
build id being ignored:

  /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
  ignored.

Link: https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christopherson@intel.com/
Co-developed-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 7f12d55b97f8..2956584e1e37 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -45,7 +45,7 @@ $(OUTPUT)/sign_key.o: sign_key.S
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
 
 $(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
-	$(CC) $(ENCL_CFLAGS) -T $^ -o $@
+	$(CC) $(ENCL_CFLAGS) -T $^ -o $@ -Wl,--build-id=none
 
 EXTRA_CLEAN := \
 	$(OUTPUT)/test_encl.elf \
-- 
2.25.1

