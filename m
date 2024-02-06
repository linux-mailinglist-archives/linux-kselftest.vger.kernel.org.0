Return-Path: <linux-kselftest+bounces-4172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133D84AD4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 05:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B931C286840
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 04:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7A745FE;
	Tue,  6 Feb 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8J1+uTE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEE2595
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192752; cv=none; b=iX3BgbDGGT9XB86qQkyYa3PCUNuwjxsfIRP+8k9gDOU/2ULxvPpW+nyiG0Yd+HH+wVcJSxZ5r8bAm6rgaA4z9okbc1nlZHvhLYnTyk2t0b3UqLAMcWafzLClTH0cy4bm9FxW5xFoG9mupm1HKZ/RCBT27vIsWQYaQWA0rgUTK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192752; c=relaxed/simple;
	bh=p6pDRVuP/GtHoWtwmtvF9N2pvBRkWaKdOuI1zGCGorY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP8ISthRVqSYUAFD/XBXwWKMVj/Ziz80CttdwltXb6Fp4kyUXaGtpPHXyydag1rw9IPzBdjNoonKI4eJWthsbMzR+pDNmmR0QGa07Z4MSnmruBt8kdVxnpL8CZIPNU2Uuy6vlcQGoId3aK4VAPExdJSQpFF1KZa1RWfNdYfrXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8J1+uTE; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363be58d093so51125ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 20:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707192749; x=1707797549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoyvBngHQWoJ2zRLfzbBaT3nu2E4IaDKEVn0kq2H6RU=;
        b=f8J1+uTEhGeZnUqPRu4Zkxf7IMDkd+u+cDkQsD3TfsvyzOi43XxtbFfEp+pyZyANc0
         +MS5wQiNVpJyZfv7M+zWg0SbBekDRMgN5y3hhsUwVmddoZrBlDb4NlKHcA51zl2Q+KGM
         vSaTcqT/4SpXdu4DFfuF2ZxrRc1EhjxagZBO7Kr2S81QpWbItwwgvgrla5EJKYmAqEEI
         +sLJlfJ8crpuC0xi3LVqthKEpgmxU2PCji2D1NHANu32Gzrdcd6PsVCg4tWfnKNzRrn4
         l5kkmnmQ+qE3AnF5x4iMIh40T5qrXA7o0/dtrP5m5LnV+R45dfDxjKBbyxZsf2oOfOfQ
         kCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192749; x=1707797549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoyvBngHQWoJ2zRLfzbBaT3nu2E4IaDKEVn0kq2H6RU=;
        b=kyv4wlybN6BcuLe90uVTueqM4LnwxnARKFJjR6aqVh9/QpfERPvFETObgeiWHUZak7
         aEP5pzm6MgZcCI3kKG6D5YZyVgbhyepTsnsJDVEqQ8XUJSSkwemprFzMPnRzI/oRiKTH
         wGZghT75RvaKcaBfeRcubsKCaF99DhB2qqlGmTsHFnZzHEFEtMkFu9gXALahrOXLXGaW
         f8mhAGXC/H52efMb31k6JoSCBBUjt+GjCqlI1HsZY2hq6a2hEjXgU/XDk7XIiix8mqHe
         FumlhzYSJTCeG052CX6q82mGfXsOABIIuHA2MkAC1J+hepz01kGGEefDMCH5YW+DnakZ
         YkGg==
X-Gm-Message-State: AOJu0Yyd7kaQk42Rsa+D6HxiNrGU10hZrPIWuFeprY3+liH2VzrWix6q
	tsW6uyTyMJDKlyzVMiH4e2iFDn7cgk0m6MeTBdjgl/YBK1WtRN4gVV9IIIcG10pbKeck5mpDpnP
	MmjBwdqE16sbE9kgQ7ho/upbPMgDbB59FH9Pp
X-Google-Smtp-Source: AGHT+IEufDjMNnrLYVeGKpbJ5fHGD6f+C242UlWQUP3hpim5UUuKSwSAAd4WnJG1XPq4bzY8lU7F4CqxOXN+ELxNWX4=
X-Received: by 2002:a05:6e02:320c:b0:363:bed5:5da1 with SMTP id
 cd12-20020a056e02320c00b00363bed55da1mr103967ilb.17.1707192748804; Mon, 05
 Feb 2024 20:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126221426.4173112-1-rmoar@google.com> <CABVgOSnOEc2AGteQNwysapxmYhNy625NeErXWpg_vvci5zC-=w@mail.gmail.com>
In-Reply-To: <CABVgOSnOEc2AGteQNwysapxmYhNy625NeErXWpg_vvci5zC-=w@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 5 Feb 2024 23:12:16 -0500
Message-ID: <CA+GJov5Ug5_xi7WDd1RQScR4cXya9LqDZ-5zKREpaRp2PoWB1A@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH v2] ktap_v2: add test metadata
To: David Gow <davidgow@google.com>
Cc: frowand.list@gmail.com, keescook@chromium.org, Tim.Bird@sony.com, 
	shuah@kernel.org, brendanhiggins@google.com, dlatypov@google.com, 
	tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, guillaume.tucker@collabora.com, corbet@lwn.net, 
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 1:50=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Sat, 27 Jan 2024 at 06:15, Rae Moar <rmoar@google.com> wrote:
> >
> > Add specification for test metadata to the KTAP v2 spec.
> >
> > KTAP v1 only specifies the output format of very basic test information=
:
> > test result and test name. Any additional test information either gets
> > added to general diagnostic data or is not included in the output at al=
l.
> >
> > The purpose of KTAP metadata is to create a framework to include and
> > easily identify additional important test information in KTAP.
> >
> > KTAP metadata could include any test information that is pertinent for
> > user interaction before or after the running of the test. For example,
> > the test file path or the test speed.
> >
> > Since this includes a large variety of information, this specification
> > will recognize notable types of KTAP metadata to ensure consistent form=
at
> > across test frameworks. See the full list of types in the specification=
.
> >
> > Example of KTAP Metadata:
> >
> >  KTAP version 2
> >  # ktap_test: main
> >  # ktap_arch: uml
> >  1..1
> >      KTAP version 2
> >      # ktap_test: suite_1
> >      # ktap_subsystem: example
> >      # ktap_test_file: lib/test.c
> >      1..2
> >      ok 1 test_1
> >      # ktap_test: test_2
> >      # ktap_speed: very_slow
> >      # custom_is_flaky: true
> >      ok 2 test_2
> >  ok 1 test_suite
>
> This 'test_suite' name doesn't match the 'suite_1' name above.
>

Hello!

Thanks for your review of this documentation. And sorry about that
typo. I will change that in the next version.

> It also could be clearer that it's supposed to match 'suite_1', not
> 'main', due to the indentation difference. Maybe we should add an
> explicit note pointing that out?

This is a good point. I will add a note in the specification example.

>
> >
> > The changes to the KTAP specification outline the format, location, and
> > different types of metadata.
> >
> > Here is a link to a version of the KUnit parser that is able to parse t=
est
> > metadata lines for KTAP version 2. Note this includes test metadata
> > lines for the main level of KTAP.
> >
> > Link: https://kunit-review.googlesource.com/c/linux/+/5889
>
> I tested this, and it works well. I think there's a couple of changes
> we'd want for a more useful set of KUnit parser changes (namely the
> option to support non ktap_ prefixes, as well as an actual way of
> using this data), but I'll leave those for a future review of that
> patch -- it's not relevant to this spec.

Thanks for testing this! My thought was to only support ktap_ prefixes
in the parser for now and we could add on others as needed. I will
make a separate patch series for this once KTAP Metadata goes through.

>
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> I like this: it covers all of the requirements we have in KUnit, as
> well as a few things we'd like to add.
>
> Is there anything obviously missing for this to work with other
> usecases? Are there any other examples of metadata people want to
> capture?
>

Yes, I am also curious about what other use cases people are
interested in as well?

> For me, this is
> Reviewed-by: David Gow <davidgow@google.com>
>
> >  Documentation/dev-tools/ktap.rst | 163 ++++++++++++++++++++++++++++++-
> >  1 file changed, 159 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools=
/ktap.rst
> > index ff77f4aaa6ef..4480eaf5bbc3 100644
> > --- a/Documentation/dev-tools/ktap.rst
> > +++ b/Documentation/dev-tools/ktap.rst
> > @@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which=
 may be nested: i.e., test
> >  can have subtests), each of which can contain both diagnostic data -- =
e.g., log
> >  lines -- and a final result. The test structure and results are
> >  machine-readable, whereas the diagnostic data is unstructured and is t=
here to
> > -aid human debugging.
> > +aid human debugging. One exception to this is test metadata lines - a =
type
> > +of diagnostic lines. Test metadata is used to identify important suppl=
emental
> > +test information and can be machine-readable.
> >
> >  KTAP output is built from four different types of lines:
> >  - Version lines
> >  - Plan lines
> >  - Test case result lines
> > -- Diagnostic lines
> > +- Diagnostic lines (including test metadata)
> >
> >  In general, valid KTAP output should also form valid TAP output, but s=
ome
> >  information, in particular nested test results, may be lost. Also note=
 that
> >  there is a stagnant draft specification for TAP14, KTAP diverges from =
this in
> > -a couple of places (notably the "Subtest" header), which are described=
 where
> > -relevant later in this document.
> > +a couple of places, which are described where relevant later in this d=
ocument.
> >
> >  Version lines
> >  -------------
> > @@ -166,6 +167,154 @@ even if they do not start with a "#": this is to =
capture any other useful
> >  kernel output which may help debug the test. It is nevertheless recomm=
ended
> >  that tests always prefix any diagnostic output they have with a "#" ch=
aracter.
> >
> > +KTAP metadata lines
> > +-------------------
> > +
> > +KTAP metadata lines are a subset of diagnostic lines that are used to =
include
> > +and easily identify important supplemental test information in KTAP.
> > +
> > +.. code-block:: none
> > +
> > +       # <prefix>_<metadata type>: <metadata value>
> > +
> > +The <prefix> indicates where to find the specification for the type of
> > +metadata. The metadata types listed below use the prefix "ktap" (See T=
ypes of
> > +KTAP Metadata).
> > +
> > +Types that are instead specified by an individual test framework use t=
he
> > +framework name as the prefix. For example, a metadata type documented =
by the
> > +kselftest specification would use the prefix "kselftest". Any metadata=
 type
> > +that is not listed in a specification must use the prefix "custom". No=
te the
> > +prefix must not include spaces or the characters ":" or "_".
>
> We should probably be more explicit about what counts as a
> 'specification' here, and hence whether a new prefix or 'custom'
> should be used.
>
> I'm tempted to be inspired by the OpenGL extension mechanism and say
> that new prefixes must be 'registered' before they can be used, where
> 'registration' consists of submitting a patch to this document linking
> to the specification.

Oh, I really like this idea. I could add a current list of supported
prefixes and even a link to the documentation of those metadata types.

>
> > +The format of <metadata type> and <value> varies based on the type. Se=
e the
> > +individual specification. For "custom" types the <metadata type> can b=
e any
> > +string excluding ":", spaces, or newline characters and the <value> ca=
n be any
> > +string.
> > +
> > +**Location:**
> > +
> > +The first KTAP metadata entry for a test must be "# ktap_test: <test n=
ame>",
> > +which acts as a header to associate metadata with the correct test.
> > +
> > +For test cases, the location of the metadata is between the prior test=
 result
> > +line and the current test result line. For test suites, the location o=
f the
> > +metadata is between the suite's version line and test plan line. See t=
he
> > +example below.
> > +
> > +KTAP metadata for a test does not need to be contiguous. For example, =
a kernel
> > +warning or other diagnostic output could interrupt metadata lines. How=
ever, it
> > +is recommended to keep a test's metadata lines together when possible,=
 as this
> > +improves readability.
>
> Should we give an example of this? e.g. ktap_duration will need to be
> output after the test has completed, but ktap_test must be output
> before any log lines. (And most of the others probably prefer to be at
> the beginning.)
>
> I think this is the most complicated point from a parsing point of
> view, so we should probably draw more attention to it.

I will try to add an example here to flush out this concept including
ktap_test and ktap_duration.

>
> > +
> > +**Here is an example of using KTAP metadata:**
> > +
> > +::
> > +
> > +        KTAP version 2
> > +        # ktap_test: main
> > +        # ktap_arch: uml
> > +        1..1
> > +          KTAP version 2
> > +          # ktap_test: suite_1
> > +          # ktap_subsystem: example
> > +          # ktap_test_file: lib/test.c
> > +          1..2
> > +          ok 1 test_1
> > +          # ktap_test: test_2
> > +          # ktap_speed: very_slow
> > +          # custom_is_flaky: true
> > +          ok 2 test_2
> > +        # suite_1 passed
> > +        ok 1 suite_1
>
> Would it be clearer to have some examples which have other,
> non-metadata diagnostic lines here, so we can see how they interact?
>

I definitely see this point. I can either add non-metadata diagnostic
lines to this example or I could also add a separate example. I am
leaning towards the former but let me know if you would have a strong
preference for a separate example instead.

> > +
> > +In this example, the tests are running on UML. The test suite "suite_1=
" is part
> > +of the subsystem "example" and belongs to the file "lib/example_test.c=
". It has
> > +two subtests, "test_1" and "test_2". The subtest "test_2" has a speed =
of
> > +"very_slow" and has been marked with a custom KTAP metadata type calle=
d
> > +"custom_is_flaky" with the value of "true".
> > +
> > +**Types of KTAP Metadata:**
> > +
> > +This is the current list of KTAP metadata types recognized in this
> > +specification. Note that all of these metadata types are optional (exc=
ept for
> > +ktap_test as the KTAP metadata header).
> > +
> > +- ``ktap_test``: Name of test (used as header of KTAP metadata). This =
should
> > +  match the test name printed in the test result line: "ok 1 [test_nam=
e]".
> > +
> > +- ``ktap_module``: Name of the module containing the test
> > +
> > +- ``ktap_subsystem``: Name of the subsystem being tested
> > +
> > +- ``ktap_start_time``: Time tests started in ISO8601 format
> > +
> > +  - Example: "# ktap_start_time: 2024-01-09T13:09:01.990000+00:00"
> > +
> > +- ``ktap_duration``: Time taken (in seconds) to execute the test
> > +
> > +  - Example: "ktap_duration: 10.154s"
> > +
> > +- ``ktap_speed``: Category of how fast test runs: "normal", "slow", or
> > +  "very_slow"
> > +
> > +- ``ktap_test_file``: Path to source file containing the test. This me=
tadata
> > +  line can be repeated if the test is spread across multiple files.
> > +
> > +  - Example: "# ktap_test_file: lib/test.c"
> > +
> > +- ``ktap_generated_file``: Description of and path to file generated d=
uring
> > +  test execution. This could be a core dump, generated filesystem imag=
e, some
> > +  form of visual output (for graphics drivers), etc. This metadata lin=
e can be
> > +  repeated to attach multiple files to the test.
> > +
> > +  - Example: "# ktap_generated_file: Core dump: /var/lib/systemd/cored=
ump/hello.core"
> > +
> > +- ``ktap_log_file``: Path to file containing kernel log test output
> > +
> > +  - Example: "# ktap_log_file: /sys/kernel/debugfs/kunit/example/resul=
ts"
>
> When should we use something generic like 'ktap_generated_file',
> versus something more specific, like 'ktap_log_file'?
>

I think it would be best to use the more specific ktap_log_file when
possible. However, I think it largely depends on how the test author
and test framework want to use these metadata types. I will add a note
here to document that.

Thanks for your thoughts!
-Rae


> > +
> > +- ``ktap_error_file``: Path to file containing context for test failur=
e or
> > +  error. This could include the difference between optimal test output=
 and
> > +  actual test output.
> > +
> > +  - Example: "# ktap_error_file: fs/results/example.out.bad"
> > +
> > +- ``ktap_results_url``: Link to webpage describing this test run and i=
ts
> > +  results
> > +
> > +  - Example: "# ktap_results_url: https://kcidb.kernelci.org/hello"
> > +
> > +- ``ktap_arch``: Architecture used during test run
> > +
> > +  - Example: "# ktap_arch: x86_64"
> > +
> > +- ``ktap_compiler``: Compiler used during test run
> > +
> > +  - Example: "# ktap_compiler: gcc (GCC) 10.1.1 20200507 (Red Hat 10.1=
.1-1)"
> > +
> > +- ``ktap_respository_url``: Link to git repository of the checked out =
code.
> > +
> > +  - Example: "# ktap_respository_url: https://github.com/torvalds/linu=
x.git"
> > +
> > +- ``ktap_git_branch``: Name of git branch of checked out code
> > +
> > +  - Example: "# ktap_git_branch: kselftest/kunit"
> > +
> > +- ``ktap_kernel_version``: Version of Linux Kernel being used during t=
est run
> > +
> > +  - Example: "# ktap_kernel_version: 6.7-rc1"
> > +
> > +- ``ktap_commit_hash``: The full git commit hash of the checked out ba=
se code.
> > +
> > +  - Example: "# ktap_commit_hash: 064725faf8ec2e6e36d51e22d3b86d2707f0=
f47f"
> > +
> > +**Other Metadata Types:**
> > +
> > +There can also be KTAP metadata that is not included in the recognized=
 list
> > +above. This metadata must be prefixed with the test framework, ie. "ks=
elftest",
> > +or with the prefix "custom". For example, "# custom_batch: 20".
> > +
> >  Unknown lines
> >  -------------
> >
> > @@ -206,6 +355,7 @@ An example of a test with two nested subtests:
> >         KTAP version 2
> >         1..1
> >           KTAP version 2
> > +         # ktap_test: example
> >           1..2
> >           ok 1 test_1
> >           not ok 2 test_2
> > @@ -219,6 +369,7 @@ An example format with multiple levels of nested te=
sting:
> >         KTAP version 2
> >         1..2
> >           KTAP version 2
> > +         # ktap_test: example_test_1
> >           1..2
> >             KTAP version 2
> >             1..2
> > @@ -254,6 +405,7 @@ Example KTAP output
> >         KTAP version 2
> >         1..1
> >           KTAP version 2
> > +         # ktap_test: main_test
> >           1..3
> >             KTAP version 2
> >             1..1
> > @@ -261,11 +413,14 @@ Example KTAP output
> >             ok 1 test_1
> >           ok 1 example_test_1
> >             KTAP version 2
> > +        # ktap_test: example_test_2
> > +        # ktap_speed: slow
> >             1..2
> >             ok 1 test_1 # SKIP test_1 skipped
> >             ok 2 test_2
> >           ok 2 example_test_2
> >             KTAP version 2
> > +           # ktap_test: example_test_3
> >             1..3
> >             ok 1 test_1
> >             # test_2: FAIL
> >
> > base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >

