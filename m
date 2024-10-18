Return-Path: <linux-kselftest+bounces-20174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D49A47BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 22:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA998282CFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523B218C03F;
	Fri, 18 Oct 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVy19Hhw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AB1547C3
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282654; cv=none; b=rccK0ceOIoWhdYCqQUcyP9u/znoJh9/w+bYIonYESzfDue9YMQKgm6rthdPeyEqlvTtWCfoeuUPwc8HM0PD6uoIFMC8W372ONDfoNgX6CR3qo8C7o1G4zdhcmwnRvIAFC5jSoj7b6sRI/7ET0B3heEW4hN8oLjvJ56b0N5Fzhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282654; c=relaxed/simple;
	bh=yhbjXMciGwC8kCtt68DLHeWJh2KGB6zIn4NSga0I7OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhCT+bgtHvmlkQ3wiz1i/WYwjsuLZiko29yAcIFOBiGQ5uCn0jDPKUa2k+Ch7vvuqyeqhFpwKf9LvRY03JM080bIof/fXFytdLoKArrHBFjIrc14AAKQ9fQaAy0CrN+D76dRkpY/sbcLcAD8rxl5hSGa8NQOfdQYT7S1cIKN+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVy19Hhw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729282650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbnmlN4w8zqivsHbL3mw7REsYVzkigS6r5daWEI1haQ=;
	b=gVy19HhwscyBLuE73p9+GSmFvT9Aj4MjrIvsRNKjh/wvjpqtKM8NM8YhK+W7EQPXcleOI5
	8wBTXIBz8m5T8BlOsUftKwyrfYTFb40svfIMncgc6GKBA1h1ZFu5DjieEsdOCxUbZWwIvo
	xe34+2pTK6uj0bqay2UaiMoF7KYRlkA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-xDRuZf0kMaKEZ7vf3wchhg-1; Fri, 18 Oct 2024 16:17:29 -0400
X-MC-Unique: xDRuZf0kMaKEZ7vf3wchhg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so44419747b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 13:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729282649; x=1729887449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbnmlN4w8zqivsHbL3mw7REsYVzkigS6r5daWEI1haQ=;
        b=XsUtxgm7Tda+SdChfnBOrL6Jcva276FNB5903KAWiQRvgE/89Bh8XUgeFelE/iEXI4
         k4mHzol6Dhkn5SjANzxON1y8Xhg980KTmZFjv0poRzEciuGPOWy71CZb37B3lP+0ZdMR
         EVtZDV5V96QLWkxW3ih6LSQObYx/9rJ+aNEDct4fPFXqqLPmeUHYBJ7mfIePbIMXQqGi
         +y+P0f6N+zU95WrCoHlqNUOJiYTBws4o6hh5CVnzkFcU1MDpy2FCjegEV+HBtu6OnEmH
         ep5X2KK7+f9vrk5bTeK9zgVMz2eJZyY3nlttYkqLEpor8mEwYRdhXmqtZZoAAoaGizeq
         erCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYIW1q+eS+ZDMxtlPvfw6Pcbg+CeyGUnm1mTX47OnC8hEbcsyqJ54Y5qkNICI0nzfZY6DM2jQcJVfefg2XpWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+QjsTEG7peVgsK0rS6WKGLv0lMT6Iq2sQwLjP87sFn3fWDIJ
	5SD1xUx+VDGP3jY24dCXbwWQEEmZOUH6VmmC7xOxACv0YTBZP8Wg6fByEOTNUPdXE34cWve9tuX
	ALVrNsHgttkPeMXQkphVYkN3lN/7K/Ed901VRhu0jZ+T6lkoG9DUCIm4FaWffON7Cs0LOcWVlgu
	4uRDr73P0SlzZcqAUnRrdrW6A1+WnRxCOhg3Vnms97YVCd8YUD
X-Received: by 2002:a05:690c:102:b0:6b2:28c3:b706 with SMTP id 00721157ae682-6e5bfd4e9a8mr30874387b3.34.1729282648692;
        Fri, 18 Oct 2024 13:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGowxvJ0ukN32Bngs1BmEaLRkLlyu3um1V4EwoDJhFP9p93Rj0yIlNx1nP5A5pFV3GehApCp89fAT9p50wOdGs=
X-Received: by 2002:a05:690c:102:b0:6b2:28c3:b706 with SMTP id
 00721157ae682-6e5bfd4e9a8mr30874117b3.34.1729282648217; Fri, 18 Oct 2024
 13:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
In-Reply-To: <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
From: Donald Zickus <dzickus@redhat.com>
Date: Fri, 18 Oct 2024 16:17:16 -0400
Message-ID: <CAK18DXZtBdxQdYY06X+Q=vYybnkCLBQBioCLqvSfkYZ21jBSWg@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
To: David Gow <davidgow@google.com>
Cc: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:22=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Hi Don,
>
> Thanks for putting this together: the discussion at Plumbers was very use=
ful.
>
> On Tue, 15 Oct 2024 at 04:33, Donald Zickus <dzickus@redhat.com> wrote:
> >
> > Hi,
> >
> > At Linux Plumbers, a few dozen of us gathered together to discuss how
> > to expose what tests subsystem maintainers would like to run for every
> > patch submitted or when CI runs tests.  We agreed on a mock up of a
> > yaml template to start gathering info.  The yaml file could be
> > temporarily stored on kernelci.org until a more permanent home could
> > be found.  Attached is a template to start the conversation.
> >
>
> I think that there are two (maybe three) separate problems here:
> 1. What tests do we want to run (for a given patch/subsystem/environment/=
etc)?

My thinking is this is maintainer's choice.  What would they like to
see run on a patch to verify its correctness?  I would like to think
most maintainers already have scripts they run before commiting
patches to their -next branch.  All I am trying to do is expose what
is already being done I believe.


> 2. How do we describe those tests in such a way that running them can
> be automated?

This is the tricky part.  But I am going to assume that if most
maintainers run tests before committing patches to their -next branch,
then there is a good chance those tests are scripted and command line
driven (this is the kernel community, right :-) ).  So if we could
expose those scripts and make the copy-and-pastable such that
contributors or testers (including CI bots) can just copy and run
them.  Some maintainers have more complex environments and separating
command line driven tests from the environment scripts might be
tricky.

Does that sound reasonable?

> 3. (Exactly what constitutes a 'test'? A single 'test', a whole suite
> of tests, a test framework/tool? What about the environment: is, e.g.,
> KUnit on UML different from KUnit on qemu-x86_64 different from KUnit
> on qemu-arm64?)
>
> My gut feeling here is that (1) is technically quite easy: worst-case
> we just make every MAINTAINERS entry link to a document describing
> what tests should be run. Actually getting people to write these
> documents and then run the tests, though, is very difficult.

Well if I look at kunit or kselftest, really all you are doing as a
subsystem maintainer is asking contributors or testers to run a 'make'
command right?  Everything else is already documented I think.

>
> (2) is the area where I think this will be most useful. We have some
> arbitrary (probably .yaml) file which describes a series of tests to
> run in enough detail that we can automate it. My ideal outcome here
> would be to have a 'kunit.yaml' file which I can pass to a tool
> (either locally or automatically on some CI system) which will run all
> of the checks I'd run on an incoming patch. This would include
> everything from checkpatch, to test builds, to running KUnit tests and
> other test scripts. Ideally, it'd even run these across a bunch of
> different environments (architectures, emulators, hardware, etc) to
> catch issues which only show up on big-endian or 32-bit machines.
>
> If this means I can publish that yaml file somewhere, and not only
> give contributors a way to check that those tests pass on their own
> machine before sending a patch out, but also have CI systems
> automatically run them (so the results are ready waiting before I
> manually review the patch), that'd be ideal.

Yes, that is exactly the goal of this exercise.  :-) but instead of a
kunit.yaml file, it is more of a test.yaml file with hundreds of
subystems inside it (and probably a corresponding get_tests.pl
script)[think how MAINTAINERS file operates and this is a sister
file].

Inside the 'KUNIT' section would be a container of tests that would be
expected to run (like you listed).  Each test has its own command line
and params.


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
> > kselftests should be the tests  to run.  However, not all maintainers
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
> >
> > Feedback encouraged.
> >
> > Cheers,
> > Don
> >
> > ---
> > # List of tests by subsystem
>
> I think we should split this up into several files, partly to avoid
> merge conflicts, partly to make it easy to maintain custom collections
> of tests separately.
>
> For example, fs.yaml could contain entries for both xfstests and fs
> KUnit and selftests.

I am not opposed to the idea.  But I am a fan of the user experience.
So while an fs.yaml might sound good, is it obvious to a contributor
or tester that given a patch, do they know if fs.yaml is the correct
yaml file to parse when running tests?  How do you map a patch to a
yaml file?  I was trying to use subsystems like MAINTAINERS (and
get_maintainers.pl) as my mapping.  Open to better suggestions.

>
> It's also probably going to be necessary to have separate sets of
> tests for different use-cases. For example, there might be a smaller,
> quicker set of tests to run on every patch, and a much longer, more
> expensive set which only runs every other day. So I don't think
> there'll even be a 1:1 mapping between 'test collections' (files) and
> subsystems. But an automated way of running "this collection of tests"
> would be very useful, particularly if it's more user-friendly than
> just writing a shell script (e.g., having nicely formatted output,
> being able to run things in parallel or remotely, etc).

I don't disagree.  I am trying to start small to get things going and
some momentum.  I proposed a container of tests section.  I would like
to think adding another field in each individual test area like
(short, medium, long OR mandatory, performance, nice-to-have) would be
easy to add to the yaml file overall and attempt to accomplish what
you are suggesting.  Thoughts?


>
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
> > #
> > # Subsystems (alphabetical)
> >
> > KUNIT TEST:
>
> For KUnit, it'll be interesting to draw the distinction between KUnit
> overall and individual KUnit suites.
> I'd lean towards having a separate entry for each subsystem's KUnit
> tests (including one for KUnit's own tests)

KUNIT may not have been the best 'common' test example due to its
complexities across other subsystems. :-/

>
> >   maintainer:
> >     - name: name1
> >       email: email1
> >     - name: name2
> >       email: email2
> >   list:
>
> How important is it to have these in the case where they're already in
> the MAINTAINERS file? I can see it being important for tests which
> live elsewhere, though eventually, I'd still prefer the subsystem
> maintainer to take some responsibility for the tests run for their
> subsystems.

I wasn't sure if all subsystem maintainers actually want to maintain
the tests too or just point someone else at it.  I look at LTP as an
example here.  But I could be wrong.

>
> >   version:
>
> This field is probably unnecessary for test frameworks which live in
> the kernel tree.

Possibly.  It was brought up at Plumbers, so I included it for completeness=
.

>
> >   dependency:
> >     - dep1
> >     - dep2
>
> If we want to automate this in any way, we're going to need to work
> out a way of specifying these. Either we'd have to pick a distro's
> package names, or have our own mapping.

Agreed.  I might lean on what 'perf' outputs.  They do dependency
detection and output suggested missing packages.  Their auto detection
of already included deps is rather complicated though.

>
> (A part of me really likes the idea of having a small list of "known"
> dependencies: python, docker, etc, and trying to limit tests to using
> those dependencies. Though there are plenty of useful tests with more
> complicated dependencies, so that probably won't fly forever.)

Hehe.  For Fedora/RHEL at least, python has hundreds of smaller
library packages.  That is tricky.  And further some tests like to
compile, which means a bunch of -devel packages.  Each distro has
different names for their -devel packages. :-/
But a side goal of this effort is to define some community standards.
Perhaps we can influence things here to clean up this problem??

>
> >   test:
> >     - path: tools/testing/kunit
> >       cmd:
> >       param:
> >     - path:
> >       cmd:
> >       param:
>
> Is 'path' here supposed to be the path to the test binary, the working
> directory, etc?
> Maybe there should be 'working_directory', 'cmd', 'args', and 'env'.

The thought was the command to copy-n-paste to run the test after
installing it.  I am thinking most tests might be a git-clone or
exploded tarball, leaving the path to be from the install point.  So
maybe working_directory is more descriptive.

>
> >   hardware: none
>
>
>
> For KUnit, I'd imagine having a kunit.yaml, with something like this,
> including the KUnit tests in the 'kunit' and 'example' suites, and the
> 'kunit_tool_test.py' test script:
>
> ---
> KUnit:
>   maintainer:
>     - name: David Gow
>       email: davidgow@google.com
>     - name: Brendan Higgins
>       email: brendan.higgins@linux.dev
>   list: kunit-dev@googlegroups.com
>   dependency:
>     - python3
>   test:
>     - path: .
>       cmd: tools/testing/kunit.py
>       param: run kunit
>     - path: .
>       cmd: tools/testing/kunit.py
>       param: run example
>   hardware: none
> KUnit Tool:
>   maintainer:
>     - name: David Gow
>       email: davidgow@google.com
>     - name: Brendan Higgins
>       email: brendan.higgins@linux.dev
>   list: kunit-dev@googlegroups.com
>   dependency:
>     - python3
>   test:
>     - path: .
>       cmd: tools/testing/kunit_tool_test.py
>       param:
>   hardware: none
> ---
>
> Obviously there's still some redundancy there, and I've not actually
> tried implementing something that could run it. It also lacks any
> information about the environment. In practice, I have about 20
> different kunit.py invocations which run the tests with different
> configs and on different architectures. Though that might make sense
> to keep in a separate file to only run if the simpler tests pass. And
> equally, it'd be nice to have a 'common.yaml' file with basic patch
> and build tests which apply to almost everything (checkpatch, make
> defconfig, maybe even make allmodconfig, etc).

Nice, thanks for the more detailed example.

Cheers,
Don

>
> Cheers,
> -- David


