Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D01268334
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 05:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgINDis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Sep 2020 23:38:48 -0400
Received: from ozlabs.org ([203.11.71.1]:55859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgINDir (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Sep 2020 23:38:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BqXC775j3z9sTR;
        Mon, 14 Sep 2020 13:38:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600054725;
        bh=WSYInpRYBtYDkZHBmQQDThkXjUE9NyRyhjskGzBOWfs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ldhHUItJlbckAFthBQwfzljIGVNGGy6y4M98azT/BZOxPnqEu0BODf5RZB5v+neFy
         rfYyn3r+eDg/2K1P9lS394q3hoLl37t06b0X9b35e8/dI9bVMYm23lPi05FGhQ7z9C
         Isa7kMcyiKZXGtsXQ8iCTg4dFgEdseOX0NKSmqPPjBKZuU2R0y5THdXI4kFcpeqqCG
         d9HLOXJ7zYr60UdwFJbiXw5lvWWrzrQgPTwdbH6YQwaaS6Mj0MToJ89PrdSwxf2pYI
         6G4p4fDMIRyX/oc9cmZAn2VP0PLlNIKOCMcSOPWOgPdN+35V1iqo6AYk3qv4Wct9/l
         Uga4UjBME7XXQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/15] selftests/seccomp: powerpc: Fix seccomp return value testing
In-Reply-To: <20200912110820.597135-13-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org> <20200912110820.597135-13-keescook@chromium.org>
Date:   Mon, 14 Sep 2020 13:38:40 +1000
Message-ID: <87363lqb7j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On powerpc, the errno is not inverted, and depends on ccr.so being
> set. Add this to a powerpc definition of SYSCALL_RET_SET().
>
> Co-developed-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Link: https://lore.kernel.org/linux-kselftest/20200911181012.171027-1-cascardo@canonical.com/
> Fixes: 5d83c2b37d43 ("selftests/seccomp: Add powerpc support")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

This looks right to me, and matches what strace does AFAICS.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 623953a53032..bbab2420d708 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1750,6 +1750,21 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  # define ARCH_REGS		struct pt_regs
>  # define SYSCALL_NUM(_regs)	(_regs).gpr[0]
>  # define SYSCALL_RET(_regs)	(_regs).gpr[3]
> +# define SYSCALL_RET_SET(_regs, _val)				\
> +	do {							\
> +		typeof(_val) _result = (_val);			\
> +		/*						\
> +		 * A syscall error is signaled by CR0 SO bit	\
> +		 * and the code is stored as a positive value.	\
> +		 */						\
> +		if (_result < 0) {				\
> +			SYSCALL_RET(_regs) = -result;		\
> +			(_regs).ccr |= 0x10000000;		\
> +		} else {					\
> +			SYSCALL_RET(_regs) = result;		\
> +			(_regs).ccr &= ~0x10000000;		\
> +		}						\
> +	} while (0)
>  #elif defined(__s390__)
>  # define ARCH_REGS		s390_regs
>  # define SYSCALL_NUM(_regs)	(_regs).gprs[2]
> -- 
> 2.25.1
