Return-Path: <linux-kselftest+bounces-16040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC195B2A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0021CB212D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57617DE15;
	Thu, 22 Aug 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHhf7VSh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323F2033A;
	Thu, 22 Aug 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321624; cv=none; b=LvnpzlPt5/ouUdyeGmZpbbAZDJYqFTnnyGtSFJN5biCMKOtRqO6CalRekWGKe+nBgwktCE1SKdX/Mq+jVlTOzT0HcKXXRewqWVEuBk/2qJsuePNSwLMFr0C3VzagkjJbTsb2u6eFliBv4N1smMMcXKnsoQ0W0d5gVzjfHsZMRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321624; c=relaxed/simple;
	bh=39TFUOz4ywXTFWX0266kN3BSTB/omdkuUEgKdN1k0fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNJ0XT7TxYvPa+AvWaybvkIqsbizwBs5DAwXvZDlIHkomX7aRWUmmSZTb0UMObpummui/WZNa7E+T2PEFLnsRoqZ7ePp+rkuMjnscjPRVI3Knnye59zG3o7Xf7jSsJU47FXZZ+fyMJ1nkHKGKrMo2MOIY2tpzt9UviupK9i11vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHhf7VSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4032C32782;
	Thu, 22 Aug 2024 10:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724321624;
	bh=39TFUOz4ywXTFWX0266kN3BSTB/omdkuUEgKdN1k0fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHhf7VShqp2gOVCaoGaZcVB7XiO9/saEricNNIbwpb85dW1xnEzB0PAMMTo2kSE9h
	 ipkg4JY/6zT18K8EJ2bCI+cSMnprrYIPbp3bZZBTBx8Ox0Jk5YZUF15lXnvwiAo2rP
	 ctLc1Q25CXSF70xS2I2Y3syPaYgf0Pq/DUAw+CpjCK4aDWJqfv73fGhK0pxN/Lh6Z6
	 pnSMO5BSzj5S4TvhIgVqM8kwzohps1tNdesusd3YeIMNvWjiBDk0VX7QP4abLPeWUV
	 La7X5AgpgcOTeqB0+sR16dkPsbwUMBoVmMbCXpQwKd3Naz9k7eKKJApRtFuPUfluFU
	 vfhgwLyWW8D2Q==
Date: Thu, 22 Aug 2024 11:13:39 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] selftests/net: Provide test_snprintf()
 helper
Message-ID: <20240822101339.GI2164@kernel.org>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-2-7bd2e22bb81c@gmail.com>
 <20240821191004.GF2164@kernel.org>
 <CAJwJo6Zix_bkE38RmDW6ywojvmzeOuPVtwH+Jqqz6AT=6jmh5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6Zix_bkE38RmDW6ywojvmzeOuPVtwH+Jqqz6AT=6jmh5A@mail.gmail.com>

On Wed, Aug 21, 2024 at 10:35:10PM +0100, Dmitry Safonov wrote:
> Hi Simon,
> 
> On Wed, 21 Aug 2024 at 20:10, Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Aug 15, 2024 at 10:32:27PM +0100, Dmitry Safonov via B4 Relay wrote:
> > > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > >
> > > Instead of pre-allocating a fixed-sized buffer of TEST_MSG_BUFFER_SIZE
> > > and printing into it, call vsnprintf() with str = NULL, which will
> > > return the needed size of the buffer. This hack is documented in
> > > man 3 vsnprintf.
> > >
> > > Essentially, in C++ terms, it re-invents std::stringstream, which is
> > > going to be used to print different tracing paths and formatted strings.
> > > Use it straight away in __test_print() - which is thread-safe version of
> > > printing in selftests.
> > >
> > > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Hi Dmitry,
> >
> > Some minor nits, as it looks like there will be a v4.
> 
> Thanks, both seem reasonable.
> Did you get them with checkpatch.pl or with your trained eyes? :)
> 
> These days I run b4 prep --check and on latest version it just gave a
> bunch of fmt-strings with columns > 100.

Hi Dimitry,

For networking code I usually run:

checkpatch.pl --strict --codespell --min-conf-desc-length=80

Where 80 is, I believe, still in line with preferences for Networking code.
Although I'm not entirely sure it is applicable to this patch.

As to your question, in this case I think it is the --strict that causes
checkpatch to flag the issues I raised. Sorry for not mentioning that in my
previous email.

