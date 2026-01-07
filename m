Return-Path: <linux-kselftest+bounces-48404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00164CFE6F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD46D30069A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F235CBDD;
	Wed,  7 Jan 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMYUCLYq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F6329C56
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797980; cv=none; b=ELEi8hAwonkqPchc36W6PcliyMZ871n5Y2EJosg9sXCRw15ldj44L+Wwz6Nn+NwPBgcNveeHjoaCfAB0gaKyExwdIE3+nskzUrWbSyZgjWqaycJquCITEFr10NVSwP5c16MIbutQBZHsJWqMEHPAJ91d5WZdCd9g8vc/QjYAhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797980; c=relaxed/simple;
	bh=/g+VPdf5RLxM3FpCwylvaiin4nBnMP86FjrQ2QeZu2c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R+kddu12XYVwyoDFCiONFHLKyJZ5USK7lLurJ1UlWOvXFL7im83uJMeGl37ajmNlRYAmQ9aFXQi7CvkQJvvnfI7+mI+c3Zih2D09xf3qeJ6MURmLZ/8EdPcYPxEQ5IGpyYX56tG2B6OBowSrWYDzROIfOTsLHCU2X1iEXdCcyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMYUCLYq; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64455a2a096so1818293d50.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767797977; x=1768402777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygEsBMOtQfOnd+ceAekCXMasHvVQy7UNaDcAc1PawvA=;
        b=YMYUCLYq2dJWMCKoC+oWjv27yM2iCKeBsMMNIcYPVJ9aPbwlMM8WtvDtWj38GIOR7M
         xIXoIb+anvUvL1HInj6BrdYuCF5TcEZ83PRLVED0/wPj8vrvYRE9dIWIUi+I5gXJ7wNJ
         AViT+KEm/wB9VJrs+ov9E65HzNnRdlQ+og0eR2x7lyu8sqQL3yBzaUrIHb1r616fPO7x
         oPDtFodb8sG1ZMTR1ERrrCuDDcGwr5h8NbNd2EFfakTSmajcIGGzWdIQ+e49NsF5kDel
         9V8DXIIZVW1I+Dc2SGMPmO/uVJh8W8wGn+5gq8Rs8rMYPHfyt6KshxnKAgIs91C1d4d2
         LJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797977; x=1768402777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygEsBMOtQfOnd+ceAekCXMasHvVQy7UNaDcAc1PawvA=;
        b=fJD2E6/j2AnqII8FrHOL0poiZOl5O7dy0DSt+WHiOZrEGrhCBAQ7yM6iqQ40z0T9E9
         Rvm4U0oRCNJFdS825enecB16ysoXgPW+DkLizqzM4lRFNdKNVzm6KG/uB3XscYH4Powv
         Vz5IzEbdp7NKJTCOewC0dXnQez4lfDLFpjj4iJUReytTivPnSLxP5eWxXYYg+xSMtBlW
         S6yJ6Ac8k9DNgyeX1jw/WWJV6ZKBjYP7vl2DREpIWaiKr/9//Mf89KOeUue67UXBuXYk
         Gd11fFpVgrPQIwM9vrfSlUjAn0n/Q7q33dxPTOCBUxtL8llpOSy2rCv2hDzZ5qmoLda1
         5WRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBOXWFZ5/sSDBlDLnLzoXYIpGj7bDbOnjSOMnlrz0rD55SI0Cr9/R8waO9nBvTcROEljSQT03va9diwYzPbkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXLXEozS6XMGzUDAAT+F6okcdXyFQtsmLOo0XHPLKP9qypKtI
	KQFyvOjAEVtQuPEjx2I3omsv2MFtvTnuqRI31YUl2ZtFgq80MWXz4ZqK
X-Gm-Gg: AY/fxX74JBi7mzBpJI94C2SXrT6jz6ElTS+SVJfmDc2NdldIJOyhUtqdgnr1EcV19sR
	o1qEB6CZDOS+utbXbMgkEwdK0fjBnny6HURreKrkbCICAsVOBqnNAEEjJqAUJe1qMnvCXacHio6
	aLB6Z0CRb/waHdakVOpE/1scSXm+AYHYvOfjpeyNLWg/ciWUYkCkwlHYWkTo1OoOqi/N79euUL1
	YvCYI3heplFopnLV2J9YhrdSKdSRjLJCH9itTchHdskuCyDjbySAXwKLY+Af4887hCYGTmDI2fx
	YxReWyEqZzc00wr+pZwpNrLwqUxiTzQJPvktKKLPwpUNzl3OSUQtuDwUf32XFzdPSjxCIlUFqSD
	g9O0KbuUbx5fRqDJoO8ug//sMlW74e3SzyStTFh9iThT0MEoRX4nCVwZzAXCar1DvN9SR7WOoiB
	9v7x48Yl7QN6a9Ae1NnA8zFfMkgl5KPrLGfwGY3e21A/xezltpOf8Wjp4+fS4=
X-Google-Smtp-Source: AGHT+IHGckZa869lQuPtJPN6tXowxLF91dFKwcfoBAPflAsajZxCtT4RbtUWJmXlz8CVoUJtC1vKmA==
X-Received: by 2002:a05:690c:315:b0:789:3166:25a7 with SMTP id 00721157ae682-790b5828b28mr57702757b3.46.1767797977574;
        Wed, 07 Jan 2026 06:59:37 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa553750sm19318617b3.9.2026.01.07.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:59:37 -0800 (PST)
Date: Wed, 07 Jan 2026 09:59:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xu Du <xudu@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24d5d52e43030@gmail.com>
In-Reply-To: <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
References: <cover.1767597114.git.xudu@redhat.com>
 <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
 <20260106145822.3cd9b317@kernel.org>
 <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Du wrote:
> On Wed, Jan 7, 2026 at 6:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Tue, 06 Jan 2026 17:14:05 -0500 Willem de Bruijn wrote:
> > > For instance, can the new netlink code be replaced by YNL, whether =
in
> > > C or called from a script?
> >
> > +1 looks like YNL is already used in net/ tests, and it supports
> > the operations in question, so that's a much better direction.
> > Please let us (YNL maintainers) know if there's anything missing
> > or not working, IDK how much use the rtnetlink support in YNL is
> > getting.
> >
> =

> Thank you for the suggestion. I am looking into replacing the netlink
> with YNL to reduce code. But after reviewing rt-link.rst, I found that
> rt-link currently lacks support for VXLAN. Would more significant chang=
es
>  to the patch be acceptable if I switch to Geneve to leverage YNL?

These are only changes to the new code in your series. SGTM. I assume
it is not a significant burden as the two are fairly similar. Is that
correct?

Eventually it may be nice to have VXLAN support in YNL akin to Geneve
support. But sounds like a separate goal.

