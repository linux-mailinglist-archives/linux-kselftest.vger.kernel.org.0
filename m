Return-Path: <linux-kselftest+bounces-22409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453039D4FB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41160B21BE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C1B1DA0FE;
	Thu, 21 Nov 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om7zKRdo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F5230997
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202905; cv=none; b=D+l1yBhwcHkoavjUbldb1jANRE3Mf8JyyUGLfkQDIotrjZGZCFuZI3YErSqGM6kCexIzB6dN2PQnA2LwJn7pcQAvk7SYggb9+b/p5r9YsCHBId3PH56CmrLHx90aghk2gUU6NImbJfNGtl+kkTntRsJnnvKOWESNEmG16FPaI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202905; c=relaxed/simple;
	bh=AiQKPX0HhQDE8c0S4ykPBQmmz/wb/hL2HG+fnVGd1Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBPs7CV1TftnOTBLrUX6cTnhccIIeYeYRsTxMjoOl+VSYk9Wot2cOY7VoArgQ6fxcT35RLww1J4bo8Q+umhEnKZFek3B897QEcebZ2AqR1Dw+P6C3fn1nFAix12qbfimdrJ9jZLHKLuNPtXnHbV+flIp0NbjWUkfnG6EtunKvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Om7zKRdo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732202902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTlRncZxSzMTlrtP+dPEh1AXEBr3udpSzwQ7cYXWV6s=;
	b=Om7zKRdojivQjSuanbD+L3GONMobBxpTJkeHGUIsozwmW6XN1gL7fG0ufRXzLGiORvggxA
	wfGiptHdnqRPtA9c5+ETmjw8ghEZRZXtjocsXjpnqzjcGgK7iYt5GgGVrH6kmtT+gIgsQb
	aGglWQSB8bNzWHfbQPLHWFuThLNK6rk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-sMxqY0FJNCSc0IuM8BvTCQ-1; Thu, 21 Nov 2024 10:28:21 -0500
X-MC-Unique: sMxqY0FJNCSc0IuM8BvTCQ-1
X-Mimecast-MFC-AGG-ID: sMxqY0FJNCSc0IuM8BvTCQ
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6ee65ae21b9so16695227b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 07:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202901; x=1732807701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTlRncZxSzMTlrtP+dPEh1AXEBr3udpSzwQ7cYXWV6s=;
        b=gx63vo+hCMWjiKdqxkGDt86HImc6Wg6J6riUFpxQTIjcca1YfUFoSNTAwjRA/n0kix
         TT+HMPsmCBYgSz3CNKtre0eRkPCWa8Wr6lVsCyVL0oPOBi0RV/U0uT5Zik/gDZY8TgDQ
         J7Qtn6WcvIxAH7WA92wjT7JNG5EC4fYpr0QC8gN70QPffMN9PA0cqugZTkgIQpvINFgI
         k1zPOH4iZ/gDfGnZZ3+7S4qXijblDtQTKVqJ5hGhS9S68Ihp6I6hMWxWGRcY44v7qJyQ
         mQCkJpcWuN6MIEZRpU8JMmWtN737w+ZtYQzYNcrd0kI4G3uB1MQsBtkQ9CZDsAxLjldV
         Zmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXlb4i+/cicy8itXK60bg6DgxmeaQAjUlDkvMJ0tnw7DmMlIpLoWucOBZN7ggE7EwFM6SGCJJ/v+D1P4bwr1T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamA+LCON79Vpkc37yQMYdKNodWY8pI/+YFyT4MUYpimKNlVEP
	EC9tSmysfjYIbdfumVL7OsAjVkmddhatVnQV98yL3W6LSlth3EfI4bVshpyk+Dxg6B22uRIHJoi
	VbEJ5/ErxjYffOtcQRD3UME8zyXXxgkxBCSldgx6pNO+U61aLl29xcdDKAhqqtmGsZe3uSXQmQe
	e5HFkYG7grMTzYBf65376JZjwvL8BJ/zVkWpHKDKQz
X-Gm-Gg: ASbGncs9qlp0fVD21ZcXWDJvCVfKpu/JbJX0Ns9e7FlCBovfpzY8JahoIk4TGShIV3N
	4ZRwtnx1qdneajPBqA9VA7L7GInCINBw=
X-Received: by 2002:a05:690c:6307:b0:6ee:7f37:7107 with SMTP id 00721157ae682-6eebd124819mr78595977b3.12.1732202900625;
        Thu, 21 Nov 2024 07:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFleEZ0WGYzANLMhgAnl5eQUxFn8peiSsoWxkXdOvWn2DCAFwsWqoW6djwb3DqQGjxNJFmHIu5JqU28r8yrDE4=
X-Received: by 2002:a05:690c:6307:b0:6ee:7f37:7107 with SMTP id
 00721157ae682-6eebd124819mr78595617b3.12.1732202900226; Thu, 21 Nov 2024
 07:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
 <CAK18DXZtBdxQdYY06X+Q=vYybnkCLBQBioCLqvSfkYZ21jBSWg@mail.gmail.com>
 <CABVgOSkBF3fT5JdVCEpBRvO1V8ZgZ-dD7fvxcv7Rxb_XPcFNbg@mail.gmail.com>
 <CAK18DXZM7sapjOHcsOUAEn_+Q+bvFUtL-CNjEgq373gpWr7r-w@mail.gmail.com> <CABVgOS=ccEK2+ighe=7K3Ja-vH0=fthK4LgV0kHTuNCgO9JzzQ@mail.gmail.com>
In-Reply-To: <CABVgOS=ccEK2+ighe=7K3Ja-vH0=fthK4LgV0kHTuNCgO9JzzQ@mail.gmail.com>
From: Donald Zickus <dzickus@redhat.com>
Date: Thu, 21 Nov 2024 10:28:08 -0500
Message-ID: <CAK18DXZCgRpS=kHgh9xGmjE9dO2s7Gm61m_yq8QUAZEMMUOEyw@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
To: David Gow <davidgow@google.com>
Cc: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, Nov 20, 2024 at 3:16=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Thu, 7 Nov 2024 at 01:01, Donald Zickus <dzickus@redhat.com> wrote:
> >
> > Hi,
> >
> > Thanks for the feedback. I created a more realistic test.yaml file to
> > start (we can split it when more tests are added) and a parser.  I was
> > going to add patch support as input to mimic get_maintainers.pl
> > output, but that might take some time.  For now, you have to manually
> > select a subsystem.  I will try to find space on kernelci.org to grow
> > this work but you can find a git tree here[0].
> >
> > From the README.md
> > """
> > An attempt to map kernel subsystems to kernel tests that should be run
> > on patches or code by humans and CI systems.
> >
> > Examples:
> >
> > Find test info for a subsystem
> >
> > ./get_tests.py -s 'KUNIT TEST' --info
> >
> > Subsystem:    KUNIT TEST
> > Maintainer:
> >   David Gow <davidgow@google.com>
> > Mailing List: None
> > Version:      None
> > Dependency:   ['python3-mypy']
> > Test:
> >   smoke:
> >     Url: None
> >     Working Directory: None
> >     Cmd: ./tools/testing/kunit/kunit.py
> >     Env: None
> >     Param: run --kunitconfig lib/kunit
> > Hardware:     arm64, x86_64
> >
> > Find copy-n-pastable tests for a subsystem
> >
> > ./get_tests.py -s 'KUNIT TEST'
> >
> > ./tools/testing/kunit/kunit.pyrun --kunitconfig lib/kunit
> > """
> >
> > Is this aligning with what people were expecting?
> >
>
>
> Awesome! I've been playing around a bit with this, and I think it's an
> excellent start.
>
> There are definitely some more features I'd want in an ideal world
> (e.g., configuration matrices, etc), but this works well enough.

Yeah, I was trying to nail down the usability angle first before
expanding with bells and whistles.  I would like to think the yaml
file is flexible enough to handle those features though??

>
> I've been playing around with a branch which adds the ability to
> actually run these tests, based on the 'run_checks.py' script we use
> for KUnit:
> https://github.com/sulix/test-catalog/tree/runtest-wip

Thanks!

>
> In particular, this adds a '-r' option which runs the tests for the
> subsystem in parallel. This largely matches what I was doing manually
> =E2=80=94 for instance, the KUnit section in test.yaml now has three diff=
erent
> tests, and running it gives me this result:
> ../test-catalog/get_tests.py -r -s 'KUNIT TEST'
> Waiting on 3 checks (kunit-tool-test, uml, x86_64)...
> kunit-tool-test: PASSED
> x86_64: PASSED
> uml: PASSED

Interesting.  Originally I was thinking this would be done serially.
I didn't think tests were safe enough to run in parallel.  I am
definitely open to this.  My python isn't the best, but I think your
PR looks reasonable.

>
> (Obviously, in the real world, I'd have more checks, including other
> architectures, checkpatch, etc, but this works as a proof-of-concept
> for me.)
>
> I think the most interesting questions will be:
> - How do we make this work with more complicated dependencies
> (containers, special hardware, etc)?

I was imagining a 'hw-requires' type line to handle the hardware
requests as that seemed natural for a lot of the driver work. Run a
quick check before running the test to see if the required hw is
present or not and bail if it isn't.  The containers piece is a little
trickier and ties into the test environment I think.  The script would
have to create an environment and inject the tests into the
environment and run them.  I would imagine some of this would have to
be static as the setup is complicated.  For example, a 'container'
label would execute custom code to setup a test environment inside a
container.  Open to ideas here.

> - How do we integrate it with CI systems =E2=80=94 can we pull the subsys=
tem
> name for a patch from MAINTAINERS and look it up here?

There are two thoughts.  First is yes.  As a developer you probably
want to run something like 'get_maintainers.sh <patch> | get_tests.py
-s -' or something to figure out what variety of tests you should run
before posting.  And a CI system could probably do something similar.

There is also another thought, you already know the subsystem you want
to test.  For example, a patch is usually written for a particular
subsystem that happens to touch code from other subsystems.  You
primarily want to run it against a specified subsystem.  I know Red
Hat's CKI will run against a known subsystem git-tree and would fall
into this category.  While it does leave a gap in other subsystem
testing, sometimes as a human you already know running those extra
tests is mostly a no-op because it doesn't really change anything.

> - What about things like checkpatch, or general defconfig build tests
> which aren't subsystem-specific?

My initial thought is that this is another category of testing.  A lot
of CI tests are workload testing and have predefined configs.  Whereas
a generic testing CI system (think 0-day) would focus on those types
of testing.  So I would lean away from those checks in this approach
or we could add a category 'general' too.  I do know checkpatch rules
vary from maintainer to maintainer.

> - How can we support more complicated configurations or groups of
> configurations?

Examples?

> - Do we add support for specific tools and/or parsing/combining output?

Examples?  I wasn't thinking of parsing test output, just providing
what to run as a good first step.  My initial thought was to help
nudge tests towards the KTAP output??

>
> But I'm content to keep playing around with this a bit more for now.

Thank you! Please do!

Cheers,
Don


