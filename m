Return-Path: <linux-kselftest+bounces-44195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB904C16187
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCAE3A9FF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A8F347FD2;
	Tue, 28 Oct 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRHG5qE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03819338F56
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671428; cv=none; b=lK/dTJ2BLvPW6434eIez7jnJh9ZfmjjmiYPPxM63SNYDt8P9VboLdaOxRZBs/ItshOkstEO5IeWkS0PpQ7S35apEodH0lt69mmwm8mZs73ISdHLhxiKWCQKqBM3U3dGMb1P2F/+HLr6tnJ1ZvDTkSGn69Z8L1TYvWQJ79U0DCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671428; c=relaxed/simple;
	bh=m3I9dtve6TdfQpeD/5c1k/FwNdSdObvUw7hMoEvNVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In6y0fKyQV+k3dcQVPu8fd6fBMpBY3l26LRWndhcBjkyEM4vTYR4sCOafIcLjb0UDjyIFbHTsm0ekKo05Exq9UR3CrAztu5SOYwa5EJTeZeRBXvqRXmCs/ON0Lnyl4DDLo6XjczfEulQxzzO3VvkJMpgFyQDGiIBc6MKDOXsAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeRHG5qE; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-290ac2ef203so59724465ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671426; x=1762276226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkkeBtodNmN2EMa9qJLybudRjmngQqkOpn4I47bN1Os=;
        b=HeRHG5qEN5uTjjY3ibkWq33IiamipujAhi60b9r1rM5RRPJZix2+MocaWLMsgNdzzn
         rCRaFyrKnHeUaypQDn1k3K/dqscVruRVqMTp+igbGbC+db5aiAfFYeE0f5PSLqzGly0B
         Ovbu07ITP9IM/2fwN+YgCr6l72LfCsLXcf98t50rQ2aT51I9i9QHnWZBcPUJfgmI0dRC
         hcDVe7L3na0X+uTihwIrNh/OF7NNAdsSDaUs/thpRtSEuaO3pAwmuCxPhAYF4SvzmzBq
         +g5mLWYTq+KRd+hIVppWWv9JlGPQ/3UNy/vJ92ZwMl4d1BKAHGUXeTSQGuqNK8db6i73
         GIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671426; x=1762276226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkkeBtodNmN2EMa9qJLybudRjmngQqkOpn4I47bN1Os=;
        b=j9qFGjePefttWW0K8HPAFgdxPjg68FhDoW/HHce8TxxHKZvAahj14Ps8aUi5uaWsGj
         8d8qeClg1MJLyMs1LanbndFbKPJk/R3HLXZmKTCYdXa86XTTkk0hJMv1sW2uHkReVPe5
         Cj6K/jFYtDGzKxey+059AKZS8oXDlUdKjffh8K1Ys+mXys5nKbW4AT+IZMFftlZzmVm7
         RRi8ctWW9wqGc0C1pMFCy3s6prH5O24AUXB1FgZZL6uae96ESl5ewOdkvbKZCuiNAYvP
         wx5l5LWvUOkRqhglJlWjbLSfI7CCUghj8ZREIXVSCgjpwuAziFi6jyMWs8LMGAKgyJCd
         jebg==
X-Forwarded-Encrypted: i=1; AJvYcCVcaDzs1v1kwVCFxoG4XIOfls8EVTZ5WwuMC4dlyyAgG9O0HHuJZeQ8brLWP4pO1t4VVo9s5VzFRT9MCCsuIY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTakkznICf/DGF0oEsdDOig4yJ1K1cFzix2fvcO2zSbLL+L7WT
	YSu4FZZh5KwX1HOpd/E58MD6OL4I3Vb7pVQDeCRQkXRjCKHyeFeO/JhP
X-Gm-Gg: ASbGnctZkDkyZWV5k5i0AZD5y7PURxZX4rT2kXFWLUGCtnWGtzLf+FR21K3wB8uPky4
	MCWBh+Lg5Wumo7PDNc8IN7o2ytzEK3e2qcEcKjU3QlbxJNpCcJEX2lhEpsaee/K5M4Il5LJAJN1
	Nshl1Wg76TiNa8xFz5TL8xfKpZ+hAj7r2Bybw85MyGZ/eg9c5p4JrBZn7TOuqvMvru6QuWSgzXw
	oblCsLROcuUI0ceXQFPArFwbQJCzcVYAixGUOINBJSeZGRs/7mQ86+e8+0XNHMthSkqwZe4QfMt
	Fd6HnTb0Kb3HYThRzVZ1G9LLtUGI8BPXcKcIYj3A1t+zKMGZutyLpxEjELFRI5AWlSKJ+t0NLtl
	hrD5iwoecQP+kBzJE4V22xFimEFdPAmKH9KyXjAJr4YM5td+x7Tw6uyaxBYmvwRPFQdzzp0XP+f
	UYVtGMIJL+ixm7j/g44lQ=
X-Google-Smtp-Source: AGHT+IGQ8ffNexl4HmIkFUmg1fdyuZl4JbBMFVH6xuxPDuvHwL2uHadtShWy1RlMi1Xof4Eda3TnCw==
X-Received: by 2002:a17:902:ec83:b0:27e:ec72:f67 with SMTP id d9443c01a7336-294cb391897mr51139475ad.6.1761671426009;
        Tue, 28 Oct 2025 10:10:26 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm121911965ad.15.2025.10.28.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:10:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:40:14 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQD49ukK0XMUHTUP@fedora>
References: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
 <aQDyGhMehBxVL1Sy@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQDyGhMehBxVL1Sy@horms.kernel.org>

On Tue, Oct 28, 2025 at 04:40:58PM +0000, Simon Horman wrote:
> Hi Ankit,
> 
> Please preserve reverse xmas tree order - longest line to shortest - for
> local variable declarations in Networking code.
> 
> In this case, I think that would be as follows (completely untested).
> 
> 	struct sockaddr_in saddr = {}, daddr = {};
> 	socklen_t len = sizeof(daddr);
> 	struct timeval tv = {25, 0};
> 	char buf[] = "hello";
> 	int sd, ret;
>
Hi Simon,
Thanks for your reply, i will send v2 patch with requested changes.

-- 
Ankit

