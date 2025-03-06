Return-Path: <linux-kselftest+bounces-28387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B9A5468B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8E13B15A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C2E209F4E;
	Thu,  6 Mar 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M5TqjAZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B420969D
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253919; cv=none; b=iEQJYdtiajM11Cp10yvLA3gKjm8xiLZNY7po+9WlTYOLMMRkDT/L/aZxM3X0nPNsz8mJNqxFEsGr3GzdZiFBbkVYdWjG6vnvJWJpA8BlD1chdhWRZzyDd20pqqbe1ymIhCLiQoTcbTggD8Va/v0RvWlSMFFaBya7qIeErt8SAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253919; c=relaxed/simple;
	bh=QRxYtULG3gOZzTU+e59fvPCAV7jDKkmzMdnB662pk30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPsZkgPyFGgUTLmnuzmQtPX4oJ/SI0OpNY2n7X1FxrNT5AMwFIXPBsYXCl5TO3NDLK7wjmhiBJ2+ajIH5rE3SJdKm37MOzPBcaSMgaYsDPvM0icpJmltNumqAs5/hilaYLAK3y5FoCBYmURaKSLgWN7WgBoueDSQh/EQNB3mOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M5TqjAZM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so3565335e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 01:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741253915; x=1741858715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wpzq/njrY6l758uuXjkU5Yg1HQdxYKPq878SD5ejP+g=;
        b=M5TqjAZMn2MDPTS2NGj3BTbOkze8ZILd9knkxIGPgFn+PhfnavBv9ZMwnf0voMHm/3
         lH0RSiDXIqMGUg9XjOnzgoaDcJuOUmlL0iT/p190tUBRdRfKnD9kh4IIiNJL31QqW5qc
         EoCCYtTeYE8kobW1iLagEi5Z5/1CTKFIdNdGKTHQyDlrPKKOAZ6PTwF2lp/WSf7vjDfO
         X4AZREQzlEM79wgvgzBAgFzs0rfb5C7jFUj4W0uQ1N34yD0ycq4hMycWQZs1fnN88ueV
         iJEwxVAkgkWyGfRWQQBaRuxu+9Qjmm5RqLVE/IpefHomXBpriviwLCqGyLnjLz7IGxSA
         zuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253915; x=1741858715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpzq/njrY6l758uuXjkU5Yg1HQdxYKPq878SD5ejP+g=;
        b=r7CMHxygqv1w7dnzXPBHUDP5DYoXh5g2VybJ9AbW2w1futWYKR8xkXjvvojxH1ppLx
         WqgLuI4mr1Kf75Nl93fOjj/bS6EX+gM0wKxGEwlI2awBX+g3b611KNYCoGbJ5VaOG2xz
         7GJC78FKXFYNLnkVWJuBY7mUBDdC5QMtdjFYHGSkt7DJG9OKiWYP9Tgq1owO0/M9XitT
         yUNVTABup6a/O4LUue8aAoDn4tK1sWiCNgl+33AFCI/Eu4YxKLsDej3Dy42duu53h1G0
         LbkL2+XKVE/p75LMefmPlkYj1Bzf/lGnR7ylDUJk68aqM4LCoBpyPvRO7VU1IllflNap
         Sgug==
X-Forwarded-Encrypted: i=1; AJvYcCWwaeeahdElRVRrGMVjdaVzKWdhr7F4isCXIzF5XhaPjajCkDQLMp5tQxtBXiP/pKzuwrOLwj4OAtL6HVtEU28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCTeIpo4YpJbpE0XE6aegakt/cgQZg1oDXX/AUDBAZR8andnt
	s8VVV1Hbb1LgY2v651M8+yPFpI6Sv5yIXA8bRJYVM1lUZsDyYYD98aIOwpHuYU8=
X-Gm-Gg: ASbGncumSkUBwlvqjqi3NO3u7UliBGxuwL3lz3XvNK/qeIVKzK3chXEksDrzepKwtNT
	pHRZYw9XgEVadqODtj/zWUZ2F/q+RRO1HHfuuUC9gIs6Etx4eLRLvvWwem+ay0otEGlX8V8COV/
	vmz8UWPM/YbwZbijhcWCVPFTI/uJeVISM02j+G3MuHtf23nyUAXdeFa82B1e14RrhKz8Fc6vmss
	MuPWQcoUTqzmksUg0EAS2HP+6UJ1qHS6QgB2gWInSUzohGe3khIRjGjZ/uLXPFj5hdUTJaiuu1+
	hEMgxaYSQMTmKfMlk0s+vdiR9NM57Ke7laE30LpfRA3v6fs=
X-Google-Smtp-Source: AGHT+IHFSps8QHofBQVEj8kAVEUhy1LU39PEl0Eivc++Qzt0gHMDxzgZsRqrnZ16eKWtWOaX2mAIaw==
X-Received: by 2002:a05:600c:474b:b0:439:967b:46fc with SMTP id 5b1f17b1804b1-43bd295853emr47566885e9.8.1741253914734;
        Thu, 06 Mar 2025 01:38:34 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93c9b6sm14167405e9.29.2025.03.06.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:38:34 -0800 (PST)
Date: Thu, 6 Mar 2025 10:38:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
Message-ID: <Z8ltGEp7NmhTwPRW@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
 <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
 <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com>
 <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>

On Wed 2025-03-05 10:57:47, Tamir Duberstein wrote:
> On Wed, Mar 5, 2025 at 10:55 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> > > On Wed, Mar 5, 2025 at 10:01 AM Petr Mladek <pmladek@suse.com> wrote:
> > > > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
> >
> > ...
> >
> > > > >  #include <kunit/test.h>
> > > > > -#include <linux/bitops.h>
> > > > > -#include <linux/kernel.h>
> > > > >  #include <linux/module.h>
> > > > > -#include <linux/overflow.h>
> > > > > -#include <linux/printk.h>
> > > > >  #include <linux/prandom.h>
> > > > >  #include <linux/slab.h>
> > > > > -#include <linux/string.h>
> > > > > +#include <linux/sprintf.h>
> > > > >
> > > > >  #define BUF_SIZE 1024
> > > >
> > > > It would make more sense to do this clean up in the 3rd patch
> > > > where some code was replaced by the kunit macros.
> > > >
> > > > I would personally prefer to keep the explicit includes when the
> > > > related API is still used. It helps to optimize nested includes
> > > > in the header files which helps to speedup build. AFAIK, there
> > > > are people working in this optimization and they might need
> > > > to revert this change.
> > >
> > > Yeah, I don't feel strongly. I'll just restore all the includes.
> >
> > It will be blind approach. Please, try to look at them closely and include what
> > you use (IWYU principle). I don't think anybody uses kernel.h here, for
> > example.
> >
> I think I'm getting conflicting instructions here. IWYU is indeed what
> I did: bitops, kernel, overflow, printk are all unused;

I believe that the headers were added for a reason. And this patchset
keeps most of the code. This is why the change look suspicious.
And I see in the patched lib/tests/scanf_kunit.c:

  + hweight32(), BITS_PER_TYPE(), BITS_PER_LONG which looks like bitops stuff
  + is_signed_type(), type_min(), type_max() from overflow.h

So, I would keep bitops.h and overflow.h.

The printk() calls were obviously removed in the 3rd patch so printk.h
include should be removed there.

I do not see any obvious reason for kernel.h, so I would remove it
in a separate patch.

>  string is used only for sprintf, so I made that replacement.

Makes sense. But please do this in a separate patch with this
explanation. It might be done together with the kernel.h removal.

Best Regards,
Petr

