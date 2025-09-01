Return-Path: <linux-kselftest+bounces-40396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA6B3DAEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD920179C25
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207F26B769;
	Mon,  1 Sep 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Efi7unnD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755E215F6B
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711373; cv=none; b=OrfShBX7H0+milhLVqce1C3e5JCHejoZyQFXlP36hfMepIKmY+80C8Flhz3AwZ04NtmXbH+ZLKbrhi/IY1dJsBRUZly5HXRnttNNmW0wv05mYLFVt/56J6RKwcQCBygYMqfYs/TmauxyMZ3BzTPiMwiPU1bJugZAv6y5ZbGBhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711373; c=relaxed/simple;
	bh=BzxkO3pHiNLUfIzrm/BhuZbnhHATcTEr65jx90yE2R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8+a9m+tJO83XSaYgvj7SMs9ORTkX6+ToDQtZ6uo23X+9hJS/jpCGJn1YxXCVDvJIQUfc6Af+G6GtZe+/Outv4ZfkXJe0gWNq2DziHdE3Tb4qEu/sd32xZRfCERUDs08CLR1QqvbSA1gyDiwu0Aewe6KGkxiGRToeY9Ws68q1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Efi7unnD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756711370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9V4R05sdobHBJHmAx3r85pkYP3EzkYBt4hLu36K3MfI=;
	b=Efi7unnDemj0Q4uGMkFdTKPaXwDxOviNb6Hyx2JWxmI5Nw1+d4efjPx2F7gge+Pp/+SsRC
	PssMaLdsKBpfrQRYA8ffuj9zu0oSL3AC56tQTx7NGrCC8PfJq32urkO40W/WHrbIxdvOI7
	gMY6WDX7Pwyio5q0iANxkRzqkkndmHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-OvgU4xQfPluLlOLtt0vkiw-1; Mon, 01 Sep 2025 03:22:49 -0400
X-MC-Unique: OvgU4xQfPluLlOLtt0vkiw-1
X-Mimecast-MFC-AGG-ID: OvgU4xQfPluLlOLtt0vkiw_1756711367
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d226c3a675so824042f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 00:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756711367; x=1757316167;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9V4R05sdobHBJHmAx3r85pkYP3EzkYBt4hLu36K3MfI=;
        b=fEK27OcPSqakDUXU+Gk/n8jPQQLw3geMv0IcDQ/LasnL5bf7WReL1GP0LRjdsuzeP0
         lsrzlW4ysIQMwDFxYQWRX3Tbp8JLIfiyeMvuWeTLpi/yZvGEaLMtxHvX7Ido4X2nvagQ
         +N17Uc5E6LRtjUXXiqjDUtU2+6isj+f/MH8BNBd8Y72htCmWBWkKBu6qXVIjrhq5tghp
         c5wYuc2TA8aqD9MFdl/xTulbtR47Ot7o+8WOinFfoDw4inLkIftT7eB1bguOli+3GXku
         IWIzenihw4I789CowokMXxtKet8GbFvyvkxMhnno0l9wAHHAEEIOAcCX63Tev/tZaVqn
         Cb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuVPVmztE69CcSRxVktSQ9q9SOkodk/beCiPEaJWHN+s2W+DAVku3SjVO6k2l8psEdOQO1DkRq1254GAkTgtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1EJuQDAAZ9FXcXO6v3K2Z8SuOcJNM5hP5faY9xXTPBOKQD+O+
	epuSSfztv3qRF/mVe0BUjDJTp0WuiTkfNHfRJHaoZl4GYV2UJP2B3ZQk6vEwxP1XmFyD53C+Ezr
	LiXV7FzljXMIJgVWjiRFsVstb9vnYnD97hd6WHUo1FIZSdN0jfcj9//hfoNtP+qwtEPvQlA==
X-Gm-Gg: ASbGnctf5taBhUctOscjr5ZysUbxK2mCKNam6eoPM2bLsBgMmsIVssGbLvKFqfZPKXf
	piI8yQpT8YWMCPNoClH0IPmH/agLUXAVXTbisRlEz1zh3Kpg+bkMjohjxA+/rsOE3kmPCVPP9cn
	PKovTm9CsHGbEPGZLSFuZUPDiSXiv9VQ4iZ75y7gf3BPcDzhxC2cHEIZ4ihzoWlTL9+HwV8VCEQ
	9dBKJ5y7hoHF5Oz2Z6eG8C73bIKgLjCTf+N/yfBb9zoU2l80QVc4kdPPwz0q9KlbrTBc6I3PNR5
	L7lmXJZsvJrvNjnj3twuA6I+xVrqrewh1noXMGw+ywRvmkqct4wcZe8BlT6OEpTNlmsCPlX9ohO
	8xZ8Z2BTWtw1YD+jRZri6OY9m7DEnQTjngaw32PmVvpYjt/jQqJM6er241clxWuRprso=
X-Received: by 2002:a05:6000:42c9:b0:3d1:e22d:df2f with SMTP id ffacd0b85a97d-3d1e22e12d1mr3737087f8f.23.1756711367091;
        Mon, 01 Sep 2025 00:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVNYjwWcm6gpW0uY4rkHHxrCMQOJdbdQbgUiX4+ObJzl258/8a6I3ZT74/QxiH1Rpl4yYyjg==
X-Received: by 2002:a05:6000:42c9:b0:3d1:e22d:df2f with SMTP id ffacd0b85a97d-3d1e22e12d1mr3737072f8f.23.1756711366670;
        Mon, 01 Sep 2025 00:22:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9cebsm13932480f8f.46.2025.09.01.00.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 00:22:45 -0700 (PDT)
Message-ID: <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
Date: Mon, 1 Sep 2025 09:22:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250831022701.2595-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 04:27, Wei Yang wrote:

Subject: "selftests/mm: verify page content after remapping PMD through 
PTEs"

> After mremap(), add a check on content to see whether mremap corrupt
> data.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> v2: add check on content instead of just test backed folio

I'm confused, don't we have that exact check later in the function?

Your v1 might have been better, unless I am missing something.

> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 10ae65ea032f..229b6dcabece 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -423,10 +423,14 @@ static void split_pte_mapped_thp(void)
>   
>   	/* smap does not show THPs after mremap, use kpageflags instead */
>   	thp_size = 0;
> -	for (i = 0; i < pagesize * 4; i++)
> +	for (i = 0; i < pagesize * 4; i++) {
> +		if (pte_mapped[i] != (char)i)
> +			ksft_exit_fail_msg("%ld byte corrupted\n", i);
> +
>   		if (i % pagesize == 0 &&
>   		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>   			thp_size++;
> +	}
>   
>   	if (thp_size != 4)
>   		ksft_exit_fail_msg("Some THPs are missing during mremap\n");

I'm a bit confused with this test in general.

We do a

pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);

which I read as a "NOP".

Questions

(a) Will this actually do anything? Also, maybe it does now, but can't 
the kernel just optimize that out in the future?

(b) Is it even guaranteed that we can access > pagesize afterwards? I 
mean, we specify MREMAP_MAYMOVE.


I would suggest to just use mprotect/madvise to pte-map a PMD-THP.

This is, of course, independent of this patch.

-- 
Cheers

David / dhildenb


