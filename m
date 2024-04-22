Return-Path: <linux-kselftest+bounces-8614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438AB8ACCD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E40B23DC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81297145342;
	Mon, 22 Apr 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gBA6MnRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9A13D623;
	Mon, 22 Apr 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789458; cv=none; b=jYJwZMAdATsUoOjX/5INbrI0tpHRArmS9TSmC8qsTQIDesQULaRrV65mN+mudwyaB7ui/CAQM51jqjhpmubUOEU8TfHLef2iuAqtRulIvuqHsWiHxjxNoVzBkdNElht7ncCO7rdlVjafbhRCS6tL1MxXI6YDcvt2XCr2qw5JgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789458; c=relaxed/simple;
	bh=nKi3nDBQfqTD2aouZarLfxHKW8Nu4xjaj/P4r3wdh1I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a9myEw+e4hmmuUbIMI8o7wo9VE2Io1aJ8D+fQkH9v8MKY2sTpCHU60NkO4Gu4mTPwyKv9zFUjYOyOwSNM50hfpZeR5hu0GfVk2a0l6h44tbmR75YeUVzGBpFfXnqePwuTYA5H+bnwhCt54uefC7LzRXbnbvc274C+LbcedukhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gBA6MnRY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713789455;
	bh=nKi3nDBQfqTD2aouZarLfxHKW8Nu4xjaj/P4r3wdh1I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gBA6MnRYR/R/xlDKV/1GJQyeDQDcN2hVUmtmjdo2LA03yMYEgmax83ytGK8M5dMWj
	 Fzsh5IadF+jxiJqp79KFR9VrR5cO/XIqx9p7RjEbbQhCEp2ldGe0OSKE/xHabI/8kR
	 26ottZjMIymtuxHA7eDhNj7PXXdxNdBNDcatSufrMxWLhkq3Q1WZmuV7Z315eJNs1U
	 NQ1auEOw8uOGc6ETrcPNl/Vke+aFP+IeWWlKhwNwoMc2TTC3rpB1o4bPpMCNsuO70T
	 J7+oX4rgA4e7gfIZ5BcgyWsXOh3e19ffx0XAmJHurWHSsUP+bT+JSXPHdLs8mLLXNS
	 xelRXKOkAY5iw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 923C337820C2;
	Mon, 22 Apr 2024 12:37:32 +0000 (UTC)
Message-ID: <10950830-3e85-45cd-b668-060fad942ae4@collabora.com>
Date: Mon, 22 Apr 2024 17:38:02 +0500
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
 <9aed3669-559b-4b9f-a1b5-0349463739d6@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9aed3669-559b-4b9f-a1b5-0349463739d6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reminder

On 4/14/24 6:21 PM, Muhammad Usama Anjum wrote:
> Soft reminder for this patch
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

