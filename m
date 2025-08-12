Return-Path: <linux-kselftest+bounces-38776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ADB22878
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C087B081B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07483280A2C;
	Tue, 12 Aug 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qewqHBMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA627F003;
	Tue, 12 Aug 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005307; cv=none; b=tlLYCxArBG3FUbYZVv9wtyKTmnoA818Q1KG9geE6aLZtMEWteWVlIaAxsqx2oM0855vac2mB4ccAKt0b+WU7HrQoxIAVONRZEkTSoFViaVzqPiRpsh/VHBL9pVnFCI2jHo32dkE6xdprOQVMKeJiZpH2bLyACTjWyl4afHE+xaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005307; c=relaxed/simple;
	bh=zJNW1KKRSi0nQtsJy7+cTejpGxgeC51nbgUM4FI7LWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6FuClfdR/gjtQYfnknjxXE41eLi06V6o+xmpiJk1aCSFRKHYFMTn9prMmY0dLFfVupMiEonFdGZfSvd9bwO71WOF07a0R4T8JTLk8CNqizddNAYjS5Y0OrNvqbXw7m0vvKCoxhocFfTyQWH0O7w/vpJrAy6MwC1uP6dP7Wwddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qewqHBMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7182C4CEF5;
	Tue, 12 Aug 2025 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005307;
	bh=zJNW1KKRSi0nQtsJy7+cTejpGxgeC51nbgUM4FI7LWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qewqHBMRaY6UuO709TIpXRaKplhk8xJtLKAn8Rm6EwbPrxJYYKaDidqATf5S+3GtT
	 7gaNpSP+srFQkWvhz8vSTTU6GKRvOQ59Gq50R9rys2AwO2o98Aa4tuhpo6Ojuf0JNi
	 zEH8UdzkqhJ/QlHbjXhzf/AmBcvGKU2vEXY408v6v+RjE7ox7VVg7be/uSI3VzUuPI
	 vMHdYeF3/Asc2HXbISTJxJc1UwUzquBV4XpY4BmLDRRvqvg9UWOQ3RkP0w9rz3uhCR
	 yV9fV7XJu99CPa/z8qlpyiAg6k1cxG/fgVayz64UcKEQvoQiKtgQPvOKwSx22szvS1
	 T1Y1Z/JdX9hDw==
Date: Tue, 12 Aug 2025 06:28:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, will@willsroot.io,
 savy@syst3mfailure.io
Subject: Re: [PATCH net v2 1/2] tls: handle data disappearing from under the
 TLS ULP
Message-ID: <20250812062825.391c030c@kernel.org>
In-Reply-To: <b3a83032-8ed4-4d5d-9df9-6dbd02acac1c@redhat.com>
References: <20250807232907.600366-1-kuba@kernel.org>
	<b3a83032-8ed4-4d5d-9df9-6dbd02acac1c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 12:45:56 +0200 Paolo Abeni wrote:
> On 8/8/25 1:29 AM, Jakub Kicinski wrote:
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 549d1ea01a72..51c98a007dda 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -1384,7 +1384,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
> >  			return sock_intr_errno(timeo);
> >  	}
> >  
> > -	tls_strp_msg_load(&ctx->strp, released);
> > +	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
> > +		return tls_rx_rec_wait(sk, psock, nonblock, false);  
> 
> I'm probably missing something relevant, but I don't see anything
> preventing the above recursion from going very deep and cause stack
> overflow.
> 
> Perhaps something alike:
> 
> 		released = false;
> 		goto <function start>
> 
> would be safer?

It's a tail call to the same function, the compiler should do that for
us automatically. Can we not trust the compiler to be sensible? Both
clang and gcc get it right.

