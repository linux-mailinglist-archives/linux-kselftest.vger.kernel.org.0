Return-Path: <linux-kselftest+bounces-11927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B025A908AF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 13:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339C328B1F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8328195B01;
	Fri, 14 Jun 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmByOVj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF219599C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365358; cv=none; b=ZtxqP54dwzVZdLCEB3o2o6yT5aJL+RDazXxBT+sFYmb3QpAJxbFbqR6h6CqMpOuuD4BmXzSWzlvlJgT3JZsThKK4T2SC2sdhk0eYDZqmqt+KAib08dpMTGlbAfAgqbWVDWNYe7fHLoO7Zbo+KbHlBq/rCO/1MyOwFn+k+FOQuLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365358; c=relaxed/simple;
	bh=hVZaXClb8YH9qvz97ZEwzE1i0kxb6RNI4BzeFUGcHdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeIbKrmFRoEI7uDW46sZYnZ5ukvcTJB3m+I97WLlxhWcu9vNzoDiqf0lnKBTnu05Bp5Odth+pzOdSXmlwFamc/kXJhNsrWFEMVjjDLg42lD+HsJS05k3bkiaMn1lNdWGZIFwndB3eBQOLChCI+dXf8Xt4tMlf2mK7scrm+69hDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmByOVj2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718365356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XXNWd08UpDrUoLaDSemWxBmdphtjcrXbt9rmtguMKlI=;
	b=UmByOVj2LEIG5Lm5DQKSr+Hgk27YPfNBd8au2CU0n74T2L6DLnpjOkiZrlmh36qUMhPkDN
	POKp3IapvYEC+SueLPIDpR5O4UMnk5BqPwxzT01egsDrrZQPs4XTXaZBUxQHTHUNeROg0c
	4dEEuJ0PT7vwVKuCZsDQlrlIzi/Ddoc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-PUKW4_4_P1ShjFL5Gcx-eg-1; Fri, 14 Jun 2024 07:42:34 -0400
X-MC-Unique: PUKW4_4_P1ShjFL5Gcx-eg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42120e123beso19537365e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 04:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718365353; x=1718970153;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXNWd08UpDrUoLaDSemWxBmdphtjcrXbt9rmtguMKlI=;
        b=EYY/toQJxMpySumGLkjyeIZAqr2K5J/b94vR9keR/GdtYoV32UmuGJpOnE7Z7/Trx9
         ejIBuOMNXPuPBi74zcFONO7WRmgE6a2DmXyaCSqseT40BV+LwXavooB9Mu3W+qxRUf36
         xq4FyMLR11lfXpJEAexBeBeqQe1ltO1oQ52fmpShus/Pz1OH55xL8xn7AxjFbR8GrNDj
         sFQWPGlrJr1hBtyT2eSvOfxL4Kh6YbLRq8fwPVOx1sjwliiRVEX5xepFqUwX0RqmTZfB
         m2G4CVFAK/X9ZLa2Su1S+fP4Bpy63lTwIz0u8oVJsa9RHN3jbhznk7T3Gy2b21E2Dj69
         hdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXLw4/4k+ZGmtcYv9XCEjx+u/B8uBla0DtSf8MFXIYsILk6obeoqm+hkFlybKnmvRabVFW+HbM1AOBEJgXfhn2w3WKZL7eIV4ep2SwN7K0
X-Gm-Message-State: AOJu0YwFLkVrx7x6v/px4hfuCV7Hn+iO3gm7p3kHIYNW4ypSkSkmLm7w
	J9+yafUmGV8Rfx9mjYYedF6C1ToMMs20HViAViZPb8iFDHUSu/VRIS20gf0oUhR4C4pysLd4UWk
	HqWdDWorq+Wuo6Q2tZxpwHfWUN+MyhRdDuK000vkEEqgw06A+zFVciDHrkV0TjIRxjw==
X-Received: by 2002:a05:600c:1f94:b0:421:f43d:dadd with SMTP id 5b1f17b1804b1-4230484c52bmr28971855e9.33.1718365353468;
        Fri, 14 Jun 2024 04:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtUipV2eNLCznRAMcgt+sPsKPl3oqaV9hUdXChEZr6dor4vA/9vXUz0gOGUwmWG/ulsqqu7A==
X-Received: by 2002:a05:600c:1f94:b0:421:f43d:dadd with SMTP id 5b1f17b1804b1-4230484c52bmr28971655e9.33.1718365353069;
        Fri, 14 Jun 2024 04:42:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104a8fsm4169001f8f.110.2024.06.14.04.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 04:42:32 -0700 (PDT)
Message-ID: <b41f3392-fd0e-4df7-8e29-754def75376b@redhat.com>
Date: Fri, 14 Jun 2024 13:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <b5dd99c7-866b-467c-9f76-d043e887394c@redhat.com>
 <c1277bf6-a211-49eb-80af-726f16ca1802@nvidia.com>
 <17b503f8-5d0c-48a3-9eeb-85b01583f9bb@redhat.com>
 <b60c8c02-5497-4c6c-ae60-86309e55f1bd@nvidia.com>
 <2c6f86b4-8151-4bb8-8400-3ea546ca10ac@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2c6f86b4-8151-4bb8-8400-3ea546ca10ac@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.24 23:27, John Hubbard wrote:
> On 6/12/24 7:11 PM, John Hubbard wrote:
>> On 6/12/24 1:24 AM, David Hildenbrand wrote:
>>> On 11.06.24 22:54, John Hubbard wrote:
>>>> On 6/11/24 2:36 AM, David Hildenbrand wrote:
>>>>> On 08.06.24 04:10, John Hubbard wrote:
> ...
>>>> You remembered correctly, but the situation is slighly muddier than
>>>> one would prefer. :)
>>>
>>>
>>> Absolutely, and I appreciate that you are trying to improve the situation.
>>>
>>
>> I think the attempts to further tease apart the include headers could
>> go into a separate, subsequent series, yes? And let this one go in
>> unmolested for now?
>    
> 
> On second thought, it is actually much easier than I thought, let me
> post a v2 with the unistd.h header fixes, after all.

Great! :)

-- 
Cheers,

David / dhildenb


