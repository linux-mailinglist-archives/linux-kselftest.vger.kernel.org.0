Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7D49CA12
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiAZMw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 07:52:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55962 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiAZMw2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 07:52:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2D061A32
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FEAC340E3;
        Wed, 26 Jan 2022 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643201547;
        bh=o2ZPJgY1sa/GtYmc6gEf6NfJ0zITH9GxAUVpWbAb3CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJekI4r5r99zAqN5bCDTLJie3E9Ni+9K8wZE0XNqAiniPEkixzy1mB3sXeODxLEMA
         w+0K79JwfzySFaw7TOtsGGeCEB4Sfl+ukHQb6iL1aajNNALQ2jV0zaZ3MDCFvIWArj
         knl6CxiiNMLX3uA6SyWqsW1NnJi/CyqvqacMg1Z1nJlzP/WKi8v5yAauLrPgizdvad
         43QO4kvZOYF6o6/iNuSiGaehVDMDT4NNrkMkrHdRYnWJdfV5ARgyjmTuU7dHM4xqNO
         4xIS3MSrvX4hI/q+e4oJy6ewCmh5eU71aLVVDiDvOx59jBEf4bz9znMbDRdDgbGj85
         VQKmS8ryPF4hA==
Date:   Wed, 26 Jan 2022 12:52:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <YfFEBlsUH+dMxmku@sirena.org.uk>
References: <20220125192851.3907611-1-broonie@kernel.org>
 <87h79q7tln.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqSnZDWT+mQxO4gU"
Content-Disposition: inline
In-Reply-To: <87h79q7tln.wl-maz@kernel.org>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--yqSnZDWT+mQxO4gU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 09:07:48AM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  	/* Distributor setup */
> > -	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> > +	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);

> So you now only test whether it is possible to create a virtual GICv3,
> but don't actually create it. How does this work?

Oh, that's rather obscure in the API - so the file descriptor returned
if the test flag is specified can't actually be used?

--yqSnZDWT+mQxO4gU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxRAUACgkQJNaLcl1U
h9AvJQf9GPAYtZanstoIG/vcqbA26bVsQFGfS/00XrVuAL2Gbc7mGcVXqn87KWGx
hUpfjqbMlgfEAqSX8xudmJKLmHxxkFce8M49ZoeP0/nN1oxvCTftYEKOO+YH8xFO
diP9rAIH4DGjH8szv7dzRE8KCSW0Svj8xwvBZm9SZJs7nqcZ1AcBN0iA2HRWCgK8
V1irsnWI852LlcDfaYetrsr6WN169e/PXBNNuISNIqsDQDe9gYDFJNHIWzB3hV3n
t2C3m3maET8C2vJukqxEe8Dv0E7A0Uofa4H8C6Y+Yae6HWd3cpD9WrSr7PfrW1un
zS0RmqmmTTactke64zug0VjVbgRjvg==
=8u2k
-----END PGP SIGNATURE-----

--yqSnZDWT+mQxO4gU--
