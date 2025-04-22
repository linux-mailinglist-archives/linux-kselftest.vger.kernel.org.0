Return-Path: <linux-kselftest+bounces-31306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B89A97049
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74FB173113
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CA28EA5E;
	Tue, 22 Apr 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZv0FcEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F34EEBB;
	Tue, 22 Apr 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335053; cv=none; b=pADtOPQURBEvm7+5WSs3z7la4fTiCNY2Ubrf4B6DgLfBEgTKsOBgIa9Ysv/RYSSG3C/mjzXG1y7a+wBq1fkkXna+5RxiJRXnnNMhIP4osKsYJtGEse6ZbWj/HezEXVP8N/hiohTQfGr+p3k3Z5n5mq2vCycinRBW6Ikxsrve3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335053; c=relaxed/simple;
	bh=gm2YtakWua6MgLU2MMARUhkStvU91vYswH2RlQrRvmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC/Pg3wgQZm5eGE/4TdYehCUB/DXBjy0pS85TE55a+rO3LviSk8ZTBq9y6Xi0JAsnIzwblPwEGgVymwN7de7LFm35gmYNVszaKOpUuhF5kJSll9dB347S1e9GXrcUK9rnbc5Dh22ipnAj9YMIwK928crHX4TT2YKjB20j4jZkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZv0FcEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C978C4CEED;
	Tue, 22 Apr 2025 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335053;
	bh=gm2YtakWua6MgLU2MMARUhkStvU91vYswH2RlQrRvmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZv0FcEmXwnwBYh5A3BQhodZ654sV9WP0Ct/QcxXpV+HT6pCfoOJ42TAoSPxNzfF8
	 UuOet1+RTGfAdp4gmB2LSt+gCcbsE+QMw1CVNr7jHCZLRmng+UypBhQ+62OUSWb22n
	 tE5jV7Lm5dse3VXl9p5d1PWPlHPHDXJ7enNlYsx5JfVwZ/ZP4anpkTWKPkfNYAtgbz
	 IL48GoxbMb/j2f0yjvyj06J3+zkh2sNHtBJdOrxDpYp23hQKsdiK4YPz20HDaBsMtz
	 wC9+S6wfGq1eFixXrdeAtf6wYrdhU/ZX4u9tYtX98mACqcDWwyFla8BEulGp5DIsaQ
	 Z9OB8yOaB4Rxg==
Date: Tue, 22 Apr 2025 16:17:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: PRIME_NUMBERS_KUNIT_TEST should not select
 PRIME_NUMBERS
Message-ID: <7e03d4e6-5ae7-4fb9-b072-051d4e24f413@sirena.org.uk>
References: <40f8a40eef4930d3ac9febd205bc171eb04e171c.1744641237.git.geert@linux-m68k.org>
 <f2a55a3f-6c56-43fa-bfda-25cc11fe5212@sirena.org.uk>
 <202504220759.67C0120FF@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AMxZP8oKYqpRSRxv"
Content-Disposition: inline
In-Reply-To: <202504220759.67C0120FF@keescook>
X-Cookie: Why are you so hard to ignore?


--AMxZP8oKYqpRSRxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2025 at 08:03:09AM -0700, Kees Cook wrote:
> On Tue, Apr 22, 2025 at 01:10:47PM +0100, Mark Brown wrote:

> > This commit, which is now in mainline, causes the prime numbers test to
> > vanish from my CI which is a regression - the selftests config fragment
> > is obviously not picked up by the kunit runner when it builds the
> > kernel.  You should add any KUnit tests to one of the configs in
> > tools/testing/kunit/configs/ - generally all_tests.config.

> Ah! Thanks -- I forgot about these (apparently my memory horizon is at
> most 2 years, considering commit 4d9060981f88 ("kunit: tool: Enable
> CONFIG_FORTIFY_SOURCE under UML").

> Does this look like you're expecting?

Yes, in fact I actually have roughly that patch in my CI already.

--AMxZP8oKYqpRSRxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgHswcACgkQJNaLcl1U
h9D3YQf/dqeIXtguSHIZFGeY3YzYcyhDRFK4xiwAHqZzvXeKnBn6wSf64JY0Q3qS
mx8IjfXuE17PuyVRzZrkOAtBWAdlvUW2swBstcnauc+ZVC5RzwEH89YiEHx2d/l0
wvM3/GPzGkUhCexkvesbE4CFZCLmexwujiz33diFPRHitNFx01UQmGZRY7IPSfHC
nV702kGVHOoIM3TT5pL7fSsuWpibFp9/Ckt8S7u60+0F2SbL8BqaE70aHwxe1ITv
XXJItunnq7Lrwhj4SDC9FxT91c7eKJ6TuOgf3mqjZZRSxiSp5cpaQeIAiTsk6J7C
QNK3XzaZ1Ditvw7C6zFn9YI8JkXizg==
=chZ3
-----END PGP SIGNATURE-----

--AMxZP8oKYqpRSRxv--

