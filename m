Return-Path: <linux-kselftest+bounces-42313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCDB9EDEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 13:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A939168D55
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64202F6173;
	Thu, 25 Sep 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi/ti6+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F993279DC9;
	Thu, 25 Sep 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798766; cv=none; b=WQpPX/dO1Da9Fx14SKDDqpEQanF2MJEjjj//AcOyJXOKuypudZRfTxu/1kNNYmXBSUVLHs6Crertgb+TNF9EDRsLvy0CUTP1EH99srduY9Y/uUPP4Cs09eB+USPKwdtzBqBMbfWwn19jGlPvSoIcTbr6kPsZEbIZLQUjcxIoeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798766; c=relaxed/simple;
	bh=wfla3Y1dSOons3njeFEIdGceO7zZYUF9LjcXnMti018=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6H9yvvYJuKPhFetkznIGrmllPBL1bqpFPvShxjzcZNFF7hr/P+D3BPwWjRGDRUXPrfiOEC1zvRntlnNDWJCSh28Le1DsCOZEzynyfaMeep3BFVAKNlM1k7TLfsnpR23ZWTQuUp+aNfCxXUvjHZ7es1Cl6rCrECn9MRcSrLVm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi/ti6+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E44C4CEF0;
	Thu, 25 Sep 2025 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758798766;
	bh=wfla3Y1dSOons3njeFEIdGceO7zZYUF9LjcXnMti018=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qi/ti6+UFCn/UIlo3PwLexk1yaz/R6xiLWxHGTGD3mB0dB04GgRsXqKVfnRTjk8yR
	 5x3q9UjODw+3r71sYYtUc7xf6xKEPx/0bIYcSMpTafCYt7Fs+TArK9+DDxph/ZcleQ
	 A3HkSq4HL2/jyPqD4TLhqEjhb9hDFSy1hN+8ynZ1SqYLuwkQFiJ16yTF65UiKXxptu
	 GGjSRKJYeTQYCOQ0m+GfXntvJ8/mgOufm7qEoN/kU2rvpX/bqvNii6AxbcY4tilT4v
	 m7xmALPJZiroYgymzgTiBrsbaiPMbpxPi4xO4z6E45wB+PczS7Y3aTUf3NviBcdIdv
	 /S3f///+7Kp6g==
Date: Thu, 25 Sep 2025 12:12:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in
 set_id_regs
Message-ID: <bb46cc46-f177-4cc7-b0d0-c7970d8d7a6d@sirena.org.uk>
References: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
 <87ikh7ya8y.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/zaKCw9JkNIMK2ix"
Content-Disposition: inline
In-Reply-To: <87ikh7ya8y.wl-maz@kernel.org>
X-Cookie: Shipping not included.


--/zaKCw9JkNIMK2ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2025 at 07:29:49PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > ---
> > base-commit: 5db15c998c390efbe5c82f6cda77cb896a3a6a3e

> $ git show 5db15c998c390efbe5c82f6cda77cb896a3a6a3e
> fatal: bad object 5db15c998c390efbe5c82f6cda77cb896a3a6a3e

> What's the point of indicating a base commit if that's not something I
> can find? You should never base any work on top of something that
> isn't a stable tag.

This was due to you having applied the LSFE patch but that application
not yet being visible to me at the time I did the rebase (I've noticed
occasional slow mirroring on kernel.org recently, possibly it was that),
I needed to base on the already applied patch so that I could check that
the test binary worked properly.

--/zaKCw9JkNIMK2ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVI6gACgkQJNaLcl1U
h9CWEQf+LhWPmI+TiqBpNhHF4rThKI4mBv/BM3yn+6w5SjGK/aQgfPXoKuBSa8gF
eajZSipUrKXtenT9qN2VJu1n02ahuNh75Issa/SipMwbkjRYseunEUSZoLzfvfaW
5aVqnQ21GIOtoQLj3as1wfVRVMQw/fntDTJBAp+NFQYPh6Iky4TPkgnSG9PTqfGJ
MiCU4IupB+pg+zebaH/fG69j2YHS9kegvJS+E+uLa7vkE0TEsc8qUXvxQz0TSvhU
8e0XJ3GMu3okoXZ9iNxRcVrcuG1VuBruhSG7In9NpaThNs7ilXDF+eTcOVlhDvtO
9FRj1mHPSl4l8O0vp3BzuFgeiR8oyQ==
=IRxn
-----END PGP SIGNATURE-----

--/zaKCw9JkNIMK2ix--

