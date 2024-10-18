Return-Path: <linux-kselftest+bounces-20111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2089A3708
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD5AB25038
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF918B471;
	Fri, 18 Oct 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwMhXR9n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA01885BE
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236135; cv=none; b=s+VbgncGiSmjDRgrfsK8KvhAdMmZmVPLKiTl+ODBvwaPPzlr+0MZ9NYAwZPMZLAVG0SDsfKSFXKjcr9T1G8AFgmquyFJXE5EAl5B60D+LL4scjkcDpbCnDAHEJCeSo8HMdHX+v/gEQW84zsEvYyWaTWGRYzZDCh6h/iYEBsTxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236135; c=relaxed/simple;
	bh=Qo7c7Qb2a3vbAr7cotm6RmPBaTosJslkZ+KZYPr/CYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDODwLLXqZ3pOJQIuiM/U+uBV5JhuD8wH6U23z0u7aqR838wtoIrdmCAOrftz93r8FMAw3fuQ34hZex2kmd1pk+x4816J7lZNa1YRiQafO20IXXDr22nDKbh33z7Osh7Nf+Ks3/c1QSyEs7ltlUSb0WsndLVfWM2QxBJjM4Murg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwMhXR9n; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso23428246d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729236132; x=1729840932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5w/eHsPU7fR4eFKryAAtPHgZLuFlcjD2SD4O+IdWCjU=;
        b=TwMhXR9n+1M0BjfRYVy95IWDe+nQCIvnxun8sXxv+wNlNynv5Fl2rmzBzKvRUeBwGV
         3sXbmEVd3FtUG+wxdTePE5W9mOGmm3DS8ty6ijoWxB87JWJiVAq40Q8BilteYfyfwu1f
         NnDmmpveHlqCr27I5UT8ot7emtUE/aOMiQkgROTxgz8J5n0ildvQeWJQ3ICo0MQm+EHU
         +8xbFddmM+pVi4I+nfPiFAQaO1tro0vOguQmpOk9k6p0WK6q6qckF3WGOLSt4d5MaYdR
         sXH1GNqQEbAvNHiO96D9vGsbWvh5lTCI/XUtevoCDmT1XT271fz3KLb88QZ/BHHt1mb5
         6aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236132; x=1729840932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5w/eHsPU7fR4eFKryAAtPHgZLuFlcjD2SD4O+IdWCjU=;
        b=gnHJiI4NMU8T/t7f3KD9uljtmxN0qcWzxvoecDwnDjpYjAj/GBnr04fdfFWgnFKvB/
         r798oRLaaazMp52lCd+qkbtoR+UlnV4a2bws2Wo1IGYBI7fyI5YGMUBDXGbpyN9mRVbi
         A3L4QzhxJiMD+AIh186HK0L8OP83OIUtdSrs5TCxciOKSLEjVpjuPFuWGkPf+5tcuTbF
         EfkqGz5fnQX2nqafKcBLeXFDXwEU/6kodrk3wHZ8cJM2ThflWBkRMGI7VdOmtt/ccpM0
         LjQQh+bsZgtO90uE9JYfT1a9TY2iR9O2pyhWRHpI6YjCfvJkCWxQ23EbqfTFnv4UQjQj
         UtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzimJUY7vXRgpOQDt70ooXn+9t8V3SRc0tRhewBtzQnfLnDqTcI+qDhwlvzZIr4Ipf8YoQMqaGeIFyPxH2KrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRn8NuR+fIn6iMeFO2btuvmtUl7BHGnKWyBW05hRNZWz3PSeaq
	8FAbkUJfTar/MPpHrKo6jIb5rQ0zroRc87QxBJCNOPuOEjM02PHc2Eru5myGYDOCa3npD6RSiuc
	gCraMl2O09OxI6eyUpDHY8MoZ95aJfIUKEcdW
X-Google-Smtp-Source: AGHT+IG1Zvkbwfkuhxl8fKJd/u0AMJQZuO+Ar+SYemvp/HST5jke0TlUDbABt0L4kdMzkRg4nVRAZiFYNwrLgfxMqzU=
X-Received: by 2002:a05:6214:e83:b0:6c3:6344:d4e1 with SMTP id
 6a1803df08f44-6cc378ab19dmr98067196d6.20.1729236131893; Fri, 18 Oct 2024
 00:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
In-Reply-To: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 18 Oct 2024 15:21:58 +0800
Message-ID: <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
To: Donald Zickus <dzickus@redhat.com>
Cc: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000068ee170624bb2984"

--00000000000068ee170624bb2984
Content-Type: text/plain; charset="UTF-8"

Hi Don,

Thanks for putting this together: the discussion at Plumbers was very useful.

On Tue, 15 Oct 2024 at 04:33, Donald Zickus <dzickus@redhat.com> wrote:
>
> Hi,
>
> At Linux Plumbers, a few dozen of us gathered together to discuss how
> to expose what tests subsystem maintainers would like to run for every
> patch submitted or when CI runs tests.  We agreed on a mock up of a
> yaml template to start gathering info.  The yaml file could be
> temporarily stored on kernelci.org until a more permanent home could
> be found.  Attached is a template to start the conversation.
>

I think that there are two (maybe three) separate problems here:
1. What tests do we want to run (for a given patch/subsystem/environment/etc)?
2. How do we describe those tests in such a way that running them can
be automated?
3. (Exactly what constitutes a 'test'? A single 'test', a whole suite
of tests, a test framework/tool? What about the environment: is, e.g.,
KUnit on UML different from KUnit on qemu-x86_64 different from KUnit
on qemu-arm64?)

My gut feeling here is that (1) is technically quite easy: worst-case
we just make every MAINTAINERS entry link to a document describing
what tests should be run. Actually getting people to write these
documents and then run the tests, though, is very difficult.

(2) is the area where I think this will be most useful. We have some
arbitrary (probably .yaml) file which describes a series of tests to
run in enough detail that we can automate it. My ideal outcome here
would be to have a 'kunit.yaml' file which I can pass to a tool
(either locally or automatically on some CI system) which will run all
of the checks I'd run on an incoming patch. This would include
everything from checkpatch, to test builds, to running KUnit tests and
other test scripts. Ideally, it'd even run these across a bunch of
different environments (architectures, emulators, hardware, etc) to
catch issues which only show up on big-endian or 32-bit machines.

If this means I can publish that yaml file somewhere, and not only
give contributors a way to check that those tests pass on their own
machine before sending a patch out, but also have CI systems
automatically run them (so the results are ready waiting before I
manually review the patch), that'd be ideal.

> Longer story.
>
> The current problem is CI systems are not unanimous about what tests
> they run on submitted patches or git branches.  This makes it
> difficult to figure out why a test failed or how to reproduce.
> Further, it isn't always clear what tests a normal contributor should
> run before posting patches.
>
> It has been long communicated that the tests LTP, xfstest and/or
> kselftests should be the tests  to run.  However, not all maintainers
> use those tests for their subsystems.  I am hoping to either capture
> those tests or find ways to convince them to add their tests to the
> preferred locations.
>
> The goal is for a given subsystem (defined in MAINTAINERS), define a
> set of tests that should be run for any contributions to that
> subsystem.  The hope is the collective CI results can be triaged
> collectively (because they are related) and even have the numerous
> flakes waived collectively  (same reason) improving the ability to
> find and debug new test failures.  Because the tests and process are
> known, having a human help debug any failures becomes easier.
>
> The plan is to put together a minimal yaml template that gets us going
> (even if it is not optimized yet) and aim for about a dozen or so
> subsystems.  At that point we should have enough feedback to promote
> this more seriously and talk optimizations.
>
> Feedback encouraged.
>
> Cheers,
> Don
>
> ---
> # List of tests by subsystem

I think we should split this up into several files, partly to avoid
merge conflicts, partly to make it easy to maintain custom collections
of tests separately.

For example, fs.yaml could contain entries for both xfstests and fs
KUnit and selftests.

It's also probably going to be necessary to have separate sets of
tests for different use-cases. For example, there might be a smaller,
quicker set of tests to run on every patch, and a much longer, more
expensive set which only runs every other day. So I don't think
there'll even be a 1:1 mapping between 'test collections' (files) and
subsystems. But an automated way of running "this collection of tests"
would be very useful, particularly if it's more user-friendly than
just writing a shell script (e.g., having nicely formatted output,
being able to run things in parallel or remotely, etc).

> #
> # Tests should adhere to KTAP definitions for results
> #
> # Description of section entries
> #
> #  maintainer:    test maintainer - name <email>
> #  list:                mailing list for discussion
> #  version:         stable version of the test
> #  dependency: necessary distro package for testing
> #  test:
> #    path:            internal git path or url to fetch from
> #    cmd:            command to run; ability to run locally
> #    param:         additional param necessary to run test
> #  hardware:      hardware necessary for validation
> #
> # Subsystems (alphabetical)
>
> KUNIT TEST:

For KUnit, it'll be interesting to draw the distinction between KUnit
overall and individual KUnit suites.
I'd lean towards having a separate entry for each subsystem's KUnit
tests (including one for KUnit's own tests)

>   maintainer:
>     - name: name1
>       email: email1
>     - name: name2
>       email: email2
>   list:

How important is it to have these in the case where they're already in
the MAINTAINERS file? I can see it being important for tests which
live elsewhere, though eventually, I'd still prefer the subsystem
maintainer to take some responsibility for the tests run for their
subsystems.

>   version:

This field is probably unnecessary for test frameworks which live in
the kernel tree.

>   dependency:
>     - dep1
>     - dep2

If we want to automate this in any way, we're going to need to work
out a way of specifying these. Either we'd have to pick a distro's
package names, or have our own mapping.

(A part of me really likes the idea of having a small list of "known"
dependencies: python, docker, etc, and trying to limit tests to using
those dependencies. Though there are plenty of useful tests with more
complicated dependencies, so that probably won't fly forever.)

>   test:
>     - path: tools/testing/kunit
>       cmd:
>       param:
>     - path:
>       cmd:
>       param:

Is 'path' here supposed to be the path to the test binary, the working
directory, etc?
Maybe there should be 'working_directory', 'cmd', 'args', and 'env'.

>   hardware: none



For KUnit, I'd imagine having a kunit.yaml, with something like this,
including the KUnit tests in the 'kunit' and 'example' suites, and the
'kunit_tool_test.py' test script:

---
KUnit:
  maintainer:
    - name: David Gow
      email: davidgow@google.com
    - name: Brendan Higgins
      email: brendan.higgins@linux.dev
  list: kunit-dev@googlegroups.com
  dependency:
    - python3
  test:
    - path: .
      cmd: tools/testing/kunit.py
      param: run kunit
    - path: .
      cmd: tools/testing/kunit.py
      param: run example
  hardware: none
KUnit Tool:
  maintainer:
    - name: David Gow
      email: davidgow@google.com
    - name: Brendan Higgins
      email: brendan.higgins@linux.dev
  list: kunit-dev@googlegroups.com
  dependency:
    - python3
  test:
    - path: .
      cmd: tools/testing/kunit_tool_test.py
      param:
  hardware: none
---

Obviously there's still some redundancy there, and I've not actually
tried implementing something that could run it. It also lacks any
information about the environment. In practice, I have about 20
different kunit.py invocations which run the tests with different
configs and on different architectures. Though that might make sense
to keep in a separate file to only run if the simpler tests pass. And
equally, it'd be nice to have a 'common.yaml' file with basic patch
and build tests which apply to almost everything (checkpatch, make
defconfig, maybe even make allmodconfig, etc).

Cheers,
-- David

--00000000000068ee170624bb2984
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgAsTmar5zr9rV081sfPx08FGA39Wu
zbQgJL50ngZzUZcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDE4MDcyMjEyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEdIwi/SkyL6UoAH+8nnnu1wa7iGR1UJUpT9k6OcDXmzH8Ml
Izs4xgiXEaA2nJObkqLEZaO6hZwzYOFxcZ7Cpk7sMv3zQ/N0xKcmsEV8EXwGmQwLvoIbzSFJkSgh
53HiDPlQIEbvfhEsqiNuDhJkp5KuOpjRxEALWQ6IvxwboEJMS8m/ljjiMHvPEi3IzDl3ai+cjYIx
m1sILQAjYq0wWwd+AYxDVJKDx3PdDf28PxekEff6UkV1rXtFdk772GpgZYm7NFnM78xICPNhe8A/
41c7JwmcXcMxjTVM6/natglMBee9VZzxKQcBLoBdSQKftRqmeHbqnR4VUnWQ5huSIUU=
--00000000000068ee170624bb2984--

