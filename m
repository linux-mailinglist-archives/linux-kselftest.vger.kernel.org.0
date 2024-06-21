Return-Path: <linux-kselftest+bounces-12411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE6911F52
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F19C28A7B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96816D9A2;
	Fri, 21 Jun 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwAARlr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C116C856
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959931; cv=none; b=cLnG5CcN1NkqO+gEWnRyFDtpQSUMAmzWZKJ77Nd114FtCRsW+5Q6ENlaIzFZguoK3fZL0QIJjNasW8vkGIhwB5ujN95GaamNEhvgfWP6/sRlEjZiQbP4Lq+rLnIUMLClrfdfaMr3u7nHWSQmhHgYeB4YLKI8l5+Db1hrR51oVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959931; c=relaxed/simple;
	bh=WI8q74hV/ZDFivnFmCN6w10DEbjmCmNDrlr40E5BZCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaaAtSKuh1K/rlUUnEOY48wQwo2MId3+8H/k/nOH2CMP9z83WjyL2iItl/JZitxK46mb12pzs6WIT+vM+sgY70ilXPFwRTX1lobMHM7rZV50KxVCCsfimIchGYUOMLVe+9Kw6b75oZBMLNGh4hB/ik82XbXtSrb5d6dEo2jf7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwAARlr5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718959928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tct0TE8nTewtK7MtncaD4F3Gq2u1ydXoNHAeRMtkAYE=;
	b=XwAARlr5Wmcob6mwzzldLCru2Lo6O7W+/06/Cu6ZhT8xo/f9yztzLYMfGbY+jZW1+V0mwj
	DruLIbh+DPPaTvV5bBd60O0EM2jXNQaM++mlGz9ARKkFXKu0zFpIPF/Ik4vFCzplMwi5Zn
	7fpQQC/RkoD9pAvKcsWJtbSC1rjHvSg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-VwstDu4bOQSZ4nX45znFEg-1; Fri, 21 Jun 2024 04:52:06 -0400
X-MC-Unique: VwstDu4bOQSZ4nX45znFEg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42476eda16cso16126845e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 01:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959926; x=1719564726;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tct0TE8nTewtK7MtncaD4F3Gq2u1ydXoNHAeRMtkAYE=;
        b=DFDjRSCEzaVgde8RxTLeapFF44QhNGwCl58mu5aCKJKQr6kApkQ7EXLLmzFI/i95Wb
         sfaQ4dUBZ2W5nkc4nFywi7tWja0d+QlkSH3XWrAT7Fbj1J0wlySkJ9qq2NGx1L0PmT68
         jvaE891trtBL56qZ7UQIpT1d2Xh/M52OHnVIctmJ6jCcaoVWVUmasCORtzp++G4cBqYM
         1OnVpqsOSi3Lmp2MY5UrfCg2FXZv+xkxWT2TYO0bmBBL9kI8vU1zXDtFNhv8Pq4CqUuF
         TtasYHJsVb+b01UwfnsiH4lXm7p+myZhYY+VsOgXPLfO82Ckb2hF3QIjxLQYdY23GlrD
         TNXA==
X-Forwarded-Encrypted: i=1; AJvYcCUHiwvf7y+716KB+pMtU53PvrNT5wPiQdRRhjSqmmjgJjp9iCniOik+5QgNws0J7SAoWHB8EG9/6uCz0Lfik88s4kX43wOLeY8S7Yw+SbYl
X-Gm-Message-State: AOJu0YyCTpducy2d2DsMfylQEBNhjaxROwNHtRxosTvAYlpwhBnLf2ci
	eXaz4R1RWWTY90kpncMCOV0kuxbQrcsX1tmBB26DKRxr7oRHg8oPdFhX/+Xoez6oC/7sLsDvTov
	PJ9Zeo/8yBVEL7EKYGTqbpxOKKZLMi6qNA+l2O0Fz0vUxcQ+mUX69A6QO+F/2ySsoCw==
X-Received: by 2002:a05:600c:5cc:b0:423:2ea:fdb3 with SMTP id 5b1f17b1804b1-42475174a24mr56312985e9.14.1718959925805;
        Fri, 21 Jun 2024 01:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMsGZDb9M775wmSXO+z3lJbuY5QHevyXcOXWN0JKgcdoKnyuS1hJcOy8igloyw/t7cqPTv5A==
X-Received: by 2002:a05:600c:5cc:b0:423:2ea:fdb3 with SMTP id 5b1f17b1804b1-42475174a24mr56312865e9.14.1718959925376;
        Fri, 21 Jun 2024 01:52:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:e600:4063:2059:fd18:9d65? (p200300cbc725e60040632059fd189d65.dip0.t-ipconnect.de. [2003:cb:c725:e600:4063:2059:fd18:9d65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248191116fsm18800235e9.37.2024.06.21.01.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 01:52:04 -0700 (PDT)
Message-ID: <d5f14248-3cbc-4c1e-8b0f-f241b07f5fb5@redhat.com>
Date: Fri, 21 Jun 2024 10:52:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ying.huang@intel.com,
 linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240620002648.75204-1-21cnbao@gmail.com>
 <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
 <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 09:25, Ryan Roberts wrote:
> On 20/06/2024 12:34, David Hildenbrand wrote:
>> On 20.06.24 11:04, Ryan Roberts wrote:
>>> On 20/06/2024 01:26, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> Both Ryan and Chris have been utilizing the small test program to aid
>>>> in debugging and identifying issues with swap entry allocation. While
>>>> a real or intricate workload might be more suitable for assessing the
>>>> correctness and effectiveness of the swap allocation policy, a small
>>>> test program presents a simpler means of understanding the problem and
>>>> initially verifying the improvements being made.
>>>>
>>>> Let's endeavor to integrate it into the self-test suite. Although it
>>>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
>>>> expand its capabilities to support multiple sizes and simulate more
>>>> complex systems in the future as required.
>>>
>>> I'll try to summarize the thread with Huang Ying by suggesting this test program
>>> is "neccessary but not sufficient" to exhaustively test the mTHP swap-out path.
>>> I've certainly found it useful and think it would be a valuable addition to the
>>> tree.
>>>
>>> That said, I'm not convinced it is a selftest; IMO a selftest should provide a
>>> clear pass/fail result against some criteria and must be able to be run
>>> automatically by (e.g.) a CI system.
>>
>> Likely we should then consider moving other such performance-related thingies
>> out of the selftests?
> 
> Yes, that would get my vote. But of the 4 tests you mentioned that use
> clock_gettime(), it looks like transhuge-stress is the only one that doesn't
> have a pass/fail result, so is probably the only candidate for moving.
> 
> The others either use the times as a timeout and determines failure if the
> action didn't occur within the timeout (e.g. ksm_tests.c) or use it to add some
> supplemental performance information to an otherwise functionality-oriented test.

Likely for ksm it would make sense to move the really functional parts 
to ksm_function_tests.c.

Fur gup_test it might be similar.

-- 
Cheers,

David / dhildenb


