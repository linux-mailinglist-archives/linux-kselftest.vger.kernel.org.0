Return-Path: <linux-kselftest+bounces-17161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61AD96C5A3
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C221F267B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450CC1E1A1D;
	Wed,  4 Sep 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cBNOiJ+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191031E1A1F;
	Wed,  4 Sep 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471952; cv=none; b=LmqosLGwlo/YS8ceObCkK2Y1VNF59SIeEFnBPIiBN5SJEwxi9sLcEAw8xfBCjUtTMKE6PiLDYSgGRxhxTU6rQVN7N3IXS4X9p3qJ9EUYD4IvZHpzgjz/hFGozah+oYZa2nQrkOdgGt7Fs1RUlS+pwnV0ZYQbpv/5wQzQNJi6sZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471952; c=relaxed/simple;
	bh=3ms+jmuZkq1vsb7bH0gsZ6GDHGRGTlXNsNd5RcimIQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/abD6tHoIlYMjhTkWXoBj5SBrjs69aspdgDWYQbCeJFlh/mPwQPmkYRzJWue9KujMWJAoJhSPX83uPc/8TxcFi7pq+rDTvzbN9RzWXwRuZauqSTA120rd8ov3FD1RJz5uhq1Sqem89VF0uJMiJbGLCrAjGzk3k0/AZdXhtH7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cBNOiJ+A; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725471950; x=1757007950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gCznZJcAGWMZfA5ynzwOCCLPb1jqxTZUYJFGAHQI7Mk=;
  b=cBNOiJ+ALWO7rZJlpRgJQN/UxJbvj960dCU2JfSyPISoHzXMLZfly/KH
   7+FaCs6wdzcMUh5Rty+PI27N+ezGSUek7gTHqlCsEa7IfJxVx62vadhR4
   pmXxDv7FFEMidbwjHxMRwEaVXhMsI2sVUlxFcwVfBXKGbEQp9KKIBB4ZU
   w=;
X-IronPort-AV: E=Sophos;i="6.10,202,1719878400"; 
   d="scan'208";a="122216293"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 17:45:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:33566]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.127:2525] with esmtp (Farcaster)
 id fde1a5a7-7b36-447f-b1ca-fad1670c5454; Wed, 4 Sep 2024 17:45:47 +0000 (UTC)
X-Farcaster-Flow-ID: fde1a5a7-7b36-447f-b1ca-fad1670c5454
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Sep 2024 17:45:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Sep 2024 17:45:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jamie.bainbridge@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <joannelkoong@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH net] selftests: net: enable bind tests
Date: Wed, 4 Sep 2024 10:45:33 -0700
Message-ID: <20240904174533.8070-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
References: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Wed,  4 Sep 2024 16:12:26 +1000
> bind_wildcard is compiled but not run, bind_timewait is not compiled.
> 
> These two tests complete in a very short time, use the test harness
> properly, and seem reasonable to enable.
> 
> The author of the tests confirmed via email that these were
> intended to be run.
> 
> Enable these two tests.
> 
> Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
> Fixes: 2c042e8e54ef ("tcp: Add selftest for bind() and TIME_WAIT.")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  tools/testing/selftests/net/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 8eaffd7a641c5d6bb5c63e3015fdd9f32c114550..9d5aa817411b653ac130a1a581d933180a597ce5 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -85,7 +85,8 @@ TEST_GEN_PROGS += so_incoming_cpu
>  TEST_PROGS += sctp_vrf.sh
>  TEST_GEN_FILES += sctp_hello
>  TEST_GEN_FILES += ip_local_port_range
> -TEST_GEN_FILES += bind_wildcard
> +TEST_GEN_PROGS += bind_wildcard
> +TEST_GEN_PROGS += bind_timewait
>  TEST_PROGS += test_vxlan_mdb.sh
>  TEST_PROGS += test_bridge_neigh_suppress.sh
>  TEST_PROGS += test_vxlan_nolocalbypass.sh
> -- 
> 2.39.2
> 

