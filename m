Return-Path: <linux-kselftest+bounces-19181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD0F993803
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 22:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8301C23816
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582C1DE4D1;
	Mon,  7 Oct 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRHaMUVF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183A31DE2A6;
	Mon,  7 Oct 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332012; cv=none; b=hzHDOljFusQTwBYlmY7padqZU8dDLzgyRUHR8X6WeGUMIgJZ2umCO02L30y05OCcr+gE/7SQzRhRlGjf6xPE34kATAMwI5xL7LWCOkMriSP3mV1dFrKA+2vbXGmhuKBmEw6Fjf22oJgEnaZHLP6vu/72bmnEjGM8jYOOJ5s/zRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332012; c=relaxed/simple;
	bh=OwIhuTuOCjUtH+lqgN/r1UqFieX0/XSad9XFiZtVLcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK3vIyaYfEuDPHTTyOVGsoprXuz9hWFcuAwApfeDMIyLMmRDBgUfdnjNA4ZJpYmTa1C2fw1W0BztSvsqaGEamLbfZtIEOq0DwsKBDN75MLnMZebF41IBRrLDWADdZvtsxhIMrW5u/k/RAhuH9snzA4ixLanumbQbyGTwNwdkBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRHaMUVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523EFC4CEC6;
	Mon,  7 Oct 2024 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332010;
	bh=OwIhuTuOCjUtH+lqgN/r1UqFieX0/XSad9XFiZtVLcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRHaMUVFTAo7VuZziMXYKga3+9IlFNUBs1+w/AIQTM7RgYCqXpycouKGEvVepWApW
	 mN8Dfk0+OAS6pD18TFBoe8TGU9CerVHT8BL15YyDsB/0OS2287GfsvL5BNOLTV+rEc
	 ruox0bRTM2POMWw4Jtzbc85/q6BiuJXERmo4/UxDADxZ6g/nf6gXuSBqou+zkYStJC
	 bxvLAg5wGtrFLK11GWMslT5YUiWUFxsz2RmeEy8y/chbCgQJghlm/rBS1wJ/1RbOcV
	 fGWC1+rxcO/VjMQimuhE6q+bu/pKZjftFARmQQQn9IoKSa2ckW+ioYBQGhBAbHw/8c
	 qvdKO4xxzsRPw==
Date: Mon, 7 Oct 2024 21:13:28 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] selftests: sched_ext: Add sched_ext as proper
 selftest target
Message-ID: <ZwRA6P3YZ42JjVk9@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
 <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
 <87r08rnbra.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SlQF1kEi/Sq2tluV"
Content-Disposition: inline
In-Reply-To: <87r08rnbra.fsf@all.your.base.are.belong.to.us>
X-Cookie: Editing is a rewording activity.


--SlQF1kEi/Sq2tluV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 06:00:57PM +0200, Bj=F6rn T=F6pel wrote:

> The sched_ext BPF programs relies on a vmlinux.h, which is generated
> using bpftool and the vmlinux with BTF information. Have you built a
> kernel with BTF support?

OK, so having beaten the kernel config into shape and using GCC rather
than clang for my build I did get this to build fine.  I think the main
gotchas are the issues with the arm64 defconfig not supporting BTF and
the fact that the Makefile silently picked up the host kernel.

--SlQF1kEi/Sq2tluV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcEQOQACgkQJNaLcl1U
h9CsgAf+JweWiALg8MrJcyZWQ/Pn9EUqi7KrnVreTX5EzvtXhEdADiwSpjKYXx4h
h9ifs9ponWUCIpZIsC0uBFE5/kUpRfUuqg3lPlJVkbK2OyMy0C9WKk/gs6J06OYR
YBERMPJ877MHJB1dt1jC0Mmy7jMA3sGY3l3kN4xrJ1eYjRe7jsvDIqnc8KaK5v/l
P4DZIPKQcecagc6yppx5BYjyEBs3x2osaUKwuUOqHFlavzOZw9JUdSenhfcCJXhh
Hm3yRRUvyr942RhZdL201NxZBpGFjqFufHL6XQo1eY56U9we/SFVKRBroPo3mOPg
EM+El1VEGI8+TTAEyp8AIS0xJfFGXA==
=VPuE
-----END PGP SIGNATURE-----

--SlQF1kEi/Sq2tluV--

