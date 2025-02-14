Return-Path: <linux-kselftest+bounces-26690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28592A367CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C90D18938AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE61DACA1;
	Fri, 14 Feb 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iacj/Ej8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7121C861A;
	Fri, 14 Feb 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569943; cv=none; b=eY3ZVzThk5lnJ1lJE6QoGeirHEEjhMwvjcARCuC75DQXNwj7qe9IRcqKBZFZ7vlUIGd/IbeaXlMS39tcgvbG0jy+7hYuoEIwQ6pMHVfKE9vgcuovvQkK34Rv1dBAQPrAyTGzTyWVGAEBrh6ZZiyeXaph4soOyiAF8JrAgtC+UHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569943; c=relaxed/simple;
	bh=/KKHLAaMFAEPJleSikTB6lnzt8UjdnvqiBRPZj74hNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrpMd7CjmS7O9muZixpkBmx42v2syDbbBas54+i5O9h3r+qMjaaiCBdqJtJEx3v8+n/k4E9S3ChDiBDB45QqWzc3OgeB/jm07WmCILlzwv6JEXxdKrThg7zdaZgyb0hLD95Qc45gAZZBi/OH+vO+4k0zP0vD5SVk13MJFCU65kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iacj/Ej8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso26197531fa.1;
        Fri, 14 Feb 2025 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739569940; x=1740174740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRqlyd6oGO0KdHznSNNqTI/AEXRx3zHfr08E+Px4USU=;
        b=iacj/Ej868u+bqloWORuC1SwfrqJdp1CikMl/XuTF3rIkt5pKinDfNgiXnN1zqtLly
         Vyoqtt4KaLdCpDa+6jbIWNZcmLEn9nDplijl/6hqUvr7Ud67LIZl9VTuR8+XrwnHaANu
         wnf+pPa4xLE1gRuDst/Nby3B32L8/haHqMX+Aw3ydL/94vmxlvPqMgrUsGIZAn49C2JA
         iEnmL2HWcmFx4mlyumAKpfCk/WZDlc9Vff/FZrIbRU93KIy7eLUF90knIwPIedIsNDIV
         LCnzNT6fMWPE1I1mTeOTCUo5mGuLXe+GZL/LCQULBGN9g43WJcHrUD50jZ81aiEmOL/9
         jmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569940; x=1740174740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRqlyd6oGO0KdHznSNNqTI/AEXRx3zHfr08E+Px4USU=;
        b=sjVsWcLT31zmTpmUzSZpNAyJNQAWapXuUHK0jARZfSjKkk/6kJyyaNs6fdWH6rY7/t
         7bFSaxmXONHimNbR2m61wUYd5XhhM7tDDLr1CcPV0Sldnz45pWYDl7k7j0ER9N+HPQx5
         hyik4NGByourGyQK9cAgP1rFHtQZ7BzdJ+NUVjmXi9OVNs/w9NbsS4wuSwdXakWc8uYU
         oS5pEvbRrpPrDjekUWqXCExa347Iv629iVN8p4EV7SrZo/PRNhBzbwZsasEGW/YW7eCn
         CPRvBkNo1AYeBC7qd9DANWi9sF2U5UxKYM/cT8Ad/jF3ZnePjnNn9gLradsbRZk/cxGe
         QtIA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Aep9+ILPQTK2kyM/SHdrz33LIjeCT0+TU8dfcRyIypXF8uP0rPmwYcWPSqtv5zXUVwDvz9YGDlQ=@vger.kernel.org, AJvYcCWCc+yDFSwUPbT/EgOY1P6Hm8Ecq08Ln0YwTn0quJ74Ycjstgj9uPbqk7BhRWS1MNqn9Cl5hoblmriFvW3W@vger.kernel.org, AJvYcCWl4nJsJcrGmS26nrgcUWZ+kFW1xdb7QZrDfcRrF5AjyIqCj2NWEB/bHeUA4kH/2VF6LVyYrMzxFJs5hQsNohEL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+mbT8p2uY1S/S9qmo/lZuCBG7Ps8lDOi6PXt4UP1Yg1vg+v9
	tXrx7Q1hYYiQT015Z9t5aDNqqQkl+4Tlnhxyr+4/1qL+/WFHp+KTD95yQfvu5x0EJn9SCFdY+jH
	Zv+pTiojRtz3EiA/g26+LRKWw6k8=
X-Gm-Gg: ASbGncsar62XaJiQvVEeWazT+Jy8fBFP+mUjO4raOwXrq/ct5Lsj6STfi6stueTN+Xe
	cCXowMoCgkPBjKVB8q83HJc/ehikML7xjH8SM9DvA6kbt4Sh+ZKfw5y7voUmzpkTm7JgDn/d0I+
	vyrPKTdqcont+fzF3u94yhz46PKsEWMGw=
X-Google-Smtp-Source: AGHT+IHSpHMu+d9yxfeM9fhEh2exQCFb02zAuHKSY+JxD0Uew6ExTEbIBTjpVBPP5XMmM53Pc3kzV0IcmY9YkC9NKA4=
X-Received: by 2002:a2e:95c4:0:b0:308:ee65:7f4e with SMTP id
 38308e7fff4ca-309279505ddmr4289291fa.0.1739569939469; Fri, 14 Feb 2025
 13:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
 <Z69isDf_6Vy8gGcS@pathway.suse.cz> <Z69oxhkUzTfJ6YKi@smile.fi.intel.com>
 <CAJ-ks9mck4DzX+WANxKSmcN=mP9ztgwWETXLmX_F-gy=EhmLNg@mail.gmail.com> <CAKwiHFjnY-c01rvkzNRz=h=L-AxRMyUtp2G0b17akF82tAOHQg@mail.gmail.com>
In-Reply-To: <CAKwiHFjnY-c01rvkzNRz=h=L-AxRMyUtp2G0b17akF82tAOHQg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 16:51:43 -0500
X-Gm-Features: AWEUYZlIzjGDNjdcMbGasiSVuX4TBnRVStLmaQbB724z7yxjnP4i1AoyHu0JSSg
Message-ID: <CAJ-ks9=T7JJ2W4+fDKeysQ9QOtquMHoGwYU3g8a-A2OJrgL9Sg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek <pmladek@suse.com>, 
	Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 4:47=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Fri, 14 Feb 2025 at 17:53, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 11:02=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 04:35:12PM +0100, Petr Mladek wrote:
>
> > > > I have just quickly tested this before leaving for a week.
> > > > And I am fine with the result.
> > >
>
> Thanks, Petr, for demonstrating how it looks in a failure case.
>
> > > Seems reasonable to me. But I want a consensus with Rasmus.
> >
> > I have a local v4 where I've added the same enhancement as the scanf
> > patches so that assertions log the line in the top-level test.
> >
> > I'll wait for Rasmus' reply before sending.
>
> I think all my concerns are addressed, with the lines printed in case
> of error telling what is wrong and not that memcmp() evaluating to 1
> instead of 0, and with the final free-form comment including that "ran
> 448 tests". If you feel that word is confusing when there's
> "obviously" only 28 "test" being done, feel free to change that to
> "did 448 checks" or "did 448 individual checks" any other better
> wording.
>
> Rasmus

Personally, I don't feel strongly about this wording, so I'm hewing
close to the original:

    ....
    ok 25 flags
    ok 26 errptr
    ok 27 fwnode_pointer
    ok 28 fourcc_pointer
    # printf: ran 448 tests
# printf: pass:28 fail:0 skip:0 total:28
# Totals: pass:28 fail:0 skip:0 total:28
ok 1 printf

I'll send v4 momentarily. Thanks, all!

