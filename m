Return-Path: <linux-kselftest+bounces-40356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C401B3C8E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 09:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F91B24539
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 07:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFD8264624;
	Sat, 30 Aug 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbW/k7Hw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11892264AD
	for <linux-kselftest@vger.kernel.org>; Sat, 30 Aug 2025 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539992; cv=none; b=R7x2vtW9agIdG2yNcpL29cbih+NzdBai1rpsCwQjhhCQILmOxOKttlaoojjpNKzdq5jKFqRoE/Ts/e/HvGXxo7/uwOS+IxEkgN/LOEANv/Gftr+i6KFokEMKN/eO985kvSeKNYkEJVNkvvgyDq9oF46yW5inHxdwQBxX0yM+kJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539992; c=relaxed/simple;
	bh=OqAYBVUn/BDqYOKqySqeDTB3zGmjcoN7B78SpJKzWP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trRMmU/JwwiDuoxwPZxhEkE5UOa+ydsa70nABh/ktCR9CpKTSV5HxQ7wBdsnwMl00NcVTCALWGpyg8hhhQ43J4cJGZ5i0K3rL67HCb2ChUNuoR+t4nF+FIoD4wwbYaYbbAR+CHd2O0Kf7z8zdZJM9/iiUhqtn79Z7eEQrJqLRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbW/k7Hw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61ca9a5b41bso3790315a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Aug 2025 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756539989; x=1757144789; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXtX9Frtab9UqXTSJxGjWOLKxBJrHqjflBYkitY6e9s=;
        b=EbW/k7Hw6fX0vtALByXrYwp24Cx5fc6+y8gGh08LxnvUabwAjTv4GcNSPF+tPeFZDv
         5eBYl+TGIbddZ77p4UPrfJLs7Uw6tVF/ypzybP6YLR/c9sRwmrWl8qwWWPqKwDoC1IpJ
         qQ8o4Vb002WkaOHih/NvXIGMRftSTcemFrjy5mLlO/VVBZ0/F67fUrhyV7xNvLxREW5r
         rqoJbhgJF3+Br5n3dFjU+ZytvR3lSElXeFcWJVGIAAP/gu7NoDTx3veFLVOrVP2tgYhL
         a0XhQOm9wBVZjjxMYcMWGsl1SOAiyFVdlTSO82ttLHUxdFWhQWnvl9kIqX8/hMiALJpp
         gIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756539989; x=1757144789;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXtX9Frtab9UqXTSJxGjWOLKxBJrHqjflBYkitY6e9s=;
        b=qFdHK8fcU28ooTSvWrqdzHemZ/dvTnB1u6sk1K6fSIA2UcOd+l7q3ol5Lp8OeiN3bm
         Om9yleG/RxWcz2Dj1f2SQz7K7nkX7piOAUbPr6XS7FSRX5lCw9TyAHjiCiO0RRafUTNO
         A4LjRSKa3qsqgKiacn0lZH7zPasfg+e03h/D3NpuoSSZVnUzfP2L85wmOddYiceWQ2dY
         rH1UfreZaoupFgjU2iZm2epULvSX4jVrb/bypk7aNBUXZhj9q7hs5dwJ7Jz/m0GYzMsz
         5r6vSucZpLMtdlj3N412oIMeRHlPhuLp2oiUnFkdhpq0CtkU0BCbe9rXr6AIKI2zpVb5
         f/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSPipZSG1MV2fUB888Ies9bPZu54Q2eBFgOdiFP+yQEI0RgRKAGiyum+t8vCEtL6Xq4iIeItp6XoaA3CbBERo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGDqRE2R8WZayUMhl6CezYP5oLULRJvpeqRHSD3nBk9pm06hp
	74l0/AiCAxKaMyTFplco+jDy3ZWC9LPXz5sIw3o5zSF1uq5yFHgpKwI6
X-Gm-Gg: ASbGncsUho3PrNmBZKgO5o52lys0zVOJxT+pt3hLNo9GyJP9uu/iCMjSbLMxvsSaKq+
	u5ZtM1ajLpUkTiNAxZ3gm50jZ41uWiTHIy/ruZ5iGoAQDg9YjBWxB2+JXTb4C373vlBnJQkpNOJ
	ro/pyKbTJLoR25v9NVpiabtYQqAqBKCeYSpN57Q/T4rqU1V8wQd8eJ6IIyQGZ1gxM3wZ+ZjxdR9
	cci56D+4Zhi4ws3i5QdZ3v9iJUnyyM6DjukefO0sHn6E2NgLA7Iu2rI+akPw5ISwc+yPWIEsn3M
	Mgis/S2aDDQNcXtE0mEpG1LbrJqVo33gL43pVf2f7Hzc/wF481fywBLSEqqB2HBxknid1vhLRKp
	VkREYmNXjhGG9EMQj2o6DqQtMfA==
X-Google-Smtp-Source: AGHT+IF+y93hNDhCFHUAbkTqB7bJ7rRk1NYfczRqTKcmtM/XlUDeBnRrXCkQu4Z3SKAA1EblyKm2yQ==
X-Received: by 2002:a05:6402:3589:b0:61c:6fb9:c83d with SMTP id 4fb4d7f45d1cf-61d269881c8mr1010269a12.7.1756539988770;
        Sat, 30 Aug 2025 00:46:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7edcsm3185195a12.6.2025.08.30.00.46.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Aug 2025 00:46:28 -0700 (PDT)
Date: Sat, 30 Aug 2025 07:46:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
Message-ID: <20250830074627.pitdp64svss6slyk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
 <20250829200953.1757e85542b1126c4881d600@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829200953.1757e85542b1126c4881d600@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 29, 2025 at 08:09:53PM -0700, Andrew Morton wrote:
>On Sat, 30 Aug 2025 02:31:02 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> The check of is_backed_by_folio() is done on each page.
>> 
>> Directly move pointer to next page instead of increase one and check if
>> it is page size aligned.
>
>Why?
>
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
>
>Looks like we're doing more work.  Is there something wrong with the
>existing code?

Excuse me if I misunderstand the code.

Originally, i iterate from 0 to pagesize * 4 one by one and call
is_backed_by_folio() when i is 0, 4096, 8192, 12288.

The change makes i just iterate on 0, 4096, 8192, 12288 and call
is_backed_by_folio() respectively.

Current code is not wrong, but not necessary to iterate one by one.

-- 
Wei Yang
Help you, Help me

