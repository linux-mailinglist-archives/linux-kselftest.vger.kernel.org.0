Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93079468772
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Dec 2021 21:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhLDU1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Dec 2021 15:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhLDU1a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Dec 2021 15:27:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C19C061751;
        Sat,  4 Dec 2021 12:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCFC2B80D9B;
        Sat,  4 Dec 2021 20:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B123C341C2;
        Sat,  4 Dec 2021 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638649441;
        bh=5WZVVH3bfq4ugkAOV2uy7mIqMkhjOZgQDqG+Ih4lMGw=;
        h=From:To:Cc:Subject:Date:From;
        b=qL2AepS940NgOk+UoSD9Jh3+BSO4JOLGBA6BKS1zwW+X9OfGGLWUc1k5+Alck+Lsr
         Zg4sv51ofm6O1rFx/6xu4cRJkr6n6ewGiEc1lvylcEox8Gl4XN4f7NO+FfnppDKSIH
         OkSm6rljI6/IJnzaDdJsAiaJ/D3QdxxpXDG3tQh+ElyfiYbfKBqfxT4NX52YAgYjyj
         LrRMxqMeqFECtx3JADYjCxusX2bqERPpCbMMY6TDr9S4+tE6ppWEwk76F129JebNOS
         3YXud3Reuh4lDWM1bpMWVJVCIb8dgP3qyDwNgaemhUz1hkLYq7miClQr/YUtl0NcWG
         HpXAHL23UOQJw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH] selftests/sgx: Fix corrupted cpuid macro invocation
Date:   Sat,  4 Dec 2021 22:23:55 +0200
Message-Id: <20211204202355.23005-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compilation results:

$ make -C tools/testing/selftests/sgx/
make: Entering directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o
main.c: In function ‘get_total_epc_mem’:
main.c:296:17: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
  296 |                 __cpuid(&eax, &ebx, &ecx, &edx);
      |                 ^~~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile:33: /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o] Error 1
make: Leaving directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'

Include to cpuid.h is missing and the macro usage is incorrect.

Include cpuid.h and use __cpuid_count() macro in order to fix the
compilation issue.

Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 7e912db4c6c5..370c4995f7c4 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#include <cpuid.h>
 #include <elf.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -291,9 +292,7 @@ static unsigned long get_total_epc_mem(void)
 	int section = 0;
 
 	while (true) {
-		eax = SGX_CPUID;
-		ecx = section + SGX_CPUID_EPC;
-		__cpuid(&eax, &ebx, &ecx, &edx);
+		__cpuid_count(SGX_CPUID, section + SGX_CPUID_EPC, eax, ebx, ecx, edx);
 
 		type = eax & SGX_CPUID_EPC_MASK;
 		if (type == SGX_CPUID_EPC_INVALID)
-- 
2.32.0

