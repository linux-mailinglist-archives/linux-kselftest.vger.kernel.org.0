Return-Path: <linux-kselftest+bounces-3635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03B83E2F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 20:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79045287205
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7968224CC;
	Fri, 26 Jan 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc/Htt40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93E241E5;
	Fri, 26 Jan 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298953; cv=none; b=X2jBt62nqL2GCPtEmDerMyai5LAGouhyZRn3f+IIJzMhDnSvUFDDEl0Ys3KMmkeF8XaWMHpsa/74h0PxeWPISCSVa+Mg/AgwUrsJZl5Wfb71aqEZmCXO/unb6/DAD0xArFgcH79eRYowB0VOa0gRx4zV1neaPOeizCvrh7g79V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298953; c=relaxed/simple;
	bh=WYU54tXCE/E8uLezCkBmXEQo+LCP1yBck4p57AJ0Nug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMCtNoJ5BDWqhKG+RA5Jzw3hE+1FRjqvfhzMVupTDNIe7PWne6LFVW91oxsdCS/JzRPHhzVspM1ce6Sv5IFcUeXOQu5d0f7bIdyqWN/Mpmmndq+EUJXm6IOKl+Tuzak+61KgF3R2pTU0+m0HO7Ce1ctdVVyInovUY4FtPfI9v74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc/Htt40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C32C433C7;
	Fri, 26 Jan 2024 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706298953;
	bh=WYU54tXCE/E8uLezCkBmXEQo+LCP1yBck4p57AJ0Nug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uc/Htt40d5WwgKbv+jbMRfUP85FOGtqEu9GqifPtfoS1QeWQ/L+X56t6Ro+EGobms
	 I27j9xlGEgpXr5eBVwfQgr1Ie5qG/sspu8DBIIM5fqSiqYGnk2J7P9TpmVOcNxxp8v
	 2VzDO0FX4q2drD7EKLUb55BiWT6byu/VwvvN4K/UDs72HIJxLCN+2P1z3iwlIPbRSS
	 pg14c21730MY7DrVOWj5afRVTeTosV7iSDZpf1ga2zU/zT7enkyRgt5AX6we5WAaX9
	 XlFOJtOHr4wqHPGT48/kLoLPOFb/Ig+f+7WUDZv5xilqXiyDcWr6Ngu0bno9zXRIJZ
	 8+46X5QdIpmvA==
Date: Fri, 26 Jan 2024 11:55:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>, Florian Westphal <fw@strlen.de>, Aaron Conole
 <aconole@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: add missing config for big tcp
 tests
Message-ID: <20240126115551.176e3888@kernel.org>
In-Reply-To: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
References: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 16:32:36 +0100 Paolo Abeni wrote:
> The big_tcp test-case requires a few kernel knobs currently
> not specified in the net selftests config, causing the
> following failure:
> 
>   # selftests: net: big_tcp.sh
>   # Error: Failed to load TC action module.
>   # We have an error talking to the kernel
> ...
>   # Testing for BIG TCP:
>   # CLI GSO | GW GRO | GW GSO | SER GRO
>   # ./big_tcp.sh: line 107: test: !=: unary operator expected
> ...
>   # on        on       on       on      : [FAIL_on_link1]
> 
> Add the missing configs
> 
> Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Ah, great, I was missing RF_RAW in the local hack.
I applied manually because looks like this change is on top of
something:

patching file tools/testing/selftests/net/config
Hunk #3 succeeded at 73 with fuzz 1 (offset -1 lines).
Hunk #4 succeeded at 82 (offset -1 lines).

While at it I reordered the values a little bit to be closer to what 
I think would get us closer to alphasort. Hope you don't mind.

