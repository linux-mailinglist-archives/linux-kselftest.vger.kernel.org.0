Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59AB43E9A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhJ1UkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:25707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhJ1Uj6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:39:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230775398"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230775398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498562990"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:29 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/15] selftests/x86/sgx: Fix a benign linker warning
Date:   Thu, 28 Oct 2021 13:37:26 -0700
Message-Id: <545aac243037bf5c2640929c4d8ff5c1edfe3ef8.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
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
Suggested-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Change Cedric's signature to a "Suggested-by" (Jarkko and Cedric).
- Add signatures from Jarkko and Dave.

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

