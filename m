Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B67E6BF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKIODJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 09:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIODJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 09:03:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE5272C
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 06:03:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242A3C433C8;
        Thu,  9 Nov 2023 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699538586;
        bh=7D6Jijux2YM7BGQPWYbE7z6xuhCQoT6kUZvx28WELZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/b2s6jgw0f3HF554QO9GLbSz9LFpxbkF1nEeyiXCL6BP0bgSbW+TLePAZuVO4J/4
         LBeUQyoiGYDzbHVpS66PnheQiL3g1KEn5blDtX8WCWqIl+g6z8bJ0MGyY6FBvYJVF1
         O3FWMjM43LGNdPE/g2sINSbMTO7SBjDxu8eld2EU045D2iskyREniimsgKj0npy1rN
         vhRyiI6jZ1hx/aBXX9ulC+YpYPtKnd8u+Yr60Jp5mk4UxHV0jpb9fraZQlZWTg1kRk
         xXY7tJYXq/t8CCpbsw0w5wGxWvbb/zKlZ+/Sq3w91+iqIjlPb71JvgP387EzD31VKU
         Xvl6i3ScSJbiw==
Date:   Thu, 9 Nov 2023 14:03:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
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
Subject: Re: WARNING: CPU: 6 PID: 474 at include/linux/maple_tree.h:712
 mmap_region (include/linux/maple_tree.h:556 include/linux/maple_tree.h:731
Message-ID: <ZUzmlhvRv66I3J6P@finisterre.sirena.org.uk>
References: <CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N4lmr59gPo+3oBVi"
Content-Disposition: inline
In-Reply-To: <CA+G9fYs-j2FYZSFSVZj48mgoM9gQd4-7M2mu2Ez3D1DqDdW2bQ@mail.gmail.com>
X-Cookie: Slow day.  Practice crawling.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--N4lmr59gPo+3oBVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 06:57:08PM +0530, Naresh Kamboju wrote:
> Following kernel panic noticed while running  selftests: exec: load_addre=
ss
> on Fastmodels (FVP) running Linux next-20231109.
>=20

Copying in Kees and Eric who maintain the exec API.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> log:
> ---
>=20
> # timeout set to 45
> # selftests: exec: load_address_16777216
> [  238.405168] ------------[ cut here ]------------
> [  238.405244] WARNING: CPU: 6 PID: 474 at
> include/linux/maple_tree.h:712 mmap_region
> (include/linux/maple_tree.h:556 include/linux/maple_tree.h:731
> include/linux/maple_tree.h:747 include/linux/mm.h:1033 mm/mmap.c:2828)
> [  238.405432] Modules linked in: arm_spe_pmu crct10dif_ce
> panel_simple pl111_drm drm_dma_helper drm_kms_helper fuse drm
> backlight dm_mod ip_tables x_tables
> [  238.405932] CPU: 6 PID: 474 Comm: load_address_16 Not tainted
> 6.6.0-next-20231109 #1
> [  238.406070] Hardware name: FVP Base RevC (DT)
> [  238.406151] pstate: 123402009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTY=
PE=3D--)
> [  238.406294] pc : mmap_region (include/linux/maple_tree.h:556
> include/linux/maple_tree.h:731 include/linux/maple_tree.h:747
> include/linux/mm.h:1033 mm/mmap.c:2828)
> [  238.406424] lr : mmap_region (mm/mmap.c:2836)
> [  238.406554] sp : ffff8000819639b0
> [  238.406629] x29: ffff8000819639c0 x28: ffff000806f79000 x27: 000000000=
2002000
> [  238.406829] x26: ffff000806f798f0 x25: ffff000806f790b0 x24: 000000000=
0000006
> [  238.407029] x23: 0000000000000ffc x22: ffff000805d6e100 x21: ffff00080=
16adf00
> [  238.407229] x20: 0000000000100073 x19: 0000000001ffc000 x18: fffffffff=
fffffff
> [  238.407425] x17: 0000000000000000 x16: ffffd7c64ceb7c10 x15: fffffffff=
fffffff
> [  238.407627] x14: 0000000000000000 x13: 1fffe001002bc9a1 x12: ffff00080=
15e4d0c
> [  238.407825] x11: ffff800081963a48 x10: ffff0008015e4d00 x9 : ffffd7c64=
b49c9f0
> [  238.408028] x8 : ffff800081963778 x7 : 0000000000000000 x6 : 000000000=
0000000
> [  238.408223] x5 : ffffd7c64e35f000 x4 : ffffd7c64e35f278 x3 : 000000000=
0000000
> [  238.408420] x2 : ffffd7c64e92fd78 x1 : 0000000002001fff x0 : 000000000=
0479fff
> [  238.408618] Call trace:
> [  238.408681] mmap_region (include/linux/maple_tree.h:556
> include/linux/maple_tree.h:731 include/linux/maple_tree.h:747
> include/linux/mm.h:1033 mm/mmap.c:2828)
> [  238.408812] do_mmap (arch/arm64/include/asm/mman.h:18
> include/linux/mman.h:147 mm/mmap.c:1274)
> [  238.408940] vm_mmap_pgoff (mm/util.c:546)
> [  238.409088] vm_mmap (mm/util.c:559)
> [  238.409229] elf_load (fs/binfmt_elf.c:385 fs/binfmt_elf.c:408)
> [  238.409337] load_elf_binary (fs/binfmt_elf.c:1134 (discriminator 1))
> [  238.409454] bprm_execve (fs/exec.c:1940)
> [  238.409598] do_execveat_common.isra.0 (fs/exec.c:1938)
> [  238.409757] __arm64_sys_execve (fs/exec.c:2106)
> [  238.409910] invoke_syscall (arch/arm64/kernel/syscall.c:46
> (discriminator 19))
> [  238.410058] el0_svc_common.constprop.0 (arch/arm64/kernel/syscall.c:13=
6)
> [  238.410218] do_el0_svc (arch/arm64/kernel/syscall.c:155)
> [  238.410363] el0_svc (arch/arm64/include/asm/daifflags.h:75
> arch/arm64/kernel/entry-common.c:677)
> [  238.410508] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:697)
> [  238.410623] el0t_64_sync (arch/arm64/kernel/entry.S:595)
> [  238.410735] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202311=
09/testrun/21009598/suite/log-parser-test/test/check-kernel-exception/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202311=
09/testrun/21009598/suite/log-parser-test/tests/
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2Xv9w=
ca3SPRN4lh73fIuUxVRNHI
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Xv9vEpjybxlDA4=
IvgDBm4bjzVT/
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org

--N4lmr59gPo+3oBVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVM5pYACgkQJNaLcl1U
h9CbYQf/fZxm3kKPgU5OonTWLdsnp6rcIDmyLmn+U8D73IEEMEWq/W9yPn2rCEkt
KWqxFAI9dAlpFt3/k3KNEaarsy1iIYPkd0lvajoKbXqtMdFYdyvDxgrJ6vmK1E6D
1vfDmZEsnpAziQdiwMu06BS932Byl5kddd3AK+lfU2M2erLZOCI4phBJrC7E8qwX
JCCosGgadkPURnR+X/awEIN++TGHfFVDqQoGcGuccP4V6Di1jXD+24oUNd/bSF78
yvHBWCY/tpZG9Lds2T0j65iOG4g2ATU6BBfkB8X8cssXRX4zsLIcmhSnxcn3Gb4H
npRfGhblaEB3uHIeXWS3F4m+89xAEA==
=LvGW
-----END PGP SIGNATURE-----

--N4lmr59gPo+3oBVi--
