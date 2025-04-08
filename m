Return-Path: <linux-kselftest+bounces-30379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172DA8154D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 21:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4443C3BA446
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623722D4D4;
	Tue,  8 Apr 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgzbA7j2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A51E8348;
	Tue,  8 Apr 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139000; cv=none; b=daCmE0sVdDX+eQmS6fsTLgTrP4Ip9q6WVVWpZlMuciXDDjhBpoXO1anZIdrkORTyhkX8stt6uM8nmzzc/jUGoq8tu81euHCyoxjyRhRVo7IG66jHWoacJ5MkEHei3aJlZa9J2Vcxb2J3zZ4sKe2a0yxOHsPAfxSBS+fXl7V+YIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139000; c=relaxed/simple;
	bh=EARKT6yocmAnZReK9tqnX7V8Nt3uW8Qi9d8HfF7ZBIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxyggzWqJ83UIZVSncoBpOGjQyZ/Ab8ASl3yzwuToa/UB0QPBJcp3Vs9Di0AB3vse05DX0MIyfXLdCJBt7DJr+6kioPQrqj8QvcyUcDY3UK0O0eps9OfWA4s3pIOTRnFEqaYJ7yG+HCO89H4dN7YQPeNe56144jMq8LxZ4Qx3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgzbA7j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DEAC4CEE5;
	Tue,  8 Apr 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138999;
	bh=EARKT6yocmAnZReK9tqnX7V8Nt3uW8Qi9d8HfF7ZBIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QgzbA7j2lLvOFPCnvGx0gUDpMilm+wUBS+wydoweKRrbUNyJND9JIA2BnY8WbOP4Q
	 gCschZ3zZWrxxq92rKWwHsb6Au5m28T1hvK1J+7YUPAem5ChwnK00OhB/2ARcpEYGY
	 5jBejeZJDT3hHEjrOz2R1qrlQLztAIqvhNv9U1wgRTN/KFJwXewLP595EXnXQZRikx
	 J9HNQu8gU82pzmzhEYIYf31wgv1BlKZQwzPxLhykp+1uwo0b991bQtU8C8irCcfRlu
	 46EM5E76hGYjp+y2kZfV338kCYp9DxwiKZmpRIM8JdEdwWe8bmNDi3UwuDP4SzSqQ5
	 7VioB9FTcWMDg==
Date: Tue, 8 Apr 2025 12:03:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 paulmck@kernel.org, joel@joelfernandes.org, steven.price@arm.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] configs/debug: run and debug PREEMPT
Message-ID: <20250408120318.65125876@kernel.org>
In-Reply-To: <df253016-81df-4cc9-8a8c-f92fd1cb8aea@kernel.org>
References: <20250402172305.1775226-1-sdf@fomichev.me>
	<df253016-81df-4cc9-8a8c-f92fd1cb8aea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 20:18:26 +0200 Matthieu Baerts wrote:
> On 02/04/2025 19:23, Stanislav Fomichev wrote:
> > Recent change [0] resulted in a "BUG: using __this_cpu_read() in
> > preemptible" splat [1]. PREEMPT kernels have additional requirements
> > on what can and can not run with/without preemption enabled.
> > Expose those constrains in the debug kernels.  
> 
> Good idea to suggest this to find more bugs!
> 
> I did some quick tests on my side with our CI, and the MPTCP selftests
> seem to take a bit more time, but without impacting the results.
> Hopefully, there will be no impact in slower/busy environments :)

What kind of slow down do you see? I think we get up to 50% more time
spent in the longer tests. Not sure how bad is too bad.. I'm leaning
towards applying this to net-next and we can see if people running
on linux-next complain?

Let me CC kselftests, patch in question:
https://lore.kernel.org/all/20250402172305.1775226-1-sdf@fomichev.me/

