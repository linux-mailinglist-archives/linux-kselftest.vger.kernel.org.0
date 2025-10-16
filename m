Return-Path: <linux-kselftest+bounces-43351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88ABE55AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F53573E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DD2DC79A;
	Thu, 16 Oct 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRTwG47w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9A469D
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645907; cv=none; b=iZdseUMJ3HWN+cDi1rx27UQ2AkJcRgNzLb6bUzd7UUXKRtoa3OOfKy+wd1BiFh6CLR1grsanzCbZdkS2f1oa/VBKd62zOCG5QEdOpumoahaBJlwYdpTV2nLUzB+TssW1bF8ePUOMtOIn+yiXeELoh3Yuq8mrCTjgZZdtl3uz3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645907; c=relaxed/simple;
	bh=jD8IZXectH4xCbx11H4VFsK0WOFkuxbQ8zxQhbckW94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uu1opc0ryDgtfrcpnLEyktzc6o4LjH9ydI6bNZRsJHR3BORTuGu9HewSdzaWIAKoLvCd6eMxo0u8tPGWxcAX7xuludRiHcgG57b70uX4sOUwchdIrz9RivyZVAbvoxpkTg/btFMkC58aFtu1XoozIZnBywm8rUmwAgZxG4JnmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRTwG47w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760645904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=afe8X+RdgeqgARYQCjHPw9pHXBS1Z29SmpYHHHH9X+c=;
	b=NRTwG47wlHKBP4kThwQuJSzkILQSkFBPQAhxwP/vHXGd21+enBoUNdnSR3lKhcOUFD3seT
	KPBZxRogotp7hYLMfmMAj3a4p5SQixosg1j5GXy54YKYb08NDaGoiN37BcDqMnwh2VZXAG
	9DsVXwPHz7itjDV5WkIihd7S3AyciZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-eP0PXX2MMGWZ8t5q1xjpIA-1; Thu, 16 Oct 2025 16:18:22 -0400
X-MC-Unique: eP0PXX2MMGWZ8t5q1xjpIA-1
X-Mimecast-MFC-AGG-ID: eP0PXX2MMGWZ8t5q1xjpIA_1760645902
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e39567579so7346125e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 13:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645901; x=1761250701;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afe8X+RdgeqgARYQCjHPw9pHXBS1Z29SmpYHHHH9X+c=;
        b=K8Q4T3x90UJY6rpJwAbh/vhfAypUdrNgxwh1vEPGpB6jYoRs6s7aYSsN3PFCaSHlvT
         LSCWRy4+8COQ6bvQZa2xOW22A0l29vw0F/8wWEfQOTjo3OA31ciHmNq3kUHxaxauxNeX
         E92StpPWxoUPko2xF1kksUmvT+cy5vO4cUOhmEcpJaB6LnOFLdIFMpl7LQTo5AFWqnch
         04svulQgPR87rw/WlV0rrDFvp+Z3vqjELrA/z1DUQZ61PlVO5J/zThM0nO2kXGxel5Sf
         qbgo8FkKCYUnYhn6jsqSNMuCWeYqqx8hQYoDqu35ny3E4o26XzSGBOV2iPGxztW9SEYT
         GabA==
X-Forwarded-Encrypted: i=1; AJvYcCWnp+UPAeMXsy5NtCThsHh7C1MFxM1dzSGczty38kDTE6w5X8alRnaQZQDSIx9P6xWMEOESVf9xfJIFWCHOEb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTkucbgP/LX+MGt7yxrWrYDHG/dNbpaYA4lX7nj1sIQBWiLDq
	B8apEOzE81iOjU7hcip6Tnf26peigzf5ddS6GcIVwpDcTQiF17HkL6SMp1cP+/dwo+7KsY387+K
	0xl7ZK8gHyO2MW5o6dVmVyj2Oo92hioYXd4lBQ3MsS/lHH39FzdeWBl7DLTupZJEuLrjmKA==
X-Gm-Gg: ASbGncss+ENbZsYe7hh6D/uwHneJhTNZj52waA8sKfr+h2/Aw0Z4LuG7kZ88q1tAqny
	0IqsQXBhFnUC+yPRTKdodQcg8Yxxj8+pO+AizyVeerfgeTTThW42mXG/mwJsJYnD1mSbfpWRCtT
	Kd6COXbM5NgU7qqFVq/K/bLWo4mmXBTpB9Z2G75Xwihvl4OtKLNSmdg4fARqBtnwSGJaASdCy2d
	kUMeihbH9FY8Kf78CXXHHVWdVcbReq6Eu8B+KPUXd8S2VyT4gIFbNfiaKP0oFLjBElCw3ZWMhfY
	CMrU3kxSyUV7AX3VBu7mFvyuIxJG/de/8UtiSks5XDabId64N14Lk0xYCZ+KDJl43iF9ihXdrau
	JqYNsCtOpQg+JqEiLVkbwgctJsBA1MyZ1VTxZ60PhxQXZ2D/a0SYZnsXG3oqmaMleCGC4Mn2RnV
	ffjR6BEI+J/FjDPnGGZz3fgFvBmIw=
X-Received: by 2002:a05:6000:1446:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-42704d963b3mr929419f8f.40.1760645901552;
        Thu, 16 Oct 2025 13:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpwmWox5fF2XM1ZxFCQsZe5apuhIUYpTVdIfchO1P6JXmo7Qz5WHjERWLjEtPjWHqU4GfxOA==
X-Received: by 2002:a05:6000:1446:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-42704d963b3mr929404f8f.40.1760645901019;
        Thu, 16 Oct 2025 13:18:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm37683358f8f.32.2025.10.16.13.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 13:18:20 -0700 (PDT)
Message-ID: <91dbea57-d5b0-49b7-8920-3a2d252c46b0@redhat.com>
Date: Thu, 16 Oct 2025 22:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 1/3] mm: memory_failure: Fix MF_DELAYED
 handling on truncation during failure
To: Lisa Wang <wyihan@google.com>, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com,
 vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com,
 tabba@google.com, dave.hansen@linux.intel.com
References: <cover.1760551864.git.wyihan@google.com>
 <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <57ed0bcbcfcec6fda89d60727467d7bd621c95ab.1760551864.git.wyihan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 20:58, Lisa Wang wrote:
> The .error_remove_folio a_ops is used by different filesystems to handle
> folio truncation upon discovery of a memory failure in the memory
> associated with the given folio.
> 
> Currently, MF_DELAYED is treated as an error, causing "Failed to punch
> page" to be written to the console. MF_DELAYED is then relayed to the
> caller of truncat_error_folio() as MF_FAILED. This further causes
> memory_failure() to return -EBUSY, which then always causes a SIGBUS.
> 
> This is also implies that regardless of whether the thread's memory
> corruption kill policy is PR_MCE_KILL_EARLY or PR_MCE_KILL_LATE, a
> memory failure within guest_memfd memory will always cause a SIGBUS.
> 
> Update truncate_error_folio() to return MF_DELAYED to the caller if the
> .error_remove_folio() callback reports MF_DELAYED.
> 
> Generalize the comment: MF_DELAYED means memory failure was handled and
> some other part of memory failure will be handled later (e.g. a next
> access will result in the process being killed). Specifically for
> guest_memfd, a next access by the guest will result in an error returned
> to the userspace VMM.
> 
> With delayed handling, the filemap continues to hold refcounts on the
> folio. Hence, take that into account when checking for extra refcounts
> in me_pagecache_clean(). This is aligned with the implementation in
> me_swapcache_dirty(), where, if a folio is still in the swap cache,
> extra_pins is set to true.
> 
> Signed-off-by: Lisa Wang <wyihan@google.com>
> ---
>   mm/memory-failure.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index df6ee59527dd..77f665c16a73 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -922,9 +922,11 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>    * by the m-f() handler immediately.
>    *
>    * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
> - * The page is unmapped, and is removed from the LRU or file mapping.
> - * An attempt to access the page again will trigger page fault and the
> - * PF handler will kill the process.
> + * It means memory_failure was handled (e.g. removed from file mapping or the
> + * LRU) and some other part of memory failure will be handled later (e.g. a
> + * next access will result in the process being killed). Specifically for
> + * guest_memfd, a next access by the guest will result in an error returned to
> + * the userspace VMM.
>    *
>    * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
>    * The page has been completely isolated, that is, unmapped, taken out of
> @@ -999,6 +1001,9 @@ static int truncate_error_folio(struct folio *folio, unsigned long pfn,
>   	if (mapping->a_ops->error_remove_folio) {
>   		int err = mapping->a_ops->error_remove_folio(mapping, folio);
>   
> +		if (err == MF_DELAYED)
> +			return err;
> +
>   		if (err != 0)
>   			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
>   		else if (!filemap_release_folio(folio, GFP_NOIO))
> @@ -1108,18 +1113,19 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>   		goto out;
>   	}
>   
> -	/*
> -	 * The shmem page is kept in page cache instead of truncating
> -	 * so is expected to have an extra refcount after error-handling.
> -	 */
> -	extra_pins = shmem_mapping(mapping);
> -
>   	/*
>   	 * Truncation is a bit tricky. Enable it per file system for now.
>   	 *
>   	 * Open: to take i_rwsem or not for this? Right now we don't.
>   	 */
>   	ret = truncate_error_folio(folio, page_to_pfn(p), mapping);
> +
> +	/*
> +	 * The shmem page, or any page with MF_DELAYED error handling, is kept in
> +	 * page cache instead of truncating, so is expected to have an extra
> +	 * refcount after error-handling.
> +	 */
> +	extra_pins = shmem_mapping(mapping) || ret == MF_DELAYED;

Well, to do it cleanly shouldn't we let shmem_error_remove_folio() also 
return MF_DELAYED and remove this shmem special case?

Or is there a good reason shmem_mapping() wants to return 0 -- and maybe 
guest_memfd would also wan to do that?

Just reading the code here the inconsistency is unclear.

-- 
Cheers

David / dhildenb


