Return-Path: <linux-kselftest+bounces-21696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D59C2088
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364BF1C23263
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AF212D35;
	Fri,  8 Nov 2024 15:35:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D11E7C26
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Nov 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080133; cv=none; b=NLioleoUqvrp4iUPx4M6OzELVeGXqiDZpeTiFoU37oNOB8EH+c42wVNc1N4sh1PURIHxNudNfU8js3ON2vfJk3XD421PbUM5RmmVJ+MGTFI/WVuZsNWVi40+kOvToKjq85vqOFBFGQ9OJE7zwSp1EEVYP0v7X2UCr+/FTdifECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080133; c=relaxed/simple;
	bh=Z/5iRe6WH8NhG7kcq181o/JIXmhVX38+YgyqnKr13Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzdA7OiboCXZ1ia9gabLNtt3denvEdidPjAJFWDykVWtcMqwr6szOuT7jErzej4KQvbVEJqM4CuzC1WnJfZQVCnfSlJwMbp1819+GtdkHOXVlu54e7lN1M/g/AlV3B6ijnFJ6nVFx9mPJbxW5e6dTefxsVYGOxAM/52meGVg9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFB4C4CECD;
	Fri,  8 Nov 2024 15:35:31 +0000 (UTC)
Date: Fri, 8 Nov 2024 15:35:29 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] kselftest/arm64: Fix printf() warning in the arm64
 MTE prctl() test
Message-ID: <Zy4vwYeaIiQrWfXO@arm.com>
References: <20241108134920.1233992-1-catalin.marinas@arm.com>
 <20241108134920.1233992-3-catalin.marinas@arm.com>
 <4bbc179b-73b6-46d7-b414-f3b14079b489@sirena.org.uk>
 <Zy4telEzvU1DGih1@arm.com>
 <6a1669e8-1654-461d-8709-3cbcaff7da67@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1669e8-1654-461d-8709-3cbcaff7da67@sirena.org.uk>

On Fri, Nov 08, 2024 at 03:30:11PM +0000, Mark Brown wrote:
> On Fri, Nov 08, 2024 at 03:25:46PM +0000, Catalin Marinas wrote:
> > On Fri, Nov 08, 2024 at 03:10:59PM +0000, Mark Brown wrote:
> 
> > > > -			       (ret & PR_MTE_TCF_MASK), mask);
> > > > +			       (int)(ret & PR_MTE_TCF_MASK), mask);
> 
> > > Shouldn't we just use a %lx here?  Casts tend to be suspicious...
> 
> > It's more like the ret is actually 32-bit and should stay like that when
> > bits are masked out. But the bitwise op 'upgrades' it to a long (in
> > hindsight, we should not have used UL for the TCF bits and mask).
> 
> Hrm, right.  Possibly put the cast on PR_MTE_TCF_MASK rather than on the
> expression as a whole then?

Can do.

-- 
Catalin

