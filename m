Return-Path: <linux-kselftest+bounces-41680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD86B7F268
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A461890731
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51433C76B;
	Wed, 17 Sep 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1senO4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C733C75A
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114528; cv=none; b=C6WCbBvjVrYV48NH/gl3IQRakAfyKv3B8bStyZlBrQl/cDg/GjowXCaEiywvM5kSWKTNawnA0oRFPvWSL0YIGU97/wAx+NB+ON6ZmUmNyrxNgk12kyx0tvluNhMYDOJLGOfXZZ0uU80ZnM7B0ajG5URGLF7GaE7SVSYWG4zKHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114528; c=relaxed/simple;
	bh=i572I/5t61zMlC3zm0YIVNIQ1+sDL42ZcU0vhKEKzMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/izRibDsKZdmShPdFWr/YSzQ6EXyhIEi30bv+Yh+vrnCtB5PQjxZ9FMe1BAHb7Plh/MpyGmbTdtWebb4uzqh7UlOF/qvUj8C0CF7KrTtYbAelGCumlw1WQ2egOg4CP6HmQSkFqqZb8d6FP23q1wmmWBPlzsrETBEi6G5e1DafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1senO4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758114526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nzfWfGht8au98LeWA8/zuY175JB8QmmK7SOvZDIdVlY=;
	b=G1senO4cgJ6tt99cuC94L88j+9vCuz8VDI1oxiDnmHacS9IX6S/smVMoe3ivQ03HlyI00U
	xgahpajDyVsLV3geAF8ma7jXP2r7QypA89Wn7ivYjgMQmho/dctzF8P6U5R2/JcdoGfPNQ
	9ZWV/HSu5UCrgmJ8YyjJHFzRXMZYcyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-7d0-Wks2MDq8aqvUc_KpyQ-1; Wed, 17 Sep 2025 09:08:44 -0400
X-MC-Unique: 7d0-Wks2MDq8aqvUc_KpyQ-1
X-Mimecast-MFC-AGG-ID: 7d0-Wks2MDq8aqvUc_KpyQ_1758114523
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ec06900004so1696616f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 06:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114523; x=1758719323;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzfWfGht8au98LeWA8/zuY175JB8QmmK7SOvZDIdVlY=;
        b=UEc+65SUbDesLOxeHwmxZ9jZs8b+AoKbwapWGBFITLQFbU8W8QvNIMZFDCSf6AnDjP
         NQTAsKv+FzGr3f+7gnTTKKpfhrOqFOU7HdAAg5UQz2ogHMYvJ32gTwqyZLSsLJIhwD78
         MEFcDg2TInHDyRNxy6tWzLJIVXASk20KC/eQQwpzkZljhetQ5mV8R+cRL7q6EUz4Wylj
         xr3Y8+VUmvHghRFIPELF1esJbJPQ7lI/w0iLoSdioi9FLUmwGeFXWyk+ZTQzP/31Ehoj
         EmRvdoXIKXlt/SdqoDf+vBJuoABkzeAjYBQmtQ+92tedi/QGUuKkQhvTQAMiJ5N97YQu
         sfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa7SXgGoPg6qWANCNzTi9X+dstTOcT8SmuZgfMbmxrwS7RVUa9UzvvCOu4Rx8qJlQFrnw+xmUlTMkMUZdM8rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKRkzKfz1gGd78XJ3BjANh54MwQ1tKIOxrAfSFW+OgcuwIOXW
	8oOzPYBA6++sV1nTWrWvkTX2+OYpNAYCd9L+xVjf997DlSFpS6ZjEoMav5IW6XxW+/f37NVQwo7
	SfEeID1cj0k9hA9sj6WFRJi9m/r4C6/o82A4mNRS/gBM3b8XZAdfTAL+xvEtb0nnBdmm2PQ==
X-Gm-Gg: ASbGnctef0MBP6bNopFTSXyEGGVId+Co6WMOcBu3Fkbw3/Ty8bq/xagJfEoyoBZD34w
	KhxktLHVDwDnPDlp3bjdagI2p32zw0y7zucSzTwTABEjBIbckhePKHD3M2zE7Fxek+HjlNqgL5B
	U7R5L1DOyYmBtYRqgGD2dybwoBNxL/LkitFPuYYi6zVMSCMIZXn7Sz3v6mpmdtSHgE/HfIZbvDP
	S87JVch+lS7DXfHqtkkbNSHHjJJDMEnRD9d0StU7h0ceI4z4iu1mPCQ5DcTXj9w3Xk4QlEZ2nL2
	m9YPkq6gWld5PS0PP7re2eucsG3cDTO9mmZ4KIQd16b2c8KmR4UpXNXwVeerSDVLgtqV8Ymivej
	4rsM1uMgTRHuoeEDMaRSXDmfelXKbEnYZNA/NY6yAEarZLo3JKHn8aWuopoeV+Yrf
X-Received: by 2002:a5d:5d0d:0:b0:3df:c5e3:55f4 with SMTP id ffacd0b85a97d-3ecdf9af23amr2124899f8f.6.1758114523504;
        Wed, 17 Sep 2025 06:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESsV8oIC9/D3nBGOX8FOAc3Rt8Xs0bAaprYwXzUAhqjLbNmBfCuTBu4PnllnnmUxZ07rs/UA==
X-Received: by 2002:a5d:5d0d:0:b0:3df:c5e3:55f4 with SMTP id ffacd0b85a97d-3ecdf9af23amr2124841f8f.6.1758114522780;
        Wed, 17 Sep 2025 06:08:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece0d4a5ddsm1768484f8f.33.2025.09.17.06.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:08:42 -0700 (PDT)
Message-ID: <ada1b1f9-bd2b-4164-ae8c-80264d4f6dc0@redhat.com>
Date: Wed, 17 Sep 2025 15:08:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: shuah@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250917122750.36608-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917122750.36608-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 14:27, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The madv_populate and soft-dirty kselftests currently fail on systems where
> CONFIG_MEM_SOFT_DIRTY is disabled.
> 
> Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
> tests are properly skipped when the feature is not enabled.
> 
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

[...]

> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 56e9bd541edd..ac41d10454a5 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -449,6 +449,25 @@ bool check_vmflag_pfnmap(void *addr)
>   	return check_vmflag(addr, "pf");
>   }
>   
> +bool softdirty_supported(void)
> +{
> +	char *addr;
> +	bool supported = false;
> +	const size_t pagesize = getpagesize();
> +
> +	/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
> +	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
> +		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> +	if (!addr)
> +		ksft_exit_fail_msg("mmap failed\n");
> +
> +	if (check_vmflag(addr, "sd"))
> +		supported = true;

Reading the code again, this could just be

supported = check_vmflag(addr, "sd");


LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


