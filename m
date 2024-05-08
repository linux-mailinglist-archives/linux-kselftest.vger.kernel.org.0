Return-Path: <linux-kselftest+bounces-9712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117F8C00E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9990A1C217B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEF1127E0E;
	Wed,  8 May 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaOq8vT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE08127B68;
	Wed,  8 May 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181935; cv=none; b=sl5540E9vxXYqmPaSROmg1D62JQV5ydixl/i+O3NermhtdB0sfsgttwCNmdZ5dGLjtNStIUvR1gXebNUvehBcC2iFR37jTuSWzF5KIqqDr8RjWp5w5eL5031uiM0HZ7QhXDlDMv++wQ6cePrtPDer0uv4eYZVyf2kPFYBZ/DOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181935; c=relaxed/simple;
	bh=v+LCBawZUinlZ/kH4yoHavtuY3E/hIPj7ZijTmY1JXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2sJKWW/lK78qF8mD6Qw/smLiqVTfCqG5fVuxHkm0W+l2ciruAL2vQuFyp10E3Iu2KEszLWy7ph5a+OO2Spj2Y2QlDdpXhu5q6Q/o+30D7r7NjIEykCWWG/MFJPnvQiiSg1UbwxGuiLIaltyLNndXWrDh/5jy/J8kwbsvAIJcow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaOq8vT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7703C113CC;
	Wed,  8 May 2024 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181935;
	bh=v+LCBawZUinlZ/kH4yoHavtuY3E/hIPj7ZijTmY1JXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oaOq8vT8Mf1zifKh4rJMDX7eO4brejCkk3w/sN9cphWeDS7Dcdj5ACO+sBEntms8V
	 Svm3sFFhm1mxlbV8cn5nqmWCm6AqR6AQ4m2H7GyZ4u5HdzKDtSMyy2dHvB91245RDR
	 iWvdFHieCkNyT29GOiNZMmrWGYN6+/BPqSXJKzBEx8TZfdEXbUrpQLXo4WhZSZwBLD
	 G2ZzYnZKZbHCzRx0l27d7HALcrz+43p2FxgJ8jo+bt2UTtXLNLf2K9xXUk0hWc2qci
	 r9zBPGjNwycVLsHgtcGqBsr5NuW5cE0YqpdfbnYdn8Q9mA7DuGipT6jgufaTsNcyzy
	 D5nF0L+FBAm1Q==
Date: Wed, 8 May 2024 08:25:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v3] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <20240508082533.37a49678@kernel.org>
In-Reply-To: <ZjrhvnpRIhPI3mal@LQ3V64L9R2>
References: <20240508004328.33970-1-jdamato@fastly.com>
	<ZjrhvnpRIhPI3mal@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 19:21:50 -0700 Joe Damato wrote:
> On Wed, May 08, 2024 at 12:43:26AM +0000, Joe Damato wrote:
> > Add a simple test for the epoll busy poll ioctls, using the kernel
> > selftest harness.
> > 
> > This test ensures that the ioctls have the expected return codes and
> > that the kernel properly gets and sets epoll busy poll parameters.
> > 
> > The test can be expanded in the future to do real busy polling (provided
> > another machine to act as the client is available).  
> 
> Ah, built and worked for me, but of course fails remotely:
> 
> epoll_busy_poll.c:20:10: fatal error: sys/capability.h: No such file or directory
>    20 | #include <sys/capability.h>
>       |          ^~~~~~~~~~~~~~~~~~
> 
> Looks like selftests/bpf/cap_helpers.c avoids a similar-ish issue? Not sure if
> there's a better way or if I should do something like that?
> 
> I assume it is not possible to add deps like libcap-dev to the test harness somehow?

Ah sorry, CI builder was missing the libcap-devel package.
I can't retrigger the CI easily, unfortunately, could you repost?
(without the 24h wait)

