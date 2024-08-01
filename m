Return-Path: <linux-kselftest+bounces-14676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C466D94532A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A12D1F24AEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A6E14A602;
	Thu,  1 Aug 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO6UZUDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9114A4EB;
	Thu,  1 Aug 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539684; cv=none; b=NiaUUtJNWez7L6aP5CdhtvMNQrVDK6zU/kRitx2P43r/RiWi8NioQgZugXa5FVDcQSeLsELNxnihSCVrfnZ4neC8T5axxC7B9fff4VK3UO6K+FQSLBb2U3/LWWWbNFoJjTTxhN0Gl9CE9RznVDJeN+F2P9pyBzkS52bkvhM0mhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539684; c=relaxed/simple;
	bh=01anIdeFIR/TWrwSz1YbUxgJaSbTkSDm5rr3OWMkjdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/RD1CAdhASdFVUFLGIJ8ip0e4vTejXYZB2HJfAbWYsn5EzudXT9g1SSARE8u9g+ID6ScdagUEwSe2gVXoNZeFZKRCWR42drVvhd9kp2YNz0z7H75L3gVLH9sCsYtTIIsdcBPatMhg428/u6sQ5xRt8ncOKWq90jdVV2UewO+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO6UZUDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2774DC32786;
	Thu,  1 Aug 2024 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722539683;
	bh=01anIdeFIR/TWrwSz1YbUxgJaSbTkSDm5rr3OWMkjdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RO6UZUDAEWZsWglXXKwTFsO9xVKhj0mTi/mnbKGJ3sSIk2oDgZUW9OUdoYGuJgXPa
	 C/yFMnWp+SIejEgWyGoD/6I+ULSONP7a0ZFnOavGK8fQc2YyiIpwFAUbdAmEZtRAvM
	 h+85u7I2JI+JzDN72osT7qL8MvzQFgl30lT6HrjfHdtTyrbzGQxy/YGiD7ynitZ7iU
	 1w2Wcno/6JehBQOutAcGaqGiQnu+CZAo/YxNlED1kB9cc8+jnllBVUHkWvZcE3s7kv
	 hbSj247qiGc2OLqocHmEJPVlCApYkY4FL7OzBoH8Wsq/RmvjxsFTqADVza06CvBeq8
	 9kaR6WsVHUbVg==
Date: Thu, 1 Aug 2024 20:14:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in
 get-reg-list
Message-ID: <811ea0eb-bc87-4ac3-8bca-27c787e43051@sirena.org.uk>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
 <86le1g19aa.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yi/EHoEl7X6dkR4r"
Content-Disposition: inline
In-Reply-To: <86le1g19aa.wl-maz@kernel.org>
X-Cookie: Be cautious in your daily affairs.


--Yi/EHoEl7X6dkR4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2024 at 05:45:49PM +0100, Marc Zyngier wrote:

> Can we please switch all this stuff to symbolic naming instead of
> magic numbers? Given how much effort is going into the "automated
> generation" thing, it is mind-boggling that the tests still rely on
> handcrafted numbers. We just end-up with two different sets of bugs.

> At the moment, the level of confidence I have in this stuff is
> sub-zero.

Yeah, I was wondering why this wasn't using the generated values
especially given that the generated headers are available to tools - I
wasn't sure if this was a deliberate decision to cross check the data
entry or something.  I'd certainly be happy to convert, though that does
seem a bit invasive for a fix.

--Yi/EHoEl7X6dkR4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmar3p0ACgkQJNaLcl1U
h9CLLQf/eEUB37vfZfDmSeqDsqzTJxrgeoFWmua8m3kh7D1xJkT/G8sCyaJjErpr
4HYDfLgkBajnm+kHRk742Ou8t9nMA9FXfkmf7c/dV1aoAXkBPFXfEtixXsTNZE6M
S8qxvb8jtvEMRWkxwONbifDelVkIn2sYwNpIDhPLPuU91evqBJyOh12BJi7k7TEq
jwERSrSZGFmkfxetToXyj/sVcydl7etTttU8Nl5UleaXOT/aRaCM0TbJX58osaKn
ajLQt7TiDEqYYGulWDePcmZIRWaYMdjx10FmZek8HkzqHYdUGLMofK6b6Girs+Jn
RnAHOD+8aLKjAHUakhF1I4E9eFkIQA==
=XmxA
-----END PGP SIGNATURE-----

--Yi/EHoEl7X6dkR4r--

