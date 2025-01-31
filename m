Return-Path: <linux-kselftest+bounces-25499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782BA24391
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 20:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02902188A5F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7091F2369;
	Fri, 31 Jan 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5VVbcKI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C722615;
	Fri, 31 Jan 2025 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353575; cv=none; b=AWMKpH+ktDIVuYm4z8dDXFu7Yzw3hA58Q2+2zAqFo/7gUjoDFfdIxQkJ6eQcmasiHkfGz/u8T4Ec9e1CAddNCXLKu6hzaL3/Ce1sga+2coLGbzTGDOUGw2Q/YsiCwsU/8t6o9vhsj8QQwanicP6comSPKteNkGdLsmv63sZtLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353575; c=relaxed/simple;
	bh=1sbfVQ+x0qVwv6oC5r6SvSSaZ46HHoEo8cAdmmwoKQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjEs7ipagcDNqPgypA9LYVMbGn8ZXNFj20OtC61dK9e9ru9qlJXvknnrmsg01E1HVehaxsoXwZt//JUdiQhxnIiOUUg39DhV18lEdnTn9p6rzSEVQ4Lkc8KUkUUw4jxECYdkU3coePngQWTXqpZbOERugK1TKxZHKWJ7uP9JdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5VVbcKI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fa7so22841051fa.2;
        Fri, 31 Jan 2025 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738353571; x=1738958371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sbfVQ+x0qVwv6oC5r6SvSSaZ46HHoEo8cAdmmwoKQE=;
        b=K5VVbcKIgbQ6QCcy2x3bMAn4FiQHhxcvw2wwlKHzG2f+lUVHgPIkjQOPaFuqg5xiNF
         Z8fOavDYnVHtzCl7ScBW+rWlIjZ1eG0yHfS7wOvz/NlEHINzDnFu1uoHgVRNMcNRpBf9
         5ZfBiYxaoz3gmnqPQKi/WrjtDATxkR6uluimyVMrrI4XZ28762UTjGtlb2ySSErVBFRe
         k6Xe2nirT+1lzo4Mm3YQVt9wl3c9ztR4yeERUyO1EsrySJ17a3lZ8xuV6ovKL+GQCRHh
         5JwHjmeqWtmy2TIE7GYlbjaCpEAxyhd751NxeYGAZucMksTLgZuByvXyLvRKiKBgKjqs
         cdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738353571; x=1738958371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sbfVQ+x0qVwv6oC5r6SvSSaZ46HHoEo8cAdmmwoKQE=;
        b=nNX0sHd7E4X/lRZWiPpdaybPrlMdClVChyP7qBeqc5M+JZGjs1LUGONGjsePNXdxqp
         yEp5nfiIopvec5j34ffQalegFfqqalutge9hcQrR7QCjUg8IujTQEz1WCybw8Kkpt7mu
         lHEQTbRm8mjtJRF7Chm4x35aog4uxotg9oJ4C53vPrQ+ItnmPUdAKW7tHkfF8042CIyO
         pLBJnlXkOA1/T6aRvw6IS4Wd1ZHJ/WiZbWhNf1WcV9s7qIrVrudplLNMxqM+zCM33SHv
         SS5yJPfq++VgrgWcT5iDc/KsTslLr3+RsBqfc7Ea8GCWplivcuG6LJOJPZ9Uy9Ooc4i6
         ZKhA==
X-Forwarded-Encrypted: i=1; AJvYcCUu98gi1SyRQ2lsvNHlhqbW5IHiEKHez6RRo02m+VPHwTh1sNg3vUu5Tz9jF9ILRz0bog+XQUkXdj3OnUg=@vger.kernel.org, AJvYcCV59ImU5EB1XaXf+mn57KDokOmic2yeSnFspkzaT+MYMtFb7v27Lg4eMjb5Gl8TFV11OiJ+rqojoQIQHBQ0Grcb@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN1TTA44EY401PTG3wvP3VK9dcjhKywKKv2l9lA2Eh4XQRtkP
	ZwnwMg4mkIbnbCmnOQNOlNpqazCD3iCBbh6raL1aIG4sNCLXwIo3GxVScUODx7+gBYn+yjysboH
	2kbXSdwxsqgePz17Iku3/SpfMPHI=
X-Gm-Gg: ASbGncs/xH0QVMfn4lTQ6TiaCaqosUanvo+QXABgwtU8NelZ2ZHHULLm/7PaQK831nW
	PE71JJWT+UCwCOfYBSEYIrRj7WF+E6y5H0DHXumSiAex4cRDKJeph7UM2ZZBbGT35c7CHoQmxf9
	b3mpKaaQTO3NEXGNwu1qXGVb6NF8hId+8=
X-Google-Smtp-Source: AGHT+IHihmgT4fkqEcjkcj3dceSxGz7ryZwu2CA1i6Q03wQwHzngEqRjlF5cg0AuosE0ekcpQRFcldW8m/tMeIfztOU=
X-Received: by 2002:a2e:b8cd:0:b0:300:2a48:fb65 with SMTP id
 38308e7fff4ca-307968eb492mr47666541fa.18.1738353570945; Fri, 31 Jan 2025
 11:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-scanf-kunit-convert-v1-1-0976524f0eba@gmail.com>
 <Z50EM7gxqyV0Eois@smile.fi.intel.com> <CAJ-ks9mMgkdNEHHKELa=5gNz+CzUNno08ZKJwwQDVEb5WvN32A@mail.gmail.com>
 <Z50NVYKv7JBn10hj@smile.fi.intel.com> <CAJ-ks9=wFZhmTE3kmVF=Ujn9xWgGoFrSnsihHmRoW1eD_3Cdww@mail.gmail.com>
In-Reply-To: <CAJ-ks9=wFZhmTE3kmVF=Ujn9xWgGoFrSnsihHmRoW1eD_3Cdww@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 31 Jan 2025 14:58:54 -0500
X-Gm-Features: AWEUYZmxZPafM5miX9PW7lXq-Ab8ebB8-qsVoiaPprEjgbhreJA1Pq6drb4xBL0
Message-ID: <CAJ-ks9ke8XeOimhMM4tkYgjUoLCx9nU6Sk=ypvEh4Eg=tjCpPw@mail.gmail.com>
Subject: Re: [PATCH] scanf: convert self-test to KUnit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:58=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> On Fri, Jan 31, 2025 at 12:50=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jan 31, 2025 at 12:22:39PM -0500, Tamir Duberstein wrote:
> > > On Fri, Jan 31, 2025 at 12:11=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Jan 31, 2025 at 10:47:49AM -0500, Tamir Duberstein wrote:
>
> [...]
>
> > There are other options like CONFIG_TEST_PRINTF or so in defconfig file=
s.
> > Why are they there to begin with? The answer to this Q will affect the =
change
> > you have done in this patch.
>
> CONFIG_TEST_PRINTF still exists; that test has not been converted to kuni=
t.

Ah, sorry, I had misunderstood your question. These were there to
enable those tests; when the tests are ported to KUnit this is no
longer necessary because of the presence of CONFIG_KUNIT_ALL_TESTS.

