Return-Path: <linux-kselftest+bounces-40372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8124B3D0C3
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F102B7A4ABE
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 02:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EFE1BBBE5;
	Sun, 31 Aug 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWwiSIuf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D152BB1D
	for <linux-kselftest@vger.kernel.org>; Sun, 31 Aug 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756606653; cv=none; b=ev0kf+LQPgCot/E8067jNeXtG8LGRzBdGWw8T6A5kArsQIto9slJMwIVflBwnkuuGqgKEZSpimD+XR3/fh6S8XJEubpjULzfX96cNmNs6PVCk245h4BHf/xqZAsk2c7xUBj8WiKGRgm80t2/aqSfj5RNTbIVX4tOgnfNC9E6M34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756606653; c=relaxed/simple;
	bh=OHppVaTN6p9+/ZMG87zsvxH8q+tfMKk67lb0jZzg6sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5RE07wcbwVjnzK10/VcwRdyKKrLzdNG2WnUCNdKcv+GIIx2akT9110aGG/B88R8KCQSUboakcY1562MBlb5CXdVizs9GvNEe07d5VZ3l78JibKD4bnZcpg2jYHtjEkpu4CE5qEsR5cj9CmPIm0Kn3Mo+KW5HioIa84y5kHbzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWwiSIuf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so7694552a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Aug 2025 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756606650; x=1757211450; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WeT/zjIwqOiQO4cUG7X3O0wwJPbXUK+ur0y6w+idiU=;
        b=VWwiSIufNUieLA//l4ijap2rJJvrINmAn+2IeQbrdMlV33sfBPYSFzoFb+y0iHtB85
         noPzgi1kCyK4a9dNvXVmc3JskfYaTB5nV58/qmFieY7ui5zMMwGP8nj5gJUKcrJkeTJX
         GtcCQZoV6DUFWg9Q/gqk3t1LI82YZW39P/p0ZBVH9LQ4i6nDpYfWOyWrsTA/Zb9Rw2Ck
         gpF02hMQwzp/IsjKGRr7nEIEoOgSU3n3Jn0fNUO6ekYf5VjC4xYiysmD1LZ4NpqqPfHs
         Z91NtqKgS267TnTVcTmgjAqx8H8xQkM173e/SFUit2dBFfnFievlmLwupHVj+Jhzemp/
         BkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756606650; x=1757211450;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WeT/zjIwqOiQO4cUG7X3O0wwJPbXUK+ur0y6w+idiU=;
        b=ShqA5eOlo5RZG0b1g/sWln7kVVZ2728BPwwo0KBWhpdx7GOjhnGnVwYu+oIRQALUAp
         14kRombarlTCwSXw9QnUoqNNMfQQ6FtANrwQTQpR/XyFBym4oVnVQcNAnp4kEZJb01Oh
         ZhMh6P76IAeuXvk6O1ZO0U882BBapTEln9OEope2cAu91Xqckgd0lklnp4BmkyT1OO78
         MK86CFpOQzoACXqEC3IMN5xkdHpwMpYkclNo4JyTKzppNYtHFitVcQfTyRYlwpjh4oOo
         NKjVwV+Fi7BHOFcXUYwWEOw2TeJyAku81ogBWnEkUSZ8TtPO0EGJL1NiyOJ/3E8bFmap
         zsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXj1DXWihPvWPFj4eJ6IeFitI10RWoe7GonzzuRcxZAIvUiAt0BYNayy26f2Y6+zjlez8pEV7MAPO/jBrZeMn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1lmLYDHCyNB8t3eOAEU+O8LanpxVV2TUQdwNgzIjtIlPenyi
	qcelc6Es3QoRWuTulgV6KifYuUuMQhL5JvMrTBRsA9Pt2epAMQ9K1Scs
X-Gm-Gg: ASbGncvAtZqs7712uiYLGnYcuFIDkBa6YXD5Ii8oe8QSVO0H27Ki/nwJv+KRWc1EZs9
	aabew7VnIFL21hpf18s6XN7VCrn187IiEhxoebEvesXEeyaNdy4lTRUBHlsjm+RktKyT3dVe72v
	zD64PCP59XYmMw6mwr+brlCkGNE1ypODPRoozOa+8oiGcz2Ju7cHIbXK2qLQMCVmV9SYO+OAaRo
	WIZ0l0yVmL5LyTo91Yg33qRbyF+0g5A1Iyg08lp8qNjNMdiRDAP9OrCvCtogZAt2moBtBaX6KAS
	8VeucO+QMcKr18x9htZCM28e7l6lOxRXaGKk97u5Ae89wsbpdSQFCnyF44dkah+lb740h3cuHpy
	Kuf4HJBgFkOBN2p9obc4GtUikzQ==
X-Google-Smtp-Source: AGHT+IHpaE4oQ84bPky6E3Gt38jrVXiAH5Rw5HJyfEG7UTk3O51dnCY5NKNk5Jf8sLxJx9Xd+oG5ug==
X-Received: by 2002:a17:907:97c4:b0:afe:d5bb:f41e with SMTP id a640c23a62f3a-b01081b3e5cmr457418566b.13.1756606650001;
        Sat, 30 Aug 2025 19:17:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04189de5b5sm80240266b.10.2025.08.30.19.17.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Aug 2025 19:17:29 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:17:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
Message-ID: <20250831021729.seingx2yto677ngq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
 <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Aug 30, 2025 at 09:32:58PM -0400, Zi Yan wrote:
>On 29 Aug 2025, at 22:31, Wei Yang wrote:
>
>> The check of is_backed_by_folio() is done on each page.
>>
>> Directly move pointer to next page instead of increase one and check if
>> it is page size aligned.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  tools/testing/selftests/mm/split_huge_page_test.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index 10ae65ea032f..7f7016ba4054 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
>>
>>  	/* smap does not show THPs after mremap, use kpageflags instead */
>>  	thp_size = 0;
>> -	for (i = 0; i < pagesize * 4; i++)
>> -		if (i % pagesize == 0 &&
>> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>> +	for (i = 0; i < pagesize * 4; i += pagesize)
>> +		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>>  			thp_size++;
>>
>>  	if (thp_size != 4)
>
>It might be better to add
>
>if (pte_mapped[i] != (char)i)
>	ksft_exit_fail_msg("%ld byte corrupted\n", i);
>
>instead to make sure mremap() does not change pte_mapped[] values.
>

Thanks, will use this.

>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

