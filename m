Return-Path: <linux-kselftest+bounces-18970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68398F376
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD5282397
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2741A4F0A;
	Thu,  3 Oct 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RubMBB26"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2819C56A;
	Thu,  3 Oct 2024 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971355; cv=none; b=VIVh2HZg9woQpbEL+2CocSx1JAPEJagBGhc48xl0o00pvlH4vjya7PlMfI9tENFBolW324IYQFmUmBOvKFC4uruwAKCD2Ydt6YdZZtJQ3723tQxPlhz4zcSljQQX1Xc5skBvzLxz2xTQx2Vu73dDe+pgOjcUuSP9hl/l18ELdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971355; c=relaxed/simple;
	bh=Y71mbrna8xlCnax0uZFatRiHGYRfpFpahKmjPE5G5ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9h7B5/wixDgJjdeiGMJGD9QEINtdD/6uzkBS8bC1yDVaBiKKInK7GMnD18Of+CkhayvufNQXaPcjO20A5FxWVylUE/zxEUUHKZL0dvgaNrLOfn1kXWLlfmzH+SnYJ8Wk7BZD6Vr/Fp1RnWaq4AlzT6yru67++9f6BP7ZmAndj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RubMBB26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A50CC4CEC5;
	Thu,  3 Oct 2024 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727971354;
	bh=Y71mbrna8xlCnax0uZFatRiHGYRfpFpahKmjPE5G5ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RubMBB26C2QwTsQjmJIZrHKxSCvTLbsI5CAqrMxuoVibNdF0Tcj5Y2IeAvT+hMDqQ
	 yvowSyQfH+EF6OvHkDGqgfbITK19AOJY09N711DMmkKPNvUXtHWyPhDF3Q8sx6y+WE
	 VlkEp4l9eXDD/1geyUwJdzaNdgUtrfHgWZfcKKokxvSq59VVPVq9xmzqv2SUgNYGEw
	 rtuh3TWT04Yzbkwh6C1+9vFpvAxWpvqAa1jFqBlzuw7UYhiGvkdGfQZuZdRE6ZUTjC
	 5JDy/EGA16Po5UsUszUBXHc9wT2+9jeiH+8qbz+GFLR2NGSmFtQ8kHuF0kQQuChgeo
	 Qvj/9U/E2Pgfw==
Date: Thu, 3 Oct 2024 09:02:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "workflows@vger.kernel.org"
 <workflows@vger.kernel.org>
Subject: Re: [RFC] MAINTAINERS: split kselftest entry into 'framework' and
 'all'
Message-ID: <20241003090233.11d24c66@kernel.org>
In-Reply-To: <MW5PR13MB5632FECA88BE3F0711032738FD712@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20241003142328.622730-1-kuba@kernel.org>
	<MW5PR13MB5632FECA88BE3F0711032738FD712@MW5PR13MB5632.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 15:05:06 +0000 Bird, Tim wrote:
> > Create a new ML for "all" of kselftests (tests and framework),
> > replacing the old list. Use the old list for framework changes
> > only. It would cause less churn to create a ML for just the
> > framework, but I prefer to use the shorter name for the list
> > which has much more practical use.  
> 
> I'm not a fan of this split.

Not a fan of the split or of reusing the existing list for core?

> The approach taken seems like it would create a lot of churn.
> You have 2 kinds of developers - a) developers of the framework
> and b) developers of the tests themselves.

Are you viewing the two groups "kernel-wide"? My subjective experience
is that tests for larger subsystems only get reviewed within their
subsystem. My mental model is not people who write tests vs people who
create framework. For networking a lot of people write tests when they
develop features and fixes, a small subset of those people also care
about the framework. But they/we do not care about non-networking tests.

So it's (a) people who write tests but also care about framework and
need cross-subsystem forum vs (b) people who just write tests within
their subsystem.

Slight sidebar but the concept of "framework developer" scares me.
I've seen "framework developers" in my corporate life too often
creating complex and unmaintainable software that has to be rewritten
from scratch every 2 years.. Maybe just my experience, but normal SW
engineers tend to produce better results.

>  Are you trying to shield
> framework developers from discussions about tests, or test developers
> from discussions about the framework?  It seems like framework developers
> would be interested in seeing discussions about tests, and vice-versa.

Not exactly. I can't think of a single case where netdev tests got
meaningful feedback from the kselftest ML. I'm probably forgetting
something but it's very very rare.

Every now and then we'd appreciate comments or a discussion with 
the broader community. I'm guessing current list doesn't serve this
purpose because the occasional framework change gets drowned out 
by a lot of pure tests getting posted.

I'd myself subscribe to a ML with framework changes and discussions.

> I'm not sure a new list is needed, but if the discussion needs to be split,
> I think it would be better to  create a new list for framework-only
> discussions, and leave the old list handling all (both framework and tests).
> 
> Like maybe have the new list be something like "linux-kselftest-core@vger.kernel.org"?

