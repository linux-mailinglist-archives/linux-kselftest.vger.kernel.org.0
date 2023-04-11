Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335836DDD88
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDKORp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDKOR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:17:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4B5263;
        Tue, 11 Apr 2023 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681222641; x=1712758641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+JgXouqrG+N1yi4JFy3ghvDTExLHywE71wQs1yugEQ=;
  b=CIh9J7rey7Czx1EfmdI/pIqWPGJrIN9zX7FUoqsCCTJUxAsxkLyxbbWn
   0n3ZJBVtov25wQlJ6DbxumkqzTcIOcpa30A38eDSdcYogw6FgL5MeIb6x
   /G/ltJnSZKb/69Th8Ua07kE+ulf6OZwVSMDPxEFxeQZT7zOKx9cftyETp
   mo0UHTHXtnkRPtA5uDpvr9dLsfuLMO3xgyr4bVJU4jjVgVD5jIEr7XmH0
   5MNntQ7Q6ntdZg78dJnH89dqwPsqmF4UF3qdpu/ybx1bqjEK8JGC6pRT9
   LSNcBbCcRQ0XsdProjBtXx1XFFZShLSjSPuKUw52zZlOpKINUJvWqZngc
   A==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="205964165"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 07:17:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 07:17:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 07:17:14 -0700
Date:   Tue, 11 Apr 2023 15:16:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>, <slewis@rivosinc.com>,
        <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,
        <vineetg@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        Shuah Khan <shuah@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v6 0/6] RISC-V Hardware Probing User Interface
Message-ID: <20230411-primate-rice-a5c102f90c6c@wendy>
References: <20230407231103.2622178-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AMh/Lwu23Kj/r0q5"
Content-Disposition: inline
In-Reply-To: <20230407231103.2622178-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--AMh/Lwu23Kj/r0q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

On Fri, Apr 07, 2023 at 04:10:57PM -0700, Evan Green wrote:
>=20
> There's been a bunch of off-list discussions about this, including at
> Plumbers.  The original plan was to do something involving providing an
> ISA string to userspace, but ISA strings just aren't sufficient for a
> stable ABI any more: in order to parse an ISA string users need the
> version of the specifications that the string is written to, the version
> of each extension (sometimes at a finer granularity than the RISC-V
> releases/versions encode), and the expected use case for the ISA string
> (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
> try and keep ABI compatible and it's probably going to continue to grow,
> as even if there's no more complexity in the specifications we'll have
> to deal with the various ISA string parsing oddities that end up all
> over userspace.
>=20
> Instead this patch set takes a very different approach and provides a set
> of key/value pairs that encode various bits about the system.  The big
> advantage here is that we can clearly define what these mean so we can
> ensure ABI stability, but it also allows us to encode information that's
> unlikely to ever appear in an ISA string (see the misaligned access
> performance, for example).  The resulting interface looks a lot like
> what arm64 and x86 do, and will hopefully fit well into something like
> ACPI in the future.
>=20
> The actual user interface is a syscall, with a vDSO function in front of
> it. The vDSO function can answer some queries without a syscall at all,
> and falls back to the syscall for cases it doesn't have answers to.
> Currently we prepopulate it with an array of answers for all keys and
> a CPU set of "all CPUs". This can be adjusted as necessary to provide
> fast answers to the most common queries.
>=20
> An example series in glibc exposing this syscall and using it in an
> ifunc selector for memcpy can be found at [1].
>=20
> I was asked about the performance delta between this and something like
> sysfs. I created a small test program [2] and ran it on a Nezha D1
> Allwinner board. Doing each operation 100000 times and dividing, these
> operations take the following amount of time:
>  - open()+read()+close() of /sys/kernel/cpu_byteorder: 3.8us
>  - access("/sys/kernel/cpu_byteorder", R_OK): 1.3us
>  - riscv_hwprobe() vDSO and syscall: .0094us
>  - riscv_hwprobe() vDSO with no syscall: 0.0091us
>=20
> These numbers get farther apart if we query multiple keys, as sysfs will
> scale linearly with the number of keys, where the dedicated syscall
> stays the same. To frame these numbers, I also did a tight
> fork/exec/wait loop, which I measured as 4.8ms. So doing 4
> open/read/close operations is a delta of about 0.3%, versus a single vDSO
> call is a delta of essentially zero.

Two nits w.r.t. build bot complaints...

On patch 2:
arch/riscv/include/uapi/asm/unistd.h:54:1: warning: initializer overrides p=
rior initialization of this subobject [-Winitializer-overrides]
I think this one is kinda spurious, all of the syscalls complain like
this (and do on arm64 too IIRC). There was a patch from Guo somewhere to
disable -Winitializer-overrides in this case, I should go find out what
happened to it.

On patch 4:
arch/riscv/kernel/cpufeature.c:29:1: warning: symbol '__pcpu_scope_misalign=
ed_access_speed' was not declared. Should it be static?

Probably because cos cpufeature.c doesn't include the header of the same
name... Perhaps Palmer could fix that one up on application?

Cheers,
Conor.


--AMh/Lwu23Kj/r0q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDVr2gAKCRB4tDGHoIJi
0ohDAP4vO99mP1Aar7XOlBB+xPLraW90a9bDAoMU0IbNlORQPAD/dsc19K8yMIXX
s/fnS3/GuvOs4S1Ty6FJFopQ+2J+HA8=
=0uEU
-----END PGP SIGNATURE-----

--AMh/Lwu23Kj/r0q5--
