Return-Path: <linux-kselftest+bounces-33911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564CAC5F23
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 04:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD4A7AE526
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D983D544;
	Wed, 28 May 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi/oVwOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304F382;
	Wed, 28 May 2025 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398559; cv=none; b=BmTIdyg7NCBFKwXPvt+xnULXSW+Z5UM94VUGdx6xyw3fDNM7aWaf2uxPnJXDgAYlG7h412MhYuqhaCp+k+2sB0cDpvou2dKHK3MeteDKVGcStHgY+YF1vVooQMag5Ucl6JL341zZtGfiBAzYJctjZWdsXlYq/M6vPB+3ZPPpQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398559; c=relaxed/simple;
	bh=oxYH+gkFPjL0vF9T4oxhzs3SiBbk2xtkclWFIPJ7sR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+qUH/mX/bivtzbsIMIxbTU6wB3efTNlpoqe0ACv82ScoNpm4AWw70BYlTp+N/fUvqFGFQvVl6ik0xDj1rSUOJ/lYLf4yfVY9dDGB/UN49vxR6fNBA24r3cvESNifaEJKFOd3Evy0nNS1MjO4tUkBXTuJ9iI5oLMDY7NJWr7Juo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi/oVwOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4047BC4CEED;
	Wed, 28 May 2025 02:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748398558;
	bh=oxYH+gkFPjL0vF9T4oxhzs3SiBbk2xtkclWFIPJ7sR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qi/oVwOvn6DbS2f4MxjxHwwoVq/k6Yvcy8mF5c79UaAwN1MihGzjTMYgwRmHoQo8v
	 hGsCYrnu/eSqCnp7zjk+dSHK6IkU/9OpKt97WAgag7Tu+jI7eS540pgsEh+7elWmSt
	 DdfRmH6/9uLksw2qINyZ0rRyPiNispW69f1aghQWYFHQeBWFvkpu3T1gM3fNC2QwgE
	 sccOVvKXk4MOx7gXol8V6R7yvE0QpwdFY3Pbp1jIvqkS1KWf2MOpUvz4Js7yOh/XQa
	 K+Wb7itl49X2ZMxJ+jlu/jVj/LA7uTPCDnBZYErZQXylz5QCHscDCR6iJCGsLSCkbC
	 B49RU57ac5JFQ==
Date: Tue, 27 May 2025 19:15:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: horms@kernel.org, donald.hunter@gmail.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v17 net-next 0/5] DUALPI2 patch
Message-ID: <20250527191556.50958768@kernel.org>
In-Reply-To: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 19:19:19 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
>   Please find the DualPI2 patch v17.
> 
>   This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
> * Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues
> 
> For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.

Please repost when net-next reopens after June 9th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

