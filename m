Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8649D338
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiAZUNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 15:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiAZUNZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 15:13:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B41FC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:13:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEC761779
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 20:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4CCC340E3;
        Wed, 26 Jan 2022 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643228004;
        bh=hmQwvBpYksIzl7tcb2EWb3VBLUCZuCxu0fG9RHpcc/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5brgLcOgZMJcUiF847vR77ELwVGIwtvyWnad09uOpkGBhYsb0BJ+W3OLZxHifz9O
         jSczxpKBaMUyGvHAxdLo9EqY5sFIeK68bjApwhDDDQ6vOKzRD+CjKZ90O99Mx2CSp/
         Xyz3kZ2FBleEAFziaBLYEcmzoawON03dFy24I9QyEbR75X9sBr4Z4EzrExYbgzYkOf
         A8xjnQGDmQ1ZnDmSlo7GWJAnr/aJbjl7Re9ngOoKYGJe9U2AVWRLJvfiVt6SgS+Ptf
         zrTHv1oLmuyamYZ9TnUMFII0PXoIVAOgW2yNu6ML/1XktIAXuLuXyUQu6VXn4Gjimy
         /t58lS0pg2mBw==
Date:   Wed, 26 Jan 2022 20:13:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <YfGrXr1/NGREULnB@sirena.org.uk>
References: <20220126145242.3473836-1-broonie@kernel.org>
 <4424dd30-f74b-006f-b540-dbaf02e45e28@linuxfoundation.org>
 <YfGmk1I8l+ROoE/k@sirena.org.uk>
 <48c44d74-6668-7823-ada6-0285a8b32a35@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HNasRwzf7887euQs"
Content-Disposition: inline
In-Reply-To: <48c44d74-6668-7823-ada6-0285a8b32a35@linuxfoundation.org>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--HNasRwzf7887euQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 01:03:44PM -0700, Shuah Khan wrote:
> On 1/26/22 12:52 PM, Mark Brown wrote:

> > If the function fails for any reason other than the system not
> > supporting vgic-v3 it will abort rather than return.

> Hmm. vgic_v3_setup() return gic_fd looks like and the interface says
> Return: GIC file-descriptor or negative error code upon failure

Yes, but in reality the only return other than a valid file descriptor
is just -1 rather than a useful error code.

> I don't follow the abort part.

All the TEST_ASSERTS() in the code (including those in the functions
called) are calls to test_assert() in assert.c which if the test
asserted isn't true will print some diagnostics and call exit(), the
general idiom is to give up immediately on error.

--HNasRwzf7887euQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxq14ACgkQJNaLcl1U
h9CC/Qf+PVOAm5Wc6qrMXiY0e8FQ6SOhccpSgyoFbwUUJet/ReDC1snRgYGn+vTx
O+LMTd3nvNcl2guAo+rUn/0bvyUFgINvvECors31R6gMO/y8m5rsQwP+2Hsf5FMY
bLpy1Jd3olD/cXw8gstIq8X8HMvfGO5q2Kt4Pk4L1Bi73K6E37vG/CydsE21n1jc
KI3JYbj2Zk41ylo8a/rfqcO7xQuhj3e+B2jT0Wll7+JyDCMZd69Cni/13mYBLy9e
mudYeJfwt1HZWxNqltl9KWZ221u+Mkek/aCHfklyFLVIDcI0D/p8dT/Xmw0amWaI
mnmMSKKsnsVFZ6VbdLE+kgHKKKPi9w==
=q/Nf
-----END PGP SIGNATURE-----

--HNasRwzf7887euQs--
