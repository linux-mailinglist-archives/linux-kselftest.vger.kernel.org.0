Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7367273A6FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFVRLc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFVRLa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 13:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F89C3;
        Thu, 22 Jun 2023 10:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D91C60BFC;
        Thu, 22 Jun 2023 17:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D75C433C0;
        Thu, 22 Jun 2023 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687453888;
        bh=r+HeDLCxfm20JkjKpr4B6z4fQk3iRO45ANhG4MC57g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhOCCugcV9GNVcRn0LX1RtnnODOD2aN4c7XIjLBTC6ErcgbicckAg80lWzTdU+tl3
         JGcnCFbGGv21+dt3U5WdYQz1pFWZe2+/FzF9A5JsQFUeQH/zVD+f5beU/L5sgp5oMD
         edtC5pjGywsNdsCQf4Uv+2/4xKBgycP7UrAxllHQgCDK4eQgl6hjmAWvpqBNFKfG7P
         xPPRKydZB1+OnlwH7BonfiNfVOEGwO9gviastrNgnpRPgmnHrL4TEV5CXyRFZw4Suh
         vyLp7wKx34TGZ9vlwsJbW3ERVq9Tl4WwClMZ+EBNJyf7bAmTjKYTeVeBwHeChjYZtF
         SoCUTnYH5haTQ==
Date:   Thu, 22 Jun 2023 18:11:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/signal: Restore TPIDR2 register rather than
 memory state
Message-ID: <ZJSAuOrkgJyULV+v@finisterre.sirena.org.uk>
References: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
 <20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org>
 <ZJR6DvGofAvxSVYW@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OFf3DTa/ozSW247j"
Content-Disposition: inline
In-Reply-To: <ZJR6DvGofAvxSVYW@arm.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--OFf3DTa/ozSW247j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2023 at 05:42:54PM +0100, Catalin Marinas wrote:
> On Thu, Jun 22, 2023 at 02:39:45PM +0100, Mark Brown wrote:

> > -		current->thread.tpidr2_el0 = tpidr2_el0;
> > +		write_sysreg_s(tpidr2_el0, SYS_TPIDR2_EL0);

> I guess the other way around may also be true - the libc sets tpidr2_el0
> to something else and doesn't want the kernel to restore its original
> value from sigcontext.

> For tpidr_el0 we don't bother with sigcontext, not sure what the use for
> tpidr2_el0 in signals is. If we assume the context saved is only
> informative (like esr), we can simply ignore restoring it from the
> signal stack.

TPIDR2 is intended to go along with the thread stack, it's intended to
be used to allow lazy save of the (rather large) ZA register state when
a called function needs it rather than forcing it to be caller saved.
TPIDR2 is used to point to memory allocated for managing this process,
something that provides a new value should be making a deliberate
decision to do so and editing the stack frame.

> I guess we need to ask Szabolcs what his preference is. The current code
> is wrong either way since current->thread.tpidr2_el0 would be overridden
> at thread switch.

Right.

--OFf3DTa/ozSW247j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUgLgACgkQJNaLcl1U
h9DQYgf/fzkpdVb7yaxJq/mTHJ35u2JEHNVIpS1aFpf/AsSM+qT9nOsUdqnKkLXJ
T3ZgYh87gDWFizEMSaJxc5IKpBPDkVrD1/IWgpI8seFbZuSUtEHS/J33I2SSpIIh
cTGiiWEWP2dKXk8pWdsialE02rbmSGJaNURfb9snUCbn+U/64GkiwQqudk7jD6UX
kDJlYyAjzP1lGc787N7QfxrMNwc9KjIgJUjEn8/EvI07lsvKYlAdfnQSiNC2MSCp
ynYfv8EH4lhf2xlDo5DPeHkfWhf1KOYrYzTliI19T1ioVejZiA15SzQXLCRvRZKN
OXSu1EaKPHILrl+vGSPtin4vtW7QbQ==
=lrja
-----END PGP SIGNATURE-----

--OFf3DTa/ozSW247j--
