Return-Path: <linux-kselftest+bounces-38685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EB3B21111
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B253718A24EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCF61A9F8C;
	Mon, 11 Aug 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOUCdw7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838E1A9F82;
	Mon, 11 Aug 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927579; cv=none; b=F+cAnkP+fitdEjzCxjZ7wegfNLXsFCXHU2myPjLlV6cQ24P3gqnZx37sDEzawiYygjzXEe8COhI+BJYr/M2L+qvZ/KRLDi4iszVy9ntkZI82wbTIutLTjbZzv1ZQghwFubI2sbezao2sR2Pld21AgFcdc3ivgaKFxPQnAqmMmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927579; c=relaxed/simple;
	bh=rMAHxsfqve86pCW8MJDJEH5uaWy14+2/Iq+hyWRBEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIB654bZXKDTBATPaGA8/v0OxE59FhsfiQB/wvpXUumuaiZUOKHMxDdFE08piBTnlMgZkKQSBxwpHDJZgqxorOyQ9y687wp3K7yiGNhN2IDjO3/rpFkFBPY6k9opT5zb8+t8ebJ7syjy4I6tSB67s1Bo+jZaDnmmEuWxlZMMRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOUCdw7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5690C4CEED;
	Mon, 11 Aug 2025 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927579;
	bh=rMAHxsfqve86pCW8MJDJEH5uaWy14+2/Iq+hyWRBEUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OOUCdw7LbqNkf7g5Y1hq0i0sPm09zLZ2pYuVG0L4uBDskjAf17FRBJLkI/Y9t5lUd
	 EKqeYDEwsDHKCZ2Hic9gmj+qbeuvpfDtW9dsvMqrpYiF5a5wDBWoB2q78lqDZmJ79K
	 3FZNyxD29rJ3cplNz3W8hoxmpgR5fXQzAcxtEIVjyvgU8zevPqL4ciBtyjfWWo16yl
	 pZ5HeOf15EpYlnCcZQaP5fWCuDBvnMcXe8TA/rSh3njcUbjRreMRBRyzvNiLaCZkZ6
	 rp9TvDB/UQn515sdg4gBCnUdw/3QHtoDx7S1WuV0dbja7rvHMVBkKMeBfHfAFn0YA9
	 SKpA6+QgUamuw==
Date: Mon, 11 Aug 2025 08:52:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, skhawaja@google.com, sdf@fomichev.me,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] net: prevent deadlocks and mis-configuration
 with per-NAPI threaded config
Message-ID: <20250811085258.4b6cfa79@kernel.org>
In-Reply-To: <aJf8_ypOuSrsQnIM@MacBook-Air.local>
References: <20250809001205.1147153-1-kuba@kernel.org>
	<aJf8_ypOuSrsQnIM@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Aug 2025 18:59:27 -0700 Joe Damato wrote:
> On Fri, Aug 08, 2025 at 05:12:02PM -0700, Jakub Kicinski wrote:
> > Running the test added with a recent fix on a driver with persistent
> > NAPI config leads to a deadlock. The deadlock is fixed by patch 3,
> > patch 2 is I think a more fundamental problem with the way we
> > implemented the config.
> > 
> > I hope the fix makes sense, my own thinking is definitely colored
> > by my preference (IOW how the per-queue config RFC was implemented).  
> 
> Maybe it's too late now, but I am open to revisiting how the whole per-queue
> NAPI config works after a conversation we had a couple months ago (IIRC ?).
> 
> I think you had proposed something that made sense to me at the time (although
> I can't recall what that was or what thread that was in).

FWIW the discussion was whether setting things at the device level
should override all the per-NAPI settings, or should we treat the
device level as lower priority and only apply it if user didn't set
per-NAPI override.

I guess it doesn't make a huge difference, other than that resetting 
the unused NAPIs to "unset" would remove the need for patch 2.

