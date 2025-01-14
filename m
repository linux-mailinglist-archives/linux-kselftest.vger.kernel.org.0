Return-Path: <linux-kselftest+bounces-24439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649EA103ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90553A8E5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AE1C5F07;
	Tue, 14 Jan 2025 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeN6tk6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470E230D0F
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850085; cv=none; b=C06/rib9+/m0Fng2DvFwmppY5TeWPUORKM32KUrCcKFA0ZkSyrWsfSHqeADB/Wq8yV7MpI/ECzsfqjBJ/Fp+GPGVGFzXWpnrwtwUB09S5H65SZbe9mZjVmxFXTBpURc2W50jR33mp+nK7ePG9sTpOaRTPcLj+oI7RcTxPypFcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850085; c=relaxed/simple;
	bh=D8eUiETDdEytNg+smqfwnQkoBOOou42Q5oI6EK/SAJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtoGY+SMHLNWI9K0EJ+iOEQl5+LJDiGhTmyN7I9mOJFRkx/xcE0QzF4K8dGfjzJq2YYhIb/ad5hEWMb84Dq1S+gX58I7q7tLi01fTTh+7moJifuWaKnZAF+KcUg57gjDyEDHYA8qRxp9+lO5Y4oXxwRC7F3AjVtfqLxodnVwwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeN6tk6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736850083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v/eDGvYOLeDMHVMqWmrB864wlTs2RG2NStXaSHeGJEM=;
	b=QeN6tk6P8b5iRR6FaURIAUSr+2rE5F8zPg2hy9y33RgDurygOqSxOGT54iqEpAMMEKFMub
	uxNeRrjPX6lRvtZta3K+YJXiSdiT6Dz4NVTKQrICUDJj7AjEyPQAPGT6QRGjjczSCUtBGm
	sNF9vpUgwYGeHT68CkYaE7+db1eSZmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Qj9eFosuM5axRu33Y96O1g-1; Tue, 14 Jan 2025 05:21:21 -0500
X-MC-Unique: Qj9eFosuM5axRu33Y96O1g-1
X-Mimecast-MFC-AGG-ID: Qj9eFosuM5axRu33Y96O1g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43628594d34so29704345e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850080; x=1737454880;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/eDGvYOLeDMHVMqWmrB864wlTs2RG2NStXaSHeGJEM=;
        b=dfHSDLxNnFva51uRz61bM8FmAzOnR06axdXZ6+6E9wVZDeKGatkRwWGYxR59z4MAsx
         m8l5+6AADJ6KOd2U7/ixU9MGvRlSPOT2k0sG/b6idMmVmqlgYxDxfEaUOq3k1YyYiVGe
         tFseN0f2a6pjsAZOyaphJ07sv/3e0bMF5SXbUJKVETwMvZVarpI35jP5jDJP2OnxdH6j
         MfjFz6PxyjGJWLZktCBYC+vZx1UoxXa+9hSBjkFBXo8pOZ7pbYKNIaNfXZQ2DlnnS9VL
         M1+KWbP7mrHR+RAHhcT8V1d4IJyZsUtN/sdRCtXxR4Q3qXD2f3rAMFZSuMDRFIOMSWuP
         HGbw==
X-Forwarded-Encrypted: i=1; AJvYcCVaAAVvusarpHrqQPNxTEUGTqNh576hcMhxerRKIEeFUYjMx5i9g7vW5QXwNLzw2X8eXajy+HT2e+qrXLQEGoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0JN12AACB2qiYuhLjvpxBdoEFreAImLSvzLAtqAA+J/13KIG
	CnLl3tFZ+pq4Kova1SHzTGFOKYdB3dTZ2Dy54MbREVMXvHItt2etxvpXkjDJg7GJ8GhvlJah70a
	xitghhs8kqa8YfmOqtoxOjG4vRmbAkvBiLMPQsY8nZ5yL8O49/A+0/n90x0+51caz+g==
X-Gm-Gg: ASbGncsghakEu+HdmP+wPDPsR4q8DkxQN8aQ6nj7tXgJsp2+1hSPSCtFZwuZhZRFEVu
	y2OVcSwsp+SfpSgrTaL7TazKj49FfkW3UGjSDlClfsII09LsrhLJUXyCNj3+XXkCB6WJCR95A/D
	+gGWToMviR5kweaZcP211GiVUBHPh29RyYvd6xFa5C+ckKqSd4flc56badcRUPC3Eo77hfF+ORH
	jz4Jc6wJi5HOz7fZc9rQoVHEdwRUXOKBWWW2+d2FzBrS4QnXh0u9dazkmEBMgjP2W+1gk9JnAXL
	H+xKL7uGmhrgL/s2qjbKu3C435yKvynQQlhoV08h6zC5owwXZ8z7NskRC3HExO8k+gMPDM9kiQ0
	tBcAWAo5Z
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-436e26d946cmr185726015e9.21.1736850080369;
        Tue, 14 Jan 2025 02:21:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRX4r3vQSk65lIDDMtCZ3iqMQpWAru7hzZ2jkt7zPuzHqnJH+ZR9OmQCGiZWluLKj3OZXNDA==
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-436e26d946cmr185725875e9.21.1736850080018;
        Tue, 14 Jan 2025 02:21:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0bb7sm202589705e9.16.2025.01.14.02.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:21:18 -0800 (PST)
Message-ID: <ffe62886-ddaa-4623-88d1-5ce1e6f3632e@redhat.com>
Date: Tue, 14 Jan 2025 11:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/mkdirty: Fix memory leak in
 test_uffdio_copy()
To: liuye <liuye@kylinos.cn>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250114023838.48589-1-liuye@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250114023838.48589-1-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.01.25 03:38, liuye wrote:
>      Release memory before exception branch returns to prevent memory leaks
> 
> Checking tools/testing/selftests/mm/mkdirty.c ...
> tools/testing/selftests/mm/mkdirty.c:283:3: error: Memory leak: src [memleak]
>    return;
>    ^

Don't take this the wrong way: there must be something better to be done 
with your time than fixing memory leaks on exit paths in tests.

> 
> Signed-off-by: liuye <liuye@kylinos.cn>
> ---
>   tools/testing/selftests/mm/mkdirty.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
> index 1db134063c38..af2fce496912 100644
> --- a/tools/testing/selftests/mm/mkdirty.c
> +++ b/tools/testing/selftests/mm/mkdirty.c
> @@ -280,6 +280,7 @@ static void test_uffdio_copy(void)
>   	dst = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
>   	if (dst == MAP_FAILED) {
>   		ksft_test_result_fail("mmap() failed\n");
> +		free(src);


We are immediately exiting the test afterwards ...

In any case, the change LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


