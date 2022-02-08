Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448C44ADCB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380449AbiBHPco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 10:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiBHPco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 10:32:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDECCC061576
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 07:32:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A17C615D9
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 15:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E3EC004E1;
        Tue,  8 Feb 2022 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644334363;
        bh=xkCl46PxIRqJOyLnKnXeEbrwIR9VZcGvqu20AX+stiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBOazE6zLv/3hLMyJSCZD8cd2X4UXB3kotQ2i1oU0JqdeXdvNwJr6IbAhyB8FqLaT
         pjkfzs/UVkwd7STsDa9c/GnqcRDuP01FnTwbvVwbAgWQO16fs4b/Iwvkpodwqbs/JV
         BztzYXnRm7n2U7czRNBZAB5LULrWy4TxIzu83s+buC4vNDMFK/DXgouVnUtbJvVLON
         S0Ra+nQ6FWqg5M0nJQqpVYwP7egbpZub23iXAiIS799OzTo3ARMgf5YhpSh6dY9Y/v
         B4o6RZmGHuL1YJZQ7Cj6skVuCnQZMHhEZdarxyohIlk5rsOVMz/Hg5BlWC537XILBb
         w6fFYHE8R+w6A==
Date:   Tue, 8 Feb 2022 15:32:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 05/40] kselftest/arm64: signal: Allow tests to be
 incompatible with features
Message-ID: <YgKNFHzeBdq0J77j@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-6-broonie@kernel.org>
 <10072dd0-8853-81fe-0c94-a00638b12f9a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z8ks9/oFG0GDDgkd"
Content-Disposition: inline
In-Reply-To: <10072dd0-8853-81fe-0c94-a00638b12f9a@linuxfoundation.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--z8ks9/oFG0GDDgkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 04:54:31PM -0700, Shuah Khan wrote:

> Assuming default_handler() will skip test and return skip test when
> feature is unsupported?

Yes.

--z8ks9/oFG0GDDgkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICjRMACgkQJNaLcl1U
h9CO6QgAhqg+JBvQZ/3fZt76+A70JOOev3FnXbKIFWDN4T6WPi6WUg8VX1yQ/MRU
NQxZ2+E9xcMAGlz2DBiUkyEBypJS48Qv+xITa7HLpqQ6Lz+qu3HRk76BhHUkGbiq
X01XiZHgS0ehDkVLqo5RhuUxvXLTBUKxXurlxVxuPTE1jWKz3s5hrjstv2AD164o
1e1mJ9BnmyjyCpzW2hJN3ZssaxreQMhUvmIfHyH8C0zsaR7EBwSg/rmSjvl7KRH6
9MxB8LFBA58w+GtbBcRn8XarugENsVq5EzOaC6QpI5CQuxJ6lYKUc5/3hNoeU+nP
TMe4bM4HmJbRNc8Lii4pII/aoqBSAQ==
=QONM
-----END PGP SIGNATURE-----

--z8ks9/oFG0GDDgkd--
