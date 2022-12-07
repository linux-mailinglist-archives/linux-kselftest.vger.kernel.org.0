Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417EA645C37
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 15:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLGOQt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 09:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLGOQr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 09:16:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984785CD1D
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 06:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE84615F8
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 14:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86871C433C1;
        Wed,  7 Dec 2022 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670422603;
        bh=r3u8Dix8avniHqNjnYoG3w/Uhbpr86KS5aLsZSxY9h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfLETTKsFfL9c3rBgI7mKeD+wjxVnNTwOjYgUIX9CV7ItKFN2QB/maSG16lWXJueh
         SBmkoc+C4jZArNpcDOvaNLjrxV5acIjXboi+Xy764T1Iie+AlkFcJz49uPBSbff1lf
         CHfqeSSt9U6OZ7NykFsw9hWr1XYSWttUw+kUn0LpJOebbE6OENJZ6o6eFf5m46Zf4U
         bWkrafdEJr+rXy4fK1RB1ngvs6XNSNMmnVPMbCDEuAl3zvA578DTfGPyuli716TlS7
         VjvsgmXY6yabmrK9WaQlZPITOi46yVGKGlhNORBqEjCh+/ib84MLij/KDgzm+1lz0O
         dS4bcXMpp4qKg==
Date:   Wed, 7 Dec 2022 14:16:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 16/39] arm64/sme: Implement traps and syscall
 handling for SME
Message-ID: <Y5CgRPbjOChpHQEJ@sirena.org.uk>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220419112247.711548-17-broonie@kernel.org>
 <e57552ea-37fb-07da-8560-e26bae8205cd@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xw/WPICFk6OpWXHF"
Content-Disposition: inline
In-Reply-To: <e57552ea-37fb-07da-8560-e26bae8205cd@huawei.com>
X-Cookie: What!?  Me worry?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xw/WPICFk6OpWXHF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 07, 2022 at 10:00:17PM +0800, Zenghui Yu wrote:
> On 2022/4/19 19:22, Mark Brown wrote:

> > +	/*
> > +	 * If SME is active then exit streaming mode.  If ZA is active
> > +	 * then flush the SVE registers but leave userspace access to
> > +	 * both SVE and SME enabled, otherwise disable SME for the
> > +	 * task and fall through to disabling SVE too.  This means

> It looks a bit confusing to me that in the current implementation, if
> ZA is *not* active, we don't actually go to disable SME for the task
> (which IMHO can be disabled as user-space is not actively using it now).

Unlike SVE there's no overhead from leaving SME enabled, the enable bits
for SM and ZA tell us if there is extra register state to be saved so we
don't have to worry about the costs there like we do with SVE.  The only
reason for not just unconditionally enabling SME is the potentially
large backing storage required for the registers, if a task isn't using
SME there's no need to impose that overhead.  If we disable SME for
userspace after the storage has been allocated then we just require an
additional trip through EL1 to reenable it for any future usage which
would hurt performance but not really gain us anything otherwise.  We
don't want to discurage applications from disabling ZA when not in use
given that there's likely to be physical overheads from keeping it
enabled.

> > +		if (svcr & SYS_SVCR_EL0_SM_MASK)
> > +			sme_smstop_sm();

> As per the SME syscall ABI

> | On syscall PSTATE.SM will be cleared and the SVE registers will be
> | handled as per the standard SVE ABI.

> and the SVE syscall ABI

> | On syscall, V0..V31 are preserved (as without SVE).  Thus, bits
> | [127:0] of Z0..Z31 are preserved.  All other bits of Z0..Z31, and all
> | of P0..P15 and FFR become zero on return from a syscall.

> Can we infer from the documentation that V0-V31 should be preserved on
> return from a syscall? But with sme_smstop_sm(), all implemented bits of
> Z0-Z31 are set to zero by hardware. Is this intentional?

> Please fix me up if I've mis-read things here.

No, the intention is to say that we exit streaming mode and then handle
things as per the non-streaming ABI.  Exiting streaming mode has the
effect of clearing the values as you say.

--xw/WPICFk6OpWXHF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOQoEQACgkQJNaLcl1U
h9DT2Qf/ZwEng2pEy0USKIPgcxnkZZTR1rImCaFy06I5mkGLN2DsF874tUEjlLVH
m3jTS9+Ekzmj+bHTrJ/E93HzlWGmWaAx+zAQy/Hx67A/wOraXL00RRSYjZ2QrHTm
0mZTDm2Cv6Y/Aqep2HbZAAyoyckjJXslXQZdpSM2ZHm3ZEWxUigtc+xHkQDw58qQ
/ZASpPtcm19SinaFJXXP4wPv5CU2hm1kXGvwdg16weggR5ro/3za6RFB63Up1VQ7
KQkppEUTmEaM4grb0JAYHFcr+gFcKIbXCaLqtkrClziQrHlAPJ/Rr9CXSTCuC8S/
K1UFr0G52c72xm1AZd1w9MrWDFOhuA==
=abex
-----END PGP SIGNATURE-----

--xw/WPICFk6OpWXHF--
