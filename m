Return-Path: <linux-kselftest+bounces-20864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9A9B3E0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31177282E22
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C61EE012;
	Mon, 28 Oct 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7BBxUbC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424B18C02D;
	Mon, 28 Oct 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155996; cv=none; b=IB2TderYuoHrZnFarcsifN+FFfeW0wXhxJk+xUWnfTtKgvjBZ2RGB2qKxVE2XfK25X3xDLRmUEfMgWAojfvHNIKdAp1nFmYAckD9Eoxboww2rHOQ14PQfoFIDT0hx5YuTNQWcgG+bJntv/8ZHQbdv2q7li7ZTdnogTn0pBkk4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155996; c=relaxed/simple;
	bh=HSm7l+dIvXw5CpFH9RjYr70BRYS7SglQogW4EmAuIbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjTgjWwbyWXYsMetmJ+rlMNgEmw7j2b/qb9WqWzbh/fCqSwh5ZLe6YK9gQGtKfOjej951tGO2T/T2ZsP3CAdbzM6QL+luTPb7QriAdW8SKv4BNpjSEbspydfPEuBHGQgRzLPHStowpTwaJ7PFa7eh/AFI4RzhYxSPTSpQ9zPLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7BBxUbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19080C4CECD;
	Mon, 28 Oct 2024 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730155995;
	bh=HSm7l+dIvXw5CpFH9RjYr70BRYS7SglQogW4EmAuIbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7BBxUbCUrpS1iA89avK18t+SK0ADv78ODLgmI54adILN5wvAAJVYJybo+/S0hL2f
	 RZsX9vVZN2k1yUROABIxWJkyZvyjSw/3FKX3Szs4lwGgdlSdopCs/198Sv1kDxiLnp
	 +UHpZk8GJMUbhcsk7z2latVFM/yF6i0bS0SFMMkLxVY9lMwdhx9BtuveqECxhc3jJ3
	 I2lr9iTGr4PpHojDmiwszyLUo1XigcWGUeuwUNN4kGZABsguU+bSMck91rBaNuKbYU
	 fRI+h1qqMRKi2+DndcTcELVb8Pi7bPMaClCB7ALR1nW9X/JbbnoG61FP7/T2PU0EKn
	 eEsV/9WhutF/A==
Date: Mon, 28 Oct 2024 15:53:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Simon Horman <horms@kernel.org>, mptcp@lists.linux.dev, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Gregory Detal <gregory.detal@gmail.com>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] mptcp: remove unneeded lock when listing scheds
Message-ID: <20241028155314.006f9063@kernel.org>
In-Reply-To: <4ca239db-6a05-4735-916c-73cee0ee22a0@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
	<20241021-net-mptcp-sched-lock-v1-2-637759cf061c@kernel.org>
	<20241023122128.GT402847@kernel.org>
	<4ca239db-6a05-4735-916c-73cee0ee22a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 16:13:36 +0200 Matthieu Baerts wrote:
> On 23/10/2024 14:21, Simon Horman wrote:
> > On Mon, Oct 21, 2024 at 12:25:27PM +0200, Matthieu Baerts (NGI0) wrote:  
> >> mptcp_get_available_schedulers() needs to iterate over the schedulers'
> >> list only to read the names: it doesn't modify anything there.
> >>
> >> In this case, it is enough to hold the RCU read lock, no need to combine
> >> this with the associated spin lock.
> >>
> >> Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> >> Reviewed-by: Geliang Tang <geliang@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>  
> > 
> > I do wonder if it would be more appropriate to route this via net-next
> > (without a fixes tag) rather than via net. But either way this looks good
> > to me.  
> Good point. On one hand, I marked it as a fix, because when working on
> the patch 1/3, we noticed these spin_(un)lock() were not supposed to be
> there in the first place. On the other hand, even it's fixing a small
> performance issue, it is not fixing a regression.
> 
> I think it is easier to route this via -net, but I'm fine if it is
> applied in net-next.

I agree with Simon's initial response. Let's not blur the lines.
Please re-queue for net-next, I'll apply the rest.

BTW thanks a lot for proactively fixing the CONFIG_PROVE_RCU_LIST
splats!

