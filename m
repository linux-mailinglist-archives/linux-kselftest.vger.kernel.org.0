Return-Path: <linux-kselftest+bounces-13543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6192DFE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462FB1F23375
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF4824AD;
	Thu, 11 Jul 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ObQI8iew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146362904;
	Thu, 11 Jul 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678444; cv=none; b=eNB4FocezdxVkh3tZU53a283JyIqb14IbbgNWUOD3KZyW+KJ7IGNwkvfdGxtfmT5lYQMLzkt9WbpImh9lbh8gWvsuYBhpAP98ldV3Rl5WpTg6M6b7Vb3PnFOmxsOV4czt0bSKGG/mURqzwQ4CsSs7gq7/ExLiRHYv/w0OAnY8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678444; c=relaxed/simple;
	bh=8xOtfjRCFwwGZhvnaP6AiSa3qARQWMU1DF/LrcXXNb8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Caa1fDev+Kf6sfVokwJjmDmJ8fN6W4iz7NYpjCKMPdht0itSF0LrZQ/ckXB11jnBzT9tIEVXcCufyLgF0T0OE8KN7Iz/I5ozpIt/xxNcCQqeny4tVHqodnRhbsGumNg8Ox3t/drKGcCQfHE2K5Mb/oyQWX5klxjAWrsoUoWlhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ObQI8iew; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720678441;
	bh=8xOtfjRCFwwGZhvnaP6AiSa3qARQWMU1DF/LrcXXNb8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ObQI8iewCADPzrhA10Qv1xzWJ0KXCVDEm/sRnWgyTipZXXZo4UN7jtD5oajZEHZDU
	 BR7DHkgA1LLqCdn66iN3lK0WVNhtu+CoU6G4Sov9RmpGwV47QWutVuqsJmZLY5ghuU
	 ntpft6dFqmtc8nuE0mnrcSKsb3dsfMkJmJeKiIVZasSWSnKDbHui6B/RnQPSStaDOo
	 qf5GwYA7yb7YiZPCbiANURBBoyyURzLx8amy9WZ67C9IEpEtd+Hu175ORz7BRx1Htt
	 Ei18khgpvhhfmDGinB4ryoc3gZC36D+VT4Gl85fJlACmiBy7rEB7QeDwgoUwKhT644
	 w6FwkcfnnTe7w==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0242137821E5;
	Thu, 11 Jul 2024 06:13:56 +0000 (UTC)
Message-ID: <f052afb8-abca-4279-8186-05df35044bdd@collabora.com>
Date: Thu, 11 Jul 2024 11:13:54 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Kunwu Chan <chentao@kylinos.cn>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP
 output
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
 <Zo5xCW9GJqFeTZUi@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Zo5xCW9GJqFeTZUi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 4:31 PM, Catalin Marinas wrote:
> On Sun, Jun 02, 2024 at 06:24:59PM +0500, Muhammad Usama Anjum wrote:
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
> Sorry, these patches slipped through the cracks. We seem to be pretty
> inconsistent with using ksft_exit_fail_perror() and ksft_finished(). Is
> there some plan to update the rest or is it only this location that you
> came across?
Ideally we would want that all the test are updated to output better logs
than what they have currently. We may update some more tests. This is
something we want the maintainers to get aware of that kselftest.h wrapper
provide helper function to better write the tests and then all contributors
start using it in new tests and older tests may also get updated in the
process.

> 
> Adding Mark Brown as well to this thread, he's been contributing quite a
> lot recently to the arm64 kselftests.
> 

-- 
BR,
Muhammad Usama Anjum

