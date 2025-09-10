Return-Path: <linux-kselftest+bounces-41197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57354B5206A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F723A845A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA452C3262;
	Wed, 10 Sep 2025 18:50:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C701265CC9;
	Wed, 10 Sep 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530222; cv=none; b=Z7JYaSaJAUHqkyNKFbVNdTHJ5YgbqZRpSFKLgSqYx+iEZMd7YL4yM+TviRK2OIJZOdPyxgBue3zw6r6U7Sg3PqHmbgfSF/AnGz6XbX9Fjh0vBsJa/c58ofxtXtP9UOS87YeZw8NSGENyCbxmwQMkeYpj4yxkGt76wnRtP/g73gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530222; c=relaxed/simple;
	bh=N4iea+SzKwrOKWR30vrkDfzE8zVNElUEfnxNB2wUOYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAPwLXg4EedalWdjy8YvYR2t2hed7n0bFdahG+vXMTyzch5Hvjur3zVVvj2RUaw9K9Z4yl8Zh1DF52HOdtdtn2i2S6g131pUkdw8qPzv+r0P9PqBX7+YqGUTsQrd2hHa/7Du+TYOP2jsdTnfHjsiXFBmU9toPfZmsRT/HGkmV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso877750466b.2;
        Wed, 10 Sep 2025 11:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757530219; x=1758135019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlQRz9kM9KvyAgrvvrHmaqoax/Y6SgW1dR4yAV7t1Yk=;
        b=oNh/3/KOKpfXCLwue5oPqfazJh9oImJh/keva/Nl4XSOmK5+1LykecJVBIJM0nJTXj
         gGIXKKgvBGFIFPQJESwIQ/lZIiQOcG0OuHJ4J5ZIANYM+DCJY+RNmq2zcqdffSOVOjz4
         S5KwVbds3G6eBy4VrDzVvmPK6nnxMCBSclaqqJtspQ8j5TVY3qwcs8AU8eNsz3T6H+0i
         1s6frJRWgdoVz38VcqM8XCK2coMuo2GQA9bMOymTuxc1nop80A+NJ3ebAL8vEKR54Jil
         wcFC5ujom3xGZUOUyNbeH4IeRdpAVS0k+2hbBwGsDoKixfILtWv9hire5WEJhGMOQhnp
         u5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xNxp85bZ7pnEF7BMzHbjNpkETUD3mKWX7cmZkIOKyWjyOX39YX1KG5/TxX1SJIqeLN64XgA6inQfbTo=@vger.kernel.org, AJvYcCVIZ9xz8VcobyyNXbhUXubjOE6OrEEVibOY2Zx44yOBk0czCQUiGH4yslQBc8vjXN6lPe2wLaLp@vger.kernel.org, AJvYcCXPGmLT7oUulRBIQaT9zYji/4r97Fw6fxS+u7M7T25kbupD4Zel7UxtQxDWd+jmbf5RDObZmY7K@vger.kernel.org, AJvYcCXkLOmoyDhS3OQMKBpUm5KNyC23Dx8N1PF8Bb0Cze020QtcE2LLjmC6sSUhUqf65FopFO+kBDWALViEfoXUi3yQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtA87M/ZeY1/0QgUaFl9NxLdQgVH8ie0Dh9umwbCanQz+uw/B
	2a0JzU7v8Bi4pjEwMdMMKaWR0k9W3wpoPcy18F3B7Uq1NeVwMj3Y4pn0
X-Gm-Gg: ASbGncsMkDNQ/RMOJdzoKFd/Ciphp7R5wtNdBv7yUyfWks6VXWS8tgfCP9lM88duKcU
	3zdG2JwSZXjuB4O2eJ9b7dAg8FP1pRBRQTDflwoCgdUfN+q/3lmPYHGvHZ6YL+/l/kaj7Cf2xOw
	EtitjJ7ZXLmGNhPML0heidKgKZPwjcHcZXW1MsJ2bNSqyGEb+74/BKIZLWgQyol1H7eeANXr7gb
	ap2mUD8NtE8TX6EzyJKvO0TcZNbkZvjRe0Mx3cL/Vze4qAgrbL05Or9nZbHb3SqzjKONqnTr6Vk
	mtcTMHpNZRhZuEqYdRbDOxA2Ec3MmEZNQFmLDKdKBfMu+5cX/xMBvCcB0XfrXeESLBlXCk/dQK0
	Ta2t2eMrd59lsIrBq9AgK
X-Google-Smtp-Source: AGHT+IEkRY10yVM1hwOHiLwYxW9pXsSMDFJXPpBi8VhvamBnCRNvf9wpeUQLrVBNwxV8/KlGwf8kuw==
X-Received: by 2002:a17:907:7290:b0:b04:32ff:5d3a with SMTP id a640c23a62f3a-b04b10081d8mr1617429166b.0.1757530218565;
        Wed, 10 Sep 2025 11:50:18 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078346526fsm207587866b.109.2025.09.10.11.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:50:18 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:50:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com, 
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <v6yjo7yfimoof3mws4ymzrb5lkqd2t3cv4d4zzmh2ljux6rna2@zyj2tn53gep6>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
 <aL9A3JDyx3TxAzLf@mozart.vkv.me>
 <20250908182958.23dc4ba0@kernel.org>
 <kmvkrqkkrbfctpramlchpwqikg2x3btb3debshabqctt7azu2j@tv4ziqd4gldh>
 <20250909161625.470d2835@kernel.org>
 <jibftqm5ihdgazmk3p5gsjhlc536itqaq7r5uag5fuiqtth6cp@abihzyykh4gy>
 <20250910105858.083ca8df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910105858.083ca8df@kernel.org>

On Wed, Sep 10, 2025 at 10:58:58AM -0700, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 07:12:03 -0700 Breno Leitao wrote:
> > On Tue, Sep 09, 2025 at 04:16:25PM -0700, Jakub Kicinski wrote:
> > > On Tue, 9 Sep 2025 13:17:27 -0700 Breno Leitao wrote:  
> > > > On Mon, Sep 08, 2025 at 06:29:58PM -0700, Jakub Kicinski wrote:  
> > > > > On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:    
> > > > > > I wonder if there might be a demon lurking in bonding+netpoll that this
> > > > > > was papering over? Not a reason not to fix the leaks IMO, I'm just
> > > > > > curious, I don't want to spend time on it if you already did :)    
> > > > > 
> > > > > +1, I also feel like it'd be good to have some bonding tests in place
> > > > > when we're removing a hack added specifically for bonding.    
> > > > 
> > > > Do you prefer to have a separated bonding selftest, or, is it better to
> > > > add some bond operations in the torture selftest?  
> > > 
> > > Normal test is preferable, given the flakiness rate and patch volume
> > > I'm a bit scared of randomized testing as part of CI.  
> > 
> > Ok, I will create a selftest to cover the netpoll part of bonding, as
> > soon as my understanding is good enough. I don't think it will be quick,
> > but, it is on my hi-pri todo list.
> > 
> > Do you want to have the selftest done before merging this patch, or, can
> > they go in parallel?
> 
> I said "it'd be good to have some bonding tests in place when we're
> removing a hack added specifically for bonding."
> "In place" means part of CI when we're merging this fix.
> Please read emails more carefully.

Apologies for the misunderstanding, It was unclear that the bonding
selftest should come before the fix. Thanks for the clarification.

I am planning to create a selftest similar to the original reported to cause
the issue[1], where I create a bond device with two netdevsim, and bind
netconsole to it.

[1] https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/

