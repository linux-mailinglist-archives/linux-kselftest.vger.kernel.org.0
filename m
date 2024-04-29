Return-Path: <linux-kselftest+bounces-9055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B138B5EEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555E01C20F9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025284A58;
	Mon, 29 Apr 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1Z91D0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB4824AA;
	Mon, 29 Apr 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407932; cv=none; b=dU/xWyJWZggrJT5I8kLJHsTgNVVLUGNfi1Sw+sfipZUuiYnjqj0hXfMJvwJj0hb8T0GlMPI+Upul83Z5rF0solBBd1+sz01bIkvJhutQjZFQ75XgAMpvsHo6H3vVAoNpoNSRIQ36Ef94WxU9cbynRkd6gJwBgSGLUQivoF1ETFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407932; c=relaxed/simple;
	bh=hSRHVXUzOZxJuDsJ1gXUwOKbr/hMUv6DDcfdIIwM8sA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvL9oNHNUo4ouzCowQ/lYZY15RkaM/OPqs7mrTQxOUSOcgqHKIiY6k+3tjPI31M3H53Dy5LOpvhUT/3kydoW/SyFv8d0C5JYBA61cZW6LlTcYvtBGZ+IqZTq+EB5x36aHfcEEDgFAyhFPHqGX+X3GVDdCyZQn70pOxHDvwbOYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1Z91D0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F40BC113CD;
	Mon, 29 Apr 2024 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714407930;
	bh=hSRHVXUzOZxJuDsJ1gXUwOKbr/hMUv6DDcfdIIwM8sA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B1Z91D0t/60LSaS3V52CClHO2WSnjOOiviB8zF/hBqwbrNsX8i8gOZyXHq4Fxdw5K
	 f9cmIW9BDM3V8OXMJUWEI9T7JNI1me49nNqbzF8/ftimhkDxpGHQKp93lM7jZnM1Y3
	 rQMdSCPVFZrimYLIz5PbnLjnk6mcIlYlJV7+c2CrNahfWJbeb7XhmHEpo1GdqAheB8
	 suEjJVWkU/8GPAEpgr1tWigSMclYnFIMX3ozRtM4iF/S6YPjXhk6cwLpVAwJO49oVB
	 +5srEDJsJRcByNbvk333YqZ1sbatWHf0+g/vqTA6pS+PRVRCUfnVZztnvb5iTjm5qd
	 6xVBCWyvDppow==
Date: Mon, 29 Apr 2024 09:25:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 0/6] selftests: net: page_poll allocation error
 injection
Message-ID: <20240429092529.649e7de0@kernel.org>
In-Reply-To: <f59287a5-99ba-4f37-8019-b176f0307ec3@lunn.ch>
References: <20240426232400.624864-1-kuba@kernel.org>
	<f59287a5-99ba-4f37-8019-b176f0307ec3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 17:01:55 +0200 Andrew Lunn wrote:
> > I'm not super happy with the traffic generation using iperf3,
> > my initial approach was to use mausezahn. But it turned out to be
> > 5x slower in terms of PPS. Hopefully this is good enough for now.  
> 
> How important is PPS? In order to get 'Maintained' status, automotive
> vendors are going to want to test their 10Mbps T1 links.

s/Maintained/Supported/ ?

PPS isn't important in itself, that said, I wanted to set a floor to
make sure that the failure path is actually well exercised. 
Some drivers may be doing internal recycling or whatever other magic,
which would make them barely call the page_pool alloc.

Even though this is not a performance tests the check is based on
expected perf. My thinking is that once we have some data points about
various system we can abstract the perf expectations a bit more
systematically than if speed < 10GE: pps //= 10

