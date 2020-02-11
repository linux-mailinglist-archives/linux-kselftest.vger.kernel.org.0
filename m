Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D366415886B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 03:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgBKCuT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 21:50:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbgBKCuT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 21:50:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GnLx2h15z9sP7;
        Tue, 11 Feb 2020 13:50:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581389417;
        bh=BUV6k8b4/tEi4PgXiYi4XOSMaNTQi4awrwVuF6nbQKg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KiyG58KOvujvM95ACCeJJIpDaFgjROxtgymhz4D8vCzlr9CSrjHECEcd02zTz6mh0
         qm4p9sZFS4aXmJt3o6Ar/UO2zEqYlPwTh2VT9kKwEBGP+KJ/9GaYEJCutIQ/00Ebit
         qCyeh/TXMW0k4Zv11ydg02PcEc+YpCeSP1I8TvN1aDVjUMFik2gPqsTzzlQgRrtx3X
         03QEqasOQLwgW7Lg1l+AbQt+vGy68t/+u6sUADbX6rOGefrEJS/eBfZcj66ymDMB0i
         L38dBZcY4WJm8NlqI7096qn+FOeN7p8oNQN3EuiKiYKLSeeJD7K+26UBwwA74XmeHT
         ov63hnh/OiWZQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhiramat@kernel.org, aneesh.kumar@linux.ibm.com,
        kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] selftests: vm: Fix 64-bit test builds for powerpc64le
In-Reply-To: <e9178d28dddfc64a23ffd51e2fecd06ad16ac92a.1580367152.git.sandipan@linux.ibm.com>
References: <cover.1580367152.git.sandipan@linux.ibm.com> <e9178d28dddfc64a23ffd51e2fecd06ad16ac92a.1580367152.git.sandipan@linux.ibm.com>
Date:   Tue, 11 Feb 2020 13:50:16 +1100
Message-ID: <87imkdzvkn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sandipan Das <sandipan@linux.ibm.com> writes:
> Some tests are built only for 64-bit systems. This makes
> sure that these tests are built for both big and little
> endian variants of powerpc64.
>
> Fixes: 7549b3364201 ("selftests: vm: Build/Run 64bit tests only on 64bit arch")
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile    | 2 +-
>  tools/testing/selftests/vm/run_vmtests | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 3f2e2f0ccbc9..8074340c6b3a 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -19,7 +19,7 @@ TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
>  
> -ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
> +ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64))
>  TEST_GEN_FILES += va_128TBswitch
>  TEST_GEN_FILES += virtual_address_range
>  endif
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
> index a692ea828317..db8e0d1c7b39 100755
> --- a/tools/testing/selftests/vm/run_vmtests
> +++ b/tools/testing/selftests/vm/run_vmtests
> @@ -59,7 +59,7 @@ else
>  fi
>  
>  #filter 64bit architectures
> -ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64"
> +ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
>  if [ -z $ARCH ]; then
>    ARCH=`uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/'`
>  fi
> -- 
> 2.17.1
