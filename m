Return-Path: <linux-kselftest+bounces-15176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1894F7FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA781F21996
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47464193069;
	Mon, 12 Aug 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KTShQkic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA3186E5C;
	Mon, 12 Aug 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493609; cv=none; b=GWPnufTpBuHOrOsZ07k6B1zAipDW2gaLKR5/s2ETxU42M0OOvCcjp3NCphQRC2QXN4E+j8sr4Y3RFIhy2u0IWEO+xj02OBlqNDVm4fSOZYB3pAtdKCaY01/BsoEHYuSILe4fjobO07d7dkCgABASqVK7DeKOWFHiCI3Fj/tWFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493609; c=relaxed/simple;
	bh=ryRIWMCMOIf7AI2hLWpZSWxhpmfeK5FKuJP+6ERD7J0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YouDx+PsxkPJvah9t9Ba4o1NXw2pFVsE9t7/Ln26Vs+0Jbhl++H5EHyGdaGSJ/WobQozrOgxCyMlPI1x82GuEsCRbQ7fMI6iQCvZFl3qqeja0MAyOCH7XY0FreptdN40y8EkanASsbZIuEaj+j+pQ6SLTvzxzMKlWOwAJVgwSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KTShQkic; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723493607; x=1755029607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s3dYEvupaKjUrQXVsYWre/xbQJlOysr0E/ytP1MYS+c=;
  b=KTShQkiczXDiKDPS/O6rcqArViTJyZ0NerWWDbZFLcAeAXByDkIgQy0T
   3FmNOxmLB13a8jKduOpHtLGchszyl3R6lu2+9P31TPNxv+BBisqbiHSJ/
   eU8BShc2OmNfxOB0QNdLC2TBgli0CYjwtye52JyeDtCC7TCrLbw4CBNVV
   4=;
X-IronPort-AV: E=Sophos;i="6.09,284,1716249600"; 
   d="scan'208";a="224908182"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 20:13:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:54559]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.82:2525] with esmtp (Farcaster)
 id 50319a02-cdfd-4706-a685-282106658347; Mon, 12 Aug 2024 20:13:24 +0000 (UTC)
X-Farcaster-Flow-ID: 50319a02-cdfd-4706-a685-282106658347
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 20:13:24 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 20:13:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jain.abhinav177@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>,
	<javier.carrasco.cruz@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH net v2] selftest: af_unix: Fix kselftest compilation warnings
Date: Mon, 12 Aug 2024 13:13:06 -0700
Message-ID: <20240812201306.70769-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812191122.1092806-1-jain.abhinav177@gmail.com>
References: <20240812191122.1092806-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Abhinav Jain <jain.abhinav177@gmail.com>
Date: Tue, 13 Aug 2024 00:41:22 +0530
> Change the parameter expected_buf from (const void *) to (const char *)
> in the function __recvpair() as per the feedback in v1.
> Add Fixes tag as per feedback in v1.
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
> v1:
> lore.kernel.org/netdev/20240810134037.669765-1-jain.abhinav177@gmail.com
> 
> Fixes: d098d77232c3 ("selftest: af_unix: Add msg_oob.c.")
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

No need to respin, but a minor comment below for the future patches.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

> ---

You can put changelog between revisions after "---" so that it will
disappear during merge.

And, it would be easy to jump to v1 if it has https:// .

Here's a nice example:

https://docs.kernel.org/process/maintainer-netdev.html#changes-requested

Thanks!

