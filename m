Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B899B740326
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjF0SYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjF0SYu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 14:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDECB8;
        Tue, 27 Jun 2023 11:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF1E7611F1;
        Tue, 27 Jun 2023 18:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CB0C433C0;
        Tue, 27 Jun 2023 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687890288;
        bh=U0Ae3RQ4h+5yMS5yiPM4dAg4Cs5OyI4YsmDbSn9P54M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBWhHyi7OhQxiwwl1PoY0idtgffmlQUHdUCFfMJgHk+cdg8J3eNys3Slb4cxWnCof
         X/6NljQ13ZORuOfC5mtqQF6jL5eECEGZWYoycQr3WgWNv4WKTY8mD2Lm/vj5hB2H3U
         SH3tZN3MLf7ggPvxZ3/YEqEn+B4jcwq4n8Aav6fw81+NT39/M4dfBgxAqymEN+EYaE
         jqCtAr/PSn/OrT6HJSKM9PK8lixaCmT8U1O3zPdtth3oe3DQRC++0U9f92PFAFLpuV
         vfR4QLL1J5OWOYZkPMCc1oK33pI/kTdwJEhdoK4B7AseSVcECzgV7/0UJ9rtaRsiat
         Mk3Z0hx1E77QA==
Date:   Tue, 27 Jun 2023 19:24:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EXEC & BINFMT API" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/2] Restrict address space for sv39,sv48,sv57
Message-ID: <20230627-eternity-mulberry-e1f4babf06a1@spud>
References: <20230626183611.40479-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZFVJLaa7EzBd/kk7"
Content-Disposition: inline
In-Reply-To: <20230626183611.40479-1-charlie@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ZFVJLaa7EzBd/kk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On Mon, Jun 26, 2023 at 11:36:02AM -0700, Charlie Jenkins wrote:
> Make sv39 the default address space for mmap as some applications
> currently depend on this assumption. The RISC-V specification enforces
> that bits outside of the virtual address range are not used, so
> restricting the size of the default address space as such should be
> temporary. A hint address passed to mmap will cause the largest address
> space that fits entirely into the hint to be used. If the hint is less
> than or equal to 1<<38, a 39-bit address will be used. After an address
> space is completely full, the next smallest address space will be used.
>=20
> Documentation is also added to the RISC-V virtual memory section to expla=
in
> these changes.

I don't know what went wrong here, but this never ended up in patchwork
for some reason, although it has appeared on lore. That seems to be via
the docs mailing list, rather than linux-riscv. Could you speak to Atish
and see if he knows what went wrong?

Cheers,
Conor.

>=20
> Charlie Jenkins (2):
>   RISC-V: mm: Restrict address space for sv39,sv48,sv57
>   RISC-V: mm: Update documentation and include test
>=20
>  Documentation/riscv/vm-layout.rst             | 20 ++++++++
>  arch/riscv/include/asm/elf.h                  |  2 +-
>  arch/riscv/include/asm/pgtable.h              | 21 ++++++--
>  arch/riscv/include/asm/processor.h            | 41 +++++++++++++---
>  tools/testing/selftests/riscv/Makefile        |  2 +-
>  tools/testing/selftests/riscv/mm/Makefile     | 22 +++++++++
>  .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
>  7 files changed, 144 insertions(+), 13 deletions(-)
>  create mode 100644 tools/testing/selftests/riscv/mm/Makefile
>  create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
>=20
>=20
> base-commit: eef509789cecdce895020682192d32e8bac790e8
> --=20
> 2.34.1
>=20

--ZFVJLaa7EzBd/kk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJspZgAKCRB4tDGHoIJi
0ilsAQC1hx/GF+DR3SpYjaRTOUhL/owNo2aM6O7rh8R9fc3o4QD7Bln7maXQOnuM
AlYliIy/ysDkNeLNH5z4t4XUqM/PLgI=
=za3L
-----END PGP SIGNATURE-----

--ZFVJLaa7EzBd/kk7--
