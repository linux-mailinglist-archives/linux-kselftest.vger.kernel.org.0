Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F6841C70F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbhI2Opy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 10:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244878AbhI2Opy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 10:45:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC2DE613CD;
        Wed, 29 Sep 2021 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632926653;
        bh=KDeH4Oq7N91SAJ92j6g8VLFdgZePjlYp+OIhj/hPpQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhJ0yBEgr1JT6AeXNNCwP7pMEN51qs+wSNIm63I3d8Ijqg/ZECwKvlIvYBFVd/IHb
         n6gGb64KIZaM5knIGeavMny6Pu6o+4Y/dGUl6ZHDLOt6a3U2D5xucaPkzB1v+0fLDP
         2zrLrZkt7L2If1rf0i+2SMRFA41F2NfFR2liN/7hW5S1eWJm/klF2Mo1JeYwNEqsj5
         gO2BMqPcya3TylBSTIjocPzTB7H2PyHSfTMTTV7i+UCOH7gYmthWhdgziXgSVcpQuG
         8uRy1bvvxsO00ptb6RQZFeMH6cC1XsoBQW81tflEJWRqzSjZpthnsuoLMnUh1pBnps
         QNLr47W1Kxgng==
Date:   Wed, 29 Sep 2021 15:43:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com
Subject: Re: [PATCH v2 0/4] selftests: arm64: vec-syscfg updates
Message-ID: <20210929144323.GQ4199@sirena.org.uk>
References: <20210917120855.13858-1-broonie@kernel.org>
 <20210929143113.GA22029@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
In-Reply-To: <20210929143113.GA22029@willie-the-truck>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 03:31:14PM +0100, Will Deacon wrote:

> With this series applied, I see a test failing under qemu with:

> # selftests: arm64: vec-syscfg
> # TAP version 13
> # 1..10
> # ok 1 SVE default vector length 64
> # ok 2 # SKIP Need to be root to write to /proc
> # ok 3 # SKIP Need to be root to write to /proc

AFAICT this is due to running as a non-root user, the testsuite was
already having serious issues before then...

> # ok 4 SVE current VL is 64
> # ok 5 SVE set VL 64 and have VL 64
> # ok 6 # SKIP SVE only one VL supported
> # ok 7 # SKIP SVE only one VL supported
> # ok 8 # SKIP SVE only one VL supported
> # ok 9 # SKIP SVE only one VL supported
> # # SVE VL 272 returned 256 not maximum 0

...as it's starting off by testing an interface that's only writable by
root and then relying on that information, the existing tests were also
not working usefully.  qemu by default supports way more than one vector
length.  In any case it's just the test added by the last patch that's
causing the output here, the first four patches should be fine and fix
issues.

I'm not sure it's a particularly good idea to run kselftest as a
non-root user TBH, it's going to cause you to skip a lot of tests.

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUe4sACgkQJNaLcl1U
h9DBfQf9HNL8PZN0AtWCqD1wZf94yN/NDZBjC7dAhHnPvds0UmoA1Oba1db4VkLD
Qz/6MSjljl/twcINqAmlsAUV8wo2/evGdf3U0cVSglt8g34Vcii5w3n0eSNevvdJ
oLpGtOWqZKrl3tULCbCAYS+tQAYiKgFj2mtG9QU2T8zEkFLUbfNBj1qaLXT+Uw7w
53nZlTRwD90Gb5lhjR7ArEF41kCONsMBBf6Ph2g4MMryM2ldlpRMvHZM72FQ51cw
56pjUM5+BZJtTEHaBMQMHIWLFOg8EKWxd1WxW8fqOjfJxRzFpvbo/DH+mdoKW+ry
+BzSGBgCN4qyTGcgASu4SkZLC1bi8Q==
=BntX
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
