Return-Path: <linux-kselftest+bounces-40432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39CB3E3B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA33A7FE9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C332A3C4;
	Mon,  1 Sep 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4A1SlfA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727F32BF3C
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731091; cv=none; b=SyDg9cqOVWZnnBQwVL8RUH/8NzdfFQRhUve5Bx5PADbvSSn2xZTnf6V5PpsW76tC5ZTmTtW2vdicY7bg6gyGAZCAqzoSWWoapTVur6YGaXmHiyqbJofuaJH5gInbBi7EyPdM66f+e6OjnlHMP2AduK0QtDw/bq4Tjh4bOMWDYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731091; c=relaxed/simple;
	bh=0Y7KClPk+ctEkOn9laBkZuJ63ot0q6jxnS3ylVWJWkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIWA+53WFTH7veRPDXK4/vjnbB6U2yGZJGO0oHexbUxvmjGhCtP0eoMVxBGSqf0R2zCkDWXt6yxhcYs1Q70u1al9o1Ez5YfMFTpwg0/GppXE/Z8zwyoPTVp9zZ1aKJ/zE+LOe6FdnQwPiUYZ4fpg9Z4+NfwQsJifn/ejn3vGZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4A1SlfA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afede1b3d05so723370866b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756731088; x=1757335888; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqF+hZbPh+nXreNj4wa7WGyYViBQF8JL9gx4eQUgXJE=;
        b=B4A1SlfA2HwzdDQ6BEbLsTGTnPsrcVaB9cvTCwWeNfG6xmYM2HltVFRC4/1w8VH76Q
         455oa1zDK2iOp1ZemYzMY/VZdM2CIKYj2fypxXQ3RrmUMCdrJHhrzz0TD4j+tCla5lXO
         V/0eWz2CrQXt3XR5emw2J3JAVC8koNTNqkVc3Ks1mW5WKbmznPpQ6A4uIc2flFanLKQS
         JTx0SFqV6ZKJ1RmgZmz6zkYv6qzJDHYqgN2ZkwU06AfyGhbSoo02B4VHDHtsYYkdBD9Y
         +Y8gkQOA43/t05pQMuMuejC1UsthBf9Z/cGDmzLUnjf0N4yNZ9/jI8etT7SebS9/xCAY
         KuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731088; x=1757335888;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqF+hZbPh+nXreNj4wa7WGyYViBQF8JL9gx4eQUgXJE=;
        b=AMb5QsZjHxN4CpAX3+AvBwPRlHbndMEOvlbDA+/NlUp9upBjVwMohhEb84ZwDw6uJc
         Cx8pV1Q7cWxB2cFKhvqYNKu4wmLQiolbX6zf+o+mVlOkQYHpYwOWcCX0jv5oyoa+S+1a
         9fCUe/wEQ1nglnqNpbdRG5ZTnIIHkpD1vguNTVovDBrxu0h2E1PM0nXNEnCDTiTgkn2s
         9eH/W4fUb2hW1MEtysGDQsc4mLRorhAjG1xbTPZJD79hl6HQOoXhGPTdsesHr9ai94Q4
         PXEAnqs+bqesb5+1wbca5aPNvWR9eWndcCbElXEGUCjXWpotS0pMw+SJJmNwZPrBnZh0
         k77Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP5Bym5zn9hiW7zuqwj5xtfMML19hxFj7rBskVLSlWpAfVTqaq0P3A6x/QRzNrjfULxTgBcxzXgLcqELcDgdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmN5ekAdnzSizAQbLhqTbiKuLHm1schFPcg30KUCNYa5Y718dQ
	Q4TYOfWQgflvpJNIUcsBBkmhagWDjiTS1mp+IRZ/Vz7s0PukhdVhQFq9
X-Gm-Gg: ASbGncvc743J/1lAbo5Ol++0qNqcXBR8Eyy+2CycZeJXzNmpegwE2AY9GGNi6t/JKuz
	+xIxQt7pUgHqk4Lh2aS1b1yxIjPpychAWpuFiEf9gwE2R+mpbWCU6eA6eM6XRYoRATlczN1OYun
	0YmVQsZCGlHFrn7FG4D5RG13PrnvmYJJMl98jqHbvQhrO+dL2/nhBXXQyz+AxshJn40qf56OEQH
	Buz233JlJeSpB1WsSUQOMH8PjXhC4X81K6cz8NNedytrpQVq4pi6JB9e6at7VOXfkx8F4KkFfkk
	qyhkvMK+FsdfRaXcbx7iNGzYAiz8lpc+iVEtDKrZiPpB0rYdZzKKQ44RmkNeh2lYoB80yZbHf7b
	HCkZCyi4ejHw8jF6pr4R9YoYrfE0zcZznMa55
X-Google-Smtp-Source: AGHT+IHvmHfcLHgFlGk/m8KuGlVWmwSTjF/X+LrwDzuawwRSwyxbRGkBHfPGjI/Zz8OpUZfMC+cDWQ==
X-Received: by 2002:a17:906:299b:b0:b04:25e6:2dbe with SMTP id a640c23a62f3a-b0425e63044mr395870066b.63.1756731087624;
        Mon, 01 Sep 2025 05:51:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04148f95b5sm419796266b.92.2025.09.01.05.51.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Sep 2025 05:51:27 -0700 (PDT)
Date: Mon, 1 Sep 2025 12:51:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
Message-ID: <20250901125126.furb4fkgim7adzhq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
 <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
 <c89a9096-716a-4bbb-a911-99096ff8f0a0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c89a9096-716a-4bbb-a911-99096ff8f0a0@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 01, 2025 at 11:32:11AM +0200, David Hildenbrand wrote:
>On 31.08.25 03:32, Zi Yan wrote:
>> On 29 Aug 2025, at 22:31, Wei Yang wrote:
>> 
>> > The check of is_backed_by_folio() is done on each page.
>> > 
>> > Directly move pointer to next page instead of increase one and check if
>> > it is page size aligned.
>> > 
>> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > ---
>> >   tools/testing/selftests/mm/split_huge_page_test.c | 5 ++---
>> >   1 file changed, 2 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> > index 10ae65ea032f..7f7016ba4054 100644
>> > --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> > +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> > @@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
>> > 
>> >   	/* smap does not show THPs after mremap, use kpageflags instead */
>> >   	thp_size = 0;
>> > -	for (i = 0; i < pagesize * 4; i++)
>> > -		if (i % pagesize == 0 &&
>> > -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>> > +	for (i = 0; i < pagesize * 4; i += pagesize)
>> > +		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>> >   			thp_size++;
>> > 
>> >   	if (thp_size != 4)
>> 
>> It might be better to add
>> 
>> if (pte_mapped[i] != (char)i)
>> 	ksft_exit_fail_msg("%ld byte corrupted\n", i);
>> 
>> instead to make sure mremap() does not change pte_mapped[] values.
>
>We do have a corruption check later in that function, so I think we can just
>keep it simple here.
>
>So this as is LGTM
>
>Acked-by: David Hildenbrand <david@redhat.com>
>
>As noted, we should just move from mremap() to mprotect() or sth like that
>which has clearer semantics.
>

If my understanding is correct, we should

   mmap 4 PMD_SIZE region with RW
   madvise and fault in to allocate pmd-mapped thp
   mprotect first page of each PMD to read-only to split to pte-mapped thp
   check whether the page is backed by pmd-order folio

Is this the correct way? 

-- 
Wei Yang
Help you, Help me

