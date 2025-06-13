Return-Path: <linux-kselftest+bounces-34907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC6AD8F1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F80A2028C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E72E11B4;
	Fri, 13 Jun 2025 14:07:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F92E11AF;
	Fri, 13 Jun 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823664; cv=none; b=qperekl3gXH0AtLxAYkrfc1bwJBhP8kTwx1LbCtu80VcTWThS9jnlbkO6YRQfhCTf6WjlmSDumYbaxO2VoQ3AaeklEuxmPrVh3aHvI2KggC7f/aSuR+NzQC38S9SMSzNkUPRxo59kSsRF6k1+eQUum8R4Uz8QwjFctTNOqwBLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823664; c=relaxed/simple;
	bh=98ZVYdyeftVKt25WNUg09UDBycu4YRaJnE7MO/w6+nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1Cx3g5/4RwBmyfwQZ2eHojeF2t19I4mdUVhFEn/9eJMVh0hrWhg1WevHiTPxhFqqPK7LJcwPNmonTlLdTvTkPq7v/WFuJWt5v7+Qt3bEcJiBqOnjAamG9vYlfxLM/p/0oByZoRxJCIxxurbn2ZKwA45x2sbaBs8JIVJ678baZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-addda47ebeaso415182566b.1;
        Fri, 13 Jun 2025 07:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749823661; x=1750428461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Url/5N94LiQKOE3bJONgPHIYMexxPTde/HXvGPstc/o=;
        b=Qbe7vX2k1zetseNpY4lzMgPOhg+I0oagWmG/42M7XlZPD70+O3ZLKun0RUIGssrzbY
         MPjruIM+zC2RfZPlPLhbM+MVhjqCqGD+8Ydj60e0+TfF9GaKEPpctkDuoQMjdOWMFhns
         qhd+mJyk0cgAPp2vw0t2UbdiGoEaqufGko1gJ5c8NwwTxVpydJ399b/f2VPcjYGzaZkH
         hPoCa2QzGdxIOD1+OLocUcY81mr5FHwmrFObktgF8fN2ydEBYg59fkYHPxkjvQ6thAxm
         aQfLKnz1svddMQQz8lK9EfplxakwgZBKAwYmfMN6mGKBdfqTlWe9O1Lg+zkywQphRAoK
         vfIw==
X-Forwarded-Encrypted: i=1; AJvYcCUQUjEdBSKfGr37GeT8AvSp06PZpJAut1rU8vXKV5z7QbEpOdRoCDniUT6aE7nGHpOO37+QxDfO+8nwuOI=@vger.kernel.org, AJvYcCUmIwnK8yfTiqxjGf1muNBG7jmSGBVxR5v/61WgF87p2V2lxv5iDdHGX2uF0jK7TDt9Fe6UvhVv@vger.kernel.org, AJvYcCWr1YMGvEZo6ynpS7gXTnVtdqwZ/APPDug9yhlWr8CMIaLcujBovhtF2U+1T0MCVuKHl7l00EpIDEuQeEc/eDpp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2MzyflO58w3I5LYNvpcxJbxGEM/r1od/YyJHLC70YddX1kfS
	Z4OshKP1WAFJn2eUmy3kaw41EF7yWUJtNgEq4C7zrbJFuYJSUy9bkqOJ
X-Gm-Gg: ASbGncuQ0T31+pzfGRx8m4ulGz6+Bly7SdaxLqTAWxhsbICuXPIezroyHsZQu6NswCQ
	mmCQaj7n6iF9eHOoszaw52np54VvsUh6bYOboutJM6n3411bW9x+dySRpRh2dF7Ke+HkXdbmue9
	Ji6+5HUb1ZPckE8ak+CZfFCsDAKeFJ1PNZPclQYVE/aVvc9iamiF/zUPhy5mCMTOXd1lJzgOLb0
	fiKTPP5xkv9Vjw1Jrcp4kVxp0XrdjrLjCTq96ZCIexPwRpBaiQYh/esX+CqGsQe3PiYyccF6dLj
	0sZQGbZRh2RAPrm5FgZouKiJeoejg15qVBWFnHS8L6E2nUjGbPE/
X-Google-Smtp-Source: AGHT+IGhGNptWBx8bwCI6iKzNxTW3g0jXNopjXbjCLhHLLFHedcVEJLkyXdvwH3V3UYpMqHOIXFeWA==
X-Received: by 2002:a17:906:c144:b0:ade:4295:a814 with SMTP id a640c23a62f3a-adec5d7028fmr302726366b.53.1749823660975;
        Fri, 13 Jun 2025 07:07:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec89880e4sm134448666b.177.2025.06.13.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:07:40 -0700 (PDT)
Date: Fri, 13 Jun 2025 07:07:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <aEwwqhrx848hSh4k@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
 <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
 <aEwd9oLRnxna97JK@gmail.com>
 <684c2b0770919_10740f29412@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684c2b0770919_10740f29412@willemb.c.googlers.com.notmuch>

On Fri, Jun 13, 2025 at 09:43:35AM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:

> > > > +def check_traffic_flowing(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> int:
> > > > +    """Check if traffic is flowing on the interface"""
> > > > +    stat1 = get_stats(cfg, netdevnl)
> > > > +    time.sleep(1)
> > > 
> > > Can the same be learned with sufficient precision when sleeping
> > > for only 100 msec? As tests are added, it's worth trying to keep
> > > their runtime short.
> > 
> > 100%. In fact, I don't need to wait for 1 seconds. In fact, we don't
> > even need to check for traffic flowing after the traffic started. I've
> > just added it to help me do develop the test.
> > 
> > We can either reduce it to 100ms or just remove it from the loop,
> > without prejudice to the test itself. Maybe reducing it to 100 ms might
> > help someone else that might debug this in the future, while just
> > slowing down ITERATIONS * 0.1 seconds !?
> 
> That makes sense. Or only keep it in DEBUG mode?

Even better, I will move it to DEBUG mode.

Thanks!

