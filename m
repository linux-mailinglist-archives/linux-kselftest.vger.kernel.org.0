Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285F540DDE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhIPPYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhIPPYt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:24:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2634660EE9;
        Thu, 16 Sep 2021 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805808;
        bh=HSGEtdJmYKwJTCSoUdvulSt8bMOu6jwLF1xXsopNyUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TC1yv5zVdPdZIuLeIFMl4GFunvWV1BHm/hzFCEkpzzOZ88c9qNU0EevE8Dqa3B1lY
         jprwi1s/+a5TJ2lRf17u+TTb0vkcAUH4ruWlqj7WW+6JaMj1WpK0fE0+GAZdKOoidK
         DDHQF4B7V0MUyeWeidvQzHnYPYHbhEl6zj+F2EkDMV3KjaGMIXCbNZbOKbOoiKVZGr
         lLDbqNJkct0D/lX7nYf9+cGbAyo5q7SFSHsqpor2MI4ZVA/ON8ysjgBPcgivK+7hF3
         fuAvmGLWCl3BFL38ePL9x5NoMcxJJW6kUYYokMyrlDELO3i/4ZyhtKYAxJjZy8bFnd
         8HBz4qtGuZ69A==
Message-ID: <fe7dc7cc1b923ac07cfe8a05b5e1303c49a80a9f.camel@kernel.org>
Subject: Re: [PATCH 13/14] selftests/sgx: Enable multiple thread support
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 18:23:26 +0300
In-Reply-To: <7b413966289d22f043762b3d20e30cb6ded936e3.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <7b413966289d22f043762b3d20e30cb6ded936e3.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:31 -0700, Reinette Chatre wrote:
> Each thread executing in an enclave is associated with a Thread Control
> Structure (TCS). The test enclave contains two hardcoded TCS. Each TCS
> contains meta-data used by the hardware to save and restore thread specif=
ic
> information when entering/exiting the enclave.
>=20
> The two TCS structures within the test enclave share their SSA (State Sav=
e
> Area) resulting in the threads clobbering each other's data. Fix this by
> providing each TCS their own SSA area.
>=20
> Additionally, there is an 8K stack space and its address is
> computed from the enclave entry point which is correctly done for
> TCS #1 that starts on the first address inside the enclave but
> results in out of bounds memory when entering as TCS #2. Split 8K
> stack space into two separate pages with offset symbol between to ensure
> the current enclave entry calculation can continue to be used for both th=
reads.
>=20
> While using the enclave with multiple threads requires these fixes the
> impact is not apparent because every test up to this point enters the
> enclave from the first TCS.
>=20
> More detail about the stack fix:
> -------------------------------
> Before this change the test enclave (test_encl) looks as follows:
>=20
> .tcs (2 pages):
> (page 1) TCS #1
> (page 2) TCS #2
>=20
> .text (1 page)
> One page of code
>=20
> .data (5 pages)
> (page 1) encl_buffer
> (page 2) encl_buffer
> (page 3) SSA
> (page 4 and 5) STACK
> encl_stack:
>=20
> As shown above there is a symbol, encl_stack, that points to the end of t=
he
> .data segment (pointing to the end of page 5 in .data) which is also the =
end
> of the enclave.
>=20
> The enclave entry code computes the stack address by adding encl_stack to=
 the
> pointer to the TCS that entered the enclave. When entering at TCS #1 the
> stack is computed correctly but when entering at TCS #2 the stack pointer
> would point to one page beyond the end of the enclave and a #PF would
> result when TCS #2 attempts to enter the enclave.
>=20
> The fix involves moving the encl_stack symbol between the two stack pages=
.
> Doing so enables the stack address computation in the entry code to compu=
te
> the correct stack address for each TCS.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  .../selftests/sgx/test_encl_bootstrap.S       | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/te=
sting/selftests/sgx/test_encl_bootstrap.S
> index 5d5680d4ea39..82fb0dfcbd23 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -12,7 +12,7 @@
> =20
>  	.fill	1, 8, 0			# STATE (set by CPU)
>  	.fill	1, 8, 0			# FLAGS
> -	.quad	encl_ssa		# OSSA
> +	.quad	encl_ssa_tcs1		# OSSA
>  	.fill	1, 4, 0			# CSSA (set by CPU)
>  	.fill	1, 4, 1			# NSSA
>  	.quad	encl_entry		# OENTRY
> @@ -23,10 +23,10 @@
>  	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
>  	.fill	4024, 1, 0		# Reserved
> =20
> -	# Identical to the previous TCS.
> +	# TCS2
>  	.fill	1, 8, 0			# STATE (set by CPU)
>  	.fill	1, 8, 0			# FLAGS
> -	.quad	encl_ssa		# OSSA
> +	.quad	encl_ssa_tcs2		# OSSA
>  	.fill	1, 4, 0			# CSSA (set by CPU)
>  	.fill	1, 4, 1			# NSSA
>  	.quad	encl_entry		# OENTRY
> @@ -40,8 +40,9 @@
>  	.text
> =20
>  encl_entry:
> -	# RBX contains the base address for TCS, which is also the first addres=
s
> -	# inside the enclave. By adding the value of le_stack_end to it, we get
> +	# RBX contains the base address for TCS, which is the first address
> +	# inside the enclave for TCS #1 and one page into the enclave for
> +	# TCS #2. By adding the value of encl_stack to it, we get
>  	# the absolute address for the stack.
>  	lea	(encl_stack)(%rbx), %rax
>  	xchg	%rsp, %rax
> @@ -81,9 +82,15 @@ encl_entry:
> =20
>  	.section ".data", "aw"
> =20
> -encl_ssa:
> +encl_ssa_tcs1:
> +	.space 4096
> +encl_ssa_tcs2:
>  	.space 4096
> =20
>  	.balign 4096
> -	.space 8192
> +	# Stack of TCS #1
> +	.space 4096
>  encl_stack:
> +	.balign 4096
> +	# Stack of TCS #2
> +	.space 4096


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks for the throughout explanation!

/Jarkko

