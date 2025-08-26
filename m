Return-Path: <linux-kselftest+bounces-39963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CDBB37038
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6016F12E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CCA3164CA;
	Tue, 26 Aug 2025 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItuZx9xm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BB3081BC;
	Tue, 26 Aug 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225604; cv=none; b=bdGflle/+KFPsK4vKMTyTNJmpA+juys4l1x/42SwTab537Z3jXuWtK0BIOZ//Uy3S9GHtNvNyV/837f6xciRHfY6/TohCySkyMIaYZPnQ4eqIc1bzFtkFpTyQno0Pg0NZ/WL/2XZQPdVuOIA7c/Vc/qX8HJeUHOCRSxjMxpA+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225604; c=relaxed/simple;
	bh=KIUHApQZBeG3sv1gBKAzcJWc3aNcc0ib8FLAyWN2igM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihbMthIe7H0oKoHfQVtjZNCmlhqrFE6csPhLI39B9yPjA9qfInlqVHl08gtCU/LyP29mYsjUCur0WGyZpqbqoHF7jAI7Yb187Fc+M2wD+ztThZHSw1+DV99ligP/x2vCXfCYPQC2c7r6dI3TFGwZdbKlPgiFRR98uRbmNypUMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItuZx9xm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3367144d19cso23509801fa.2;
        Tue, 26 Aug 2025 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225599; x=1756830399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5zGMY0B+wsQd0Wnquc7Hok6cqc/WBPDwGcUcIfHRhk=;
        b=ItuZx9xmwoblq1aFrYRUznaaOwJ/J+eaVuBlBA+8jtU33Uc8SQoWs92c5N6Rk4V53n
         FY4Vw04UzvHm8TrZE7JezEU9/LaqggJ+WdyxjCKRootDVPd2WqDYyTgX6M0geEAnggMf
         j/EL+l/cSffNH1ChoVo/LDuIPqTS8wZYSgU/X5sCg0p8eb1sV8C1mAzOFsf400/Z9Vt1
         gNPoN2HeUJwoVo5V6Y9mdzi7Kxu7W2uu6CXGxi7Dol/6udeJByzKvFgmy2vexqb9ZV7m
         wTIU5g71IjRCAeXjHD78QiSLOx89otGG0y2C7NHWd3Vkp+qCcEY00V87c0PaLUwFF8we
         TZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225599; x=1756830399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5zGMY0B+wsQd0Wnquc7Hok6cqc/WBPDwGcUcIfHRhk=;
        b=phTucKxernkH1eOhfY36kcsa0hv5ciOzG31aazksuW6OluLeDUTAI9W7biO4l8K3cC
         lsPrkBgP5Z5fCAWLknTbJqV9zwkwjbxUgP55ZMVuI8JMwxuWRRWDt9zwKkg0nPhnue9O
         gptfkSAaVjVEHMp/DLBLa1xcW/Y50b5TTncBNtzJH1ZV9+FGgkP5ijLkDrbvpCzLSYt9
         gFw5xF8mddzw3wapUzduQnkrakn48qJ8gh4hqI3x7c3VpJhYWtbCL/JxpS0b2B1F84at
         lhX83YweJtxFKsmUhRJ0H3gl+BRTjQ/6stKWHNHBVIYDRcJzEAg8w/033/XJ5FW7N9M/
         tQvA==
X-Forwarded-Encrypted: i=1; AJvYcCVdKpBqi12uMNqDQXe1r8+W/BSGXBLeP3nMUimVbc6Yt8M/ZKJwUDy0rt5rKgtqSWXthNaeLcCSPpRGYRA=@vger.kernel.org, AJvYcCWCMNBWKdVGvn0cIYU1WereDLupuNpD2LSOqa6992kOhDoMr2AK4QAkch0NCcz7Z0VAl+uP2oSg4TdpDn6n6Ieb@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeo6WzLf6ZjI+CZq9QlUcTVAtd8NCyUiSYKGWd5rcojNLqi+l
	Fw0J/THO0cWtFMWABXsu4t5dgfCip0bsrKl8Xl5iwkS/JKQMAtEaQgpNZbXuXlgtknLQFxygPuy
	LohHIHbJ2JnjGMRotIuBSRR2zlg1qoTyHhsFi
X-Gm-Gg: ASbGncuVRHG4STBdrwpKmkquGJ4A/PjklZt1X9xoAPAHDOQGGnkEANS4dOWFR/uM3+d
	moNFwGiOE9KhuDtvmxKSwx3at23sS22419XQFlkw8PJ1Vo9MBkii4s5U04MhQ+H4oys0JGgB3OL
	OCLPDyNvJQT9P7kMnKKKjT1MEAKs71syLso3TlCAzLF5tt+hJsSiKpn9OKMToom2mU0UfDZtu2E
	HCfKhpXQgfaRecz67fE5qY4Z5BrauN1c2wBycVSzg==
X-Google-Smtp-Source: AGHT+IHkb64c4bZS+NGaeP4VCluu/PBLB8BKBtdaSeEYU+WxbjYgL2JboP1sxe+Bh7hVlYsMPO1uy+hpvD/0fQSHB0E=
X-Received: by 2002:a2e:be92:0:b0:331:f04d:e689 with SMTP id
 38308e7fff4ca-33650fc8436mr45721141fa.41.1756225598840; Tue, 26 Aug 2025
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730142301.6754-1-pranav.tyagi03@gmail.com> <20250806164841.2907972-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250806164841.2907972-1-joshua.hahnjy@gmail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Tue, 26 Aug 2025 21:56:26 +0530
X-Gm-Features: Ac12FXydsbaI3ePxtk_Pq8B7Slgn4iz04KSeXyYj_cYZPkXFV1_OSHzZmmvB410
Message-ID: <CAH4c4jJmCP8w8mbeTpOhNvWCgb9U1A+ssny3nSw9Qg5tEnqVcw@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: use __auto_type in swap() macro
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 10:18=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Wed, 30 Jul 2025 19:53:01 +0530 Pranav Tyagi <pranav.tyagi03@gmail.com=
> wrote:
>
> Hi Pranav,
>
> Thank you for this patch! Sorry for the late response, thank you for bump=
ing
> the patch. I just have a few comments about the commit message.
>
> > Replace typeof() with __auto_type in the swap() macro in uffd-stress.c.
> > __auto_type was introduced in GCC 4.9 and reduces the compile time for
> > all compilers. No functional changes intended.
>
> From what I understand, the compiler optimizations from typeof() --> __au=
to_type
> applies when the argument is a variably modified type. It seems like this
> internal definition of swap() is only used within selftests/mm/uffd-stres=
s.c,
> and in particular is only used twice, in these two lines:
>
> /* prepare next bounce */
> swap(area_src, area_dst);
>
> swap(area_src_alias, area_dst_alias);
>
> Where area_src, area_dst, area_src_alias, area_dst_alias are all char * w=
hich
> the compiler knows the size of at compile time. Given this, I wonder if t=
here
> are any compile time speedups.
>
> But this is just my understanding, based on a quick look at the code. Ple=
ase
> feel free to correct me, if I am incorrectly understanding your changes o=
r if
> my understanding of __auto_type is incorrect : -)
>
> With that said, I think the main benefit that we get from using __auto_ty=
pe
> has more to do with readability. Since __auto_type can only be used to
> declare local variables (as we are doing here), maybe we can rephrase the
> commit to be about improving readability, and not compile time?
>
> Again, please let me know if I am overlooking something.
>
> One other thought -- while this internal definition of swap() is confined=
 to
> selftests/mm/uffd-stress.c, there is another identical definition in
> include/linux/minmax.h that may be used more widely across not only mm
> stresstests, but across subsystems as well. Without having taken a deeper
> look into this, perhaps this version of swap is indeed called on some dat=
a
> structures with variable type, and we might be able to see some tangible
> compile time improvements?
>
> In any case, this change looks good to me, but maybe a new commit message
> that can more closely describe the effects would be better : -) Once you =
add
> those changes, please feel free to add my review tag for the mm selftest =
change:
>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  tools/testing/selftests/mm/uffd-stress.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/s=
elftests/mm/uffd-stress.c
> > index 40af7f67c407..c0f64df5085c 100644
> > --- a/tools/testing/selftests/mm/uffd-stress.c
> > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > @@ -51,7 +51,7 @@ static char *zeropage;
> >  pthread_attr_t attr;
> >
> >  #define swap(a, b) \
> > -     do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } while=
 (0)
> > +     do { __auto_type __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } whi=
le (0)
> >
> >  const char *examples =3D
> >       "# Run anonymous memory test on 100MiB region with 99999 bounces:=
\n"
> > --
> > 2.49.0
>
> Sent using hkml (https://github.com/sjp38/hackermail)

Hi Joshua,

Thanks for the detailed review and I sincerely apologize for the delayed
response.

You=E2=80=99re correct =E2=80=94 __auto_type mainly provides compiler optim=
izations when the
argument is a variably modified type and in this case the compiler already
knows the size of the arguments at compile time. The motivation here is mor=
e
about readability and consistency, as __auto_type is already used in severa=
l
places within selftests. This patch has since been picked up into the
mm-unstable branch.

I also looked at the swap() definition in include/linux/minmax.h, which is
indeed more widely used across subsystems. That version may offer tangible
compile-time improvements in cases involving variable argument types and I
plan to follow up with a patch there.

Thanks again for the thorough review.

Regards
Pranav Tyagi

