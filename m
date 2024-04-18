Return-Path: <linux-kselftest+bounces-8353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC958AA0EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CD1C21508
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFE175544;
	Thu, 18 Apr 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCxGt7Ul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D81172BD5
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460758; cv=none; b=qg6HlkP30bRdMbr7CNgLYTgXsCR0poDy5TiM0pzOAV81B3YibLvr4Pn0CAS6BksRTLJg9ltgwXwIwxBSbIB4K2V3Y0plBnWi0PM1dVIpVwNYuPGDuhW5dmQ2Q+Nfn74L0IfBuMdyGKdvLpkRq5a0pMgwZAFb1c8mywQ1K+t/IVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460758; c=relaxed/simple;
	bh=z8deP5JiCX4tE0osRAabfU/ka6kCpJORJ3z3SrfiQSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H101t7yd+6snKH3frTg1s3GdvpMAD6hhnHCHzUfQDc3/tvvfkGoDHcbvYRbKxlzlvvDVzzB8iWbp+xWb/aGaNBAmO6kXdUbN2JEiA45I8CsLOZL4ywKN+RrLovBP2fJJI6OJO9Zxw5Lliykb5HXUl9w8bHHqvNZrSxEgvWeF808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCxGt7Ul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713460754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5bV22Y6v5pDARLpQxuhoUtFKqLzg5Cehfkskiq3Udg=;
	b=ZCxGt7Ul9cKClMCrK7DVBkjd9lsyuJT3QmaXfSgd8N8QtnD8UiliscQoDAkQKKRj5nj+oN
	Fq3fMYKziRoT91KIRUYqgQBlijgj13TxD2c98K45qFBL7DETWfAM0FhViTetzBxsnpb/9/
	z8QO1m0BfVE6kanQIya/Ep+XCovkXcQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ndzi8vS_NBaK4KfF8iLz_w-1; Thu, 18 Apr 2024 13:19:10 -0400
X-MC-Unique: ndzi8vS_NBaK4KfF8iLz_w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43700c117dbso15896181cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 10:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460750; x=1714065550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5bV22Y6v5pDARLpQxuhoUtFKqLzg5Cehfkskiq3Udg=;
        b=uUtXsx5fqifyWaGecW4Xcvw1e/2WLi/1xhzaSU+F2SDVTFiYYo7tKmyHx7YJ0FymxZ
         LBb+8nU7o+PrfT5gLM5VNoaf2EfTfX/SXOOKec56BynhnrfmH3qf2AltZVqxY/LKNH+J
         O2kHB/WtAokDHnAwtaOzEu4zUUUUu894h6AEcuYCWwJx3TUzqN3YK7m3h9ib17HjZqZ1
         8ouxXO9o46wCtlcB7oM1tJ0Fc6jMRTYdp7qXaxsjq7E4kNMwCR5f/CZ8JQKgEUiwLkl7
         GrwWDjZExJiZ9DJQYM9xsATd4jrBdHjH02yJBVtZiPIo/GDnTvSAXuJK/Ia+nOWMk9nx
         3WLA==
X-Forwarded-Encrypted: i=1; AJvYcCWOvMPayAm0HDlRm87jXPSjpG+uO6F+0dPDcyNF/kb6JJPUdbli6o3MVkAKX9zZiMiZgvRilXDC0XWaOeWlGTalbfTUHQBHwXAG4EFICzEu
X-Gm-Message-State: AOJu0YyrsH/uc6zaw6R9BAY17pTN1sEEzBp1YBlBSHVSM+4aqrv6mp8e
	sBEoQS89i3GAFhmDkVilSAulM1KGVyPpjf4BdJrB79MVfOFnttw34mC3QTUo596f5ffw0onHMBK
	eN9UgBGajI+bTnR/OBPk2hsNbu6mau5q3HqXcQotY+mDU+wsq8mZsjiUhE/lda3IAkZ07bkIxhu
	7CxtVSQMnN4yZPJ+03tYwx4PNYFwrzim4FCBuH+2LE
X-Received: by 2002:a05:622a:f:b0:436:ba2a:4aef with SMTP id x15-20020a05622a000f00b00436ba2a4aefmr4004843qtw.52.1713460750349;
        Thu, 18 Apr 2024 10:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKngSjSF6iWF1QhKj/ESh69oayLe4joJMZzFJEgkEVk0tUD3zJIsN6uNqpnXh8+kDRMgV0RR3zJNphOH8wO8g=
X-Received: by 2002:a05:622a:f:b0:436:ba2a:4aef with SMTP id
 x15-20020a05622a000f00b00436ba2a4aefmr4004823qtw.52.1713460750106; Thu, 18
 Apr 2024 10:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418131754.58217-3-wander@redhat.com> <9ff84256-c7d2-48e5-b06b-09a993db2c39@web.de>
In-Reply-To: <9ff84256-c7d2-48e5-b06b-09a993db2c39@web.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 18 Apr 2024 14:18:59 -0300
Message-ID: <CAAq0SUk7nJ80rrMG+zeVi-XReVJ7sdWTAT9fmi4E+LpYAYa=OA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: avoid memory leak on device register error
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:24=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> > If the device register fails, free the allocated memory before
> > returning.
>
> * I suggest to use the word =E2=80=9Cregistration=E2=80=9D (instead of =
=E2=80=9Cregister=E2=80=9D)
>   in the commit message.
>
> * Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?
>
>
> > +++ b/lib/kunit/device.c
> > @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >       err =3D device_register(&kunit_dev->dev);
> >       if (err) {
> >               put_device(&kunit_dev->dev);
> > +             kfree(kunit_dev);
> >               return ERR_PTR(err);
> >       }
>
> Common error handling code can be used instead
> if an additional label would be applied for a corresponding jump target.
>
> How do you think about to increase the application of scope-based resourc=
e management here?
>

I thought about that. But I think the code is simple enough (for now)
to not require an exit label.

> Regards,
> Markus
>


