Return-Path: <linux-kselftest+bounces-28875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A21A5E8C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 00:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F255217CA29
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6221F3D54;
	Wed, 12 Mar 2025 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkQOqOnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F21F2B87
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823501; cv=none; b=Uk7envuJ9QhHeGzXcQ8vXcyV7PDjIba5PbT6Xy4JtTv5f910KZn9o2nmeqzciNeszp1o03L6Z8LdKtgqvll5i4MqjW84mgMpehxTy9QboxROAwBf1mABxsQ8ju+Dj/TmJtPvvd5qjgNXFPQXrWUzDG5dFLE6RkeBrQ8Y9dc2guM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823501; c=relaxed/simple;
	bh=kz2scAfyGV/3NhQ9g5PL4QN9dT/vGyGmFmkva1NA/GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKzJ0my81ReGR3nvC6+6At6mK3WI4fDhZpFKkyYxVQQO4I81qvGznX4i/jCrFS0bqf/1i1WikZjjcSZsjsJAEB39iCRnfIPckBB96VdmBiz/5/ZQEZ0nA2cbPj7C3RK3FzqMCvaelZdXMCWvTqO5NIxNScgWmMi0sEIks87oMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkQOqOnR; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d04932a36cso3506395ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741823497; x=1742428297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMdILqUTCbGjpyl5slWgWBb49xQQ6Sv5T+7HBXXgjuc=;
        b=TkQOqOnRTXfKMeObLJ5hh/4W04FFXLXgXIppuDQiy51DCJAXnV3DrsKM9kdspdK8ri
         maqwPOJhPWLccR0y1WwFtehQPLsRtZwIbKh5c/uym+EfVnk3Z76l1LtYg7gmc+kwJQAE
         bEwO34OkyOP7+3WYwDTFrfHdwg3vzMjNl+bKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823497; x=1742428297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMdILqUTCbGjpyl5slWgWBb49xQQ6Sv5T+7HBXXgjuc=;
        b=i9O/Nr3/GMACptQfpn6Cn0JM0FesHUpoxtPoHtSaVorUSZvsw1JsB7foLVpv7Auo0u
         TyeWY/aPZeuH2NMZ/DEp1E+qA30NNsZNAdaoFqWXD7kn0temtUhYzhfbCzq4gh587miq
         pJDXfrXAtXFDi+c2FRGRiFnhM1FARMiKQiXCbLEShr2lAyxatjySmYsMgUXBajMdefDQ
         MxAE7zhMDGi+Snrv3/2rxsLkNk9KBo09gzoU5FhPPF1FSy+bBDpSu3UQAMJCgPrLrhCI
         jsdaQauNoSfFoP4+ArmFpo1c2ZS8H7NFrLWb8ZclIB2FVHHw5GC4pJohRrM6Yjc2+rnL
         if0g==
X-Forwarded-Encrypted: i=1; AJvYcCV7UfqjrAJEoz9DhxsFV0QkZUmObyfRHTHIHB+ASIKsHY8mKnQaxs0/9I/oc6jVV2BrFlcx1FMvRnUrzYsarbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEVjwHIiEK3GZHPcqbDzHVdAgSh3FsjNR2pqRA1+at/M7qLub
	HEf07J/V+FDel7yDLdnHd5FdTHAgnC1HviZ69cuJ8mm1ot/UoBNw/yILAPoUrQ2SILnrN0TQ3PS
	b
X-Gm-Gg: ASbGncv5YqxxtN5NKggIBhQcihRimxWN+IuJ1OGqpa39trHmYU32LT+EXcMPMlGyj71
	ZJ4+I7OuvvT5HcxGyOC9+BRPqb3th6p65Z2i89rYXFKZaKkQSclE3gnKxRoRlUetTpkihJOmFMT
	ODl9a3XChU6w4h41c6gkyYogq3fpQNmDJXL0wV6NGyxNfJm37C1HdZZd2AuPiW5PJ6KdbkEYg3n
	lGCunmu4E1mFDhQWSqlnpvKWhEfmHIfSIecrcdAy6VmaBkWln3G5jhiUXBxn0DQJarHyzX0m/gY
	/yDIJP9Ymc2FGD6uUqaiIexflldOY6Svsq4vXCG0zWQ9oiWqNjPqSEc=
X-Google-Smtp-Source: AGHT+IFJdEKouFDEl/CM11osjyRxzNZkSqQ0gWaQpK9UWqB6/Ss9dyGEFkXyoaOnnVpo99ZsIG4xbA==
X-Received: by 2002:a05:6e02:198e:b0:3d4:36da:19a1 with SMTP id e9e14a558f8ab-3d44193ed4fmr301815755ab.21.1741823497495;
        Wed, 12 Mar 2025 16:51:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a72ce54sm356225ab.51.2025.03.12.16.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
Message-ID: <5a1e11fb-4213-45f6-a5ef-636de5e175d8@linuxfoundation.org>
Date: Wed, 12 Mar 2025 17:51:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during --arch x86_64 kunit test run
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
 <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 16:52, David Gow wrote:
> Hi Shuah,
> 
> On Thu, 13 Mar 2025 at 05:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> David, Brendan, Rae,
>>
>> I am seeing the following error when I run
>>
>> ./tools/testing/kunit/kunit.py run --arch x86_64
>>
>> ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression
>>
>> I isolated it to dependency on CONFIG_AMD_MEM_ENCRYPT
>>
> 
> That's interesting. I recall seeing this issue briefly about a year
> ago on an internal branch, and we worked around it there by enabling
> CONFIG_AMD_MEM_ENCRYPT (which worked).
> 
> But I've been totally unable to reproduce it this morning: are you
> seeing this on any particular branch / config / environment?

linux_next - I did allmodconfig build prior to running the tests.
That means I had to run make ARCH=x86_64 mrproper before running

./tools/testing/kunit/kunit.py run --arch x86_64

I tried something different checking out a fresh
linux_next repo and running ./tools/testing/kunit/kunit.py run --arch x86_64

No errors on

./tools/testing/kunit/kunit.py run --arch x86_64

I will try this again and let you know. Can you try this as well.

- Clean linux_next and run tests
- Run tests after buidling allmodconfig and mrproper

thanks,
-- Shuah

