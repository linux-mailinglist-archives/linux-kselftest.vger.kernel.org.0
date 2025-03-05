Return-Path: <linux-kselftest+bounces-28306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74749A4FDCA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 12:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979FE172281
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48716241C87;
	Wed,  5 Mar 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6MWTxx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFD236450;
	Wed,  5 Mar 2025 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174606; cv=none; b=gFCVzob+8HCkQvYxhszn3qO7BzLWO2FGSUMsMQ4Snex9Mt+X6Emjhn00/hZBBJiwtYRGbkx9MutA7qDQqykUVqSVy4Fp+fTrN/eenmrAz+jfCb+iD8f9DF7bukG3K0S8hDkxYOzTgITsd1XqZ0VIHguLpheKp8FrE4jBmexPEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174606; c=relaxed/simple;
	bh=HeaLeqCxFce0lg8Om7j0ozI2Ceknv89Ds829ukrVQcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oi3xsqxqs7Lx1lUcuhFS/YJbUJaXxMuMXGwEMKcPmur+5ylONA3gUBHozSnAb8V0Sq6WWWEvo6LkvvMMVo6kxFL1zoJsMKvLTjd5nHZoY/Mpae8fxQwVVtao4fsnGJQ8M9KyVGuG2xj2qS5d/ww+kvI4GHqvRhfY6VtfvMpd7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6MWTxx3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fa8so72194021fa.2;
        Wed, 05 Mar 2025 03:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741174602; x=1741779402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWlFdYO+U5pkyvFkJdSxJPcpii24zFkKT+mvaAzenDM=;
        b=L6MWTxx37fGCpwEY2bCr3N5ofGiVCcrgjd7y155eN/His0I5esm5WsDsAwEaZchEqD
         aSvR14ZpQmlRPuc7it30ui0RDt/jJyg4qAhWuMCZPwnuD+3bmdAKgxE/4YczcijHAM0o
         i2fv8d+dkUjKwJMjGGShpEDYAtIV1nHrPRTo/0QyFZJzHmBM89hMZTHE1LVBnoURs1+l
         47ACBjVt4UGqjeCzn+8kh3rgk6NEAD2RMRJfFpTSojl0FitN+0tF5OCIyWW4+Qor3X2b
         iT7W03z3oN9vc5lka13jpo3ckWQitu8CStJ89wTDgP1p21UGAih/7CZlNMYv/SLgLsaz
         s2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741174602; x=1741779402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWlFdYO+U5pkyvFkJdSxJPcpii24zFkKT+mvaAzenDM=;
        b=w3ZnvCiZ85duLVbs5VW/K8uD6p+DC+gDHaT5se1e8Mtw42Fvy7hh84U27cFhjk86fY
         OqFdMivEJ/jusi6RjDUz9vsRK/L8tPvWCzouyJbU52m2O/Saknajb0k721pH/QL2AFvB
         VXGEe+l5MBhPQ/NoJIvGRGRuSwjkJeDmvrMbRMAP6zmmeAO14E+ydtbUt6sI/0iGJhzH
         VZsdRGfS2JyUr5Yds5bYwVmAN7dsmAEkhYWn0WjBUEOrx29b0sUrqtjCI3Mf1/jGe05U
         GDXJtfBl55t7TrdkpgrYvft5wNgnCgFeJotRWHtrXwR7LZ1BvABJo5B5O7SXLpCelPFQ
         t9OA==
X-Forwarded-Encrypted: i=1; AJvYcCUMPuZncruYdWdsQT3+AzrR0vt81URH1KOuLbDw3vYeKcd4oz91r/TULiQmqlGWtybPQArQ33bQ+Twl8wo=@vger.kernel.org, AJvYcCWtLDnAKurW3aivLAJENqPzbk0bkeGTjelijrFzgsZZ/WVE+qWIyKL9z12TFy7UZoFvksG8wc8+Pj5SKUgxke+9@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPZQH3mxWbysBsQJPwH6RsbhsfYT/ctxl5PgCiA0Mqqejh2fw
	m5fWz+dMgVGshTlP11kUPPrGAshbXFd5FJiSKVNREYZ/jmGX8mvIHLw3fKQv6c58E/ilCir+35F
	OUyNITjyWAGI0VKamxIcicBuQyvs=
X-Gm-Gg: ASbGncuAGQ7D60InbOv1dtHSWwuc7UZ6MJ1MbG12FMqZ6qpOxoRLdbJAYk282zmVqZ2
	cihbPqvpqkTUtTEOx+AFXI3lLwIBsiRl3fMAeVMZnyXIkpMzutrAcqsjtBfavIxnUNuQg3uC1NP
	RaKdKvHY9Q6WIDoeBkjUvYCR9TxLyUOSBaHiCEieylPCF3/UetDXWdTyXb6qTY
X-Google-Smtp-Source: AGHT+IEoFkcbxDDv1dZPxu93WwtasiJI2Lz3qV5/cJ/6/JfY41teVTwgtDE1Riii8TG+BQq6FVk+CV4MaDNemyWbAN0=
X-Received: by 2002:a2e:bc18:0:b0:30b:d63c:ad20 with SMTP id
 38308e7fff4ca-30bd7af199bmr10137871fa.24.1741174601641; Wed, 05 Mar 2025
 03:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
 <202502160245.KUrryBJR-lkp@intel.com> <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>
 <Z8gdpSErMCMCZZNP@pathway.suse.cz>
In-Reply-To: <Z8gdpSErMCMCZZNP@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 5 Mar 2025 06:36:03 -0500
X-Gm-Features: AQ5f1JqURv3wm0FFfsHXNlwRx6ZYwKWLutLxKPRJPNR4Ik3Z-kjKd3V7yI5FsHY
Message-ID: <CAJ-ks9mMCmD8UkT_gkiLxh3sRZkOWGVFamNnFfdVNJ__f2mfgA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: kernel test robot <lkp@intel.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:47=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Sat 2025-02-15 14:52:22, Tamir Duberstein wrote:
> > On Sat, Feb 15, 2025 at 1:51=E2=80=AFPM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Tamir,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on 7b7a883c7f4de1ee5040bd1c32aabaafde54d209]
> > >
> > > url:
> > https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/scanf-i=
mplicate-test-line-in-failure-messages/20250215-002302
> > > base:   7b7a883c7f4de1ee5040bd1c32aabaafde54d209
> > > patch link:
> > https://lore.kernel.org/r/20250214-scanf-kunit-convert-v8-3-5ea50f95f83=
c%40gmail.com
> > > patch subject: [PATCH v8 3/4] scanf: convert self-test to KUnit
> > > config: sh-randconfig-002-20250216 (
> > https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-=
lkp@intel.com/config
> > )
> > > compiler: sh4-linux-gcc (GCC) 14.2.0
> > > reproduce (this is a W=3D1 build): (
> > https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-=
lkp@intel.com/reproduce
> > )
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes:
> > https://lore.kernel.org/oe-kbuild-all/202502160245.KUrryBJR-lkp@intel.c=
om/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    In file included from <command-line>:
> > >    lib/tests/scanf_kunit.c: In function 'numbers_list_ll':
> > > >> include/linux/compiler.h:197:61: warning: function 'numbers_list_l=
l'
> > might be a candidate for 'gnu_scanf' format attribute
> > [-Wsuggest-attribute=3Dformat]
> >
> > I am not able to reproduce these warnings with clang 19.1.7. They also
> > don't obviously make sense to me.
>
> I have reproduced the problem with gcc:
>
> $> gcc --version
> gcc (SUSE Linux) 14.2.1 20250220 [revision 9ffecde121af883b60bbe60d004250=
36bc873048]
>
> $> make W=3D1 lib/test_scanf.ko
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC [M]  lib/test_scanf.o
> In file included from <command-line>:
> lib/test_scanf.c: In function =E2=80=98numbers_list_ll=E2=80=99:
> ./include/linux/compiler.h:197:61: warning: function =E2=80=98numbers_lis=
t_ll=E2=80=99 might be a candidate for =E2=80=98gnu_scanf=E2=80=99 format a=
ttribute [-Wsuggest-attribute=3Dformat]
>   197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Sta=
tic_assert(!(e), msg);}))
>       |                                                             ^
> [...]
>
> It seems that it is a regression introduced by the first
> patch of this patch set. And the fix is:
>
> diff --git a/lib/test_scanf.c b/lib/test_scanf.c
> index d1664e0d0138..e65b10c3dc11 100644
> --- a/lib/test_scanf.c
> +++ b/lib/test_scanf.c
> @@ -27,7 +27,7 @@ static struct rnd_state rnd_state __initdata;
>  typedef int (*check_fn)(const char *file, const int line, const void *ch=
eck_data,
>                         const char *string, const char *fmt, int n_args, =
va_list ap);
>
> -static void __scanf(6, 0) __init
> +static void __scanf(6, 8) __init
>  _test(const char *file, const int line, check_fn fn, const void *check_d=
ata, const char *string,
>         const char *fmt, int n_args, ...)
>  {
>
> Best Regards,
> Petr

Thanks for the review! I'll respin later today unless you let me know other=
wise.

Cheers.
Tamir

