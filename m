Return-Path: <linux-kselftest+bounces-12991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59891DA1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD71C20FC7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66F824B1;
	Mon,  1 Jul 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SxVZ78Im"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0F9476;
	Mon,  1 Jul 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823139; cv=none; b=Ty9ZBJsdT2px3iD8TduWxQgpT7hKk364tj6iZPsUPstDOGUDhJTr1Lz1QkeGMhFRICD0Iq4kZ04gow3kU39HPeOy7TWbFSZCEuaaRG4Cx5LTWPsEsuhyJ03h4pWFI1lZ6Z4iAvzpNCnl85xh5nfuewwZAANiAEGUJZP4UOD+c2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823139; c=relaxed/simple;
	bh=SdxKnkKGiusNAYtdZL1hgEgV8CCDoKezaLYbvDMFgoM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mo3s6T9Iw4h6foKXN117pAl8FD2xkla94+BVU4Yz+FUFekH3ZoS2DxHsJG5uLqHZKOxQPkH29q4cUYnlnFRgsJ/q4kcYuvE7BsgNesjDOVwYjRIUSmRLZbaHOsBlznKezG83/Y/eLiDAQ4ePWceqcExW4+vdHRRvWxMct1HxzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SxVZ78Im; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719823136;
	bh=SdxKnkKGiusNAYtdZL1hgEgV8CCDoKezaLYbvDMFgoM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SxVZ78ImFExqoNADaLkjy1bK+BUtKdFUFlfkm01cIPX1rudxlKNSGO6mQfEN8FFWW
	 nMKj8btE5fin7l6zqdqYaK1poCdJVPzrmPhY8x0ZXNzpTqTxJrjaSgWRbVLcpkUeW8
	 rENxYk3rY259wJxSWRnHjAdUglCHJmuOXlAnUTNl42ImNr1m2USTzOGIZPI8LzHcsM
	 28kRUADesFMV+oRs3Nnp0kdKIawoVZD+YqJ2hfsTrv1Stqvvfozd3FpQSxmeYG3C/t
	 z5YIq1g0GHzHK/re5IxPiFwWaW6gDVbqsRpnZhhbhG99B9el9ckPozkMOBkYAOg3wf
	 PmgqhK4/lc0zg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EB5BD3782109;
	Mon,  1 Jul 2024 08:38:51 +0000 (UTC)
Message-ID: <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
Date: Mon, 1 Jul 2024 13:38:45 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding more reviewers. Please review.

On 5/28/24 10:05 AM, Muhammad Usama Anjum wrote:
> Kind reminder
> 
> On 4/26/24 3:18 PM, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - No changes, sending it again as got no response on v1 even after weeks
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

