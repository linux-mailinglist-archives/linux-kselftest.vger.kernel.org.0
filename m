Return-Path: <linux-kselftest+bounces-24463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FDEA10CAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BD816305E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767BE1D47BB;
	Tue, 14 Jan 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Abi+VcOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260E1B21AD
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873379; cv=none; b=C6xVjkFLK4FLQt0PIfkyAwM8O/Xd4shcMxUAPQcpVwygCzGwy3KX4XfjrzbXrsygdlnhyRKrPZpAkpMeiBs3Qs0HXy1dyF3FoSW/iFJIHpzuTCI2FRqPPhYFKDoWRxMCWMLOr915DGG/R558JoyYYaUKnVi87NeXkC64t1zZcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873379; c=relaxed/simple;
	bh=BMlCOae7Wj6SjTMxH02RsjJjI/ets9dgYNnwGlKC4yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKhQhEFO5jaC4j7eYjjQlVHHV9iWATmxRcc/t2OOqKcxi0yRxmgF3ZXy37EzriYHDyFbZvBbg+Nc8/ePm59CUpojx0eMwMO3wyZZCzHTBSqYyuSV7z+pRM1qV/8OR1KzR/DhxayfZlpBs2BI4TLqgTIHA4tjjSWc+MI5rO4excI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Abi+VcOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736873376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=phlr2P2Bd9OZggweW2xYFMsNy1St1AWnhTYL3T3s0vQ=;
	b=Abi+VcOaanO01FT4dXA5nOKl8yxWx2k2zST1WeH4OUBdE2QSpzhU+vx4ZBPJ1xNI8gxaeC
	TiNiz3RIENikHO/Ue0Ge5yd+DUS8PH1LhtvsMY381u38JfMjWvRJ9+WLv7fOSfNuMOHoQc
	hN9t09w1vYyr08nBaGUpDPvvxoMpW6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-hKM2Odi6NO-Rp2Xin4pyXw-1; Tue, 14 Jan 2025 11:49:33 -0500
X-MC-Unique: hKM2Odi6NO-Rp2Xin4pyXw-1
X-Mimecast-MFC-AGG-ID: hKM2Odi6NO-Rp2Xin4pyXw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436723db6c4so39097305e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 08:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873371; x=1737478171;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=phlr2P2Bd9OZggweW2xYFMsNy1St1AWnhTYL3T3s0vQ=;
        b=eBHEUcw0j4vM3Rrap5nJ9r/TxslRi9btOYIK6FZdzNzuzPFPNHmGWvoCw2MUDOV+jy
         9eFrsu3hSwbpjk/Wmxid00MPbIbtXntWN2fG8RlssPVSV+WrT5u+0VMroibaWFO/skRZ
         Q9QWAjSJsJ44VPt4G41g67dTfvKI+SX9uULYQVCl8GnYCpTbRsHnG5VDx9QRkKnRDaAU
         QHkb9n2NPyBC+wUxU/kX2wSN8XkUXdQu80GAwSV8CNXMZfvo6YbFo8ecJDcJbvjiFMNn
         XWA6OOAaAdT/b/XNSHjb+dhL57mdjj6M4Ul1GxmCSNApQPDy58+IyOJoAdZLErKxTEQc
         xqNw==
X-Forwarded-Encrypted: i=1; AJvYcCURxaKTkmEO4ggsVk3EnU49o4wohCrxg2vV4fKIfLe1FVVhn8fTa8+WmvycOFso3Dofs8mmor0Yk9Fx4XyNmxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/kVEuvp5JACDV1RS6azbCXTFOVuychOKzbGk+pbbdqmxAWpD
	EMetX9ZWgCFexO1hjzJ64fpitJaJ++ARmNrcO17rWGmaY6ujWzXWcxyodhdokRpPPMjcbwuh3yU
	FoDVR8IbpUH0UCWxslQy9w/dcuA+SS63lxzBvKF4mjz5iWLESGX8KXlZjRUmxiq3cBQ==
X-Gm-Gg: ASbGncvJOKvytmdcgZVfEvT2UQEq41JTdcs6tYiqQ9EW6Q5Fvnm8N82A0YCZHvvWItO
	c4n3zdbHQV0Bspwjwfpma+WpuwQ+ImUzo7BESrK5LMwC4mlSZ4khb2pNZzeTlNumtuSwl4EGK8p
	WdnkL34yVwwpSuWF4SV2XzncNHOBTrPSDhsX0PEV1JwR5UTpGluxYA2NPZX/F3ah+vrkHiT6d7O
	5VOpy9ZVsry+jhl1DROOg5+jD+mxlUzLERLkZ2joP00aqnG9wSftHY0BQEZgFJLHUQy8HwrXpck
	Yj/gwPSASydCGA0cplANX3oavFyQcFWTacosqFx26i8E45XL8WslrG7no9HDed+fG2WC79o8PHS
	qd/xXvXcn
X-Received: by 2002:a05:600c:3c9f:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-436e2686716mr229898495e9.4.1736873370798;
        Tue, 14 Jan 2025 08:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR+NAZOHYpGvs/S1fzgk+OWmBa299GHLKJtiiwOGgut9bjrcuEoEq6+e2QmWHMPB+PR6kO1g==
X-Received: by 2002:a05:600c:3c9f:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-436e2686716mr229898305e9.4.1736873370477;
        Tue, 14 Jan 2025 08:49:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc81sm183799285e9.5.2025.01.14.08.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:49:30 -0800 (PST)
Message-ID: <1ac24517-6f7b-4923-836f-2b4284a46a41@redhat.com>
Date: Tue, 14 Jan 2025 17:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests/mm: virtual_address_range: Reduce memory
 usage and avoid VM_IO access
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.01.25 17:06, Thomas Weißschuh wrote:
> The selftest started failing since commit e93d2521b27f
> ("x86/vdso: Split virtual clock pages into dedicated mapping")
> was merged. While debugging I stumbled upon some memory usage
> optimizations.
> 
> With these test now runs on a VM with only 60MiB of memory.

60 MiB ? Crazy :)

-- 
Cheers,

David / dhildenb


