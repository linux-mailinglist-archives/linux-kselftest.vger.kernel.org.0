Return-Path: <linux-kselftest+bounces-48295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1ACF88BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7B4E305C41C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F53019D9;
	Tue,  6 Jan 2026 13:36:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602E330B2C
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706600; cv=none; b=qjaE8hnZcGRoDHWJEU1wUjIFJgm0uVROztgi63lxtecoar04bSPxBrKmOWXC+fnDFHP+rOrEsxroURq6aghpkWKYcdC6mye6hDz2xSXR/Rp+UpfzhCdk3g7N8ofei0Wl7lJWV2GjYNYV2Icdn7NOlAOo2Q6vwPpAYRWDTmZSAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706600; c=relaxed/simple;
	bh=vQumBeeEW44awTrAa1QUTaUHf4TNO2iFQKtwj6+mFSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knMYZIxP4QHpoDmPgE+M/2/a1QrmIHgUKCKHpHNo3+gEaP4U5ETMaCajoumC1fXRQuDzWE5wHix+lPPrPwKFUplziedXf6f5NmtUqfI8dPyilwB+xA9NgQde2HkMdmexwInci7uFVMm3J1Ze2/ugKHFWV8SNyZW9JOeOvehxN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-55ad466ad1eso315515e0c.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 05:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767706596; x=1768311396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ISLrZTYAWhGv2xePnJzG+mEl6aBTj3DjpPZi0mImgk=;
        b=doFwFgqQ4wKjIyLnx1vneHqQDwz2DCTlXAgIs7YXe+f7eAprln6Da0RqkJLOHsbT3B
         70H38kNn6bxQjHkrNeLSuroC3QZkYiQX9kRIsQvlVip9VvNV7ItqdO7cb73tmHkHY+Qc
         UEWB8/eygsOvPpE7JLUZ4lzyyXGUVpje//e2hv7bHtj0B58QgJ8AhMnPlaixl4fpeGqX
         eNPmFRoLvJMnO6zjNJjqK/AtC1L9D4qMcumM1A1YtnaxEZEJtDoxwmCqDYy05cnebu+t
         gxxBT2D98psBFmKkg8odYHj5VKEWmElqzDpFFFaSFCivSIRY+KakzMkqSA5KvPYchtXA
         lduw==
X-Forwarded-Encrypted: i=1; AJvYcCX5snDuAoDuJ7GuYGakOr001qcUdBWdEIV1NkpLebQhQErjrRSxhwW06DFdF+AJlrmdJwzPivPFHHaikjI1J0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydVU/Jc3PhXbGdkBkaYm4l7bJo+HE124fCSjU5fkS6sUqM5+w
	dPCJbNzrfFMbv00Y1lh8eIkEIn0zJT/kt65HfgPZ4s6IKiuLgddfBtGZ2x8LNKwJ
X-Gm-Gg: AY/fxX5q4JFXqnxmpwdFXvyYnHu0RSeP73ejXogiD/XSU1jSEVGlzkyaQzO9vDynRtZ
	Gl0nFYAM43pQjlP7cYwsFYmBTszGnRh0UDj5zJIodRNSkdzdbSNn/VcRsm98qJR5x/ot9k30WfF
	aIT2oyFQ3HQ2dRe1sF9fnox6JEGBY0JLLfMM/2l8AzRq7jvS5CAoWkEeUwSobdk7/8i3HotBXQu
	Eav2FI21EJPFoAcE/aJZwJAorW1lFnjtYB9iFORDKLMyG9BAeg7oPtDtDX+mVR3lH0GMahOGRO9
	zOvRzP2EKVx3+bs1OJnyrgatD3rdSbmWgfo9dDwg9uA3w4vr6jEvqLG3nQrWf/kPrQG/ZUHqEoN
	6rfA18EzkjGhoymOvKhXTNV4XpRcSNnPWup1JvVYEvgsjeUtwp4aObIL1CmpAcdXn2xeaRzGVVh
	6BFenbgeiVI63kybjZg/V4i3TI0f2UvcpJQavqqNHfI61T4hupj5oaplOjZDA=
X-Google-Smtp-Source: AGHT+IHBXaKPBtnmF5JsNWqbLZP2R5Fh2IzXQSdISrYy0hFsiOaSA6Aj0loKW51wxz4O3bezoRkaRw==
X-Received: by 2002:a05:6122:903:b0:54a:a048:45a4 with SMTP id 71dfb90a1353d-563395db965mr864062e0c.16.1767706596242;
        Tue, 06 Jan 2026 05:36:36 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a3f78d8sm637759e0c.10.2026.01.06.05.36.35
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 05:36:36 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5e5697a2cfcso316069137.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 05:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWb0tgmO9+RaeD7Ir+EAKMoOSucvn6aPy1xJ0nrW1NC0JOjmwqTkyusbDYHl4ZUzmJExwHzm76ecS/Qu6EZFzg=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec6:b0:5db:ca19:f02f with SMTP id
 ada2fe7eead31-5ec74329ce6mr780322137.9.1767706595615; Tue, 06 Jan 2026
 05:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
 <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com> <18bb48f2-b5aa-42a6-bc09-4773e1907670@t-8ch.de>
In-Reply-To: <18bb48f2-b5aa-42a6-bc09-4773e1907670@t-8ch.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 14:36:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBs5nGWEyvu7F+kWB4dMwEOvtqzdYnT+NE3YtU48udwg@mail.gmail.com>
X-Gm-Features: AQt7F2pS2zEMJSSrw-f5_D2VtdljWRNLfuOj3aeGQfVfg5zt8yanPcwyDoySzGY
Message-ID: <CAMuHMdWBs5nGWEyvu7F+kWB4dMwEOvtqzdYnT+NE3YtU48udwg@mail.gmail.com>
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, 6 Jan 2026 at 12:47, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> w=
rote:
> On 2026-01-06 12:40:12+0100, Geert Uytterhoeven wrote:
> > On Sun, 4 Jan 2026 at 23:14, Thomas Wei=C3=9Fschuh <linux@weissschuh.ne=
t> wrote:
>
> (...)
>
> > > --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> > > +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> > > @@ -117,7 +117,7 @@ DEFCONFIG_riscv32    =3D rv32_defconfig
> > >  DEFCONFIG_riscv64    =3D defconfig
> > >  DEFCONFIG_s390x      =3D defconfig
> > >  DEFCONFIG_loongarch  =3D defconfig
> > > -DEFCONFIG_sparc32    =3D sparc32_defconfig
> > > +DEFCONFIG_sparc32    =3D sparc64_defconfig
> >
> > How can we test sparc32 using a 64-bit kernel?
>
> CONFIG_COMPAT=3Dy

FWIW, testing 32-bit userland on a 64-bit kernel is something completely
different...

> Please note that this changed in (the now committed) v2 anyways:
> https://lore.kernel.org/lkml/20260106-nolibc-sparc32-fix-v2-1-7c5cd6b175c=
2@weissschuh.net/

Sorry, I hadn't noticed the newer version, as the latter does not
include some keywords to trigger my interest ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

