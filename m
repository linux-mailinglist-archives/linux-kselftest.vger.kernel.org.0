Return-Path: <linux-kselftest+bounces-33454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0F1ABF33E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020D017C4E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6025DD0B;
	Wed, 21 May 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJhmoql+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA9258CDB
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828007; cv=none; b=XmI6jdH0TWuFhFTj0+4EzkK8J+uztaGsEmbJyEE0oxeLBW/m0/mOLT6ndga5PZiDK/wFkrg8XuyLFXWsW4GftG8hmGD3svi6i35dOMAnJCk0Rupq6PlSd4NgI58S7p76y2/k+dnLhgxGkvlzyFSxaVvkYLZU146S1kvwYaDaQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828007; c=relaxed/simple;
	bh=CQyhfmiJIPtxS6SipwLYsxZZA7U9rvkY4JzzJjSJNwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwbwYZFCiIVPyDJ6V0F8F1Q3HjtQQIWdHa90mPpHi8AthMOi/93DihpXHuMvGytfEMDsM1iZa+OatuE7JvECqkNalKJjXUTqubFkBEufOdYBWXqWuDpdGvRdrD1D1zaXjK+0B1EDDYav7l+qVouWacqrzEF2KcWn5lz9F644rHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJhmoql+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747828004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+c2fZNJNaDDZY5YZcoK6a646IJ0yGxQ/SXFdX2vKZlY=;
	b=BJhmoql+g1DdF2lHmjAFy4tjM6UBARuYPKPgPOXWOShSlx5g9pMw+bjPNq89AmEDQpNUI0
	B2W5fqHs0Jr6bNOBC3ND7O05dSfunR4sxtnjKaQxQuxxzlqj7w6FOoVg+/IQcIfrH1CNZO
	IH5Z046DTwwd/J530X+pP66aGnr9I8I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-xcjhnELhPlmKTiQSTm8Q-w-1; Wed, 21 May 2025 07:46:43 -0400
X-MC-Unique: xcjhnELhPlmKTiQSTm8Q-w-1
X-Mimecast-MFC-AGG-ID: xcjhnELhPlmKTiQSTm8Q-w_1747828002
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442d472cf7fso53128095e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 04:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747828002; x=1748432802;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+c2fZNJNaDDZY5YZcoK6a646IJ0yGxQ/SXFdX2vKZlY=;
        b=r/qhhIQell1RW3AsZrZFKRWxmbksuhuRjn7TkM4nK3LeMdcdO0+twr75MzinjjA+Ql
         LaULGe+wFB6I9OtmEPeGhT8ubF4Z+P7T0JsZDXGUzmw18d45aS9z50FT9btp2pohOk6E
         qakuEtQCoS+k6/eBuKgpOUHrZXscpwx0F0gOU+a3kc8k1AP3QigzP1n3MNQ/Davdgz20
         qwv1X4q9bLy5e+2HxHLyS73Mfj3LG2PbQ0O1clT81pvg86eR10E/z3jiu7KRL7A+RW75
         GXj0+6i1P6H9tE4s4KySOEy3MoY/iDcY3wb9mT7WCv9GdxLI2ZMwsFxftpTh9E8RhtBY
         pyTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq44KnN3A2B5Prhy9w6w38SWOWK+Bl09dO/G9pACT8j4DCQmkpXU7HmGHuzRc8HvRCKLhAeYOFXXPRNVFGDlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/IXfDNy1Hlu7BI57HHGj2z6wkHOGyzN0MG5SmIy5hwnxgI+q
	OLaUYB9ZFnYhRxk/A/4iWCwkEgIfXH/YiMUudprTklQ+beVE/yfYIo215E93gyAoRRm8QQslMVt
	nkcVnTsQIIKPBOksLT7MHSxcqqQRBLSihGCzL91J52e5qp6mEq0aGW9CS5ZLTv+FDNAUxYA==
X-Gm-Gg: ASbGnctmktUPYDS12wXEYYeW9IexThVkP6Sj+QuqYtONBX1nXdiU0n70tAiubEtX8Io
	TT1Oo7BKUMufppKD5a5lfAtQwMSgwWu/OLbjX1rLeQt+1mFCvk52Z62sYBxc15kRzJ4vwvSlIMN
	+EjggufJZJaOmoqJzn998q1AYPTpJpdpTnBnRRCjDJaR2lPePA7vX0PcMfauF7yEmRTis/rA+6g
	H0Ubs0LB1ncBCrUZwZamEqJxCIG6naVgqipJTccchPm6gGRms5cd2Hd01hPcn+JsAG3ByVwt63X
	Hl3PmjIzjMfKd5s9eWTjFus4nG9d4ry7ECvfHODWZV8tVqMCuI2gs0ZUpba5oaFo1nCXLSQgHTi
	sBN5qydObKOEO5F4ctLL7TmB20fnUgZDnPEOJD58=
X-Received: by 2002:a05:600c:1e02:b0:442:f4d4:546 with SMTP id 5b1f17b1804b1-445e6f11da3mr108191255e9.1.1747828001843;
        Wed, 21 May 2025 04:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhqr9Yfq/TYOMh88TpTfnLzxiUp7FXzDUK6sQRsZMtCRov/N3Ixpy4Ua1rvssjwE8+Pvki6w==
X-Received: by 2002:a05:600c:1e02:b0:442:f4d4:546 with SMTP id 5b1f17b1804b1-445e6f11da3mr108190945e9.1.1747828001430;
        Wed, 21 May 2025 04:46:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7bae847sm64283925e9.36.2025.05.21.04.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 04:46:40 -0700 (PDT)
Message-ID: <43d6aa16-3e52-45df-9366-e072c0cb3065@redhat.com>
Date: Wed, 21 May 2025 13:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 rientjes@google.com, hannes@cmpxchg.org, rdunlap@infradead.org,
 mhocko@suse.com, Liam.Howlett@oracle.com, zokeefe@google.com,
 surenb@google.com, jglisse@google.com, cl@gentwo.org, jack@suse.cz,
 dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com,
 raquini@redhat.com, aarcange@redhat.com, kirill.shutemov@linux.intel.com,
 yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com,
 vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org,
 peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org,
 corbet@lwn.net, akpm@linux-foundation.org
References: <20250515033857.132535-1-npache@redhat.com>
 <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
 <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com>
 <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.25 13:24, Lorenzo Stoakes wrote:
> To start with I do apologise for coming to this at v6, I realise it's
> irritating to have push back at this late stage. This is more so my attempt
> to understand where this series -sits- so I can properly review it.
> 
> So please bear with me here :)
> 
> So, I remain very confused. This may just be a _me_ thing here :)
> 
> So let me check my understanding:
> 
> 1. This series introduces this new THP deferred mode.
> 2. By 'follow-up' really you mean 'inspired by' or 'related to' right?
> 3. If this series lands before [1], commits 2 - 4 are 'undefined
>     behaviour'.
> 
> In my view if 3 is true this series should be RFC until [1] merges.
> 
> If I've got it wrong and this needs to land first, we should RFC [1].
> 
> That way we can un-RFC once the dependency is met.

I really don't have a strong opinion on the RFC vs. !RFC like others 
here -- as long as the dependency is obvious. I treat RFC more as a 
"rough idea" than well tested work.

Anyhow, to me the dependency is obvious, but I've followed the MM 
meeting discussions, development etc.

I interpret "follow up" as "depends on" here. Likely we should have 
spelled out "This series depends on the patch series X that was not 
merged yet, and likely a new version will be required once merged.".

In this particular case, maybe we should just have sent one initial RFC, 
and then rebased it on top of the other work on a public git branch 
(linked from the RFC cover letter).

Once the dependency gets merged, we could just resend the series. 
Looking at the changelog, only minor stuff changed (mostly rebasing etc).

Moving forward, I don't think there is the need to resend as long as the 
dependency isn't merged upstream (or close to being merged upstream) yet.

>>> Because again... that surely makes this series a no-go until we land the
>>> prior (which might be changed, and thus necessitate re-testing).
>>>
>>> Are you going to provide any of these numbers/data anywhere?
>> There is a link to the results in this cover letter
>> [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html
>>>
> 
> Ultimately it's not ok in mm to have a link to a website that might go away
> any time, these cover letters are 'baked in' to the commit log. Are you
> sure this website with 'testoutput2' will exist in 10 years time? :)
> 
> You should at the very least add a summary of this data in the cover
> letter, perhaps referring back to this link as 'at the time of writing full
> results are available at' or something like this.

Yeah, or of they were included in some other mail, we can link to that 
mail in lore.

-- 
Cheers,

David / dhildenb


