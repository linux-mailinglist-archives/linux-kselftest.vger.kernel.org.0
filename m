Return-Path: <linux-kselftest+bounces-28518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3259A56F7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBD97A4F0B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA9022173E;
	Fri,  7 Mar 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SN0WZZdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F8187346
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369576; cv=none; b=FyX8ut/MZ/3GGzICXzFNjUzf78zUYrnAqu6Ex6FeCwlxdFi7BvGdZuk3NfBj7FXpl/x2pKPPo4XzvNpc8flPBupoyW1t9CBMKBhokgPU9D5V5G6DC8WS6sCdlMaTq58zg0hzuX4KNWpSDRa3wPVHIGyutUGkMB9kyrUpZrxoEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369576; c=relaxed/simple;
	bh=Ck64soIjBUbbI8eQv8uM0301JaHYNiwENDn9InlDS7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZTWhlXX4ODKLUZwJEFHNOPpoZhAp7m87OAoIJFlSxeE6H4ppLKVjkwcQMgLgyeeE7OHAm4PnLmNMjnVYMlCESG1GD79k+Q316pH60CobMEWpICZGkLSo0mZaZQqAcWTsCfrdspU3KEjjJbF6mPLleyu0z2ByaEC3avMuOCVVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SN0WZZdb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741369573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s0d46d85j/SCNs/mf2/DYy+Wd/1PTHrrROSv3cRDEGE=;
	b=SN0WZZdbe6wbSU+MPK3SV/8n1ZBVW/Z//WvTGXUqsLhjs7aBdvUZ5VtpiMviQodSfB0jyB
	hnEtYf4wv2puOhnSu/gwr2JOduDasGch4/i+X63+9IcxRbj9fF/qOhMQ4TKxgrqS1paIxC
	6MhUr1QDODjMfykW8Z5BX50VNDP69Qc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-LTZmOjPmPd2tGclcDUGatw-1; Fri, 07 Mar 2025 12:46:11 -0500
X-MC-Unique: LTZmOjPmPd2tGclcDUGatw-1
X-Mimecast-MFC-AGG-ID: LTZmOjPmPd2tGclcDUGatw_1741369570
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so118698f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Mar 2025 09:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369570; x=1741974370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s0d46d85j/SCNs/mf2/DYy+Wd/1PTHrrROSv3cRDEGE=;
        b=gRPSGrDI8Gki/6GOOlgNpFbZBNKlY4gOBAtkqqhJj/9jq2dr9aqv3gjdIx5turRzK/
         Uvp3LbGh8zhLkr3iRGw2C1zLrsgGnQVbcUC1057XVAe15gv7lGdhLGA4ng5kY1vHGTRf
         jdzYuFiptuMcB9iS8+kSp5kzAHdQs+xnHndjlfKlBNUQJ7Zt9k2Usbcz7+fJ/KcO7acH
         gduJNj3Ff93KBC8c0zCYjOEUzOzjOyp1aakCZXYbdyUpe7eCxwOmTMtEmac7ckvETekk
         JYxAaFSzGwnZxF1ntdnxstRvZIpAbCNZ+CTxDS8MnzZ+3LTDWmSSwWMpJh0ySEngP8dK
         GBCw==
X-Forwarded-Encrypted: i=1; AJvYcCWBhcUpn/Q4cFDWsrkw0iizgbnd/J5Uzud6rBxEC3+4HXOA7tANIW7ckb6I91xb/18IHKDiTB7u5KpIGOZY3Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6ToItljCgk2GBye0sN3zCK6+MnpF7HbdwLc5JKLrgC1WqKLU
	/cUOCnZ8ou7hiWDrGgQDvIgHe1fTSef7XRsqeujqAx/ylJsb+/ZgbbdC14YO6EC/cQU6i9X7N3K
	WBlvEPl1CGE4TrCLhVm21f5jFbsenJdakVtyhu0baBuRub6ETmtm6mzQDnPEzl2tT1Q==
X-Gm-Gg: ASbGnct+F2r57V9NXkVL9+TzMg24w2D3fp3Ask9QaoSSTk779Vd4zhnREThumWMuNmT
	JECg+NZGoLzUi+hsT2zr9wiFs7Q6kAhbmorRGeU7C+sjErCAL23E1yX9vPE/02LgHHVmp9OEOwO
	JRfoixC23M/ltqOT3z0acSDRlB/Jqt2h5gZUe487VGAXqytlnBbv+YnksHIBJrzwWw5kNSICuRo
	1ZsYs7y3yrYgn/gsDjqUkflrJZ4UyoKzQbPF7Fl60316zxMOWDNtvLcgCpKAlTESyMiKYzwNXtj
	+hauX9aoNY4rAY5gyq1wv44QdpPb2BJ+uq2SErm0MJzccyQvLlECnWgkW3nwJ+rzcWPm3hsKJQu
	IQhpekt6ShYX9zSHKqnqFn2hpSOi2UlyUr1NQcQ==
X-Received: by 2002:a05:6000:1542:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-39132dacdddmr3472048f8f.38.1741369570328;
        Fri, 07 Mar 2025 09:46:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEay378VfGx6HjrKKEru31t3Xw9A5Kakd8fIT8HXoafjGBKv2vfMbbU/t5rI7i224hxbdeqqg==
X-Received: by 2002:a05:6000:1542:b0:38d:d0ea:b04c with SMTP id ffacd0b85a97d-39132dacdddmr3472030f8f.38.1741369569920;
        Fri, 07 Mar 2025 09:46:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17? (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de. [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfb16sm5971728f8f.29.2025.03.07.09.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 09:46:09 -0800 (PST)
Message-ID: <72fd6f77-736f-4b38-b541-f5027925660c@redhat.com>
Date: Fri, 7 Mar 2025 18:46:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
To: Zi Yan <ziy@nvidia.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
 <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
 <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
 <4a9f102a-60db-475a-a933-975edb2fb1dd@redhat.com>
 <3E7D36DB-287A-4CC5-9C1C-0E9A35A95B1D@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3E7D36DB-287A-4CC5-9C1C-0E9A35A95B1D@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.03.25 17:27, Zi Yan wrote:
> On 6 Mar 2025, at 4:19, David Hildenbrand wrote:
> 
>> On 05.03.25 22:08, Zi Yan wrote:
>>> On 5 Mar 2025, at 15:50, Hugh Dickins wrote:
>>>
>>>> On Wed, 5 Mar 2025, Zi Yan wrote:
>>>>> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
>>>>>>
>>>>>> I think (might be wrong, I'm in a rush) my mods are all to this
>>>>>> "add two new (not yet used) functions for folio_split()" patch:
>>>>>> please merge them in if you agree.
>>>>>>
>>>>>> 1. From source inspection, it looks like a folio_set_order() was missed.
>>>>>
>>>>> Actually no. folio_set_order(folio, new_order) is called multiple times
>>>>> in the for loop above. It is duplicated but not missing.
>>>>
>>>> I was about to disagree with you, when at last I saw that, yes,
>>>> it is doing that on "folio" at the time of setting up "new_folio".
>>>>
>>>> That is confusing: in all other respects, that loop is reading folio
>>>> to set up new_folio.  Do you have a reason for doing it there?
>>>
>>> No. I agree your fix is better. Just point out folio_set_order() should
>>> not trigger a bug.
>>>
>>>>
>>>> The transient "nested folio" situation is anomalous either way.
>>>> I'd certainly prefer it to be done at the point where you
>>>> ClearPageCompound when !new_order; but if you think there's an issue
>>>> with racing isolate_migratepages_block() or something like that, which
>>>> your current placement handles better, then please add a line of comment
>>>> both where you do it and where I expected to find it - thanks.
>>>
>>> Sure. I will use your patch unless I find some racing issue.
>>>
>>>>
>>>> (Historically, there was quite a lot of difficulty in getting the order
>>>> of events in __split_huge_page_tail() to be safe: I wonder whether we
>>>> shall see a crop of new weird bugs from these changes. I note that your
>>>> loops advance forwards, whereas the old ones went backwards: but I don't
>>>> have anything to say you're wrong.  I think it's mainly a matter of how
>>>> the first tail or two gets handled: which might be why you want to
>>>> folio_set_order(folio, new_order) at the earliest opportunity.)
>>>
>>> I am worried about that too. In addition, in __split_huge_page_tail(),
>>> page refcount is restored right after new tail folio split is done,
>>> whereas I needed to delay them until all new after-split folios
>>> are done, since non-uniform split is iterative and only the after-split
>>> folios NOT containing the split_at page will be released. These
>>> folios are locked and frozen after __split_folio_to_order() like
>>> the original folio. Maybe because there are more such locked frozen
>>> folios than before?
>>
>> What's the general concern here?
>>
>> A frozen folio cannot be referenced and consequently not trusted. For example, if we want to speculatively lookup a folio in the pagecache and find it to be frozen, we'll have to spin (retry) until we find a folio that is unfrozen.
>>
>> While a folio has a refcount of 0, there are no guarantees. It could change its size, it could be freed + reallocated (changed mapping etc) ...
>>
>> So whoever wants to grab a speculative reference -- using folio_try_get() -- must re-verify folio properties after grabbing the speculative reference succeeded. Including whether it is small/large, number of pages, mapping, ...
>>
>> The important part is to unfreeze a folio only once it was fully prepared (e.g., order set, compound pages links to head set up etc).
>>
>> I am not sure if the sequence in which you process folios during a split matters here when doing a split: only that, whatever new folio  is unfrozen, is properly initialized.
> 
> Got it. Thanks for the confirmation.
> 
> My worry came from that after I rebased on mm-everything-2025-03-05-03-54,
> which does not have folio_split() patches, I see a crash saying a buddy
> page is hit in __split_folio_to_order(). It turns out that I did not
> add the changes from your “mm: let _folio_nr_pages overlay memcg_data in
> first tail page” patch. With that fixed, no crash is observed so far.

Ah that makes sense. Yes, it must look like in my original v3 that was 
based on your patches. (now it's the other way around :) )

-- 
Cheers,

David / dhildenb


