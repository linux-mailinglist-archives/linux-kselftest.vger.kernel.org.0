Return-Path: <linux-kselftest+bounces-39285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC3B2BAB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF071655B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833425D1EE;
	Tue, 19 Aug 2025 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmw9HCgB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083C1CAA79
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588509; cv=none; b=EhRnehHB/wd8PkmmKBHHESqdQdP0wlKzdrxgasJkd8lrpDyqke45NruTIzCV1/vok4fa6GxoD6X+wUQHLccna24yePrZdBv5pzGvv/BTBTGwrG0eJB5P2Jn9hUWoyhjRTXgaGyqXZSo3VpPH4nnzsI56iH9JXsLK7BLrkoJ8tP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588509; c=relaxed/simple;
	bh=cT4WYpP8Qioy7fE042CTr3k6lWVzIvtbP3YdH+eh4Aw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZNgM7oq5C6eEY0W5zE82Vt7LcUXze28MKDZdYFN+H9WEKHfy3eI/4SFq/9nHuxM0NbiE1WO29Gi3PoXHvyLmF/YJLwJ4MHcOOtb9p/pXRZpjvg9zpoJ4gw3koq9N3ys1YTMFEFcKlRpaYXEDpJDzov0AvVuJxOVa62cECoIpsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmw9HCgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755588507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C67CXYyWZPL0PYQM1CJnzY816eVbPhG0ubvsjsSE9lw=;
	b=gmw9HCgBihkdRlU5fpFebSn3u616/b+C/3/4HN/u95qlXuJ+cs7pvf5GOoWhXhciR86LCZ
	kqFYEcDe3co60tBJO22LX0SNka+WpBj+LSZj34RZOV76Qjv2NJH5ixl+IIsb4D/WXAOWUX
	3ehIUbJ4odTCzuPYjdEFWPCguJpQ/CY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-OZ-m7QowONKfL5kJgQbxdA-1; Tue, 19 Aug 2025 03:28:24 -0400
X-MC-Unique: OZ-m7QowONKfL5kJgQbxdA-1
X-Mimecast-MFC-AGG-ID: OZ-m7QowONKfL5kJgQbxdA_1755588503
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso24935785e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588503; x=1756193303;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C67CXYyWZPL0PYQM1CJnzY816eVbPhG0ubvsjsSE9lw=;
        b=mN8p/2n2aSKIt1GUd1x6vvdzL0vzSSRHk+IfKUFE+cHXCVBfHpC7+jOZQ44w5mwOem
         MBYUneEB3NtA+f/Z/e/jTez4lwtaL/45g2H6GqIclKGx1EvCRZwkDcdehvvvRocHAwp1
         sBts6P1B8ht5SodrrdqSLfcda9T7tfwoj8c5N+gWR8qNUmIugRbuqYo3Jes8fHFoJWhV
         nhnyou2Dkzb8PI9018TS/ihTojHXJCvXsSiavKE12nUyZkCceo0Q0e4A3wGBlZgv0Cw0
         mjb+1Bd4MenwMiLhkF2cZu1EaRPQiuq0yXUZPU6xLoZvWBX61uPJS1fuoeZvSE7gxjPg
         vk8g==
X-Forwarded-Encrypted: i=1; AJvYcCXlD0qqVR00hqXesFvSWRM2Aa1pSBt0LDDoZ8iIkzg8jRBp1zSCQ4o1WgYRYC3e1JjbexLOGNAZVg5yKDuU2t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysDu3iT+pbcKoh4WiCuOcW8DnNzB/L+HnixevUCJqF4w7AYb5
	n+QmffS68yydNW9jRiznn3GJsvObqihfh47Lz+5SObwMQ1lQWkKSzsbGU8vcsm6/pF8kZZlfb7I
	EBqP1UdwE6WLfJL4xxpKypTQ4vTcuVSma1DAyxPa4hMv3Rwg0I1hndbHvQB1fMaAv3XE2jg==
X-Gm-Gg: ASbGncvwcFbDYwL3P3z0P13zUz9rZlXUU15oEKFswAffqA3eK2/Tq+onRnmmbdqFJDG
	0TuhEG/nk2oAJOZIR8iAHtGyPLYoaBVks9Oqa10Ibn5wnrw/KvDvm/rL2c3zxUnw8nzCbXzMB7r
	ASY4rL1sVlqJWMYNXInHIN0sbtVhLkLlp6VYI979nV1+kC2ieiQ9xhuUHYBV5a8yemlQYqVorT1
	k15OqjPm1bo1xkXxV0uNyZWXsoSs5grc//hToI7t11BO1PEa79s1H/qKweu2/EYtTWlfhIi/QDv
	DYL+doPSFzJ2evjCo6TGTIJrBhyIaJjw39Rwwxr+4pY0HB+hQRXWIxBoMCu4dEYwjgsMMdTPQdR
	0/kdLphKDB8diPPItBOi9ByPa/Tob6k7/CmaTcvYfPwyqnX7XG8AXRSzKNsQ+upycHrc=
X-Received: by 2002:a05:6000:4304:b0:3c0:7e02:67b5 with SMTP id ffacd0b85a97d-3c0ed6c3818mr1051979f8f.61.1755588503169;
        Tue, 19 Aug 2025 00:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj/WjMJBeZuYEAK7dIsLoScszwyn3R+S0rUMZyxDPtfbSfFcyjc5kvMjglgW5na3LwlXjxrA==
X-Received: by 2002:a05:6000:4304:b0:3c0:7e02:67b5 with SMTP id ffacd0b85a97d-3c0ed6c3818mr1051947f8f.61.1755588502732;
        Tue, 19 Aug 2025 00:28:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c16fasm2472720f8f.35.2025.08.19.00.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:28:22 -0700 (PDT)
Message-ID: <38734ae6-012d-4630-8bf3-efefb65f0d23@redhat.com>
Date: Tue, 19 Aug 2025 09:28:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Fixup PATCH] mm/selftests: Fix formattig in split_huge_page_test
From: David Hildenbrand <david@redhat.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250816040113.760010-5-aboorvad@linux.ibm.com>
 <20250819041239.167537-1-aboorvad@linux.ibm.com>
 <8142d36d-2a0e-476c-8250-1a69c1f92913@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8142d36d-2a0e-476c-8250-1a69c1f92913@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 09:25, David Hildenbrand wrote:
> On 19.08.25 06:12, Aboorva Devarajan wrote:
>> Removed an extra space in split_huge_page_test that was introduced
>> by commit 4b76e221794b ("mm/selftests: fix split_huge_page_test
>> failure on systems with 64KB page size").
>>
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>> ---
>>    tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 54e86f00aabc..faf7e1f88743 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -544,7 +544,7 @@ int main(int argc, char **argv)
>>    		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>>    
>>    	nr_pages = pmd_pagesize / pagesize;
>> -	max_order =  sz2ord(pmd_pagesize, pagesize);
>> +	max_order = sz2ord(pmd_pagesize, pagesize);
>>    	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
>>    	ksft_set_plan(tests);
>>    
> 
> Please just comment next time one the respective patch as review comment.
> 

To clarify what I mean is something like this:

https://lkml.kernel.org/r/3dca2de4-9a6a-4efe-a86c-83f9509831fc@gmail.com

Gives more context when the subject directly highlights to which patch 
you are replying.

-- 
Cheers

David / dhildenb


