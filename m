Return-Path: <linux-kselftest+bounces-15686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD7957426
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389F7284183
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA01D54E6;
	Mon, 19 Aug 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WsoMoYRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730126AD3;
	Mon, 19 Aug 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094441; cv=none; b=IaPYun+3NhvN+VmVlyWVw6nOksf3EqnHJKL7+R/7/vnBxrIKWADQUN0vpiPkRPeX+ojHpDJ7IY27UIGaGyocZMD4Xuvch2D/QAVUr5JXNauZvYgbnIiVXBnlwPaWnFS6sqMIAOADLPWqNyPVU2GJsHNONZEbX40xPlL/ZqFt1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094441; c=relaxed/simple;
	bh=bt42UqfBxqgqyY5wR6uAz2vGGnxhK928PpdeZzLAk4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDTiWeVAzCRIB8b+oDCv/ZW7Ea06swrD6kDiDcUlUxTsPG21v1Q9m0UgoA8oEemCL3eoRRtwa5P8e0rNSDmxiOLDo6hDB4M6dpj6g45cjaJyBUHfkzljWaAElhyA/+kOh2w5XOgwfyOq6fDB1OB5tCzaxqFbEzap6u5WcWn8Q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WsoMoYRg; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724094440; x=1755630440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRr3Q0af9dLwiv6Jedl/iB/rxkkLw+gkIXPbHxR1vPc=;
  b=WsoMoYRg9jyDEcimrd+nbjHa+jvey9T3qE2zy8r/VOznj9LW8noU/nQz
   LQXv1h/zFJst9owzy+9eiuiWedTFPtmfO6M8+3scHvyodYtCs13McOX5s
   AhTHteCnqxYXw39ugOEBp721+BPVD62ivJbzTdGCEqAM6PBWUoKeK6iEj
   g=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; 
   d="scan'208";a="19819003"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 19:07:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:62802]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.61:2525] with esmtp (Farcaster)
 id 7b1dbc00-8fff-41c1-a735-77696693fc96; Mon, 19 Aug 2024 19:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: 7b1dbc00-8fff-41c1-a735-77696693fc96
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 19:07:15 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 19:07:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dan.carpenter@linaro.org>
CC: <bpf@vger.kernel.org>, <kuniyu@amazon.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [bug report] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Mon, 19 Aug 2024 12:07:04 -0700
Message-ID: <20240819190705.23030-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a063a534-0ccf-4192-a15a-732a73dbcbd0@stanley.mountain>
References: <a063a534-0ccf-4192-a15a-732a73dbcbd0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 19 Aug 2024 21:57:57 +0300
> On Mon, Aug 19, 2024 at 09:54:00PM +0300, Dan Carpenter wrote:
> > Hello Kuniyuki Iwashima,
> > 
> > Commit a74712241b46 ("selftest: bpf: Test
> > bpf_sk_assign_tcp_reqsk().") from Jan 15, 2024 (linux-next), leads to
> > the following Smatch static checker warning:
> > 
> > 	tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c:493 tcp_validate_cookie()
> > 	warn: off by one 'mssind' == ARRAY_SIZE()?
> > 
> > ./tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> >     462 static int tcp_validate_cookie(struct tcp_syncookie *ctx)
> >     463 {
> >     464         u32 cookie = bpf_ntohl(ctx->tcp->ack_seq) - 1;
> >     465         u32 seq = bpf_ntohl(ctx->tcp->seq) - 1;
> >     466         u64 first = 0, second;
> >     467         int mssind;
> >     468         u32 hash;
> >     469 
> >     470         if (ctx->ipv4)
> >     471                 first = (u64)ctx->ipv4->saddr << 32 | ctx->ipv4->daddr;
> >     472         else if (ctx->ipv6)
> >     473                 first = (u64)ctx->ipv6->saddr.in6_u.u6_addr8[0] << 32 |
> >     474                         ctx->ipv6->daddr.in6_u.u6_addr32[0];
> >     475 
> >     476         second = (u64)seq << 32 | ctx->tcp->source << 16 | ctx->tcp->dest;
> >     477         hash = siphash_2u64(first, second, &test_key_siphash);
> >     478 
> >     479         if (ctx->attrs.tstamp_ok)
> >     480                 hash -= ctx->attrs.rcv_tsecr & COOKIE_MASK;
> >     481         else
> >     482                 hash &= ~COOKIE_MASK;
> >     483 
> >     484         hash -= cookie & ~COOKIE_MASK;
> >     485         if (hash)
> >     486                 goto err;
> >     487 
> >     488         mssind = (cookie & (3 << 6)) >> 6;
> >     489         if (ctx->ipv4) {
> >     490                 if (mssind > ARRAY_SIZE(msstab4))
> >                                    ^
> > Should be >= instead of >.
> > 
> >     491                         goto err;
> >     492 
> > --> 493                 ctx->attrs.mss = msstab4[mssind];
> >     494         } else {
> >     495                 if (mssind > ARRAY_SIZE(msstab6))
>                                      ^
> 
> Here too, I guess.

Thanks for reporting.

Will fix it.

But I'm curious why BPF verifier couldn't catch it.


