Return-Path: <linux-kselftest+bounces-25491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E9A241DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A0B3A9A08
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8641F03F5;
	Fri, 31 Jan 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS9RGYIM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA261F03DB;
	Fri, 31 Jan 2025 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344360; cv=none; b=ktDuFBeTsnYxC15PCkvVQ4OA04N3aPLHZmfmog+EoxzBXdEjACNrjeGYjZ0ena2GiSwWxwcqu79bgNAYUbCag/vZfeBvvFyUlbd2nXANZVLEW8N9F5S3PC+MeS5EafX+Sf9IQ1vZpNcUWW11j4JBTh+LCWWLD8HHu1Cf2KbvzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344360; c=relaxed/simple;
	bh=Md3avUZfkJpoONhbgXrvxIHSaXb5C8aY9m/Ek/7i2Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phElSY7lXioNq+0qkVOxw7yS5d4hmlHzpO/5rIz58l75oZLNfsPF0S4qsjGHyQvSmpt6TEEU8gqx9vZnWzBNVX+eHVhqtNByo+Iba3f+lIIvc8LPLuGB4gN2tn87evq0vbARN7KFMpqa9K+nQ8ymQdrKhp7NsDWcYXxTnF2PjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS9RGYIM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fa8so21420561fa.2;
        Fri, 31 Jan 2025 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738344357; x=1738949157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md3avUZfkJpoONhbgXrvxIHSaXb5C8aY9m/Ek/7i2Eg=;
        b=QS9RGYIML+FkyM2zGmLPMGTKOwynj3CMv+Xk6lquTcc/3K8R3NoDDcR0HHcoQMKTo6
         o9JqkFJDuOU8E0J/KookWPrSGNcj6plzWpGzklJHmFRXxt/E/eMrP+aZzLyXppaf+2s3
         GkbkzvdbsoMls3IWumIjj2qirWkAW0AZQD8PLDuctbba0hpzB1gnvnNskmT/iTxYgE0S
         VtXFWIT6pTGw1erh2NGcq+AmLMIq3zgW+9pmNX93NtH+VZsLmeHHgLoB2yRqKHCWyNhF
         A/pMqBM8DSpNEHxGRL021U7hsatXcRsu7WuL8tQe7FV+dOSWOABwoem8FugwdF60Pdr7
         gSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738344357; x=1738949157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md3avUZfkJpoONhbgXrvxIHSaXb5C8aY9m/Ek/7i2Eg=;
        b=a72LbhtG3C6zBxD4toP2b5t9ygp3MSWfpS5hzLa4uvqtAHUFSa4YNElyJ+5KoWcptv
         OWItj/6T7JttV+grjoMIuVDg2Z4Fy2nMPyfNskjOaBXf1nDMv7XPjgYBrkGnzlpRoWRw
         7eREwSJNhBR8+U7VQuEsJAYacIpElz4oLDAEiOIowZdGm5BBayGiYH3EECzHgvJgQRbn
         qKd1AECg5whG7UTEwX44HXSD6jo5bb6d9DXPLgKt8eoQgMATdgp0VM6us2MS7/eddMm1
         M9j1l7OaiUIx1QcbCMqxSEp/+cYanWZHydlpXiqi8iF8LUjj9ohst/+8PkH4mTrDw68j
         90qw==
X-Forwarded-Encrypted: i=1; AJvYcCULXtAUDiaVzn1GwL95lXBEy/9pWdnyLOZFQ1S1lNsnkMNHQvdwlUPBcQ8n4jEr5OJLpNK8m1mJ6UEi+ZM=@vger.kernel.org, AJvYcCWOYDE/sgqaG2nPELF06Ye7ORlFyrZvrLV+77EeRZBnaYUjtyZdyF+Gc/+u7utfm/aTRZr3a+P2vIdt0OfxBWa6@vger.kernel.org
X-Gm-Message-State: AOJu0YznJyre/DfCbBjpj8x81YPSaacMNyT4tgkH9sCnIT5Tu/D2YL/R
	1GO0pTDQrG2UrLI7deyCMRP6IimT4D8XAjU1s8yBx+QaM4nxYFUQqGJU/3/jQBAGtTkU5dr9Br7
	3ALLBG6wsLbpPh+ATPw8WOmcYaOXaAvb5ts2V4A==
X-Gm-Gg: ASbGncsKLE94GmvQqGjPa01kn3VDXfdn3eVePHto2NawolvyHtwMZGPn+iavfwN7Pe+
	QsMP/hN9kJMXRn2iEBOfM57NSVzuxNhUSYDgvo64kKsdlzA/FuGkXb8GPMhy6Va5jrqRRlmwal5
	zvB8q5Gan4L3U1F1T/fciDYweusc0Mwg==
X-Google-Smtp-Source: AGHT+IEGkMcRMiHSzofLD3dZ2/pBPEvPzGUaOaEuSkvIX7aCnII3RpAlF62ijv+mQrOkOogQG3fmYIBiCF5Kwz+3WwY=
X-Received: by 2002:a05:651c:884:b0:306:501:4772 with SMTP id
 38308e7fff4ca-3079691028amr45460741fa.37.1738344356554; Fri, 31 Jan 2025
 09:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
 <Z50EM7gxqyV0Eois@smile.fi.intel.com> <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
In-Reply-To: <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 31 Jan 2025 12:25:20 -0500
X-Gm-Features: AWEUYZlwyE92ko3eqfFnfy7F8irTVn1UiJ7GVwLe4P9iMADObDXbjLo12hxUM_Q
Message-ID: <CAJ-ks9=N8TkYjCm0fSFvoMNHKV2uJNrWJW5oCJziz6JgL2ObMA@mail.gmail.com>
Subject: Re: [PATCH] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:22=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> On Fri, Jan 31, 2025 at 12:11=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jan 31, 2025 at 10:47:49AM -0500, Tamir Duberstein wrote:
> > > Convert the scanf() self-test to a KUnit test.
> > >
> > > In the interest of keeping the patch reasonably-sized this doesn't
> > > rename the file in accordance with usual kunit conventions nor does i=
t
> > > refactor the tests into proper parameterized tests - it's all one big
> > > test case.
> >
> > Rename of the file may be done, but you need to use -M -C when formatti=
ng
> > patch, in such a case the diff will be moderate in side and easy to rev=
iew.
>
> If you prefer that I rename the file, I can do so in v2.
>
> Can you explain what you mean by using -M -C? The formatting was done
> by hand, is there an automated tool? I tried using clang-format but
> the result was a change on almost every line.
>
> Note also that though it looks like a lot of formatting has changed,
> in reality almost every changed line has non-formatting changes due to
> passing `test` around.

Ah, you were referring to git format-patch. Sure, if you'd like me to
rename the file, I'll use those flags in v2.

> > P.S. The test modules in defconfig is something which puzzling me. I wo=
uld
> > remove all of them at once, if somebody wants debug configuration, they=
 would
> > specify it and use with help of merge_config or alike.
>
> I'm not sure what you mean? I removed instances of CONFIG_TEST_SCANF
> from defconfig because that option no longer exists.
>
> Cheers.
>
> Tamir

