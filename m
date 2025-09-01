Return-Path: <linux-kselftest+bounces-40405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D69EB3DC1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F2A7A977E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77241C5D6A;
	Mon,  1 Sep 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLys55QF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456812110E
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714623; cv=none; b=jYQiMma/oNvrOoLGN0/rMGzAb1SFa3Ob/AUpdAwbB0N0jghJjDXMzJfgGJx8Epq19WK2J907zqqd750rgwFX7ivlxQD45wtP6f+96D+YsT1/aRFxXBl6224lFoy/piY7WZBKYXoy/xZHdL69z8QH5Lp8xqpAkVCpsFbn/vwkSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714623; c=relaxed/simple;
	bh=Gw9mt8i34qZS9P9I0dE5uk1yGH5tborOHQbgwGIYM7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVyrbN2zvgUbQLPb9oTwVPQhNnbmbAZDOnpNwWHuH/d2h+LAILd1/7ZZ/XxSOhxj7VfSkd4GDcVQe8aDexustIpVaN+D/v+cboStbHvYTjUR0pzTk0OMXV8knNr0d+TUegvXpK/gXYhYMlUXnbopriQjS4+k5b/pAR2lQGQFLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLys55QF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756714621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nkLdfO7LREf76//a5lXUqelHdImxWu4Mcdt/w87Pji8=;
	b=ZLys55QFsm86S+X4+e92q2303qd8NvglK+n7iO7FEWcEnXVs565bdkrTkrWZIRD5GXYGE2
	W9nGTDDnu9CN82LLzLjzIYkAyXNtFOKT5D3LzEhjIyZ8POgEZ+zpd1Vzgs24a3G9SdR8hu
	CUpbytYn47HYio5gxDHUyBScmJhY0rE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Y93Rvt6yMHqHfMMZHx32YQ-1; Mon, 01 Sep 2025 04:16:58 -0400
X-MC-Unique: Y93Rvt6yMHqHfMMZHx32YQ-1
X-Mimecast-MFC-AGG-ID: Y93Rvt6yMHqHfMMZHx32YQ_1756714617
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so1816296f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 01:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714616; x=1757319416;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkLdfO7LREf76//a5lXUqelHdImxWu4Mcdt/w87Pji8=;
        b=J2b6eP+91S2p3elVXEKwq5906hk7fhlhMz8303CZ5rC6i5uSHww0BTPMRZaZM9b3Vt
         yDwhE2fV5zwEfjpaAaloD9BtBphKiNhsB9A3663Al006ydLov3bMK+kN4JWsbV81FT/w
         Kh5x6mbnGPQo/v6BcXDee3fqnrzwUyfyTBYjOrVVtrafDE7pyXSxKqdhq3i0rP3mgB3a
         GUMUbNC/bKN2aLet0ZprWdV8xmxwmELKtQc1r4pXBkzYVmWWZLnjeWcHPIMXip/kiKvM
         2llnTHw8Nqa2NOD5Pxkw6ZaOcf72fMkxYqwpG/Zjz+a5eLUj1iLMSDwnwqjw62OopEQe
         5j7A==
X-Forwarded-Encrypted: i=1; AJvYcCX2WQCkNhRB0sIqH1fI6XjR/HdfpVXWfqR8HoxTv3HIlMh+GIYloQ3B09MbfrI/g/TPSK26T30crScre25Xs9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5hfIRLUT5/7Z9a60wRgN3gY1SJ4xZweW2mDa3HjO5xJBAx2b
	O0tUOvLrqdLfEbP2BfxHZK3O/87fonBqvQEfy04pPa5e7TlHQfjY+A5rgonvljbQ5m99sKu6Mja
	Jdx+eGX0G8zdKVvf+muR8fd+klPZbHOkM9qE9k9zMgd78l2aKDtkp9M6sMI52y7RW8ZvNHw==
X-Gm-Gg: ASbGncuJx7fVi8VRRKK/D83mmWfu9ZLVpaXM5Cx4Wkm3BIVrWAPxpUgeu99eH7tDaOX
	80Qx3MrfF6Afw3OqN6oFeGnW0JdCN5f29UJW5hlIdUT+vltobv5EDk5CwZE9c/mv7TWqAHVWY8P
	OoWXdKI9LPwpIa4gMHU+peF5rYfddGd0WUgutvNKWnKSZIJWUsO+W6TOVTx++XFXxg8ZJV4gQhM
	qKauFBpvo7jx0tD/QfoOssstNojEh2rqcw00rJFFi7n7dq8Jx7VrZmdAepkt1+8faixgWJyRFow
	ivI0ZNqqnaF4HZBCqMQiheAHuuv9z1xf1TMsvxVDdYBz3HxaRQ3+i/AxtAgpxKgnJOBksIWF77f
	0QKMQH8itRmiwSWYfcmbWqOHQEw9HsD0e+5LHKQfBHsld+0AuRwBUTR9y/OTcr4BNuDE=
X-Received: by 2002:a05:6000:1884:b0:3d8:7c6e:8ad4 with SMTP id ffacd0b85a97d-3d87c6e9003mr439458f8f.10.1756714616566;
        Mon, 01 Sep 2025 01:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwthdaUuRN/UHZwPjQCWXHJR2aYsLBcBwtQCJ670MV0m+dvqvfBHbNmHISZ0huNgDdFxfD0Q==
X-Received: by 2002:a05:6000:1884:b0:3d8:7c6e:8ad4 with SMTP id ffacd0b85a97d-3d87c6e9003mr439432f8f.10.1756714616154;
        Mon, 01 Sep 2025 01:16:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0c344f6casm13232159f8f.36.2025.09.01.01.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:16:55 -0700 (PDT)
Message-ID: <df27d5cc-bac8-47ee-a03d-eb1eff6dbe39@redhat.com>
Date: Mon, 1 Sep 2025 10:16:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, richard.weiyang@gmail.com, ziy@nvidia.com
References: <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <20250901081109.52460-1-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901081109.52460-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 10:11, wang lian wrote:
> 
>> I'm confused, don't we have that exact check later in the function?
> 
>> Your v1 might have been better, unless I am missing something.
> 
> Hi David,
> 
> Perhaps you missed this in the v1 feedback:
> https://lore.kernel.org/linux-mm/E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com/ ?

We have:

	/* smap does not show THPs after mremap, use kpageflags instead */
	thp_size = 0;
	for (i = 0; i < pagesize * 4; i++) {
		if (pte_mapped[i] != (char)i)
			ksft_exit_fail_msg("%ld byte corrupted\n", i);

		if (i % pagesize == 0 &&
		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
			thp_size++;
	}

Sure, it's after the split, but if mremap would have corrupted the pages, surely
it would still be corrupt after the mremap+split.

-- 
Cheers

David / dhildenb


