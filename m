Return-Path: <linux-kselftest+bounces-23035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA839E94D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2487281F5C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F2228CA0;
	Mon,  9 Dec 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA0xvu90"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03C2163B5;
	Mon,  9 Dec 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748702; cv=none; b=h8ZtuCVpWI1pxPWhRy3a8TQp8I5IxJviSiZCwzH7254W/rqNwJuTBQV0bugepnKjcPw/sY2x4SysqmOMW2Pvt/fPJB8ZiBBjp32GXdRSEogiSCF1rDBu3Ui+SbEd9abZQ+uN9O1YezOVqfVvG7FFYIL8HGaxA0rKHNqy4xbpLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748702; c=relaxed/simple;
	bh=7uMdlMbeAMotNjKM62Hjf14TnIvJ+lF0stexCijYJS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrfZX0N/hgRkGb5cQS7oLaIyPrkHPziKrwl2QbLWEvF7zWnkgWzHyKNqYyIm1SUYS6HgOjafTIMBLJsfpkeYTByl+gEgI47YSQdKR4yDa+NWfD8QONSDtoi98nVsTQp0HUGcab/BZJ0/8PplsO7PEkznAfL+hVMsl7X4eYRav4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA0xvu90; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d74363cbso3776709a12.2;
        Mon, 09 Dec 2024 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733748699; x=1734353499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0pYVI0rIMt/vUsXuEhU3q6EMT1SoyXTaXNYDyXxI18=;
        b=iA0xvu90QFl4W7iYDq12VS9BdBsPaPHhtTDDjbdCgSfzydZVCSG2OY1O1GDkE4lm9S
         RRqiaDnIxGXYpZ8qisoydW0XeajFEzYCG1lPAVcIrZFkmCPbZA+i3wUUoDtQ9noGBaM9
         P7p5P2NorFNcKUc7DeNW/YinU/ZaqefoGfEWzpuA1YoOakmIiGoo1DHqU4SF/opm30Sz
         YzBANHqLhoSd3vyXR8WZ/IqJ8U72+0vsB5Jcigf7M5W7yJnu9HRhrbOF0YTfIk0n0W7t
         YaHglxnOSj4sSkaxJrEVCxD79dOuCHwU9Av4S2U/r0kKoO2T3X42SKYNp//zaEz2E3WN
         TaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733748699; x=1734353499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0pYVI0rIMt/vUsXuEhU3q6EMT1SoyXTaXNYDyXxI18=;
        b=POHvzxdERjPLftw7PZRg8Rh5jdgq+7Z03d1LGdpYHWe4E6QoEOppPPIzOsw0zttmvu
         spmd/mE67Bl6FrAMMmpErbP7vpgDfZNzvxXXoJUD/bCY7fIqqAxVeXBnY6hsxbUsBPMF
         cbQbx4a8ELDoCmsAWdWmMiMf7N17CmsdpQVtqsI1ZzJPovVIcpTABLxaq+vaPnip9vcP
         w3pe4wmpifuyq/+01Ja5iP6Hp+qdZwmuPrJo0IDoF83jHbTnbYIwQ0vOCd9RgG/KGd25
         D+Zg6RFg+lZxon0dvMZ5akh5VdCSpdcc1r6GrpQN8g7jXwDw512kvosNbGC8HR97oAl2
         0OaA==
X-Forwarded-Encrypted: i=1; AJvYcCWgEriw+RMsAQHdP3Uw+/taKE1i/M/w3n3hAtdJrJDcUggRBUgqW9DB8+QzkUSnWN5KpnD7Cfv4FREaEhOFaLz5@vger.kernel.org, AJvYcCXw3JKHSAwDBA9NpHQcDcMhi1oS7eeoVyh1nzhXplfXBKmP2ONG+EMzu9ngCY4M1v0Oc6lJp+uYIy2OGUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvTIOFEhjoB+x+9NBvSAkM+udmfg9WppdfU7SgvOEPCwyjPnx
	aHxhlN+8m+B1qjHZOM5DD8mRWGU74ZqULcSUiv5LSUkf1jzXi1AZ6U/IaxZeEecBXZMNpt1Of0Y
	NRZSUumq6FuWgdCA0zP4DH39ouLA=
X-Gm-Gg: ASbGncvWGWe49ES2qS8D+jebTZUo6UrWiMW9qL7NabTGs/gKe4bI/d9Tdc6JbjyXsUU
	ncZt8dHj03227UV3ndCcvUW6zLuAaPvVc9elBCrlzXDc9DnrDMhz66jF7vsbNWTd0
X-Google-Smtp-Source: AGHT+IExZsuV9qZ60jM3CNxwtfATwtZMmIJq3uoo8pM6xbqf0trkd4ZMavUYr+ponHmxavZhf+YgUtsJjOzCmMrNzZU=
X-Received: by 2002:a05:6402:2689:b0:5cf:e894:8de9 with SMTP id
 4fb4d7f45d1cf-5d4184f7b02mr641635a12.3.1733748699088; Mon, 09 Dec 2024
 04:51:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209105237.10498-1-o451686892@gmail.com> <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
In-Reply-To: <3279e669-1ee2-4792-9e10-8b40928de6b4@sirena.org.uk>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 9 Dec 2024 20:51:28 +0800
Message-ID: <CAHk0Hov5k37=MtTBLWTj+Dwm4EXE0xGJS1Uc8xgyLtJxusqsww@mail.gmail.com>
Subject: Re: [PATCH] kselftest/arm64: abi: fix SVCR detection
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Dec 09, 2024 at 06:52:37PM +0800, Weizhao Ouyang wrote:
>
> > When using svcr_in to check ZA and Streaming Mode, we should make sure
> > that the value in x2 is correct, otherwise it may trigger an Illegal
> > instruction if FEAT_SVE and !FEAT_SME.
>
> >       // Set SVCR if we're doing SME
> > -     cbz     x1, 1f
> >       adrp    x2, svcr_in
> >       ldr     x2, [x2, :lo12:svcr_in]
> > +     cbz     x1, 1f
> >       msr     S3_3_C4_C2_2, x2
>
> This is against an older verison of the code so wouldn't apply now.
> It's not also checking the value of SVCR, this is checking the SME flag
> passed in via x1.  You can see that the SVCR value is loaded into x2 but
> the check is against x1.

Hi Mark,

This patch aims to fix the second check (SVCR_ZA_SHIFT) instead of
the first one (the x1 SME flag you're referring to):

// Load ZA and ZT0 if enabled - uses x12 as scratch due to SME LDR
tbz x2, #SVCR_ZA_SHIFT, 1f
mov w12, #0
ldr x2, =3Dza_in
2: _ldr_za 12, 2

If SME disabled, x2 will not have an expected value.

BR,
Weizhao

