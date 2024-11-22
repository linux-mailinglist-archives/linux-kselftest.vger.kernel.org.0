Return-Path: <linux-kselftest+bounces-22454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D43459D6110
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 16:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE5FB26F78
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E881DE8B0;
	Fri, 22 Nov 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="h1JWM7+T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAC13A3E4;
	Fri, 22 Nov 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287703; cv=none; b=kio79y0h/GfCZkdysogz8xh9KxTQ+9mBIQRmtq38w+FKkU19e4k2mDG/uVwcJP0Z3yj/fsYUPg8FzC5AlGQ5g+WnMigmlgPz+f17/ARni+wlTZJ3f6DZQrBa2Nz39kamba5qCm0qrX+6q2lw8IXGj/+ZkCvB2sJBjDref5conMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287703; c=relaxed/simple;
	bh=q5clxXL+rrB2Qa/SClfsFnrpas8q0UVgr5ltbgUhIWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd5Mu1jMmZbs+Rs7Uj8sXXjYLztEWh7f/SZbKLci1fe3l0pym4k+bU3AR+8jxiJEhEgle/C+16tC7jsNIG5nHZDeKm3dIupru2KhcC/bnLvOl7iOMd/nu/AvUpysppaqH3KwVo6XWhHzMIAayR/MTcAJWOJjZvGay1tCvdNJA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=h1JWM7+T; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1732287701; x=1763823701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XhEkPlJOEC4ipBCKHrvl3bqgRsZel/0/VfceNqNLM5U=;
  b=h1JWM7+TOxSMTH4iI1gwdyDKduDyJAOV3Ae3mGZ//zx9kXlbgoPhEJkM
   2JYJk6wt0EtdupZFOHPUUqBQ24NobHvoVI2tZUB+y2NYcHULNDjT0EBv+
   2DWMbXwKA4x4AVyAj6aIGIzTxm/SossHhWc883Eo4+dz1S9X4rN5cLl/E
   c=;
X-IronPort-AV: E=Sophos;i="6.12,176,1728950400"; 
   d="scan'208";a="675868813"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:01:34 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:63119]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.62:2525] with esmtp (Farcaster)
 id d7fa063a-9d11-47ba-bfb7-1ba007f2778f; Fri, 22 Nov 2024 15:01:34 +0000 (UTC)
X-Farcaster-Flow-ID: d7fa063a-9d11-47ba-bfb7-1ba007f2778f
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 22 Nov 2024 15:01:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 22 Nov 2024 15:01:30 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 22 Nov 2024 15:01:30 +0000
Received: from dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com (dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com [10.253.68.42])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id D954340529;
	Fri, 22 Nov 2024 15:01:29 +0000 (UTC)
Received: by dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com (Postfix, from userid 5466572)
	id 98B25B449; Fri, 22 Nov 2024 15:01:29 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:01:29 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, Allison Henderson
	<allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Vegard Nossum
	<vegard.nossum@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: rds: move include.sh to TEST_FILES
Message-ID: <20241122150129.GB18887@dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com>
References: <20240927041349.81216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240927041349.81216-1-liuhangbin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Hangbin,

On Fri, Sep 27, 2024 at 12:13:49PM +0800, Hangbin Liu wrote:
> The include.sh file is generated for inclusion and should not be executable.
> Otherwise, it will be added to kselftest-list.txt. Additionally, add the
> executable bit for test.py at the same time to ensure proper functionality.
> 
> Fixes: 3ade6ce1255e ("selftests: rds: add testing infrastructure")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/rds/Makefile | 3 ++-
>  tools/testing/selftests/net/rds/test.py  | 0
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py
> 
> diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
> index da9714bc7aad..cf30307a829b 100644
> --- a/tools/testing/selftests/net/rds/Makefile
> +++ b/tools/testing/selftests/net/rds/Makefile
> @@ -4,9 +4,10 @@ all:
>  	@echo mk_build_dir="$(shell pwd)" > include.sh
>  
>  TEST_PROGS := run.sh \
> -	include.sh \
>  	test.py

Should test.py also move down to TEST_FILES? I think run.sh is executing
test.py anyway but does a couple of sanity checks before, so I think
this it's not necessary to let the runner execute test.py standalone.

>  
> +TEST_FILES := include.sh
> +
>  EXTRA_CLEAN := /tmp/rds_logs
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
> old mode 100644
> new mode 100755
> -- 
> 2.39.3 (Apple Git-146)
> 

Thanks,
Max



Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


