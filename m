Return-Path: <linux-kselftest+bounces-41390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DEFB54FF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE941D61421
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79130EF70;
	Fri, 12 Sep 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Kin5uA9V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFEE3009F8
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684802; cv=none; b=H5xhKpnIAtjjsc6aG+mbZVqTgwycNCRNuP3m5vL+5Yuk2JK0m3z2JXBN+/rgvMg1gU/gGmp/CqrAVTmk0cTaQJPS8qRVCGDzfdAU1EXspEK7k/v1aPOEl9DmN30HYlHyudpRlzpj0rLf21OEqEry8r5q9YVHrKVZQ7waCO6vZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684802; c=relaxed/simple;
	bh=v4JtY9vSL/ymUzoCEJf8PMANI/JiqvGzFXWGWHS7MS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtlN9hcVMdAJpb2Iupt2dQCqdNjnhBXYXvesdAPtE26HAvQObh/yBsKMhClm+76v+V1FPGyrriLpMamDEdJl/hTo9aXa17zLhIPX5/OgacxdsQqNE19YMZniUHzzpB938PL3KMZILmGVEB7c1LX3fMxMSBsDjIF0LCJMMy3HenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Kin5uA9V; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-337e714b3b4so15557071fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757684799; x=1758289599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4JtY9vSL/ymUzoCEJf8PMANI/JiqvGzFXWGWHS7MS0=;
        b=Kin5uA9VaG3pa35slgeqtL0t/NXMDxDV8wuuizb0JMZlJPfH2iZuQwUIVN4myJab34
         MCx9MEYrkB1WOAfBEDEiqz/0/LImTP5gjG8L6S7C8GqvBk9ybUkCnOJryfegB3YbESAq
         ucwFXVERQZ0X8SXb0xwRzKdtvajMxpqxFnBoYA6NRMRWZw2K2PfAve9HEESXntHvMlqb
         gi2u3bkLls4cfTSMW5RKMiLpmreLTPTObakV+KaxLVmu5siEWUH6TVJzJbYf3uDvBDeY
         dZo7fN9gsMxJOFXu7qRD+5bLt0OOB6YPEwivKfC65rfjLbZpgiQttLEeLqfjEv6i+9sY
         zsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684799; x=1758289599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4JtY9vSL/ymUzoCEJf8PMANI/JiqvGzFXWGWHS7MS0=;
        b=Lia0vqGHhNJJQZDs0TFwDPAxeJzfNcxD6jFa8EjBeDNPs3tTqgPkIhC3wxMC2f82DY
         OX2/RyCvNHJX0VWyMNIwOSW6mVTWJU8+Rp5mZlLIqe5dif3+aIMDE6J17z4InW5H6PrL
         +LeDW/wrwQDuEnlXYtl9I9MGG2VEbiq2N2DYP7NxlRTenRFx0IUBSE4P1bSLav5eWeMU
         QldB9gFOXPnZyuNekqJOsPhjAK5pzUcpYlvDYr8YwczneNp1P5T5ZBLRnpcTMv2ZcNXI
         SFtCLa1Hvu8Hzm0KWFWrhIuJFLeInCqDzZ6rW0VDu5hyBZSj45hCeqtXDmit1CpF32TO
         ++dg==
X-Forwarded-Encrypted: i=1; AJvYcCXTHtzcpWRZ1jjtQqRxBUbqpRQaLxJtuEtZINH1HKr9b83L+wRPQ6TSrGAGU7VcCc/SnaND17/gxR235gPnxaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ykDSGVcN5iKGCz3CdmCxUtgSAYA1jo7FXAW0uKk3Ba5zCyLQ
	Wu7YJwJrmxKJ/GrzJ4Hp11dmMa34RDmInPdbSAmgwFh42Yb5IcDRLNcx0vCrrbjpRyAOKR6TSJf
	BwVxQOPLpFqax3dz9UDX+DyKsFB517YaGRuMVylda8A==
X-Gm-Gg: ASbGncsyaySt5gvk5sxRHBNUDv3wPVc2L/L6s2UHgzNWoKUdlZ9Ms4rjloWp1XAYDqW
	j5ZJ4Y33b8RYLbiywXYi5juI/wyMOOwZC7VXnEAaHH3wouQS/Pkdu7nWX3oGaHstvmpESyyLm2Z
	HVmorGmG4iZNg9IV6M8V+Wr0IzobpPGzwJV8FyZNxAyWWY7GEoOS29HwHtUZPy4dhd+EnuYPYB4
	O/hopiCi+m5Z8ulSi9sXohkEJVKKHXReg9mmg==
X-Google-Smtp-Source: AGHT+IGl0c5/zhdOHSETmwuPRA4tqW6HoSSHPDwaRkjQJteW3bfz+plrHfEmjYRmQh9olW2s5Fl6FKUzor1dOfUjNsc=
X-Received: by 2002:a05:651c:198a:b0:336:e46c:5eea with SMTP id
 38308e7fff4ca-3513ecc4932mr8562981fa.31.1757684799188; Fri, 12 Sep 2025
 06:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912081718.3827390-1-tzungbi@kernel.org> <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop> <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
In-Reply-To: <2025091209-curfew-safari-f6e0@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Sep 2025 15:46:27 +0200
X-Gm-Features: Ac12FXyIDSy-eYKyNqWjJQnokOfxXk3HAMgS7Hxbag5ilFR-3-M21SM8Ndw8aGw
Message-ID: <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Benson Leung <bleung@chromium.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I have no objection moving this to the cdev api, BUT given that 'struct
> cdev' is embedded everywhere, I don't think it's going to be a simple
> task, but rather have to be done one-driver-at-a-time like the patch in
> this series does it.
>

I don't think cdev is the right place for this as user-space keeping a
reference to a file-descriptor whose "backend" disappeared is not the
only possible problem. We can easily create a use-case of a USB I2C
expander being used by some in-kernel consumer and then unplugged.
This has nothing to do with the character device. I believe the
sub-system level is the right place for this and every driver
subsystem would have to integrate it separately, taking its various
quirks into account.

Bartosz

