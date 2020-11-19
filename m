Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E73E2B8B3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 07:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgKSGDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 01:03:40 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSGDk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 01:03:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cc8Hs6Rdnz9sTv;
        Thu, 19 Nov 2020 17:03:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1605765817;
        bh=+pZz8i6g7OW4NmP3Iuj693zPmlv8QYjXt7afMQdN6hE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V4dsU87ALmKVfy4tqYomzsbnaVJHR20L5N3ndFKpV2IVqKhJ/yqxgQ8p151HOofey
         1xrEuX6BOPCEF5p9l3fGBjt+CiS2hkL1YGoFyxG2zfi04+UNz5nwZoixuYHj01+Sae
         2haUvRoyfyYWCCGT0wMp/3I3l16XUkFrh7+40y81m6X3hFxD3AXYQy+Tfc7tn94Fjg
         dr4sefW4e08FS5xumP7CmJHp48+8kEriOc85xKdgorrf8K0i8/ig+LO/S2HD+0rlxC
         Digtvx5vBb+UvSVaRyuMms4qN8wSmUj7XFWwds7EiJxQPqU3KY962y+gsUBSGoP//u
         6jNsEKLf97VFA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: powerpc: Fix typo in macro variable name
In-Reply-To: <20201117210104.1000661-1-keescook@chromium.org>
References: <20201117210104.1000661-1-keescook@chromium.org>
Date:   Thu, 19 Nov 2020 17:03:34 +1100
Message-ID: <87y2ix2895.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> A typo sneaked into the powerpc selftest. Fix the name so it builds again.
>
> Fixes: 46138329faea ("selftests/seccomp: powerpc: Fix seccomp return value testing")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I hit that and thought I'd sent a patch for it, but seems I never
actually sent it.

So thanks. I assume Shuah will take it.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers


> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 76c458055c54..26c72f2b61b1 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1758,10 +1758,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  		 * and the code is stored as a positive value.	\
>  		 */						\
>  		if (_result < 0) {				\
> -			SYSCALL_RET(_regs) = -result;		\
> +			SYSCALL_RET(_regs) = -_result;		\
>  			(_regs).ccr |= 0x10000000;		\
>  		} else {					\
> -			SYSCALL_RET(_regs) = result;		\
> +			SYSCALL_RET(_regs) = _result;		\
>  			(_regs).ccr &= ~0x10000000;		\
>  		}						\
>  	} while (0)
> -- 
> 2.25.1
