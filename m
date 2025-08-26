Return-Path: <linux-kselftest+bounces-39962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF50B3701C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE77016E34D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2213148DE;
	Tue, 26 Aug 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSngglwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C0260586;
	Tue, 26 Aug 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225416; cv=none; b=hQIJjljiY94snnO8g3QC833X+nOnAekhZn9HPoq3SeKyunHl1wFT9TsgrKDbHELugGlXh3wMkhAsjgz50uaz6plZs5Ze1GenVfGikuyZddWD1hqkzWT0Ar7jeOJUvCBhgk6sv/37OGUBXWhGEWw/tn3CojP1UpPgqPa3dQDn3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225416; c=relaxed/simple;
	bh=Z/fHLdraDHvbPNoiSuB2MHL7U8X5376cBP4TN8AruJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9YL46eTf74uQIfaCR/8b9smXjRf8NVA+aeFdnE+0VSj4zsfLl02NLFyRyUvpo/CdYRjv8+CE/t4aWvqm4y+5GGxomNCWhbXngQgbm7YcgQC2D6g33T3OX0e99yV81yCe37vMc08MuUCUKXwQgPbaf+VyS5hd7qlMEQDDreFC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSngglwj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33663b68b06so20519341fa.1;
        Tue, 26 Aug 2025 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225413; x=1756830213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aYFk7sq5CM2dSodTk0DRa46bB7zw/9j1RzjFIhceTA=;
        b=mSngglwj85+jOeuX8OhxwTDX99A0h23dVpF/4TWskTcUNF2XGNC/NI53FjILWpmqqn
         6+rf4S3iHa+dGf9C15h+u1N43qEw5uvWpIeuTEQ2o48Zx1a8ogNgCCsTTJcW63HRQKkj
         vK942bBMlLzrpL+ypjxaFN7eCKw2E5TAyuDDbHEDFYs1PjPmXpUnK+tT/alM38Pk60ci
         rKDkKz7myM4bb1S/WDpMVYZbKV0Ib0iRO67mcyG2ph0p63N9o9cGNxdCB70YY6R11pRA
         htRYKBrsivjywXGw+pvSKAfoQoHRc9ctPCL7HwX92imbI89aMa1AJ5EEynk1WThB8NJP
         00+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225413; x=1756830213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aYFk7sq5CM2dSodTk0DRa46bB7zw/9j1RzjFIhceTA=;
        b=UGpLgJs5RzFPiUc86GCf5ZR/pOcYVducXUoPPJd9cYVax0XjGusC+v1i4thVfjI0zW
         T+pVOByzkrHbREcZI9QvwUjDSTVekOWEyVwxaZKcAkTczGs//9TaMK9/zDwke+qP1i2s
         HPALDcZrZuFqfYNNL3450eetA27vBMnGnHvH1bq3rDD929e3DeW5UAFhow2Rd4cm5uxX
         pWS7jRUTdhSlwBpQiuz/JJAan90AHo60D/EsK+NXi4KM6lPMNyaaA1C/1jpZCndKR8pw
         WAa4jVJhhN+po3uF1my6t3ZTL1gS5fbgi1YShTUEmqPONrRYH0V4qHnxLVnqQO3Da1Q0
         6hQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUizZFUKRO+slX3/y6sS6NqvM3C0XXcE+t1arpi/kbNPgnDs61vMBVqV051cfVAXy9FRPVZ8Gsl0pqMZWw=@vger.kernel.org, AJvYcCX0Ze/KiMzl+IsaZm5QTKNrOhIWUcZW/5KWdZKuECLEtmu4u762fC0z5ScBTcnnjJbXut7wePJ0rH/MPtPm3KpV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vmV6tUVmoI8Y5ln2nFgwB6kbRNpNt1HJ7x3FC96PD40noaz2
	6W7OhdZijQcwsTjiZKxYrdqwQMxOVZb/mPSwc3Rww9quOC0ApYHrRFzqvm0w+vvraC4AOIxlg4T
	3Co/cn/jvI/Z/wKtx8/wVAGibP3YY2lDUUSGE
X-Gm-Gg: ASbGncvw6xQcaQDJ6KYVhvfMFdE2sX9beFNCWb4z8LQGs28DqFVjzRDlOvBeC6VdeA/
	VH21ec9NsdOzrXWW6R5pDx15fbFiTN1TqkHWHQR18sm7bhGG80VWbhZeq6rB86i3J9fz+5mERt+
	4l8TPyzsjs0B481QHIfLPpxaxifodZo6PmmPv3MoXE2JNYQjdTQJYzxBH9b3c9Na6lUznartbbL
	KbNreYAduJlIIza4GTfv/Am4NYGLqOYNTocOxTPhw==
X-Google-Smtp-Source: AGHT+IFY8gu/RrCyr3edgcmpVM4R2w44fG9KMd2O0YJMqKVLqnlWjuRIpRapn1ch7o9iKR+T1hVRKcHiM4nMmDW1D0I=
X-Received: by 2002:a2e:a54a:0:b0:336:89dd:41ba with SMTP id
 38308e7fff4ca-33689dd43ebmr8627441fa.9.1756225412701; Tue, 26 Aug 2025
 09:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
 <CAH4c4jJ8VywRUfn2z8HnA73vNxviZ53DZttcR3JaPULF3JFkQA@mail.gmail.com> <aJOG-IAmYhjoYVf-@x1.local>
In-Reply-To: <aJOG-IAmYhjoYVf-@x1.local>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Tue, 26 Aug 2025 21:53:20 +0530
X-Gm-Features: Ac12FXxDQE7gyOdZYAnPp3w1u4iY3ylCUDIqHFUVWVKzr1Z2KPlM4NdLcQSO8Lw
Message-ID: <CAH4c4jLsFNzBEhCQVSCT43tZjbf5wp88xU_5BXnN+4t5CxU52A@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: use __auto_type in swap() macro
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 10:16=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 06, 2025 at 09:15:50PM +0530, Pranav Tyagi wrote:
> > On Wed, Jul 30, 2025 at 7:53=E2=80=AFPM Pranav Tyagi <pranav.tyagi03@gm=
ail.com> wrote:
> > >
> > > Replace typeof() with __auto_type in the swap() macro in uffd-stress.=
c.
> > > __auto_type was introduced in GCC 4.9 and reduces the compile time fo=
r
> > > all compilers. No functional changes intended.
> > >
> > > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-stress.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing=
/selftests/mm/uffd-stress.c
> > > index 40af7f67c407..c0f64df5085c 100644
> > > --- a/tools/testing/selftests/mm/uffd-stress.c
> > > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > > @@ -51,7 +51,7 @@ static char *zeropage;
> > >  pthread_attr_t attr;
> > >
> > >  #define swap(a, b) \
> > > -       do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } w=
hile (0)
> > > +       do { __auto_type __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; }=
 while (0)
> > >
> > >  const char *examples =3D
> > >         "# Run anonymous memory test on 100MiB region with 99999 boun=
ces:\n"
> > > --
> > > 2.49.0
> > >
> >
> > Hi,
> >
> > Just a gentle follow-up on this cleanup patch. From what I could find,
> > this is the only use of
> > typeof() left in the mm selftests, so this should be the only instance
> > needing this change.
> >
> > Thanks for considering!
>
> Hi,
>
> Andrew should have queued this one in branch akpm/mm-nonmm-unstable (even
> though I'm not familiar with the branch).
>
> Said that, I'm also not familiar with __auto_type.  Looks like it's more
> efficiently processed by the compiler in some special use cases, however
> it's also new so maybe some tools (sparse?) may not recognize it.
>
> Is it the plan that the whole Linux kernel is moving towards __auto_type?
> I still see quite a few of typeof() usages (not "a few", but 2966 instanc=
es).
>
> Thanks,
>
> --
> Peter Xu
>

Hi Peter,

Thank you for the feedback and I sincerely apologize for the delayed
response.

You=E2=80=99re right =E2=80=94 this patch was initially queued under akpm/m=
m-nonmm-unstable
and it now lives in the mm-unstable branch.

The motivation behind switching to __auto_type is twofold: it reduces compi=
le
time across compilers and improves readability. Support for __auto_type has
been available in GCC since 4.9 (quite some time back) and in sparse since
v0.6.2 (2020). To the best of my knowledge, it has since been widely adopte=
d
by toolchains.

That said, I acknowledge there are still many uses of typeof() in the kerne=
l,
as you pointed out. My intent with this patch (and a few related ones I=E2=
=80=99ve
submitted) is to encourage more consistent use of __auto_type, starting wit=
h
selftests where it is already in use in several places.

Thanks again for your review and for pointing out the current branch status=
.

Regards
Pranav Tyagi

