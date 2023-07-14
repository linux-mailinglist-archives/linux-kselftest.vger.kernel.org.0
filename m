Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CBF753957
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjGNLRI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGNLRH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 07:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09072D78;
        Fri, 14 Jul 2023 04:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64EEC61CDA;
        Fri, 14 Jul 2023 11:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E61C433C7;
        Fri, 14 Jul 2023 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689333425;
        bh=Yf59rtKFicaadtmI6Nu2BYl9fHiZoEYJ3kP0RAok4to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lv5p4XEJQEMYWbfF3sNwRz+QmN/bOZIdS4qb75dRXPFKTzZr72kGVX0h5YjfVYWdF
         PhUgBU5l1GxxzHUCa0AYbY86VyEPh2lt5CQI/D1w2jl5eZFVlh9Zb0VIG95kKqkBON
         0LQSgEEjpRwOHP4U8NL+kMLyDXECXLt7xgZVosEniQOAmc/Ac5G6MBnvVwz+/4JIhM
         mHgYukXGY/eNVWv9vjAuxG4ig1/K/yzGnZpnoz05MCqOQZhfi5rkD6zU+9tP8uEp44
         1VtjmtpAbcdPRbBt1Krv2ccvfEtR39qs02rULLJoWltPcziP8WwTLIu3jduXY5imNh
         Z8jQYbEpf2UTw==
Date:   Fri, 14 Jul 2023 12:17:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: Re: [PATCH v5 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <20230714-hangnail-stinking-60f9725ac0d5@spud>
References: <20230714001430.75798-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jMLB4CN0CiHBLUdn"
Content-Disposition: inline
In-Reply-To: <20230714001430.75798-1-charlie@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--jMLB4CN0CiHBLUdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:13:59PM -0700, Charlie Jenkins wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. Users can now select a
> desired address space using a non-zero hint address to mmap. Previously,
> requesting the default address space from mmap by passing zero as the hint
> address would result in using the largest address space possible. Some
> applications depend on empty bits in the virtual address space, like Go a=
nd
> Java, so this patch provides more flexibility for application developers.

The patchwork automation failed to apply this, what is the base for the
series?

>=20
> -Charlie
>=20
> ---
> v5:
> - Minor wording change in documentation
> - Change some parenthesis in arch_get_mmap_ macros
> - Added case for addr=3D=3D0 in arch_get_mmap_ because without this, prog=
rams would
>   crash if RLIMIT_STACK was modified before executing the program. This w=
as
>   tested using the libhugetlbfs tests.=20
>=20
> v4:
> - Split testcases/document patch into test cases, in-code documentation, =
and
>   formal documentation patches
> - Modified the mmap_base macro to be more legible and better represent me=
mory
>   layout
> - Fixed documentation to better reflect the implmentation
> - Renamed DEFAULT_VA_BITS to MMAP_VA_BITS
> - Added additional test case for rlimit changes
> ---
>=20
> Charlie Jenkins (4):
>   RISC-V: mm: Restrict address space for sv39,sv48,sv57
>   RISC-V: mm: Add tests for RISC-V mm
>   RISC-V: mm: Update pgtable comment documentation
>   RISC-V: mm: Document mmap changes
>=20
>  Documentation/riscv/vm-layout.rst             |  22 +++
>  arch/riscv/include/asm/elf.h                  |   2 +-
>  arch/riscv/include/asm/pgtable.h              |  20 ++-
>  arch/riscv/include/asm/processor.h            |  46 +++++-
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/mm/.gitignore   |   1 +
>  tools/testing/selftests/riscv/mm/Makefile     |  21 +++
>  .../selftests/riscv/mm/testcases/mmap.c       | 133 ++++++++++++++++++
>  8 files changed, 234 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/mm/Makefile
>  create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
>=20
> --=20
> 2.41.0
>=20

--jMLB4CN0CiHBLUdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLEurAAKCRB4tDGHoIJi
0vWmAQC/EywXok82Hrth9kz9y/zRYvLkySW1jR8buVPiN1zfigEAnSaGF2UkAjYa
6VCcjkwS7uQI4c/XFRtzztmmptbfaQo=
=V+TD
-----END PGP SIGNATURE-----

--jMLB4CN0CiHBLUdn--
