Return-Path: <linux-kselftest+bounces-13453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800C292CE52
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA461F24FF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D540118FA21;
	Wed, 10 Jul 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dXBVre5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288118FA18;
	Wed, 10 Jul 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604272; cv=none; b=PLo50SBl7GDbdtaQdOzXiM4cHk18tIFx7Yu6OiDHpTsAthiAkssr5H5o31beqigHwN5lFY6fRbri3C7+2ArOwfnG705fPXAt9RI8/2CC0zIu1J4OKKBFK3TCZcTq3f96NXWPW2hyI6LuT9nJF1uDWkMih14DupG+KScU52hujXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604272; c=relaxed/simple;
	bh=l0InjUn+r9qMZLELw7DvorDCNWscZsq07ZH4vjQNSpo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CtPjjvGr1cmp15M4PF439Ob56sWmRj+quTjwHw224CUNDVBvQ5Hnhg4I+gghwor60qUo9bAgXk9WcI0HgGxF2BIhKCUzfgnOYjznsxEkcmWiVfSRJwrdimQMIF+VBNvPjZu54XEjC65zC7Gu0kRA8dLMZJ9TBjjYz6YAJmUulQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dXBVre5y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720604269;
	bh=l0InjUn+r9qMZLELw7DvorDCNWscZsq07ZH4vjQNSpo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dXBVre5y+Yvxx3PzpkRSgBvm+9evADx4Ie/OjSZOjTSMNHhYvUWcC4x1oQjt/kjdK
	 GP4uaFZm1bHDzjIXj9IBZILXkf9a60jxtHP0ynAts7SBBNCnO1VnDvr3Cz7jT5e15R
	 WDQQwHXswZlCMJtBspdPA5AQG8BG9wYvbXx1ERH5bSZdLwFYvCTdVN3RgVk5C6MtDr
	 aNu5mIzltQQzPxwfUPLW07s3VVsY2YYc/OcFHY2Fe2vduU/vbilwcF5edI6J9bcLul
	 rATfWGU0+/40CL45Pzze7vYFTTI5/dcGMpQqsoofO8gcJROBUj96yyf7IWDg1v17qq
	 Mi+P0N4Fr996Q==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 742213782192;
	Wed, 10 Jul 2024 09:37:39 +0000 (UTC)
Message-ID: <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
Date: Wed, 10 Jul 2024 14:37:26 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
 <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch brings just readability implements by using kselftests wrappers
instead of manual pass/fail test cases counting. It has been on mailing
list from several months now. Please can someone ack or nack?

On 7/1/24 1:38 PM, Muhammad Usama Anjum wrote:
> Adding more reviewers. Please review.
> 
> On 5/28/24 10:05 AM, Muhammad Usama Anjum wrote:
>> Kind reminder
>>
>> On 4/26/24 3:18 PM, Muhammad Usama Anjum wrote:
>>> Conform the layout, informational and status messages to TAP. No
>>> functional change is intended other than the layout of output messages.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - No changes, sending it again as got no response on v1 even after weeks
>>> ---
>>>  tools/testing/selftests/x86/vdso_restorer.c | 29 +++++++++------------
>>>  1 file changed, 12 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
>>> index fe99f24341554..f621167424a9c 100644
>>> --- a/tools/testing/selftests/x86/vdso_restorer.c
>>> +++ b/tools/testing/selftests/x86/vdso_restorer.c
>>> @@ -21,6 +21,7 @@
>>>  #include <unistd.h>
>>>  #include <syscall.h>
>>>  #include <sys/syscall.h>
>>> +#include "../kselftest.h"
>>>  
>>>  /* Open-code this -- the headers are too messy to easily use them. */
>>>  struct real_sigaction {
>>> @@ -44,17 +45,19 @@ static void handler_without_siginfo(int sig)
>>>  
>>>  int main()
>>>  {
>>> -	int nerrs = 0;
>>>  	struct real_sigaction sa;
>>>  
>>> +	ksft_print_header();
>>> +	ksft_set_plan(2);
>>> +
>>>  	void *vdso = dlopen("linux-vdso.so.1",
>>>  			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>>>  	if (!vdso)
>>>  		vdso = dlopen("linux-gate.so.1",
>>>  			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>>>  	if (!vdso) {
>>> -		printf("[SKIP]\tFailed to find vDSO.  Tests are not expected to work.\n");
>>> -		return 0;
>>> +		ksft_print_msg("[SKIP]\tFailed to find vDSO. Tests are not expected to work.\n");
>>> +		return KSFT_SKIP;
>>>  	}
>>>  
>>>  	memset(&sa, 0, sizeof(sa));
>>> @@ -62,21 +65,16 @@ int main()
>>>  	sa.flags = SA_SIGINFO;
>>>  	sa.restorer = NULL;	/* request kernel-provided restorer */
>>>  
>>> -	printf("[RUN]\tRaise a signal, SA_SIGINFO, sa.restorer == NULL\n");
>>> +	ksft_print_msg("Raise a signal, SA_SIGINFO, sa.restorer == NULL\n");
>>>  
>>>  	if (syscall(SYS_rt_sigaction, SIGUSR1, &sa, NULL, 8) != 0)
>>>  		err(1, "raw rt_sigaction syscall");
>>>  
>>>  	raise(SIGUSR1);
>>>  
>>> -	if (handler_called) {
>>> -		printf("[OK]\tSA_SIGINFO handler returned successfully\n");
>>> -	} else {
>>> -		printf("[FAIL]\tSA_SIGINFO handler was not called\n");
>>> -		nerrs++;
>>> -	}
>>> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>>>  
>>> -	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
>>> +	ksft_print_msg("Raise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
>>>  
>>>  	sa.flags = 0;
>>>  	sa.handler = handler_without_siginfo;
>>> @@ -86,10 +84,7 @@ int main()
>>>  
>>>  	raise(SIGUSR1);
>>>  
>>> -	if (handler_called) {
>>> -		printf("[OK]\t!SA_SIGINFO handler returned successfully\n");
>>> -	} else {
>>> -		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
>>> -		nerrs++;
>>> -	}
>>> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>>> +
>>> +	ksft_finished();
>>>  }
>>
> 

-- 
BR,
Muhammad Usama Anjum

