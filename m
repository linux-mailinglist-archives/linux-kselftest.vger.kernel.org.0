Return-Path: <linux-kselftest+bounces-25931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD71A2ACE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043537A666D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92585246334;
	Thu,  6 Feb 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE/M/NO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A0246332;
	Thu,  6 Feb 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856563; cv=none; b=fY0i45W6eLwuMI5NS/vedj8JP077X7N1zr2vJhkOcA6sJi60IUGuVw82BAMLbHxXgHmlmBPr4qBeyzmn9bEhwBkhBWbqJX5YIL77bv88TmrxcbxOxgrtVfReu5N7OUeTztUKzkkqrofN7y4I6e+ha0C7Z6wNcJH4eWNsJtJi8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856563; c=relaxed/simple;
	bh=DnUsgVHClr7an86uGMkQW50BpNMdgryjiyGPvpfPTTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtwykX9m9MA6yrZ7ofAT1ICAUvqe6z93cHEGzmY0Oq8Hlyv486396/Ln57aaT2lPY41HN5+q6typTE7n8/DLWxIUUu2vDTWpemkkNea3ePj7qswzaotd8yThylCag2jP4+Annka5vYWdNTgJRRJgxrO0p8KWoNyQxzLlK9yTdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE/M/NO2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401c68b89eso1015592e87.0;
        Thu, 06 Feb 2025 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738856560; x=1739461360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uThs7vYoVlUaze6KIjPadU4u3D1zzeJriVcrwyPC8wc=;
        b=aE/M/NO2bTPCLHfSZ0gC9yCSjtlF7iiR4AlO8KNUUIds9uasJrHHhhc3ZFL1Tk3vlE
         U0FlrkxoVjRYvu2IzW8W+fP8XTZyaDPwqngCJb2P2AATlrFiQw1RBiW/L+jachR3GWxd
         kc6kBhwJ5YeOnoW0zWxOfiHC971i4IIJpF2SIgmhbJ6O7Ei9bcGkTzz1L5nuZ7P07env
         Xu/11h23Ev+Vcok35R/nUCPt3DqXgzMWkyU2ZaB54PXA4UtUNenNdBoocpWcG7qxF/A3
         Jsms6/9Cm/jIE7mGI4/K9BcKF8ZtOs7fiqgL0Ll0W4qvSoxWcazvYqCcqlQgq+yzu5Zi
         ZzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738856560; x=1739461360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uThs7vYoVlUaze6KIjPadU4u3D1zzeJriVcrwyPC8wc=;
        b=b6DEFgI/9YNz9qeXZs2BuoGn/wZvBLPCfelw9FfBOwj/XA2bifodm6Fn7J9WONmoJC
         AiR4mfM6/mhcQrgcOfA5geV4KOGsAHMMtmLzcBPH2xdCikE/BACD3NUtPVN2s9gkz0aN
         QTYrY3IYVgKYaQ5hOQHZrOPa0nen/kIwFjGGgw4cM7VW3nuW+K86cQnyfGJCzgR8yJzM
         rV6vMWe5XdlNZ9rwptwMzG6NkKqt6IocLV5cgQ9dgh0zHKU4cNA+4gPNEa34lRBtG0rR
         fNO6kMveHd9/bo0A9veeGDwYW3QJnnIR9sLkvgUw5/74yi38zdZQNGoOcFuv4gBAPofS
         0MSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuQJJFUZZyP2ce/bsQonvEKDQqFAsY4ItVYjsMljHixPtOjUa1Lb/5a4ho1QvlLCVG8czha5JyfGV0uoM=@vger.kernel.org, AJvYcCXMeRB9jje0wotdR4LjAEjUIdvWO+DXuZ1Hack/2Ye74kocceKX/cYkophfizGjRCIGfLTQNpufj0b8Tm7ymi4K@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBrtntIcnpJqydKhqa6+l71niYAUlKvrTUpaHH/JUVfLv3WQa
	Sk87mG/D3V8sleB/NOnznVWvUfTrR75Vtn2YBYHq3toTyceIg639CgQkafMPOVhiZ/t5ngcvzXl
	Np2RHYmTDwXq/frGfCw7WFRr5/4Y=
X-Gm-Gg: ASbGncsY0nV6tM3NH9WIBEHC8pdKVfzVwV3WpxxNeMm2HTJ4yt0rZRC5I1XGIhLwMpQ
	9SIWAkwXEYZR4prlSilt40Eahh+UZ0qQqG2uHCqrrwYmQ3n6qwtyG4rj7doG/Tfs1mHtWAh3llO
	saI/60qIsqZGc9kvdIvUTomYAW6Xaw
X-Google-Smtp-Source: AGHT+IGPXm3nqny934lAKfMLDlPQGgX9mhMRTaM1S4Jcvt0pPTC8Drms/FoerkG68qymoAyQjOGKsjZsj6jxZxs2V8k=
X-Received: by 2002:a05:6512:b8a:b0:541:324e:d3ac with SMTP id
 2adb3069b0e04-5440e627a64mr1357452e87.3.1738856559402; Thu, 06 Feb 2025
 07:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com> <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
In-Reply-To: <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Feb 2025 10:42:03 -0500
X-Gm-Features: AWEUYZmqiZ8pSWCyJv-_rM25pw08M-NzDT4PDrP7lw5DMp40U5AKmi1rqOOhl94
Message-ID: <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 4:27=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Tue, 4 Feb 2025 at 20:36, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > This is one of just 3 remaining "Test Module" kselftests (the others
> > being bitmap and scanf), the rest having been converted to KUnit.
> >
> > I tested this using:
> >
> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1=
 printf
> >
> > I have also sent out a series converting scanf[0].
> >
> > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-386=
d7c3ee714@gmail.com/T/#u [0]
> >
>
> Sorry, but NAK, not in this form.
>
> Please read the previous threads to understand what is wrong with this
> mechanical approach. Not only is it wrong, it also actively makes the
> test suite much less useful.
>
> https://lore.kernel.org/lkml/f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusv=
illemoes.dk/
> https://lore.kernel.org/lkml/876cc862-56f1-7330-f988-0248bec2fbad@rasmusv=
illemoes.dk/
> https://lore.kernel.org/lkml/0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusv=
illemoes.dk/
>
> I think the previous attempt was close to something acceptable (around
> https://lore.kernel.org/lkml/57976ff4-7845-d721-ced1-1fe439000a9b@rasmusv=
illemoes.dk/),
> but I don't know what happened to it.
>
> Rasmus

Thanks Rasmus, I wasn't aware of that prior effort. I've gone through
and adopted your comments - the result is a first patch that is much
smaller (104 insertions(+), 104 deletions(-)) and failure messages
that are quite close to what is emitted now. I've taken care to keep
all the control flow the same, as you requested. The previous
discussion concluded with a promise to send another patch which didn't
happen. May I send a v2 with these changes, or are there more
fundamental objections? I'll also cc Arpitha and Brendan. The new
failure output:

    # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
vsnprintf(buf, 256, "%piS|%pIS", ...) wrote
'127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
    # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
vsnprintf(buf, 19, "%piS|%pIS", ...) wrote '127.000.000.001|12',
expected '127-000.000.001|12'
    # ip4: EXPECTATION FAILED at lib/printf_kunit.c:131
kvasprintf(..., "%piS|%pIS", ...) returned
'127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'

Cheers,
Tamir

