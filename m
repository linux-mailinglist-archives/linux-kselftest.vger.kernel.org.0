Return-Path: <linux-kselftest+bounces-44150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C7C11F0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C82F341EDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D32DA771;
	Mon, 27 Oct 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CccYhQBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF72E88BD;
	Mon, 27 Oct 2025 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606791; cv=none; b=kJ/OwiIWTg9Nf6/KMSD1ocWIcRKkZfvz+5dN2TEd4nk+2EPtknbsMirSMiWgfonMPIZ79LG1EOcQUPZzQA4M6HDLtI3d0LSd7BhsGiHivHgBYk0SjsnXBZ8LNKOtuvl31YqoB3Yv7RiFY9l5bYqscba8Lk8XpMgg6J3knP6h6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606791; c=relaxed/simple;
	bh=eQiGzLMt98XNx4v/lnpj++1SjVFZR5EtYynqO+z/lIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTHlMmqhMpP1k/fqvp4cq+VES1XwhJ3+YPotjSIm9lveYzyqm9UVo+mGmwe6rQI6/rKR4rR+sXrnjxYMD2amq2XogQlYvn7SFGHi5cbFmG+vnlrRltgdhhuOERjvXenVmzGFYh3mbgKsPy5HxkPBc8VmPq/G8aS7qOErEm0TW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CccYhQBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CE2C4CEF1;
	Mon, 27 Oct 2025 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761606790;
	bh=eQiGzLMt98XNx4v/lnpj++1SjVFZR5EtYynqO+z/lIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CccYhQBm65FdVVX64bQU9yCWSdqWHnCe2wXVw/eUCYEATBSpLp+2KemBMeanovKcM
	 Utg6qvYHHJ3xYCYKXno0zoTBFMFF957dcQHNo5zMjVAHHmWuPhOMV/jEQCmrSK50od
	 bLbSLkBavJuG8t7eCQoaykuKseyS7up/MHJrE1iz3OqirtSYjeYy/0HWFEosSbNZPB
	 P0bQxvVaxvEXvqSNSrxe/qn5+XB+7oo/eUsl8oH0/+UkLtdJSLWG2WthxgwtRedfLk
	 Kh+mtS3dZbnXNeCQ8aMDyjHDVd0DJc1IkDBJYVxIWbur/QfI5wr0AAhuQNzlxddxee
	 Y9Tpi1Ujc1oTg==
Date: Mon, 27 Oct 2025 16:13:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Wilfred Mallawa <wilfred.opensource@gmail.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <20251027161309.7fd96bae@kernel.org>
In-Reply-To: <aP9YMiW9V7Dkhu_1@krikkit>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
	<20251023184404.4dd617f0@kernel.org>
	<cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
	<20251024163336.5fba5cd1@kernel.org>
	<aP9YMiW9V7Dkhu_1@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 12:32:02 +0100 Sabrina Dubroca wrote:
> > But we haven't managed to avoid that completely:
> > 
> > +	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||  
> 
> We could, by taking a smaller minimum payload size than what the RFC
> says (anything that allows us to make progress, maybe 8B?). ie, I
> don't think we have to be as strict as rfc8449 (leave the userspace
> library in charge of rejecting bogus values during negotiation of this
> extension).
> 
> > I understand the motivation, the kernel code is indeed simpler.  
> 
> Also more consistent: the kernel syscalls work with record payload (at
> the send()/recv() level). The rest is hidden. Userspace could try an
> approximation by sending max_payload-sized chunks with MSG_EOR.
> 
> > Last night I read the RFC and then this patch, and it took me like
> > 10min to get all of it straight in my head.  
> 
> I don't find this stuff very clear either tbh, but maybe that's a
> problem in the RFC itself.
> 
> >  Maybe I was tried but
> > I feel like the user space developers will judge us harshly for 
> > the current uAPI.  
> 
> But userspace libraries have to do the same computations on their side
> if they want to implement this RFC. They have to figure out what the
> max payload size is as they're building the record, they can't just
> chop off a bit at the end after filling it.
> 
> Quick grepping through gnutls got me to this:
> https://gitlab.com/gnutls/gnutls/-/blob/eb3c9febfa9969792b8ac0ca56ee9fbd9b0bd7ee/lib/ext/record_size_limit.c#L104-106
> 
> So I have a slight preference for not being tied to a (kind of
> confusing) RFC.

Alright :)

