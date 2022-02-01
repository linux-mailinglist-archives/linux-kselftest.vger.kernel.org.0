Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C54A62CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiBARn2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 12:43:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37298 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiBARn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 12:43:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A0261266
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 17:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4744DC340EB;
        Tue,  1 Feb 2022 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643737406;
        bh=/KTrZBEyV6pqKGAlc78yl605G1ixk0QNgUXm07ChIdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kf/99bOHt2NDqSRfO1wtMreMxosFlJLwM1bhGE4KJa6PBZ3panCiFVaWt2ZXgNrbY
         Bn0amhODmgn5i7lWWwESMr/C0/X1vYl8FPKZrzsfX/7Jl6e4sEVKJS+e7P+igBK3bL
         4f0poaLmUnNfa1zI0966jwD9hbjWLy+JcwJeEI4j06Ovdyz9Hi9CbOECGFGXSI5okM
         /RZMutlGvYgrvihFw8OELCYNExz7qaOBoq2RGCiIPIVVYFgHBo4n16mg9AOUsWQgTB
         7DylTHRT6qPFRvcbJQ2VRvQ/rhufh1zvOTYjVApA+Ca6+paWnQ3RpCOO/dNb+9QTuU
         LVneiEBsIxqiA==
Date:   Tue, 1 Feb 2022 17:43:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: Check for event generation when we
 write to controls
Message-ID: <YflxOnS65NDyx5Ul@sirena.org.uk>
References: <20220201151551.21497-1-broonie@kernel.org>
 <0e1bc48d-ff3e-a4f8-5f81-d6902e89458d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gY52o4Z50JJtWXeg"
Content-Disposition: inline
In-Reply-To: <0e1bc48d-ff3e-a4f8-5f81-d6902e89458d@linuxfoundation.org>
X-Cookie: All's well that ends.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--gY52o4Z50JJtWXeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 09:18:52AM -0700, Shuah Khan wrote:
> On 2/1/22 8:15 AM, Mark Brown wrote:

> > +int wait_for_event(struct ctl_data *ctl, int timeout)
>=20
> Let's make this static.

None of the other functions in this file are static, that'd be a further
change to make the whole file consistent rather than having a mix I
think.

--gY52o4Z50JJtWXeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH5cTkACgkQJNaLcl1U
h9CU0Qf/REJTfz5jncQd+T4BEpJ+maX9T/SxGsXtSMDJELroUPB1VgnSV7HbU7SV
BULsVDO/95YK649ZArYHqqUVO+mq8hQhWq3YiFrhFINQUcGNrWL4yj1RiHlP6K58
Oi/enb0DmRTv4UAPt0d6gXWWKC3h/YxndeFyVcVAUSJ0+0CXs0J4e2CmYCCp2wRs
u2Ezppv+6oG/fbYn2J3Df9mDQNIW9/w1/TH1Ls1mEaH4vV+D3UB+SqKEDbs0Lt6C
IQK7pGArF4Env+GHwij+9igC7hlkTsZ357zkm4twodw4DSS62PJJAJJAfPdc0i65
QdejD4xkTzConfxU9P4aO7l9+jlQ3A==
=+qVw
-----END PGP SIGNATURE-----

--gY52o4Z50JJtWXeg--
