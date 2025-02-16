Return-Path: <linux-kselftest+bounces-26741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A622A373CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 11:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FDC16B1E4
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492BC18DB0F;
	Sun, 16 Feb 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3vy/xxo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A01547C8
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Feb 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739701965; cv=none; b=UODVQJTnYPYo+ZY2Dy1y28bf093kRxOpd5giKJov8pBE+TMm7UueU4DfYq20xGTUAV0TvjxdkNPko/o9x0UlEJd21OZjohKqZaylJd1SvWRmjUBDn8S11slVPAUb8izU9Awz6N/IW6FPErswSWArGFeTQEo5/o1HMeRMwQBgUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739701965; c=relaxed/simple;
	bh=dF+w8ASMHcqzjcFushYaz1lV4wXycakJg44UezSNGNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O56MnRhcf2gqVHtuC5RXG+nOV6BqS9TCT603Z1tSt8lzNcTejBo8klduCfWOpRPvtgMmvO1i3i2yHj7MBfp5jcEIM3pPy6DiPSneIslFb1JdCQIKCEv6O0WQxkvZPce7p3H9/55ieVpzPCyLXCloUYDBwpiFo1kn77X86/1rk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3vy/xxo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739701961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3LuSxmx+5sp5h0X5CwOasudK4bvFkj88IzW7by3CUc0=;
	b=T3vy/xxoaY2RFkUAPkB5OudXnCyQR0JZD5ynqeut00ZkzsOC+mMHig70FMyyN344J+W8SU
	qDm9ywXngy1fTuEuJ1usSKhnRIEaCGROFZGaRiyN2EeA6gkkIVo4a4RKTtBF1xBj1vFu+y
	HKE1ktVyN46yafEfIMylTd5SzFqO5i8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-mW58hQInNka8ePo2xO3VfQ-1; Sun, 16 Feb 2025 05:32:39 -0500
X-MC-Unique: mW58hQInNka8ePo2xO3VfQ-1
X-Mimecast-MFC-AGG-ID: mW58hQInNka8ePo2xO3VfQ_1739701958
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2cefb154so1537437f8f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Feb 2025 02:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739701958; x=1740306758;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3LuSxmx+5sp5h0X5CwOasudK4bvFkj88IzW7by3CUc0=;
        b=J1q5rlDtju8gTscaWpstF+owex03yC30zEtUeBPUG/XT+9nhEcrktMJQdHBQf5ZNKm
         IcMe/LEsqHxLqAlKTf2Cja7z8vRKW40/PazkGEboDB8IKjtq8d4fc25HF/7nfCdcyc/R
         3zDa4+yGH7KKfQwE35RWNKcXn/0mSS7//Nj5H19I1udDnmaN8K+n1AbLATvpcJjlmJmF
         1N2aMwI/A1x2mNDX1EyIVNVRqjI/WXSjXGlav4FXQPEBXXD8gt5nEsGyqtUNhzvE/Rh2
         JW4aoD0javrzoUPDw1c3ORGj+SoLO6NOps9xI+noz7bnOq9poAV1ljZxWT2ZEutz+qZf
         FGYw==
X-Forwarded-Encrypted: i=1; AJvYcCV1OLosnPxwNd4QSc/TscIL2x03JwPksaZ5bgbe0FkcUz8ndBnMN5c8EuXU1wqLjEkB20ECJyhP6WHneVrX0fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJGTrgiPg9HHAEhCbVmviY4/EsrJxoPYSr2agYiwVyKU4dhTO
	hrpMQtGcB/tfu6E6x7mHzfFwJn9eJlvHtoTltzEinsbXx8SyDzvjoigj2sFzNmRwMQi+nKkQ8fk
	/1+Cvc9/+TbX4GqhoVR38gMPVtvpMBJP0uQHXnx3lq7UPWl+b7VsvKNyUqiRoNgS2kA==
X-Gm-Gg: ASbGncu2fvM/X+fBPtowoq5HG3qRN01av+DBLC/iULRJxJIqdAeCijMOEP696CjfJGg
	dLQlbBDnDd/+b7jXwALv3pppD3xw6u3AlDi48m0P/ykm6qsNCzy45DMnTk2QAu/CpZ9pB3dTnGJ
	lokc9k+BJNENlDM2akZkB4y5DBaUkLcpFjyuVkoX5aEp7SlDJ4MdpXiHFJRpIQx8dTfZbNbN68R
	emFD7EAz1/REaJ+sjCg7fcL3kfoVamDwTVi80vWkRPfSGGB175CsK3oHV2sUPFDAZelG2h8VYXW
	QyrINPT625qAwCEuMT18WcWN3hvPliy21cz4Ev3WTWoU/tyrBGezKiHfqolk8nADtv+zbuxvolY
	ZNzNTkQcHXgyZ59KkyW0f4UXF5wd7l1Lt
X-Received: by 2002:adf:f10b:0:b0:38f:2a44:8079 with SMTP id ffacd0b85a97d-38f33f34bffmr4826636f8f.32.1739701958057;
        Sun, 16 Feb 2025 02:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCllInP2N5nDdAZNdP0iC9xkwgfBjfwcD0FnByUhVwkUeTcSGmmYwiIiNzbIib8NaVX5dxeQ==
X-Received: by 2002:adf:f10b:0:b0:38f:2a44:8079 with SMTP id ffacd0b85a97d-38f33f34bffmr4826623f8f.32.1739701957685;
        Sun, 16 Feb 2025 02:32:37 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm9266294f8f.73.2025.02.16.02.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 02:32:36 -0800 (PST)
Message-ID: <f1198e22-3358-4f82-8227-49b0e779302f@redhat.com>
Date: Sun, 16 Feb 2025 11:32:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] mm/huge_memory: add buddy allocator like
 (non-uniform) folio_split()
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-5-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250211155034.268962-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.02.25 16:50, Zi Yan wrote:
> folio_split() splits a large folio in the same way as buddy allocator
> splits a large free page for allocation. The purpose is to minimize the
> number of folios after the split. For example, if user wants to free the
> 3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
> as:
> O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
> since anon folio does not support order-1 yet.
> -----------------------------------------------------------------
> |   |   |   |   |     |   |       |                             |
> |O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
> |   |   |   |   |     |   |       |                             |
> -----------------------------------------------------------------
> 
> O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
> ---------------------------------------------------------------
> |     |   |   |     |   |       |                             |
> | O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
> |     |   |   |     |   |       |                             |
> ---------------------------------------------------------------
> 
> It generates fewer folios (i.e., 11 or 10) than existing page split
> approach, which splits the order-9 to 512 order-0 folios. It also reduces
> the number of new xa_node needed during a pagecache folio split from
> 8 to 1, potentially decreasing the folio split failure rate due to memory
> constraints.
> 
> folio_split() and existing split_huge_page_to_list_to_order() share
> the folio unmapping and remapping code in __folio_split() and the common
> backend split code in __split_unmapped_folio() using
> uniform_split variable to distinguish their operations.
> 
> uniform_split_supported() and non_uniform_split_supported() are added
> to factor out check code and will be used outside __folio_split() in the
> following commit.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 137 ++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 100 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 21ebe2dec5a4..400dfe8a6e60 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3853,12 +3853,68 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>   	return ret;
>   }
>   
> +static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
> +		bool warns)
> +{
> +	/* order-1 is not supported for anonymous THP. */
> +	if (folio_test_anon(folio) && new_order == 1) {
> +		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
> +		return false;
> +	}
> +
> +	/*
> +	 * No split if the file system does not support large folio.
> +	 * Note that we might still have THPs in such mappings due to
> +	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
> +	 * does not actually support large folios properly.
> +	 */
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +	    !mapping_large_folio_support(folio->mapping)) {

In this (and a similar case below), you need

if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
     !folio_test_anon(folio) &&
     !mapping_large_folio_support(folio->mapping)) {

Otherwise mapping_large_folio_support() is unhappy:

[root@localhost mm]# ./split_huge_page_test
TAP version 13
1..20
ok 1 Split zero filled huge pages successful
ok 2 Split huge pages to order 0 successful
[  144.936764][T15389] ------------[ cut here ]------------
[  144.937948][T15389] Anonymous mapping always supports large folio
[  144.938164][T15389] WARNING: CPU: 5 PID: 15389 at ./include/linux/pagemap.h:494 uniform_split_supported+0x270/0x290
[  144.941442][T15389] Modules linked in:
[  144.942212][T15389] CPU: 5 UID: 0 PID: 15389 Comm: split_huge_page Not tainted 6.14.0-rc2-00200-gdcbc194183fd #153
[  144.944188][T15389] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[  144.945934][T15389] RIP: 0010:uniform_split_supported+0x270/0x290
[  144.947144][T15389] Code: ff 89 de e8 c2 20 ca ff 84 db 0f 85 47 fe ff ff e8 05 26 ca ff c6 05 f6 c2 22 06 01 90 48 c7 c7 18 44 fa 86 e8 31 2a ac ff 90 <0f> 0b 90 90 e9 24 fe ff ff e8 e2 25 ca ff 48 c7 c6 08 52 f7 86 48
[  144.950897][T15389] RSP: 0018:ffffc90022813990 EFLAGS: 00010286
[  144.952058][T15389] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8120ed77
[  144.953559][T15389] RDX: ffff8881326f3880 RSI: ffffffff8120ed8a RDI: ffff8881326f3880
[  144.955045][T15389] RBP: ffffea00062a0000 R08: 0000000000000001 R09: 0000000000000000
[  144.956544][T15389] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000001
[  144.958043][T15389] R13: 0000000000000001 R14: ffff8881328b3951 R15: 0000000000000001
[  144.959898][T15389] FS:  00007fb74cda4740(0000) GS:ffff888277b40000(0000) knlGS:0000000000000000
[  144.961627][T15389] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  144.962886][T15389] CR2: 00007fb74ca00000 CR3: 000000013e072000 CR4: 0000000000750ef0
[  144.964418][T15389] PKRU: 55555554
[  144.965100][T15389] Call Trace:
[  144.965746][T15389]  <TASK>
[  144.966331][T15389]  ? uniform_split_supported+0x270/0x290


-- 
Cheers,

David / dhildenb


