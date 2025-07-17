Return-Path: <linux-kselftest+bounces-37506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A7B08FBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F3E1C425CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282C2F7CFF;
	Thu, 17 Jul 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGJTrNUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215122BEC28;
	Thu, 17 Jul 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763364; cv=none; b=Y3/0KVeDxh8/+Mr+NGiia64T55mRtL9DfUetuPD9FvNconGdGNIx26qcQ4VtNQjMQOq4uNrGqoqVKd6Wuyz5MKH+uw8TuAlsh10z7kywBXxgKVVLuXa60J8ZiD9rc6sMvpn0BXefFeK3+NufeiyUhgB492eeBXPEaPjAvoGpsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763364; c=relaxed/simple;
	bh=26PgzRbEgkOwg5Xdk9wssF4RF1imGTHlSB4l1VKtd10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRSjVZBdS3muwlffYnsSD+dVuXWAU239ysyUW7yINCDtm2ELd0p6bP7NTry3wlEQf5xBWmpm5FL7be4o1JSRufUdL96/sWIzAfqLuSg7Wn4ZZ0mncDOhfyh9lFIJSZeglpxkeodDc4OF6uZ9NjoPYZttnzExB7f3Ui2zTOStJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGJTrNUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57055C4CEE3;
	Thu, 17 Jul 2025 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763364;
	bh=26PgzRbEgkOwg5Xdk9wssF4RF1imGTHlSB4l1VKtd10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGJTrNUKQS8J0ODj759/OrImkMqic2w5OQg2SOwDFQapO0P7ugFO5n37HV1GIrD3j
	 flwQncGtC1qTM9CaZHvPCCs/E/JRQ51zshwalLpUNbx+P2Vy5cIGR1LN/5XW2f1NIX
	 4EX44MSX9KE+vhAltlr/UIt8OdPruFwdCXfGWZBjHxVPtFkLp+nzxxF/BaVvDijlMF
	 C687BQClWY0JqXXHssLBEFRf0r4letbV15MjGTYMyIQud2o8zTO0kZXhdjN0Z0+IvH
	 5KDvBnBobivQtLzMfR6yBeHK7PeaBWRX6iPzWY2E4pbcSHt4spg421hY9DhU8X9PxM
	 xePUoZsR6Noag==
Date: Thu, 17 Jul 2025 07:42:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Christoph Paasch
 <cpaasch@openai.com>, Davide Caratti <dcaratti@redhat.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Message-ID: <20250717074242.1ef5d441@kernel.org>
In-Reply-To: <e46aadbf-51c6-4e09-bdaa-374698b406f3@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
	<20250715185308.2ad30691@kernel.org>
	<20250716072602.386a8963@kernel.org>
	<ae6d333a-f3b2-4463-b930-b4caf56b39f8@kernel.org>
	<20250716083632.72854bd5@kernel.org>
	<e46aadbf-51c6-4e09-bdaa-374698b406f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 18:35:11 +0200 Matthieu Baerts wrote:
> >> And just to be sure, no CPU or IO overload at that moment? I didn't see
> >> such errors reported by our CI, but I can try to reproduce them locally
> >> in different conditions.  
> > 
> > None that I can see. The test run ~10min after all the builds completed,
> > and we wait now for the CPU load to die down and writeback to finish
> > before we kick off VMs. The VMs for various tests are running at that
> > point, the CPU util averaged across cores is 66%.  
> 
> Thank you for having checked, and for the explanations!
> 
> OK, so maybe running stress-ng in parallel to be able to reproduce the
> issue might not help. We will investigate.

connect tests failed again overnight. Now I see why Paolo was
responding on Eric's series, that seems like a more likely culprit..

