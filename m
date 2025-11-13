Return-Path: <linux-kselftest+bounces-45592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9671C5A549
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ED444EB331
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7642E6127;
	Thu, 13 Nov 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+SorA+T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3D2DFA48;
	Thu, 13 Nov 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073239; cv=none; b=TQUj9LaaTcbLB1dPl8oTUdpFE3OGw5lPOLnRf/YhbjrkAL16sqDv1UkYhXmuXuz+/YMZtqgFuOD3+scTTbPqXPcHgZ+2pXiY8eWGC5DIl+eZWa9j9gf8o60KLe9tTYDy1KLhvNEGwxg/F8EMp9q1Vnf+NgJRSwaT1yFIKasQrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073239; c=relaxed/simple;
	bh=ZomP9AbfNlKZXi56JMsQPWtvmmMeRaVV4VF65hib0gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TER76MHuo/1onJOr9G5Yb70n7OMEkaaFZCYGAZyPZ8q8IWuBwsw+yxUb6sbpcsOKrody5rroUda6ciZd4QJ8J4bqGhN3kiCcApXvRP9HJy5s/aSIvfcC872TPk7py7uS4y9SGtTgS1eEAnSML29jhYA77zGjY5XhQMsDCg/gHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+SorA+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9AFC4CEF7;
	Thu, 13 Nov 2025 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763073239;
	bh=ZomP9AbfNlKZXi56JMsQPWtvmmMeRaVV4VF65hib0gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+SorA+T3oiYjAaWcO8c9g2c8W82OReP7LPLrfICb7Q9fEn/bbZEuoh/2cayVXbj1
	 6HsZOxZjfPp1eY9zGi78KJrTpOlFzr+lA/PZUho75r/isGPWLiaTYwQHQ3uehrOc1M
	 Mfeb70ytgLuMZ9EgVEHW/ECEs4JnP80O0Nv5q2Byd3OhFqCmnb5tUlBV/l90Xkd5B6
	 EhmK9qpjthxP2Iq0MkH2HCoOPdjQahUuAeMdM/KfQfLUSUktIwGjluFi4wN55MFRke
	 5c+IQK0PXlLBRaby9MEpFZlBJUp+yA1gomij6ZTpAXb4yhh7PVuzyrD+rMG19wM7YL
	 sms6HbHcZBejQ==
Date: Thu, 13 Nov 2025 14:33:57 -0800
From: Oliver Upton <oupton@kernel.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: oliver.upton@linux.dev, maz@kernel.org, duenwen@google.com,
	rananta@google.com, jthoughton@google.com, vsethi@nvidia.com,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com,
	corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
Message-ID: <aRZc1SqU01Cyxc5Y@kernel.org>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <176305834766.2137300.8747261213603076982.b4-ty@kernel.org>
 <CACw3F51cxSgd-=D46A6X6GptEZS8-JZ_MnB_yK_ZR1wktunYRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51cxSgd-=D46A6X6GptEZS8-JZ_MnB_yK_ZR1wktunYRA@mail.gmail.com>

On Thu, Nov 13, 2025 at 02:14:08PM -0800, Jiaqi Yan wrote:
> On Thu, Nov 13, 2025 at 1:06 PM Oliver Upton <oupton@kernel.org> wrote:
> >
> > On Mon, 13 Oct 2025 18:59:00 +0000, Jiaqi Yan wrote:
> > > Problem
> > > =======
> > >
> > > When host APEI is unable to claim a synchronous external abort (SEA)
> > > during guest abort, today KVM directly injects an asynchronous SError
> > > into the VCPU then resumes it. The injected SError usually results in
> > > unpleasant guest kernel panic.
> > >
> > > [...]
> >
> > I've gone ahead and done some cleanups, especially around documentation.
> >
> > Applied to next, thanks!
> 
> Many thanks, Oliver!
> 
> I assume I still need to send out v5 with typo fixed, comments
> addressed, and your cleanups applied? If so, what specific tag/release
> you want me to rebase v5 onto?

No need -- I took care of the issues I spotted when applying, LMK if
anything looks amiss on kvmarm/next.

Thanks,
Oliver

