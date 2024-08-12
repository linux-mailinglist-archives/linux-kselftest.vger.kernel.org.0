Return-Path: <linux-kselftest+bounces-15168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D884494F6CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 20:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C9285FA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D7C189B8C;
	Mon, 12 Aug 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PrgVCLF/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBC17A584;
	Mon, 12 Aug 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488001; cv=none; b=GHb607QZLBunb2ZxkOr1Sj4hEK51AM+RKgbnJX197G4QqG4YfpAkZ/B3MRKpu2u5gx7m/i7i5qTP29KlDJbcOVob3jebtFiD00p5djip9cXA/Rhh4NZyFWo4iLQEooCrFkAXeqmMaWhtyOR9sGOPhAppndysLGoG+mzhaFyna5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488001; c=relaxed/simple;
	bh=hLPS2eeLbacCeDfQdas8OaO5alGg1xd9KieoKImfa0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRve6wO9CSZX+IYyUSb/UUhB/EcW2Eo7HNuy4VSrXJNLreKpjg7gLoBmmbGUdMjAgex0aUGONurT5w9uHC71LeuIa5zXXp6OOgGny4eLSX8TFSZ+FO7tqc0YGPREqa09lXyHa/wkX4xsSKC0sq+brebgkoW1DATxKdpMOJSFoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PrgVCLF/; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723488000; x=1755024000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TsKRs/tU1C7lyHz4zW8SHtDYXaLJ8JdBh1WrHkGGBk8=;
  b=PrgVCLF/vAyZ8qXVx5k7XrqBTjUyJEE5c/D6DyL9HeOFo+mnTPG+P53q
   6sy8lf5Z4oggrZGhr1bfpOcIdT1VBHUWRXy2sXBVA7PaKTcCsbNpMYQsH
   tvcHpqfisjl57tLH+GPy/bRngHm9+VnHwdtt5T7V2YLG9SAJjIouZaIwR
   4=;
X-IronPort-AV: E=Sophos;i="6.09,283,1716249600"; 
   d="scan'208";a="361879517"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:39:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:2345]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.243:2525] with esmtp (Farcaster)
 id a734b439-3f9a-4de8-8c2c-222296eb6e51; Mon, 12 Aug 2024 18:39:56 +0000 (UTC)
X-Farcaster-Flow-ID: a734b439-3f9a-4de8-8c2c-222296eb6e51
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 18:39:55 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 18:39:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jain.abhinav177@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>,
	<javier.carrasco.cruz@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH net] selftest: af_unix: Fix kselftest compilation warnings
Date: Mon, 12 Aug 2024 11:39:44 -0700
Message-ID: <20240812183944.59844-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240810134037.669765-1-jain.abhinav177@gmail.com>
References: <20240810134037.669765-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Abhinav Jain <jain.abhinav177@gmail.com>
Date: Sat, 10 Aug 2024 19:10:37 +0530
> Add proper type cast (char *) to the buffer being passed to TH_LOG
> macro in __recvpair function.
> 
> This change fixes the below warnings during test compilation:
> 
> ```
> In file included from msg_oob.c:14:
> msg_oob.c: In function ‘__recvpair’:
> 
> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
> of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]
> 
> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
> msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
> 
> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
> of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]
> 
> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
> msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
> ```
>

Fixes: tag is needed here (no space between SOB tag)

> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  tools/testing/selftests/net/af_unix/msg_oob.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
> index 16d0c172eaeb..66d76ab38251 100644
> --- a/tools/testing/selftests/net/af_unix/msg_oob.c
> +++ b/tools/testing/selftests/net/af_unix/msg_oob.c
> @@ -232,7 +232,8 @@ static void __recvpair(struct __test_metadata *_metadata,
>  
>  	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
>  		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
> -		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
> +		TH_LOG("Expected:%s",
> +				expected_errno ? strerror(expected_errno) : (char *)expected_buf);
>  
>  		ASSERT_EQ(ret[0], expected_len);
>  		ASSERT_EQ(recv_errno[0], expected_errno);

I don't remember why I defined expected_buf as (void *), but more simple
fix would be the following ?

---8<---
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..535eb2c3d7d1 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -209,7 +209,7 @@ static void __sendpair(struct __test_metadata *_metadata,
 
 static void __recvpair(struct __test_metadata *_metadata,
 		       FIXTURE_DATA(msg_oob) *self,
-		       const void *expected_buf, int expected_len,
+		       const char *expected_buf, int expected_len,
 		       int buf_len, int flags)
 {
 	int i, ret[2], recv_errno[2], expected_errno = 0;
---8<---

Thanks!

