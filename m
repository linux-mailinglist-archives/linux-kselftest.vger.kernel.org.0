Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76254712922
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbjEZPIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjEZPIj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 11:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33398F7;
        Fri, 26 May 2023 08:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAEAD650C0;
        Fri, 26 May 2023 15:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5050EC433A4;
        Fri, 26 May 2023 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685113717;
        bh=jw06Bd9UnyKSbXh6qpPKPh6ve8zeePuDuifL3U5qGWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHZS/sgsqiCWxXuG+5tVlkySwRcBkVCppB+F9SO4qTwxFzzjyyFTmvlbiqz4s5a/v
         dlBTNtwkrfVQaVi/k5/ZdvkHn51HqiW38by25WA7hx3MLTdW2lL+KlZsYjxmcXTAUj
         gR75We/w7iAdfw0qXFV2wM+PMB1io6hVLGMkx18bQavV+DIJus06YZAF+QCcxpQtRY
         1MbZwP9rttL297GwqwCdaQKOiETjFAD4HUej0/aiq+0elKNTXCuzi7PI84c6oDSEQ+
         58/VF+4LwXVaXxVNLRwfkHLM2yfJmiAdSr+kOaVZkbsXi0m8UlKbFAkK2jVhk7ztKx
         L2sE6WnK4xVwQ==
Date:   Fri, 26 May 2023 16:08:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de,
        w@1wt.eu
Subject: Re: [PATCH 06/13] selftests/nolibc: allow specify a bios for qemu
Message-ID: <20230526-humongous-manifesto-3c44973f0df1@spud>
References: <20230526-clover-litter-1f41398cd820@wendy>
 <20230526133825.198100-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WayLhPoiZx5ZZrQj"
Content-Disposition: inline
In-Reply-To: <20230526133825.198100-1-falcon@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--WayLhPoiZx5ZZrQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 09:38:25PM +0800, Zhangjin Wu wrote:
> Hi, Conor.
>=20
> >=20
> > On Fri, May 26, 2023 at 06:25:18PM +0800, Zhangjin Wu wrote:
> >=20
> > > > On 2023-05-25 01:52:29+0800, Zhangjin Wu wrote:
> > > > > riscv qemu has a builtin bios (opensbi), but it may not match the=
 latest
> > > > > kernel and some old versions may hang during boot, let's allow us=
er pass
> > > > > a newer version to qemu via the -bios option.
> > > >
> > > > Nitpick:
> > > >
> > > > This seems very specific and hopefully only necessary temporarily.
> > > >
> > >
> > > RISC-V is such a new ISA and the Spec (especially the SBI) changes ve=
ry
> > > frequently ;-)
> >=20
> > Huh. Could you please expand on which versions of QEMU will hang while
> > booting an upstream or stable kernel? Which kernels would be good to
> > know too.
> >=20
>=20
> As the cover letter listed (in the Environment section), the softwares we
> used are:

Not super interested in those ones since they work ;)

> The kernel version is the one this patchset based on (Willy's nolibc
> repo), it is v6.4-rc1.
>=20
> qemu v4.2.1 is the one systematically installed (/usr/bin) from the
> qemu-system-misc package and used to test this patchset in my Ubuntu
> 20.04 based test docker image.

Okay, in the context of RISC-V, that is pretty ancient ;)

> Just installed a v7.0.0 qemu from ppa:canonical-server/server-backports,
> there is no default opensbi, and re-checked, there is one prebuilt
> opensbi for rv64, but still no prebuilt opensbi for rv32.

Ah, I see.

> The hang issue I mentioned may be using one of my older prebuilt version =
of
> opensbi, I can not find which one it exactly is, so, please ignore that i=
nfo,
> will update that description too.

Okay. If you do manage to reproduce it, LMK! I was/am just worried we
have some regressions because you should be able to keep booting with
those older opensbi versions, modulo some Kconfig changes - although if
it is something like qemu 4.2.1 specific I don't think I care all that
much about dinosaurs ;)

> Btw, something not about this patch: qemu v8.0.0 seems not boot non-mmu
> v6.3, both sides have issues, not dig into it carefully, so, not report
> it yet.

Cool. Feel free to CC me on whatever you discover. nommu gets little
enough testing in mainline, and even less in stable kernels. That reminds
me, I do need to add 32-bit nommu to the patchwork automation for
linux-riscv.

Thanks,
Conor.

--WayLhPoiZx5ZZrQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHDLcAAKCRB4tDGHoIJi
0nCqAQCCgCmTkKTJmk/35FqltqEtnqj2/KKHc1XPAIfhmy4/DAD/dMTwgLHXhm2b
t9fvm/hCLjoKAjt1pgKF97u2CcEfowU=
=iJ17
-----END PGP SIGNATURE-----

--WayLhPoiZx5ZZrQj--
