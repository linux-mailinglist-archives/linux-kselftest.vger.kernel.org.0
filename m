Return-Path: <linux-kselftest+bounces-34904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E1AD8C73
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E09716D3B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9179F5;
	Fri, 13 Jun 2025 12:47:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854B1862A;
	Fri, 13 Jun 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818877; cv=none; b=L+EJ8CLObN0Dh+9zJWNFmxrBA5E3Hu3sYVms/EzPEuXRN5IgWgwXkNnu+sX7i1FOj27JaUKQGVmYYs/CqVYzAy6BxcHG7InNy3IOV5mv8lW3KHur1Vn6/+O7coACAEhIQjhxX++jOih0Le6EIZwWmPmcX8MDK2YqdOYMEjopFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818877; c=relaxed/simple;
	bh=ezXY3qXnquNhyaHYxBN/76XTuscB/Svb9cb+gsY3Hzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjUYsct0aUc85Z9BoBlLKa5SSOV5H8NTbE4+ZCNDmSlXQ0esKm9IH9+1M8cg1HtsdqO8DtgPx/PDw3ztP7ObjL9anFSxvtVnI1nHnicf8GPTqR+m/zWkz8UnJx+U1OrRnG1HJuIO88vZZD+BlafbyN1EIRwmpR+CBKRKbPe4xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so4081962a12.1;
        Fri, 13 Jun 2025 05:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749818873; x=1750423673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wHh4AEKR+VQShRFBc7WiyNVG6FHWDiPyckjUrWvfps=;
        b=cwoXK8FqNYC1FFtRwnQdALPKxgvrMBcSAn7OrLchhvd2ReoHaWpxzA2v3rSeugdCCZ
         KuXOpECDlt3GDWtYRe5ZEPpJAw1wAnllFeD9zQ6i3ZKEfbv/0rO+2A9eRzd66sZnhIr4
         hT8NF4Se5ndk8VTEVVU36ewuYkO445rBsE+Qtv4x0GbK7mDImJPh3zXiJn+vnZoF/zvi
         wijYB3Jwxs32t1RaCM/jvARFGQybz3Lwzf6i4iKpGGG8FbSdHD5YQS6pIEsljihbvexh
         VXsjXofrxIyekkmaCgdfE4F1ooVcenulR5hjxxZWxOazpM7jMwemb4BGqxwyvJir/nYQ
         53/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSsrZP/uXoi/JCHbHTlVWGWYT9r7lqvrBLhLVtlKtuXeKX0T9fr5VD65HEq5Zt7XbWqcHvC0UtmTtH+YFCXb7/@vger.kernel.org, AJvYcCW8q6TSBH8ugZxA6bLrM7gYPvk5NnRsFgu2wWVzk1EGeER3kAAw7g4upTHOTpFHkfLehfK/lycX@vger.kernel.org, AJvYcCXCjBEnzFJVKnPu7rnfEDTR2yKIr/nTazctAK9KKqCl4vbNV9sCBmtCT1sEXExcbxrKMAb1yZUOGFiuRYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVI1fdj6QKYdX0c53Vsd5Nr3U7JMu897AplfYpV76vH/yvCOI
	opwqVQXDw/Wn++R3eFS0YX6eYm62OmSlzrGS9NLD7Vq1sL8V/hJFjjCy
X-Gm-Gg: ASbGncs/kJKPKzCnHBHDOlVB1XMeq4UOhZ8FVbC/F4w4qh0O4ZZPeazYHxnP48LYeJb
	Z5xpRbgKRaBqJ+Z6DiVz7VG7NxiyazLuRW8B2qAFwsJB8tWUU1YYS/HL8ao3VCYf5vJy5qF6W82
	pc2JMTPS3RdTbOzTyq5ipHAbVd/1ADUpzKRoMJTA/6jHiAy04hGhxcliAJ5wK8LyWQ2wl3l/aH0
	Dy8tQjFL1SudRZqBv8hN6I1WLd7gIGvvRRUo6ji0xBoQwKF+Cw2FU0FkTuj8835CB8Q/YLJXAZ/
	nbFxBqxaK08aNnJvu2H/AdRDaK2cdV19Ux2blrpaHQqtblMFWQZR
X-Google-Smtp-Source: AGHT+IEq4rp5HuD75TmcVUsHuvmf88w/CqhBoW1iucFaZkCbfjFQ5I2ZG/geivWvMnTr6dTh72+hCA==
X-Received: by 2002:a05:6402:40d2:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-608b48c74b6mr2557695a12.5.1749818873294;
        Fri, 13 Jun 2025 05:47:53 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48a876asm1151392a12.4.2025.06.13.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:47:52 -0700 (PDT)
Date: Fri, 13 Jun 2025 05:47:50 -0700
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
Message-ID: <aEwd9oLRnxna97JK@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
 <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>

Hello Willem,

On Thu, Jun 12, 2025 at 10:35:54PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > Add a basic selftest for the netpoll polling mechanism, specifically
> > targeting the netpoll poll() side.
> > 
> > The test creates a scenario where network transmission is running at
> > maximum sppend, and netpoll needs to poll the NIC. This is achieved by:
> 
> minor type: sppend/speed

Thanks! I will update.

> >   1. Configuring a single RX/TX queue to create contention
> >   2. Generating background traffic to saturate the interface
> >   3. Sending netconsole messages to trigger netpoll polling
> >   4. Using dynamic netconsole targets via configfs
> > 
> > The test validates a critical netpoll code path by monitoring traffic
> > flow and ensuring netpoll_poll_dev() is called when the normal TX path
> > is blocked. Perf probing confirms this test successfully triggers
> > netpoll_poll_dev() in typical test runs.
> 
> So the test needs profiling to make it a pass/fail regression test?
> Then perhaps add it to TEST_FILES rather than TEST_PROGS. Unless
> exercising the code on its own is valuable enough.

Sorry for not being clear. This test doesn't depend on any profiling
data. Basically I just run `perf probe` to guarantee that
netpoll_poll_dev() was being called (as that was the goal of the test).

This test is self contained and should run at `make run_test` targets.

> Or is there another way that the packets could be observed, e.g.,
> counters.

Unfortunately netpoll doesn't expose any data, thus, it is hard to get
it. 

I have plans to create a configfs for netpoll, so, we can check for
these numbers (as also configure some pre-defined values today, such as
USEC_PER_POLL, MAX_SKBS, ip6h->version = 6; ip6h->priority = 0, etc.

In fact, I've an private PoC for this, but, I am modernizing the code
first, and creating some selftests to help me with those changes later
(given we have very little test on netpoll, and I aim to improve this,
given how critical it is for some datacenter designs).

> > +NETCONSOLE_CONFIGFS_PATH = "/sys/kernel/config/netconsole"
> > +REMOTE_PORT = 6666
> > +LOCAL_PORT = 1514
> > +# Number of netcons messages to send. I usually see netpoll_poll_dev()
> > +# being called at least once in 10 iterations.
> > +ITERATIONS = 10
> 
> Is usually sufficient to avoid flakiness, or should this be cranked
> up?

10 was the minimum number I was able to trigger it on my dev
environment, either with default configuration and a debug heavy
configuration, but, the higher the number, more change to trigger it.
I can crank up it a bit more. Maybe 20?

> > +def check_traffic_flowing(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> int:
> > +    """Check if traffic is flowing on the interface"""
> > +    stat1 = get_stats(cfg, netdevnl)
> > +    time.sleep(1)
> 
> Can the same be learned with sufficient precision when sleeping
> for only 100 msec? As tests are added, it's worth trying to keep
> their runtime short.

100%. In fact, I don't need to wait for 1 seconds. In fact, we don't
even need to check for traffic flowing after the traffic started. I've
just added it to help me do develop the test.

We can either reduce it to 100ms or just remove it from the loop,
without prejudice to the test itself. Maybe reducing it to 100 ms might
help someone else that might debug this in the future, while just
slowing down ITERATIONS * 0.1 seconds !?

Thanks for the review!
--breno

