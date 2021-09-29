Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100EF41CA51
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbhI2Qjw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 12:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344376AbhI2Qjw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 12:39:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B5C760F6E;
        Wed, 29 Sep 2021 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632933490;
        bh=seeBK6jT9/yDCZFkA5WcebzZu0xlpHUHOmo08Y4Y3MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Woa15ujxFTWO4EXjfY/kEs2ppTWT6EfuKSlaBvzC24HirWQn2Z+THQOFbBPpkDnnj
         4tXPfpxmW1ITDujaMvZakDYrRuWbLOzwdbmx6omxo2MzenLeFjTW/G2K8kLumA+pRr
         qL3Z18Mmtw/c7niKYN63Fnxfd1Migb9q7aEK6e8lboMaYixpENKhUvNmRMGfuW/iox
         i6x6ZvFK/RXIEqNQI53N68ZSNPuGhWAuD78DXyrnGMUm3u3AvE2DVR+7aRQkX89u8s
         mAV9H9zPc4/TvUoK6xuvw+1cQbRVc8rGXKMH9pVkZZsgs9Wn46W80EovsJ8ziSAXV8
         vOHL93Y0o76qQ==
Date:   Wed, 29 Sep 2021 17:37:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
Message-ID: <20210929163721.GT4199@sirena.org.uk>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210929143113.GA22029@willie-the-truck>
 <20210929144323.GQ4199@sirena.org.uk>
 <20210929153511.GB22029@willie-the-truck>
 <1b573881-ef9f-c7ae-c08b-8079f63f66ec@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aEcIyhw0mmnxygNd"
Content-Disposition: inline
In-Reply-To: <1b573881-ef9f-c7ae-c08b-8079f63f66ec@linuxfoundation.org>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--aEcIyhw0mmnxygNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 10:26:49AM -0600, Shuah Khan wrote:
> On 9/29/21 9:35 AM, Will Deacon wrote:
> > On Wed, Sep 29, 2021 at 03:43:23PM +0100, Mark Brown wrote:

> > > I'm not sure it's a particularly good idea to run kselftest as a
> > > non-root user TBH, it's going to cause you to skip a lot of tests.

> We don't want Kselftest default run to be as root. Users can choose to
> run as root which would be an explicit choice so they expect and plan
> for the impact. Example panic test.

OTOH if you're trying to verify that the tests aren't broken it's not
that great since it'll mean that you'll not be exercising a bunch of the
code.

> > Ah, thanks for pointing that out. It would probably be better to skip the
> > tests rather than fail them if they're not running with sufficient
> > permissions, but I'll go ahead and queue your v3 for now.

> Correct. I would like to see tests skipped not failed if either config
> or permissions are lacking to run the tests.

As I said previously that's what my v3 that Will referenced above does.

--aEcIyhw0mmnxygNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUlkAACgkQJNaLcl1U
h9BXCwf8C/QJ0Wk8Siu/Ov7a+fsmZ72GiFe+uTJyGHx5p6qudilGHoMRmOZx7bcN
lteDZh2DjfwkAltlZX56Yr1nqo1R/UdxboUJoH3VhGwVuC/1RgRQw2YGb77wbsz9
kyVU1H1RR8muJ0heM7LBYPdo91EE+/cB6onssOcLhlQ5uj/apaaGje6bxGz3gTDo
+XQbzsepyf0avQVGI0ULYh9gzjw746fopDzZ1PzyBM7ZytdYSMAjoYenKvCLQ/h7
eYch0qsCVUWJwhRiPKdVwsHH1Z7v6jSaGigaajwDN6NP8j3/Qn8+zepGTBJbEcrl
OKh0AxT5/J0Yy1sEcawT0VkwHZUUQQ==
=Qqh1
-----END PGP SIGNATURE-----

--aEcIyhw0mmnxygNd--
