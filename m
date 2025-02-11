Return-Path: <linux-kselftest+bounces-26356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B3AA30AD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E363A7ACD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5A1FAC54;
	Tue, 11 Feb 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkSKv2GY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBD1F8AC5;
	Tue, 11 Feb 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274709; cv=none; b=ESsEaa0kRbORm7/jD1Bl26GiFpDNKLwdDG+wQ2Y5FbHsLmKHJyeiHkDYMWw+bNYPIIoycWBAkHkgWbfMBSouvuP09sLC7Zq5fvL+nSlow+9j4O8hkLO0F9nkbftEJxuzH982RRJakzS4UY6GvIC/8ao+Y7svUgSfRHn2HZYy3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274709; c=relaxed/simple;
	bh=GiOlrHymRtTnbNW11P2v4jLd7s8W8V1jFSq+UdT9D6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buY38PwBGcHA56fyWXGIkx2xY3bm1wvcB9clW1klXHW5n9mMA+6O3A/LmDvP7kFBfOM/JU9UT/gNnlsiyGRjoZMf3/Llfbbv9jcMBQAeop5ohGf0i6mP/HsvgwYQ6euKveEfyio8V9ild+XSQZ7f59cAC1ohkVKgnPDZPAKIUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkSKv2GY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30737db1aa9so56054041fa.1;
        Tue, 11 Feb 2025 03:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739274706; x=1739879506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrD/WybHb9roCdO2wW/GzOOL/NJbgM9+aimPlnjkmkw=;
        b=KkSKv2GYo9ZvNUEOvRYDFla+A6Z1dTFWP1TVvKJ+LdnLkCqwhrEbIfvOqE06kOsRAB
         Fa+CnWbgDOtD3mQd8oFRoz5izhjcE2jBAfNm5XDMt4hBLMExZrO2ajc79IK3+dFWiOVM
         kiQxFZ+ShPjFR8999htTeDghKxV0WXxToX6H7fAgWeP8WCLdFPnrdVqQNpyD8cQf7EAn
         Uct0toyWjiaSPPqCiSXaxnw68LK1dhykX1aQob18ssp0Q55eZj1vz42JgTzJfRtTYtE9
         AOD7PNKiUMIre/dvWR7eDarLENYrKt+dq+Zo7B1WO7adcrTp0dYJ6kcjsEnJUS2LU9hv
         IBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274706; x=1739879506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrD/WybHb9roCdO2wW/GzOOL/NJbgM9+aimPlnjkmkw=;
        b=JN0an0dA9f073IkrQm4qfaHN8NuoSbsUPaaRcrT2HXirZFKOmtodyD0gSt+H2HJQLH
         0wLDEWTY4xNFDcU9d0i/L5OjU1jiZUwsej98BuNC2ML3Yr3K3mUINckPJwNirHQF5xVa
         nNe6a6WnBmuvoTNhiDffvgodSuqrKF56RDVRnW1yZTgXtZn3LwBuMOUgfkiD6oneK9vC
         D4UwhoSK5TgJOlzVrBoi/USDx49p1oSZY0lTKCE6GQwRkWrggwt4UgMuKBMi/I/uftZR
         bhnwHgae3XvyzJpuXAWEF8TnQF/ESYm3/nM9XrZZ7EOCEKT7UjtOi2dj3ODh53/NoYq+
         YQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbKaz/nW1KjXXcS0iLe7CP9Vbj4mxQmWhUW2TmRgkXNtyBW98K9cGToD4sQPD/gceihYKzd1Fn//J3pFs=@vger.kernel.org, AJvYcCXQMpNX6Tsf0rDLZhYygSl3HbGjegVFApipOdxkgg44oFPJog+imVSSwZ/ycCIuDHHfclgj9NaCM0DZrS2zoom+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MGl5BpTd5KX7E+rBNJHUGDroMKxXtkn3JklLVZ8iNS6KpPrm
	yh2JS4c6FateIrql+mkio2tDT6zzr8AbpQfa7Pz6TSWId27dpt92mCgWwr1Ynpj19skTd/lU3Lt
	p3b4OZ8LW8UoI1srwWw+RUtJ4Kf0=
X-Gm-Gg: ASbGnct+UB6lgPdfrRgZds49PkwYIUr+dSg9/GmZssjuTCjDcc0nTMvfcmLV++kjg2L
	5ttHUtu+zLqR8RUC+o+FqyOSa4nlVmD4k5AfeoxAbsXkKAgPX/Ud+MLnCI3k/dHuIE8pUgaP5SP
	qIpU+3mSHmMgzXTJXtFQahoLwIM3UZ
X-Google-Smtp-Source: AGHT+IH08XVqwqToptyJwAIYZWbhNv9d/Df3YJD+L+AXe0Ds71S1k+GwZFoMghLe0DNxhUeaE5fxXhkXIdqu834EGdw=
X-Received: by 2002:a05:651c:2208:b0:308:f827:f8e4 with SMTP id
 38308e7fff4ca-308f827fa79mr11235141fa.7.1739274705696; Tue, 11 Feb 2025
 03:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
 <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>
 <202502101836.2B3E7BC4@keescook> <CAJ-ks9=pU6FsOfMk+fSwG2oLG95L2C-jwBDNad1FTGzQ5seiuw@mail.gmail.com>
 <CAJ-ks9nDH9Zk9vaiBP599LN-Jx3aN+JyxFXP16ikV0cayc01SQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9nDH9Zk9vaiBP599LN-Jx3aN+JyxFXP16ikV0cayc01SQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 06:51:09 -0500
X-Gm-Features: AWEUYZnxQAyz6N_1zd_0U9tUq541QFPZHqCTnbbCQo_Dy8ukCVZPWTGX4saYWyU
Message-ID: <CAJ-ks9nK2oNz7s+QW5eF=W_SRZuuu5j4_DNQj9WM5iqH2ECZnw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kees, it looks like the private header didn't make it to your tree.
This bit is missing:

diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index f88d6e64dbdc..de59f001c8c7 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -58,6 +58,7 @@ static DEFINE_MUTEX(lock);
 static const struct primes __rcu *primes =3D RCU_INITIALIZER(&small_primes=
);

 #if IS_ENABLED(CONFIG_PRIME_NUMBERS_KUNIT_TEST)
+// Calls the callback under RCU lock. The callback must not retain
the primes pointer.
 void with_primes(void *ctx, primes_fn fn)
 {
        rcu_read_lock();
diff --git a/lib/math/prime_numbers_private.h b/lib/math/prime_numbers_priv=
ate.h
new file mode 100644
index 000000000000..f3ebf5386e6b
--- /dev/null
+++ b/lib/math/prime_numbers_private.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+
+struct primes {
+       struct rcu_head rcu;
+       unsigned long last, sz;
+       unsigned long primes[];
+};
+
+#if IS_ENABLED(CONFIG_PRIME_NUMBERS_KUNIT_TEST)
+typedef void (*primes_fn)(void *, const struct primes *);
+
+void with_primes(void *ctx, primes_fn fn);
+bool slow_is_prime_number(unsigned long x);
+#endif

Tamir

On Mon, Feb 10, 2025 at 9:52=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Ah, I see https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/=
commit/?h=3Dfor-next/move-kunit-tests&id=3D3e50ba8fc834cadead733e4feeb969fc=
e2f3b6e1
> now.
>
> On Mon, Feb 10, 2025 at 9:47=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > On Mon, Feb 10, 2025 at 9:37=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Sat, Feb 08, 2025 at 09:44:39PM -0500, Tamir Duberstein wrote:
> > > > Extract a private header and convert the prime_numbers self-test to=
 a
> > > > KUnit test. I considered parameterizing the test using
> > > > `KUNIT_CASE_PARAM` but didn't see how it was possible since the tes=
t
> > > > logic is entangled with the test parameter generation logic.
> > > >
> > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > ---
> > > >  lib/Kconfig.debug                            | 14 +++++
> > > >  lib/math/prime_numbers.c                     | 87 +++++-----------=
------------
> > > >  lib/math/prime_numbers_private.h             | 17 ++++++
> > > >  lib/math/tests/Makefile                      |  1 +
> > > >  lib/math/tests/prime_numbers_kunit.c         | 59 ++++++++++++++++=
+++
> > > >  tools/testing/selftests/lib/config           |  1 -
> > > >  tools/testing/selftests/lib/prime_numbers.sh |  4 --
> > > >  7 files changed, 106 insertions(+), 77 deletions(-)
> > >
> > > Thanks! I've applied this and rebased it onto:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=
=3Dfor-next/move-kunit-tests
> > >
> > > --
> > > Kees Cook
> >
> > Thanks! Could you also take the first patch in the series[0]? The new
> > test won't build without it because lib/math/tests/Makefile is dead
> > code.
> >
> > [0] https://lore.kernel.org/all/20250208-prime_numbers-kunit-convert-v5=
-1-b0cb82ae7c7d@gmail.com/
> >
> > Cheers.
> > Tamir

