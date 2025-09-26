Return-Path: <linux-kselftest+bounces-42471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DBFBA3FAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8671892D45
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E862FB615;
	Fri, 26 Sep 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="exUyD7xU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDAD2FAC12;
	Fri, 26 Sep 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894845; cv=none; b=qdSvvUPOeGQ/X+OmTkxoxUVrTZ01Pk3jxDFXci3nv4cYbtMi8yfwj5AyZ5b5wmgpjtUh0YFwJ07xpVisMhqnz90zo7sZlPMDSvpewfikTc9lCsG5GUwndaOnR4o2DLWLiU49fKsRsi6y7C2WZoSA3l3A1U88LE/H3ocdbjM2hZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894845; c=relaxed/simple;
	bh=EAqKV/2RF7bW8arWG9fwnOlAqRNSwPmfuGtdSoCMrbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXnkN3q9YiVcVgu3gkINWJo0z1GgVodR44ISm+hEyOUI9Bda+cXkncwdi1gjUWPcclPrM2kaQC+TleROQktICz9nUlfRGkig0Z1/I7dsN1x6tMTW3lTpps4JMeYpNRpc1l3YshzTmFxp7spxhF3V6vr6S7q8y3ETYnmkCwkh7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=exUyD7xU reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cYBrd72t9z1DDr7;
	Fri, 26 Sep 2025 15:53:53 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cYBrc5B6bz1Fb38;
	Fri, 26 Sep 2025 15:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758894833;
	bh=0oKPt5B2BYzle8pqRjAR1Qbv4tzNfaR8uywq90JI968=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=exUyD7xU1FFoAo0zIaGO8L1T0an8JyysSniNaBEN284brN/McStsyIZqRxq8PWEKU
	 4xjl2QjrfL3v6vRMcSOZA6TsputTD4TBzNeEmQkcG3KIUuhpPXP+zEXF3Yz/NS7pmB
	 PcxjXfIwjxcneymF0BZH9kKiWkU57AHDRlm5Of+kNpRF0jGMlR6JwP/sN6nrYrb0Z0
	 guRP8WAhweSnyJbReXLTERryS4IR1w0uYknNh+L2dgFLhbTwnQE2kx++CD7JJaeLrS
	 PJLHZmJ4jqQSjfHyyxYla7ZzLAyJTcxvyTl+OUIQNZsx642Tr8lLuLkTgoW04lH9tr
	 uEVtlAUR67olA==
Message-ID: <76d9171c-4a74-499e-a598-ec51fdfa4e94@gaisler.com>
Date: Fri, 26 Sep 2025 15:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/36] sparc64: vdso: Switch to the generic vDSO
 library
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King
 <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 Arnd Bergmann <arnd@kernel.org>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-09-17 16:00, Thomas Weißschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
> 
> Make use of the generic infrastructure.
> 
> Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
> https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
> 
> Tested on a Niagara T4 and QEMU.
> 
> This has a semantic conflict with my series "vdso: Reject absolute
> relocations during build". The last patch of this series expects all users
> of the generic vDSO library to use the vdsocheck tool.
> This is not the case (yet) for SPARC64. I do have the patches for the
> integration, the specifics will depend on which series is applied first.
> 
> Based on tip/timers/vdso.
> 
> [0] https://lore.kernel.org/lkml/20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de/
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v3:
> - Allocate vDSO data pages dynamically (and lots of preparations for that)
> - Drop clock_getres()
> - Fix 32bit clock_gettime() syscall fallback
> - Link to v2: https://lore.kernel.org/r/20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de
> 
> Changes in v2:
> - Rebase on v6.17-rc1
> - Drop RFC state
> - Fix typo in commit message
> - Drop duplicate 'select GENERIC_TIME_VSYSCALL'
> - Merge "sparc64: time: Remove architecture-specific clocksource data" into the
>   main conversion patch. It violated the check in __clocksource_register_scale()
> - Link to v1: https://lore.kernel.org/r/20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de
> 
> ---
> Arnd Bergmann (1):
>       clocksource: remove ARCH_CLOCKSOURCE_DATA
> 
> Thomas Weißschuh (35):
>       selftests: vDSO: vdso_test_correctness: Handle different tv_usec types
>       arm64: vDSO: getrandom: Explicitly include asm/alternative.h
>       arm64: vDSO: gettimeofday: Explicitly include vdso/clocksource.h
>       arm64: vDSO: compat_gettimeofday: Add explicit includes
>       ARM: vdso: gettimeofday: Add explicit includes
>       powerpc/vdso/gettimeofday: Explicitly include vdso/time32.h
>       powerpc/vdso: Explicitly include asm/cputable.h and asm/feature-fixups.h
>       LoongArch: vDSO: Explicitly include asm/vdso/vdso.h
>       MIPS: vdso: Add include guard to asm/vdso/vdso.h
>       MIPS: vdso: Explicitly include asm/vdso/vdso.h
>       random: vDSO: Add explicit includes
>       vdso/gettimeofday: Add explicit includes
>       vdso/helpers: Explicitly include vdso/processor.h
>       vdso/datapage: Remove inclusion of gettimeofday.h
>       vdso/datapage: Trim down unnecessary includes
>       random: vDSO: trim vDSO includes
>       random: vDSO: remove ifdeffery
>       random: vDSO: split out datapage update into helper functions
>       random: vDSO: only access vDSO datapage after random_init()
>       s390/time: Set up vDSO datapage later
>       vdso/datastore: Reduce scope of some variables in vvar_fault()
>       vdso/datastore: Drop inclusion of linux/mmap_lock.h
>       vdso/datastore: Map pages through struct page
>       vdso/datastore: Allocate data pages dynamically
>       sparc64: vdso: Link with -z noexecstack
>       sparc64: vdso: Remove obsolete "fake section table" reservation
>       sparc64: vdso: Replace code patching with runtime conditional
>       sparc64: vdso: Move hardware counter read into header
>       sparc64: vdso: Move syscall fallbacks into header
>       sparc64: vdso: Introduce vdso/processor.h
>       sparc64: vdso: Switch to the generic vDSO library
>       sparc64: vdso2c: Drop sym_vvar_start handling
>       sparc64: vdso2c: Remove symbol handling
>       sparc64: vdso: Implement clock_gettime64()
>       clocksource: drop include of asm/clocksource.h from linux/clocksource.h
> 
>  arch/arm/include/asm/vdso/gettimeofday.h           |   2 +
>  arch/arm64/include/asm/vdso/compat_gettimeofday.h  |   3 +
>  arch/arm64/include/asm/vdso/gettimeofday.h         |   2 +
>  arch/arm64/kernel/vdso/vgetrandom.c                |   2 +
>  arch/loongarch/kernel/process.c                    |   1 +
>  arch/loongarch/kernel/vdso.c                       |   1 +
>  arch/mips/include/asm/vdso/vdso.h                  |   5 +
>  arch/mips/kernel/vdso.c                            |   1 +
>  arch/powerpc/include/asm/vdso/gettimeofday.h       |   1 +
>  arch/powerpc/include/asm/vdso/processor.h          |   3 +
>  arch/s390/kernel/time.c                            |   4 +-
>  arch/sparc/Kconfig                                 |   3 +-
>  arch/sparc/include/asm/clocksource.h               |   9 -
>  arch/sparc/include/asm/processor.h                 |   3 +
>  arch/sparc/include/asm/processor_32.h              |   2 -
>  arch/sparc/include/asm/processor_64.h              |  25 --
>  arch/sparc/include/asm/vdso.h                      |   2 -
>  arch/sparc/include/asm/vdso/clocksource.h          |  10 +
>  arch/sparc/include/asm/vdso/gettimeofday.h         | 184 ++++++++++
>  arch/sparc/include/asm/vdso/processor.h            |  41 +++
>  arch/sparc/include/asm/vdso/vsyscall.h             |  10 +
>  arch/sparc/include/asm/vvar.h                      |  75 ----
>  arch/sparc/kernel/Makefile                         |   1 -
>  arch/sparc/kernel/time_64.c                        |   6 +-
>  arch/sparc/kernel/vdso.c                           |  69 ----
>  arch/sparc/vdso/Makefile                           |   8 +-
>  arch/sparc/vdso/vclock_gettime.c                   | 380 ++-------------------
>  arch/sparc/vdso/vdso-layout.lds.S                  |  26 +-
>  arch/sparc/vdso/vdso.lds.S                         |   2 -
>  arch/sparc/vdso/vdso2c.c                           |  24 --
>  arch/sparc/vdso/vdso2c.h                           |  45 +--
>  arch/sparc/vdso/vdso32/vdso32.lds.S                |   4 +-
>  arch/sparc/vdso/vma.c                              | 274 +--------------
>  drivers/char/random.c                              |  75 ++--
>  include/linux/clocksource.h                        |   8 -
>  include/linux/vdso_datastore.h                     |   6 +
>  include/vdso/datapage.h                            |  23 +-
>  include/vdso/helpers.h                             |   1 +
>  init/main.c                                        |   2 +
>  kernel/time/Kconfig                                |   4 -
>  lib/vdso/datastore.c                               |  73 ++--
>  lib/vdso/getrandom.c                               |   3 +
>  lib/vdso/gettimeofday.c                            |  17 +
>  .../testing/selftests/vDSO/vdso_test_correctness.c |   8 +-
>  44 files changed, 451 insertions(+), 997 deletions(-)
> ---
> base-commit: 5f84f6004e298bd41c9e4ed45c18447954b1dce6
> change-id: 20250722-vdso-sparc64-generic-2-25f2e058e92c

Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com> # arch/sparc

Thanks,
Andreas


