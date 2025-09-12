Return-Path: <linux-kselftest+bounces-41374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FEDB54E32
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C4616F844
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E53054D0;
	Fri, 12 Sep 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+7TX9oq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B7304BD3
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680549; cv=none; b=NMynHpkF7d9801uHticAq8hAJC7HRwKgup1MD9eOAdq3z2oPn8eY523wy/ho8ZZGznKJVs9Sd0f4XsOgKhfnHGKHZUGnFpkqrCIbS1Bvi0GRlx52fF1JwxMiyI3tkuQfcbIbINzMOluunROb2+0hxMntOWRc+F3XUudz2e0Ro80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680549; c=relaxed/simple;
	bh=9naDuZ89ohkhST9nPdyMsS/odQGyMK2ICA4KVhv0buU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TME1nclMTEFqAjIHv7CEMlpEgt414Zp+62BXbdeUkRG2uDj9EuP+HsWTz1fwDQEZ6c4DzSNGgjBOxxPPyH02ccgjuJqKU0mSohNzrZJ3r+qo2cbEGQ98UGj6AVm/jHCvhGKCD89KJqFWWyNOXzsGhrtTPnRvdlMNkbbOygGMxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+7TX9oq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757680546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vl4F3QETQ6Qmt3iYKAH8GUoCSTGHR7l04Sg9h/MZCJE=;
	b=C+7TX9oqLrppOBbv0t16W93Jb5oOgC1Btl7zBitJYbOFuUy2ceKkmTc35wa0osncv8DLt2
	UDunEMw9PeHKyqkddSd/95wh+j0WBnp1ybYrP2uz3ZNx4v7Z7XcBBG10Q9dvBYie2QrbsF
	HkI5d/noJ4motv/7s198c5ihsYOybTo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-FLWGTnTKP8e0_FTxtCAP_Q-1; Fri, 12 Sep 2025 08:35:44 -0400
X-MC-Unique: FLWGTnTKP8e0_FTxtCAP_Q-1
X-Mimecast-MFC-AGG-ID: FLWGTnTKP8e0_FTxtCAP_Q_1757680544
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so17620295e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 05:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680544; x=1758285344;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl4F3QETQ6Qmt3iYKAH8GUoCSTGHR7l04Sg9h/MZCJE=;
        b=IHJ63zwzS5ggDPDOQ55CMmgNELl6oJan3My8eUleltQNEYaHgQc/6s9U/S9+lpBB3D
         n9nUsF3mGNKcIx/epn52rmu0PKvoO23ej52xd1QCSIU/tsiRgNdDR9CeDE4saqbvfMdC
         ud/o8gQOYYP+qNNwK2zc6FodbqgddgPWHKg1hqKlxoEkzqqQyUYDKtLgrGFkTz4cak8L
         rLKPVerAhic95ZGMda/c02ay0CEx6zhoS0zMMS2ck7UOIqRlu4b/vmlcUUVYL58NU1cM
         J9hqHp5cW2QpqAaTFDb65/FPhi9E8SeOc4yqcRwTtIPSb4UB1Mb7qtYCJFDrRuo/Dt0G
         xg0w==
X-Forwarded-Encrypted: i=1; AJvYcCU20nYVDdR6P7sUv095QUJz3rPxpwTijHS5oyINTB+NEcGxHqDvD5VecUNN6X/I2T4Un8yVf1zDG4Rjv5SGD4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uGEjt5UEyZ3zX6vv7FaroeUTyC1AlLO8AY877VBHJoU+B0Iw
	6HtizvQMrXtDmI9r0l1TZB3hwwEh3iLEPKFxwko3VxwIL/AF69RXI9exsEgrXbagFpXcAm+wZf6
	yscLj+MhfxyVCSVnKkr6SrtfKcUlr5YpBV2328okeHheOW4r9scnmfPrIZRYqPqXq8G1raQ==
X-Gm-Gg: ASbGncv0QeiZwoE/vsm+9Em/HvXa74Y3yPZZt7embNevrmtmD6ntFMG/rryiqnQ5/RY
	Qh3VvlGdqZulrZx7wu/23sHHTBEpUYjcLTsqhAvo4DCKEbx1wqU6ni5bzemWdhsL65APQLmUDHP
	7P8Sp1pEkxiT0UB3RWQhh7ANRPCiSjPMxyEkpAnS0DY9ZvXO7mfB8114eDnryqx2g7W1MHO3G/Y
	SJ2cEtempHnJKGSK5Djt4RWhUn2VNf1gS/ssya9bBLXzzcOxiLH+K7BUbqyXP7U/CUhLJi6YDPF
	wW4Ko8uwRzoyMn7TDK5+Sp1HVgC7FULtzr287BkaCQ0CjvL6E2bVflQvW+d+in7FdJHbXZwTeIf
	RkzDZW7NbT7NL9zCTMlCSbbZJG6IhGUmB0pBBXJ2JMBxXeOYQTWwz0hiP/lPZGaILv8c=
X-Received: by 2002:a05:600c:6d41:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45f21208123mr19823975e9.35.1757680543620;
        Fri, 12 Sep 2025 05:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/oqbYA0X7f4pVcp67reuoA98LJhkZr0rCtEodluWIHcTYO0r2jSI0s6HquK2fSwltZexZQ==
X-Received: by 2002:a05:600c:6d41:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45f21208123mr19823715e9.35.1757680543157;
        Fri, 12 Sep 2025 05:35:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037b922csm65908345e9.15.2025.09.12.05.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:35:42 -0700 (PDT)
Message-ID: <175479c6-d43f-48b1-8fb5-c78a555cd315@redhat.com>
Date: Fri, 12 Sep 2025 14:35:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: Add -Wunreachable-code and fix warnings
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>
References: <20250912123025.1271051-1-usama.anjum@collabora.com>
 <20250912123025.1271051-2-usama.anjum@collabora.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250912123025.1271051-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 14:30, Muhammad Usama Anjum wrote:
> Enable -Wunreachable-code flag to catch dead code and fix them.
> 
> 1. Remove the dead code and write a comment instead:
> hmm-tests.c:2033:3: warning: code will never be executed
> [-Wunreachable-code]
>                  perror("Should not reach this\n");
>                  ^~~~~~
> 
> 2. ksft_exit_fail_msg() calls exit(). So cleanup isn't done. Replace it
>     with ksft_print_msg().
> split_huge_page_test.c:301:3: warning: code will never be executed
> [-Wunreachable-code]
>                  goto cleanup;
>                  ^~~~~~~~~~~~
> 
> 3. Remove duplicate inline.
> pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
> specifier [-Wduplicate-decl-specifier]
> static inline __always_inline
> 
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


