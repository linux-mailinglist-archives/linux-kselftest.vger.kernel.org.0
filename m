Return-Path: <linux-kselftest+bounces-15169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5D94F6E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 20:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4778B1C21B5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2818C330;
	Mon, 12 Aug 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="feUxoO/M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693E2B9B7;
	Mon, 12 Aug 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488356; cv=none; b=tu6HsFIYwXZqWMwiHUYQRBUEGwBFuphZrtjbb56XIugrcygGvREaCPpdQUpy+cwswqAp7Rtf4WSiK8puGqUPquTMvXtAsbKGXbB7GyRT683cRWbf57JwIZS1W58sDAW8H9/kkgPGBo/SLwcCgsEvn6ME2u02u9UeqbT1qu5tmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488356; c=relaxed/simple;
	bh=TR9nm8qypj66rgyu/7tTWyN3lIGveJ1wdSlfjYIj1uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZS9bsWyz2ht5jcwv+TCEmsrtW1EN9hJMJ5ZxMjdThDCY8rD4sI8zUz7on8M2vJ52bjRQkwCkZzsBRtR9GPutRkvAxumKiTrQPo4syim/uju/M2KfpDLejCrMfE7HVjjJCwrYRn1RU7e6385zKdcuieAb91F7KFRKTYqfC4VrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=feUxoO/M; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723488356; x=1755024356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vZiDuPYpb58bPwU+I9LWgQyOBzqpwIr01DUBTsMb5eo=;
  b=feUxoO/MY7kYHZug1NVXsKV50V97+LTLHllB/TQZxEBu95KGuVbwZjqo
   IThY8IXdSdOPCsRsnfFo3vL0DCFGp7x1PZA55m+R5p4I0UFEM7jBXMtNa
   Jk4lSnXYzg69AWtC2FBgDO67LmCPYqqG7AS0LRlODTuvyzzXCJd+ij/7W
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,283,1716249600"; 
   d="scan'208";a="673462861"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:45:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:50457]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.236:2525] with esmtp (Farcaster)
 id c93f32e9-5893-4d1e-b1f8-7cefa3a997c6; Mon, 12 Aug 2024 18:45:51 +0000 (UTC)
X-Farcaster-Flow-ID: c93f32e9-5893-4d1e-b1f8-7cefa3a997c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 18:45:50 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 18:45:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mtodorovac69@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <jain.abhinav177@gmail.com>
Subject: Re: [PATCH v1 1/1] selftests: net: af_unix: cast void* to char* in call to macro TH_LOG()
Date: Mon, 12 Aug 2024 11:45:40 -0700
Message-ID: <20240812184540.60174-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812002257.23447-2-mtodorovac69@gmail.com>
References: <20240812002257.23447-2-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Mirsad Todorovac <mtodorovac69@gmail.com>
Date: Mon, 12 Aug 2024 02:22:58 +0200
> GCC 13.2.0 reported warning about (void *) beeing used as a param where (char *) is expected:
> 
> In file included from msg_oob.c:14:
> msg_oob.c: In function ‘__recvpair’:
> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
> 							but argument 6 has type ‘const void *’ [-Wformat=]
>   106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
>       |                                        ^~~~~~~~~~~~~
> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
>   101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
>       |                 ^~~~~~~~
> msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’
>   235 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
>       |                 ^~~~~~
> ../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument of type ‘char *’,
> 							but argument 6 has type ‘const void *’ [-Wformat=]
>   106 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
>       |                                        ^~~~~~~~~~~~~
> ../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
>   101 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
>       |                 ^~~~~~~~
> msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
>   259 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
>       |                 ^~~~~~
> 
> Casting param to (char *) silences the warning.
> 
> Fixes: d098d77232c37 ("selftest: af_unix: Add msg_oob.c.")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>

Thanks for the patch!

but I found the same patch posted a bit earlier here,
and Abhinav will post v2.

https://lore.kernel.org/netdev/20240810134037.669765-1-jain.abhinav177@gmail.com/

