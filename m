Return-Path: <linux-kselftest+bounces-7183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F64898664
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224182847FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273284A3E;
	Thu,  4 Apr 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w4lYWrL7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F160745C3;
	Thu,  4 Apr 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231351; cv=none; b=Jeg/o7vGtFJL8/1sghmDi6LLW85evpnGqvTevvXBIeDTLGSwVvSF4aqi8crunxduP9sLyWC8rXBkj+Y09BHIr3gCCKJZAVkZuwIU6NFUnarEv+klroOikDlg50WBeSPlvlb42DgbLs/6oNU4q1da0gqJcr0+bxP1dWjn2+cL3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231351; c=relaxed/simple;
	bh=BWoUsoa5YB4lhI10K0YeWtvCr1zRzQPNRlj6UNtfjfo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mmYeXSOqG53+nQFFMV7VNSIn2Bw1bmyBTg4MPk1B+oHmNVsa9WrloAT1KL8DrPiqkYuwmwwVDsXEY/2TT8JHeN+JXu2xi4ZDsfYHAHBWS2vX0iz20o+rxuZvurytTUMRwFvSKh9DJ7gTcWolb7rIn/Ij+ckpt0bvnogBe0QyXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w4lYWrL7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712231348;
	bh=BWoUsoa5YB4lhI10K0YeWtvCr1zRzQPNRlj6UNtfjfo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=w4lYWrL79dG6OT+yr360jTrTlooYPA9oOV0lcECKbTzYDAVM+u5a0HQrWoOLK2HsJ
	 fzzzaSOcSvvoDCPuDpY1ADsCeyzTo782fbYliQoEpXqqxPI4J7PBzSBlwvTDWbQ3/t
	 FgHLGVifUo/umZKeb79LHvaTN6j38cEMx1zAP/ZWMGUZU2VCtezsJiAH2t0JNRL9aE
	 +WOtaRU043PRLXGF+o4bw/UNWZ7oJP2Z+oEYgkpmoYE6fgyFZdC6Za6+MebykW9KSf
	 Ro89hmvOcVMNAKGquCziwN/KtX57SMBPVIUi3+oWgVrXmdyvDaWnmQwR2XVQ4xNZmG
	 CP/vgvBOfiAzQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6FFC5378200D;
	Thu,  4 Apr 2024 11:49:07 +0000 (UTC)
Message-ID: <7942f5b1-4712-4350-8d3f-d06f7be65fde@collabora.com>
Date: Thu, 4 Apr 2024 16:49:39 +0500
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
 <3c3b8d18-7f52-4914-8a1e-8e32b4dd8b20@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <3c3b8d18-7f52-4914-8a1e-8e32b4dd8b20@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 3/25/24 12:07 PM, Muhammad Usama Anjum wrote:
> Soft reminder
> 
> On 3/7/24 11:37 PM, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/x86/vdso_restorer.c | 29 +++++++++------------
>>  1 file changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
>> index fe99f24341554..f621167424a9c 100644
>> --- a/tools/testing/selftests/x86/vdso_restorer.c
>> +++ b/tools/testing/selftests/x86/vdso_restorer.c
>> @@ -21,6 +21,7 @@
>>  #include <unistd.h>
>>  #include <syscall.h>
>>  #include <sys/syscall.h>
>> +#include "../kselftest.h"
>>  
>>  /* Open-code this -- the headers are too messy to easily use them. */
>>  struct real_sigaction {
>> @@ -44,17 +45,19 @@ static void handler_without_siginfo(int sig)
>>  
>>  int main()
>>  {
>> -	int nerrs = 0;
>>  	struct real_sigaction sa;
>>  
>> +	ksft_print_header();
>> +	ksft_set_plan(2);
>> +
>>  	void *vdso = dlopen("linux-vdso.so.1",
>>  			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>>  	if (!vdso)
>>  		vdso = dlopen("linux-gate.so.1",
>>  			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>>  	if (!vdso) {
>> -		printf("[SKIP]\tFailed to find vDSO.  Tests are not expected to work.\n");
>> -		return 0;
>> +		ksft_print_msg("[SKIP]\tFailed to find vDSO. Tests are not expected to work.\n");
>> +		return KSFT_SKIP;
>>  	}
>>  
>>  	memset(&sa, 0, sizeof(sa));
>> @@ -62,21 +65,16 @@ int main()
>>  	sa.flags = SA_SIGINFO;
>>  	sa.restorer = NULL;	/* request kernel-provided restorer */
>>  
>> -	printf("[RUN]\tRaise a signal, SA_SIGINFO, sa.restorer == NULL\n");
>> +	ksft_print_msg("Raise a signal, SA_SIGINFO, sa.restorer == NULL\n");
>>  
>>  	if (syscall(SYS_rt_sigaction, SIGUSR1, &sa, NULL, 8) != 0)
>>  		err(1, "raw rt_sigaction syscall");
>>  
>>  	raise(SIGUSR1);
>>  
>> -	if (handler_called) {
>> -		printf("[OK]\tSA_SIGINFO handler returned successfully\n");
>> -	} else {
>> -		printf("[FAIL]\tSA_SIGINFO handler was not called\n");
>> -		nerrs++;
>> -	}
>> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>>  
>> -	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
>> +	ksft_print_msg("Raise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
>>  
>>  	sa.flags = 0;
>>  	sa.handler = handler_without_siginfo;
>> @@ -86,10 +84,7 @@ int main()
>>  
>>  	raise(SIGUSR1);
>>  
>> -	if (handler_called) {
>> -		printf("[OK]\t!SA_SIGINFO handler returned successfully\n");
>> -	} else {
>> -		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
>> -		nerrs++;
>> -	}
>> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>> +
>> +	ksft_finished();
>>  }
> 

-- 
BR,
Muhammad Usama Anjum

