Return-Path: <linux-kselftest+bounces-11412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824539009C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807301C216DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F6199EB3;
	Fri,  7 Jun 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nmznvAS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190519A2A8
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775974; cv=none; b=AiOl0mchV1jOCup0kl+dcY7F7NZjqkWXFEiwgfq6xDFq/ht1wBhb3Zp96Kr5f54MhstVFqjEJNzLaKUNrEB2cHU+IG9u7PYwe+zAt4sHDF8Qns3WmuoVpD+6AsjLaz3LXMlR3FDT5I/pYzbbCbdoIRXEDzkTt/eBnO1zMZVPoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775974; c=relaxed/simple;
	bh=iq3vgahPJc1R2sFSNT7KHSLa4eLNSlV+Str2BooQvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgM752+LmqihKCIDn6e41QkaguJQokGq8Qn/zXbSziNawMN+5zihp7j8/xlj9Q44YbISx/swMJZG+PRSvSU+pI2eDICzaSY0RTYyp4kuk80BMDkwRPW6iwoKPE2b91c5wUwpKyABkfyAhxW7B8PBaDyHH187F50hvxhkxnTx5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nmznvAS0; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-24c9f892aeaso1187368fac.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717775971; x=1718380771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NHMt+xVhVtjzNsRDYJ5h2jc+BN/nMBD6W7NvHLgmaM=;
        b=nmznvAS04yaaxDle7fLdSmnrgWW28hcYRKk3T0IqZaYucQfYz3UO9Tm32BGxvENW2F
         xbJ4UbwPPnQoA8ZUyU7d3RlQb3T4L6is24FTY+uz47Zo/Ipi+BYlrjZ/YmL4JIg2uKak
         m+OV629T3A0xIAf6rvUbHvUPEn4m5JZapr9S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775971; x=1718380771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NHMt+xVhVtjzNsRDYJ5h2jc+BN/nMBD6W7NvHLgmaM=;
        b=CnpcVMh93LZJSbqZJRPZ5hCFABrdqnM+Nev4BD/d7UX2tixzHUPJWDKFte1jjxMo6P
         JkT3zPWgrk35HDc5CcE9B/Ctt7F2z9ZKoNPYqUmNJAAT/xFDGt3BECZRLgEiycYCdxJN
         dgfquvKmHmKuMQVEZPMHq57iSc6kYA5KQJm3+QsLfeJ24KNHYkcj7AHy4baG9dEyDyD9
         lIMKolAeIROQiED43prGrBJIjEcxF+DthJr+uZBlbN5OZNWjqn5sLUE+Hm0CvhaYEXNR
         QeI/tMNjM9MkpZLqJi3oUEjXnRjnHiRfanAV3Pl3zas0KLwoC/ce+HoKDcRGEWavxdAf
         8ytQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIvAEZEABtwsq7t9h9qjPoVYhYnxpzQziYf0XhyY7+oaCgAC5A4X2JYMMU2zuZlcbJ/K0UyafPdrWwtDaMmSLKnymBynJaTFKC6Yt5RifQ
X-Gm-Message-State: AOJu0Ywvfk0pQFS1pArqXOoM4hvWRKedzDM1RjUJyEaKFXc3D/isArNk
	feGUUbGo5JOQUNn0lKZpQbjpEqVVgFSLOHj2xhPFkW4z7W6OcFL96Mh7EI2oBSkwsWD69iChDU5
	4az82W2LF09ptPPHX8tVp2ItU6YeXFfMVyPcG
X-Google-Smtp-Source: AGHT+IEC31nw9ObtnGzw3zJl6fKelGiEgC9ZoPCarB7OMc+eN9hRyWGo2K+eWFqjbDdWgwjsJsikOOzysaE0DDaqvi0=
X-Received: by 2002:a05:6870:c687:b0:229:f022:ef83 with SMTP id
 586e51a60fabf-25464684289mr3475878fac.43.1717775971301; Fri, 07 Jun 2024
 08:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-2-jeffxu@google.com>
 <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com> <CALmYWFu61FkbboWkXUSKBGmXeiNtBwrgfizS5kNvPMx4ByUqPQ@mail.gmail.com>
 <b8cGJnU5ofWgsiKD5z8RGlW-2ijs7IW9h4LUg1tzFBu3agFinCvdxuiSaUDG_DfVen2vCDNu-QbGfOR7DeARf4jsy3CNNTfzQGMX1HfqHdo=@protonmail.com>
 <CALmYWFv+Tsqwv96oB4rTrJ7_ZC3CoNZFjmKFYKQgGZuceqZ6vg@mail.gmail.com> <2fQi6XI7TmRN_qi9xldglgYFujpzMvr0bbkxhYNJhY6VRYjDsyTDqavR6OPU6DNBtCKAPgBVKxV0SMo7WnjUaDit-zxsBZauGavgKzqcNy8=@protonmail.com>
In-Reply-To: <2fQi6XI7TmRN_qi9xldglgYFujpzMvr0bbkxhYNJhY6VRYjDsyTDqavR6OPU6DNBtCKAPgBVKxV0SMo7WnjUaDit-zxsBZauGavgKzqcNy8=@protonmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 7 Jun 2024 08:59:20 -0700
Message-ID: <CABi2SkXyHegwpZKF7ZVDAOsqzaHE4BdDQOMmbuJ+51HkQ3CmJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: Jeff Xu <jeffxu@google.com>, David Rheinsberg <david@readahead.eu>, 
	Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com, dmitry.torokhov@gmail.com, 
	Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, jorgelo@chromium.org, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barnab=C3=A1s

On Fri, May 31, 2024 at 11:56=E2=80=AFAM Barnab=C3=A1s P=C5=91cze <pobrn@pr=
otonmail.com> wrote:
>
> 2024. m=C3=A1jus 30., cs=C3=BCt=C3=B6rt=C3=B6k 0:24 keltez=C3=A9ssel, Jef=
f Xu <jeffxu@google.com> =C3=ADrta:
>
> > On Wed, May 29, 2024 at 2:46=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn=
@protonmail.com> wrote:
> > >
> > > Hi
> > >
> > >
> > > 2024. m=C3=A1jus 29., szerda 23:30 keltez=C3=A9ssel, Jeff Xu <jeffxu@=
google.com> =C3=ADrta:
> > >
> > > > Hi David and Barnab=C3=A1s
> > > >
> > > > On Fri, May 24, 2024 at 7:15=E2=80=AFAM David Rheinsberg <david@rea=
dahead.eu> wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> > > > > > From: Jeff Xu <jeffxu@google.com>
> > > > > >
> > > > > > By default, memfd_create() creates a non-sealable MFD, unless t=
he
> > > > > > MFD_ALLOW_SEALING flag is set.
> > > > > >
> > > > > > When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD =
created
> > > > > > with that flag is sealable, even though MFD_ALLOW_SEALING is no=
t set.
> > > > > > This patch changes MFD_NOEXEC_SEAL to be non-sealable by defaul=
t,
> > > > > > unless MFD_ALLOW_SEALING is explicitly set.
> > > > > >
> > > > > > This is a non-backward compatible change. However, as MFD_NOEXE=
C_SEAL
> > > > > > is new, we expect not many applications will rely on the nature=
 of
> > > > > > MFD_NOEXEC_SEAL being sealable. In most cases, the application =
already
> > > > > > sets MFD_ALLOW_SEALING if they need a sealable MFD.
> > > > >
> > > > > This does not really reflect the effort that went into this. Shou=
ldn't this be something along the lines of:
> > > > >
> > > > >     This is a non-backward compatible change. However, MFD_NOEXEC=
_SEAL
> > > > >     was only recently introduced and a codesearch revealed no bre=
aking
> > > > >     users apart from dbus-broker unit-tests (which have a patch p=
ending
> > > > >     and explicitly support this change).
> > > > >
> > > > Actually, I think we might need to hold on to this change. With deb=
ian
> > > > code search, I found more codes that already use MFD_NOEXEC_SEAL
> > > > without MFD_ALLOW_SEALING. e.g. systemd [1], [2] [3]
> > >
> > > Yes, I have looked at those as well, and as far as I could tell,
> > > they are not affected. Have I missed something?
> > >
> > In the example, the MFD was created then passed into somewhere else
> > (safe_fork_full, open_serialization_fd, etc.), the scope and usage of
> > mfd isn't that clear to me, you might have checked all the user cases.
> > In addition, MFD_NOEXEC_SEAL  exists in libc and rust and go lib.  I
> > don't know if debian code search is sufficient to cover enough apps .
> > There is a certain risk.
> >
> > Fundamentally, I'm not convinced that making MFD default-non-sealable
> > has  meaningful benefit, especially when MFD_NOEXEC_SEAL is new.
>
> Certainly, there is always a risk, I did not mean to imply that there isn=
't.
> However, I believe this risk is low enough to at least warrant an attempt=
 at
> eliminating this inconsistency. It can always be reverted if it turns out=
 that
> the effects have been vastly underestimated by me.
>
> So I would still like to see this change merged.
>

The MFD_NOEXEC_SEAL is a new flag, technically, ABI is not broken.
The sysctl vm.memfd_noexec=3D1 or 2, is meant to help
migration/enforcement of MFD_NOEXEC_SEAL, so it will break application
if it is used pre-maturely, that is by-design.

I think the main problem here is lack of documentation, instead of a code b=
ug.
ABI change shouldn't be treated lightly, given the risk, I would like
to keep the API the same and add the documentation instead. I think
that is the best route forward.

Best Regards,
-Jeff



>
> Regards,
> Barnab=C3=A1s P=C5=91cze
>
>
> >
> >
> > >
> > > Regards,
> > > Barnab=C3=A1s
> > >
> > >
> > > >
> > > > I'm not sure if this  will break  more applications not-knowingly t=
hat
> > > > have started relying on MFD_NOEXEC_SEAL being sealable. The feature
> > > > has been out for more than a year.
> > > >
> > > > Would you consider my augments in [4] to make MFD to be sealable by=
 default ?
> > > >
> > > > At this moment, I'm willing to add a document to clarify that
> > > > MFD_NOEXEC_SEAL is sealable by default, and that an app that needs
> > > > non-sealable MFD can  set  SEAL_SEAL.  Because both MFD_NOEXEC_SEAL
> > > > and vm.memfd_noexec are new,  I don't think it breaks the existing
> > > > ABI, and vm.memfd_noexec=3D0 is there for backward compatibility
> > > > reasons. Besides, I honestly think there is little reason that MFD
> > > > needs to be non-sealable by default.  There might be few rare cases=
,
> > > > but the majority of apps don't need that.  On the flip side, the fa=
ct
> > > > that MFD is set up to be sealable by default is a nice bonus for an
> > > > app - it makes it easier for apps to use the sealing feature.
> > > >
> > > > What do you think ?
> > > >
> > > > Thanks
> > > > -Jeff
> > > >
> > > > [1] https://codesearch.debian.net/search?q=3DMFD_NOEXEC_SEAL
> > > > [2] https://codesearch.debian.net/show?file=3Dsystemd_256~rc3-5%2Fs=
rc%2Fhome%2Fhomed-home.c&line=3D1274
> > > > [3] https://sources.debian.org/src/elogind/255.5-1debian1/src/share=
d/serialize.c/?hl=3D558#L558
> > > > [4] https://lore.kernel.org/lkml/CALmYWFuPBEM2DE97mQvB2eEgSO9Dvt=3D=
uO9OewMhGfhGCY66Hbw@mail.gmail.com/
> > > >
> > > >
> > > > > > Additionally, this enhances the useability of  pid namespace sy=
sctl
> > > > > > vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel=
 will
> > > > > > add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> > > > > > MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables th=
e MFD
> > > > > > to be sealable. This means, any application that does not desir=
e this
> > > > > > behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 t=
o
> > > > > > migrate/enforce non-executable MFD. This adjustment ensures tha=
t
> > > > > > applications can anticipate that the sealable characteristic wi=
ll
> > > > > > remain unmodified by vm.memfd_noexec.
> > > > > >
> > > > > > This patch was initially developed by Barnab=C3=A1s P=C5=91cze,=
 and Barnab=C3=A1s
> > > > > > used Debian Code Search and GitHub to try to find potential bre=
akages
> > > > > > and could only find a single one. Dbus-broker's memfd_create() =
wrapper
> > > > > > is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tri=
es to
> > > > > > work around it [1]. This workaround will break. Luckily, this o=
nly
> > > > > > affects the test suite, it does not affect
> > > > > > the normal operations of dbus-broker. There is a PR with a fix[=
2]. In
> > > > > > addition, David Rheinsberg also raised similar fix in [3]
> > > > > >
> > > > > > [1]:
> > > > > > https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b02=
5bc46f267d4a8784cb/src/util/misc.c#L114
> > > > > > [2]: https://github.com/bus1/dbus-broker/pull/366
> > > > > > [3]:
> > > > > > https://lore.kernel.org/lkml/20230714114753.170814-1-david@read=
ahead.eu/
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_E=
XEC")
> > > > > > Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> > > > > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > > > > > Reviewed-by: David Rheinsberg <david@readahead.eu>
> > > > >
> > > > > Looks good! Thanks!
> > > > > David
> > > >

