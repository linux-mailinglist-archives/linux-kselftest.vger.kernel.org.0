Return-Path: <linux-kselftest+bounces-16809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB69665C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255BDB240DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE381B655D;
	Fri, 30 Aug 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G7x7lqFO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426941B653B;
	Fri, 30 Aug 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032058; cv=none; b=et0bWgCukkY5HUaZBlWmPrfcK7exvoXI2Ud1EgoYCumLc3+4ASINPhrJSLAhmDex8HmEeDsgYQ9i6rMcgGQcspkrUGPFL0BSwyLr8aWOGuFtasui7ThwTbyQT2VZnHnY6YXQ6bg10eTrghLvgkG0OjZJZEzZ/wiwUqSYGjQdbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032058; c=relaxed/simple;
	bh=/XryR1JGSGlWcvWZUrlRcN4aOhv3ZUX5yaHJjEerzJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrVX4xdKeTTZuZuDXy4B7FsfcMqZc2CbdOqLRXct2hhDfvaIh85wTCdYc4KnRgMz3GdBhEi7+yO2ut0jzfvioIsE15Kdyc2yMKOK524znOufi6xptEx2mBudmDATIxU/CHWssRG/0mmfl4HdCu9dzOgOiUFpOrybyNDCaGQPxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=G7x7lqFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300F0C4CEC5;
	Fri, 30 Aug 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G7x7lqFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725032055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pEF7065aXbW2Ym3pos15rAL0Nq8C/WBIBiNy2olJqEo=;
	b=G7x7lqFOgvLsWS5KqCk3NLUO7J9PtQXUitskQTDfclq54jRri3t6ESD/XhNLPMTS6zqJtl
	a/NfgKAh7EaTpWRUcNMTo8P+mUKsW6dbrXJxPSsnivCmLoLMVt+p/wWAA99qf+UzXSxc9i
	xtdpDW5/bD0ZENmfzHE/BDa1gvIC21o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 16dad5be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 15:34:15 +0000 (UTC)
Date: Fri, 30 Aug 2024 17:34:13 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/vDSO: Fix cross build for the random tests
Message-ID: <ZtHmdf1XsEJLur84@zx2c4.com>
References: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>

On Fri, Aug 30, 2024 at 03:06:35PM +0100, Mark Brown wrote:
> Unlike the check for the standalone x86 test the check for building the
> vDSO getrandom and chacaha tests looks at the architecture for the host
> rather than the architecture for the target when deciding if they should
> be built. Since the chacha test includes some assembler code this means
> that cross building with x86 as either the target or host is broken. Use
> a check for ARCH instead.
> 
> Fixes: 4920a2590e91 ("selftests/vDSO: add tests for vgetrandom")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> The x86_64 build is still broken for me because nothing installs
> tools/arch/x86_64/vdso/vgetrandom-chacha.S (I beleive it's supposed to
> be copied from ./arch/x86/entry/vdso/vgetrandom-chacha.S but I don't see
> how?) but this at least fixes all the other architectures.
> ---
>  tools/testing/selftests/vDSO/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index e21e78aae24d..7fb59310718c 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -10,7 +10,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>  TEST_GEN_PROGS += vdso_standalone_test_x86
>  endif
>  TEST_GEN_PROGS += vdso_test_correctness
> -ifeq ($(uname_M),x86_64)
> +ifeq ($(ARCH),$(filter $(ARCH),x86_64))

Actually... this doesn't work. Because:

ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)

The x86_64 gets turned into an x86. It's a little trickier when
considering subarch. I'll send a followup here and not queue this.

