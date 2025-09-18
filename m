Return-Path: <linux-kselftest+bounces-41884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A205B860F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537CB4A3014
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3D52FFDFD;
	Thu, 18 Sep 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqwp1By0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FCF291C1F;
	Thu, 18 Sep 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213348; cv=none; b=icoiToL9lJLzmiNjQJ1enaGUPXgTjlp7qXfJ3PuGQ7Ofo3KtPK2NSxKrtKsAp6Ko1QmEXDj1OnmnbaPDpe/Lx921Qc4g9Gq2BW0AsyvwQJRVXu93AGWhN4GqBsgu2FosAjora71vp4f3XDOne2qotCdTq25yJcZsECqWTnUxokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213348; c=relaxed/simple;
	bh=uxbX3t65LxbL3UUj4PABQhIPHTRcI8HpQVH4OGiCm8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHjzEkwv43lLHwc5X+FGlesxnlxUtxwcR15AkDIhIa9u77ozrP5PzcWC32pr4HF/obqqYjagrGQiBghJ3KXNZaycyZpd++q2GKC/ARrKnLIS/tlZNjUwskvMtT7GYyJIfxMYl9UwNHpwL92dj1cVC79qwwE9vJ1VP0r/LrogUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqwp1By0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CC9C4CEE7;
	Thu, 18 Sep 2025 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213347;
	bh=uxbX3t65LxbL3UUj4PABQhIPHTRcI8HpQVH4OGiCm8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqwp1By0aLBYXZSos7hikkd57+UkiZqpzTzsct6C1oCr4v4HxkJq+ywbiYD+eg7AF
	 Mkaqizqg6vbSGGjcMdUGSk3iNE2PPyN4dhfzBt34BIiF4wETQszSvRG3lEUNyrKuzR
	 gaoQm7PTRi7GhvzxrCXkpsg8VIgJSiCOMN0kr25ym9GXH4Pn/gC2LEq/VAd7Jbaqjy
	 ZjuCT7VL36rm15P8NNiKlLauHiH0URE4Z1O/5G3ppmIyv57ahV//NF5ZQEnR7ycsSr
	 OGXbuloZdCQrFboMMXHnxVA0SW25H+7I2OxWNzCK45tUtfSB8R3E9h5UeZfGxOL1l6
	 gDW/kl+Y+6RTw==
Date: Thu, 18 Sep 2025 19:35:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: kselftest and cargo
Message-ID: <aMw032Im4D9zy77g@kernel.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
 <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
 <aMwf89qekCuAdD1L@kernel.org>
 <aMwh95tMxB7sMEzy@kernel.org>
 <6712e20a-0fa9-44f5-ae0d-f4d9c3324028@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6712e20a-0fa9-44f5-ae0d-f4d9c3324028@linuxfoundation.org>

On Thu, Sep 18, 2025 at 10:04:13AM -0600, Shuah Khan wrote:
> On 9/18/25 09:15, Jarkko Sakkinen wrote:
> > On Thu, Sep 18, 2025 at 06:06:31PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Sep 16, 2025 at 04:39:37PM -0600, Shuah Khan wrote:
> > > > On 9/16/25 07:48, Jarkko Sakkinen wrote:
> > > > > Hi,
> > > > > 
> > > > > The pre-existing kselftest for TPM2 is derived works of my earlier Python
> > > > > based rudimentary TPM2 stack called 'tpm2-scripts'.
> > > > > 
> > > > > In order to get more coverage and more mainintainable and extensible test
> > > > > suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
> > > > > is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
> > > > > 
> > > > > Given linux-rust work, would it be acceptable to require cargo to install
> > > > > a runner for kselftest?
> 
> What is runner for kselftest in this context?

It would really just a bash commanding tpm2sh and with conditional
check the binding is kept loose.

BR, Jarkko

