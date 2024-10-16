Return-Path: <linux-kselftest+bounces-19858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D44669A1118
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A3FB24B6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6718BC22;
	Wed, 16 Oct 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL8I62f8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531416C687
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101751; cv=none; b=fXYpOdO82FuKkeO+dCH6AuecXelFaQSllpNh4lYgza+c/L8VC5NEc7Y6G+AQ1zmlPONRxnTUcoeXtvjThdAttLo1WgAYdoUPM+9RPHhWu9iITzmn+QpvCMEYo9AC/SXmSKmR3b2YtxyFQZECyCnf1DM99Yanz9ICb367UXuQ4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101751; c=relaxed/simple;
	bh=pi9H4WMd9SM5eDGDfTbd2w4J6yN+KVgePTHA6Uemi7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjNX29x/6n/7tfUyZEhT1FpIKje96tFOYZ+o6U4ND/AqbDTyQDUZNwW+qZ9KfjRpdyFzwsyYIAB2BkRyxOQW5Uky0eVt0+oBURY1uiymG8wE+ML7qrKQPVqyjR92cpG8yMJSF11Wj07gEP4HlnWuQKL8xZWlEy3BnocAXK4mTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DL8I62f8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729101748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pm8JXLoAKsq/UPs87DRA42ZRFshFvHDgnF3dqmUbVPs=;
	b=DL8I62f8giLAf3ynQVCb02eU3hornqZpGDRG/pPX0+UGNst6liPhbVcZ80s52bZb+JkqB9
	eVVKLAvjd4XIEqPY5j+q5Js3hB/mjC8Nu0Z3bqcyIvlKV4EQtqE9yZz4Th64JqnoPEKB6C
	+Y8f2+if2F9T0yaIwOUjaKemFnlEoJo=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-_i-DZMWANdK7tsPomOq5HA-1; Wed, 16 Oct 2024 14:02:25 -0400
X-MC-Unique: _i-DZMWANdK7tsPomOq5HA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-288898e50daso116613fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 11:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101745; x=1729706545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm8JXLoAKsq/UPs87DRA42ZRFshFvHDgnF3dqmUbVPs=;
        b=fAOQ0oCd/IkrEWbBU2Z3+Y7GwrJ8AKwXTxaYk8+Ad10Pdn7IU2y6UT+O7sOLxWd0yN
         UxGNdBwxTObSdTxkIQ6TXAByiHVNQiFRCS2ok407IshPf7h5B6BCFaStEJn6K1z1TPlc
         hBiZI81sDh0No8IvlFY4q+9pj+kl7Lkfq2EYiUQ2Ol2JlkN6hwTMA68tNCWYma+QZ638
         erd7fn7LyrAziQNlGYAURARbWHDvmt2+v6Uf+YZo6nwppe/R+JTgobBkb28RWqMmFvzA
         9OpjUJVCtYUoUISkHvYDHnjK43UDCGtPYUqgzb10jA12baQrDqsEqmfIMYQmPuIS0nW8
         wRPg==
X-Forwarded-Encrypted: i=1; AJvYcCV4enK+snqxlTzVaL34Q0DrrdfMOJPWQ33pIyHGKDp+372DNAmdO1TRSkrhiP4H8zRjFqLPAkPU0TpBY8vUIE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPvw8Pd7l8KrR1ieE4tw9hPfrm9rOAZ/OtKGfs+jNWWxdTXWZ
	+y9t1bdbMrI/qWZR+CaDbfe6P1Vy5AvrfR6/0LBcJsDHbRHl3YmiQFStIuRD+o+nesWmRKI24tS
	P0UXWu5V3D3M10zLc6dIqaPpf4Dk9WAiL14erT/b732sikd4wh+a+HsPNTRUgP4rE+QtWYCQVKQ
	fL3bjOwElh9DvVbOwJm6X4PcptDgw3Zv+B6MO13Ben
X-Received: by 2002:a05:6870:c1d4:b0:277:db7f:cfb2 with SMTP id 586e51a60fabf-2886dd7375cmr15544358fac.14.1729101744970;
        Wed, 16 Oct 2024 11:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDNQLSYZavey/MCZZTTF4pekCcu5Qvgrv7LS/txIy8CC0Uej3nbZiDkCn/5iIUKyyCta1WoXvJIzg7cctLQX8=
X-Received: by 2002:a05:6870:c1d4:b0:277:db7f:cfb2 with SMTP id
 586e51a60fabf-2886dd7375cmr15544335fac.14.1729101744699; Wed, 16 Oct 2024
 11:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
 <Zw-7Tydnaaj3XAQo@yuki.lan>
In-Reply-To: <Zw-7Tydnaaj3XAQo@yuki.lan>
From: Donald Zickus <dzickus@redhat.com>
Date: Wed, 16 Oct 2024 14:02:13 -0400
Message-ID: <CAK18DXYDxfd3cqUdUjLvzMMxvkCma-H6qWbgmAgqyRTNb00TWA@mail.gmail.com>
Subject: Re: [Automated-testing] [RFC] Test catalog template
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Tim Bird <tim.bird@sony.com>, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
	"automated-testing@lists.yoctoproject.org" <automated-testing@lists.yoctoproject.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, 
	"laura.nao@collabora.com" <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cyril,

On Wed, Oct 16, 2024 at 9:11=E2=80=AFAM Cyril Hrubis <chrubis@suse.cz> wrot=
e:
>
> Hi!
> > Just saying "LTP" is not granular enough.  LTP has hundreds of individu=
al
> > test programs, and it would be useful to specify the individual tests
> > from LTP that should be run per sub-system.
>
> A few thousand tests to be more precise, and also the content tend to
> change between releases, be it test additions or removal and I do not
> think this level of changes is somehing that makes sense to be tracked
> in such database.
>
> It may be better to have more generic description of LTP subsets, there
> are a few obvious e.g. "SysV IPC" or "Timers", and have the LTP
> testrunner map that to actual testcases. The hard task here is to figure
> out which groups would be useful and keep the set reasonably small.
>
> I can move this forward in LTP reasonably quickly we get small list of
> useful groups from kernel develpers.

Thanks!  The thought was if we wanted to encourage contributors to run
these tests before submitting, does running the whole LTP testsuite
make sense or like you said a targeted set would be much better?

Cheers,
Don

>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


