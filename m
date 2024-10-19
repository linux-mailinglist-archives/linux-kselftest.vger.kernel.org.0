Return-Path: <linux-kselftest+bounces-20189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8575E9A4B8F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 08:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37261F21BFC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF41DC07B;
	Sat, 19 Oct 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2rLJYgt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E11D95BE
	for <linux-kselftest@vger.kernel.org>; Sat, 19 Oct 2024 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729319800; cv=none; b=RdCAJckPxinlFSAj6NxMRVulalth2+FN45kAoSTOrSe/QolMlyzDQWIC3PqtxbzyGNqjEFgM0z8LATqgUPaQZ51bREKHAbA5e4fxXXKLt7UAEbRDv6NsrdY2LWLbDV7hQOJoEaBu+/8aXHLIM6ARn2dMFrhmRGADD4Ffz3QEmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729319800; c=relaxed/simple;
	bh=ybClTSxbLINvyDwxmqI2HmXJrJvUIE4tjG0+KfcqBS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMff27qToZDVQxEoNqfOK0DqqcsTttFKGloEHbeOe7KDkexklggwmfXMkDCGGU1TMT5y/L5Zx6eK0PPaKpQ/cJjbqB9e/e0feQN8Ip+vCY+eT+R23D8uZ6WmROHhimtMSUiW7Vd+u22XZuJEbuN5AMHkq0dNEVzEFfzSjBOZ5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2rLJYgt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbce16d151so15659326d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 23:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729319796; x=1729924596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv8yjSpiJOBuSMuYbK38aWOW3XQEzRijs+PzU844yTs=;
        b=s2rLJYgthCrSpO7yPfM5GBcgNw7RxGi96MLlNnQtbmXojsBRSVg4Hv3IDVAwD3PeZB
         pXAlz3KoLoNciqlDSBgDU2uHG/AvdMgBZR/BAmsxOOI2AalN5GBK+NIp6MgsvBoC8iyx
         mQOpaizxiQxLEO0ZBVoyI0Hw+dHkZCG69wa6DOnGqmMk4NTRrCDSBrwQJxUPFb100kK9
         uEmpInDu5cm5RlkofXUkQ+KErxZb2uAQMzOvj7OTKk9rFU6u7WFskg9kzGxMWCPDZJLZ
         /2WV2eSDPlPJsZ9t/KTzohvUje0iIkyVDuixzNMQhCWBf/w2Waa1Hm+SgvIbsGXRRcL5
         YGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729319796; x=1729924596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv8yjSpiJOBuSMuYbK38aWOW3XQEzRijs+PzU844yTs=;
        b=va+Kx2e3847YwuS9uPXn259zWiYGDA5sEV+gyglW5ixxEwxLDUQNQrPoXsCleK4Dat
         Zr7Q8+DGTW33ckGlfHo+yimt+jjPKETj6bgEXF5HDkiNuVuSOK8TicPPpeVhM8raG3oB
         G7SwBAwmdHa6tuHBSylSbonSaRLfHpiaLgekAF1Kj+5vRvKBoCkO9RO+fFxMHlo0nNlP
         hEAdiM7vOTgdsoGyMiO6RQ4DW+WmS+GSFJB4D4XmvClk4SaoSIl8hS4nT2LfxeeRM4Br
         uRnmxQ4kS6p1pEOINlcQ3odmYQyrC/eJRX8RBbDxiB6oxHT5TO5odnYetO5IEie4JEoC
         clTw==
X-Forwarded-Encrypted: i=1; AJvYcCWVQRtIv0dqO4kuN814syuVCrDisfnMMrFRvIhKJhaELt1Zv8Jt6YUDdkORBtIBqtBSsu6Fhzdrsw3219SCAiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGLD9pvxnx9YWg/mncvQxYsvoEeLVPjQ6gfl8Gdo2JuCdOQEN
	swp77pjwtrYTwH2qw0YNj6EyLAI176e4hJkoIIVLAYvAnhbnHbAJDpOEYdp2XBkWgGXZhBpKXXp
	IznJ9zaJdBOPcy7sU402xQKVK69WQRw/e0QI7M423kxNfVmSKyC+I
X-Google-Smtp-Source: AGHT+IEgE4jXcbwYTKuhtKFoeszKpbbMkf4rEgQ/nZQ82rt9nvI3vvbs49fXm1nxOAk3GhZ1T5LhPZXn75A5yiHvErw=
X-Received: by 2002:a05:6214:5544:b0:6cb:ef8d:b10 with SMTP id
 6a1803df08f44-6cde15f18f9mr76424596d6.39.1729319796156; Fri, 18 Oct 2024
 23:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com> <CAK18DXZtBdxQdYY06X+Q=vYybnkCLBQBioCLqvSfkYZ21jBSWg@mail.gmail.com>
In-Reply-To: <CAK18DXZtBdxQdYY06X+Q=vYybnkCLBQBioCLqvSfkYZ21jBSWg@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 19 Oct 2024 14:36:22 +0800
Message-ID: <CABVgOSkBF3fT5JdVCEpBRvO1V8ZgZ-dD7fvxcv7Rxb_XPcFNbg@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
To: Donald Zickus <dzickus@redhat.com>
Cc: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000321a2c0624cea4d4"

--000000000000321a2c0624cea4d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Oct 2024 at 04:17, Donald Zickus <dzickus@redhat.com> wrote:
>
> On Fri, Oct 18, 2024 at 3:22=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > Hi Don,
> >
> > Thanks for putting this together: the discussion at Plumbers was very u=
seful.
> >
> > On Tue, 15 Oct 2024 at 04:33, Donald Zickus <dzickus@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > At Linux Plumbers, a few dozen of us gathered together to discuss how
> > > to expose what tests subsystem maintainers would like to run for ever=
y
> > > patch submitted or when CI runs tests.  We agreed on a mock up of a
> > > yaml template to start gathering info.  The yaml file could be
> > > temporarily stored on kernelci.org until a more permanent home could
> > > be found.  Attached is a template to start the conversation.
> > >
> >
> > I think that there are two (maybe three) separate problems here:
> > 1. What tests do we want to run (for a given patch/subsystem/environmen=
t/etc)?
>
> My thinking is this is maintainer's choice.  What would they like to
> see run on a patch to verify its correctness?  I would like to think
> most maintainers already have scripts they run before commiting
> patches to their -next branch.  All I am trying to do is expose what
> is already being done I believe.
>

Agreed.

>
> > 2. How do we describe those tests in such a way that running them can
> > be automated?
>
> This is the tricky part.  But I am going to assume that if most
> maintainers run tests before committing patches to their -next branch,
> then there is a good chance those tests are scripted and command line
> driven (this is the kernel community, right :-) ).  So if we could
> expose those scripts and make the copy-and-pastable such that
> contributors or testers (including CI bots) can just copy and run
> them.  Some maintainers have more complex environments and separating
> command line driven tests from the environment scripts might be
> tricky.
>
> Does that sound reasonable?

Yeah: that's basically what I'd want.

>
> > 3. (Exactly what constitutes a 'test'? A single 'test', a whole suite
> > of tests, a test framework/tool? What about the environment: is, e.g.,
> > KUnit on UML different from KUnit on qemu-x86_64 different from KUnit
> > on qemu-arm64?)
> >
> > My gut feeling here is that (1) is technically quite easy: worst-case
> > we just make every MAINTAINERS entry link to a document describing
> > what tests should be run. Actually getting people to write these
> > documents and then run the tests, though, is very difficult.
>
> Well if I look at kunit or kselftest, really all you are doing as a
> subsystem maintainer is asking contributors or testers to run a 'make'
> command right?  Everything else is already documented I think.
>
> >
> > (2) is the area where I think this will be most useful. We have some
> > arbitrary (probably .yaml) file which describes a series of tests to
> > run in enough detail that we can automate it. My ideal outcome here
> > would be to have a 'kunit.yaml' file which I can pass to a tool
> > (either locally or automatically on some CI system) which will run all
> > of the checks I'd run on an incoming patch. This would include
> > everything from checkpatch, to test builds, to running KUnit tests and
> > other test scripts. Ideally, it'd even run these across a bunch of
> > different environments (architectures, emulators, hardware, etc) to
> > catch issues which only show up on big-endian or 32-bit machines.
> >
> > If this means I can publish that yaml file somewhere, and not only
> > give contributors a way to check that those tests pass on their own
> > machine before sending a patch out, but also have CI systems
> > automatically run them (so the results are ready waiting before I
> > manually review the patch), that'd be ideal.
>
> Yes, that is exactly the goal of this exercise.  :-) but instead of a
> kunit.yaml file, it is more of a test.yaml file with hundreds of
> subystems inside it (and probably a corresponding get_tests.pl
> script)[think how MAINTAINERS file operates and this is a sister
> file].
>
> Inside the 'KUNIT' section would be a container of tests that would be
> expected to run (like you listed).  Each test has its own command line
> and params.
>

Yeah. My hope is we can have a "run_tests" tool which parses that
file/files and runs everything.

So whether that ends up being:
run_tests --subsystem "KUNIT" --subsystem "MM"
or
run_test --file "kunit.yaml" --file "mm.yaml"
or even
run_test --patch "my_mm_and_kunit_change.patch"

A CI system can just run it against the changed files in patches, a
user who wants to double check something specific can override it to
force the tests for a subsystem which may be indirectly affected. And
if you're working on some new tests, or some private internal ones,
you can keep your own yaml file and pass that along too.

> >
> > > Longer story.
> > >
> > > The current problem is CI systems are not unanimous about what tests
> > > they run on submitted patches or git branches.  This makes it
> > > difficult to figure out why a test failed or how to reproduce.
> > > Further, it isn't always clear what tests a normal contributor should
> > > run before posting patches.
> > >
> > > It has been long communicated that the tests LTP, xfstest and/or
> > > kselftests should be the tests  to run.  However, not all maintainers
> > > use those tests for their subsystems.  I am hoping to either capture
> > > those tests or find ways to convince them to add their tests to the
> > > preferred locations.
> > >
> > > The goal is for a given subsystem (defined in MAINTAINERS), define a
> > > set of tests that should be run for any contributions to that
> > > subsystem.  The hope is the collective CI results can be triaged
> > > collectively (because they are related) and even have the numerous
> > > flakes waived collectively  (same reason) improving the ability to
> > > find and debug new test failures.  Because the tests and process are
> > > known, having a human help debug any failures becomes easier.
> > >
> > > The plan is to put together a minimal yaml template that gets us goin=
g
> > > (even if it is not optimized yet) and aim for about a dozen or so
> > > subsystems.  At that point we should have enough feedback to promote
> > > this more seriously and talk optimizations.
> > >
> > > Feedback encouraged.
> > >
> > > Cheers,
> > > Don
> > >
> > > ---
> > > # List of tests by subsystem
> >
> > I think we should split this up into several files, partly to avoid
> > merge conflicts, partly to make it easy to maintain custom collections
> > of tests separately.
> >
> > For example, fs.yaml could contain entries for both xfstests and fs
> > KUnit and selftests.
>
> I am not opposed to the idea.  But I am a fan of the user experience.
> So while an fs.yaml might sound good, is it obvious to a contributor
> or tester that given a patch, do they know if fs.yaml is the correct
> yaml file to parse when running tests?  How do you map a patch to a
> yaml file?  I was trying to use subsystems like MAINTAINERS (and
> get_maintainers.pl) as my mapping.  Open to better suggestions.
>

One option would be to have multiple files, which still have the
MAINTAINERS subsystems listed within, and worst-case a tool just
parses all of the files in that directory until it finds a matching
one. Maybe a bit slower than having everything in the one file, but it
sidesteps merge conflicts well.

But ideally, I'd like (as mentioned below) to have a tool which I can
use to run tests locally, and being able to run, e.g.,
./run_tests --all -f fs.yaml
If I want to specify the tests I want to run manually, personally I
think a filename would be a bit nicer than having to pass through,
e.g., subsystem names.


> >
> > It's also probably going to be necessary to have separate sets of
> > tests for different use-cases. For example, there might be a smaller,
> > quicker set of tests to run on every patch, and a much longer, more
> > expensive set which only runs every other day. So I don't think
> > there'll even be a 1:1 mapping between 'test collections' (files) and
> > subsystems. But an automated way of running "this collection of tests"
> > would be very useful, particularly if it's more user-friendly than
> > just writing a shell script (e.g., having nicely formatted output,
> > being able to run things in parallel or remotely, etc).
>
> I don't disagree.  I am trying to start small to get things going and
> some momentum.  I proposed a container of tests section.  I would like
> to think adding another field in each individual test area like
> (short, medium, long OR mandatory, performance, nice-to-have) would be
> easy to add to the yaml file overall and attempt to accomplish what
> you are suggesting.  Thoughts?
>

I think that'd be a great idea. Maybe a "stage" field could work, too,
where later tests only run if the previous ones pass. For example:
Stage 0: checkpatch, does it build
Stage 1: KUnit tests, unit tests, single architecture
Stage 2: Full boot tests, selftests, etc
Stage 3: The above tests on other architectures, allyesconfig, randconfig, =
etc.

Regardless, it'd be useful to be able to name individual tests and/or
configurations and manually trigger them and/or filter on them.

_Maybe_ it makes sense to split up the "what tests to run" and "how
are they run" bits. The obvious split here would be to have the test
catalogue just handle the former, and the "how they're run" bit
entirely live in shell scripts. But if we're going to support running
tests in parallel and nicely displaying results, maybe there'll be a
need to have something more data driven than a shell script.

> >
> > > #
> > > # Tests should adhere to KTAP definitions for results
> > > #
> > > # Description of section entries
> > > #
> > > #  maintainer:    test maintainer - name <email>
> > > #  list:                mailing list for discussion
> > > #  version:         stable version of the test
> > > #  dependency: necessary distro package for testing
> > > #  test:
> > > #    path:            internal git path or url to fetch from
> > > #    cmd:            command to run; ability to run locally
> > > #    param:         additional param necessary to run test
> > > #  hardware:      hardware necessary for validation
> > > #
> > > # Subsystems (alphabetical)
> > >
> > > KUNIT TEST:
> >
> > For KUnit, it'll be interesting to draw the distinction between KUnit
> > overall and individual KUnit suites.
> > I'd lean towards having a separate entry for each subsystem's KUnit
> > tests (including one for KUnit's own tests)
>
> KUNIT may not have been the best 'common' test example due to its
> complexities across other subsystems. :-/
>

Yeah: I think KUnit tests are a good example of the sorts of tests
which would be relatively easy to integrate, but KUnit as a subsystem
can be a bit confusing as an example because no-one's sure if we're
talking about KUnit-the-subsystem or KUnit-the-tests.

> >
> > >   maintainer:
> > >     - name: name1
> > >       email: email1
> > >     - name: name2
> > >       email: email2
> > >   list:
> >
> > How important is it to have these in the case where they're already in
> > the MAINTAINERS file? I can see it being important for tests which
> > live elsewhere, though eventually, I'd still prefer the subsystem
> > maintainer to take some responsibility for the tests run for their
> > subsystems.
>
> I wasn't sure if all subsystem maintainers actually want to maintain
> the tests too or just point someone else at it.  I look at LTP as an
> example here.  But I could be wrong.
>

Fair enough. Maybe we just make this optional, and if empty we
"default" to the subsystem maintainer.

> >
> > >   version:
> >
> > This field is probably unnecessary for test frameworks which live in
> > the kernel tree.
>
> Possibly.  It was brought up at Plumbers, so I included it for completene=
ss.
>

Yeah. Again, good to have, but make it optional.

> >
> > >   dependency:
> > >     - dep1
> > >     - dep2
> >
> > If we want to automate this in any way, we're going to need to work
> > out a way of specifying these. Either we'd have to pick a distro's
> > package names, or have our own mapping.
>
> Agreed.  I might lean on what 'perf' outputs.  They do dependency
> detection and output suggested missing packages.  Their auto detection
> of already included deps is rather complicated though.
>

Sounds good.

> >
> > (A part of me really likes the idea of having a small list of "known"
> > dependencies: python, docker, etc, and trying to limit tests to using
> > those dependencies. Though there are plenty of useful tests with more
> > complicated dependencies, so that probably won't fly forever.)
>
> Hehe.  For Fedora/RHEL at least, python has hundreds of smaller
> library packages.  That is tricky.  And further some tests like to
> compile, which means a bunch of -devel packages.  Each distro has
> different names for their -devel packages. :-/
> But a side goal of this effort is to define some community standards.
> Perhaps we can influence things here to clean up this problem??
>

That'd be nice. :-)

> >
> > >   test:
> > >     - path: tools/testing/kunit
> > >       cmd:
> > >       param:
> > >     - path:
> > >       cmd:
> > >       param:
> >
> > Is 'path' here supposed to be the path to the test binary, the working
> > directory, etc?
> > Maybe there should be 'working_directory', 'cmd', 'args', and 'env'.
>
> The thought was the command to copy-n-paste to run the test after
> installing it.  I am thinking most tests might be a git-clone or
> exploded tarball, leaving the path to be from the install point.  So
> maybe working_directory is more descriptive.
>

Sounds good. In the KUnit case, the tooling currently expects the
working directory to be the root of the kernel checkout, and the
command to be "./tools/testing/kunit/kunit.py"...

> >
> > >   hardware: none
> >
> >
> >
> > For KUnit, I'd imagine having a kunit.yaml, with something like this,
> > including the KUnit tests in the 'kunit' and 'example' suites, and the
> > 'kunit_tool_test.py' test script:
> >
> > ---
> > KUnit:
> >   maintainer:
> >     - name: David Gow
> >       email: davidgow@google.com
> >     - name: Brendan Higgins
> >       email: brendan.higgins@linux.dev
> >   list: kunit-dev@googlegroups.com
> >   dependency:
> >     - python3
> >   test:
> >     - path: .
> >       cmd: tools/testing/kunit.py
> >       param: run kunit
> >     - path: .
> >       cmd: tools/testing/kunit.py
> >       param: run example
> >   hardware: none
> > KUnit Tool:
> >   maintainer:
> >     - name: David Gow
> >       email: davidgow@google.com
> >     - name: Brendan Higgins
> >       email: brendan.higgins@linux.dev
> >   list: kunit-dev@googlegroups.com
> >   dependency:
> >     - python3
> >   test:
> >     - path: .
> >       cmd: tools/testing/kunit_tool_test.py
> >       param:
> >   hardware: none
> > ---
> >
> > Obviously there's still some redundancy there, and I've not actually
> > tried implementing something that could run it. It also lacks any
> > information about the environment. In practice, I have about 20
> > different kunit.py invocations which run the tests with different
> > configs and on different architectures. Though that might make sense
> > to keep in a separate file to only run if the simpler tests pass. And
> > equally, it'd be nice to have a 'common.yaml' file with basic patch
> > and build tests which apply to almost everything (checkpatch, make
> > defconfig, maybe even make allmodconfig, etc).
>
> Nice, thanks for the more detailed example.
>

Thanks,
-- David

--000000000000321a2c0624cea4d4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgU3cI33P42SQODEn3whGxA4Djpkeg
6v30K7t/3TEB2o8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDE5MDYzNjM2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBADrY7J8k286CIyBd6yqW9TgaVeqH73pdx6aw8hZ1szOfdJBu
baVqR97upgiVScLmcrALOayiXdLy7jac02tkgkZ67uJKhm/sUsZCXx7rO77mjYMwGaqul2DruMjj
EGN7yPdsWwbKbqI7qgVmzwpec20KV5tkYeEYAjWSmdy9uu/YSQ9yrueB/LqjzkCnZ5CidPXrax7F
a9Ad34Uibf37l89za/KKPzqS/K7rKDscRkWOS3MHmd9/y1OiwVEEglUrkvaf6Rw0xwdDRaGTpA5r
5cJlZoPN5871KfhUVkKolQ11mKPGX0/RvXeQgm50KBhJJl3T6Hd3DHH+RGGQlNt+TxQ=
--000000000000321a2c0624cea4d4--

