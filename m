Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C984CA55B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiCBM7R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 07:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCBM7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 07:59:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0771812637
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 04:58:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E33EFCE20EA
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 12:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DAAC004E1;
        Wed,  2 Mar 2022 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646225907;
        bh=LosMea2p7TimEumkKgBbuDQpRFN6vS+YPd2axvQzG6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/B7wUcsV7VRFuaBavVxMvlLX9Gl48ULu5N/NiWRRzIjOqfCoWHw5PZWHtLf69Nix
         aS1WVHeY5yNQfxe4OySY6mcvUJfrDuVvCYimEXqrKCMQCyKTiF/xW9ZVcm5Bw7+jwV
         JBgUIRqBGPhHABLys81oc2aBgXcSY+Kp4aBWn0xcraW5KACbw6FKlSKvRrEwPVJuWb
         NRxc3rizhfSsjBH3ZrpKO/YeTCC/W9Z90BsUjt7yTL+ojubU/w0/BnD663p362KLM9
         EbHzbKa+NpYNleLnOk5+uHh+lY6XL9lxUGURaDsOSlWhMRrp58mJqqGu2Mqa/HLbKP
         0b3mfoGPx72rQ==
Date:   Wed, 2 Mar 2022 12:58:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
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
        kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
Subject: Re: [PATCH v11 03/40] arm64: cpufeature: Always specify and use a
 field width for capabilities
Message-ID: <Yh9p6s6iZg489U+2@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-4-broonie@kernel.org>
 <Yh6kqaR9FQXg8Q4w@qian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OcHL1zhRmZwbvB0Q"
Content-Disposition: inline
In-Reply-To: <Yh6kqaR9FQXg8Q4w@qian>
X-Cookie: The sheep died in the wool.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--OcHL1zhRmZwbvB0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2022 at 05:56:41PM -0500, Qian Cai wrote:
> On Mon, Feb 07, 2022 at 03:20:32PM +0000, Mark Brown wrote:
> > Since all the fields in the main ID registers are 4 bits wide we have up
> > until now not bothered specifying the width in the code. Since we now

> Do we leave this one alone on purpose?

>                 .desc = "GIC system register CPU interface",
>                 .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>                 .type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>                 .matches = has_useable_gicv3_cpuif,
>                 .sys_reg = SYS_ID_AA64PFR0_EL1,
>                 .field_pos = ID_AA64PFR0_GIC_SHIFT,
>                 .sign = FTR_UNSIGNED,
>                 .min_field_value = 1,

No, that's just an oversight.

--OcHL1zhRmZwbvB0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIfaekACgkQJNaLcl1U
h9CS3wf/f2m0xewYcmqZmPopGs54aBgCAog0anEB6iHaydYBxYysrufPJ/lpopIp
V+SKVUcxQiaiKNAQR3cMvt9ij8dh8aeRd9aSq7LGviM7ewR9+LQmEIKb2NCpidq0
AoAtXn9BZcShTs1E2Foy6jf+KjybFbJQQm0+gKIPwOzhOZ3HB3+q7gBEWQD9vuhc
qjYIleeNSEkI4JlZWxIVagxEKOLt+v5XDqEE23zK7mpOfCpRtlyAZS6kHA9ZBvkk
FHs8wq0JdvzJ8fh2oLkoq0JRF20uQXR6dbTkDg5HZCqln3ZBeYjhrV42r2kieFqJ
wm0lyXja3v08bVgxgPVib/iK0komlw==
=ukOI
-----END PGP SIGNATURE-----

--OcHL1zhRmZwbvB0Q--
