Return-Path: <linux-kselftest+bounces-24440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA45A103FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 11:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4947A1AC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486C28EC78;
	Tue, 14 Jan 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV44XA1w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFE284A6B
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850248; cv=none; b=bH9diy0LOeD28hOjdA6dgOgnyLxM9ooTPAX3tgq0He/iGci+QeWE1Hsy9JUbw/R/67dPk4KgWfJChCyDSWQJDFqA/TR3cI4KW3CtLXte/yuWWmcQl46mmYEgv8e2uVp4rmZbMqdI2Usts1m+nP7/odVeea8aMtf9mbosIhlcKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850248; c=relaxed/simple;
	bh=rCJVFkVeS3Srd5IAm71d1HCjHOZnITFfS3Yb/5XS5Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lq3I2mSb6fS97fPRdhsHyRYB8oCruVMD/5sltkdklzsTU5oTdfNVRX73bVFQlNyQV95jlaaS2vNIzIf73Nj8TNGNWa4C1Anv6XiMF80WNA+BnZXMxABlyUldxacsAYJLhNVJjw//DjaxbDvch1dUrQco6IL4g76BmwQTvNVXt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hV44XA1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736850245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FK+xa/fmgG/jyvWf9H8pjEbAVH2RYy7jsXq3UQXJCJs=;
	b=hV44XA1wPUM2S+4FANcqaTExMgYVV/4OohsmARiMZ/532+cC2n944Xz7ZEKI26dayZamZF
	R7SZV3LoBGSHZZdCZHmtWYKMx9vxwU5e8nACl+H62cpV+oH5iqDgdQKow4zgZeTfy2PKQk
	t8O//uheqAR8lmvVLvoEXgKlbvbKxxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-sQC6T9K1OVmYAvH0-uqWSA-1; Tue, 14 Jan 2025 05:24:04 -0500
X-MC-Unique: sQC6T9K1OVmYAvH0-uqWSA-1
X-Mimecast-MFC-AGG-ID: sQC6T9K1OVmYAvH0-uqWSA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361b090d23so28113625e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850243; x=1737455043;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FK+xa/fmgG/jyvWf9H8pjEbAVH2RYy7jsXq3UQXJCJs=;
        b=IgMEO3B+H7SCkpPowdBymhOB3nW5i0vscd4f5N0yVcsUPhmoeh1BiIy5AoXXVgBPD0
         lu2tCO0Lu6TRhiMtCsJhsBptp+4+tTNwixSSRl8ISNMCPCBeaJPsf7WkuLFy8TIXTqD1
         sjTdEgHDWrTU3+R9fKi71YZlCBUwlLP+Ix07ZcNqhX4zsfVU1l4eEz69uhZK2nlxqyiT
         y+F8IaDgDTYiIR0/d2Ncn90B8WQHJYIST9gW2CZFBZCpGKOcQV/5hRhpJqv4X1MctWeg
         wWaN2MhKRA4e7WJ5HXNJiQxIcIrEE8ZsWysBD1F58nI4Yu4OsyhOvEqRfdbPU0OBHYkR
         1PEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIEUkGBh8JX52h/dxOc2tWPZk8vsuNBWe7oN1omrTPRu6UDl3FJukI7DfuLALFdoHbfNsMN7aE5nXIP24MpQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5NeAbi4EElpACh6uo5KTfLbh9epqqghFUaXzszN5te0BCQaC
	Phs20gTpPZNQ5TxpFAqx6G37q8Nj9YabKvO1GoPU1OdoBQvWPbIJmBcZPHcbJzU+kgejjtsgp1V
	BAiHmXjN0Q0ate1aQ2YE0yfYYNmiOc4OQCJSd1gU2vqpECLIilgezfJfcCh5NZrgxkw==
X-Gm-Gg: ASbGncsDZWW3OJh9lhcwT1CsSAopATCoQe4iyNsxFsRHmNC5qJoAsGUHopWzrV842nF
	2zLXDtG8r+Tl51JBy7BGRGFeIgT2eASOznQiJj9wLjbrLhPE36zTQ9yOYk+nDjq3o4cnzJ4z4jQ
	9RHgPOPxxx0HE82Ge4hnOZokQTa9fIUM0ut913eyzlmRJ/TheBS8FkVGXRGSatp0hcz1rBjztY0
	ZMDCBxah5PztFoS/QXRMlFAAm+vP3R9+eE2xw64yvNAnanCkui5Gs3L8CAlekDS/khlkTDaRWpV
	kqP6ty88qVRJmx8AxEgqFm9IIuLzK8UqwXL/2vpRVFQ21zpXPePBxJsLGRx1MgYOX1xlkQGBrLg
	sCb6YES8x
X-Received: by 2002:a05:600c:3c9e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-436e26a6727mr213878355e9.8.1736850242640;
        Tue, 14 Jan 2025 02:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOWjvyHJ7MmSDTJAQTamhmssQWsN+EFga/BCnXhzGm5kMPY93nNn4f9s9OcKULczW/vf1bqA==
X-Received: by 2002:a05:600c:3c9e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-436e26a6727mr213878145e9.8.1736850242277;
        Tue, 14 Jan 2025 02:24:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03f8bsm168847805e9.23.2025.01.14.02.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:24:01 -0800 (PST)
Message-ID: <4fd2fdca-ea98-499f-ba04-0f1140180ba4@redhat.com>
Date: Tue, 14 Jan 2025 11:23:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow : Fix memory leak in
 child_vmsplice_memcmp_fn()
To: liuye <liuye@kylinos.cn>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250114022929.46364-1-liuye@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250114022929.46364-1-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.01.25 03:29, liuye wrote:
>      Release memory before exception branch returns to prevent memory leaks.
> 
> Signed-off-by: liuye <liuye@kylinos.cn>
> ---
>   tools/testing/selftests/mm/cow.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 1238e1c5aae1..959327ba6258 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -167,19 +167,30 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
>   	/* Backup the original content. */
>   	memcpy(old, mem, size);
>   
> -	if (pipe(fds) < 0)
> +	if (pipe(fds) < 0) {
> +		free(old);
> +		free(new);
>   		return -errno;
> -
> +	}
>   	/* Trigger a read-only pin. */
>   	transferred = vmsplice(fds[1], &iov, 1, 0);
> -	if (transferred < 0)
> +	if (transferred < 0) {
> +		free(old);
> +		free(new);
>   		return -errno;
> -	if (transferred == 0)
> +	}
> +	if (transferred == 0) {
> +		free(old);
> +		free(new);
>   		return -EINVAL;
> +	}
>   
>   	/* Unmap it from our page tables. */
> -	if (munmap(mem, size) < 0)
> +	if (munmap(mem, size) < 0) {
> +		free(old);
> +		free(new);
>   		return -errno;
> +	}

We are immediately exiting the test in do_test_cow_in_parent()
	exit(fn(mem, size, &comm_pipes));

Your changes make the code unnecessarily more complicated to read, so 
I'm not in favor of this one to make some checker tool happy.

-- 
Cheers,

David / dhildenb


