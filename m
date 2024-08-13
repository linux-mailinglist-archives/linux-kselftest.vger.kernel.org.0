Return-Path: <linux-kselftest+bounces-15264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AADA950D13
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 21:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD4B286058
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B621A4F10;
	Tue, 13 Aug 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cSQEfELJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A601A3BBC;
	Tue, 13 Aug 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576980; cv=none; b=n4p+IxzSHFKu8+vAijNdvPY2jMcDhaKlg2AFxqMQOD8+ixIgS6tbpN+1fgIdgwdfXSZiHLwLFd/DGeb3/p+ko2ATPuuqNI5SqSr4OrmeAS7hc9lpIEYBo1x39OwKBn8LtmNIrY8EAQgsFX6mcZEo9uSDbxcoahy4nrw7nQTMbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576980; c=relaxed/simple;
	bh=S8IgRoT3rGuUs3Taam7C7rdBtNX5Ws5CvI6Kh7gN94I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0886aCVpkkOLbvIuP5hCqHm2f+eaJY5QQcqNxJ/qSs2iZjt1VH/LiV7zW/VMmmexH/kzAI5EHCL68OxuzWQyJAqo1f4Zh27xTFCKfBgb7X5L9avxDoLVlqIsYE/fqsnYgz93d2rTYG5UxVJdQZ74TPUdrVe29Vls5df2eNLhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cSQEfELJ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723576979; x=1755112979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVY6McdLttZ/ks3QIA7dtEO+Q6+G94A3MUcoEqmhLGE=;
  b=cSQEfELJ/yRjSK7qxWh3Y7Rc36IhC0izowZIhG/plN99TGqK0XMTMT6a
   hL2Wr2nRVtmv/I17RiWbHfopC/T+JsV9zo9smYjSbE+iDYWcmJlgfVKHE
   FkHB4UyOrjXUQ1SA311jqNfAsRXDFOrgXuYLzDSec0SH9cJnwx/ZHMEyV
   8=;
X-IronPort-AV: E=Sophos;i="6.09,286,1716249600"; 
   d="scan'208";a="18728270"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 19:22:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:26393]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.30:2525] with esmtp (Farcaster)
 id 76dc4125-4df1-46d0-8c75-88bd9d7740c6; Tue, 13 Aug 2024 19:22:54 +0000 (UTC)
X-Farcaster-Flow-ID: 76dc4125-4df1-46d0-8c75-88bd9d7740c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 19:22:53 +0000
Received: from 88665a182662.ant.amazon.com (10.119.205.65) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 13 Aug 2024 19:22:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mtodorovac69@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH v2 1/1] selftests: net: af_unix: convert param to const char* in __recvpair() to fix warning
Date: Tue, 13 Aug 2024 12:22:41 -0700
Message-ID: <20240813192241.11560-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240813162004.2464421-3-mtodorovac69@gmail.com>
References: <20240813162004.2464421-3-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Mirsad Todorovac <mtodorovac69@gmail.com>
Date: Tue, 13 Aug 2024 18:20:06 +0200
> GCC 13.2.0 reported warning about (void *) being used as a param where (char *)
> is expected:
[...]
> As Simon suggested, all calls to __recvpair() have char * as expected_buf param, so
> it is safe to change param type from (const void *) to (const char *), which silences
> the warning.
> 
> Fixes: d098d77232c37 ("selftest: af_unix: Add msg_oob.c.")
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>

Usually Reported-by is not needed if it's same with SOB.

and the same feedback to v1.

Abhinav posted a fix earlier.

https://lore.kernel.org/netdev/20240812191122.1092806-1-jain.abhinav177@gmail.com/

Thanks

