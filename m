Return-Path: <linux-kselftest+bounces-48461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65636D009BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE42A3001FE5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9A227B94;
	Thu,  8 Jan 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQUi1qwK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmLMkHKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67A2264A9
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838215; cv=none; b=OgvhbpXCyj3KNTFgbFyydWiQzatuM/fY5FjhZQrnP/PhEsD2fjIk3KXehbq4ZGFTGlmDuG7ye9QTR6d0ogrzzSD61o5w75KJS4uUGTkanbShvGUsKS3zkJ8WG05AgLGHqhY0AetzxU7NQkNRoRGTAeOWaSkTUdimp5uBdI49C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838215; c=relaxed/simple;
	bh=kUnR9HX7lQUF5BwVYBBEbR1+bdzDdJhHY5QWbcNrgW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvZrGBCGPDnf7HsF61FlEs/Ur2FJtdfQBZ4BpeJiJ9y1ro0uynkq2f3NlQnlYgZF92CEXrBdgIB48kSlQqXXP3Mf4KCFh8zjBXztJ9boG4RjDmLIgeyUk3FDS75zcXB+szcZtsS6x+UqT0tlZO6/ZRVdSX+EB3jc4wISPmMNKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQUi1qwK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmLMkHKw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767838213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbKKq3eWOpnN64kmqoe2MLI8jKxuF4NAAyTLOPJCk1c=;
	b=CQUi1qwKM4sXN1Z8ApAKb4OvPUuvldw0WKEtGQJDRvmhBJpDHPl2irAu834Bw1l4Kkty2n
	aZYbJpNp/i+f6iPs3Fd7jhf+eMc56SpijMhBmLxMSZ/o6ZyLrDvBJbHlGabjYiXDPhkQn2
	LeiyBB8TQGa3+bAoVcv+pz9K7Ag/KeI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571--WxSBjkhO6ulTbY-sskdgA-1; Wed, 07 Jan 2026 21:10:11 -0500
X-MC-Unique: -WxSBjkhO6ulTbY-sskdgA-1
X-Mimecast-MFC-AGG-ID: -WxSBjkhO6ulTbY-sskdgA_1767838210
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b841fc79f3eso263159766b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 18:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767838210; x=1768443010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbKKq3eWOpnN64kmqoe2MLI8jKxuF4NAAyTLOPJCk1c=;
        b=EmLMkHKwb+chszaAXcv6XenU2lzvDyk86fkconPORvF7M0Sg5xcWHBu+F7KIYCjXtL
         Hj9ttu/Y97+H8d0yAnT6RyoIDMKZyMVFQ2dbvnbbwCcJy45gP+IbEEYqCnxJGFQnSzFi
         izbE7M6NopdSRdnoDIWxdaRs49L8erEPjKyuuMUHWFa517XI2zfyQLbI8yH+b3HRfmIL
         iqdtwYAaHxcuvtTwrFAWWCCjvRhV+KMonrrjngc0I7/9HS6iFO4GkfKfzAjnf/p0DzxK
         RLdp1RLlEOOUOQhw0sZTMFJzWMD/RAzS36YoYcD1LY7Dh72ATUUP/j6FgvtTl4rYio+2
         s9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767838210; x=1768443010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbKKq3eWOpnN64kmqoe2MLI8jKxuF4NAAyTLOPJCk1c=;
        b=UIJBheW58k7+iuXNv3bkWFksryP1yCIIXNmcqNcs+AKCup/ab7RkHIn5q5MFqJ1Gz4
         v6BDQbUX/VHxC15Zpk0fIUzKWO85pywSoPXHFuLhjRtSoPclesN8FR4bvSz8sFxIwOLO
         z/G87nSO2XbQ90yU/OqvtFon5tqSMki2jy8FbcwC8YBgf3Lx78F90R7DQRGORCycXthh
         VA9jzj0o/quwPUzeNA77+9/Iw3+4tDR6VKz386NXwzssuLjz/85HdsLbxdzIQzUsI3ag
         0oZUl2axU0ZCczd3IOkBIZnXvJUssddW0hEEwnAAjAWzrT2vucy+Y/fYgFDHYk9/V19H
         jqMA==
X-Forwarded-Encrypted: i=1; AJvYcCWsLeh+IfpWbM+qNroCCCbaYuDuXIzJqFQU0n3hTecnJIXA5j6noG+jGZYJ7LK6tN8Hltw3QhNLJWoXLcnTIUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUCs7S9o7kJCLaDKGBxqErndOK9iYCGY4YO+2An89dIYxwKaX
	kpmLeXiRG6M6gYneuRnZFEKn++ejywDiJFH5UYs6SLOjIk7PjKW+6dNBcpb4zWVAHLFHVOJvFbV
	JEkvDqjDUCluXJVifnMQ/HBginOStmNPElWlOYndXWQ62yivXoceCtaPtE1tVj3rtrekkAUyzMZ
	kXaZDaHEEv+z6BExujuzaExYPyDOxRXzg3gmy2dVjj6nNCNnHa6LCgbr0HeD36
X-Gm-Gg: AY/fxX4BlSkx+7BJdEb+gTO3yHllJ5ucus+2fqOzWeMTMbHNPxur2Q+huqS6B9ZV+12
	NyVGNOhrzFupgsCxtq5mPf7gwyJukiJpNCWUzJqQEI92DE6oNrnLxb/5kFTVa9/+TKqxVDbPTuB
	dqRdNStPFlP3poUfyCY7l8/wEBhpodAvM9DEWkXqpvHyhS3pRaeIIjnanMWufkirHpNEI=
X-Received: by 2002:a17:907:78b:b0:b83:15cb:d4cf with SMTP id a640c23a62f3a-b84451de1d5mr379482466b.29.1767838209696;
        Wed, 07 Jan 2026 18:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiLXyXs4mwJJvyTOueFeBS6umsNPGhSgTwLnU3w460hH3uJovgWV/0G4cRKqUFXnHXvK4EuWnp7J/QtTQ4YTk=
X-Received: by 2002:a17:907:78b:b0:b83:15cb:d4cf with SMTP id
 a640c23a62f3a-b84451de1d5mr379481466b.29.1767838209270; Wed, 07 Jan 2026
 18:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767597114.git.xudu@redhat.com> <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
 <20260106145822.3cd9b317@kernel.org> <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
 <willemdebruijn.kernel.24d5d52e43030@gmail.com>
In-Reply-To: <willemdebruijn.kernel.24d5d52e43030@gmail.com>
From: Xu Du <xudu@redhat.com>
Date: Thu, 8 Jan 2026 10:09:58 +0800
X-Gm-Features: AQt7F2pWAqMWev0KJxABViGC51S0adN36dKHz2g-w5Tu3XLOWV45XqO5Up36Tfg
Message-ID: <CAA92Kxmdcc01B0p8jK3JM-ot+LzdnCwS8utAtFe7bBg1ymqT5w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:59=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Xu Du wrote:
> > On Wed, Jan 7, 2026 at 6:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Tue, 06 Jan 2026 17:14:05 -0500 Willem de Bruijn wrote:
> > > > For instance, can the new netlink code be replaced by YNL, whether =
in
> > > > C or called from a script?
> > >
> > > +1 looks like YNL is already used in net/ tests, and it supports
> > > the operations in question, so that's a much better direction.
> > > Please let us (YNL maintainers) know if there's anything missing
> > > or not working, IDK how much use the rtnetlink support in YNL is
> > > getting.
> > >
> >
> > Thank you for the suggestion. I am looking into replacing the netlink
> > with YNL to reduce code. But after reviewing rt-link.rst, I found that
> > rt-link currently lacks support for VXLAN. Would more significant chang=
es
> >  to the patch be acceptable if I switch to Geneve to leverage YNL?
>
> These are only changes to the new code in your series. SGTM. I assume
> it is not a significant burden as the two are fairly similar. Is that
> correct?
>
> Eventually it may be nice to have VXLAN support in YNL akin to Geneve
> support. But sounds like a separate goal.
>

I think it is not a significant burden. I will perform some internal
testing first.

--=20


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China


