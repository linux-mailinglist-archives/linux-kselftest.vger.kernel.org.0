Return-Path: <linux-kselftest+bounces-26153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CF8A2E5D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 08:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27505162723
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B11ADC93;
	Mon, 10 Feb 2025 07:54:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797E2F2A;
	Mon, 10 Feb 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174073; cv=none; b=MK07+ISUru3TssuEaAOKciRm6ljd6lKaBBADq43pB3RjYrhREsJAw+pEJ6LrjvAk9Ski8IVJjfU1ktmNBQF0CSIrqS17qidXelnrb2gkycS8Xrm5psT5smJpqTlUfApdnaJ3JcSv1vYqJvzM6zVQOIu3GgegiX9N6+PazkTnG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174073; c=relaxed/simple;
	bh=zGzqUTrmQ524+OgAqr4VcU42+3jZ2qDqqvvZ3J3P0v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbJPeRNF9QQxby+tTFjsEm6jj/2yvLzUNLoclBSJNj8iPL/QvxCE/M3sq8q/Ng4IdlDwhWhbXkS2ilP3QuhWMSEiczMn+k5JyuMBgIb1AX9gTDoN/uYvAOlL2mRmEF+UQeT8+JOlMc5j1Z1Lw6wiO5rhFvPw35DrkLFgZAknhr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-867082baa8eso714284241.1;
        Sun, 09 Feb 2025 23:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739174070; x=1739778870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QVuU+Pj4WW7p8VfYDhUhfStFdnghuMaJHmBwZ02Z5o=;
        b=O/gQnRTAKW6PuDNzFg95Yn9r+fWIcCS6FhKxK6XiRUkyFYO1PwPbMAlhwoys0Oyws5
         9RZy71D5oV0Nbvcdm7d/xbSLV2EkpgN4V/5aVDhpu5+Gq/myaeljWVsBVBJLBeECfXXw
         B1GdQi7+jwcm5ijihav39kmCCOHs7r/pkoGh8GtRWnbKeFR1ej3j78qxck9dxwrAFFa7
         IMHki5HDOK5OgmoWX5yFq6Aezag6Wr6EnZS73r73w5C5V2/xzOCKFo6fqI5NkrxSbLfM
         8BuLqXR0CWkE1CBZYU4YVTDNkAFr3zsZkimuNxJKepILpce1924cAZlolOCbB0YTTBHt
         qmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTsdv/QwWW48ujdbmZa8Jh0APNE9fZ4al3/snxYZQ1AGjFNAwL8M84GTLDQP2FGnfDJJE3Y2s0GFWHm4E=@vger.kernel.org, AJvYcCWh5iFOKTv8kJo9NCQGjhkYXJIB5+EgsweH8UUX6z1XgqshEg8hQ7pmtwPSLeHyfgj0IzkwZg8QO0zxAivAFfWS@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYaoatYau7smf0BGe+FSuMtM+3UMv3QMSIzeu4DOUoAItAzAl
	YtoF9OVs/+FeudwUMtDlT+zIj4m790EPk7xkByIHptjV+2ut7NAl+Cju+yM8
X-Gm-Gg: ASbGncujUIe8jHkXkxVWt5P/Bh/lL9ZnKV+VHM/RJwFswhVptJPgwKNqtqNKq5gjasL
	Ti/14d+vqAVd753SQ9YnMoEcSwYr1n3W0PSfXq04Rc3sbyn1Lh2VhB7MghvVZbVotPLikZ+npYu
	CsLGa9mfZtuXwgAQD5ZQlbIXkziZY0QwBf44VNyI19RqC37s9EfvIoUNAct10YzCxFlEMQUkOXa
	6F7NutxrXbc8R9JFL1iVsnmnWp1Lrd+Tz7ycNGkkcYKsysyvmx+Vvt3WLZv56zKTjgiHbkMn0v1
	DTYBSxjUrmMuqOPsoppe/WyYaAvBaGEkBRQNj2Pd9Lw9lLrRfagj+Q==
X-Google-Smtp-Source: AGHT+IGjuVcvT014ehZgGSfSHcd+XVV36feIbwzJLyY58DY6zuXf2LZT8MgiKhibr7rtKkhYugZxRA==
X-Received: by 2002:a05:6102:372:b0:4ba:971a:41fd with SMTP id ada2fe7eead31-4ba971a441amr5252028137.19.1739174070075;
        Sun, 09 Feb 2025 23:54:30 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bbc78d2675sm358103137.29.2025.02.09.23.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 23:54:29 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86715793b1fso510141241.0;
        Sun, 09 Feb 2025 23:54:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeajdMWKldA8YkZgO3VhNmbGs3P3w9KwnVDfXOWy7yGFboSMcZLcRcWLCO42i54IFZpPb63S1D4ZvYURU=@vger.kernel.org, AJvYcCVv2fyK4L9gocrZ2F9wiZJIEvI6BwdAilUO48jNSi9z2S/nINHpwq0+4MYUT4muXEXwI7gcrkthyKiF6Rmr7/uP@vger.kernel.org
X-Received: by 2002:a05:6102:41a0:b0:4ba:7b06:7e68 with SMTP id
 ada2fe7eead31-4ba85f54226mr8216593137.23.1739174069469; Sun, 09 Feb 2025
 23:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com> <Z6eaDuXnT_rjVSNS@thinkpad>
In-Reply-To: <Z6eaDuXnT_rjVSNS@thinkpad>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2025 08:54:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
X-Gm-Features: AWEUYZm5Xr2vD3ubUCPEj8UL7Ai7XR-3LWBLYpLEYOvMDEsJZO3nw3gZxZYFUGk
Message-ID: <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
Subject: Re: [PATCH 0/3] bitmap: convert self-test to KUnit
To: Yury Norov <yury.norov@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yuri,

On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
> > On 7/27/24 12:35 AM, Shuah Khan wrote:
> > > Please make sure you aren't taking away the ability to run these tests during
> > > boot.
> > >
> > > It doesn't make sense to convert every single test especially when it
> > > is intended to be run during boot without dependencies - not as a kunit test
> > > but a regression test during boot.
> > >
> > > bitmap is one example - pay attention to the config help test - bitmap
> > > one clearly states it runs regression testing during boot. Any test that
> > > says that isn't a candidate for conversion.
> > >
> > > I am going to nack any such conversions.
> >
> > The crux of the argument seems to be that the config help text is taken
> > to describe the author's intent with the fragment "at boot". I think

IMO, "at boot" is a misnomer, as most tests can be either builtin
or modular.

> KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
> on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to

I think distros should start setting CONFIG_KUNIT=m.

> boot-test bitmaps. Even worse, I'll be unable to build the standalone
> test from sources as a module and load it later.

If you could build the standalone test from sources as a module,
surely you can build the converted standalone test and KUNIT itself as
modules, and load both of them later?

> Or I misunderstand it, and there's a way to build some particular KUNIT
> test without enabling KUNIT in config and/or re-compiling the whole kernel?
> Please teach me, if so
>
> Unless you give me a way to build and run the test in true
> production environment, I'm not going with KUNITs. Sorry.

FTR, this is why I've been advocating for making all tests modular, and
for not letting any test select (possibly unwanted) extra functionality.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

