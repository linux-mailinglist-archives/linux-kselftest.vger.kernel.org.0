Return-Path: <linux-kselftest+bounces-1689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E480F0C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 16:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2DCB21151
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412475439;
	Tue, 12 Dec 2023 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+S5z1qL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22810A
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702394837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3dMiL5LvMWqoHBj+yfJcaK2PIbsFzEoAWHSJdbBQUk=;
	b=a+S5z1qLvkfJCWgLxm3h8RUOoHWKfnSf33QxFeIFlEb7DVpmFcENzxyaO4vOWCDtSJy7iS
	Qmvrot11DYoYAlXWy8LyO5vGGg+uGkSxpr1dRq+1RgoIro+oyBUDbz8/J+g4CWqdgGLGYg
	ek7KQ8dtxiFVfzdE1dXucIeD9JawMps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-5dCVN3hQNKu5vquvdIt6uA-1; Tue, 12 Dec 2023 10:27:16 -0500
X-MC-Unique: 5dCVN3hQNKu5vquvdIt6uA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c3307ccf4so33193675e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 07:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394835; x=1702999635;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3dMiL5LvMWqoHBj+yfJcaK2PIbsFzEoAWHSJdbBQUk=;
        b=P9irrBp0MM/GOL3AvzMkA7k+GV7cRe+n2gi34PcXSs5VqNDf5OnVFxS5EPId93ncaO
         ibEpZIaPpnQPLLxAHotzCtFQPIiOT9/RP8nxiVVPEe9s4VsSsawu68HrLwz5ibpTO5l6
         rtVNRw8zwYnFlVudIYqPa1DGCQbiH4O01dNOBkJ5PeVb4Z0hda0MzAd9cWm/2qakNFho
         bbOPdUb6RmuDp/XcXCfn5xRV/gg7fYgyBsDR60PXlfBOKVryV3CDnTOOkOXsIpH91egZ
         GdPTj+m5Xwv2pqi58Jlm+53wBIEm+2DLRZC6eqMj0GD6sFdwxnXT/AhN6HUWWO+aR253
         x/oQ==
X-Gm-Message-State: AOJu0YxedMWOKLqR3i8GmUM/a1tJlzfrjn+YDl8/nsi7jyz3KeCTr2/q
	EpJfcFd5hpMStsAPoquyvcznlfFCdhVewq8WIhAj+mwjUCfXeq1LezGL3fPYH8Zl/GFnquR8iQT
	Vs57RtkatzsDcrJPBvnojih799J6a
X-Received: by 2002:a05:600c:458c:b0:40b:5e21:d355 with SMTP id r12-20020a05600c458c00b0040b5e21d355mr3324541wmo.94.1702394834607;
        Tue, 12 Dec 2023 07:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbPjNioLxUv8Co39SV9O7EvpPUZyV2Fan3jrsLUi0Vn7c3DhtxI5KCJMgrb1vtYVQ3vpafkA==
X-Received: by 2002:a05:600c:458c:b0:40b:5e21:d355 with SMTP id r12-20020a05600c458c00b0040b5e21d355mr3324508wmo.94.1702394834131;
        Tue, 12 Dec 2023 07:27:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:ca00:4ca2:ff2c:9092:f070? (p200300cbc74bca004ca2ff2c9092f070.dip0.t-ipconnect.de. [2003:cb:c74b:ca00:4ca2:ff2c:9092:f070])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b0040c44b4a282sm9088185wmq.43.2023.12.12.07.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:27:13 -0800 (PST)
Message-ID: <daf9f834-c79d-4f8c-9248-b0b232017732@redhat.com>
Date: Tue, 12 Dec 2023 16:27:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
 ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
References: <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <1368c558-c58c-4574-907e-36b07dee31bb@sirena.org.uk>
 <6ee5d68a-fa54-4ed6-bc41-2bff0d9eb12f@redhat.com>
 <052dc756-cc05-4aa8-9724-14d42853089c@sirena.org.uk>
 <8a2ce635-58f4-44e1-a646-6527936c5836@redhat.com>
 <400c0342-bb28-4dd2-b132-9927c7babec4@sirena.org.uk>
 <f3081d52-8bbc-4bc7-96d4-b086ca91975a@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f3081d52-8bbc-4bc7-96d4-b086ca91975a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.12.23 21:11, John Hubbard wrote:
> On 12/11/23 12:01, Mark Brown wrote:
>> On Mon, Dec 11, 2023 at 07:00:32PM +0100, David Hildenbrand wrote:
>>> On 11.12.23 18:32, Mark Brown wrote:
>>>> On Mon, Dec 11, 2023 at 05:53:59PM +0100, David Hildenbrand wrote:
>>
>>>>> https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com
>>
>>>> I mean, I guess people who don't want to install the headers are just
>>>> not going to be able to build a bunch of tests?  There definitely are a
>>>> bunch of tests where it's not needed so I can see why people would not
>>>> like being forced to do the headers step if they're only interested in
>>>> those tests.
>>
>>> Yes. And before that, people mostly had no clue that headers had to be
>>> installed in order to compile successfully.
>>
>>> So maybe a warning to give at least some hint might be reasonable.
>>
>> That sounds sensible, especially if we could arrange to flag when the
>> specific tests being built need it.
> 
> 
> But the end result is messy: not everything builds in some cases. If
> instead we went back to the little ifdef snippets, such as this (from
> v5.1):
> 
> hugepage-shm.c:
> 
>       #ifndef SHM_HUGETLB
>       #define SHM_HUGETLB 04000
>       #endif
> 
> ...then with a bit of one-time, manual effort, we could get everything
> to work at all times. And that seems better, doesn't it?

I'm not a fan of fixing up host headers on a case-per-case basis using 
ifdefs. It makes the tests harder to read, write and maintain.

We do have the proper headers in the tree, just not in an consumable way 
for the tests.

Ideally, we'd either carry our own "consumable" version in the tree, or 
are able to convert the headers under the hood and place them in a 
directory where we won't have to dirty the tree -- and only tests that 
need these headers (e.g., mm selftests) will perform that conversion and 
include them.

I usually build my stuff in-tree, so I don't really have a lot of 
experience with out-of-tree selftest builds and the whole kernel header 
inclusion (and how we could avoid the "make headers" and place the 
headers somewhere else).

-- 
Cheers,

David / dhildenb


