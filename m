Return-Path: <linux-kselftest+bounces-18171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8897D756
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDAB1F218E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF017CA0A;
	Fri, 20 Sep 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dATlL6U/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132017C7C9
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845042; cv=none; b=Tn3iCbs+EwGfUipXCZMKeFFEBKyMjOfIAq1gP6Ik+WURLle85ycVq3MPfywQdzEI55MmVQj4p4w24gYz8fw+/XoKpwZziAd0rT4LRr1XnAM1o5B4N4du9Db0qH1qzZmcwyzBceRREiJ0OMwnzpf1/k1J1OGnpD+GiDi7OP4sLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845042; c=relaxed/simple;
	bh=m64zunrpTT7clJ4I9TXVRY5xts3FGhLA4W4pYySMktk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOX+gDRO5PDvBaFXmFLhH+TguLtddBXwuGK/K6cvrfS60EIDieifA/E58VpYHpc0amZcq1xQxhDYSpHQ8byX9aPYy3WYOZ0XQjSg95NxjTWPijGxQGE3C15iMsXyCkZOdO8jHbhL6JcrdlnxCHmT/KdgnrrQbKWEyJcavl6dLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dATlL6U/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aa3f65864so80560839f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726845038; x=1727449838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJJMb8RSS4AQiwxpzvIgvhQjhF1XMXFRTCcE2Om75mQ=;
        b=dATlL6U/v+2GeN31SofkuPALf6Hi01JCzMIKircd038ebje/fsx7IhnQn8V+YKo4R/
         le4SF6HvQTYec2RhT6o8cCV8qe7D07QkcrpHtach5CJJDtSt/lFIR4EbmIICx27BzMmJ
         GlIXlx5AVPdWO1YoXyfc9VMhmypgOBBwzl/x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726845038; x=1727449838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJJMb8RSS4AQiwxpzvIgvhQjhF1XMXFRTCcE2Om75mQ=;
        b=QjQxIYmXC3M4z3uIHyBLXxQPVWh+e4uAI0AwxQB7lB4Vwm4F1HUhl0a5LFAreibXB0
         oWtJcpJ3SmRv+kg6NXGTn2oUc0X1QPSMKmp2/fUjVYCciolk45vEb6mrFY4Vig9twPUE
         0ADvccQoeNQejDo2cre1GXOTCEhFwltp9Imfy270f8O54QGhF113ljb3BxFD/qvqsMx2
         H7fvyV+0AJxUzejutnV8YWvwFGK/bHXNdzBXyFgjUO1gJpYrOee8D/apw6sISk0sQw2R
         QvQ6zhfdsd+OLaCQ8QISOvXNKIClSzsRV38AwJmhz+xUNtbtGwrsg0IAT0/YquKSwQcU
         fiiw==
X-Forwarded-Encrypted: i=1; AJvYcCUQgc0yr6QRdeX5ZsoUrZK/fCSTBcgzqwmyRt4dd64JNbLV9g77QI6e8P4eC4BIW4ySBCHPKSTKORLTFwKlGz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvAcvjt6grYXZ2g1lE3xzml+0uvPyqyZa/ZVicmLmIlpYmW9S
	+qZ7j4eFOM4HhfAwOnLS6FWSKPe3FpEthJWZzSDZJ0i9E7WFzsAtDhPl66pu+SI=
X-Google-Smtp-Source: AGHT+IHeudTP4G0KwruXvq75Uj6FmS+FTUetpEU0+/iBmXwgBmFFWT6xfJOUNZbgWuHMf51VOQGj8Q==
X-Received: by 2002:a05:6602:6c17:b0:831:fe52:c602 with SMTP id ca18e2360f4ac-83209eabdb1mr409460239f.15.1726845038296;
        Fri, 20 Sep 2024 08:10:38 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf483esm3601957173.10.2024.09.20.08.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 08:10:37 -0700 (PDT)
Message-ID: <f641378c-e729-4c5d-bf55-24a7fc96b623@linuxfoundation.org>
Date: Fri, 20 Sep 2024 09:10:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: David Gow <davidgow@google.com>
Cc: Artur Alves <arturacb@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240917005116.304090-1-arturacb@gmail.com>
 <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
 <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 01:10, David Gow wrote:
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

I do think it will help to separate the renaming and adding a new test.
It makes it easier to follow.

thanks,
-- Shuah


