Return-Path: <linux-kselftest+bounces-3266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44928833248
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654B91C21261
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 01:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140E7FC;
	Sat, 20 Jan 2024 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UCp7uzu2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9D10E1
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Jan 2024 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714476; cv=none; b=VSfP4oYzIFR/vY9f0BolotoldfXIaavKfW3kQXxjjf2BNaM0leiAg7+7Ap41g5c2MvXYayYDLbNMlymuihqO+iTbbVwG5QlELg0DJtx2bS78YaW+201yCeA3J0q7iLX+iDqYYOUtOKuRF//ZIjtLDVYgJ5fOZo+1nrwGShS/U64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714476; c=relaxed/simple;
	bh=26huEc5Mwf9rHtDTIB9WAm8Uc/lRlNkBs+RET7bxIJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIoPp5oi/LZ4FykqKc27DseWqL7DTajR5ZD+L34Ym4F82xFt8zXhMEUr9VKZ+qJ3opWYoO2rszs2zygC9AFKKpgPKauoC5tx8PH1jo1G3j3gzRtTJVkKfdyk6Nr0+4KOTb7VNOkjzO21J0UrQL4OX7GyDUDH1hGY7FUR2je97Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UCp7uzu2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9bbf71bc8so1028137b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 17:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705714474; x=1706319274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ESr1s1LQuOTutaWHm69OFuVr1y+EY8ccPvGNNNRU7c=;
        b=UCp7uzu2SrCb+R9eaVctu2pPOqoDuEKPKwXpHR7XkhnHNkbRA3W+8E6RQb/J23CxWC
         RAL5FkWrxUT1EU6Djq4IiFvT/uWQg2s15zio4t8pyN7OSoPkW/oO5oSh0158ilgdUh6N
         dMd+oRMs9CqL8nlJGoi9JzSJCCTTaB7K9TztSsFvt0IkQVObSLRTkXrcLIB+YEbLuJ+t
         JZoKjWH1T3vPRP30Tt+he4KvTS4SnuoqpZoqH+8IuwN5izgYWB89ubnxoGXAw6NkdDiE
         mlVnBFYjOfqws2vOOy3XIE7c3faHIV7OIxavzWvRuROh9EPdL7BZO2vr1VM0d0XDYhyF
         ++jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705714474; x=1706319274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ESr1s1LQuOTutaWHm69OFuVr1y+EY8ccPvGNNNRU7c=;
        b=F/Vo76BLuqEgQstcYGp0Uj+3OYV2vDaXUklXkbDnj7//hEUI4ydFZtrrI5EAlnqgMc
         IAac5dDH9kLsA+jXG3ppBz6TBkwM7S5K5h62tDKVW68t3IJN5I5lLs7h8ocCCMyDEaZy
         BjnY6ZYXlsPSs70rd8TuLGz2wpy4O+qOsUMAq99cHYHUFSX5X+MzwJsSvkDiDq0z+hCR
         xCIc3DkLk/js46D5qWlaI6Mm9d1co264aYxHhi8SXv5icfho1rC20OacEXUaj1kT7baD
         AoalUMPWqJHaaTuR8N9oqtlNhq8QMVubIU2CdFctRADBOouxAQsTD2imfX6I9+1c5Wh+
         sXaQ==
X-Gm-Message-State: AOJu0YwIC2RG0Gkp25UuUxw5XGV2HYC6edPrhsVm4BDLVwY7FUOcNzz8
	5oBNV0OQOROWIXZyaUXo8hM4Ca7k5YJfI0oEcSHGuIOjsmCYHXS7YzvjPCmtqoY=
X-Google-Smtp-Source: AGHT+IFpTaljaK+IhzjIUgqr3GVQ3I9VycDOb1FWOAfJMZG3m5Pa9z8B24GyjvedFp0KN3e6hXYsKA==
X-Received: by 2002:a05:6a21:185:b0:19a:6830:2334 with SMTP id le5-20020a056a21018500b0019a68302334mr757399pzb.46.1705714474654;
        Fri, 19 Jan 2024 17:34:34 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id r9-20020a170903410900b001d71c89fb32sm1961666pld.269.2024.01.19.17.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:34:34 -0800 (PST)
Date: Fri, 19 Jan 2024 17:34:31 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: alexghiti@rivosinc.com, anup@brainfault.org, aou@eecs.berkeley.edu,
	conor@kernel.org, jrtc27@jrtc27.com, konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, mick@ics.forth.gr,
	palmer@rivosinc.com, paul.walmsley@sifive.com,
	rdunlap@infradead.org
Subject: Re: [PATCH v10 0/4] RISC-V: mm: Make SV48 the default address space
Message-ID: <ZasjJ3HPUVuxr2oG@ghost>
References: <20230809232218.849726-1-charlie@rivosinc.com>
 <tencent_F9568C6D8872E30EDFAF20ADF686A31D6E06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F9568C6D8872E30EDFAF20ADF686A31D6E06@qq.com>

On Sun, Jan 14, 2024 at 01:26:57AM +0800, Yangyu Chen wrote:
> Hi, Charlie
> 
> Although this patchset has been merged I still have some questions about
> this patchset. Because it breaks regular mmap if address >= 38 bits on
> sv48 / sv57 capable systems like qemu. For example, If a userspace program
> wants to mmap an anonymous page to addr=(1<<45) on an sv48 capable system,
> it will fail and kernel will mmaped to another sv39 address since it does

Thank you for raising this concern. To make sure I am understanding
correctly, you are passing a hint address of (1<<45) and expecting mmap
to return 1<<45 and if it returns a different address you are describing
mmap as failing? If you want an address that is in the sv48 space you
can pass in an address that is greater than 1<<47.

> not meet the requirement to use sv48 as you wrote:
> 
> >	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> >		mmap_end = VA_USER_SV48;			\
> >	else							\
> >		mmap_end = VA_USER_SV39;			\
> 
> Then, How can a userspace program create a mmap with a hint if the address
> >= (1<<38) after your patch without MAP_FIXED? The only way to do this is
> to pass a hint >= (1<<47) on mmap syscall then kernel will return a random
> address in sv48 address space but the hint address gets lost. I think this

In order to force mmap to return the address provided you must use
MAP_FIXED. Otherwise, the address is a "hint" and has no guarantees. The
hint address on riscv is used to mean "don't give me an address that
uses more bits than this". This behavior is not unique to riscv, arm64
and powerpc use a similar scheme. In arch/arm64/include/asm/processor.h
there is the following code:

#define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
					base)

arm64/powerpc are only concerned with a single boundary so the code is simpler.

> violate the principle of mmap syscall as kernel should take the hint and
> attempt to create the mapping there.

Although the man page for mmap does say "on Linux, the kernel will pick
a nearby page boundary" it is still a hint address so there is no strict
requirement (and the precedent has already been set by arm64/powerpc).

> 
> I don't think patching in this way is right. However, if we only revert
> this patch, some programs relying on mmap to return address with effective
> bits <= 48 will still be an issue and it might expand to other ISAs if
> they implement larger virtual address space like RISC-V sv57. A better way
> to solve this might be adding a MAP_48BIT flag to mmap like MAP_32BIT has
> been introduced for decades.
> 
> Thanks,
> Yangyu Chen
> 

- Charlie


