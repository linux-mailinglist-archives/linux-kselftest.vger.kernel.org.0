Return-Path: <linux-kselftest+bounces-8421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913068AAE74
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A60B2151B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B19A85943;
	Fri, 19 Apr 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQY4dM6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EE85924
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529825; cv=none; b=qTljf4m1iqqCfw33FDv+/PMptb2zC7Wg3665BDW1sphbMTC6SYSjoC71Au2Suq+La/3erPS4r0PWpkvN63fXAiCCJ7QBCPc1vlS5wMu/vvT1Ax8hQiAC941EuLnadPxgY3ZoW963p/ksSPyXfsl6bymEMBu3SFhToE1vEGg/Br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529825; c=relaxed/simple;
	bh=Y0qzuaLHp7jYNZt/yJHBqCPkPqeNLCNBhwMVULVwpAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwckF/BR9b9LVMTCckLQ0oDdVlnN7UTtwwwLNmgaVkYDxasERwDc9pKnj+CYGd2xsKVeDN6nXnwhwpSE9DMIIbeTA1gtA4Tzl6foHLLWURGerOr3OJIWdzorGKz8RYO9zAjoZdVQp2NwVC4wMizHtisn+9izrRk3nOL5EIr5FL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQY4dM6U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713529822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUl9xI+kv1Ecrl0dN5hTZc3O707nonguLWXio7bCIq4=;
	b=CQY4dM6UUDZoSYlqJo3SIHMv74SBqC7wsDOh7MtFaUENNBolYH3rjTFUiSW/SY2nkI7cDy
	XsDFo3tHqEG+1JnzfwXmBezOZrRZatxxppMOk0LKXLOwvTxUlNzVYoE5ZY51GMVYwbLl2I
	mmEOft7sna5xoIkZKlsdBhS7+dZpxaA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-oGoQ057TNSW5KS388vSc7w-1; Fri, 19 Apr 2024 08:30:19 -0400
X-MC-Unique: oGoQ057TNSW5KS388vSc7w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-434e545b504so26912531cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 05:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713529819; x=1714134619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUl9xI+kv1Ecrl0dN5hTZc3O707nonguLWXio7bCIq4=;
        b=XRQrS4KhNdRxkJjZpvvX+QT0MipsPbhiouzWJ7nItGBW7Q6svuryyki52hQ9fE27bH
         12tkhpONVYx6AjJvQmSXlTHeR9AgoTvH+iL9vWDFB9PYEiSFqVeTcwYtyQ+lmtAqvTVs
         BZ61X/42a5b5cR/mDbBFl2RVAt2iJEsDi+Cnk4Itx4bw7N03+bqL7Qpmq+dRApyVPGJG
         Lwt/wP9zSPefqgGml+he9hHocbaXeQTa1fG8JEwXEI9ghk1KlQ4sEbmiI+YRT4FUEiib
         HTWMdTL5GO2RGS94QvtoqMKJvKNEqwnPVXq7lm3e1Lef0+pjTXXQQfws62+yxuVaZdHo
         3SuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV94/xe/oA+yLC+yJygkVO0hy8SRw40KQJmAcp5pbjaprZ9kkQtFBykfeYZa78drmf1i7Ei1GYm98tbcFB0RrmFVGlbbyoNLNNN6BmQpp/E
X-Gm-Message-State: AOJu0YzSRqKJSUgnNDxrTR3loXeMORrBlj7/hqeWSO+1R38mclqmlWxs
	3y/u+RNcAoqGTCWvo4P2pn7NJewNCiGDgjKxWPc0jQJRSYTsw0InLHPwGHtPophBHTieoiiq8EB
	pAhURIhjmkf24k+5uVL0buDHJQ2X6UbYvOcIXCAt0PwrLUmBZRwxmPIVH1hfkkRvBfQVKtOovym
	9yZDksCz5ibCg9l3nFh9opFsdpq7xgYt2R0PBi/eAw
X-Received: by 2002:ac8:58c5:0:b0:436:9fc4:6146 with SMTP id u5-20020ac858c5000000b004369fc46146mr2525513qta.57.1713529819034;
        Fri, 19 Apr 2024 05:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/0gAu1715B7QcJo9RzfxjgsVK4gM72ujbyqIpwdqiQsGOP/u/P3Xa/+8cNacgni8XdO9khMEeRrBNwJnQxNQ=
X-Received: by 2002:ac8:58c5:0:b0:436:9fc4:6146 with SMTP id
 u5-20020ac858c5000000b004369fc46146mr2525485qta.57.1713529818801; Fri, 19 Apr
 2024 05:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418210236.194190-1-wander@redhat.com> <20240418210236.194190-3-wander@redhat.com>
 <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
In-Reply-To: <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 19 Apr 2024 09:30:06 -0300
Message-ID: <CAAq0SUmMdTb5C-SCSD5WPPyj5B1iB6dD5QWuDTsXPnJktFr36g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 1:59=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Fri, 19 Apr 2024 at 05:02, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> >
> > If the device register fails, free the allocated memory before
> > returning.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > ---
>
> Thanks.
>
> I'm not sure this is correct, though... Shouldn't put_device() free this =
for us?
>
> The documentation for device_register() says to never free a device
> after device_register() has been called, even if it fails:
> https://docs.kernel.org/driver-api/infrastructure.html#c.device_register
>
> Or am I missing something?
>

I am not freeing the device object passed to device_register, but its
parent structure.

As a side note, the behavior of device_register() seems
counterintuitive and error-prone, IMO. If the function returns an
error, it should ensure it leaks no resource and shouldn't require the
caller to do any cleanup.

> Cheers,
> -- David
>
>
> >  lib/kunit/device.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > index 25c81ed465fb..bc2e2032e505 100644
> > --- a/lib/kunit/device.c
> > +++ b/lib/kunit/device.c
> > @@ -119,10 +119,8 @@ static struct kunit_device *kunit_device_register_=
internal(struct kunit *test,
> >         kunit_dev->owner =3D test;
> >
> >         err =3D dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name=
);
> > -       if (err) {
> > -               kfree(kunit_dev);
> > -               return ERR_PTR(err);
> > -       }
> > +       if (err)
> > +               goto error;
> >
> >         kunit_dev->dev.release =3D kunit_device_release;
> >         kunit_dev->dev.bus =3D &kunit_bus_type;
> > @@ -131,7 +129,7 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >         err =3D device_register(&kunit_dev->dev);
> >         if (err) {
> >                 put_device(&kunit_dev->dev);
> > -               return ERR_PTR(err);
> > +               goto error;
> >         }
> >
> >         kunit_dev->dev.dma_mask =3D &kunit_dev->dev.coherent_dma_mask;
> > @@ -140,6 +138,9 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >         kunit_add_action(test, device_unregister_wrapper, &kunit_dev->d=
ev);
> >
> >         return kunit_dev;
> > +error:
> > +       kfree(kunit_dev);
> > +       return ERR_PTR(err);
> >  }
> >
> >  /*
> > --
> > 2.44.0
> >


