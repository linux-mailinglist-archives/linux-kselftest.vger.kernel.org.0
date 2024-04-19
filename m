Return-Path: <linux-kselftest+bounces-8433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A128AB074
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0965B26E88
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEBC12E1FE;
	Fri, 19 Apr 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epn20zBx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80712BEA0
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535908; cv=none; b=GA4W4aWb0g9DEZ1qTqmRxFV6R/XKJHM1qkavAElNr9hY+ke/vGBNojGXF5Z7/M5q8h4Sl1jaXM3ChKMLpGOweawrC+ZMcF3ujU3IsDurM3xPJeIkr5271s/zOfzsnoDHzil9iDV80LUN4DvqqdyfYu2shYQw3s7z5VRCfg8U3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535908; c=relaxed/simple;
	bh=qBW9kC20d2MgXPK0K7PyE29H/AqaKDpOJmt3FajduGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfaRKdeXRGK7xh48WKfjG2NFDtvINbd1JWXceM34HJZU+11OQjEufCPe0wfrup3lASCbX/5OQ8xF2DgJorbqvo3zGJUS3f89jai22AeoyFASTUY5Z5ofrMurnDWpYv+dtl6BQAoiwdX6FNAbW8bU815Nl4yckn2kPTrK/blqijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epn20zBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713535904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veCFJ5s5nwQXNCbj3LY7veh9fp5tYNFk3WMUGDvs+DQ=;
	b=epn20zBxsKjTrwSSIBVLEMJ4mxt1TTar8pRoDdUzbWgb8YHfFy9mq4LHNU0PMzPDDu+ytI
	bcSnSUKHunMZyDZa3HA7A9DSw2JN/Eq25l49QxPB+wDS4nOahXe86rdpDAE59+KsIZxrup
	yx5BlBRxKihZjI35WTQEsL1KpfrO87Q=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-fiD9LiwxNNe-j_pyR-0zGw-1; Fri, 19 Apr 2024 10:11:42 -0400
X-MC-Unique: fiD9LiwxNNe-j_pyR-0zGw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c74d1dc6b6so353983b6e.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535901; x=1714140701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veCFJ5s5nwQXNCbj3LY7veh9fp5tYNFk3WMUGDvs+DQ=;
        b=PfpfWSROZJaCDNw/HuhhUygMZXQ7WQHRtfJqR/OvzdopVCHJqGu4Q8B76yOY3Rbdu9
         DwB82MLoQLzliFvFMqi5p8O9n49fxm8ir+j3cE9HkMz4bGcRSigfjFP6gTjrH8Dt1V5y
         KX/Gn5h/hIphsv+qnzdLyS7eATfg1YpTJLAbF3oLBN+W+FsvLwYmuhHQSS+tBPUmDFSu
         tyd9IXtYOqd8afwSR30rii3JYuBzw6jSJb9igMT+sMKtUaPDPJ5RGeK3y9pwcJm70wxh
         Z8h+DIpMQ9lBPHGFVLm9M3ExSu8gCDQOvQgn7XCEU3aG2w90fIojZ9MfDNqLE3V70muY
         KSww==
X-Forwarded-Encrypted: i=1; AJvYcCUxroxW105qRg35Z9/NdrstC/JLWpqJxytlbdy902kl1Ok3SrgWvJ/yXrGEtxsLcNf2008/qf4B8ei68L5/eA8ncP1/e0LC3UpjLdxAnbDP
X-Gm-Message-State: AOJu0Yy+FLxf4vDKZeiSSD3PVGlqxqkj5F8FJqzCvgXtl+C7OfzAyL7F
	wUBXbV/ZVGKu10QEfK2g7mHLoPdW9lOZI9ceyoOBGUsNjC/ElEXD40ZJ6YuIJWA28c9NuS92xjI
	10XrzFTmHLyRfeZ4a/KqvH00msQ5z9TxR7GXh7dgNF1YYag7oi4gLO+7uulRtqtPiWDYmX1QSbi
	IRdxuVkFohXf7X0A2thEcm4ptGrI2AUnvbZ3RWniOmxpxfif+U
X-Received: by 2002:a05:6808:429a:b0:3c7:2616:554e with SMTP id dq26-20020a056808429a00b003c72616554emr1983461oib.57.1713535901374;
        Fri, 19 Apr 2024 07:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGZRV9MmeZLQ+H+l4h7XmRd2gRa+8XU74Iwg4+D93gJXQFmHszAJlk1X+qg0QPerkZdmQbcYhJSafs6s24UAM=
X-Received: by 2002:a05:6808:429a:b0:3c7:2616:554e with SMTP id
 dq26-20020a056808429a00b003c72616554emr1983444oib.57.1713535901153; Fri, 19
 Apr 2024 07:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419132504.9488-1-wander@redhat.com> <20240419132504.9488-3-wander@redhat.com>
 <2024041919-unify-improve-d4a5@gregkh>
In-Reply-To: <2024041919-unify-improve-d4a5@gregkh>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 19 Apr 2024 11:11:29 -0300
Message-ID: <CAAq0SUnjc03N5kHgJ8vwk19BjzQr8DCRCokh09npmCs2mxxwXA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kunit: avoid memory leak on device register error
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 19, 2024 at 10:25:02AM -0300, Wander Lairson Costa wrote:
> > If the device register fails, free the allocated memory before
> > returning.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > ---
> >  lib/kunit/device.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > index 25c81ed465fb..d8c09dcb3e79 100644
> > --- a/lib/kunit/device.c
> > +++ b/lib/kunit/device.c
> > @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_i=
nternal(struct kunit *test,
> >       err =3D device_register(&kunit_dev->dev);
> >       if (err) {
> >               put_device(&kunit_dev->dev);
> > +             kfree(kunit_dev);
>
> This still looks wrong, the release function for the device should free
> the memory here, not this kfree, as the reference count in the embedded
> 'struct device' handles the memory logic for the whole structure (if
> not, then something is REALLY wrong...)
>
> You _do_ have a release function for the device, right?  If not, you
> should be getting loud messages in the kernel log when releasing a
> device here.
>

Ok, I got it. Yes, there is a release function. So this patch is
wrong, ignore it. Should I send a v5 with only the other patch?

> thanks,
>
> greg k-h
>


