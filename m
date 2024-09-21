Return-Path: <linux-kselftest+bounces-18188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641697DB82
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63DD1C20D2A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE25684;
	Sat, 21 Sep 2024 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2WTBPPC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514D28F4;
	Sat, 21 Sep 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886976; cv=none; b=JUV5hjXQBpJSlSaIAxztkzOt84ddGM5jNrqtB8vc3CWgMNve1EuIsr8edaCdGePH0BW3GHp6sRpLRWWh4yCDeKvWZvXpQSROcdKqZGrlExoujI7FExiv96ybYuOInxEuc9Qio3J2JVQf8pjW8OqKqDsPkX3PIM5Hhxi5EcjsGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886976; c=relaxed/simple;
	bh=//K9hbaxPHdW1/y+2DJJVajM+TKkakeF72bAqnG3kO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1oHfBoj4j+7BuDnch+etV8rBIhFGTdzNo/CEIxsoEmv5u/X4F9CucxgJcDP8CtYpr5xLxWuXUgPqDLUO0my7ISw/QtbokiBZCS2Q9hGqSSOVqrEI9LTRbbstTVLwFFDyj3GWh/hldZSYIz7k5TA14nhQtLgUD351j7a9CvL414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2WTBPPC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2059112f0a7so25014675ad.3;
        Fri, 20 Sep 2024 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726886974; x=1727491774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltHnEVOf3AmMRMzkvl1ZOEGlhEF8xITCLJjC6HhJhc4=;
        b=O2WTBPPCN7KG8eKGMFo4kJ0CqLWGKxv7F7NwnwaCPTe09F6PIWUnRj5JKL5p+8FWIv
         6cxD5F+cbvksVc8uF3yQ/q1qWDomVDk/VraalFlbBk4K5gqAtx9+Na9wQf97gew9oZsz
         sBnf5MTCYYgXPKc3Xt9eQY/1TEvm9ls8jPuerpr+QSsfu46B110eZW2jHIW3KOsNIRsp
         tj5/sBDftrkF+9oDNu/Y0leAGlHcedi/2+56jg3dZ7/VDrZUdttde7+l3EkefsS/Si8R
         4ayHbRqpapUlMu0Knv/E7SaEMdbS8lQrUS29NERmKxVb/KnyiG7FOJPfuBWLSkKRuaGb
         1cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726886974; x=1727491774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltHnEVOf3AmMRMzkvl1ZOEGlhEF8xITCLJjC6HhJhc4=;
        b=HbsGdfys1xDI+Q6eb58ksedj0zuvGp4CR4XNs31DRfjxPzh+X0tItNE4JovxxywgpH
         i+OnsOP2BunpYMN3YfBQdDKfxuafzuqH4Geo8fP3dGpS/6j1EUVpErUrTB6SbCUph+xp
         b+lGa/HwBA46wiZRYDYag7z5VoMOaDmtL2hmJiju61my4dYrkAcxUrD0x91Q0vK09urs
         MLoPaMz7B4b8Am9J7X3I5xhjZQDpmEl9lN5a+x7a+kHhnNDnvjTxyZQWYyOhMHWWEQhs
         PIh5/ESsIWCgHkR399f7pddAUFHTmJZJCIJesGRzA/gro+OEvRXxX8DjKtdkNi6VsHk0
         ceLA==
X-Forwarded-Encrypted: i=1; AJvYcCV8HsvV8JZGSKugI3opXAFxce3qE5Rk2412XYIsIjymuKv/ZfNmNnKHbqGx2dxcqYpOei9DboMUUOiTGnUABGe0@vger.kernel.org, AJvYcCXCBqd+zkbiN0xkdVLTsIMC7r9O9GIHxpfsXXJ5BVRuKL9L+iCdTF7jhfmsjt+9gDuQxXtaEK/NpjFJpQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiXGc4a8h53XGoTnYcKCmRv9GXZAz/whVz11tJindK5UZmk7p
	fzdKngJTMV1q2Z73v8uJKt4WFfTuhHmdxFQjbrCRpnI7FwC+hQPSEvkZ4K7t
X-Google-Smtp-Source: AGHT+IFZm8L5WwYLgio76VXdNrwEQOaaDE1XES+ajc6obLQuMgezVBqA8sM8a6ox0qpNr0sacNbY3w==
X-Received: by 2002:a17:903:110d:b0:206:b618:1d91 with SMTP id d9443c01a7336-208d8327cf2mr75000925ad.5.1726886974168;
        Fri, 20 Sep 2024 19:49:34 -0700 (PDT)
Received: from [10.0.0.100] (201-0-94-15.dsl.telesp.net.br. [201.0.94.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460255asm101145035ad.107.2024.09.20.19.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 19:49:33 -0700 (PDT)
Message-ID: <ce313b67-416e-44fe-865c-77388883556c@gmail.com>
Date: Fri, 20 Sep 2024 23:49:28 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com
References: <20240917005116.304090-1-arturacb@gmail.com>
 <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
 <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Content-Language: en-US
From: Artur Alves Cavalcante de Barros <arturacb@gmail.com>
In-Reply-To: <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 4:10 AM, David Gow wrote:
> On Fri, 20 Sept 2024 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/16/24 18:51, Artur Alves wrote:
>>> Hi all,
>>>
>>> This is part of a hackathon organized by LKCAMP[1], focused on writing
>>> tests using KUnit. We reached out a while ago asking for advice on what
>>> would be a useful contribution[2] and ended up choosing data structures
>>> that did not yet have tests.
>>>
>>> This patch adds tests for the llist data structure, defined in
>>> include/linux/llist.h, and is inspired by the KUnit tests for the doubly
>>> linked list in lib/list-test.c[3].
>>>
>>> It is important to note that this patch depends on the patch referenced
>>> in [4], as it utilizes the newly created lib/tests/ subdirectory.
>>>
>>> [1] https://lkcamp.dev/about/
>>> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
>>> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
>>> [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>>>
>>> ---
>>> Changes in v3:
>>>       - Resolved checkpatch warnings:
>>>           - Renamed tests for macros starting with 'for_each'
>>
>> Shouldn't this a separate patch to make it easy to review?
>>
> 
> I think that, if this were renaming these in an already existing test
> (like the confusingly similar list test), then yes. But since it's
> only a change from v2, I think we're okay.
> 

Yes, the renaming refers to some test cases from the test suite that I'm 
adding, with the purpose of resolving some checkpatch warnings, as 
suggested by Rae Moar's review[1].

>>>           - Removed link from commit message
>>>       - Replaced hardcoded constants with ENTRIES_SIZE
>>
>> Shouldn't this a separate patch to make it easy to review?
> 
> Again, if we want to change this in other tests (list, hlist) we
> should split it into a separate patch, but I think it's okay for llist
> to go in with these already cleaned up.
> 
>>
>>>       - Updated initialization of llist_node array
>>>       - Fixed typos
>>>       - Update Kconfig.debug message for llist_kunit
>>
>> Are these changes to existing code or warnings on your added code?
> 
> I think these are all changes to the added code since v2. Artur, is that right?
> 

This is the case! All changes are in the added code, so it doesn't 
introduce any checkpatch warnings that were present in v2.

>>>
>>> Changes in v2:
>>>       - Add MODULE_DESCRIPTION()
>>>       - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
>>>       - Change the license from "GPL v2" to "GPL"
>>>
>>> Artur Alves (1):
>>>     lib/llist_kunit.c: add KUnit tests for llist
>>>
>>>    lib/Kconfig.debug       |  11 ++
>>>    lib/tests/Makefile      |   1 +
>>>    lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 370 insertions(+)
>>>    create mode 100644 lib/tests/llist_kunit.c
>>>
>>
>> You are combining lot of changes in one single patch. Each change as a separate
>> patch will help reviewers.
>>
>> Adding new test should be a separate patch.
>>
>> - renaming as a separate patch
>>
> 
> I think given that these are just changes between patch versions, not
> renaming/modifying already committed code, that this is okay to go in
> as one patch?
> 
> The actual patch is only doing one thing: adding a test suite for the
> llist structure. I don't see the point in committing a version of it
> only to immediately rename things and clean bits up separately in this
> case.
> 
> 
> Cheers,
> -- David

Thanks for replying!

I'd like to reaffirm that the patch is, in fact, doing one thing: adding 
tests for the llist data structure. All the changes in V2 and V3 refer 
to the code that I'm adding. I'm not modifying any existing list tests, 
only adding new ones.

[1] 
https://lore.kernel.org/all/20240903214027.77533-1-arturacb@gmail.com/T/#mc29a53b120d2f8589f8bd882ab972d15c8a3d202

Best regards,
- Artur

