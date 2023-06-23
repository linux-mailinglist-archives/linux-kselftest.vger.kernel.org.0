Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CC173BE56
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFWSWX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWSWW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 14:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FA2705;
        Fri, 23 Jun 2023 11:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D48F61AC1;
        Fri, 23 Jun 2023 18:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97811C433C0;
        Fri, 23 Jun 2023 18:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687544540;
        bh=KWec6uJWtJluhTlGyx0Ca6Y32wWpjQJ0UjmTw5Bovf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNFq0vgrbWD72G5nD9K0x/iZ7SmnE0js8oj0v4JxiMz6yttFRKEDlMmjRky7ugEAW
         OapVN3jqwQ6BsLIBYDrgu25KmpdXZL5k1GqiYyWYEQZBoilo1YRAL+32fxJNsf6uqM
         MuABWehg2Nh3hr9wlSjHou9eb7oZo3RuCNUtnewymn5rKBtFcIfBHgAgNqgPiEpYkn
         TqxuopQzedYdvg6GG5VTLDbldfJ5Vuuyik/eb+DlrLNflVMl0N73cy1R+uVxO5tC4B
         QU2Xl82TruCce8GLgmflXmd2uhWmm2E5XPnG8OANIcOqMx3bxEhUv8DNwHpcTFWg/b
         dne7UlyYMJv4w==
Date:   Fri, 23 Jun 2023 19:22:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64/signal: Restore TPIDR2 register rather than
 memory state
Message-ID: <ZJXi16SWYD2W0UN2@finisterre.sirena.org.uk>
References: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
 <20230621-arm64-fix-tpidr2-signal-restore-v2-1-c8e8fcc10302@kernel.org>
 <ZJR6DvGofAvxSVYW@arm.com>
 <ZJSAuOrkgJyULV+v@finisterre.sirena.org.uk>
 <ZJXWLAsAVuHNOqpS@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tgdU0+CKCHtbAbFH"
Content-Disposition: inline
In-Reply-To: <ZJXWLAsAVuHNOqpS@arm.com>
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


--tgdU0+CKCHtbAbFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2023 at 06:28:12PM +0100, Catalin Marinas wrote:
> On Thu, Jun 22, 2023 at 06:11:20PM +0100, Mark Brown wrote:

> > TPIDR2 is intended to go along with the thread stack, it's intended to
> > be used to allow lazy save of the (rather large) ZA register state when
> > a called function needs it rather than forcing it to be caller saved.
> > TPIDR2 is used to point to memory allocated for managing this process,
> > something that provides a new value should be making a deliberate
> > decision to do so and editing the stack frame.

> OK, so if the signal handler invokes a function that touches the ZA
> state, it may use TPIDR2 for lazy saving in any callee. In this case we
> need to restore the original TPIDR2 of the interrupted context on
> sigreturn.

Yeah, or if something tries to sigreturn to a previously saved context
which had live TPIDR2 state things might end up unfortunate.

> So I convinced myself this is the only option that makes sense ;). I'll
> queue the patches.

Thanks.

--tgdU0+CKCHtbAbFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSV4tAACgkQJNaLcl1U
h9AZbgf+LgfjIoh8QJEGqzJX+CwbiqVuIcjuUSAb1uqnNOw1CPoxZyPyZ/eNW1Pn
HfIpBAbFRpiTfctjzpcLpyPru7gL/VhoA+VIOAzBKNExZOM0E5KZTiwofBcMfSpp
6qTc+ZaIovXcHh6XZ986KHEVagzZSFC5h3FdSxpbk7kWRzNp9yxd+WexNpZ7GCNd
P2hnJtBg7UMfMSuNtTC5T1GO5VBj4RQoHHpzhKdds+wdnM3OfpUiwD7u91QhvL4r
WV7DeTzBJo2qDQmDRvkG4m/IrRHx+8PLHqqeDSfkcKCt9g40GaaXjThpOM5nhzu3
XrXZcbam3rO//7eTMASaXmlaKFmqlw==
=UNdU
-----END PGP SIGNATURE-----

--tgdU0+CKCHtbAbFH--
