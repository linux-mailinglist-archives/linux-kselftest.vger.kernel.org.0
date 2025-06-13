Return-Path: <linux-kselftest+bounces-34906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A126BAD8D6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1692C3A7FB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5422F17A316;
	Fri, 13 Jun 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/vlDZO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BD111BF;
	Fri, 13 Jun 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822219; cv=none; b=pQtVs7mcra3dJexSdqi54mBicaqjqb+X6SlbJfCF0DRugzrCGCnbmLLAYiuO92n3lqmP9KppWh0jAkoIajPY/1aRiV3SPRZuh8zVNEZqQgP0JQDlpkGaaCB573FWv7v9cuBinMu/xS2hj8KCkj/pW3Q6TMZd+9n7PUgetLRrYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822219; c=relaxed/simple;
	bh=KZ8V03W9AMSS/ZrJN6Tc1lj0hBTtN9vN9Uigrs3yZ3Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=s0aqjLnju5DwfEzaY0b6I2at+Ec/ZR4gAZ3RI40cBpkyfztE6ANt06jXj+jmZpVLGBVrjLeZn8EC0eYluTGOlw1m4mqkBDzSwymuuoJCMkf3hvT+mL2j9SQPEgYxHJA2LCNDzVan7J39w/VA0rFgRzDFhuciv/F4xDwSaG6Pwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/vlDZO0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-710f39f5cb9so20830027b3.3;
        Fri, 13 Jun 2025 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822216; x=1750427016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox3E9dQ67FbqXqAnvQO795RQbhpNGDVUFih1Lflr29A=;
        b=j/vlDZO0PdG6zIR8guhdW8Rnp5bHjcd2aMc9WYS8KNqRofX5NWVdlvV2rwMFrCP1YK
         yVAchWUj0YBGhXf94mMxLBuyV5sNopV/vmv+L+gVn3Kco7AKcsiAuoEj5+zv/2DiqdN2
         16sWE9y2V/12AwajlmTjFjOwH63/aC9f1dgYijlIFfmSYr0QiGvRJlxZ23k58+EYJeTy
         3hI/Lhnih0dd4IrMmFdbwhKxg7SSi3iGUOA1QnmO+PUfEQK1Q4GGQdugbY2MLqIuWVt3
         1/L3R9qCpjzBVCJtKZH+7X2rSrB6/6frBO4TEp5+QAwT7SA9YKx/DCKTcYAB4QRmREDL
         WreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822216; x=1750427016;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ox3E9dQ67FbqXqAnvQO795RQbhpNGDVUFih1Lflr29A=;
        b=MnytL88jU+EhZzwPsGjNFKMcNetkauhn2QiBji9m98o2BasGegR2ntNjMG95mkLJLE
         ZRnLjb0FRPUJ/JglUyI8hb4FqOD0UIdVA2kZzG6x+K8CgwYWC8y7+gyvYHmiSWdTRLnT
         njvp/PqVO4u1GwlHyTq4Zz4aSixmsSH1HYteoVXn+SVq21U25/gEcqG7FPjmRornA/ci
         nGEGJsFqohtA8NyQ713lFzUo6dvSsV4zKT6+9DzhtkCDs6Ea24eoJ2doBK+V+oVvAPs7
         KammVVUMEq2vfi7wE7ba9FRatBaI3X1AV0Bbvmc4Q4cap6Rlvvfs1ODass5Bqe+vStom
         qNOg==
X-Forwarded-Encrypted: i=1; AJvYcCUtxeNVOeLupAuzEe7cMLyQCo7Ur8mPWYp8CG0M/4hMDUPi3oVCVzyw9LINNHqadvSY0FG7OWlJ@vger.kernel.org, AJvYcCWrKAz3MQQIUmtKuSXkmfSg0nKQe4j88kON9YjKkAOIYz+tdRVteYRgqJ5Qp1r4pNrQdHOJAoh8fd2RgtwqAn5k@vger.kernel.org, AJvYcCXe9xY+ug6EoIwQ6wf8eXMEv9tGkY6mOPdChnF74W6+1eRMsYN+paKD/aQi6iDSdcs9Q9d4NRozqFzByoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuC1blLOjB4NhV4BN1upIiffRnBQcCEw+lcpUDB82Z+1ZznOfV
	HfvbLy36VuiHNpzTzsusDxqnsP9ccA09HbtyLKoTiC5Sk6pJAJGMxql3
X-Gm-Gg: ASbGncuKb03M1sZZtkqp4zm2MvptcisHIDgd0TBLuVoi/JuK73rZlxhtFlNueTLWpVP
	gSAIJKCGfbDwesnfpcT4YqrqI+orYvdfCEg1YW2g07q7cwHj0a4QWRujSfQ9+IKe5EEdxKiYzvD
	uvcnOLBsVrMHghtBzv/Go4ptkL//a9BCBWJzHQBamE89rPTGezt71KTLp6xiflsCDTZSzYx69Kw
	ZX/8HL+/TZEZPnIaUUM5Ekz8E4gp4cQsu/FFUur5x8hWJdPSo8Nh3RkyaeQE7Smy67lOfD3eCvl
	DUj1GQPOOXmC6onoVV1nnO+X3buja4AMPvffHTrJ+pdaoyXpEfMVomomCP6/Tn3lcpzkQasCVRr
	zMdyO/MtCuu5ebZS9ORGFA3gYklfsVzbaVb8vjFSOVg==
X-Google-Smtp-Source: AGHT+IEbD4QsQkLlqlVlhfEq0zqhzfDi3PWNPwwOqa42u0o9X1ZYKAWtGJroQ5rtRtkrC07DcFZxMw==
X-Received: by 2002:a05:690c:9c13:b0:710:f025:4077 with SMTP id 00721157ae682-7116370c74amr48799327b3.2.1749822216318;
        Fri, 13 Jun 2025 06:43:36 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71152091490sm6424747b3.48.2025.06.13.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:43:35 -0700 (PDT)
Date: Fri, 13 Jun 2025 09:43:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 ast@kernel.org
Message-ID: <684c2b0770919_10740f29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <aEwd9oLRnxna97JK@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
 <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
 <aEwd9oLRnxna97JK@gmail.com>
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Hello Willem,
> 
> On Thu, Jun 12, 2025 at 10:35:54PM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > Add a basic selftest for the netpoll polling mechanism, specifically
> > > targeting the netpoll poll() side.
> > > 
> > > The test creates a scenario where network transmission is running at
> > > maximum sppend, and netpoll needs to poll the NIC. This is achieved by:
> > 
> > minor type: sppend/speed
> 
> Thanks! I will update.
> 
> > >   1. Configuring a single RX/TX queue to create contention
> > >   2. Generating background traffic to saturate the interface
> > >   3. Sending netconsole messages to trigger netpoll polling
> > >   4. Using dynamic netconsole targets via configfs
> > > 
> > > The test validates a critical netpoll code path by monitoring traffic
> > > flow and ensuring netpoll_poll_dev() is called when the normal TX path
> > > is blocked. Perf probing confirms this test successfully triggers
> > > netpoll_poll_dev() in typical test runs.
> > 
> > So the test needs profiling to make it a pass/fail regression test?
> > Then perhaps add it to TEST_FILES rather than TEST_PROGS. Unless
> > exercising the code on its own is valuable enough.
> 
> Sorry for not being clear. This test doesn't depend on any profiling
> data. Basically I just run `perf probe` to guarantee that
> netpoll_poll_dev() was being called (as that was the goal of the test).
> 
> This test is self contained and should run at `make run_test` targets.
> 
> > Or is there another way that the packets could be observed, e.g.,
> > counters.
> 
> Unfortunately netpoll doesn't expose any data, thus, it is hard to get
> it. 
> 
> I have plans to create a configfs for netpoll, so, we can check for
> these numbers (as also configure some pre-defined values today, such as
> USEC_PER_POLL, MAX_SKBS, ip6h->version = 6; ip6h->priority = 0, etc.
> 
> In fact, I've an private PoC for this, but, I am modernizing the code
> first, and creating some selftests to help me with those changes later
> (given we have very little test on netpoll, and I aim to improve this,
> given how critical it is for some datacenter designs).
> 
> > > +NETCONSOLE_CONFIGFS_PATH = "/sys/kernel/config/netconsole"
> > > +REMOTE_PORT = 6666
> > > +LOCAL_PORT = 1514
> > > +# Number of netcons messages to send. I usually see netpoll_poll_dev()
> > > +# being called at least once in 10 iterations.
> > > +ITERATIONS = 10
> > 
> > Is usually sufficient to avoid flakiness, or should this be cranked
> > up?
> 
> 10 was the minimum number I was able to trigger it on my dev
> environment, either with default configuration and a debug heavy
> configuration, but, the higher the number, more change to trigger it.
> I can crank up it a bit more. Maybe 20?
> 
> > > +def check_traffic_flowing(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> int:
> > > +    """Check if traffic is flowing on the interface"""
> > > +    stat1 = get_stats(cfg, netdevnl)
> > > +    time.sleep(1)
> > 
> > Can the same be learned with sufficient precision when sleeping
> > for only 100 msec? As tests are added, it's worth trying to keep
> > their runtime short.
> 
> 100%. In fact, I don't need to wait for 1 seconds. In fact, we don't
> even need to check for traffic flowing after the traffic started. I've
> just added it to help me do develop the test.
> 
> We can either reduce it to 100ms or just remove it from the loop,
> without prejudice to the test itself. Maybe reducing it to 100 ms might
> help someone else that might debug this in the future, while just
> slowing down ITERATIONS * 0.1 seconds !?

That makes sense. Or only keep it in DEBUG mode?


