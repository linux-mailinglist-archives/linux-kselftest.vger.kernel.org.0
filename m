Return-Path: <linux-kselftest+bounces-19857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC19A1111
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525EC1F22B13
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805218BC0E;
	Wed, 16 Oct 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cC1a+lZ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEF16DEAC
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101629; cv=none; b=sAlG2+uY+Uo4tPzoItqevM1+lupgSwym7q4e18R6+pEYOmGKZ4WKmF0HmiPCY7Q9gglGnQXy47eaTDNROu+hTejN66TFgkM2E5p8OkbcHEIZGePqcAJSQ+cNhG8l+v9KbIsAtuCgws2a4L9ETUbaIye+fY29PQbYucFdLhDkJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101629; c=relaxed/simple;
	bh=r+DmvFoNHV+CnJHYXI7gzPRgz+47XKtZj3xP2+kaweE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui5jMjuApabEkH2QlQb06D8g/V61yQHHDsm/w9+bWL4JCIyC2239JfGJZIXhj24fegoHVjlMIMZUBQXJPWc/6qeGGfVVAfJ3VSemudiU5PH1zH1MDD22eTr9iGHAtjZYb1Y0yxKjo5iCMhbE+Fj3e1VHLOF7TiGp3ve/2lc3r14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cC1a+lZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729101627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvuMUB+YxlmDY/Zh8jIKyjbgFDGsxUZWuqMUa3pIvIg=;
	b=cC1a+lZ0IBKxBx1hKPUV8zhgtjK7A3yA4Wq09UBGwmAkY95eP5/iGM3Cc6xV1XbGfG4DCj
	oZRt1bEkDDkYhFYdFjAG9CgoDgTVLqsVZfdNvexDZLXmnYInYVFU+iYVPYnS6mJ1ff/DwR
	UlUMY2byxg07nimQPk/gKRgJ+9bMJE0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-13rA19QTPgu9atsWqoI3LA-1; Wed, 16 Oct 2024 14:00:26 -0400
X-MC-Unique: 13rA19QTPgu9atsWqoI3LA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6e2e5e376fcso3833587b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 11:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101625; x=1729706425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvuMUB+YxlmDY/Zh8jIKyjbgFDGsxUZWuqMUa3pIvIg=;
        b=ZQc3fAK2h19tHuglLDFwKNrXqDF32j8xWeiKXk4D/gI5c9j3tWj8MtgfFasOQit1Ln
         +qbIJzWtXbLClkGWwEsXq3+k0JiWH0rfcIPblcEK0TFWtgNEzxxbgxnKKv1o3qCauGd4
         OiJ1yFgJA81SG3J42+OYJjVtWntBGke5vqpI8bjO+FqCrqqdb9KufmIkmjV2/p7YQJXV
         hXvGScB87hue1RwVV51zA/WgRz0pyPusk5roTXwHaTncUoBZQm5P52dOro3QNnZAparF
         1pCzbewAoycoD2R0eiUU02cfihacUPSKqzVAA14g7FIc5Lw5NLdTwPRSA8kNrsEV4trK
         6E/w==
X-Forwarded-Encrypted: i=1; AJvYcCXPrwuVVRDaCaxOEgJSBQ0ByUypoVZw7WLtqavYe+ocWoX0FzUX5HpcADB9C1Cbt2ZH0Xk/wCdLNd9ItA2uuag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrq4YZ4tHdKp4UBfRL2F6r+0AH8D22gW8GZAYfH0btqkAclLZ/
	HIIpSA+OyrO4e4QMuNYtrPg+7TwbmjzFOK9oNnzWP/wSmrgnZj4M3jNUeekHh1GDCDXP5S0EZbe
	PUN6FJsfcYR8boDl8fZIWHZFWfm2Hj+ubOBRCs6xOM3ptX4iT6xvKDvwOerH4io4Ata4cqIvMb5
	60l9D6CzrphbXv/HZHUKzhicLOGUeRp7xJq0/z/CQu
X-Received: by 2002:a05:6902:c0f:b0:e29:27d:5ef3 with SMTP id 3f1490d57ef6-e2931dff424mr14365273276.49.1729101625257;
        Wed, 16 Oct 2024 11:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhz8e+7URFfxiW/PklUAF5rnrkDwYncm2dP2uHkzA3LG2V9PbPovLITgY/L/70RBjZGAhZeCG/lR9PRW6v/GQ=
X-Received: by 2002:a05:6902:c0f:b0:e29:27d:5ef3 with SMTP id
 3f1490d57ef6-e2931dff424mr14365229276.49.1729101624915; Wed, 16 Oct 2024
 11:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB5632C443F9D7E658168BC77DFD452@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Donald Zickus <dzickus@redhat.com>
Date: Wed, 16 Oct 2024 14:00:14 -0400
Message-ID: <CAK18DXZ64XwjgeMEJSBPE+Sunq-fK3TupcOw=5ynpzdTL5H6vg@mail.gmail.com>
Subject: Re: [Automated-testing] [RFC] Test catalog template
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
	"automated-testing@lists.yoctoproject.org" <automated-testing@lists.yoctoproject.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, 
	"laura.nao@collabora.com" <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Tue, Oct 15, 2024 at 12:01=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrot=
e:
>
> > -----Original Message-----
> > From: automated-testing@lists.yoctoproject.org <automated-testing@lists=
.yoctoproject.org> On Behalf Of Don Zickus
> > Hi,
> >
> > At Linux Plumbers, a few dozen of us gathered together to discuss how
> > to expose what tests subsystem maintainers would like to run for every
> > patch submitted or when CI runs tests.  We agreed on a mock up of a
> > yaml template to start gathering info.  The yaml file could be
> > temporarily stored on kernelci.org until a more permanent home could
> > be found.  Attached is a template to start the conversation.
> >
> Don,
>
> I'm interested in this initiative.  Is discussion going to be on a kernel=
 mailing
> list, or on this e-mail, or somewhere else?

I was going to keep it on this mailing list.  Open to adding other
lists or moving it.

>
> See a few comments below.
>
> > Longer story.
> >
> > The current problem is CI systems are not unanimous about what tests
> > they run on submitted patches or git branches.  This makes it
> > difficult to figure out why a test failed or how to reproduce.
> > Further, it isn't always clear what tests a normal contributor should
> > run before posting patches.
> >
> > It has been long communicated that the tests LTP, xfstest and/or
> > kselftests should be the tests  to run.
> Just saying "LTP" is not granular enough.  LTP has hundreds of individual
> test programs, and it would be useful to specify the individual tests
> from LTP that should be run per sub-system.

Agreed.  Just reiterating what Greg has told me.

>
> I was particularly intrigued by the presentation at Plumbers about
> test coverage.  It would be nice to have data (or easily replicable
> methods) for determining the code coverage of a test or set of
> tests, to indicate what parts of the kernel are being missed
> and help drive new test development.

It would be nice.  I see that as orthogonal to this effort for now.
But I think this might be a good step towards that idea.

>
> > However, not all maintainers
> > use those tests for their subsystems.  I am hoping to either capture
> > those tests or find ways to convince them to add their tests to the
> > preferred locations.
> >
> > The goal is for a given subsystem (defined in MAINTAINERS), define a
> > set of tests that should be run for any contributions to that
> > subsystem.  The hope is the collective CI results can be triaged
> > collectively (because they are related) and even have the numerous
> > flakes waived collectively  (same reason) improving the ability to
> > find and debug new test failures.  Because the tests and process are
> > known, having a human help debug any failures becomes easier.
> >
> > The plan is to put together a minimal yaml template that gets us going
> > (even if it is not optimized yet) and aim for about a dozen or so
> > subsystems.  At that point we should have enough feedback to promote
> > this more seriously and talk optimizations.
>
> Sounds like a good place to start.  Do we have some candidate sub-systems
> in mind?  Has anyone volunteered to lead the way?

At our meeting, someone suggested Kunit as it was easy to understand
for starters and then add a few other volunteer systems in.  I know we
have a few maintainers who can probably help us get started.  I think
arm and media were ones thrown about at our meeting.

>
> >
> > Feedback encouraged.
> >
> > Cheers,
> > Don
> >
> > ---
> > # List of tests by subsystem
> > #
> > # Tests should adhere to KTAP definitions for results
> > #
> > # Description of section entries
> > #
> > #  maintainer:    test maintainer - name <email>
> > #  list:                mailing list for discussion
> > #  version:         stable version of the test
> > #  dependency: necessary distro package for testing
> > #  test:
> > #    path:            internal git path or url to fetch from
> > #    cmd:            command to run; ability to run locally
> > #    param:         additional param necessary to run test
> > #  hardware:      hardware necessary for validation
>
> Is this something new in MAINTAINERS, or is it a separate file?

For now a separate file.  It isn't clear where this could go long
term.  The thought was to gather data to see what is necessary first.
Long term it will probably stay a separate file. *shrugs*

>
> > #
> > # Subsystems (alphabetical)
> >
> > KUNIT TEST:
> >   maintainer:
> >     - name: name1
> >       email: email1
> >     - name: name2
> >       email: email2
> >   list:
> >   version:
> >   dependency:
> >     - dep1
> >     - dep2
> >   test:
> >     - path: tools/testing/kunit
> >       cmd:
> >       param:
> >     - path:
> >       cmd:
> >       param:
> >   hardware: none
>
> Looks OK so far - it'd be nice to have a few concrete examples.

Fair enough.  Let me try and work on some.

Cheers,
Don

>  -- Tim
>


