Return-Path: <linux-kselftest+bounces-41106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDCB50E74
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3505E5340
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421D30649B;
	Wed, 10 Sep 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/gg6LOd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6119D093
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486844; cv=none; b=PVoYVL9MqjOHfQVU6CybgNs0Im9Zn5UIK8Mju3+A2ST+S1w1yyoRy5bdV/Bw0LELLGT+lUKV4nxjjklg3XILO0a7W1U48M0rnemQKaWfahkavhQbxGo+uQJYaI6vuLR+rj8jgXAc6WmlaUHdbPDZxiP2xqKZHHdg3CWirGa8hYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486844; c=relaxed/simple;
	bh=0krdSigjkNWm4whsMe2fv8fzKfNF5OL8bcqbJw08UQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qmgxl+c/asb42EnGU7myqjDpYuNnDZxwyPOilufLKd6nQNkt2cttATINm6nlk5fQOOsIwIysRz5Op315h1maRWzLgjHuj4MbyttmUhiCLXmCpodtCqAZvKlCQpUqWXt7PDEkJx7zCH0iUszdv/9tG/fRvfp4bUB8zhj6X+QYeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/gg6LOd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757486841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DclbICh4vt4htwsTue4DjShXgYZNbK2BpNkYpPd7VQs=;
	b=Y/gg6LOdjvb45YIFSC4V01/hhOGrtMTxzoMN2T0WbEfIGLJKdczvs1Rxiuq00WCgXEMasi
	sOMmp/SQOw4+6Avdwdptn+yIZVHYY933+zKE1Rg8BUcA8GpUQdLsqnAw4/SdNLnRszZ5jz
	mLbScrz07GFtwEMOzozJnLk384byHfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Udal8JAnPvikUrL-OS0bVQ-1; Wed, 10 Sep 2025 02:47:20 -0400
X-MC-Unique: Udal8JAnPvikUrL-OS0bVQ-1
X-Mimecast-MFC-AGG-ID: Udal8JAnPvikUrL-OS0bVQ_1757486839
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso1850885e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 23:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757486839; x=1758091639;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DclbICh4vt4htwsTue4DjShXgYZNbK2BpNkYpPd7VQs=;
        b=ePIxfQFD7W9Tvx3I7vJ+T+GZ5dtsYuvO4dIcsGgdv5IqB6gpa2WQHZUJRuZddjgXDp
         AzvuTZMxlr570dgqoLV7IACEQaLN26E3A8Z/zOWA/6rPVESqG4tWUSWaREYuVPR1SBcg
         kz70kqOW5S151pk+0VSFHLukgKDTLSNTsgQ7ym42iY9SMy2Spnh3qkgNhxp6Y/KKZgIH
         gWxn8hXWv+LUn9ef3ZwFr6YStgOCTCokQUO/MT1MCS2p2vm6Iu4FF5nNI6V67hiaCblR
         h3CNjbM7ZTdZ6GcRvYu5KOgF/ftLbmdQ1y2/t7fy8hnktTpktXc9x5zH+LaqAfm06vt6
         tqSw==
X-Forwarded-Encrypted: i=1; AJvYcCVEnz976ebZaT4NVvNCn6VamQIvxa+3TsKBGkOdCT4Fqs8iu6VFQyjrODPsm5GKbBZB1aRu7maX/Keuv/YTfS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3pjitB+KNPVRA77R8ODvEWXVdkXoZ9QPoP/Ain+JQuOFbTVK
	x7m8Tuoqf57EcDVSx/+L/pYt+ZUjCj0jaeAcTEyyLPkjkDnpda9NczXmNIw/gl2OEMJx5ZpBK/+
	7IEFh/s7lCRmPXb+xi3VOECtnCg5j3m49PhWeFi5SPeW2zHVzygMvIkvYkyro3qqpjmarCA==
X-Gm-Gg: ASbGnctaFwUGp2VN4I40M8Ep5MTUQjGvVheM9cxuuqRx7fQVyJalPtZ6lXFPE475D3S
	J1wn7lDBRtroQ5jmacoxB6WehbaxQBpvCaZaMgP8VCusZoGrvstDUoH0EzPoOX+GU2hr9a0+4gA
	dtCDPUsHODN3b0OEQD2sSA4kE3JgY7mWGKZebOj+ChNDUdJTwQSRHPwwoIEfJlVos9mgym4e5W5
	75FafWL+T+9+lJ/tXcIU2s38y98LPDgsMwzgchP+Kb28fwLKIBPcP0DZZhtjEd0ihCaZ8gzm51v
	GQn09HaFVAg7u74o5aHP6DikJfMtGrKOknEdpZOPfX/03g3FzoGeG2+tecMBpqpn+mwaUlVFwle
	Bax0prWKSjs92QsOZjdpiV7/QSzgmnst0wYrlKayhobt/yFE+zfsKeB4sEZIMzmxKxzg=
X-Received: by 2002:a05:600c:3109:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45dd5b6870emr170580005e9.12.1757486838762;
        Tue, 09 Sep 2025 23:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83J5OJuXJRUwcDtMhsLLb63Ao7OmC+YBUOiY4RlDnVWFPTK7sefin7s19OlLvWaaiTz7/1A==
X-Received: by 2002:a05:600c:3109:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45dd5b6870emr170579765e9.12.1757486838384;
        Tue, 09 Sep 2025 23:47:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223898csm5855416f8f.39.2025.09.09.23.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 23:47:17 -0700 (PDT)
Message-ID: <837a56d1-38ef-453d-9b94-b151765d5b84@redhat.com>
Date: Wed, 10 Sep 2025 08:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
To: Zach O'Keefe <zokeefe@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909190534.512801-1-zokeefe@google.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250909190534.512801-1-zokeefe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 21:05, Zach O'Keefe wrote:
> As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> thp collapse no longer requires file-backed mappings be created with
> PROT_EXEC.
> 
> Remove the overly-strict dependency from thp collapse tests so we test
> the least-strict requirement for success.
> 
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> ---
>   tools/testing/selftests/mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index a18c50d51141..3fe7ef04ac62 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -394,7 +394,7 @@ static void *file_setup_area(int nr_hpages)
>   		perror("open()");
>   		exit(EXIT_FAILURE);
>   	}
> -	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
> +	p = mmap(BASE_ADDR, size, PROT_READ,
>   		 MAP_PRIVATE, finfo.fd, 0);
>   	if (p == MAP_FAILED || p != BASE_ADDR) {
>   		perror("mmap()");

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


