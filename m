Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8446C3C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 20:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhLGTnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 14:43:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:65345 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhLGTnl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 14:43:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="218351324"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="218351324"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 11:40:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="611804406"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 11:40:10 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/sgx: Fix build error caused by missing dependency
Date:   Tue,  7 Dec 2021 11:40:05 -0800
Message-Id: <797ff1331cfe540fc378fcc4a4a7b00ff5099fbe.1638905135.git.reinette.chatre@intel.com>
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
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /path/linux/tools/testing/selftests/sgx/main.o
main.c: In function ‘get_total_epc_mem’:
main.c:296:3: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
  296 |   __cpuid(&eax, &ebx, &ecx, &edx);
      |   ^~~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile:33: /path/linux/tools/testing/selftests/sgx/main.o] Error 1
$

Make the kernel's __cpuid() available locally in support of the
test's usage.

Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---

The commit introducing the issue can be found on
the x86/sgx branch of tip.git.

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

