Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96B765831
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjG0QCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjG0QB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 12:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D47B271E
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 09:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E026C61E06
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB9EC433C8;
        Thu, 27 Jul 2023 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690473717;
        bh=PoFAvcNSw2azpXJajYVTP1fkgUhuEl8F9XbcDH+zxDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEp/XVnJo/RyDCP8H9CbCJGyaajnXOnM0yG3ui6WTkoYZqiie+bBZEBebRurCRIS/
         JyfWq1CETyzZYjMy8FA7jHOJoAeGY7nBwuhv1MPGLgd2sKBE3h6xcQq6ONplUTt7gL
         b1DpWk4iIRp0R7KA/xYaRRpbSuUIGi81rZYgcUz1TDOkc2jne0WRFSXc0N9zL6dsay
         t3rWLV95MLASEbXTQG0f2ufRxcWgLelputCmFFBoYOsPWix69PlWbdR6IiKd0O34Ht
         QrVdU0DOWCDp13A4wthxtYeccrI0TxYbXf2o7L3UZVA0MjimxSR6Y2i5vCZTcKho1z
         TGntnipPgRMdg==
Date:   Thu, 27 Jul 2023 17:01:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] kselftest/arm64: Exit streaming mode after collecting
 signal context
Message-ID: <f98c3f05-46f4-415e-a32a-bd22fc756dc4@sirena.org.uk>
References: <20230720-arm64-signal-memcpy-fix-v3-1-08aed2385d68@kernel.org>
 <20230727155009.GA20050@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hnfk6Dmn4XW6aKQA"
Content-Disposition: inline
In-Reply-To: <20230727155009.GA20050@willie-the-truck>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--Hnfk6Dmn4XW6aKQA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2023 at 04:50:10PM +0100, Will Deacon wrote:

> Looking more closely at this, I see that the bpf and kvm selftests are
> able to include <linux/compiler.h> directly, so I don't see why we need

Hrm, it does seem like that's on the specific list of headers we can get
at.  I'm kind of surprised that it's not got dependencies that upset
things.

> to open-code this here. I also spotted that we've *already* written our
> own version of this as the 'curse()' macro in selftests/arm64/bti/compiler.h!

That one wasn't originally a kselftst so it'll just have pulled in
something from completely outside the kernel build systems.

--Hnfk6Dmn4XW6aKQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTClO8ACgkQJNaLcl1U
h9DcdQgAgvTAcPR0palC1xciXVX7eeY18VDgZXeeL48H39R6eswcymLnXq2sHICa
f8Gyt92sr1+It1sbobjkZBfePtifYOomhNc8yaScKHd4asX9Il60vMwytLIZTHAQ
O8iE7Vdums0SAd6a4NpI9UCayHJKFBO5XUSz5JlmrELL0SmyPYv/8VDzM6ebXKfN
m/UvpplTwT/KFJql/Xg6rLz51bg/pAN6QSYUeF4Oap1bngr0/tD0a9a+cqTf9zAK
8HT16kNL/KaFwDfSmgbfFt9ideOIWROd15Gi4n5O5jkDI87mnQ5S11n+JjN9hX/H
fzn+imhmC59XVUhibSpMSawooTqZNg==
=zul5
-----END PGP SIGNATURE-----

--Hnfk6Dmn4XW6aKQA--
