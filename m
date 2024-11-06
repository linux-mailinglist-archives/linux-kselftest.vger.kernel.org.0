Return-Path: <linux-kselftest+bounces-21543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D659BF3D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0296D1C235C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF9205131;
	Wed,  6 Nov 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtgJ1p15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0284039
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912478; cv=none; b=prJCRnTlqOA+jskbYBPattkuVoBZy6u057XoFq3R3HsMRnmNHJ05O8WhaFkrmXgVSGJY9Gu7MNEFhTtRHEwBfIYkhozgdmvNnYcIFnNDOXVyeNZMfT6DRIBioq2fJB363rZcXgKdYcfMlyy4fqDHL45UpQ4IbDtjq4dYlSAar4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912478; c=relaxed/simple;
	bh=q9rihScmhZAOxpPIfbwAduusOgbC5ixRzXvVx3Qn0KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDe7m2/Z8RmG6XoWh4kI/yRv64HQ2gg1czfKrLlWYgA3vKKBq194ZMpW2ulaufaxraA9bjyrBL31V0RGdMAmA9BHZ60KHI2FFYpHZYt/eZEUNJ21iK75xb2GYLPfYgReQ4t6opMLu46+3DMvzne0V/H23J+hFDtmjPNOZMaOmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtgJ1p15; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730912474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6njKn4P9YVbv4L+ogmy0dcPnDK4/dU1er1B06b00o0=;
	b=MtgJ1p15TK2j+qIhXNspX76OhgpLauPMOztKGsmNEg4NJaE9G9Ujg6KAF6KqafJw7OJrIQ
	uSpTuahnkabcnDJBOBThmhHyM1chbYgw5YuqKDSTibj5O9P+CSwtWM2BL3Zlr8xDy+5Map
	24PyvXrfuFUVWzXPX/qX3L2upk88tRE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-yHNAd5lqN32Zv3Enb-Mmxg-1; Wed, 06 Nov 2024 12:01:13 -0500
X-MC-Unique: yHNAd5lqN32Zv3Enb-Mmxg-1
X-Mimecast-MFC-AGG-ID: yHNAd5lqN32Zv3Enb-Mmxg
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6ea90b6ee2fso57374517b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Nov 2024 09:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912473; x=1731517273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6njKn4P9YVbv4L+ogmy0dcPnDK4/dU1er1B06b00o0=;
        b=hPovZ6lGnoSMk+jai5g4+MFdPTtkYJFMlMW2IbbDoyU5Inu0qpzReTgVQ8/RY/By+P
         KoEdvbVqighRYu/ymfPuvBJyOHKfdn6Qskhth03rnRXgpsBXNTFaP+Z6kn0Y91bMXzBf
         NQFQRTIoqEy8XA2LX5am+AIifetqSyS9kpV6QNcNbmGW/ko7Xmf9DAedrpWb84KyNcDu
         0aQVc/WRzs2xKs3ZExAE+bZ0sWs2x5GrFKHY8gT/h6YsV+esSdKj+Hipl/cmoQbKV6PR
         KTUoO1FTz9oYYjHVcPCoP9N3Q8ju+GcRtKwDymqATZvjSAQz4PGyKY8RnBJheak9Fb0g
         O5ow==
X-Forwarded-Encrypted: i=1; AJvYcCVxL5pl/5R75ttn2dXAj8uAZ+VOMUpcGEctfCqd75U8u5m3cWb4LinEgfIUzaNPZL1oBxOIsaCnWqTyy+vnNQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbGS8gXSoqVHXyv2U1UKsvvPUkg2ivFQDTUUs9LHlgiYqdiWb
	Y/rsPzDCn1pTfdIsSRowDvI9uVteOyTOFD1nZpBso67DHdD9EQg12/+QheKJaXX62RM2BLIwI4T
	tRI6Yda4w3USimca/rfgdyyDC7iGDKFl8MufV059YrvfiTA7f5JPZ7OjUFlA35UA3PlzE5UKz9i
	v+kSsURiTQCLUueWGiEvdjED7Bw+nz1WyVeV4AxaSZ
X-Received: by 2002:a05:690c:61ca:b0:6e3:252c:408 with SMTP id 00721157ae682-6ea523cb2c8mr254640047b3.20.1730912472501;
        Wed, 06 Nov 2024 09:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcban3KNO2ycX02IVD7OOHSA1xjIU5RZ1dd1XrIqYbEGIFUzC5QcEqb7peE+ox4D6SVXnsW4TIgR9qxz1wytU=
X-Received: by 2002:a05:690c:61ca:b0:6e3:252c:408 with SMTP id
 00721157ae682-6ea523cb2c8mr254639487b3.20.1730912471965; Wed, 06 Nov 2024
 09:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
 <CAK18DXZtBdxQdYY06X+Q=vYybnkCLBQBioCLqvSfkYZ21jBSWg@mail.gmail.com> <CABVgOSkBF3fT5JdVCEpBRvO1V8ZgZ-dD7fvxcv7Rxb_XPcFNbg@mail.gmail.com>
In-Reply-To: <CABVgOSkBF3fT5JdVCEpBRvO1V8ZgZ-dD7fvxcv7Rxb_XPcFNbg@mail.gmail.com>
From: Donald Zickus <dzickus@redhat.com>
Date: Wed, 6 Nov 2024 12:01:00 -0500
Message-ID: <CAK18DXZM7sapjOHcsOUAEn_+Q+bvFUtL-CNjEgq373gpWr7r-w@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
To: David Gow <davidgow@google.com>
Cc: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the feedback. I created a more realistic test.yaml file to
start (we can split it when more tests are added) and a parser.  I was
going to add patch support as input to mimic get_maintainers.pl
output, but that might take some time.  For now, you have to manually
select a subsystem.  I will try to find space on kernelci.org to grow
this work but you can find a git tree here[0].

From the README.md
"""
An attempt to map kernel subsystems to kernel tests that should be run
on patches or code by humans and CI systems.

Examples:

Find test info for a subsystem

./get_tests.py -s 'KUNIT TEST' --info

Subsystem:    KUNIT TEST
Maintainer:
  David Gow <davidgow@google.com>
Mailing List: None
Version:      None
Dependency:   ['python3-mypy']
Test:
  smoke:
    Url: None
    Working Directory: None
    Cmd: ./tools/testing/kunit/kunit.py
    Env: None
    Param: run --kunitconfig lib/kunit
Hardware:     arm64, x86_64

Find copy-n-pastable tests for a subsystem

./get_tests.py -s 'KUNIT TEST'

./tools/testing/kunit/kunit.pyrun --kunitconfig lib/kunit
"""

Is this aligning with what people were expecting?

Cheers,
Don

[0] - https://github.com/dzickusrh/test-catalog/tree/main

On Sat, Oct 19, 2024 at 2:36=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 19 Oct 2024 at 04:17, Donald Zickus <dzickus@redhat.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 3:22=E2=80=AFAM David Gow <davidgow@google.com>=
 wrote:
> > >
> > > Hi Don,
> > >
> > > Thanks for putting this together: the discussion at Plumbers was very=
 useful.
> > >
> > > On Tue, 15 Oct 2024 at 04:33, Donald Zickus <dzickus@redhat.com> wrot=
e:
> > > >
> > > > Hi,
> > > >
> > > > At Linux Plumbers, a few dozen of us gathered together to discuss h=
ow
> > > > to expose what tests subsystem maintainers would like to run for ev=
ery
> > > > patch submitted or when CI runs tests.  We agreed on a mock up of a
> > > > yaml template to start gathering info.  The yaml file could be
> > > > temporarily stored on kernelci.org until a more permanent home coul=
d
> > > > be found.  Attached is a template to start the conversation.
> > > >
> > >
> > > I think that there are two (maybe three) separate problems here:
> > > 1. What tests do we want to run (for a given patch/subsystem/environm=
ent/etc)?
> >
> > My thinking is this is maintainer's choice.  What would they like to
> > see run on a patch to verify its correctness?  I would like to think
> > most maintainers already have scripts they run before commiting
> > patches to their -next branch.  All I am trying to do is expose what
> > is already being done I believe.
> >
>
> Agreed.
>
> >
> > > 2. How do we describe those tests in such a way that running them can
> > > be automated?
> >
> > This is the tricky part.  But I am going to assume that if most
> > maintainers run tests before committing patches to their -next branch,
> > then there is a good chance those tests are scripted and command line
> > driven (this is the kernel community, right :-) ).  So if we could
> > expose those scripts and make the copy-and-pastable such that
> > contributors or testers (including CI bots) can just copy and run
> > them.  Some maintainers have more complex environments and separating
> > command line driven tests from the environment scripts might be
> > tricky.
> >
> > Does that sound reasonable?
>
> Yeah: that's basically what I'd want.
>
> >
> > > 3. (Exactly what constitutes a 'test'? A single 'test', a whole suite
> > > of tests, a test framework/tool? What about the environment: is, e.g.=
,
> > > KUnit on UML different from KUnit on qemu-x86_64 different from KUnit
> > > on qemu-arm64?)
> > >
> > > My gut feeling here is that (1) is technically quite easy: worst-case
> > > we just make every MAINTAINERS entry link to a document describing
> > > what tests should be run. Actually getting people to write these
> > > documents and then run the tests, though, is very difficult.
> >
> > Well if I look at kunit or kselftest, really all you are doing as a
> > subsystem maintainer is asking contributors or testers to run a 'make'
> > command right?  Everything else is already documented I think.
> >
> > >
> > > (2) is the area where I think this will be most useful. We have some
> > > arbitrary (probably .yaml) file which describes a series of tests to
> > > run in enough detail that we can automate it. My ideal outcome here
> > > would be to have a 'kunit.yaml' file which I can pass to a tool
> > > (either locally or automatically on some CI system) which will run al=
l
> > > of the checks I'd run on an incoming patch. This would include
> > > everything from checkpatch, to test builds, to running KUnit tests an=
d
> > > other test scripts. Ideally, it'd even run these across a bunch of
> > > different environments (architectures, emulators, hardware, etc) to
> > > catch issues which only show up on big-endian or 32-bit machines.
> > >
> > > If this means I can publish that yaml file somewhere, and not only
> > > give contributors a way to check that those tests pass on their own
> > > machine before sending a patch out, but also have CI systems
> > > automatically run them (so the results are ready waiting before I
> > > manually review the patch), that'd be ideal.
> >
> > Yes, that is exactly the goal of this exercise.  :-) but instead of a
> > kunit.yaml file, it is more of a test.yaml file with hundreds of
> > subystems inside it (and probably a corresponding get_tests.pl
> > script)[think how MAINTAINERS file operates and this is a sister
> > file].
> >
> > Inside the 'KUNIT' section would be a container of tests that would be
> > expected to run (like you listed).  Each test has its own command line
> > and params.
> >
>
> Yeah. My hope is we can have a "run_tests" tool which parses that
> file/files and runs everything.
>
> So whether that ends up being:
> run_tests --subsystem "KUNIT" --subsystem "MM"
> or
> run_test --file "kunit.yaml" --file "mm.yaml"
> or even
> run_test --patch "my_mm_and_kunit_change.patch"
>
> A CI system can just run it against the changed files in patches, a
> user who wants to double check something specific can override it to
> force the tests for a subsystem which may be indirectly affected. And
> if you're working on some new tests, or some private internal ones,
> you can keep your own yaml file and pass that along too.
>
> > >
> > > > Longer story.
> > > >
> > > > The current problem is CI systems are not unanimous about what test=
s
> > > > they run on submitted patches or git branches.  This makes it
> > > > difficult to figure out why a test failed or how to reproduce.
> > > > Further, it isn't always clear what tests a normal contributor shou=
ld
> > > > run before posting patches.
> > > >
> > > > It has been long communicated that the tests LTP, xfstest and/or
> > > > kselftests should be the tests  to run.  However, not all maintaine=
rs
> > > > use those tests for their subsystems.  I am hoping to either captur=
e
> > > > those tests or find ways to convince them to add their tests to the
> > > > preferred locations.
> > > >
> > > > The goal is for a given subsystem (defined in MAINTAINERS), define =
a
> > > > set of tests that should be run for any contributions to that
> > > > subsystem.  The hope is the collective CI results can be triaged
> > > > collectively (because they are related) and even have the numerous
> > > > flakes waived collectively  (same reason) improving the ability to
> > > > find and debug new test failures.  Because the tests and process ar=
e
> > > > known, having a human help debug any failures becomes easier.
> > > >
> > > > The plan is to put together a minimal yaml template that gets us go=
ing
> > > > (even if it is not optimized yet) and aim for about a dozen or so
> > > > subsystems.  At that point we should have enough feedback to promot=
e
> > > > this more seriously and talk optimizations.
> > > >
> > > > Feedback encouraged.
> > > >
> > > > Cheers,
> > > > Don
> > > >
> > > > ---
> > > > # List of tests by subsystem
> > >
> > > I think we should split this up into several files, partly to avoid
> > > merge conflicts, partly to make it easy to maintain custom collection=
s
> > > of tests separately.
> > >
> > > For example, fs.yaml could contain entries for both xfstests and fs
> > > KUnit and selftests.
> >
> > I am not opposed to the idea.  But I am a fan of the user experience.
> > So while an fs.yaml might sound good, is it obvious to a contributor
> > or tester that given a patch, do they know if fs.yaml is the correct
> > yaml file to parse when running tests?  How do you map a patch to a
> > yaml file?  I was trying to use subsystems like MAINTAINERS (and
> > get_maintainers.pl) as my mapping.  Open to better suggestions.
> >
>
> One option would be to have multiple files, which still have the
> MAINTAINERS subsystems listed within, and worst-case a tool just
> parses all of the files in that directory until it finds a matching
> one. Maybe a bit slower than having everything in the one file, but it
> sidesteps merge conflicts well.
>
> But ideally, I'd like (as mentioned below) to have a tool which I can
> use to run tests locally, and being able to run, e.g.,
> ./run_tests --all -f fs.yaml
> If I want to specify the tests I want to run manually, personally I
> think a filename would be a bit nicer than having to pass through,
> e.g., subsystem names.
>
>
> > >
> > > It's also probably going to be necessary to have separate sets of
> > > tests for different use-cases. For example, there might be a smaller,
> > > quicker set of tests to run on every patch, and a much longer, more
> > > expensive set which only runs every other day. So I don't think
> > > there'll even be a 1:1 mapping between 'test collections' (files) and
> > > subsystems. But an automated way of running "this collection of tests=
"
> > > would be very useful, particularly if it's more user-friendly than
> > > just writing a shell script (e.g., having nicely formatted output,
> > > being able to run things in parallel or remotely, etc).
> >
> > I don't disagree.  I am trying to start small to get things going and
> > some momentum.  I proposed a container of tests section.  I would like
> > to think adding another field in each individual test area like
> > (short, medium, long OR mandatory, performance, nice-to-have) would be
> > easy to add to the yaml file overall and attempt to accomplish what
> > you are suggesting.  Thoughts?
> >
>
> I think that'd be a great idea. Maybe a "stage" field could work, too,
> where later tests only run if the previous ones pass. For example:
> Stage 0: checkpatch, does it build
> Stage 1: KUnit tests, unit tests, single architecture
> Stage 2: Full boot tests, selftests, etc
> Stage 3: The above tests on other architectures, allyesconfig, randconfig=
, etc.
>
> Regardless, it'd be useful to be able to name individual tests and/or
> configurations and manually trigger them and/or filter on them.
>
> _Maybe_ it makes sense to split up the "what tests to run" and "how
> are they run" bits. The obvious split here would be to have the test
> catalogue just handle the former, and the "how they're run" bit
> entirely live in shell scripts. But if we're going to support running
> tests in parallel and nicely displaying results, maybe there'll be a
> need to have something more data driven than a shell script.
>
> > >
> > > > #
> > > > # Tests should adhere to KTAP definitions for results
> > > > #
> > > > # Description of section entries
> > > > #
> > > > #  maintainer:    test maintainer - name <email>
> > > > #  list:                mailing list for discussion
> > > > #  version:         stable version of the test
> > > > #  dependency: necessary distro package for testing
> > > > #  test:
> > > > #    path:            internal git path or url to fetch from
> > > > #    cmd:            command to run; ability to run locally
> > > > #    param:         additional param necessary to run test
> > > > #  hardware:      hardware necessary for validation
> > > > #
> > > > # Subsystems (alphabetical)
> > > >
> > > > KUNIT TEST:
> > >
> > > For KUnit, it'll be interesting to draw the distinction between KUnit
> > > overall and individual KUnit suites.
> > > I'd lean towards having a separate entry for each subsystem's KUnit
> > > tests (including one for KUnit's own tests)
> >
> > KUNIT may not have been the best 'common' test example due to its
> > complexities across other subsystems. :-/
> >
>
> Yeah: I think KUnit tests are a good example of the sorts of tests
> which would be relatively easy to integrate, but KUnit as a subsystem
> can be a bit confusing as an example because no-one's sure if we're
> talking about KUnit-the-subsystem or KUnit-the-tests.
>
> > >
> > > >   maintainer:
> > > >     - name: name1
> > > >       email: email1
> > > >     - name: name2
> > > >       email: email2
> > > >   list:
> > >
> > > How important is it to have these in the case where they're already i=
n
> > > the MAINTAINERS file? I can see it being important for tests which
> > > live elsewhere, though eventually, I'd still prefer the subsystem
> > > maintainer to take some responsibility for the tests run for their
> > > subsystems.
> >
> > I wasn't sure if all subsystem maintainers actually want to maintain
> > the tests too or just point someone else at it.  I look at LTP as an
> > example here.  But I could be wrong.
> >
>
> Fair enough. Maybe we just make this optional, and if empty we
> "default" to the subsystem maintainer.
>
> > >
> > > >   version:
> > >
> > > This field is probably unnecessary for test frameworks which live in
> > > the kernel tree.
> >
> > Possibly.  It was brought up at Plumbers, so I included it for complete=
ness.
> >
>
> Yeah. Again, good to have, but make it optional.
>
> > >
> > > >   dependency:
> > > >     - dep1
> > > >     - dep2
> > >
> > > If we want to automate this in any way, we're going to need to work
> > > out a way of specifying these. Either we'd have to pick a distro's
> > > package names, or have our own mapping.
> >
> > Agreed.  I might lean on what 'perf' outputs.  They do dependency
> > detection and output suggested missing packages.  Their auto detection
> > of already included deps is rather complicated though.
> >
>
> Sounds good.
>
> > >
> > > (A part of me really likes the idea of having a small list of "known"
> > > dependencies: python, docker, etc, and trying to limit tests to using
> > > those dependencies. Though there are plenty of useful tests with more
> > > complicated dependencies, so that probably won't fly forever.)
> >
> > Hehe.  For Fedora/RHEL at least, python has hundreds of smaller
> > library packages.  That is tricky.  And further some tests like to
> > compile, which means a bunch of -devel packages.  Each distro has
> > different names for their -devel packages. :-/
> > But a side goal of this effort is to define some community standards.
> > Perhaps we can influence things here to clean up this problem??
> >
>
> That'd be nice. :-)
>
> > >
> > > >   test:
> > > >     - path: tools/testing/kunit
> > > >       cmd:
> > > >       param:
> > > >     - path:
> > > >       cmd:
> > > >       param:
> > >
> > > Is 'path' here supposed to be the path to the test binary, the workin=
g
> > > directory, etc?
> > > Maybe there should be 'working_directory', 'cmd', 'args', and 'env'.
> >
> > The thought was the command to copy-n-paste to run the test after
> > installing it.  I am thinking most tests might be a git-clone or
> > exploded tarball, leaving the path to be from the install point.  So
> > maybe working_directory is more descriptive.
> >
>
> Sounds good. In the KUnit case, the tooling currently expects the
> working directory to be the root of the kernel checkout, and the
> command to be "./tools/testing/kunit/kunit.py"...
>
> > >
> > > >   hardware: none
> > >
> > >
> > >
> > > For KUnit, I'd imagine having a kunit.yaml, with something like this,
> > > including the KUnit tests in the 'kunit' and 'example' suites, and th=
e
> > > 'kunit_tool_test.py' test script:
> > >
> > > ---
> > > KUnit:
> > >   maintainer:
> > >     - name: David Gow
> > >       email: davidgow@google.com
> > >     - name: Brendan Higgins
> > >       email: brendan.higgins@linux.dev
> > >   list: kunit-dev@googlegroups.com
> > >   dependency:
> > >     - python3
> > >   test:
> > >     - path: .
> > >       cmd: tools/testing/kunit.py
> > >       param: run kunit
> > >     - path: .
> > >       cmd: tools/testing/kunit.py
> > >       param: run example
> > >   hardware: none
> > > KUnit Tool:
> > >   maintainer:
> > >     - name: David Gow
> > >       email: davidgow@google.com
> > >     - name: Brendan Higgins
> > >       email: brendan.higgins@linux.dev
> > >   list: kunit-dev@googlegroups.com
> > >   dependency:
> > >     - python3
> > >   test:
> > >     - path: .
> > >       cmd: tools/testing/kunit_tool_test.py
> > >       param:
> > >   hardware: none
> > > ---
> > >
> > > Obviously there's still some redundancy there, and I've not actually
> > > tried implementing something that could run it. It also lacks any
> > > information about the environment. In practice, I have about 20
> > > different kunit.py invocations which run the tests with different
> > > configs and on different architectures. Though that might make sense
> > > to keep in a separate file to only run if the simpler tests pass. And
> > > equally, it'd be nice to have a 'common.yaml' file with basic patch
> > > and build tests which apply to almost everything (checkpatch, make
> > > defconfig, maybe even make allmodconfig, etc).
> >
> > Nice, thanks for the more detailed example.
> >
>
> Thanks,
> -- David


