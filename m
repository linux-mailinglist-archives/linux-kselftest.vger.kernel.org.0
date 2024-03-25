Return-Path: <linux-kselftest+bounces-6529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399D88A117
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 14:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700C71C380F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD799171E51;
	Mon, 25 Mar 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j22xJ/w6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619937319F;
	Mon, 25 Mar 2024 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350404; cv=none; b=o4Eeob5Z+IMjaGjxGyY+iK6LdZbwO+wrB6H/SBNepBPPEnjQ3rTuJqW7mTmoIDmy8ngXzoFwJX4EBGn5F7JOM51B2I5znb2ElgpTjCwCxAJNBWTpmHQITF24VSDfpIHcCmIZYRCY9MlaY8hxQ2NISh0tXTxViwAAJDJjnvUN9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350404; c=relaxed/simple;
	bh=2BI+P40kX8mCNe18wq2erATH2487oY9xn8frIy2QuAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MuT+YYKiHIvxgZPVtvlAeuhWR2uJGWB2LF8siTRyN5Tt55dSsk21Qd63WwjK11F6zz9PgAWMVNGZEFN8UqBPgwFAY3QglL2C+OkZZwifDveH9e8IW9kIju3fFmIqvFiqRl2bYW+hObQGoLshmByKrfVQZDxei6uido78/DbEec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j22xJ/w6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711350400;
	bh=2BI+P40kX8mCNe18wq2erATH2487oY9xn8frIy2QuAY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=j22xJ/w676BIdvmye1gkOBURBDit3tPNtdL2O6CbIZ0Wqm1JX5xZ96yz7/DKqz1Z/
	 MGiMSZdVvO/4aO66fShJrOMoy4yvVnms7+90f9GavTydIJ4wvZqAJgeDrVS1bg9/K1
	 vWpMTV8PwnlojLL/wHGL7bncTDrfBuulQVYeKEIlo8kMFtJYiFN64k+SbsIXHpUMaj
	 sa1ATVHWT6R1uLT+DnIRg9X4Q1+pmJa8wULt6c4ZOiKh/UXpXeHI84LD1b2Sli9dlD
	 Ja3C/K4HrQ54Uvgl+ezdS1EwAQuiTOo+iBrjt0YyiJUp6S2SeMIVWsSH5YbJ0+z7Qe
	 eAeLkYXDtPsMw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 43BC3378148F;
	Mon, 25 Mar 2024 07:06:37 +0000 (UTC)
Message-ID: <3c3b8d18-7f52-4914-8a1e-8e32b4dd8b20@collabora.com>
Date: Mon, 25 Mar 2024 12:07:13 +0500
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
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>
References: <20240307183708.2857513-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240307183708.2857513-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

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

