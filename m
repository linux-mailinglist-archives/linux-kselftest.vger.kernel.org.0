Return-Path: <linux-kselftest+bounces-15543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD91954F5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201EA284CB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD431BF328;
	Fri, 16 Aug 2024 16:55:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6681BE85F
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827356; cv=none; b=Rhu2JxII4lMG3/qlOKKh+qXRJfd+WvUfIjPGSef/seMibPc8/XgoKcCqa4ZUA9FBZB6OBr0Wyimx1F0mdHvmSKqS2esTYTLW+0ZTsl4GcflO1O8yy3nB7zoWYaZOmA6lIRU1kCMzgvUvONH1JD8Pjl1cXcmaQwTDSsG88umjIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827356; c=relaxed/simple;
	bh=d1eMlxGsAEPKU03SDWs0l6hbj4BIetqqke0EVmCK9Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okQiEVySfRgaeWUuQaVZ0HSlDb9MSBhE71U6tt+3v3voz1cCCcTcUZKVI5F4SgpnHElW82UOrnR0Clrp94Kdi+3tqpLzkgJzsB3fiTCvw0KGzmwDF0JPK0WLmGxZe9GPwx0lxiYnV7VJQAMtlFUkWDf4m9eBgb5sFsBbUnpJbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2783813D5;
	Fri, 16 Aug 2024 09:56:20 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD4E3F58B;
	Fri, 16 Aug 2024 09:55:52 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:55:48 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Shuah Khan <shuah@kernel.org>, Amit Daniel Kachhap
 <amit.kachhap@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/8] kselftest/arm64: mte: fix printf type warning about
 mask
Message-ID: <20240816175548.01b0c515@donnerap.manchester.arm.com>
In-Reply-To: <1afb487d-b5ba-499e-bae1-8579d7b3303c@sirena.org.uk>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
	<20240816153251.2833702-6-andre.przywara@arm.com>
	<1afb487d-b5ba-499e-bae1-8579d7b3303c@sirena.org.uk>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 17:30:14 +0100
Mark Brown <broonie@kernel.org> wrote:

Hi Mark,

thanks for having a look!

> On Fri, Aug 16, 2024 at 04:32:48PM +0100, Andre Przywara wrote:
> > When masking the return value of a prctl, which is clearly an "int", we
> > use a uapi header provided mask, which is defined using an "UL" modifier,
> > so the whole expression is promoted to a long. This upsets the compiler's
> > printf type checker, because we use "%x" in the format string.
> > 
> > While we could simply upgrade this to a "%lx", it sounds wrong to
> > promote the "ret" variable, that is clearly an int.
> > Downcast the mask instead, to keep the type correct.  
> 
> This suggests that we've got some confusion with the UAPI, these flags
> need to go through a prctl() return so they shouldn't be unsigned
> long...  That said, it's UAPI so I'm not sure that's fixable.

My thoughts, exactly. Not sure if this mask is used on some larger types
somewhere else, but it's indeed moot since it's UAPI.

> > -	if ((ret & PR_MTE_TCF_MASK) == mask) {
> > +	if ((ret & (int)PR_MTE_TCF_MASK) == mask) {
> >  		ksft_test_result_pass("%s\n", name);
> >  	} else {
> >  		ksft_print_msg("Got %x, expected %x\n",
> > -			       (ret & PR_MTE_TCF_MASK), mask);
> > +			       (ret & (int)PR_MTE_TCF_MASK), mask);
> >  		ksft_test_result_fail("%s\n", name);  
> 
> TBH my inclination is that this is worse than letting the value be
> promoted, casts (particularly casts of constants) are just obviously
> suspect in a way that printf() formats aren't.

Fair enough, I wasn't sure about this either, and indeed this down-cast of
a constant smells dodgy. So shall I just use %lx, and rely on the
promotion (so the MASK being defined as UL), or cast "ret" to long?

Cheers,
Andre



