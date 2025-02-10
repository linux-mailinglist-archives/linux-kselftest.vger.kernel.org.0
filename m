Return-Path: <linux-kselftest+bounces-26193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E67A2F3B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 17:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63FD18847E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E701F4623;
	Mon, 10 Feb 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMxb1LJE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E92580D6;
	Mon, 10 Feb 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205376; cv=none; b=p31d9b3U4Eg+EBMkXjPhmZb/5IekV/XVuLIytWHFLA3WGExledkR1/BCQHW+2dh6678UDzSheurtZTrgQpyq2pc2kJEUJsBfGWSMC1AuSELXurLM3EQByeIxsFHYXiXV3alsKeQEfqU45IsKWFMT9G2bc+Vh3P3an7pHsqMliTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205376; c=relaxed/simple;
	bh=C5sIxuTthKF4f8I2Nio7HGGX+GwQOo4U8GC1aS9Pf2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnT+Xx7eXmeC0FK8xdMaNlPc9JwF3bFSJH+ma2UNHOVlRfkI7UFcIv0nxfhDb+ITrcEK1tTFGujkbZtikk4ErkMldeWddryakf6/zRV87+BkaIGlQO0JUHEoJKhb9nSCH1//U9pXc7Xc1+r04FUm5dQv4f/nzyxs4NJyOIkW/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMxb1LJE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30227c56b11so49148511fa.3;
        Mon, 10 Feb 2025 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739205373; x=1739810173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5sIxuTthKF4f8I2Nio7HGGX+GwQOo4U8GC1aS9Pf2c=;
        b=nMxb1LJEVbmHLMMR3v5xpkZrBQci2kH+CNBkq9aL9WpF5OVOC1kWWY1QGW7AJOa3ZD
         wacH3r5DmIyRjz5iyqWe36kETSnvsTNXlTVStzr44t/Mr9Mt4rfjiMk/8TaFC0vR5FKD
         EUg2Of9KS0KJ+sOVkL6RKyp4Z/Mcwv5Z0rxOCrC8bDkKrznGguMWrbtSmgkHrJK9xfcG
         Mm8VadsULqou913AP4MxrtaQ3AKuqCm9aFUKoRNoJ//6N6wSeMf2/gc9iaxknqOTO0i1
         VuscF/8fffbpfdlVt38vM4cYilG9vTPYAh4gjkuf6N0+TpfveBJIEqv4LWaDA64iLSEG
         EFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205373; x=1739810173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5sIxuTthKF4f8I2Nio7HGGX+GwQOo4U8GC1aS9Pf2c=;
        b=BHZr4t3lLBvChJeKYSIDCbBwTawyJxjLMntzqH29/eBvz1TCCa7cUmfzUfTzrNRhyA
         JUm8w4HRgD6CmsGIYU5EwwBqnlcq+oQplikgO7fU0iJvwCKpcr29am9ADdl9FmJxf279
         vlfIwWu3LcbQaFDUqv08KJuDGxadkIrYyv+cp2P5gaXh4pDmWff9+g3BsVt1x7gzUR9p
         Aw4C5MCOXlEG1Y+mJ0O7aRV5QRoGvT7jOkQMGpXVOqoOU12bfVQ+DSXcBATV5pwgAMD6
         ZFM3nyw7G5AFZp1IltLz6uZwduRjKTsmQI9eSr7CMn2NYUbVJyGdMtBkKORnDz8L4HUU
         2jKA==
X-Forwarded-Encrypted: i=1; AJvYcCWyHbYi6voAbPEVXom+uY0LPpQxuBONXBDgjy/ZaLUKeH+BTblYUiQSWcKMsVSG1J7fBcAoc23Ka04Hi4L1jp2g@vger.kernel.org, AJvYcCX/OJAEIah0X7uIDAWy7giFxXMn4YOEzyANKTNTJiAAXHz/07zjeFphjK7ipNKLaCfSqdfdq1hT8EtTb8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlhs5J98uM5091pDqSeHTdC07P1Q+1ApmR0ZZCkC7sa7s3irMu
	nyIylzbs9j+tWNU+33Tr8dbR2Cxb+W+lomeidgxMat9lkQWrV9uTMvSjOFjdAUn4eQUGBEJwu7L
	ybJ1C8rI0RtIIQPBSWdyJmlA15IA=
X-Gm-Gg: ASbGncu6VVUgL8XFzL0GSHMsHZGU6yhjqRl0ZlL8fL2zIkc0tVpNyPvSB+uYbBf0YJI
	yf+jWn55Na/WJS5D4b6oJZPxOOcmlpxMVpkOSbUI4FiuTp8OghkzFfDhh1+mO8GdkF4RVO4MQpk
	2s8MAL5BXWvmPb
X-Google-Smtp-Source: AGHT+IFzqZpdu7MC8t9TxkIo03vP5tL99wB5Cj8QQx+1U3hSpPKuYwxv3gGiCqW0z/L2qVzCF6IOF+4mjYObYqGjPnk=
X-Received: by 2002:a05:651c:1a0c:b0:308:e476:3b9c with SMTP id
 38308e7fff4ca-308f8373d5fmr1975321fa.19.1739205372588; Mon, 10 Feb 2025
 08:36:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com>
 <20250210-scanf-kunit-convert-v5-2-8e64f3a7de99@gmail.com> <CAMuHMdVnqqffKUQ7+usXruWce8B0KdRxxO41zNY8bTfh-r5oHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVnqqffKUQ7+usXruWce8B0KdRxxO41zNY8bTfh-r5oHQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 11:35:35 -0500
X-Gm-Features: AWEUYZm4phthVH71XRopRSAx-PNkjP5DpFuh1P3qRs_4VwmmjqIDiR-xY8mvinE
Message-ID: <CAJ-ks9nJ6t4UZuH1fOHG5bU0dx5Pcm8XiPUw0c9off+kP2Y1XA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] scanf: break kunit into test cases
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:27=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> > [...]
> >
> > -static char *test_buffer;
> > -static char *fmt_buffer;
> > +static char test_buffer[BUF_SIZE];
> > +static char fmt_buffer[BUF_SIZE];
>
> Why? This wastes 2 KiB of memory when the test is not running.

It's a fair point. I guess I'll respin v6 after all and go back to kmalloc.

Thanks for reviewing!

