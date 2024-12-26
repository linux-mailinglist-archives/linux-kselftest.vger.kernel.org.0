Return-Path: <linux-kselftest+bounces-23758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13149FCDF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 22:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AF51631A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2519258B;
	Thu, 26 Dec 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjF48+92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8D19007E;
	Thu, 26 Dec 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248257; cv=none; b=O5NpWakoUFckVCcB6a3UQyfI85chiEQT260o39I5P9j8FgN1G9PA1A8cmZFmBGXZSAvnCfMtZVJf/JBFQRG1vaB+yRwtwEBx7IfVgMxKhhlHFAbI8uxo4DRxIFitcXtGvHuMkYLEgIDZZcRmj86nI/hawKKv4N55L0rsGyA6S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248257; c=relaxed/simple;
	bh=UtPtkiMC9aMLooraJK0OO9y9CL0h+3uSLW06oAagplA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PSCjA/r+mN/7ugwr3Ea6C61dI6sBOiooXVuF28peAyEe+rrvD/4qa5S5l+u64g0wl3npsrYj+6DxokEGvWaWUrekG2p3ezcFUrwlll52DKCTVZyJT74VE2fOYxaNPjQILnhz7402N4JNt+w3y7UWwqMQAKUVOnKTAH+/Un4xMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjF48+92; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a3c85e11so40999061cf.2;
        Thu, 26 Dec 2024 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735248255; x=1735853055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfeX401MSHvmmCPqi6qpPfC5xzDKFLL9ih2D1zIAmnc=;
        b=cjF48+92PZartOlLbr+Vjr4c6qGQ0shy3gGxZylDaRZr6zy2GpUqpycVeUNjsbvk7H
         grDS/pfxCUAyuU6bCYjN5AUgxJF4Pf6IgYfJyqdpqBfJUn0AKjGOh3RRzwJY2SgykN13
         D/hDXB2bR9bogAbHBFHlw/K+1ziecf5jilKhXow7DJxEGdcexMJkrAuHEtDEz/NuIbrr
         d5sOeU0e2S9SO/NbQk/wjNu+FH1157jO8auXrL0jMSBSZjsz1cMnEFsEKkaEU3c7aQuN
         +FRMyNv52H8xMVPYmmpcLMjTC5BHjQKCpkQ/vcaFnyFXMd2XGOrKW3d7ylHrwj4JbaZN
         yRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735248255; x=1735853055;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VfeX401MSHvmmCPqi6qpPfC5xzDKFLL9ih2D1zIAmnc=;
        b=fIu6mp/uIp4pw0ee4vXzBpP0jFp3u9h30u20RCF0HPBHMrJz7FCqwdTbHj5Yo0ZbOy
         iZpLYH+CqbEk08Ih46yF+/jmuChNLJOc+J/C3guLM/nJ2LTbGHnBPIypljRQsTRyzknq
         Siiz7c7BG255m1gTL8LDY+mWeBCNxpkGtiL8KBH3AnJBBADzrFLcooSIYOibadMsqEmI
         HmxAZGK6fGAoFVcZGkITwXM3S6GLCRGtvsN81DlB1rSiYk1KTOivA0qE8/LEuMSN0/fb
         4n01d5r7N8z4b1oXJGsc65uPxbMLtZpi7KsfqGfRy/Uv1jD8kl0cyfhwoX/DpFANn2x+
         fN6A==
X-Forwarded-Encrypted: i=1; AJvYcCV2Mh7fd79uDo8vg6h1DHg7u9Kkki5YeBREB8FuzoOcPGOpdwnPYsFOO57NvSLl2Vqh7ynXVkAxgAW/wyoJ@vger.kernel.org, AJvYcCVPxp3Un73vWlPuB9oN4zrbC0VOSmgj7+RkNvrml7X0dpNVsWiBMcp7O4kjfg/voeg8eIYN+6qztcn+hp7Hu22Y@vger.kernel.org, AJvYcCWenZHyvsXznoA9fMM4IFNDwJ4jbB6Y1IHHBr79vzKQ2wo5pZafbRv3MkHwDwD1MtKW7gBYC7DN@vger.kernel.org, AJvYcCXSHUqf76voIY/nK5EmiO0Ohl8mc+PgsczTRg5zzoXvGGhFUhn0YE/5geRLhip1+ezUvWg=@vger.kernel.org, AJvYcCXTn3tx+g3MJrZUaKikGIAuwW/C3YduRAVc2Kf3FdZUy+JKVxYgIAOhbJpegAFB0sGeJMTHZQo9Q547@vger.kernel.org
X-Gm-Message-State: AOJu0YypjsqfNhWuWtuRFQGXi8jEXiwrEuRE3EylV9v1aCZfe15H/PEK
	BJj5EhXfHp1BJxjKoXwhlcNvaIeCPTFZuWxJbWTd/O5xSfGm87aB
X-Gm-Gg: ASbGncs6jVnf9kgvwYsw8zc+GmEUS17Y06hp5feCIyY1P9A9wryakHFNB3NWv+ukx4s
	5pLsTS6UkNpUHWM0J6IPO/ew5YYcbaNc2f7itCeOeKlhrh6xG2bTSQcZ8ZfKzP5rNaQSI0Az0K6
	iJUsHa84Wj+IlXVOWth+FAujRwT8wsymVwkDc4R0QbP1kuUDkq4b6ZBaKes5FhvrvvKjXAMtKc2
	iB60YRSsZ3Uy/ZZIahvbfoBbHbzTqH3U/TnDAk1BM9vMfAn1xBlrL6laD5PwTmcRnTXOxp1o1+v
	UvyweMsI6KX6VflwcCLWKgKYO9wuCD0A4Q==
X-Google-Smtp-Source: AGHT+IHU4gOFbrplgEWifYfJdFaG1u/QGgASBA2M+5ivbCzO+XzXulwv1NBgHR7vrK85NZx/bB/gig==
X-Received: by 2002:a05:622a:13d0:b0:467:6c18:9855 with SMTP id d75a77b69052e-46a4a8ebb04mr484623951cf.27.1735248254929;
        Thu, 26 Dec 2024 13:24:14 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6553e8sm73991201cf.11.2024.12.26.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 13:24:13 -0800 (PST)
Date: Thu, 26 Dec 2024 16:24:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Joe Damato <jdamato@fastly.com>, 
 dw@davidwei.uk
Message-ID: <676dc97d7c311_1d346b29456@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241221004236.2629280-3-almasrymina@google.com>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-3-almasrymina@google.com>
Subject: Re: [PATCH RFC net-next v1 2/5] selftests: ncdevmem: Implement devmem
 TCP TX
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 261 +++++++++++++++++-
>  1 file changed, 259 insertions(+), 2 deletions(-)
> 

> +static unsigned long gettimeofday_ms(void)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
> +}

Consider uint64_t and 1000ULL to avoid overflow on 32-bit platforms in
2034 (currently at 1.7^10^9 usec since start of epoch).

Or use clock_gettime CLOCK_MONOTONIC.

> +
> +static int do_poll(int fd)
> +{
> +	struct pollfd pfd;
> +	int ret;
> +
> +	pfd.events = POLLERR;
> +	pfd.revents = 0;

Not important but since demonstrator code:
no need to set POLLERR on events. Errors cannot be masked.

> +	pfd.fd = fd;
> +
> +	ret = poll(&pfd, 1, waittime_ms);
> +	if (ret == -1)
> +		error(1, errno, "poll");
> +
> +	return ret && (pfd.revents & POLLERR);
> +}

