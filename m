Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856385AB8A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 20:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIBS50 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIBS5Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 14:57:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C430EEC5E
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 11:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C65F2CE30E8
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 18:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0220FC433D6;
        Fri,  2 Sep 2022 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662145040;
        bh=dbJipCqZH47geoYBSGS+07TYRjh+fhp0RLhPCXdVNnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k81URW6bUsBbsa9teu1oszbl+0fTuw80usZbyv/s/FSist7cJMsIijajFWiTrG6+e
         peXJuLfuCju29Ghq8e70NcXQH7l8i9yw/zgJpIaoNjpgIMYyJfp6CG9xPT8DwSWFGi
         qb4/ttkDpivV5Nr16Yh4st2564V3I9aTTZJ92sy2AQXYMqld314R8QNnraRoIkjfV9
         IjdpGeAPo382nXO7+CHLl6xmDqRy68XA3zZmThaNmEgs05xfmcd/tfipvwUtLXzYg3
         4FMDXYctrRQ0BZNx50JzO1TvLWds4vO/AU60CdfjOexy4l1Wew7HBW+8LShUMcRvWi
         NRCTWIFxlqokA==
Date:   Fri, 2 Sep 2022 19:57:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64/sve: Document our actual SVE syscall ABI
Message-ID: <YxJSC02ORt/4GFkH@sirena.org.uk>
References: <20220829162502.886816-1-broonie@kernel.org>
 <YxJJ3HVNbJO4Z+kT@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qBIm3/vzvBtXiAFL"
Content-Disposition: inline
In-Reply-To: <YxJJ3HVNbJO4Z+kT@arm.com>
X-Cookie: I doubt, therefore I might be.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--qBIm3/vzvBtXiAFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 02, 2022 at 07:22:20PM +0100, Catalin Marinas wrote:
> On Mon, Aug 29, 2022 at 05:24:59PM +0100, Mark Brown wrote:

> > v3:
> >  - Rebase onto v6.0-rc3.
> > v2:
> >  - Rebase onto v6.0-rc1.

> Please don't rebase beyond -rc1 unless it no longer applies cleanly. I
> came back from holiday and I have two or three versions of all of your
> patches in my inbox. It just adds to the clutter.

OK, sure.  It might help to advertise what you're looking for here - the
whole thing with wanting everything based off -rc3 has never been clear
to me, IIRC I figured it out from some off hand comment rather than
actually knowing what you and Will want.  It's neither base off latest
nor base off -rc1 which seem to be the more common policies.

--qBIm3/vzvBtXiAFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMSUgoACgkQJNaLcl1U
h9BfzAf7BWB4FV/lelZ9CRYaIf05qu2U2H3xXFfeWwaH2HvrTAQCC6ccwBPH6zfR
htPoysCBFY/qPj6uYyKQczbcSchfs45dfLKXWZpmFSx6IDKEUCYvGZxaijmIK3Ul
nx1W7xw1+CoiD0S07yCYB0INQbWZQxJH3AU68kP9nLPoWDxrmeSwtBHBx5I4Czcx
0IIMNaifjAqwcBh3oWDs0YNJbVIsWpL4OwwwaovQLTkuWzr7SIdL5TRQWTZoC/eO
goT+SkuWfJUsINlWSnxfrJsNujet6jWDOr7jrwjimpF5gs5gXd7j+oN7xymZM/pP
cHn0hEmPE1aX/hmJjAJw/khibP0Hbw==
=Q6hO
-----END PGP SIGNATURE-----

--qBIm3/vzvBtXiAFL--
