Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81BE1E21FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 14:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbgEZMfC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 08:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389076AbgEZMfB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 08:35:01 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A7C03E96D
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 05:35:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49WYM431Ncz9sRW;
        Tue, 26 May 2020 22:34:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590496496;
        bh=nlmuxPZ4OAcgaEOWJJyC/a4yX3EnNdlg306uXa5AWVM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SLiZEO0TBai5zo5oWN8HDSJWMY3gH6u9hDSsLJe/HYYSSDwWXTIpffodrGTTWNSMx
         DlmC+YpjK7Cn65T3Z8GSUEx/S6IDg5fMyRS3RR1/sneUpU/VwN7yn6s2NEBC/Zk6LK
         F8EGeCL6HP2BBqsR3Q9i6L6qfV3RpFso/Tzt9MRpd4xwSHNSIXv48ZuF8z7rek2hk/
         vfzL4hjxoOU+SgbfD77T9OItD0rTosQ3mJbem2OFroxzwymuLF2m5UlOZE3FXavmLU
         oTfeMlLogZrs5xYwG2c0Hm4EjcK1t1br7r63h9hjZYsfqL5/hYCxhSNkUC1LuOLqSP
         0t+bF8m0jC20g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
Subject: Re: [PATCH] selftests: powerpc: Add test for execute-disabled pkeys
In-Reply-To: <20200508162332.65316-1-sandipan@linux.ibm.com>
References: <20200508162332.65316-1-sandipan@linux.ibm.com>
Date:   Tue, 26 May 2020 22:35:19 +1000
Message-ID: <87367mg9h4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sandipan,

Sandipan Das <sandipan@linux.ibm.com> writes:
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> new file mode 100644
> index 000000000000..b346ad205e68
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2020, Sandipan Das, IBM Corp.
> + *
> + * Test if applying execute protection on pages using memory
> + * protection keys works as expected.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <signal.h>
> +
> +#include <time.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +
> +#include "utils.h"
> +
> +/* Override definitions as they might be inconsistent */
> +#undef PKEY_DISABLE_ACCESS
> +#define PKEY_DISABLE_ACCESS	0x3

Why would they be inconsistent?


> +/* Older distros might not define this */
> +#ifndef SEGV_PKUERR
> +#define SEGV_PKUERR	4
> +#endif
...
> +
> +	/* Restore permissions in order to continue */
> +	switch (fcode) {
> +	case SEGV_ACCERR:
> +		if (mprotect(insns, pgsize, PROT_READ | PROT_WRITE)) {
> +			perror("mprotect");
> +			goto fail;
> +		}
> +		break;
> +	case SEGV_PKUERR:
> +		if (sinfo->si_pkey != fpkey)
> +			goto fail;

This doesn't compile on older distros, eg Ubuntu 16.04:

  pkey_exec_prot.c: In function 'segv_handler':
  pkey_exec_prot.c:121:12: error: 'siginfo_t {aka struct <anonymous>}' has no member named 'si_pkey'
     if (sinfo->si_pkey != fpkey)
              ^
  pkey_exec_prot.c:151:24: error: 'siginfo_t {aka struct <anonymous>}' has no member named 'si_pkey'
     pkey_set_rights(sinfo->si_pkey, 0);
                          ^
  ../../lib.mk:142: recipe for target '/output/kselftest/powerpc/mm/pkey_exec_prot' failed


I think a reasonable solution is to use the absence of SEGV_PKUERR to
basically turn the whole test into a nop at build time, eg:

diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
index b346ad205e68..218257b89fbb 100644
--- a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
+++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
@@ -30,9 +30,7 @@
 #define PKEY_DISABLE_EXECUTE   0x4

 /* Older distros might not define this */
-#ifndef SEGV_PKUERR
-#define SEGV_PKUERR    4
-#endif
+#ifdef SEGV_PKUERR

 #define SYS_pkey_mprotect      386
 #define SYS_pkey_alloc         384
@@ -319,6 +317,13 @@ static int test(void)

        return 0;
 }
+#else
+static int test(void)
+{
+       printf("Test built with old libc lacking pkey support.\n");
+       SKIP_IF(true);
+}
+#endif /* SEGV_PKUERR */

 int main(void)
 {


cheers
