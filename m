Return-Path: <linux-kselftest+bounces-30440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F77A82BC2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B47F1B64EA0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF0268FDE;
	Wed,  9 Apr 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns4iX0OS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583A1A3159;
	Wed,  9 Apr 2025 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214138; cv=none; b=Sm1z2vFpJGqio5tWWxW8W77NMYM7byHaUeZG+DXa9Fyv3yIHabVR8kW6uAhsr9OkSbQK5jpUNobBINdeNmL5/+b6Jv0bLx5UQivHDlkZjo2o/XtH/kALKuS2cz2KQ64lp7EX6MAqVz9cpFvzplLwzxwPCu7zwPtUl3DgIVMyO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214138; c=relaxed/simple;
	bh=WW1N/1DaqI87EqtkhE04HgTwYLpLakjaAuM2yUvrwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFObxeila99h3ZLMo015v86JYi5zIak9RjYJ02LBNhl/V13QVaLwWF8hbYT7qh91e1E5NDYcdTf1KDuHd4NCNG79zWNjam3jCKJImsPEUZGgKU+O2bSyxRqoliPb186NM8eUcKjndmidOC0jOdCcwidYk3NIz8e1pdiFQCjo5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns4iX0OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B56C4CEE2;
	Wed,  9 Apr 2025 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744214137;
	bh=WW1N/1DaqI87EqtkhE04HgTwYLpLakjaAuM2yUvrwPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ns4iX0OSppovqb9VC+Y4d9RlZ0wyE9soo85cb4ockpsqwokaEmE19h84RHZyd41Uz
	 5tV4jYnThZWoz81jB7iCYeWD0XYeWQik7OkaqxWP33hB6sqcWCGnfzt3Yv4IsH9RVH
	 GUe8v5kBk8sTYGRs+iO3dmu76UBh2BNo7KeojQBuxc8vhOQpXcVYc7rC4kl2DZ6/eg
	 yLMyVYpogA4NqufayXttjfNnv37npJ5l1EH8LOR7RH+57fSFqrWCje7uGTSruP3JSI
	 r9EcV652v3SpsQd1yAuy5enjLTC8lXIhIY+YM33uuhP1lXdR5Em06IlOuF3t2AY9BW
	 rFKW0bm9oav/g==
Date: Wed, 9 Apr 2025 08:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 paulmck@kernel.org, joel@joelfernandes.org, steven.price@arm.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] configs/debug: run and debug PREEMPT
Message-ID: <20250409085536.245acdf1@kernel.org>
In-Reply-To: <3f5ff26b-9904-462e-ac22-84b5d212e9ff@kernel.org>
References: <20250402172305.1775226-1-sdf@fomichev.me>
	<df253016-81df-4cc9-8a8c-f92fd1cb8aea@kernel.org>
	<20250408120318.65125876@kernel.org>
	<3f5ff26b-9904-462e-ac22-84b5d212e9ff@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 13:58:13 +0200 Matthieu Baerts wrote:
> On 08/04/2025 21:03, Jakub Kicinski wrote:
> > On Tue, 8 Apr 2025 20:18:26 +0200 Matthieu Baerts wrote:  
> >> On 02/04/2025 19:23, Stanislav Fomichev wrote:  
> >>> Recent change [0] resulted in a "BUG: using __this_cpu_read() in
> >>> preemptible" splat [1]. PREEMPT kernels have additional requirements
> >>> on what can and can not run with/without preemption enabled.
> >>> Expose those constrains in the debug kernels.    
> >>
> >> Good idea to suggest this to find more bugs!
> >>
> >> I did some quick tests on my side with our CI, and the MPTCP selftests
> >> seem to take a bit more time, but without impacting the results.
> >> Hopefully, there will be no impact in slower/busy environments :)  
> > 
> > What kind of slow down do you see? I think we get up to 50% more time
> > spent in the longer tests.  
> 
> That's difficult to measure in our CI because we have a majority of
> tests either creating test envs with random parameters (latency, losses,
> etc.), or waiting for a transfer at a limited speed to finish. Plus, we
> don't control the host running our tests. But if we omit that, our
> packetdrill tests take ~20% longer on the CI, and our 2 mini KUnit tests
> took ~10% longer (275ms -> 305ms). Globally, our test suite took maybe
> ~10-20% longer, and that's acceptable.
> 
> So not 50%. Is this difference acceptable for NIPA? Even when some tests
> are restarted automatically in case of instabilities?

We also see 10%+ on most cases, the 50% was the worst one I glanced.
The worst offenders in terms of runtime only increased by 10% so still
within the guidelines.

> One last thing, Stanislav's patch has been shared during Linus' merge
> window: perhaps something else could also impact the time?
> 
> > Not sure how bad is too bad..  
> 
> Did you observe more instabilities? Maybe the individual results should
> be omitted, and only debug specific issues (calltraces, kmemleak, etc.)
> should be looked at?

A couple but unclear at this stage whether that was just the merge
window or enabling preempt debug. Now patchwork is super unstable
so again, hard to judge the source of the problems :(

> > I'm leaning
> > towards applying this to net-next and we can see if people running
> > on linux-next complain?  
> 
> Good idea! But I do wonder how run **and monitor** the selftests in
> linux-next with a debug kernel :)

One way to find out :)

