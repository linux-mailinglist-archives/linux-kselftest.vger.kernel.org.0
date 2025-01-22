Return-Path: <linux-kselftest+bounces-24935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE284A193DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE523AA2F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53EA213E7B;
	Wed, 22 Jan 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/aWkADl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287B17C220
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556075; cv=none; b=UC+qTWT6oUV9f5YLuxym7qB6/S6hrMRd69cGmOWFgL3sv7yz+dArW5v3dBhZNvLEL5JBVN8EUUMwOzl+MXeEi1CpRh4ftoS9knMPiN42Y1JLu6B67TVgG/MEx13OvIrCtxrSmwsqVs7MjiE5xLBnyFwXxjtovV4NYKWsQ+nEc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556075; c=relaxed/simple;
	bh=v2xuFYGs+2OBSVxnTcpg2B0/NVyTiHlAQ5vQTngbKJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXlib9qtroQxiXKzwfWEeO5dLEvj3PAY64uil1i5sJc3oyjiS2y0CgTflYIYjmvv5HSNHXTpZzT40ThOg/UyZBic0jTQiCIB60LVyO9UzlWqLs81S2ept90DCVcg/zdqYx91TS6ejNkrFjWS3SekPJ00tybUsRFRUMOW8ylgaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/aWkADl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737556072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xeLiFVQC+FwfnjIjUD2FtqgctddtCSg/hP/Ew4X0Pzw=;
	b=L/aWkADlT1yeHa2hwT669uPBsCcL17529KNloOf7ld1uL/5h9ElloIl/IW2QmFaSF1z0Xc
	8asV1Dk5479i9IwOxsm9GsdnEwmsqcO+H7qql8OuPhjfZZDNwmYsrWyq1FZKCcb+BE5uA3
	RkTQJRaYjfvrUTZz51+d8AgWioseVoM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-KWAhx5-PMYiLXZEZilBwLg-1; Wed, 22 Jan 2025 09:27:51 -0500
X-MC-Unique: KWAhx5-PMYiLXZEZilBwLg-1
X-Mimecast-MFC-AGG-ID: KWAhx5-PMYiLXZEZilBwLg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a873178f2so3603820f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 06:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556070; x=1738160870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeLiFVQC+FwfnjIjUD2FtqgctddtCSg/hP/Ew4X0Pzw=;
        b=LQXEDhqfWZEWUhnfroBLYGAvdUk9Blu5tGeqIgD+5A3fli9IFMw3TFNCZUANNU8fR5
         1DXgCLJ+iJzIJmTxhIWIGQdI+Q5oJpvh9P7+t8bGKEulqaM7mK7OxvnDZ8sqD8XRM/WJ
         UueYVIOUqmj4LYLC6maIXU/xiNlsDNH26M4YH24Cj8M5DIgxMsKKgS1Ym5AQI7UajemF
         kbm550FL3GURnblDwn6EsPV9cjP5Y+2PlXaoulaGxkbozc/WNQmstbMbIzD4HyYA64e0
         JvDihR2QvIJOIXnG9MQHhICOlDWmysBvP9hsP1Mx0FQQOZNMBlIC+0QUJjDh4z7CXXpM
         +Knw==
X-Forwarded-Encrypted: i=1; AJvYcCW82QAPByOn/rGwhKudBB5p587HY5pdaicZTbGvJ87J1DSfe0QOEvyQPlf74wcJwZEe3QzmMnazoONAnEg6fEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylk5b7ogBPcqtai1yNVhf4hNJUs7EB85FRiNCoqNCvBGRDOLti
	5AjNYo+p3m58CSAfMZMXjaJwqr0V8+j28emwmzljrQEtKJnoflP4gUsvDPD4BUN1zo1XrEIan1J
	RZAUpG75ToQVOy3afHb6ba15EaGN3zbqk7MYqVGt1QfHLV5mGM9Np4NBXzOuHxnl4bw==
X-Gm-Gg: ASbGncuEkm3agShFwA9403PZZ7aF57/sHyJxoUfF4VQgPNnoFe0GRLaeLk+qOBYpyHC
	9OwKPVNmxWmuGra4sWOB2YhFMDLkB9KwdRdoYjygWcjt02ItzFoy9UUMaA9135D2YkTm3QxpaqH
	V/XYs7rqFpkGonj+2JeCRbUFJyluX4nvLXvfYxwuJ2scebiyEQwSG9VZmiDdnOFCizzWyWJMi4w
	h+obtAEHjagQ8DaYMvxuDTfIx9+IpD+FqQCvU2sFA323ffYleFYNr7Og87rIuPElMBYiATGRYAT
	fzAFVWblxk6GTxzz99lMi5WeyvKMqxxgQHRO+RKakg85LQqbBlegGhdm9AVxh5zJazCghSVo+Ou
	S7uSMI6598EbQa2Y8da/oeA==
X-Received: by 2002:adf:f682:0:b0:38b:e26d:ea0b with SMTP id ffacd0b85a97d-38bf566c314mr16875534f8f.25.1737556070035;
        Wed, 22 Jan 2025 06:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJI4u3iClTnYhB2b4IdMR//bzTEQCmmMUMNBAg+34VSusxZveEyCW3M9a8kzPr/C9DvHXmXw==
X-Received: by 2002:adf:f682:0:b0:38b:e26d:ea0b with SMTP id ffacd0b85a97d-38bf566c314mr16875502f8f.25.1737556069623;
        Wed, 22 Jan 2025 06:27:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:db00:724d:8b0c:110e:3713? (p200300cbc70bdb00724d8b0c110e3713.dip0.t-ipconnect.de. [2003:cb:c70b:db00:724d:8b0c:110e:3713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32845e8sm16718293f8f.97.2025.01.22.06.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 06:27:48 -0800 (PST)
Message-ID: <3c60c603-04ee-4908-9317-7bf5d3bf24bc@redhat.com>
Date: Wed, 22 Jan 2025 15:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/huge_memory: allow split shmem large folio to any
 lower order
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250122124047.1216024-1-ziy@nvidia.com>
 <20250122124047.1216024-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250122124047.1216024-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.25 13:40, Zi Yan wrote:
> Commit 4d684b5f92ba ("mm: shmem: add large folio support for tmpfs") has
> added large folio support to shmem. Remove the restriction in
> split_huge_page*().
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/huge_memory.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3d3ebdc002d5..deb4e72daeb9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3299,7 +3299,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		/* Some pages can be beyond EOF: drop them from page cache */
>   		if (tail->index >= end) {
>   			if (shmem_mapping(folio->mapping))
> -				nr_dropped++;
> +				nr_dropped += new_nr;
>   			else if (folio_test_clear_dirty(tail))
>   				folio_account_cleaned(tail,
>   					inode_to_wb(folio->mapping->host));
> @@ -3465,12 +3465,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   			return -EINVAL;
>   		}
>   	} else if (new_order) {
> -		/* Split shmem folio to non-zero order not supported */
> -		if (shmem_mapping(folio->mapping)) {
> -			VM_WARN_ONCE(1,
> -				"Cannot split shmem folio to non-0 order");
> -			return -EINVAL;
> -		}
>   		/*
>   		 * No split if the file system does not support large folio.
>   		 * Note that we might still have THPs in such mappings due to


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


