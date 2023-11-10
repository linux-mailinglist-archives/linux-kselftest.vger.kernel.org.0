Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3D7E7EA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 18:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjKJRqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Nov 2023 12:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345972AbjKJRpy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFAC6E9B
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 22:22:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FFDC43397;
        Fri, 10 Nov 2023 05:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699595127;
        bh=nmolrdb//VGv32Rb9iWEJYtfWLsDlsHjutrwFtjka8g=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=eGvrQjY5SgxrkK1i6OXYJKzEXwHz8aaZMSoLbQu68zA3I5BB8rJzdHlOFEy4hRwwL
         KsGB+ETlTS0184mwDS+yoZ4wvMG2UlzZmCWWVf0k5f2k2+mqsiUpVFp2BiPaKpFuxd
         RBdI+SZ4Z6+q/LPAROtMeGzNqgPkSZvJ7PASrwpl4Kgjx7PcrdBjulZMQYkfBrQLzD
         Z1koPdlaz/0mwa3Y3DgCrf41/vZzlPguqmHU/8X4tNTl4w3VEMKRw50NVlmyTa87ZS
         vQXzkHlJMb1ZOXWQU+bH+WfUuWwymKOp6fp/XqOWNoVeiooWrGms4S+LazTSk3/hsv
         Tuo/DnINTtjAw==
Date:   Thu, 09 Nov 2023 21:45:26 -0800
From:   Kees Cook <kees@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     linux-mm <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_WARNING=3A_CPU=3A_6_PID=3A_474_at_in?= =?US-ASCII?Q?clude/linux/maple=5Ftree=2Eh=3A712_mmap=5F?= =?US-ASCII?Q?region_=28include/linux/maple=5Ftree=2Eh?= =?US-ASCII?Q?=3A556_include/linux/maple=5Ftree=2Eh=3A731?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZUzmlhvRv66I3J6P@finisterre.sirena.org.uk>
References: <CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com> <ZUzmlhvRv66I3J6P@finisterre.sirena.org.uk>
Message-ID: <B4299DC4-57CF-4CB2-ACB1-A215F429BF6A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On November 9, 2023 6:03:02 AM PST, Mark Brown <broonie@kernel=2Eorg> wrot=
e:
>On Thu, Nov 09, 2023 at 06:57:08PM +0530, Naresh Kamboju wrote:
>> Following kernel panic noticed while running  selftests: exec: load_add=
ress
>> on Fastmodels (FVP) running Linux next-20231109=2E
>>=20
>
>Copying in Kees and Eric who maintain the exec API=2E

I'm traveling tomorrow so I won't be able to investigate this for a couple=
 days=2E A quick look makes it seem like this is only happening in -next? (=
This warning was recently added to __mas_set_range?)

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/next/linux-next=2Egit/=
commit/include/linux/maple_tree=2Eh?id=3D02eccbc51164b43c5dadc3e5b40922c757=
075e08

Adding Liam=2E=2E=2E

-Kees

>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro=2Eorg>
>>=20
>> log:
>> ---
>>=20
>> # timeout set to 45
>> # selftests: exec: load_address_16777216
>> [  238=2E405168] ------------[ cut here ]------------
>> [  238=2E405244] WARNING: CPU: 6 PID: 474 at
>> include/linux/maple_tree=2Eh:712 mmap_region
>> (include/linux/maple_tree=2Eh:556 include/linux/maple_tree=2Eh:731
>> include/linux/maple_tree=2Eh:747 include/linux/mm=2Eh:1033 mm/mmap=2Ec:=
2828)
>> [  238=2E405432] Modules linked in: arm_spe_pmu crct10dif_ce
>> panel_simple pl111_drm drm_dma_helper drm_kms_helper fuse drm
>> backlight dm_mod ip_tables x_tables
>> [  238=2E405932] CPU: 6 PID: 474 Comm: load_address_16 Not tainted
>> 6=2E6=2E0-next-20231109 #1
>> [  238=2E406070] Hardware name: FVP Base RevC (DT)
>> [  238=2E406151] pstate: 123402009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS=
 BTYPE=3D--)
>> [  238=2E406294] pc : mmap_region (include/linux/maple_tree=2Eh:556
>> include/linux/maple_tree=2Eh:731 include/linux/maple_tree=2Eh:747
>> include/linux/mm=2Eh:1033 mm/mmap=2Ec:2828)
>> [  238=2E406424] lr : mmap_region (mm/mmap=2Ec:2836)
>> [  238=2E406554] sp : ffff8000819639b0
>> [  238=2E406629] x29: ffff8000819639c0 x28: ffff000806f79000 x27: 00000=
00002002000
>> [  238=2E406829] x26: ffff000806f798f0 x25: ffff000806f790b0 x24: 00000=
00000000006
>> [  238=2E407029] x23: 0000000000000ffc x22: ffff000805d6e100 x21: ffff0=
008016adf00
>> [  238=2E407229] x20: 0000000000100073 x19: 0000000001ffc000 x18: fffff=
fffffffffff
>> [  238=2E407425] x17: 0000000000000000 x16: ffffd7c64ceb7c10 x15: fffff=
fffffffffff
>> [  238=2E407627] x14: 0000000000000000 x13: 1fffe001002bc9a1 x12: ffff0=
008015e4d0c
>> [  238=2E407825] x11: ffff800081963a48 x10: ffff0008015e4d00 x9 : ffffd=
7c64b49c9f0
>> [  238=2E408028] x8 : ffff800081963778 x7 : 0000000000000000 x6 : 00000=
00000000000
>> [  238=2E408223] x5 : ffffd7c64e35f000 x4 : ffffd7c64e35f278 x3 : 00000=
00000000000
>> [  238=2E408420] x2 : ffffd7c64e92fd78 x1 : 0000000002001fff x0 : 00000=
00000479fff
>> [  238=2E408618] Call trace:
>> [  238=2E408681] mmap_region (include/linux/maple_tree=2Eh:556
>> include/linux/maple_tree=2Eh:731 include/linux/maple_tree=2Eh:747
>> include/linux/mm=2Eh:1033 mm/mmap=2Ec:2828)
>> [  238=2E408812] do_mmap (arch/arm64/include/asm/mman=2Eh:18
>> include/linux/mman=2Eh:147 mm/mmap=2Ec:1274)
>> [  238=2E408940] vm_mmap_pgoff (mm/util=2Ec:546)
>> [  238=2E409088] vm_mmap (mm/util=2Ec:559)
>> [  238=2E409229] elf_load (fs/binfmt_elf=2Ec:385 fs/binfmt_elf=2Ec:408)
>> [  238=2E409337] load_elf_binary (fs/binfmt_elf=2Ec:1134 (discriminator=
 1))
>> [  238=2E409454] bprm_execve (fs/exec=2Ec:1940)
>> [  238=2E409598] do_execveat_common=2Eisra=2E0 (fs/exec=2Ec:1938)
>> [  238=2E409757] __arm64_sys_execve (fs/exec=2Ec:2106)
>> [  238=2E409910] invoke_syscall (arch/arm64/kernel/syscall=2Ec:46
>> (discriminator 19))
>> [  238=2E410058] el0_svc_common=2Econstprop=2E0 (arch/arm64/kernel/sysc=
all=2Ec:136)
>> [  238=2E410218] do_el0_svc (arch/arm64/kernel/syscall=2Ec:155)
>> [  238=2E410363] el0_svc (arch/arm64/include/asm/daifflags=2Eh:75
>> arch/arm64/kernel/entry-common=2Ec:677)
>> [  238=2E410508] el0t_64_sync_handler (arch/arm64/kernel/entry-common=
=2Ec:697)
>> [  238=2E410623] el0t_64_sync (arch/arm64/kernel/entry=2ES:595)
>> [  238=2E410735] ---[ end trace 0000000000000000 ]---
>>=20
>>=20
>> Links:
>>  - https://qa-reports=2Elinaro=2Eorg/lkft/linux-next-master/build/next-=
20231109/testrun/21009598/suite/log-parser-test/test/check-kernel-exception=
/log
>>  - https://qa-reports=2Elinaro=2Eorg/lkft/linux-next-master/build/next-=
20231109/testrun/21009598/suite/log-parser-test/tests/
>>  - https://tuxapi=2Etuxsuite=2Ecom/v1/groups/linaro/projects/lkft/tests=
/2Xv9wca3SPRN4lh73fIuUxVRNHI
>>  - https://storage=2Etuxsuite=2Ecom/public/linaro/lkft/builds/2Xv9vEpjy=
bxlDA4IvgDBm4bjzVT/
>>=20
>> --
>> Linaro LKFT
>> https://lkft=2Elinaro=2Eorg

--=20
Kees Cook
