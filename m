Return-Path: <linux-kselftest+bounces-48762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE789D13B18
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 427AD30F630D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6232E7F1C;
	Mon, 12 Jan 2026 15:16:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8A2E093A
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231019; cv=none; b=FiXljd8dQ6RYEt8ih4PT/OrCz1wKSxMDP3S34LcAhVqYPflENG5Wmb7XXWqSqNKWg+9eVYiR4irVMAhCV53GEw5UgXGBrlQzD2q1m4kJCtT0X+oTwqDs6x0gjO+748NsYJKXL1d+49hTGWsAnxjBC7FLY8+wXlNV8YIwTyFFoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231019; c=relaxed/simple;
	bh=EShopnW71/xFcgQTbpFPl66ggY2BecFS9wgT1FftxTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceWWVlFt8IfcQwSq3/+4Jb19X4a+1aP5S6hFwVXm8JN+FBbMjnmvqmYtwmu7DBEqO0tw/NXv5axY47pSIvW2/d3/f8jykCChyQdF1MPrUV8mHu3LlKdRVMpn0fZigJBxd1oSFBanfPnw9clU0+/apdc+yg5BzqFLln9E7NgFq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45a7db48c57so2406732b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 07:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768231017; x=1768835817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2lP+KPaY9dq3lWX+X1Khpp2qI/DD2GRwQIakoNQiEk=;
        b=ojgiscvLEUsJw9Re0PXGgRcrORN0YGu0bxpzPjcg1hn7+KySppzK4CwepafUo+T34k
         ETTFuvmF+qrCT9FcrZJbhajGlVkGQSuECA2Pf++3K5x11b4V+3qNXCPVNESQL++nrybE
         wH2bsB4+Yv1XeL/VBeaTCRbVKSE5NvD988jxgPtmWzWG5EBMPNL254VYMoy9CMOfEEWR
         uAepEjgP1k7zzLo2HVEkfY7j5i344nfJKtes1mf7zUf81qBj9Vw0Ttcy+gyWIYA9bAeV
         0zpmYGpnKoCd8yW9H6XXLL2InjnHP8+CdqtwP6KN7M2BnQd1pdiz1Pg1fxeuZLDhGKDP
         v4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU4gThtEKqizpp1LNzNFvxhQDRu57UtAzGk0X7dJ00lZjp+x7o5oQUzTUnT6zPJoqJHj7xqR66xk8ggtbPhZuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAKSTEO6uw9I0RutXqUFlWrHB+9DKIOEVqKWMZp/aN06jiPa4
	GnDYkI2HaEHPMDe/YMGRLMcSP2rxNLwvuBJEO/eS+IhrzNH6+3ajr3Zn
X-Gm-Gg: AY/fxX4IODu0qEvQatNeNAFmvHpLNOKIVInZMn0kszNTn0ChPJU2XRan2srEDvh9Qcy
	oMfZeccEatxntb3i++eIVD4BFN23sUxnMC4EmxekYYzkjxt6QQO+v8H6urgx3GUWP+I5yedZ0Az
	NI7317tDWWC6PH1BkXpwt+4iZ8818G+xrNCk0Va1tnpTQyKeOR44KgAcBLEF+PXg8J9WRDNtxej
	tuh7MThVUUZjXk2IGy1j/+B6WJglkNNWM4jl5F/fFxLlVwrazfnojrei0VGa3txtt39Bs9qQcdh
	QTwF20Sc3q378BqgRhHTgvpfIhnWSRZjHnybl0tYfd9kq40j0hjMVUKez7D8/XD8cGMKhl5jtdp
	9igtBis4EL6r+VtISX8ckrvv5dRM/cBswpKpUsp20KiTkJ4nluncTPYXeozcRJqg1g0SV/V9law
	==
X-Google-Smtp-Source: AGHT+IHXfMnaYPQo14c++hNdyyk6Ymr6+cKtUfrFEeM1r20pAZ3gzUSjR2INaAmkNP4czHxbLR1BrQ==
X-Received: by 2002:a05:6808:11c9:b0:44f:da6f:edb1 with SMTP id 5614622812f47-45a6bd83ba4mr8571597b6e.13.1768231016956;
        Mon, 12 Jan 2026 07:16:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288c42sm8280583b6e.11.2026.01.12.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:16:56 -0800 (PST)
Date: Mon, 12 Jan 2026 07:16:54 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andre Carvalho <asantostc@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Message-ID: <uzrkzwqpy2mf5je44xz2xtody5ajfw54v7kqb2prfib3kz7gvj@wtsjtgde5thb>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
 <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
 <20260112061642.7092437c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112061642.7092437c@kernel.org>

On Mon, Jan 12, 2026 at 06:16:42AM -0800, Jakub Kicinski wrote:
> On Mon, 12 Jan 2026 09:40:58 +0000 Andre Carvalho wrote:
> > Introduce a new netconsole selftest to validate that netconsole is able
> > to resume a deactivated target when the low level interface comes back.
> > 
> > The test setups the network using netdevsim, creates a netconsole target
> > and then remove/add netdevsim in order to bring the same interfaces
> > back. Afterwards, the test validates that the target works as expected.
> > 
> > Targets are created via cmdline parameters to the module to ensure that
> > we are able to resume targets that were bound by mac and interface name.
> 
> The new test seems to be failing in netdev CI:
> 
> TAP version 13
> 1..1
> # timeout set to 180
> # selftests: drivers/net: netcons_resume.sh
> # Running with bind mode: ifname
> not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1

I was discussing this with Andre on private.

Also, do you know why we got:

	/srv/vmksft/testing/wt-18/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory

after the test failed?

Link: https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-drv-dbg/results/470321/3-netcons-resume-sh/stdout

