Return-Path: <linux-kselftest+bounces-14916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856E949FD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D261C22809
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 06:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089C1B5813;
	Wed,  7 Aug 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="OcCMCGd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662B1B5805;
	Wed,  7 Aug 2024 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012459; cv=pass; b=iYviWVHZhggXaaIq3khj1UKs2gzxiBMnGSIHwvXK0woct37fVKlqVdjsq5oTjNbQEm/sJ76WRCMpehmJ/rfAPwPsMleQuiTMDyFpAHxF2bUFPu9ta93e/8jPE06h7yJwBXvWLfCRZAqx1Lnx7XE9ydScwdl6bd4gXisCcUcbDw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012459; c=relaxed/simple;
	bh=PjY1kIXXa/+Uvf6D4rCAZkO8Q7OqC9WNlDXVzCDIaYA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ywud1RAUJWd+23f46LfK3p5Pxg9Q9SVA7wJelAvX9WzDfoPuyzjSYQwVdmfgipaHWbhzzoF1zwKG6iMZjYs0DS6LyEGsZlNx1PbUQMr3NaAszPgZPU/fVArbZgU/yHt9sCyGUjG8jwe2JHF5pVFt/50W14B6TjyqUJY6IBoGSZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=OcCMCGd+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723012446; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IWZNbuVjFdgfwNfwnjJxv9fWk0L8MnWfKZSuFDTFJCewZNaJRWuyYZKyyruqu6GU1x40O6CWWPTu5D4MuDY9IDUffiVlWZ9QF5B+OUWpSXM9St3giP4pFtITUh4NYVEwA5J1Ue+H/I8jLds9VCpnQtEfhnZQxF9RH0BFi2yzFOw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723012446; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cN9VwZ3ux/dSwp942c5/KewkPym2XQ/3TqOiMuYs6Ok=; 
	b=Od1flUVT55hKI3FWebFnHRSg2u7/hZYwYPpBibzQL0QjcSzsYrP91lgSwPcA18mq0GOQYh2pF/TAmv6q+UMZaPb8IehpCS905ko8lcICJxGwJbeM7J/Sanw3fO0EbtMELRlNKdWm8sxeb4RTACWfM6Kda8zWrdfJtt/N9HvM24w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723012446;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cN9VwZ3ux/dSwp942c5/KewkPym2XQ/3TqOiMuYs6Ok=;
	b=OcCMCGd+QC227b27+w1f9IIQvzqCqH49GS9cJ2ST9ND/2J+3Itl1iFD9+bFRXWT2
	/2FFwTmViXUq2JRzVpfLRlSK4g6T5YjdXFQUrTolWBdIjB8UJmXCDBp1Zg17CddLdkb
	4dhNRS03hKoYX9R1HvAqLgEXXZoBCdygsb+JwRdM=
Received: by mx.zohomail.com with SMTPS id 1723012444268333.907844900133;
	Tue, 6 Aug 2024 23:34:04 -0700 (PDT)
Message-ID: <5703a55a-95ab-44ee-a070-2bca6e9e23bc@collabora.com>
Date: Wed, 7 Aug 2024 11:33:58 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests: kvm: fix mkdir error when building for
 non-supported arch
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20240806121029.1199794-1-usama.anjum@collabora.com>
 <6a3b2f3c-b733-4f64-a550-2f7dcbaf7cb7@linuxfoundation.org>
 <ca500f5c-57e7-43bc-9a1a-015021582af2@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <ca500f5c-57e7-43bc-9a1a-015021582af2@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/7/24 11:08 AM, Muhammad Usama Anjum wrote:
> On 8/6/24 9:00 PM, Shuah Khan wrote:
>> On 8/6/24 06:10, Muhammad Usama Anjum wrote:
>>> The mkdir generates an error when kvm suite is build for non-supported
>>
>> built
>> unsupported
>>
>>> architecture such as arm. Fix it by ignoring the error from mkdir.
>>>
>>> mkdir: missing operand
>>> Try 'mkdir --help' for more information.
>>
>> Simply suppressing the message isn't a good fix. Can you investigate
>> a bit more on why mkdir is failing and the architectures it is failing
>> on?
>>
>> This change simply suppresses the error message and continues - Should
>> this error end the build process or not run mkdir to begin with by
>> checking why $(sort $(dir $(TEST_GEN_PROGS)))) results in an empty
>> string?
> The tests are specified on per architecture basis. As KVM isn't supported on arm, there are no tests in TEST_GEN_PROGS and it is empty. While lib.mk infrastructure has support to ignore and not build anything in such cases, the Makefile's behaviour isn't robust enough.
> 
> I think the better fix would be to check if TEST_GEN_PROGS isn't empty and then call mkdir. I'll reiterate and send the fix.

Waiting on Paolo's response before sending the following fix. Maybe he
has better idea here.
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -317,7 +317,9 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@

-$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+ifneq ($(strip $(TEST_GEN_PROGS)),)
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+endif
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)


> 
>>
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>   tools/testing/selftests/kvm/Makefile | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>> index 48d32c5aa3eb7..8ff46a0a8d1cd 100644
>>> --- a/tools/testing/selftests/kvm/Makefile
>>> +++ b/tools/testing/selftests/kvm/Makefile
>>> @@ -317,7 +317,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>>>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>>>       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>>>   -$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>>> +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))) > /dev/null 2>&1)
>>>   $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>>>   $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>>>   $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
>>
>>
>> thanks,
>> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum


