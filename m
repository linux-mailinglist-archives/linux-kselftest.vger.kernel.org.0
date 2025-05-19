Return-Path: <linux-kselftest+bounces-33356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DFEABCBB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 01:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8578C25CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 23:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912D1FDE14;
	Mon, 19 May 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfTUfceC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9F4B1E5E;
	Mon, 19 May 2025 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698528; cv=none; b=Fg3OORQcQoj4ppo0pmC+QFG9UAulEV0hL5eJ+FGeQjXXCvNxwHY50NxYyk76Y/8oLJE5IXgC5PVRIFQOrTYeiH5ZNJBmYJEbUOzqR5RHJHoubgrfxFLcCFxgclshD0Yj3iNSireYC3dSYOOmdOhTgph2SqaTMGbzfsyIFxXX2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698528; c=relaxed/simple;
	bh=KY1eMq/GYCaPfzTkzeeKII/x7ctTj9mKeTjTe1ksYQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDqTlc2CdnSOVVBZEEK2iH1oU6cyeR6FrQo5k+I7Jdsre1YRgWmLvnP/ceiDPQz5oehVEcPZ2yUoCJQ5cc7UiodnzhjOcYyftLnKfhwLDPUAWp88buUqkfCx1In8rBh8A4vBzddjCQzS4HnBWdxJclrcWukBBGKU3TFN1E+yYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfTUfceC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3110DC4CEED;
	Mon, 19 May 2025 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747698527;
	bh=KY1eMq/GYCaPfzTkzeeKII/x7ctTj9mKeTjTe1ksYQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JfTUfceCoa6lkj7bKXecnZoPZPki2zZjT0xTf1jakn8U9GrVa0efdOwsbV1YblNdL
	 +/hQYHBNtG8Eel3jwrPlnDZBhIVlatLBuxGMoEJu9jYPjm8Xb/hPdojjLo4VtINz8j
	 hJ3vFKFxQwnrvQIhTEsaImnzW5voGbmZjPPkaZAh3ev8lgLbj9u77cabFlgncuM1d3
	 E0fekisSWd1Iv9F8QdGd8EfXxdiZnLPLCtMiMw7S2wtajmeQ8vEq1T37wrgASJkoRb
	 yIgldeav/X7arKnYC73NjPGoBz2ritOrQiO54ljTzTo2ZpyxpBD9ARxshS2RM7KIYH
	 QXQ/yLQwbZHSw==
Date: Mon, 19 May 2025 16:48:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern
 <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
 shivajikant@google.com
Subject: Re: [PATCH net-next v1 5/9] net: devmem: ksft: add ipv4 support
Message-ID: <20250519164846.40cd01e4@kernel.org>
In-Reply-To: <20250519023517.4062941-6-almasrymina@google.com>
References: <20250519023517.4062941-1-almasrymina@google.com>
	<20250519023517.4062941-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 02:35:13 +0000 Mina Almasry wrote:
> +    addr = cfg.addr_v[ipver]
> +    if ipver == "6":
> +        addr = "[" + addr + "]"

You want baddr ?

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/testing/selftests/drivers/net/lib/py/env.py#n155

In general you should use cfg.addr, cfg.addr_remote and self.addr_ipver 
if you don't care about what IP version env provides.

If you want to test specifically v4 or v6 they should be separate test
cases (doesn't sound like that's your intention here tho)

