Return-Path: <linux-kselftest+bounces-13452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5492CE43
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129C11C2273A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA95A17FD;
	Wed, 10 Jul 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BPOuGWKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65684E0D;
	Wed, 10 Jul 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604131; cv=none; b=SW/BkWvmcPfzpaFhlKGuXxSzPmY4msYKRmBm2O182XxOxD40SvgqxSSEMkHWIIUaUoBqmymubO1qEI8I8b+ifYGcHkwqCFaxZQyQxmuxrmpFLYCrr4ojRZ0sHumFS5Wt0eob0eQrfPFtB3wmfBKy0Ur6vejjQ/Aiz4VV/G6YkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604131; c=relaxed/simple;
	bh=xjDv/a9AfKrRSeQV89Csz9I6G8Pym2b21m4TyF8lKIU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fN/nWNu5u3+xj1DJs8E3EgehLiPEpXaOB39f6XWyaw1ZT7m8p5ZBeIz2FanPQDZVYHge7Ps1JUoKBYeZ3awyYcU3mkkyUJp6/2BYtYvAa9LIwTIMo4wTI6ukk43o86uTPRD7+coA16cQQG08JSLp8llasNlo8KYVOkWzewKuwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BPOuGWKp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720604128;
	bh=xjDv/a9AfKrRSeQV89Csz9I6G8Pym2b21m4TyF8lKIU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BPOuGWKpLXOcYQYR95ixbG4bjZHSX5RfjC8mkxcTkODMzxgLC+5qXLreQbU2vROt2
	 5COhggXbbdE1ClHe6rkx9WdXfJmlUS1cnMnjc2D4lc3Uf43sYQv4KcvYl9URm2SmLI
	 W1GNve70XYOQ2+myKopYCJ/Pu8qwkiBB1DxR5tbSgz00MM9UNtq+b87ECaVcAzMywm
	 csmci0VmOmgBgCpDh4wNojo8zH9wsaoSIa58nGfsCUZQaP1UcV4Brl8oaCgA4Sy500
	 +yMRudV0Px2OFNz8z5ymrlXDGGkSWzJzmoK7LTXFiIS4ws5su8Qfdq+MgNlelcPhAW
	 Ek61oRi7hRPSA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD0BD3782192;
	Wed, 10 Jul 2024 09:35:18 +0000 (UTC)
Message-ID: <0ce9ef47-a655-492d-b8ae-39341d2ef076@collabora.com>
Date: Wed, 10 Jul 2024 14:35:04 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP
 output
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kunwu Chan <chentao@kylinos.cn>, Mark Brown <broonie@kernel.org>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
 <599d722c-6d34-42dd-bdfd-5cc862d1c8b4@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <599d722c-6d34-42dd-bdfd-5cc862d1c8b4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kind reminder.

This two patch series is removing a script which was marking test pass/fail
by adding pass/fail logic inside the test itself.

On 7/1/24 1:40 PM, Muhammad Usama Anjum wrote:
> Soft reminder
> 
> On 6/2/24 6:24 PM, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/arm64/tags/tags_test.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
>> index 955f87c1170d7..8ae26e496c89c 100644
>> --- a/tools/testing/selftests/arm64/tags/tags_test.c
>> +++ b/tools/testing/selftests/arm64/tags/tags_test.c
>> @@ -17,19 +17,21 @@ int main(void)
>>  	static int tbi_enabled = 0;
>>  	unsigned long tag = 0;
>>  	struct utsname *ptr;
>> -	int err;
>> +
>> +	ksft_print_header();
>> +	ksft_set_plan(1);
>>  
>>  	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
>>  		tbi_enabled = 1;
>>  	ptr = (struct utsname *)malloc(sizeof(*ptr));
>>  	if (!ptr)
>> -		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
>> +		ksft_exit_fail_perror("Failed to allocate utsname buffer");
>>  
>>  	if (tbi_enabled)
>>  		tag = 0x42;
>>  	ptr = (struct utsname *)SET_TAG(ptr, tag);
>> -	err = uname(ptr);
>> +	ksft_test_result(!uname(ptr), "Syscall successful with tagged address\n");
>>  	free(ptr);
>>  
>> -	return err;
>> +	ksft_finished();
>>  }
> 

-- 
BR,
Muhammad Usama Anjum

