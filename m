Return-Path: <linux-kselftest+bounces-15687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13E95743C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2322829B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F01D6DBD;
	Mon, 19 Aug 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PT7sjT0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C07175D46;
	Mon, 19 Aug 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094870; cv=none; b=HxuWvq8nVBJYx6WavJ1hiaXGUfsYqblTFDrrpDLz+pGDp5+UVh6W/38w+0TpHx3F4sd1nerJZTMcUO0Qm7BEA/RND8RjC1wz0WD9aT9CWl4HI9JPzGiTLLA3EnerHG8InxtrmuvFpjDPSYXprtVYjW+0ZZn4NvveWjzqxNReXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094870; c=relaxed/simple;
	bh=W/VyUOPRM0LnMR38irwj5tTiltknby85KxxzLwDLO5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQhUEDPIwLGuHtUp5eO+rr7vnNYLVr/mbBxjH3B1TJVWTdq8rmYMzEvOuqsI++crMDZHSLdnxhs2kZChsPERt1XMSzgnzswBELP2JZXUt4p/99JLBpXoaQe9sgw4bNWlu3NYtdsVy1Ka7/2am+Sf6nQAFhMPnAEi0XwtDCFOOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PT7sjT0D; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724094868; x=1755630868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W50UB2NiWcbz6XYLm/ZODvE3j7l39JJLW9jpwLMYPqQ=;
  b=PT7sjT0D4U2mSjZrJPR8VLD+XuDusE5hcCWsp2VdJ94v0EnSnhK3BvFp
   efaxdwpuqv7EFuJWq2fEUEOE6v2IoH0Yi6EGXnbKWhxs2hf8+4G8ieuzS
   gnRDwHwBolE+sHq65FmEVitLl9AhiCvN27ews7bBUPuGQunlZw7KNHX4i
   o=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; 
   d="scan'208";a="674760078"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:14:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:45218]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.29:2525] with esmtp (Farcaster)
 id 5043fab3-598c-4765-8d5e-f71565221264; Mon, 19 Aug 2024 19:14:24 +0000 (UTC)
X-Farcaster-Flow-ID: 5043fab3-598c-4765-8d5e-f71565221264
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 19:14:23 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 19:14:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <bpf@vger.kernel.org>, <dan.carpenter@linaro.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [bug report] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Mon, 19 Aug 2024 12:14:13 -0700
Message-ID: <20240819191413.23841-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819190705.23030-1-kuniyu@amazon.com>
References: <20240819190705.23030-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 19 Aug 2024 12:07:04 -0700
> > >     488         mssind = (cookie & (3 << 6)) >> 6;
> > >     489         if (ctx->ipv4) {
> > >     490                 if (mssind > ARRAY_SIZE(msstab4))
> > >                                    ^
> > > Should be >= instead of >.
> > > 
> > >     491                         goto err;
> > >     492 
> > > --> 493                 ctx->attrs.mss = msstab4[mssind];
> > >     494         } else {
> > >     495                 if (mssind > ARRAY_SIZE(msstab6))
> >                                      ^
> > 
> > Here too, I guess.
> 
> Thanks for reporting.
> 
> Will fix it.
> 
> But I'm curious why BPF verifier couldn't catch it.

Ok, this off-by-one report is false-positive as the test has

  mssind = (cookie & (3 << 6)) >> 6;

and the following (mssind > ARRAY_SIZE()) is just to make verifier happy.

