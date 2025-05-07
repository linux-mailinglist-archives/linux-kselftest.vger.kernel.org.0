Return-Path: <linux-kselftest+bounces-32605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D12AAED5E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1C3AEE64
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BC28FAA8;
	Wed,  7 May 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHuXWIud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675728FAB2
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650970; cv=none; b=hm7ZzifK3tz2eq/Yu1+KxV5PJZ2Qo3Wsruhyszo12IrvOXth++UBumAzxG2xdBvCJZzvA+1YqWxYZaYYWSfUkZ9rhHAZQ7N9XpVmA3sJKFes7bIn22GUoCvBZTOL7i9FkZPjGGcbuOHCyayw4nxpevnnyE3zj0ZEdJCGj4OY+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650970; c=relaxed/simple;
	bh=G75xtNcBa/HKc4thX1U4JClvdxzbtUn3lxLH5U+xQzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbaCkp6Pg/YOzOwykw0rbJHtMtR+kycRqHKLBkpFxOb1GgZXQhuKAdMufvdXAunptezzG8ofD5Jvuzu+SCrjUqFFW8nXs9bupzdSW4CzAswjn8v8OJRb1IVY1xsz7JmS1sCKOluXb1gPu0C237O6U5zRJ2ziNrbj7x1PFKCJOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UHuXWIud; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86135ac9542so14336039f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746650967; x=1747255767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbrLfo/HVOEcIGm/SsMmNRXcHh8Er8SMroRu1GzttWY=;
        b=UHuXWIudVx0iFjD1cgs/WMt7Gy9yO3wmQjyiBGzXln3lJ7WGSKiHsgxVKrlFnbg8RU
         5Z5W0V6HBs9CygCznH005Mizq3na5geCOEAgoxhHSlLDun1G4lPLwIe20U3DiSDZ5XEg
         eCoxbcFAOFMAcZEyOGE2st9H7RVSIXOA2HBoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650967; x=1747255767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbrLfo/HVOEcIGm/SsMmNRXcHh8Er8SMroRu1GzttWY=;
        b=Fn+QWEcgx/d1Gk3ZmjGw663nGqszgILxTekwxLDq5zA16QLzNHgo9bQUAuehx2sJ85
         23wyYM31AfB/FM6+xKeUjQSuMMl5SJRHZjGwDidOn4y9+Q7BOVP39uvc6UeDCYWIEi5V
         Q2o8oocZdX8glyT4JqETlzH3N6vDC7hw6OxEl7Xl8uxaAnBGXgwdN016C6RHnXfzsMMh
         xbtX3ptlP9Jz43ncYnWcc52KPL6FgT9kFrEX9b6u0YGi5pQOAiCvT09YaL2j/2xWFzCR
         sm9++UGKfCFQ1ArhAxtMKaKJP6lXMpVR2ghMskgrFbDjsnPtvfWM6vaHabGd2hYsCvW9
         mq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCZVwZgkeAnCejHtqkzD6LaPwpsoINeEz1b3TYpnPsqXUsE76E+hi0q4Di9URaCDkFsatZsZ2ObrMSk8Hk5bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+zsDZvnDS8q98fNPYS+bwizg9UQrnZpn2hOKS6cinELeYLVa
	d4XoBKiOekb8dZKbekwapzC0Hka1YM8fSwpOidwQlq26Ts6P27kPvxyOwkFbanw=
X-Gm-Gg: ASbGncvx524xX0Hd5mhv4RBDIDnWQkZsdUmJGJbvPwL+hsU1JQYaLkeWN0nI1+bihci
	qP0UtToI1s5cvFybn6DeM+prHvd2nQgfhI6DVC4+ufsfBxFSrq1rKS/fzp1xQyP+Oqym7HOhet8
	LTOPA0BBfLpgPBW+0iUiVC+rBbVS+bzQklr8p7o8WjR1LFHCOHARFMzjMCZBkxjZzLPCamRBXc8
	r8pDjPAiFo2tu6qo2eTtl4DDWuGqacNInbl7yfzV5PDgfSuh+itVQpUXN0DuJpfGJk7qODxXAa1
	Yj6peuZeiUZUnd8ZC3bylTLtU46XvhtskvmoYPqBVS8joteCwZI=
X-Google-Smtp-Source: AGHT+IGX4LIZdxiQGhsPmHJayBQ3t4X15bBVjp4+dG9Yr+NmPEGNWKAvicjiqoIWxW3kT3pxCS3NFg==
X-Received: by 2002:a05:6602:29c9:b0:85e:16e9:5e8d with SMTP id ca18e2360f4ac-867550e2fdemr166032339f.7.1746650966768;
        Wed, 07 May 2025 13:49:26 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa31e07dsm271901639f.21.2025.05.07.13.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 13:49:26 -0700 (PDT)
Message-ID: <efd8baf5-f30e-4e7b-af53-a75efaab12f7@linuxfoundation.org>
Date: Wed, 7 May 2025 14:49:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, seanjc@google.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
 <17464a97-e7be-49d4-9422-96ff824dba7c@linuxfoundation.org>
 <8f765dc8-421f-420f-bd3e-1a0d889238a1@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8f765dc8-421f-420f-bd3e-1a0d889238a1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 15:34, John Hubbard wrote:
> On 5/6/25 2:18 PM, Shuah Khan wrote:
>> On 5/1/25 05:42, Peter Zijlstra wrote:
>>> On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
>>>> On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
>>>>> On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
>>>>>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
>>>> ...
>>> Please fix this fucking selftests shit to just build. This is unusable
>>> garbage.
>>

Peter, John,

There seems to be confusion regarding  KHDR_INCLUDES. Tests don't have
to use KHDR_INCLUDES if they don't want to.

There are 4623 test Makefiles (excluding the main Makefile) under selftests/.
Out of those 73 Makefiles reference KHDR_INCLUDES exported by lib.mk and
selftests/Makefile. The rest are happy with system headers.

The support for this KHDR_INCLUDES was added just for the case when a new
test depends on header change. This is the reason why only a few
test Makefiles use it. When test rings ran into issues related to
dependencies between header changes, we recommended installing headers
to solve the problem and introduced KHDR_INCLUDES so test Makefiles
can use it in their Makefiles overriding the framework defaults.

If your test doesn't need it, you can simply stop referencing it or
use the approach used in mm test.

It is a manual step. Works well for developers who know what they are doing.
This isn't ideal for test rings. This isn't an ideal solution really.
It works for the mm developers.

# In order to use newer items that haven't yet been added to the user's system
# header files, add $(TOOLS_INCLUDES) to the compiler invocation in each
# each selftest.
# You may need to add files to that location, or to refresh an existing file. In
# order to do that, run "make headers" from $(top_srcdir), then copy the
# header file that you want from $(top_srcdir)/usr/include/... , to the matching
# subdir in $(TOOLS_INCLUDE).
TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi

The issues Peter is seeing regarding KHDR_INCLUDES in the following
tests can be easily fixed by simply changing the test Makefile. These
aren't framework related.

kvm/Makefile.kvm:	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
x86/Makefile:CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
futex/functional/Makefile:INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
futex/functional/Makefile:CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)

You can make the change to remove the reference to KHDR_INCLUDES.
If don't have the time/bandwidth to do it, I will take care of it.

If test build fails, you can then figure out how to address that.
Hopefully build issues related to header changes are infrequent.

thanks,
-- Shuah

