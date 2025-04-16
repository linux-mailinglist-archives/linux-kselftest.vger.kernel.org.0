Return-Path: <linux-kselftest+bounces-30984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70556A90E8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E541B3B684C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164922A80E;
	Wed, 16 Apr 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSLP5NHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8F2135AC;
	Wed, 16 Apr 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841953; cv=none; b=l8kEclvJxapFVGjD5Pceph6cBJvaQvYgHJBvN0i8loqnL9b+tcZA8WMLi32oSX0hUvkbD9fwYz0+dgPcYtrkch2+US/WRQ4oII8FmNeAAz6WjiIKJfW8sF/Px9DxkrbZ9efG2HEBqB/akwjB6RGG02vA76g2u7vM8FC8VozzuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841953; c=relaxed/simple;
	bh=JxjGlO8io3o7nQA//oy7HKFVNPtQVrdR0OgOA+KwBco=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKVlSpJL7WK3SRQZsBcQvBfvNU4eZ6ulrC//BsVmH+WL7LKlbf/ijiH6diDhzX9X/NXv/5A5DtDDGE2sWrK7tRyQ+AkTvsoWU/vC5+ga2waDKTRtb+bnzgaDavHVoXEIccorGwPOWnKRXiaKcC+asQkU23ImE2rgYWnKYWuqdhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSLP5NHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA17C4CEE2;
	Wed, 16 Apr 2025 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744841952;
	bh=JxjGlO8io3o7nQA//oy7HKFVNPtQVrdR0OgOA+KwBco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSLP5NHu5iw2+GoSncRSbxr2XcbnTPvdJvucfjQ6Uz0ET4qWnFk5zNzRF4NiJn35P
	 V0r2lEtDQh6wNpCeby0GWl8ExkitEoSeSS8IiDn7WZR1RupyWeF1sde83R4ApwEpT+
	 I7EkZgsDp01MJvIxSebEUKDXYU7YkxTkdIXUA0g8XibvkIN89DCdLLyGQT8bxE+VSX
	 NfvHmGHTRWUqEEWRLM3HhvAWRrR5oCJf8t2lGpE8ANEk2T3rvo1bPX2ukbQcug3zgO
	 euRhWt9dMwpIlk1Ynzya5dqbGQ0zUUqD7APhN6BpRp5/ya2KOJCNzYr65EzQ2foXGY
	 gFiMtOy+uX0QQ==
Date: Wed, 16 Apr 2025 15:19:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests
 for qdisc DualPI2
Message-ID: <20250416151910.6eaaf506@kernel.org>
In-Reply-To: <8272f999-fe55-4afb-894a-57a7cc161473@mojatatu.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
	<20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
	<20250416065223.4e4c4379@kernel.org>
	<8272f999-fe55-4afb-894a-57a7cc161473@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 11:00:35 -0300 Victor Nogueira wrote:
> On 4/16/25 10:52, Jakub Kicinski wrote:
> > On Tue, 15 Apr 2025 14:43:14 +0200 chia-yu.chang@nokia-bell-labs.com
> > wrote:  
> >> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >>
> >> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> >> and add folloiwng self-test cases for DualPI2:
> >>
> >>    Test a4c7: Create DualPI2 with default setting
> >>    Test 2130: Create DualPI2 with typical_rtt and max_rtt
> >>    Test 90c1: Create DualPI2 with max_rtt
> >>    Test 7b3c: Create DualPI2 with any_ect option
> >>    Test 49a3: Create DualPI2 with overflow option
> >>    Test d0a1: Create DualPI2 with drop_enqueue option
> >>    Test f051: Create DualPI2 with no_split_gso option  
> > 
> > it appears applying this causes the tdc test runner to break,
> > could you take a look?
> > 
> > https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/79725/1-tdc-sh/stdout  
> 
> It seems like the breakage happens because the iproute2 patch
> is not in yet. I applied the iproute2 patch locally and the
> tests succeeded. The next iteration should run with it applied
> so the breakage should stop.

Thank you! returned the patches to the queue, 
the net-next-2025-04-17--00-00 branch should have them again.


