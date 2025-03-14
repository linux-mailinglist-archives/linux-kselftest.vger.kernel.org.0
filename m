Return-Path: <linux-kselftest+bounces-29107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72BDA61FFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172CB420913
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032F71C6FF7;
	Fri, 14 Mar 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="MgAGO0Uu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC36262BE;
	Fri, 14 Mar 2025 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990430; cv=none; b=q3MGxlkeL5rKhVf73A4GNmbc5eie8B0cOXlGCCecsifvJc88IuOm1HcdSgNYi278S27fH0D68CsC2pGjYoB08yEChtUqpNCkGJ70l5yCpd2HwHZtdtJseKbpy8Ex9TIIepGbASMT1MAnNx8fFogfy9jOXVYtaMdGaESjzY3me5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990430; c=relaxed/simple;
	bh=UITDYVCXqYuE7ynx1X+bmF5r6g/TsOpDW74HJC0XhIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCCqvaspDKvrZXeckf1e8BrQ38bJta6Q90vZjU6tLmOguCFHfGPkK+V0ZIrDO56mzTtfFd/8LMVLKNhzgGyJHtpbMcRnmt9wnaDMwlQOfDlm5xncKBiOPT1p/kvU2sjqintGNaseRPgIAAsI2kIwKBQkqBwcMCppqBWKH2F2Hfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=MgAGO0Uu; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6D6L7jd5ctE2jcaMdejQ4S1lZUd3LdVX6rULsD9OB0U=; b=MgAGO0UuWGUude1+YxpfugaENM
	uroiBD2yehxnxZeGjuduKYXk4xshbhEeoxq67auQ2rcg6wRFS1oeQD2tmRJxFOS63Thv4qxYnvFBG
	pnwgEyoHcSIuRutej8eLbaAH2ofaGELB34P25XVVVDgP0mWldsl807UInQ0jaUwKgtKsHmc0oL8Hf
	l7ZCL4a+wxo3JNM2WhPb7gNNH385tDiAF5cdpchvNQmRwmWmrZryGIX8JAjm7fVzaDiGbiiYKy4d/
	Y3Ir+ltLoHl2mgP3h9NGzzzv+4qsjTN9ue5BoV9a/C68C1e6lD1qeeL1pIAjkssdF/71Gp2f98xeM
	Qr09nYqw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1ttDGg-00EMsv-0q;
	Fri, 14 Mar 2025 17:12:38 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: shuah@kernel.org, Su Hui <suhui@nfschina.com>
Cc: Su Hui <suhui@nfschina.com>, wine-devel@winehq.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH 2/4] selftests: ntsync: avoid possible overflow in 32-bit machine
Date: Fri, 14 Mar 2025 17:12:38 -0500
Message-ID: <1776080.QkHrqEjB74@camazotz>
In-Reply-To: <20250314071454.201697-3-suhui@nfschina.com>
References: <20250314071454.201697-3-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 March 2025 02:14:52 CDT Su Hui wrote:
> When using '-m32' flag  to compile this test with gcc, there are some
> errors when running test:
> 
>  ntsync.c:785:wake_any:Expected ETIMEDOUT (110) == ret (0)
>  ntsync.c:823:wake_any:Expected (1) (1) == __count (0)
>  ...
>  FAILED: 7 / 11 tests passed.
>  Totals: pass:7 fail:4 xfail:0 xpass:0 skip:0 error:0
> 
> There is an overflow about 'timeout'. 'timespec->tv_sec' is 4 bytes in
> 32-bit machine. And 'timeout.tv_sec * 1000000000' causing the overflow
> problem, adding a cast to avoid this problem.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  tools/testing/selftests/drivers/ntsync/ntsync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
> index bfb6fad653d0..ded83dc58e6b 100644
> --- a/tools/testing/selftests/drivers/ntsync/ntsync.c
> +++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
> @@ -103,7 +103,7 @@ static int wait_objs(int fd, unsigned long request, __u32 count,
>  
>  	clock_gettime(CLOCK_MONOTONIC, &timeout);
>  
> -	args.timeout = timeout.tv_sec * 1000000000 + timeout.tv_nsec;
> +	args.timeout = (__u64)timeout.tv_sec * 1000000000 + timeout.tv_nsec;
>  	args.count = count;
>  	args.objs = (uintptr_t)objs;
>  	args.owner = owner;
> @@ -729,7 +729,7 @@ static __u64 get_abs_timeout(unsigned int ms)
>  {
>  	struct timespec timeout;
>  	clock_gettime(CLOCK_MONOTONIC, &timeout);
> -	return (timeout.tv_sec * 1000000000) + timeout.tv_nsec + (ms * 1000000);
> +	return ((__u64)timeout.tv_sec * 1000000000) + timeout.tv_nsec + (ms * 1000000);
>  }
>  
>  static int wait_for_thread(pthread_t thread, unsigned int ms)
> 

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>



