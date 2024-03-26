Return-Path: <linux-kselftest+bounces-6653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39E88CAB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BD81F8378E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041FE1CD29;
	Tue, 26 Mar 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkuZqFgt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1B1F941;
	Tue, 26 Mar 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473916; cv=none; b=ppb5IPyCoILx5YLMRfnFBaVIrB9+IhRrOxlrxlqDnzUJP4P48GhlxRKK3XZaoRpuU8DDEV4U5rMCUT1dFalNUv7HeTuK5dNmVairmKN5oduOaXWE+2JK5upvlXqiu7C5sJQzBqbBiEV22n3oj7pvXZAA9VyH4yZ20C/tHo8deyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473916; c=relaxed/simple;
	bh=ouExxAnjMIsGwW4T+Gq7Ao5GRlfTuNgYV0PeftFLR90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWsC1OiinkByOWTX0714XIrdgSsxR6Yjtxl6O6vvjxS6bHImKzAJTnY6rWJaltcA9llcs8exliXSWHift31A7HhUP1WGSirI/SgNBC6FrMHFwvc6s0a11tecuIkO2hnLGuWROgPuvY9f1kI6X7TYIeiInOwIy24g9jCW/zwoi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkuZqFgt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-414866f92beso16806445e9.3;
        Tue, 26 Mar 2024 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711473913; x=1712078713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIUgf1B9/y9K/vRu24Pisue7YbENj34ko6OOe/V8jiE=;
        b=UkuZqFgtdTI/F7xmhgzjDC/VZi4iw7qJBNutXRTMfDAde9m0GnIuIunITpjdgfW2SJ
         2r1W9mJl4U8Qcwn/dWSqv91QbZnF+sUgh6E8U0WGsi6CiXunWW49GjEnBIddMymG9Nw0
         2SQUT6I973VNaH/deaBnwgd3e6tpBxNWCt91GTVflYUE9CtSy9iNJERL23u4Uzjh3gMf
         JaSj1gp/GOmrQpeaE/YtWYz+zIy2plIZae37FtfiKJsbq5UTRnQuVSmSrqlda9EO3hkh
         qfOo4J+UezKw9kqd+toy9gMxkk10YyIneF72/36o3oOJwp3ODQS9Ey3X2oskAxoci8sv
         3i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473913; x=1712078713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gIUgf1B9/y9K/vRu24Pisue7YbENj34ko6OOe/V8jiE=;
        b=A83FEZylQDiV/t0RaazOsIjyL1i8fCeetSv/Mk+BU2X2hjqPkhW5WBbJhDiwtTZhym
         c96jggGGah3mzM/DgUJ0O4Rx/9BjG/G8AnQPJ4VKgOuFru96soRPheOtA4cLqbQ8DBd7
         KUCZX851T0JoyoOOTr0reGuQy/7Ea1Q44gzW5V+Mk6EKHzLUUGCSKrAQdteu4b/Ki0Yk
         KOtpC+79qGqP9Yp8Ea4SZeqz5r4kssRZWVL0EdNARR0YVPth2px1SNSssDRK0LJ2oM2y
         FFMrgMdNcnAnMl5FsfbX52bmecvbUC7dfJBXC3CKpFTFRXA4mGL2ckmAJJlidgj+O6OG
         olXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcWem35aVIse9BRlQFDjS6V602DQ3UGiuhQqK1pdbQqxw1UKw/eI5fRPnuCvZqInBvJsYgXYD3mQ0XBDCCD3TD9M/fd8qJ6RG/dI957X13yBhuiG8PtO3l6fC0BBL6AMFmttLt47cCB7+GJzx66Ojz3zuc46B2zelvYgbkjAOMkCCqLwJf
X-Gm-Message-State: AOJu0YzPFEQXYcl6Og8rAlre1IuhUBoxJjOOk8uKppabqyQga+DM1KfR
	Ac0xI8ksRrtkkYWvqDZGNz4Dh4dzJ2RH6kCD+7apziY/i3LxFHz2
X-Google-Smtp-Source: AGHT+IHVNFIGMzS2dZ3xveJrlDb2FBXMasemMuwXPYWdG6f6UVM+/kEQadi8UvLXh+w/YXKt7GjYSA==
X-Received: by 2002:a05:600c:4f51:b0:414:9141:1461 with SMTP id m17-20020a05600c4f5100b0041491411461mr157359wmq.29.1711473913398;
        Tue, 26 Mar 2024 10:25:13 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b004148619f5d0sm9341052wmo.35.2024.03.26.10.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:25:13 -0700 (PDT)
Message-ID: <57bf675d-c2f0-4022-845c-166891e336be@gmail.com>
Date: Tue, 26 Mar 2024 18:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240325182543.87683-1-richardbgobert@gmail.com>
 <20240325182543.87683-5-richardbgobert@gmail.com>
 <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
 <46e0c775-91e7-4bf6-88f3-53ab5e00414f@gmail.com>
 <CANn89iJkDbzLKmUGRHNFpfiaO8z19i44qgqkBA9Updt4QsRkyg@mail.gmail.com>
 <6566fd5f-fcdf-4dc7-b8a2-5e8a182f8c49@gmail.com>
 <d60c6185b8394da02479100981fa3f1306d9c81f.camel@redhat.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <d60c6185b8394da02479100981fa3f1306d9c81f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Hi,
> 
> On Tue, 2024-03-26 at 16:02 +0100, Richard Gobert wrote:
>> This patch is meaningful by itself - removing checks against non-relevant
>> packets and making the flush/flush_id checks in a single place.
> 
> I'm personally not sure this patch is a win. The code churn is
> significant. I understand this is for performance's sake, but I don't
> see the benefit??? 
> 

Could you clarify what do you mean by code churn?

This patch removes all use of p->flush and flush_id from the
CB. The entire logic for L3 flush_id is scattered in tcp_gro_receive
and {inet,ipv6}_gro_receive with conditionals rewriting ->flush,
->flush_id and ->is_atomic. Moving it to one place (gro_network_flush)
should be more readable. (Personally, it took me a lot of time to
understand the current logic of flush + flush_id + is_atomic)

> The changelog shows that perf reports slightly lower figures for
> inet_gro_receive(). That is expected, as this patch move code out of
> such functio. What about inet_gro_flush()/tcp_gro_receive() where such
> code is moved?
> 

Please consider the following 2 common scenarios:

1) Multiple packets in the GRO bucket - the common case with multiple
   packets in the bucket (i.e. running super_netperf TCP_STREAM) - each layer
   executes a for loop - going over each packet in the bucket. Specifically,
   L3 gro_receive loops over the bucket making flush,flush_id,is_atomic
   checks. For most packets in the bucket, these checks are not
   relevant. (possibly also dirtying cache lines with non-relevant p
   packets). Removing code in the for loop for this case is significant.

2) UDP/TCP streams which do not coalesce in GRO. This is the common case
   for regular UDP connections (i.e. running netperf UDP_STREAM). In this
   case, GRO is just overhead. Removing any code from these layers
   is good (shown in the first measurement of the commit message).

In the case of a single TCP connection - the amount of checks should be
the same overall not causing any noticeable difference.

> Additionally the reported deltas is within noise level according to my
> personal experience with similar tests.
> 

I've tested the difference between net-next and this patch repetitively,
which showed stable results each time. Is there any specific test you
think would be helpful to show the result?

Thanks


