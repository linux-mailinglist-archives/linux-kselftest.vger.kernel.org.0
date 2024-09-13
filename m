Return-Path: <linux-kselftest+bounces-17907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C701B9776BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D761C24366
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58821D12F7;
	Fri, 13 Sep 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z33D3HKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C21CEE97;
	Fri, 13 Sep 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193288; cv=none; b=gYoBPQO1WpML9aULvo2PoUzNYyx9GQhOXBvDgT6V2Lg44U6A3BDArnGvp1eC/g5qJ1m/oWnnMtpFqKe47mQcNt3Q9HuJNxjshE9GG7GzxMAc3YjPdNMau2ppggAF59F4Gvln7koyI2wpP6p8T8/JM2ZCk4RTILZXkE8cws+CMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193288; c=relaxed/simple;
	bh=9eu43g3M8wipEXOkNZjpouW9lCogA3u6Xl1D1un49kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQM7sn0sYhoYF+oOuC4yWuu5vXcXBY6Xt2zl4qYnTciXO8Rjoee7wpikTUv4dV+Nu20nRrj5CIMT2ZoTXcFndw6YcT4Uo2rzSkYBf3L9SBywQwinVSMSaQigxHRcurYCdroRArXz+D3IGXELgeh5IDWTcd1T8q3HFfPP+eQHrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z33D3HKo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e049185cfeso146997b6e.1;
        Thu, 12 Sep 2024 19:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726193285; x=1726798085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7cimPnDbBKYHrFkLn6Bf+Cga62onzQ+Q3eQb/Boxbw=;
        b=Z33D3HKovCtknm0H10JwzQdlDEMekOnUySEqtlqVMbmXO0U9zaSisEXzxmKFpAMXa8
         hWJTzVyI2Hc4fcQfZei8gljV54Vsqz7TEqW5KSgjqmZkyTQ2nVyWPGvm0qSAJgT7Lsmf
         P8djyzZkDYtsrf5JWUqoDbRCcSqwWQg07L1zodJ6QZY3y3ZOJd5hqVfs1/TLwmBUrHiO
         j2yKgwoy7nzB49EFWUD7sAy6orjMd/kfYEb9F2CFa4n9HzTrGXnVIU6BsFo4nq5Ck7Y8
         1GZExlLF32boIRRRl1btvjLpBpjov/00XxdbQuIozxlMP7B9LhBM+I62horW7e1O5kUt
         E8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726193285; x=1726798085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7cimPnDbBKYHrFkLn6Bf+Cga62onzQ+Q3eQb/Boxbw=;
        b=CtoardTfwI+pg3YtzDDTouUxSOCBSqQ5KetMT+TW/ndJRUpFlZdRkXyitoEnKw8Hj+
         95DQjyj5QJSYTOjQCVTMuZ4eCWBY1/750no8ZfLslPiXzEdChzDgCES2ntyCXbDHttBY
         NGsibPdwKxKD6sqie5izbrWuvMWTPrzUVELgPzb1302bhI3eqTsQBVSOX4OFZBWnRfFa
         +CYquS7vvKXVIB2SD3XqGfJKSGz15xr1N489dHJL/uSMXxlAfOx4AeyXJV9VqF1Jt6UO
         w1a/X2KdzIjd6pz168dejgUo35IZpJpERk7P/NKPlzZ/tCJWpFSrHcbU+8lJ7tIcX4L9
         +scQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8rTmcSKOPXsxXSEVV9Phz0NZO7DBW6OKLqiGh3q/6hhlxrYFZQMLdoIKAe/8bA2dFQ1d1WsT3B6h/b/0=@vger.kernel.org, AJvYcCVjbrlUi9kJHWASLqTW+Akg2nJv6YWzzp9tTMppxlNpqQzPTPIyhdosQADrVus6OtTuhZG3fH8gQHzHN0W9Fy2a@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHFYjKHPQjD8GCtqImJJGPw2RpO77loMNfOGORd7O+YFSANqJ
	XeNMqm/TDNh9U0RsPLmQiUthrxSCzsiwAArY1ZaAkaQTVVt0FWysjyOLSYBE1m46LqI5rQRnosO
	ldANgPEPF3eHwmeoO+nbboAZVLsw=
X-Google-Smtp-Source: AGHT+IHggupOHNWQQGi87kpgjxoBFmwiJyJeCdJM1Ufdym7+4NlW81mIMtLq1f/ocpWT1XwYREsvFBgQ5gHmWI0LRtQ=
X-Received: by 2002:a05:6808:14cf:b0:3dd:cc7:957c with SMTP id
 5614622812f47-3e07a0eee2bmr659522b6e.8.1726193284860; Thu, 12 Sep 2024
 19:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912100018.736447-1-zhangchunyan@iscas.ac.cn> <ZuNTWCsPPLTm1zdX@ghost>
In-Reply-To: <ZuNTWCsPPLTm1zdX@ghost>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 13 Sep 2024 10:07:28 +0800
Message-ID: <CAAfSe-sfv2n85-XtYBqegCH+n=XR1KN+v6oJu+5d0_y_z9toTQ@mail.gmail.com>
Subject: Re: [PATCH] selftest/mm: Do not use hint for riscv mmap
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 04:47, Charlie Jenkins <charlie@rivosinc.com> wrote:
>
> On Thu, Sep 12, 2024 at 06:00:18PM +0800, Chunyan Zhang wrote:
> > When the virtual address range selftest is run on RISC-V platforms,
> > it is observed that using the hint address when calling mmap cannot
> > get the address in the range of that validate_addr() checks, also
> > that will cause '/proc/self/maps' have gaps larger than MAP_CHUNK_SIZE.
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >  tools/testing/selftests/mm/virtual_address_range.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > index 4e4c1e311247..25f3eb304999 100644
> > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > @@ -64,6 +64,14 @@
> >  #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
> >  #endif
> >
> > +#if defined(__riscv) && (__riscv_xlen == 64)
> > +static char *hind_addr(void)
>
> This is not a typo by you since this is the name of the original
> function but this should be "hint_addr" right?

Right, didn't notice this typo, let me fix it.

>
> > +{
> > +     return NULL;
> > +}
> > +
> > +static void validate_addr(char *ptr, int high_addr) { }
> > +#else
>
> This is something that I am trying to solve over at
> https://lore.kernel.org/lkml/20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com/
> (the solution is still in flux). Since riscv doesn't currently have this
> behavior of restricting the virtual address space, I think it is more
> reasonable to disable this test entirely. After we have a longer-term
> solution with the patch I have up we can adjust the test and re-enable
> it. What do you think?

That also makes sense, I will send another patch to do that.

Thanks,
Chunyan

>
> - Charlie
>
> >  static char *hind_addr(void)
> >  {
> >       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> > @@ -81,6 +89,7 @@ static void validate_addr(char *ptr, int high_addr)
> >       if (addr > HIGH_ADDR_MARK)
> >               ksft_exit_fail_msg("Bad address %lx\n", addr);
> >  }
> > +#endif
> >
> >  static int validate_lower_address_hint(void)
> >  {
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

