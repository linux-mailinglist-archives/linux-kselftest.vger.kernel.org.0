Return-Path: <linux-kselftest+bounces-41858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D9B8572E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6BB2A2D90
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20801C3314;
	Thu, 18 Sep 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5jpQoQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DC18FDBD;
	Thu, 18 Sep 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207991; cv=none; b=og5xtZDvOd7kH4wPoqnPks4kDJLKQY34qv8FMz2rtWuAMMO+yEKDC93YTlUszlo/+MHlYZmKbzKPjOqrJBsJdycydC+khNfanXqL5D5dWqMFwPooLVqTdfhDQLJEneYlKltqqzWVdKun3QWWKYBBBAClY2J8JuRg2Ofz5RQpr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207991; c=relaxed/simple;
	bh=XHpYkSXN/kkI4pHYvhq40cYT5X0wwZU5bBK87mtoEwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+qpvE3mBL2dDhjpPJgXkJcmCm4X70d14EDu7vWgd2zc2DbAHyctnKHlMwL5+ovr7COIwjVTSeqOrq/beh7oZ3094kR9Y5Z8OixGK0GQ0iZ9nxughB1V7Z/EGTMUN4U0vBX2ns7ia/ymUSP+N3MVS5K9O36hUghmxJSVQQg+ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5jpQoQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE1C4CEEB;
	Thu, 18 Sep 2025 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207991;
	bh=XHpYkSXN/kkI4pHYvhq40cYT5X0wwZU5bBK87mtoEwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5jpQoQGgPW5TsXsmOLAPXjfDQUr39YJqQ20OWkjTJddESnZoV162x2OAnfgJV3b4
	 kfbrGryZgm89wuOcsJxDu/b6TucmGZnvn+qb54qq9h0KpiLZhUboOS0IdtJCg02Uyh
	 huOWaCPcL2/ZQD3cMGvGqHGv1YVumAgKOQRrSmeejl6pLRiAncsI72qxSjfmaJDhf8
	 HX0gocAzZPwcQpoy7ykRJoF5brttZsmhVnWFV6suHeQaHMTronTOSCYpAJUq3AQjWe
	 iKGQ/cuBdlF5b8Io0VvkOm6//0enh3hkmtwGaMk7005ZAVrYUBgp6REPu6thcEbV5D
	 2y2X1oXadikTw==
Date: Thu, 18 Sep 2025 18:06:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: kselftest and cargo
Message-ID: <aMwf89qekCuAdD1L@kernel.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
 <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>

On Tue, Sep 16, 2025 at 04:39:37PM -0600, Shuah Khan wrote:
> On 9/16/25 07:48, Jarkko Sakkinen wrote:
> > Hi,
> > 
> > The pre-existing kselftest for TPM2 is derived works of my earlier Python
> > based rudimentary TPM2 stack called 'tpm2-scripts'.
> > 
> > In order to get more coverage and more mainintainable and extensible test
> > suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
> > is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
> > 
> > Given linux-rust work, would it be acceptable to require cargo to install
> > a runner for kselftest? I'm finishing off now 0.11 version of the tool,
> > which will take some time (versions before that are honestly quite bad,
> > don't try them) but after that this would be something I'd like to
> > put together.
> 
> Probably fine - how does this impact kselftest default run?

OK so this was early query: I might introduce such test as part
of series that hasa waited for long time for an update [1]. I can
use tpm2sh more easily to reproduce equivalent crypto as kernel
does and make a test that can compare the results in a meaningful
manner. I also plan to relocate tpm2sh as part of git.kernel.org
custody from Github, as its main dependency tpm2-protocol crate 
already is [2].

I went over the top in the original mail: most definitely it makes
sense to retain the pre-existing test, and such "Rust-enhanced"
test should be conditional, and can instead of depending on cargo
simply do "command -v" in order to check the existence of tpm2sh
and output installation instructions if it is missing.

With those precautions it should be somewhat harmless unless you
actually want to run that test.

Thanks for quick response!

[1] https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git

BR, Jarkko

