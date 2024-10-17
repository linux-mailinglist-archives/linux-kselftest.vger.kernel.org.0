Return-Path: <linux-kselftest+bounces-19961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6369A2444
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178B6281095
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA11DD548;
	Thu, 17 Oct 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcFglXin"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61611C147
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173142; cv=none; b=cIrkg6Ftm+7ot2rNOkGLLn5opoH3q6ScsXz5wcvHn43UPVREQRJkQ8RSNumsT4gq3Jgmdw1M/BxvT7ssne4unPqbqOtES/cuMepOG+DBtTX45/+ADfc7mjaxjBe+85VCYmrvRLxGSzpIK+aQeCyaJOWQcsEA3q9GddyotCWNQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173142; c=relaxed/simple;
	bh=Lzc8/UvUCZR5yb6EfCDFEzDaV8g3Ckprx5sQcnXx5wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktdf2sOIQVuFFVQEpoet0i3X37rVuSr4hIvwLDDyu4ucqK5VPUQkespVQ2WxjIkuYBTEYYQSdGHvraWPjc8x9sg5Q9ziMu9N/Nn7JbwEoy6jPSAc8LEfsbkgafoua4ElN9jFSmQzedFOjSQC030fxTFW41hecZY/nySEXnljaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcFglXin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF5BC4CEC7;
	Thu, 17 Oct 2024 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729173142;
	bh=Lzc8/UvUCZR5yb6EfCDFEzDaV8g3Ckprx5sQcnXx5wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcFglXinzoZFgGYgDdeyzTXurxNbciBEL4tsYn5KOd2VeWu66QShCtV8WVncJlrV1
	 4lgN6eXI/OPC996S4Z6L3h7vMgsCCaBArdz8Z9r8dyJYkVQ7/bmXDVUnbwWawJvzjP
	 aGVV+5LOTIFxt/tn9skKjytMNcmv5TdAGJkRQTNAIRGBYs7ozoaBAqKrZPM8tKs/Al
	 bU2PKlmeVpOcvTQuPhnHOQ9+Dw8Rt4jcBQpLNer9OKI0ETtC88Ru5mIRnr9K3T3jK8
	 q6DHoY7Cm68rApr5oTkpT81cy5em5buAcRpp62ioabHlGXdCU/fSScZMCzmcGp6J2L
	 qaUr4jcq7kNzw==
Date: Thu, 17 Oct 2024 14:52:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	dave.martin@arm.com, jeffxu@chromium.org, joey.gouly@arm.com,
	shuah@kernel.org, will@kernel.org, linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 2/5] arm64: signal: Remove unnecessary check when saving
 POE state
Message-ID: <17ec1d72-d902-41bc-b652-6b3b7dd61872@sirena.org.uk>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-3-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FhMD8Wa5anRdntm+"
Content-Disposition: inline
In-Reply-To: <20241017133909.3837547-3-kevin.brodsky@arm.com>
X-Cookie: One picture is worth 128K words.


--FhMD8Wa5anRdntm+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2024 at 02:39:06PM +0100, Kevin Brodsky wrote:
> The POE frame record is allocated unconditionally if POE is
> supported. If the allocation fails, a SIGSEGV is delivered before
> setup_sigframe() can be reached. As a result there is no need to
> check that poe_offset has been checked before saving POR_EL0; this
> is in line with other frame records (FPMR, TPIDR2).

Reviewed-by: Mark Brown <broonie@kernel.org>

--FhMD8Wa5anRdntm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcRFo8ACgkQJNaLcl1U
h9CU0Qf/V8TCCseHFMvQ5CjtPw8EeGw0MFUzcr9NZ1P7QsH+sVvsobmhRjXc7wFJ
jbOL+cX7lhb0kR5cmJLG+ar4WxnWYTbaJ46X6oE3J1XK6uIsowzON0aj9Healvf5
gGOvHq4fBq/0hjnpSh9mfttZWnieK+eZ2953tziqRaeGYmJpBBBmHWXH8ATgGmYO
Cmt5gstkZeuqp9E5a9B9MfS7csE/H8tpZstaePNdw/WuHkRvVD6vE5wYqZUjDtug
xTV45PWmXOipcjBJb5JK9w2RP18q/PS58h9hLJRTNcJIlLKuItz1Nwta22vH6mce
mq4oIiWfKRLMsBAdvj2FULTlagnHzQ==
=rrHV
-----END PGP SIGNATURE-----

--FhMD8Wa5anRdntm+--

