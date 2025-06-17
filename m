Return-Path: <linux-kselftest+bounces-35208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2FFADCD2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B253A94AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A07E2E719C;
	Tue, 17 Jun 2025 13:24:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAA2E7179;
	Tue, 17 Jun 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166670; cv=none; b=nQqacByYDLMdZ+jG8VpqlUQUSOOBdjyER6SDhyTR10EyvpwMUXRVT/+GCLc7UWntZ2W88JIlmX0pxdRsuM22/mBb7BWhleYK9PZG+woeu1RKc6EGG0QL3sgXJvL97UghQwDsxu9Br/T+uM4uFHf9mFgriI0xX4ETyggmYoawsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166670; c=relaxed/simple;
	bh=rMdH19Ha3Xz24HHYBArjf+McyOLpaD9H7J/RsDJcwb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD/KnzLOHSb5vNqCcVP0tGYsVipP4YVDNRtub6k0jEqrpFeJ5MwhIDbv72yHQ15YJ92ODqdVO1rKq9ZDuFiRD+dsempAFChCt8Pv5Aia2RG2mjrZLZK1Jm7iwz2PQZaoric63eTq337HnaC8ZhCGKFGOI/AFaPblfk4xtcad93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so1054475966b.3;
        Tue, 17 Jun 2025 06:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750166667; x=1750771467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZICFVnnnVkMN743/FIJcvBC1yVrX98jV652ZYbnCU4=;
        b=iW9e0F3tdtMOpLJ/74zfLV8/2MYjDzYYkObQGPu0OqwiodwtPbL/5MgfzHVVx7qq8j
         I2TbNpD2rKXnjhbTlWfTjkmgcwMy6ALXnOsJRnxPsTDlLY6qltR3UsWINha1R1vXSK+k
         +fKA+LHgqlbm2GzugBxaONQ43Rs/IbZTk+cSAhCXC0VX42eLIy5u/dbBdwGgt/iJKBNX
         +alqB4RMtZDVcirf9ZZg/RO9bq/zGJLoVX9LJ+0N7iNl9QgU7REtbS1kc9wrVQiN6W5z
         wVHWV7sO0xagaLDhGou4Gj95h/+Zx1DPKL7Uc9iwUBba6uYIsA3ARP4hDbJdtWf6kcbV
         kPMA==
X-Forwarded-Encrypted: i=1; AJvYcCUFBNv1+1mU0iLQ2W8ptLoZBmTK6QUizb1HzqtChlYiZ+4ntYuzl6YTlrhqdOAF80hB9gkpPHg9uPubHGg=@vger.kernel.org, AJvYcCUp4V4XB+hbUDvvgfieilfkOieK/pdRpNdupndOfOUZ1f11hL4OZe5UGR5of8caT0lASS40M3hO0FFdxDd8E5H4@vger.kernel.org, AJvYcCUyguMTzq10E6aGTw7Kv6Q7oYZh1PM5iTt8OswYlgtuiaFQoxjwnA+0sARI4mbQ3OD1l0iTRGEs@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTnulWUpA+0BN+u0sOGojFnMq8R0Vyu830XJ+4WqBxDptqE2p
	gedeYVxKJhRmRxkgUTNhODrrFqiSxjHLNOz0gZhk+NRaxctyrABF3MeS
X-Gm-Gg: ASbGnctc5Jkbhi0XU/LG786kPUUrEghnZT3lBRkgfG8Z28hQ/Di3uGP7UdI07oz44aD
	t/zWeDM4jhdTlalOkRe3nDba7lK1Yzu6Lt723wkJwwNdLagT7Gbo06URic4e5Ek1m8d12tq+blE
	+7ye5ilroEP3unnN3XSZgD4W8940ay2UkyZfMjNY72ZU3x270Z0kvQo0k6R2VLfqFW8JM66KlWC
	7GjRphQW8fiOsqDjEZ0dWXNrga+Wid5ZiCG/ilkYYlLZ7D0KxUSUhE6p6jANodf+Pv1FEEsBZaZ
	ZZErDh0MkzlZi2jemqJw5g2py/fbWJk2JTbGfIAxm4mqMJ5XTn9Abg==
X-Google-Smtp-Source: AGHT+IGb/qV6q15Q5myFKayi4K5nSnZqUdVvCniIl3Tz87O9hLcBmM/EKSqLdBxQCLQnRtXfxzrDhw==
X-Received: by 2002:a17:906:6a18:b0:add:deb1:d84d with SMTP id a640c23a62f3a-adfad29d0b3mr1296023866b.1.1750166666357;
        Tue, 17 Jun 2025 06:24:26 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0138c533dsm11930466b.7.2025.06.17.06.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:24:25 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:24:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH net-next v3 4/4] netdevsim: account dropped packet length
 in stats on queue free
Message-ID: <aFFsh6kFOkhGOO7Q@gmail.com>
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
 <20250617-netdevsim_stat-v3-4-afe4bdcbf237@debian.org>
 <20250617055934.3fd9d322@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617055934.3fd9d322@kernel.org>

On Tue, Jun 17, 2025 at 05:59:34AM -0700, Jakub Kicinski wrote:
> On Tue, 17 Jun 2025 01:19:00 -0700 Breno Leitao wrote:
> > -static void nsim_queue_free(struct nsim_rq *rq)
> > +static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
> >  {
> >  	hrtimer_cancel(&rq->napi_timer);
> > +	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
> 
> here we are in process context and debug checks complain about the use
> of this_cpu_ptr(). Let's wrap this in local_bh_disable() / enable() ?

Thanks. I was able to reproduce it. Your suggestion avoids the complain.
I suppose we should just wrap dev_dstats_rx_dropped_add(), right?

	diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
	index 5d0b801e81129..07171cf8b07ee 100644
	--- a/drivers/net/netdevsim/netdev.c
	+++ b/drivers/net/netdevsim/netdev.c
	@@ -635,7 +635,9 @@ static struct nsim_rq *nsim_queue_alloc(void)
	static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
	{
		hrtimer_cancel(&rq->napi_timer);
	+	local_bh_disable();
		dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
	+	local_bh_enable();
		skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
		kfree(rq);
	}


