Return-Path: <linux-kselftest+bounces-7923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685E8A4291
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003931F21271
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC3381B9;
	Sun, 14 Apr 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QRuJ30Wo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39718AF4;
	Sun, 14 Apr 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100872; cv=none; b=h7dAakDvwKPsSofbzyTApX1fV2VyKBciQwjIDHJEQ2JjIrYTxAN6IvrQcgz0Q7OFyAUlOLnAFoLBIfgKXiy7iy55rqQFueyY+65tM6niRvzjXAReWAt1XhS0fka1VM0uttGvhhPB+t1qpOoLtbGbf1B2HghkMSvorn8v8JffiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100872; c=relaxed/simple;
	bh=jHXX78g0PUcFPTft7N6jU+LV2sfeTt381GBHdR61JkI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J7A+Zfsd4aSNs1OY+96Y75ltt4LNXl0Zuhj8uu2nlN4sX8vwWTI+U6c3MGupduAwJ4c8dAr/7vBOeNYvlxMlFRWStNyMhvLisPKVCX0Wdh3aPvQ+XrSsANNO2vHTMZVXGb8QuJ+lGf2orKMkz41P4vISDrvp0unwIs3HCc6x4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QRuJ30Wo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713100869;
	bh=jHXX78g0PUcFPTft7N6jU+LV2sfeTt381GBHdR61JkI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QRuJ30WoBokygCT1hKjupeUCWUwyA1j3Jd1NQmN8N/BOGd0CbSjYL22Fn2CgKlSOS
	 Xd+GEDmnHmZWKTTCkgs3LxcxMFC2oOgnwudCdGv5q8LslXmeWJICyV0uD48pwT1t8T
	 OBa2/4I4HE/biNrmOX6b2NDPu1Y7CydC3Vr+mxOVOQKony/wIYlVn655PDogeIcAUr
	 h6mXXKqepw2PH0+eeLxhtCO72BXOmAfdfHUvCAJ0PZ8YXbH/LGc9Hp2QZK/CtrMiBe
	 pKbQ9ox6U3OeodrttXmftLK+UX1LbMHhGfl62Q9eQ1b89Gxav+9v+St+A8cZFe8l4Y
	 nmoY5JRMNLbEw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E37BF37811CE;
	Sun, 14 Apr 2024 13:21:06 +0000 (UTC)
Message-ID: <9aed3669-559b-4b9f-a1b5-0349463739d6@collabora.com>
Date: Sun, 14 Apr 2024 18:21:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: x86: conform test to TAP format output
To: Shuah Khan <shuah@kernel.org>
References: <20240307183708.2857513-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240307183708.2857513-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder for this patch

On 3/7/24 11:37 PM, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/x86/vdso_restorer.c | 29 +++++++++------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
> index fe99f24341554..f621167424a9c 100644
> --- a/tools/testing/selftests/x86/vdso_restorer.c
> +++ b/tools/testing/selftests/x86/vdso_restorer.c
> @@ -21,6 +21,7 @@
>  #include <unistd.h>
>  #include <syscall.h>
>  #include <sys/syscall.h>
> +#include "../kselftest.h"
>  
>  /* Open-code this -- the headers are too messy to easily use them. */
>  struct real_sigaction {
> @@ -44,17 +45,19 @@ static void handler_without_siginfo(int sig)
>  
>  int main()
>  {
> -	int nerrs = 0;
>  	struct real_sigaction sa;
>  
> +	ksft_print_header();
> +	ksft_set_plan(2);
> +
>  	void *vdso = dlopen("linux-vdso.so.1",
>  			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>  	if (!vdso)
>  		vdso = dlopen("linux-gate.so.1",
>  			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>  	if (!vdso) {
> -		printf("[SKIP]\tFailed to find vDSO.  Tests are not expected to work.\n");
> -		return 0;
> +		ksft_print_msg("[SKIP]\tFailed to find vDSO. Tests are not expected to work.\n");
> +		return KSFT_SKIP;
>  	}
>  
>  	memset(&sa, 0, sizeof(sa));
> @@ -62,21 +65,16 @@ int main()
>  	sa.flags = SA_SIGINFO;
>  	sa.restorer = NULL;	/* request kernel-provided restorer */
>  
> -	printf("[RUN]\tRaise a signal, SA_SIGINFO, sa.restorer == NULL\n");
> +	ksft_print_msg("Raise a signal, SA_SIGINFO, sa.restorer == NULL\n");
>  
>  	if (syscall(SYS_rt_sigaction, SIGUSR1, &sa, NULL, 8) != 0)
>  		err(1, "raw rt_sigaction syscall");
>  
>  	raise(SIGUSR1);
>  
> -	if (handler_called) {
> -		printf("[OK]\tSA_SIGINFO handler returned successfully\n");
> -	} else {
> -		printf("[FAIL]\tSA_SIGINFO handler was not called\n");
> -		nerrs++;
> -	}
> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>  
> -	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
> +	ksft_print_msg("Raise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
>  
>  	sa.flags = 0;
>  	sa.handler = handler_without_siginfo;
> @@ -86,10 +84,7 @@ int main()
>  
>  	raise(SIGUSR1);
>  
> -	if (handler_called) {
> -		printf("[OK]\t!SA_SIGINFO handler returned successfully\n");
> -	} else {
> -		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
> -		nerrs++;
> -	}
> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
> +
> +	ksft_finished();
>  }

-- 
BR,
Muhammad Usama Anjum

