Return-Path: <linux-kselftest+bounces-11850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40290691A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BB1C21EB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746813F449;
	Thu, 13 Jun 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lcSy/Oml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE513D529;
	Thu, 13 Jun 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271622; cv=none; b=tFJWmbAMwVaIO4eEFtOCNUD39l1/idpgMk95PAWVE1E5YEXjcUnBS0eIgmGvVGHoWNxqSaa38rnuZBUhPEjxJvLudqj3j3v8pQdYAmn/flK3tjRt+jn/wyJPevXpjstpOJ+ty8R08X8eBadmudHTsCmh1VdDBwnbe7SRqQUi8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271622; c=relaxed/simple;
	bh=vMaFPwlw0HLYH4RGrie7jpHqjxtGpMU+nm3oIZ2lvow=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BecGR2TYdpE44NGugZOtEYLDhBX3LJto+ktGF9q+wKw+oJK1svYHNB0ZeeRN2tOdLeQJnLcF4QZkSa2PY4FclfUssJB7/S5siTnsHL2xY9NBXhQx39wZN880vXJL2kE6npIqSbQaxtIyG8Uai15DotmpIFf836deqmLeqo8ds/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lcSy/Oml; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718271618;
	bh=vMaFPwlw0HLYH4RGrie7jpHqjxtGpMU+nm3oIZ2lvow=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lcSy/OmlmhheqOSRTid2O6w+F/ISxNDi3TeEZG6QZLOnLb9n06ULi7foDiNaym8Oz
	 2evCFFkIasc5tSwR8LYfT7jl6GTtZIQP8qi51e4lvBcVc23SrlZC7lNK56NLX3gSQl
	 Z6ieimKTy5EC3QKCECZ6rdahc0JMZzTsBoHEiIRZgpz4GZLbCJ8X9OIQwAlwZfciIw
	 83wlfix2vMrQc1QXqs0GP8yhjw7wPFQZQoHFMl8IEM5zDsGlbz/R93//THwKEaUhir
	 H5sH+lxNDkUCYK7wt4CZnAsE9a3hgwwTEuDlA2SMj/8LQJkFsZbd7VoZzer+EeqU/4
	 f5+jbkuwO/6AA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC4943781139;
	Thu, 13 Jun 2024 09:40:15 +0000 (UTC)
Message-ID: <ade2de8f-8f63-45fb-a01a-096d048dd971@collabora.com>
Date: Thu, 13 Jun 2024 14:40:52 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kernel@collabora.com,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: kvm: replace exit() with
 ksft_exit_fail_msg()
To: Sean Christopherson <seanjc@google.com>
References: <20240612104500.425012-1-usama.anjum@collabora.com>
 <20240612104500.425012-2-usama.anjum@collabora.com>
 <Zmnwhx0Y0qh0x03J@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Zmnwhx0Y0qh0x03J@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sean,

Thank you for replying in detail. I wasn't aware of true origin of these tests.

On 6/13/24 12:01 AM, Sean Christopherson wrote:
> On Wed, Jun 12, 2024, Muhammad Usama Anjum wrote:
>> The KSFT_FAIL, exit code must be used instead of exit(254).
> 
> This needs more justification.  KVM selftests have worked just fine for 6+ years
> using exit(254), so stating they "must" use KSFT_FAIL is obviously not true.
The selftests scripts read the exit code and mark the test status
pass/fail. Maybe selftests run_tests target isn't being used or this code
path wasn't being triggered.

> 
> I'm not personally opposed to switching to KSFT_FAIL, but it is a potentially
> breaking change.  E.g. some of Google's internal test infrastructure explicitly
> relies on the exit code being 254.  I don't _think_ that infrastructure interacts
> with KVM selftests, nor do I think that forcing upstream KVM selftests to sacrifice
> TAP compliance just to play nice with someone's crusty test infrastructure is a
> good tradeoff, but this and all of the TAP compliance work needs to be done with
> more thought and care.
You have given your perspective from KVM selftest suite perspective. I've
been thinking from kselftests subsystem perspective that how TAP compliance
and exit codes help the entire subsystem. It is understandable from KVM
suite's perspective as not all the suites are compliant and work the same.

> 
>> The 254 code here seems like anciant relic.
> 
> As above, AFAICT it comes from Google's internal test infrastructure (KVM selftests
> came from Google).
> 
>> Its even better if we use ksft_exit_fail_msg() which will print out "Bail
>> out" meaning the test exited without completing. This string is TAP protocol
>> specific.
> 
> This is debatable and not obviously correct.  The documentation says:
> 
>   Bail out!
>   As an emergency measure a test script can decide that further tests are
>   useless (e.g. missing dependencies) and testing should stop immediately. In
>   that case the test script prints the magic words
> 
> which suggests that a test should only emit "Bail out!" if it wants to stop
> entirely.  We definitely don't want KVM selftests to bail out if a TEST_ASSERT()
> fails in one testcase.
But KVM tests are bailing out if assert fails, exit(254) is being called
which stops the further execution of the test cases. It is same as
ksft_exit_fail_msg() behavior.

> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/kvm/lib/assert.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
>> index 33651f5b3a7fd..db648a7ac429b 100644
>> --- a/tools/testing/selftests/kvm/lib/assert.c
>> +++ b/tools/testing/selftests/kvm/lib/assert.c
>> @@ -87,7 +87,7 @@ test_assert(bool exp, const char *exp_str,
>>  
>>  		if (errno == EACCES)
>>  			ksft_exit_skip("Access denied - Exiting\n");
>> -		exit(254);
>> +		ksft_exit_fail_msg("\n");
>>  	}
>>  
>>  	return;
>> -- 
>> 2.39.2
>>
> 

-- 
BR,
Muhammad Usama Anjum

