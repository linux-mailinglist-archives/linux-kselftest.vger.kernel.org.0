Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17650765402
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjG0Mdt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjG0Mds (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 08:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D7A0;
        Thu, 27 Jul 2023 05:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 159AA61E63;
        Thu, 27 Jul 2023 12:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96677C433C8;
        Thu, 27 Jul 2023 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690461226;
        bh=7VsMmtHFnt3Mu8te/EKSf4+ZEamhC9GT5n3lbZ8HcF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KryMqBMvkbHpL7pIWShH5LDgkQwzn4vj30MjLrUKKcupCQw0pYVMWO+JBKD8n74es
         WSTLcMbzb5HcSjtxpdsDLQwgyhjDziMh1rIQIcpVZJkJ7q998QwCJWE/d7v0gugot4
         lSNcnerOHaHeiPZ8yFSFVOl7fS9POcfpRAmJjLpZiaKHW+Nx3KReQ11+0xcQEYj7Rd
         BYx9/GYFS36xA68BhbZyefhKmdfTIkMAPz0pV+P+CYLrpIkspEY7815Ho+n4rzaqv5
         IQueyjIk4ayVdFn7Anr+T4fEMCaRfUQ6MmvGBSYP01oVnG8BngrTSLuoH+1kgZ3DqI
         KlyaLbKhTAwHg==
Date:   Thu, 27 Jul 2023 13:33:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v7 1/4] RISC-V: mm: Restrict address space for
 sv39,sv48,sv57
Message-ID: <20230727-unruffled-joyride-410fc348ce7b@spud>
References: <20230726164620.717288-1-charlie@rivosinc.com>
 <20230726164620.717288-2-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0svxelhh/GmhJGt3"
Content-Disposition: inline
In-Reply-To: <20230726164620.717288-2-charlie@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--0svxelhh/GmhJGt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On Wed, Jul 26, 2023 at 09:45:55AM -0700, Charlie Jenkins wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. A hint address passed to mmap will
> cause the largest address space that fits entirely into the hint to be
> used. If the hint is less than or equal to 1<<38, an sv39 address will
> be used. An exception is that if the hint address is 0, then a sv48
> address will be used. After an address space is completely full, the next
> smallest address space will be used.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/elf.h       |  2 +-
>  arch/riscv/include/asm/pgtable.h   | 13 ++++++++-
>  arch/riscv/include/asm/processor.h | 47 +++++++++++++++++++++++++-----
>  3 files changed, 53 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index c24280774caf..5d3368d5585c 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>   * the loader.  We need to make sure that it is out of the way of the pr=
ogram
>   * that it will "exec", and that there is sufficient room for the brk.
>   */
> -#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
> +#define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
> =20
>  #ifdef CONFIG_64BIT
>  #ifdef CONFIG_COMPAT
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 75970ee2bda2..530f6a171a2b 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -63,12 +63,23 @@
>   * position vmemmap directly below the VMALLOC region.
>   */
>  #ifdef CONFIG_64BIT
> +#define VA_BITS_SV39 39
> +#define VA_BITS_SV48 48
> +#define VA_BITS_SV57 57
> +
> +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
> +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> +
>  #define VA_BITS		(pgtable_l5_enabled ? \
> -				57 : (pgtable_l4_enabled ? 48 : 39))
> +				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
>  #else
>  #define VA_BITS		32
>  #endif

Please, at the very least, build test things for rv32 if you are going
to change things in mm:
io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_S=
V39'
io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_S=
V39'
io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_S=
V39'
io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_S=
V39'
io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_S=
V39'
io_uring/io_uring.c:3457:20: error: use of undeclared identifier 'VA_BITS_S=
V39'
mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
mm/util.c:441:19: error: use of undeclared identifier 'VA_BITS_SV39'
mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'
mm/mmap.c:1770:20: error: use of undeclared identifier 'VA_BITS_SV39'

Thanks,
Conor.

--0svxelhh/GmhJGt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMJkJQAKCRB4tDGHoIJi
0mzpAPwJWPSKvd4h8Mm2l0MHa3fl9fuzK7BKyFcMJpsby/MFOgEA/1VnfZ0R7Xf9
N3Mv5qgorgiDhx/vTvbCdG/fUFEpCwk=
=LPTS
-----END PGP SIGNATURE-----

--0svxelhh/GmhJGt3--
