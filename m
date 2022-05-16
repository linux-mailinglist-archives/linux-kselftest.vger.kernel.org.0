Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BC528CA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiEPSNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbiEPSNt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8056F3D4B5
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 11:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42B88B815A3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 18:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDECAC385AA;
        Mon, 16 May 2022 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652724826;
        bh=tTku+6Tyd6MFwBgZs1ZbL2tOphYJflmq2ZYeWbo0oKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0Y1qb6t6JfZkZ+mPR/krnEQ4Hh9JfEAtinATuhzG1PDKScmj8xyLf9ywxwlTpZOU
         +pMPyAFogLtgciLfxQ+hvBqowUW4obntsqUrXdUb8DqIo+bSk8RYR+Ce30Tl+fxtTf
         W9xvBxUGxjLCWSfVcf55FHTo9HmLvggYgf4Na53FJHa0PqGnrCKbpZGv5jzWuM4QEf
         RYooPa5ahyYDfemHGYbjBE7+7nK7R4ZPQVpNMIyF29cVsm7dozSCVVlWXhA56aj+HI
         EQ+0HywSihqXx2FKFd/0euvC+xrB4LnPxEt1L9YINlu8Fq2YIxS0aCSZOhMsleZhoa
         t0QtzwSSqIe5Q==
Date:   Mon, 16 May 2022 19:13:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Explicitly build no BTI tests with BTI
 disabled
Message-ID: <YoKUVfVCcj9u/fR4@sirena.org.uk>
References: <20220511161004.189348-1-broonie@kernel.org>
 <YoKTYFtXMsZW/+Iq@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZN9Z6PW4tCrWPzq"
Content-Disposition: inline
In-Reply-To: <YoKTYFtXMsZW/+Iq@arm.com>
X-Cookie: May be too intense for some viewers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--OZN9Z6PW4tCrWPzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2022 at 07:09:36PM +0100, Catalin Marinas wrote:
> On Wed, May 11, 2022 at 05:10:04PM +0100, Mark Brown wrote:

> > -CFLAGS_NOBTI = -DBTI=0
> > +CFLAGS_NOBTI = -mbranch-protection=none -DBTI=0
> >  CFLAGS_BTI = -mbranch-protection=standard -DBTI=1

> Do I miss an patches? I can't see the CFLAGS_STATIC in the arm64
> branches, nor in next.

Ah, sorry - I have some WIP stuff to do a dynamic btitest binary.

--OZN9Z6PW4tCrWPzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKClFQACgkQJNaLcl1U
h9ClMgf+NWNgVjj0YMGubLUNw/j7GcHcq3khwRZpjzO5gaXr26926M6qd3lkWADW
kd0m1MP6fZNnXgz8SzH2MGn6DLojxeCNdkYvrDlVWmBUi8CGDXUy0zz1aBdDgmxu
Obcmo5HOsMBq+1e77zIFAVILGHD6bNjLsAJSFU8tcOF4RNWofamPTunvwpSViWyn
Jq3AXkInkb2E3eTfP7ecVCk8mcqmdNRkyo7qCfkN2y94VDL8R3NGQEDB1pyLxGT3
7keXe5ff16o4INEEu3li3WfIHanxC0kaM8J3BVAVNCCjNxQ0FDx8UYtb5geKOlav
IXyhrxwybRFkAsUxijIBxes0Vx/aDg==
=mv8P
-----END PGP SIGNATURE-----

--OZN9Z6PW4tCrWPzq--
