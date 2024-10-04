Return-Path: <linux-kselftest+bounces-18995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E1998FB5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 02:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4507E1C225C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA055153BED;
	Fri,  4 Oct 2024 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BqfCbb4G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B517571
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000067; cv=none; b=lVvCU7ol06n9J+uDBJ4M7bmnKq1Fi+Inp7hnzXpabzr4gKma0uXtahXZ17UESPsI6ZO5gtM8I9V6Y17z8schJ125zB7K3vlnbig8Dp296t+1E3yS1qgEdXU8MR/qNJ74SseLnYqHUDl9tVYkgJK6Z/5lklMGg8+ldabeDHwjUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000067; c=relaxed/simple;
	bh=Uk8PYF1jkvRqrAuznedTKDFcx8jh6uWwYlptJbhFscM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txKcvvx1YlVP+mnkB09kqWDbHt4/ElJi8BbXHqngkWbLlLbtpdYAF6jExTYSVlQx36uhXrd6orVYaq7WRp67ZTdqDy9GyPj98X5rzI5RFwNnGL5Fr4qym3k6pvb1RScf5C9pv7GryUEqIK2RAupsBsW71d2lwuHeP7Auy4xTm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BqfCbb4G; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cdb749598so73399639f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728000063; x=1728604863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOGFPQ6jAXNerE13UVZtADeZtxdDJrEYc49/QlGda6k=;
        b=BqfCbb4GBQcGoUnkKnnRxaIxl6McRiM5QFoe9y7D3A7JsZYekXFMo5uErHMiHHFDKY
         Jz5J2b3qROZUL6vmarEB2psk4NaKYjif/2SmSECImRmraXHW+GqWQ6D6nYsTCU3V6bT1
         IzieV48Gp5K3jZVqOV1S7LCae9S1egDHDWwyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728000063; x=1728604863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOGFPQ6jAXNerE13UVZtADeZtxdDJrEYc49/QlGda6k=;
        b=GwDh8RuM2ZWSZM899cnraoTnyYp9HE07ZZgRImro3kfmfeyPXZfp3msBgijM6leYcw
         s9f/jIC5Okj92wagnt4EztNoJnS/fqWHUWvQ0ln3xqG9MUvIC8nFW86tXujjD1reDTGw
         hYYAxAHzN+TYCMH7pMD206UHfVaL7z+AhrtayyZncHI4wDtR3Lb9mbABzLCXlMFCWeTv
         Hm5mkiMWJwJ8M/opOPJUVWOYxe28K3IrOIJ1aj1XNvLSox9Of/zzJOPqyghmNucslztO
         tqkCVtfc5Vl5AjFv5WPdRXJgCEndDdrmPeWT3v2gQrPXA78dGN1DZb7ux+w9wnImqnOC
         C3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCiHLALWuWSREya6AGdFOVq1gMtmLWJJ1sPEFklRHc4N2UmpgZumY6d5SfjuohiX/HewO1OP+AjRxMILRBjxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLg7WizMncHW9eUsPE2KYWZxzJN0xY5gfqgp9PJwxCMG5iV6i
	vkq6NiDIbU7H3WWc+dT2M3eRItSWvWmCUsbZf2kzPdED6DcgrncwwtchpuE92dxFihmQPuOJbLb
	O
X-Google-Smtp-Source: AGHT+IHIccZXhQUNgi92VPytZaHIJ6MpIN1peJv8CYFwgdHXLLxczbVb2tz1DUdVGBu72XFuQ8IYrA==
X-Received: by 2002:a05:6602:1412:b0:82a:2a0b:1c7d with SMTP id ca18e2360f4ac-834f7c7f15emr145501039f.5.1728000062948;
        Thu, 03 Oct 2024 17:01:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55ad6608sm489068173.171.2024.10.03.17.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 17:01:02 -0700 (PDT)
Message-ID: <5a926b36-59e8-465d-a824-e869959f2b10@linuxfoundation.org>
Date: Thu, 3 Oct 2024 18:01:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org, willemb@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
 <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
 <20240920123827.715ff109@kernel.org>
 <3f0d12ba-0e52-41f9-9cbd-34bc1225121e@linuxfoundation.org>
 <CADYN=9JO-h5L8+CBE9rKY9fnA2sJmam6_MzpZB38Bmn5D4fdPQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CADYN=9JO-h5L8+CBE9rKY9fnA2sJmam6_MzpZB38Bmn5D4fdPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 00:15, Anders Roxell wrote:
> On Wed, 25 Sept 2024 at 19:26, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/20/24 04:38, Jakub Kicinski wrote:
>>> On Thu, 19 Sep 2024 09:51:47 -0600 Shuah Khan wrote:
>>>>> @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
>>>>>      @ret=1; \
>>>>>      for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>>>>>              BUILD_TARGET=$$BUILD/$$TARGET;  \
>>>>> +           mkdir -p $$BUILD_TARGET;        \
>>>>>              $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>>>>>                              INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
>>>>>                              SRC_PATH=$(shell readlink -e $$(pwd)) \
>>>>
>>>> Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?
>>>
>>> I was wondering about that, too. Looks like the code from the all
>>> target is copy/pasted in the install target except the mkdir line.
>>> Best fix would be to make the dependency work, I don't understand
>>> why it doesn't already, tho.
>>
>> I think this could be the issue:
>>
>> net main Makefile doesn't have handling for subdirs. It looks
>> like the way this is handled is by adding an entry to the main
>> Makefile:
>>
>> TARGETS += net/af_unix
>> TARGETS += net/forwarding
>> TARGETS += net/hsr
>> TARGETS += net/mptcp
>> TARGETS += net/openvswitch
>> TARGETS += net/tcp_ao
>> TARGETS += net/netfilter
>>
>> So the solution would be similar adding net/lib to the main
>> Makefile.
>>
>> Anders, can you try the above and see if it works.
> 
> Sadly that didn't help.
> 

Okay. I tried the following:

make kselftest-all TARGETS=net/lib O=/tmp

I see /tmp/kselftest/net/lib/csum

Can you give me the exact command you are running?

The following from selftests/Makefile should take care of this.

# Networking tests want the net/lib target, include it automatically
ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
ifeq ($(filter net/lib,$(TARGETS)),)
         INSTALL_DEP_TARGETS := net/lib
endif
endif

thanks,
-- Shuah

