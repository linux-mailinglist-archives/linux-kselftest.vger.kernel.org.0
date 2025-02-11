Return-Path: <linux-kselftest+bounces-26435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3377A3197B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BF4167928
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30232267AFE;
	Tue, 11 Feb 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujNtVwwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E28272908;
	Tue, 11 Feb 2025 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316326; cv=none; b=RU4lUQ8Vj2Ie/0UCJEU9tBbEC0wD33gTQzRfre/QYfDhjknXXhm80nLa1kkLxCdDcj9C9ix64ta2f10XyZhfhfDkGLs6FHbTuDL1lVzEd7d8G4wVErfEB57hc9cBInoQImGTUVF/+brTSBt3ueYSyYx8qWPtQ4SyS1Li7AFLsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316326; c=relaxed/simple;
	bh=togaeu5eaYhtKO5F7a7MEwakO3LtPg29+ybcKw1HZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBe6N2Cl7/vTYxpSEbz4kfqgorsex1sU5GpiaPkxn9y9iAcz8in56bb+dk39RdmnmrO8F2DE3x47xxPq2lbdr8eurEL+MFF9T9nfCDzC9Gbq4EcoiBsf4YxeNMPWtB2c7AUg07hUUOHd2JVwQo+Tw1cl7k9wi8nst9A33q8zL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujNtVwwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB830C4CEDD;
	Tue, 11 Feb 2025 23:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739316325;
	bh=togaeu5eaYhtKO5F7a7MEwakO3LtPg29+ybcKw1HZAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujNtVwwrOvLd2zUbxO8T+ZpGhw+6qjcq0sqXTkBtXgoekNuwHuUl/Q90UOyWS/LNb
	 DethNKoB3gFCDaazLBtXZUVl1wj/jYcEUSgUXz/CZ1p8yzmGNYo0GFNr2u39PI+FlW
	 bmMWRhfmYbnDxD3ts3vkemwM8AI5wXeKk9joXckVkPvYa16mUlMXMXicu8t15WMkPg
	 On7tsqfCUvCTA7yjSbtWTH5L0zt0mO0RZiFWamII5MiXVSLEniHWH+zdbYBWKKgjdJ
	 F0KiXEPo7phRkKiDgM+BdhZJXg7GBKlfkmJRUv9ufsh505Pex7yt9JtunUvYbN897Y
	 K76uWspxLc12w==
Date: Wed, 12 Feb 2025 01:25:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ahmed Salem <x0rw3ll@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, shuah@kernel.org,
	skhan@linuxfoundation.org, linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <Z6vcYJjC7vEpf5Um@kernel.org>
References: <nyskb7mbqk2dvlwhez4sua7ryz5gyi73yker6y3qhd4chyyeaw@x6nhqgtxcyvl>
 <D7PTH0ZUAH5L.VVEECLR4VEWH@kernel.org>
 <x4dtkjgxwy7vyjg7rryvqqu3lwhiqm6jmhr4ph2fexa7m2m2mv@dbefieqhx6x6>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4dtkjgxwy7vyjg7rryvqqu3lwhiqm6jmhr4ph2fexa7m2m2mv@dbefieqhx6x6>

On Wed, Feb 12, 2025 at 01:05:02AM +0200, Ahmed Salem wrote:
> On 25/02/11 08:10PM, Jarkko Sakkinen wrote:
> > On Tue Feb 11, 2025 at 5:00 AM EET, Ahmed Salem wrote:
> > > Use POSIX-conformant operator symbol '='.
> > >
> > > Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
> > > ---
> > >
> > > Apologies for my previous mistakes.
> > >
> > > Changes in v3:
> > >  - Reword mistaken commit message
> > >
> > > Changes in v2:
> > >  - Remove snippets pinpointing the issue 
> > >    from commit message
> > 
> > OK I read what I wrote and I guess it could have been misinterpreted.
> > 
> > What I meant was to take the relevant part of the transcript that shows
> > the issue (and possibly also how it works when fixed).
> > 
> > Sorry about that.
> > 
> > [1] https://lore.kernel.org/linux-integrity/D7OY3ZVGJOV5.R3SL9SBFT2DF@kernel.org/
> > 
> > BR, Jarkko
> 
> Understood. Thank you so much for your review and continued guidance!
> 
> I will be sending the revised patch shortly with the proposed changes.

Yeah, like narrow down the transcript that's all, and yep what I said
was somewhat misguiding...

BR, Jarkko

