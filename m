Return-Path: <linux-kselftest+bounces-14915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C03949FA5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 08:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926071C20B1A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D919D098;
	Wed,  7 Aug 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="FwvCYAMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B019D081;
	Wed,  7 Aug 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010946; cv=pass; b=YMgLnGYCLZwoWo6fOKtGs/X3girljah6CapW1rGY3mel4bhIUjS1mRKfthoju7DAKt9baA0Ls1tT6vgXd7rrARRfjySspTwlhVZAQ7ouLWXhDFvpg8HU31snwhf3DD4QSVkKPoyF3ZJGAReeriG+M86Qi69mA6iOVe2y6+/ExAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010946; c=relaxed/simple;
	bh=zqix6/Y9EAnHCD78hNdu6wnaiC7NJWBNTLc/qLIXYdA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eeCpDRxm11XkF1oPL31R9RY+BGXItOcyFDCslLBOOaAk7KEGsDTok0T99R3JEnP9oVUNFLaRTwZTPumMwr1G92dVVf0NN83vlgidBCYPyG75+Mox6dm8ActfrrNj4ZRJKQi6ypY+Jo5yjVZ/7iVpbiWj+52UXRkRf1YMLxX0zDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=FwvCYAMx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723010932; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BJGi0Yr1kJwYlWqEqTxxQWcZ6uqgfhczC3g5lkJ8PwOQwDvC71yqQTW2dFrxXkAaPPMUjAZc6M8oKfPZrs5Rw90u+Ad0U19VJVRbE88Dth4HIWC8oD6CYdbf2lf9d7+zJlt2Wng9isupyouPm9LJsW/oGQzP4WEuG+nTWXqVgBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723010932; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DxRlp7hpua5LRbqfeatf97wHNzDk4//q2dzIKmCGBiQ=; 
	b=jM/bgaDCvcy3mMA8u+5k/8IJxjDacWa1frJEys6LmcMIBSfyL6EmyTp6hPRmCRDyo+0HYZ5WkXoLnci8N36L4O13/b5MnsGHKcEUC3Lnh+Ff+c3k58qawHT/BnY2oAbbCOiXpwd2vITa81ZGwT2YHPubZxPp2cQsw6N2NHZ0wA4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723010932;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DxRlp7hpua5LRbqfeatf97wHNzDk4//q2dzIKmCGBiQ=;
	b=FwvCYAMxRIMvfuSXZH4qcNjayrbIG6++Gc9lzOG1F5MoQD9F3XtSJddgWLjXXxLn
	UxiBXNVbqvlIUHlfjY+aDyfo2c0hZwetCOrodlBdO/oEiyB+2KDxFPnGSKZBApO5/v1
	zMVWZUxu2METARsOeVUKEt2yDs5PMqrSj1Nlbs4I=
Received: by mx.zohomail.com with SMTPS id 1723010930974862.6719533491794;
	Tue, 6 Aug 2024 23:08:50 -0700 (PDT)
Message-ID: <ca500f5c-57e7-43bc-9a1a-015021582af2@collabora.com>
Date: Wed, 7 Aug 2024 11:08:43 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: kvm: fix mkdir error when building for
 non-supported arch
To: Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240806121029.1199794-1-usama.anjum@collabora.com>
 <6a3b2f3c-b733-4f64-a550-2f7dcbaf7cb7@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <6a3b2f3c-b733-4f64-a550-2f7dcbaf7cb7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/6/24 9:00 PM, Shuah Khan wrote:
> On 8/6/24 06:10, Muhammad Usama Anjum wrote:
>> The mkdir generates an error when kvm suite is build for non-supported
> 
> built
> unsupported
> 
>> architecture such as arm. Fix it by ignoring the error from mkdir.
>>
>> mkdir: missing operand
>> Try 'mkdir --help' for more information.
> 
> Simply suppressing the message isn't a good fix. Can you investigate
> a bit more on why mkdir is failing and the architectures it is failing
> on?
> 
> This change simply suppresses the error message and continues - Should
> this error end the build process or not run mkdir to begin with by
> checking why $(sort $(dir $(TEST_GEN_PROGS)))) results in an empty
> string?
The tests are specified on per architecture basis. As KVM isn't supported on arm, there are no tests in TEST_GEN_PROGS and it is empty. While lib.mk infrastructure has support to ignore and not build anything in such cases, the Makefile's behaviour isn't robust enough.

I think the better fix would be to check if TEST_GEN_PROGS isn't empty and then call mkdir. I'll reiterate and send the fix.

> 
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index 48d32c5aa3eb7..8ff46a0a8d1cd 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -317,7 +317,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>>       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>>   -$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>> +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))) > /dev/null 2>&1)
>>   $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>>   $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>>   $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> 
> 
> thanks,
> -- Shuah

-- 
BR,
Muhammad Usama Anjum


