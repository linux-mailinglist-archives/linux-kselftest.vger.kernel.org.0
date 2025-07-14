Return-Path: <linux-kselftest+bounces-37262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB2B04209
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E0F1A6436F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9125744F;
	Mon, 14 Jul 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ZBmZL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EC25744D
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504173; cv=none; b=LPB8/MSEiRUZS07f9asT0dbEGcZfd7m8G3UkxvFbHSM+yYpLrJxsCSxz5yQwDttECFzXkSciPetsLjcFhNztXZ58VIx91gLYrLQj1EmNAqUtY+gDzCjWOTr4aZIj7FVklBWALyQbe1MFR0T1cm5T6ZhCkGDN42olPTPhOZqmQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504173; c=relaxed/simple;
	bh=qYHBNjBSu3G7R44MM+5GEBY0sN3Xdw7sC0g1jWh8Fjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUwvNcKDi10Dz+BDkXxZ5WGEonPujJT27BML1lYpWnK+0PIsluXq2/iiaPPCtSKkLNLB9yCubUf2CdKF4YL3dv+7DbDe4S175+URhZSucUklzMApRvmSiugCnZpk/O1aFqk/4tHBV5L1JDAPLdcbIRjDLPrVjHsZj+mvR0//SQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ZBmZL1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7974539a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752504170; x=1753108970; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGV3n5W1egWo03wxOrU8BU7faH4EKgSlUZEQZXvL0b4=;
        b=E0ZBmZL1mJWNtX57W9VCYbur47iKPFiI8M2ksJlvKa65Wx0gFIfMespIwbkFSy6QH2
         O8WWOk7lI22Wn5/u3fDGfOQmX0ipZKTFnZLMSgvjhFy9md1tiFQKCtZYvKItyfMRK143
         0yGNwzcbIMmqwYkoEjzgU6nhnZXMnWYcUESi46hPtEQJDjZa8ycqD79wtllJF9bGXWR5
         BFqg7Ro/Ig4uVDkbEhl2lRvHwPPkIqqy9TZiNXg521Hd/9MBkG4h4eRMF30yfPvWrJTc
         /WMNBSdkjz7yiDvbGanFLtLbulfHw29g3K5bvt3Z/VFMHnkypOFLsAuFWR6YCzzjAtxe
         WDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504170; x=1753108970;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGV3n5W1egWo03wxOrU8BU7faH4EKgSlUZEQZXvL0b4=;
        b=um55zqkKLpKTOFZgyJDOK3IQA/1fA+MRHcOKTXX1mi/4vYm/0PWCgcQ1aXKJY3v6P1
         E4HclsZou3YqGFY515gd5PECdF989xIkkg9mCl858xtR19+r0STnDLVHYBfGuCX/Wu/M
         orChkcxGV2rS/r/sxYSaAQkZYsPZJ9Iza+OphXiatQ+J44Oyp3nk2xPQis0O7QGx46RD
         hWY9aYIoRAGUhsAgV+Y+2JE+78H7HhcfIMGgnWnDrnfGfFvfADj5TUIrhyj1sryf+AZp
         oDh1XVmN2pHivUTd2IQmkQ7VBT+fqbqT0R2x8ArNsdKXAuR3tre+giSVfd0GfrDFXLrs
         WXVA==
X-Forwarded-Encrypted: i=1; AJvYcCWU3ywJIz9ILpIBtWltBLf6C8bI8S4ggzzl/kstPv5sHBQQ5GCR9NEoLx17ltTW9oIfKm7JiE663xMHB7C8KS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmWRdUS1INsE9tYvZlyioLF/PzGoeUr2pD0ld+PxD28W39o25
	2sLxVbkqyxa4lYRmeYOX379lDzJ+bkwjDhZyJQAxuuVB6JqUEm68tKaL
X-Gm-Gg: ASbGncs+w2DGe0Fk6NWCnm3XPpH2Q30NlPYeMJ9HG2C0ptONL+iGg6eTd/4mkRLT3IV
	87fyhY/1/KgMLfMt5DcAIayNGEXzuDxmIaOoTx1Ckw8C+pRaViLnq+YpLQxdj36i2g5TxJO80AV
	fp1nUI8EViMLSaxRIF3/Zr+IXlWpOtzrQTJMYUOUWsujVfSXKpkh/zReLbzwhDYhuC+bOKxcm3y
	tURLdu2NNPR1nvIOn49KP3Xa2BYoKhyMukmzDgu9/cGe12loykzluwo/Ont235DQMevSmNx1Sqb
	S51DIlHDv+yZoM8LSgezYCpIiqBULMQIbgZUagDGIWb8Sez7pYiNppgfO90JaZ3KEdbLUltDwCM
	+zfY0PrRwl7L/dB0ZH//gdA==
X-Google-Smtp-Source: AGHT+IGNPgYSSilVDXgxVSvy8qJLCu98LlVfchHGGyPLn3Ewhul8liV+EqV4FB/CaTr5k6cwtqMAsg==
X-Received: by 2002:a05:6402:ca8:b0:60c:62ec:670b with SMTP id 4fb4d7f45d1cf-611e84ae864mr9391615a12.23.1752504169607;
        Mon, 14 Jul 2025 07:42:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9524072sm6212711a12.20.2025.07.14.07.42.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jul 2025 07:42:49 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:42:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, riel@surriel.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC Patch 2/2] selftests/mm: assert rmap behave as expected
Message-ID: <20250714144248.54d4rhboeq2wn6x4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
 <20250604082145.13800-3-richard.weiyang@gmail.com>
 <20250604083441.hilkdzlxmxygivvt@master>
 <2ee1d2ca-94c5-4c27-b2dc-bcea2b710dcf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee1d2ca-94c5-4c27-b2dc-bcea2b710dcf@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jul 11, 2025 at 05:39:39PM +0200, David Hildenbrand wrote:
>On 04.06.25 10:34, Wei Yang wrote:
>> On Wed, Jun 04, 2025 at 08:21:45AM +0000, Wei Yang wrote:
>> [...]
>> > +int try_to_move_page(char *region)
>> > +{
>> > +	int ret;
>> > +	int node;
>> > +	int status = 0;
>> > +
>> > +	ksft_print_msg("worker %d move_pages of content: %.15s\n", getpid(), region);
>> 
>> One thing confused me here.
>> 
>> If I don't access region here, the following move_pages() would report
>> -ENOENT occationally. The reason is do_pages_stat_array() ->
>> folio_walk_start() returns NULL.
>
>Right, the pages were not faulted in. The man page mentions that as
>
>"-ENOENT: The page is not present."
>

Thanks I see the man page, but from the code point of view, I don't follow it.

The move_pages() return -ENOENT in a child process, and the child duplicate it
memory space during fork().

dup_mmap()
    for_each_vma()
        copy_page_range()
	...
            copy_pte_range() -> copy_present_ptes()
                __copy_present_ptes()
                    set_ptes()

Even we map the range by MAP_SHARED, we don't need to wrprotect it. 
But we still set_ptes() in the child process page table.


So it looks the child has prepared the page table and not need to fault in to
setup it.

Do I miss something?

>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

