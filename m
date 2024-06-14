Return-Path: <linux-kselftest+bounces-11932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C3908BAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABF0282C72
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80519645D;
	Fri, 14 Jun 2024 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBgG46Ve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8353196D9A
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368186; cv=none; b=U8moXaHRTJfxGE+d0/C1GAR9+ihhONmb6Lv5fLt2j3bUr49DVAtLyNGQEVgBwBJl70o6CbFjxEW+3RV7294IOgnoO+c+RqdXgtSiVTah9OulJPHBCdZ/nQzwlQQwSXi63Muu3dBiiSexT5rE6PHoyQfGUSRiwBdH/WJHO0DaXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368186; c=relaxed/simple;
	bh=OhKgU15ZWjeC2N6hpKVV9bnKlAh6JPYi/WMmK1hnWQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFLP/iwqdqITZEOGqQ2/WXuEI0Kb2b7+agdSG3JBWWk2XbY7x940IZaFGkoPZIs+EOB/elDU4rhgomkbiMbqXYqHla+HQ1GzPrT6/njal5W0gC+uXg20fh/nd3iKN/QPcvClT3p0FPH+OSmB1RwXedrqMH0HChwppaQl27zQl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBgG46Ve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718368183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T8R5hFnH4t68Z/MixcytprsQWRka9fyIV4kLoij88qc=;
	b=KBgG46Ve1Y2qnEwDjnztw9LEEs8cNWWTsoeYjlqDgC57cuXNdtyFtrI0/UE7b5lCxWmjCJ
	RYung5BC+lv1D/GKWs/ckKLyHYq4g12VN8IrT38OwiCuFyA5tuaHJDvmRbCZIbrowZ9TpY
	rNLaT7gCK0T3RuzWrpGwyVdjjGfKxMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-7cv7RjqnMKKhFXjM9AI_wA-1; Fri, 14 Jun 2024 08:29:42 -0400
X-MC-Unique: 7cv7RjqnMKKhFXjM9AI_wA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4227e29cd39so12426915e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 05:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368181; x=1718972981;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T8R5hFnH4t68Z/MixcytprsQWRka9fyIV4kLoij88qc=;
        b=hBVvTrBFEiaJ6lTSAjsFrzugBiqEqteYB+y+vrjAKTn0wrgNH5+kRP1Ihp0hpdVRQA
         5e8QYmhgW59dbsaYcJ6dhLaRP5fl6lHjPY7r6b4gyrSZpPa1fJ4vghMh29rFYP+Rbv9m
         BPxN/7d//Afm3MtPXiDE4iG5AXwHT0oJZuwBPRmFHz9hmocC0T2QtQd1+hjOmfj78vS2
         FZ4h8HTlweDbRZj24kKbjPVTsqPR/RxRlacoP5/ir+4AgUrRHe1KmT+cg/UHzXHG7bt2
         jKYWrn/u+W0sMwN2B1yZhXzvj4UD2i5RD+bmYaP0583c7mgd2pODmwa1TTZYLnl7F471
         XLjw==
X-Forwarded-Encrypted: i=1; AJvYcCUk0mfF+YC2YBG4eUM4w8xr8uKrDSZyCCtRbu1f4Erdj6/EsQZCkKZn0P1deuSFyPLTOf/VOxTJLHtr0Y9k/k8cA3cfmIXf3yqmORoaboeT
X-Gm-Message-State: AOJu0YxNAF0hkMz+OpmiFtK0HXjmE+dJQhHzMHQHs2w725hiPlrEn7uW
	IBSSHVx0eSklqKtqBFXOXOYZcFh46pIB2rxMw1u5UcrkCpglgyIHQaKsbT65GZRubzDgd6x6S9m
	aTGmCYF0u++SVaqRRxn2kb4gNCK6JljpbsQRINQkAknwTYP2SrQESRDeJLjtPCEcjRQ==
X-Received: by 2002:a05:600c:1c13:b0:421:f346:6b06 with SMTP id 5b1f17b1804b1-42304848abfmr26039045e9.28.1718368181292;
        Fri, 14 Jun 2024 05:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7U3z0j+A8w50q9VK9ennnUqTj3tgKOwX6iZR1j+mid9Zz3P1cpJZ6LxrKXNgf9wgqUZyz0g==
X-Received: by 2002:a05:600c:1c13:b0:421:f346:6b06 with SMTP id 5b1f17b1804b1-42304848abfmr26038715e9.28.1718368180879;
        Fri, 14 Jun 2024 05:29:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e7e3sm60036305e9.12.2024.06.14.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:29:40 -0700 (PDT)
Message-ID: <b125057f-5e84-4ba7-adfd-792382cbf0f3@redhat.com>
Date: Fri, 14 Jun 2024 14:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] selftests/mm: fix vm_util.c build failures: add
 snapshot of fs.h
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-5-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614023009.221547-5-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.06.24 04:30, John Hubbard wrote:
> On Ubuntu 23.04, on a clean git tree, the selftests/mm build fails due
> 10 or 20 missing items, all of which are found in fs.h, which is created
> via "make headers". However, as per [1], the idea is to stop requiring
> "make headers", and instead, take a snapshot of the files and check them
> in.
> 
> Here are a few of the build errors:
> 
> vm_util.c:34:21: error: variable has incomplete type 'struct pm_scan_arg'
>          struct pm_scan_arg arg;
> ...
> vm_util.c:45:28: error: use of undeclared identifier 'PAGE_IS_WPALLOWED'
> ...
> vm_util.c:55:21: error: variable has incomplete type 'struct page_region'
> ...
> vm_util.c:105:20: error: use of undeclared identifier 'PAGE_IS_SOFT_DIRTY'
> 
> To fix this, add fs.h, taken from a snapshot of ./usr/include/linux/fs.h
> after running "make headers".
> 
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


