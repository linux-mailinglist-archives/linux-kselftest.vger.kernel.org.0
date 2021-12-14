Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D52474BDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhLNT0V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:26:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:13340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhLNT0U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639509980; x=1671045980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XSV+YeNkdlLKpNceb+MMS4Z9fxagz4iZ7SepDSjjwo4=;
  b=E8DoUiWyhFu/UkmYo142yy1f3om1PiWywwN0NY/ZYWkd9FdTc5U37AV1
   ogM4g0MhqzYM3JUczMIlpGiPhVk7wmOjNEataMNaQNT0kduXDg3wQbL7s
   kMbr7reUqIbrAi6NxcZOUCK8ngvbdjZImCeEx1/0lWXGszRPTbiKUIsIK
   zUvMnBqDX1WMhh3ojDHEkwr8WG7QiTs1zufKCFjgfxMLbgu8pO9TNmDej
   YqYcAri3DNM1Amp25PwjXDM4pOs9R1xsPj0q0HYuRTpcXSs6+KDjU6iQR
   tYy+i3RUp/UMFNFJg/qaoF1mdlCPVFo4XGDvPIc9ctAty9yeTjQAbEDOf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238879370"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="238879370"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 11:26:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="518416029"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 11:26:19 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH V2] selftests/sgx: Fix build error caused by missing dependency
Date:   Tue, 14 Dec 2021 11:26:08 -0800
Message-Id: <de2a262e97e7b173548b909a608e9e99aab38e9d.1639509500.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit f0ff2447b861 ("selftests/sgx: Add a new kselftest:
Unclobbered_vdso_oversubscribed") depends on __cpuid() without
providing the dependency and thus introduces a build error:

$ make
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o ../linux/tools/testing/selftests/sgx/main.o
main.c: In function ‘get_total_epc_mem’:
main.c:296:3: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
  296 |   __cpuid(&eax, &ebx, &ecx, &edx);
      |   ^~~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile:33: ../linux/tools/testing/selftests/sgx/main.o] Error 1
$

Clone kernel's __cpuid() implementation to the self-test in order
to make it available to the EPC enumeration code.

Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---

The commit introducing the issue can be found on
the x86/sgx branch of tip.git.

Changes since V1:
- V1: https://lore.kernel.org/linux-sgx/797ff1331cfe540fc378fcc4a4a7b00ff5099fbe.1638905135.git.reinette.chatre@intel.com/
- Improve commit message. (Jarkko)

 tools/testing/selftests/sgx/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 7e912db4c6c5..6dead57a3121 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -73,6 +73,18 @@ static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
 	return true;
 }
 
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}
+
 static unsigned long elf_sym_hash(const char *name)
 {
 	unsigned long h = 0, high;
-- 
2.25.1

