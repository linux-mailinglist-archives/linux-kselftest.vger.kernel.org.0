Return-Path: <linux-kselftest+bounces-43664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20625BF7979
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9264423E3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0B341AC1;
	Tue, 21 Oct 2025 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QOcYgzWP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557E15A86D
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062922; cv=none; b=ojt9TYKz3olcULr/R5R8OCjqrrp3ezAxtKw4QXmh4JzF9JMDHjRZMqMUXh7ljxKv0/5BngdP06HLj7QBvsMsq1xtR0Ude2gHmF58rcxSGPiVzbh7lQgpboK6H+wGr3Ty7hym04W2SlCy+kh26aHV3ay6q9/cU2fmUKkh5pHSQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062922; c=relaxed/simple;
	bh=5u+TcudwikdJNDByxDFVDrH4Mrn0KzJNwyJDRm/gPc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYR4RZtTASsxspoPLmqvKe5guwtTVb+STCaos5NEU2VT0ec8JvT6j0DY+bggXEazJVWeJ1106HTtKE3L1q9ogodBGOvh/nS9O+fgL1jOEkChcPWBCc8UcMQ3BgVFJJGlVunYItOjY86qfSw3AorNpGlUxIAPal4flBTBfMBsEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=QOcYgzWP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso7247653a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761062919; x=1761667719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxaUYavdFNgjliOqAPTDoGj/sgS4UHn62o4psiKVfI4=;
        b=QOcYgzWPBkIW+aImCI4XlR+l6J8W+mVOtWtjDHpcTIM64QQFdeFNRuL0q4ksV9leSC
         ZHIo3UVUdxWLqjCZRzJRLOnRev6HYr7fij2i4HVr3JgaaUxEG3Hk/ExEuNWt6zGL7Epr
         JbH1ia5blmrpchg+hQQwZ/+YxIhkWDsTy//xOzSybrGHTVwePRdQ4FZuKKZxtA+EDDFq
         PeDJaYcDsEK87sNNSpCtUNkoEAVgCwl0XgdzGz+t4Y8dyFPlA5R85YyiLzrkDr53AU31
         /ywd1KhhB6GzLVXyukna8q6HNPdg2bpk4i32H0JAqudCiEbLPiUq3rIJwWOXC2u+itZZ
         iV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062919; x=1761667719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxaUYavdFNgjliOqAPTDoGj/sgS4UHn62o4psiKVfI4=;
        b=IjeXgXMEJhqLZYBXVfd2I1KAPMJLiPgOmc7FxlA9ERR7/GRYOnFtIRbH7fM0io4H6m
         8/sF38nkpCuxtpyG7N5/1LecQci5VkV74qNIjFMoRQzSEb+/Fcd6aRau3DBqEaWQhOX7
         Vll4xnB1k5xiIgtwDPYZ/G8UflRa2wdGHVgsyXAOyvFa4I6gOVxkxWVQ6YZN14g1PRSF
         3M5NxbfEy2jmTmdlK4fk3X3+iv/SxzUbLdMRKtFtL6AZkhvJMkU3AhNm0XQuV45n1OW9
         sVxF5VEXiBWIEAW4+XTO1iPp1pWeWJcfWzEyOdjS2yBy+u+I53tAqGWWnHYapkBO2sJR
         UFiA==
X-Forwarded-Encrypted: i=1; AJvYcCUTzxZ2OoXt5B82PLcM/v0oK4cYt0iK0TOWSB7yw8a7iFapncubsuwr/OuAGRut3xG3NaaLOUjc+GUBdJOjGcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2drlihj8ig9l/B5xF7w34GJi8QSXBJJBwbBfXs1VHqGScWgVr
	xPrLW9dY8IWU5FqvLUhlEhX8sO43Km188ofjUU400zYITrysmUxeBdcVPFi6STpAlNIduqyvYT4
	kvgT6/LUS6IU2W4/zZcaBxu0rYXKZSKqkO6qHcZecOQ==
X-Gm-Gg: ASbGnctIV27BM1tBmLlTIIIOnYFQEB3AvHTK/2X6+c/AMYuhBQJ6oJu8QJD1gbkCa6q
	wjcqb1fC2PRwSYC9ckZHX06aByzumO5K7mNEbMaiISTlQ2ub6IYoJBDFRo/YoB6aHwMkN7DS0Qk
	OKdYavgzEs83vM0CNREASG3dspaTi2wCThzMjvRSteOwnxFZJyCPQINsQqBCsWvDnMoYpv6eEi9
	0WoxXCFN5qKnWKAbON3WeJGcYLW13A4cMVJxSQkwuIl1+0qVkDLUBdDtN6BsA0wY6540klIhtwh
	pBo=
X-Google-Smtp-Source: AGHT+IGYvj0cBBq3wGSoiNp1CoIJkYDF8ytokgZ/O7ati7otorbUHmL5FNnl4y1k4W4RaajJu5WCCQ85CcQM/eQSHZw=
X-Received: by 2002:a05:6402:40c5:b0:637:e4d1:af00 with SMTP id
 4fb4d7f45d1cf-63c1f677665mr17049736a12.10.1761062919175; Tue, 21 Oct 2025
 09:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-2-pasha.tatashin@soleen.com> <aPXoKRVAyGWCNj8I@kernel.org>
In-Reply-To: <aPXoKRVAyGWCNj8I@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 21 Oct 2025 12:08:02 -0400
X-Gm-Features: AS18NWBcHGkJXGG0ZFCeY6uu-eAVSgeT1z_110jp41TVdiVY4QWXrqa-qnZgrXU
Message-ID: <CA+CK2bD9RHEWZd+t7kWFxofOjBVLd-e+gQTheNJxZbSFy84rfA@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] kho: allow to drive kho from within kernel
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:43=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Oct 18, 2025 at 01:17:47PM -0400, Pasha Tatashin wrote:
> > Allow to do finalize and abort from kernel modules, so LUO could
>
> We surely don't want modules being able to drive that. Maybe
>
>    allow kernel to drive finalize and abort without requiring triggers
>    from the userspace

done

>
> > drive the KHO sequence via its own state machine.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > ---
> >  include/linux/kexec_handover.h | 15 +++++++
> >  kernel/kexec_handover.c        | 74 ++++++++++++++++++++--------------
> >  2 files changed, 59 insertions(+), 30 deletions(-)
>
> ...
>
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index 76f0940fb485..76c34ea923f0 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -1067,7 +1067,7 @@ static int kho_out_update_debugfs_fdt(void)
> >       return err;
> >  }
> >
> > -static int kho_abort(void)
> > +static int __kho_abort(void)
> >  {
> >       int err;
> >       unsigned long order;
> > @@ -1100,7 +1100,27 @@ static int kho_abort(void)
> >       return err;
> >  }
> >
> > -static int kho_finalize(void)
> > +int kho_abort(void)
> > +{
> > +     int ret =3D 0;
> > +
> > +     if (!kho_enable)
> > +             return -EOPNOTSUPP;
> > +
> > +     guard(mutex)(&kho_out.lock);
>
> Please include linux/cleanup.h explicitly

That is going to be included via kfence fixes which will come before this p=
atch.

>
> > +     if (!kho_out.finalized)
> > +             return -ENOENT;
> > +
>
> ...
>
> > -unlock:
> > -     mutex_unlock(&kho_out.lock);
> > -     return ret;
> > +     return (!!_val) ? kho_finalize() : kho_abort();
>
> An 'if' would be cleared IMO:
>
>         if (val)
>                 return kho_finalize();
>         else
>                 return kho_abort();
>
> and we can rename u64 _val to u64 val as we are dropping the boolean.

done

>
> >  }
>
> --
> Sincerely yours,
> Mike.

