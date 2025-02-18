Return-Path: <linux-kselftest+bounces-26837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1EA3952D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 09:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66A27A3B36
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43421239095;
	Tue, 18 Feb 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWrCUrnQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CD22DF83
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866823; cv=none; b=sgWALzWKJwnCFaAEteZH8NkC5i4UMt4PT3B4E7N0oKp6HJ5v5ET6MJw2rlRZWy8oXEuYkGTtrzHN1kGD3OYE6JBEEzaLqhgRAPeW9eArJt4or6YsjliSEADmMnZtOeoHHanbnn0ZFfFolxkTXINL3suS1MOlQltTPEdTwFsXS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866823; c=relaxed/simple;
	bh=zN9qTlYIsKWkdElzRO+O5cgc7BG1CW7Q+5G1/YXBqR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RICEkNmoWmEj49QlZttarKANVPaZsjuz/6gAF+RkVEHonTjiLtblXubu4Fls1FDnQ7fTn9e1luHLN23BwtdVAftfs4yV4HcwQeRu/kOxHFwhSQzvyAcWD7gUvfdzkPNCO8AyMh+KIFkaWo2PZ0P0Yn8TzO07a0EE3Lwxnqvt9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWrCUrnQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e6846bcde2so10007416d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 00:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739866820; x=1740471620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuoQ19C3N119izu3AtNG1s9CgLBdYj10wUQqT6aat4s=;
        b=PWrCUrnQsB/1PrYPC03GTaArlQ16hGBHgvjQQtvzHK8izVqd6uXOzhvql15tYsd+NN
         76G6OFIfgg13n20MM2SEpOl6KKovULZbkR7f7lU2KVqK6Sj5dmU+imRZcn0aC9OrY7H3
         sFJb/Y91oqdV2u4jlAHHJqVcF+JHotHdHlWWdGjGu0uUPThnho97HNMpfe4ryCG0OBAs
         MYqXzOa3f0ID+KdIBysHVFxKk24Z6uBiV3KOp+y5vQXQf23Z1slZ3Dsp5FufyU1zsbWE
         0rMFbX/yKoR5FeJPYKWwczSRE0f/Z4NMo+GlRSeCbfUK88mNMpxISnsxQbFVvEcnDyv9
         iq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866820; x=1740471620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuoQ19C3N119izu3AtNG1s9CgLBdYj10wUQqT6aat4s=;
        b=pi/GatUiVF9MIHHAojISUN9QG7J8Ygvc56E//P5IKHlWr4xEnvmM11xuHOb7MO2Y7r
         U50Z3bvQx9TyNtmc3AdQ2GSJGcT7G678RD0FpggpjveIaP2aY/InI1X/A3fz0ljCXvre
         2cfE9xKxdnuuZpKVD/DPCXKRXQKUTeky1ww94/ONQNg+EMAEId+RAjro/C4mLhes0qNU
         nfsYYHXVNFAoOd51rQW2nlgx1OIaB+qSz5vhrReDfhSwhQhFG+f67TWnEQFPcLYR00lc
         h2IyGEqp+4Im3UYUJl7c13asPyNgvvuA7ACyZhxDc6w5KWVKgbrAF5rWnSuRDb1PXKRU
         eOkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9f+FsBy0ZK0dPcB6kgq76Gh/O8MNdEhvFIbpEXgD3npxbz56mq7B3dfBcUec7OIDJoeqOa4C+2b4RKZeZOJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VmbZG5gzSkCmIDr+hfkEMHbXi+o93R5A9G+9TH8l4bwqxiD0
	PbwoRHxsW2y/IvZmxNvSPfE+ZQOWE11LhRL8bvWVEfBz1o+DM1ZIJ6lDP7BpnJrPOkEwb6Prq9Z
	2bSZRwXQjAzcY/Jf2a/b9wvtDzJoNdgnkUZrc
X-Gm-Gg: ASbGncsgrhvJyMg82IAKs9o6lX6Vbfps6ErSTWy2IJyPc3cCxbQFkMhAJhStLu8UveU
	ytI1gjRqUp+EvkD0XxfvHzEzWI1I7uTW+gBr5Ro5HJFRVEH/VF3GE1XI45OFhMj7P/shJEkOeng
	==
X-Google-Smtp-Source: AGHT+IFUJfybEUXPvrsW87DgsnIvE+HQJ5a6+pzrlrCs1oeh+20Y0GTMrQexFX4rmjjFLGXQ/rxrdP5vqnXW/+QABmc=
X-Received: by 2002:a05:6214:5019:b0:6e6:5ec3:868e with SMTP id
 6a1803df08f44-6e66cd19b75mr215529066d6.31.1739866819538; Tue, 18 Feb 2025
 00:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Tue, 18 Feb 2025 16:20:06 +0800
X-Gm-Features: AWEUYZmvtT093vpdYvvuHuiOHYbXlWuuoZDfhVK3Xg7QvvIfkc59Z_7-vUrHOoI
Message-ID: <CABVgOSn5tGDj5rnR=a133ntv3GeoXQLnHRBg9HRf86hWve7T1w@mail.gmail.com>
Subject: Re: [PATCH 00/12] kunit: Introduce UAPI testing framework
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c4ef9b062e664fa1"

--000000000000c4ef9b062e664fa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 at 19:00, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Currently testing of userspace and in-kernel API use two different
> frameworks. kselftests for the userspace ones and Kunit for the
> in-kernel ones. Besides their different scopes, both have different
> strengths and limitations:
>
> Kunit:
> * Tests are normal kernel code.
> * They use the regular kernel toolchain.
> * They can be packaged and distributed as modules conveniently.
>
> Kselftests:
> * Tests are normal userspace code
> * They need a userspace toolchain.
>   A kernel cross toolchain is likely not enough.
> * A fair amout of userland is required to run the tests,
>   which means a full distro or handcrafted rootfs.
> * There is no way to conveniently package and run kselftests with a
>   given kernel image.
> * The kselftests makefiles are not as powerful as regular kbuild.
>   For example they are missing proper header dependency tracking or more
>   complex compiler option modifications.
>
> Therefore kunit is much easier to run against different kernel
> configurations and architectures.
> This series aims to combine kselftests and kunit, avoiding both their
> limitations. It works by compiling the userspace kselftests as part of
> the regular kernel build, embedding them into the kunit kernel or module
> and executing them from there. If the kernel toolchain is not fit to
> produce userspace because of a missing libc, the kernel's own nolibc can
> be used instead.
> The structured TAP output from the kselftest is integrated into the
> kunit KTAP output transparently, the kunit parser can parse the combined
> logs together.

Wow -- this is really neat! Thanks for putting this together.

I haven't had a chance to play with it in detail yet, but here are a
few initial / random thoughts:
- Having support for running things from userspace within a KUnit test
seems like it's something that could be really useful for testing
syscalls (and maybe other mm / exec code as well).
- I don't think we can totally combine kselftests and KUnit for all
tests (some of the selftests definitely require more complicated
dependencies than I think KUnit would want to reasonably support or
require).
- The in-kernel KUnit framework doesn't have any knowledge of the
structure or results of a uapi test. It'd be nice to at least be able
to get the process exit status, and bubble up a basic
'passed'/'skipped'/'failed' so that we're not reporting success for
failed tests (and so that simple test executables could run without
needing to output their own KTAP if they only run one test).
- Equally, for some selftests, it's probably a pain to have to write a
kernel module if there's nothing that needs to be done in the kernel.
Maybe such tests could still be built with nolibc and a kernel
toolchain, but be triggered directly from the python tooling (e.g. as
the 'init' process).
- There still seems to be some increased requirements over plain KUnit
at the moment: I'm definitely seeing issues from not having the right
libgcc installed for all architectures. (Though it's working for most
of them, which is very neat!)
- This is a great example of how having standardised result formats is usef=
ul!
- If this is going to change or blur the boundary between "this is a
ksefltest" and "this is a kunit test", we probably will need to update
Documentation/dev-tools/testing-overview.rst -- it probably needs some
clarifications there _anyway_, so this is probably a good point to
ensure everyone's on the same page.

Do you have a particular non-example test you'd like to either write
or port to use this? I think it'd be great to see some real-world
examples of where this'd be most useful.

Either way, I'll keep playing with this a bit over the next few days.
I'd love to hear what Shuah and Rae think, as well, as this involves
kselftest and KTAP a lot.

Cheers,
-- David

>
> Further room for improvements:
> * Call each test in its completely dedicated namespace
> * Handle additional test files besides the test executable through
>   archives. CPIO, cramfs, etc.
> * Compatibility with kselftest_harness.h (in progress)
> * Expose the blobs in debugfs
> * Provide some convience wrappers around compat userprogs
> * Figure out a migration path/coexistence solution for
>   kunit UAPI and tools/testing/selftests/
>
> Output from the kunit example testcase, note the output of
> "example_uapi_tests".
>
> $ ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit example
> ...
> Running tests with:
> $ .kunit/linux kunit.filter_glob=3Dexample kunit.enable=3D1 mem=3D1G cons=
ole=3Dtty kunit_shutdown=3Dhalt
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D example=
 (10 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11:53:53] [PASSED] example_simple_test
> [11:53:53] [SKIPPED] example_skip_test
> [11:53:53] [SKIPPED] example_mark_skipped_test
> [11:53:53] [PASSED] example_all_expect_macros_test
> [11:53:53] [PASSED] example_static_stub_test
> [11:53:53] [PASSED] example_static_stub_using_fn_ptr_test
> [11:53:53] [PASSED] example_priv_test
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D exam=
ple_params_test  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11:53:53] [SKIPPED] example value 3
> [11:53:53] [PASSED] example value 2
> [11:53:53] [PASSED] example value 1
> [11:53:53] [SKIPPED] example value 0
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] example=
_params_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11:53:53] [PASSED] example_slow_test
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [11:53:53] [PASSED] procfs
> [11:53:53] [PASSED] userspace test 2
> [11:53:53] [SKIPPED] userspace test 3: some reason
> [11:53:53] [PASSED] userspace test 4
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] exam=
ple_uapi_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D [PASSED] example =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> [11:53:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11:53:53] Testing complete. Ran 16 tests: passed: 11, skipped: 5
> [11:53:53] Elapsed time: 67.543s total, 1.823s configuring, 65.655s build=
ing, 0.058s running
>
> Based on v6.14-rc1 and the series
> "tools/nolibc: compatibility with -Wmissing-prototypes" [0].
> For compatibility with LLVM/clang another series is needed [1].
>
> [0] https://lore.kernel.org/lkml/20250123-nolibc-prototype-v1-0-e1afc5c19=
99a@weissschuh.net/
> [1] https://lore.kernel.org/lkml/20250213-kbuild-userprog-fixes-v1-0-f255=
fb477d98@linutronix.de/
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Wei=C3=9Fschuh (12):
>       kconfig: implement CONFIG_HEADERS_INSTALL for Usermode Linux
>       kconfig: introduce CONFIG_ARCH_HAS_NOLIBC
>       kbuild: userprogs: respect CONFIG_WERROR
>       kbuild: userprogs: add nolibc support
>       kbuild: introduce blob framework
>       kunit: tool: Add test for nested test result reporting
>       kunit: tool: Don't overwrite test status based on subtest counts
>       kunit: tool: Parse skipped tests from kselftest.h
>       kunit: Introduce UAPI testing framework
>       kunit: uapi: Add example for UAPI tests
>       kunit: uapi: Introduce preinit executable
>       kunit: uapi: Validate usability of /proc
>
>  Documentation/kbuild/makefiles.rst                 |  12 +
>  Makefile                                           |   5 +-
>  include/kunit/uapi.h                               |  17 ++
>  include/linux/blob.h                               |  21 ++
>  init/Kconfig                                       |   2 +
>  lib/Kconfig.debug                                  |   1 -
>  lib/kunit/Kconfig                                  |   9 +
>  lib/kunit/Makefile                                 |  17 +-
>  lib/kunit/kunit-example-test.c                     |  17 ++
>  lib/kunit/kunit-uapi-example.c                     |  58 +++++
>  lib/kunit/uapi-preinit.c                           |  61 +++++
>  lib/kunit/uapi.c                                   | 250 +++++++++++++++=
++++++
>  scripts/Makefile.blobs                             |  19 ++
>  scripts/Makefile.build                             |   6 +
>  scripts/Makefile.clean                             |   2 +-
>  scripts/Makefile.userprogs                         |  18 +-
>  scripts/blob-wrap.c                                |  27 +++
>  tools/include/nolibc/Kconfig.nolibc                |  18 ++
>  tools/testing/kunit/kunit_parser.py                |  13 +-
>  tools/testing/kunit/kunit_tool_test.py             |   9 +
>  .../test_is_test_passed-failure-nested.log         |  10 +
>  .../test_data/test_is_test_passed-kselftest.log    |   3 +-
>  22 files changed, 584 insertions(+), 11 deletions(-)
> ---
> base-commit: 20e952894066214a80793404c9578d72ef89c5e0
> change-id: 20241015-kunit-kselftests-56273bc40442
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

--000000000000c4ef9b062e664fa1
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgKWvTIDzDKHvkh+HzIVVioiaeUqrb
vD6Az0VCNvZDpikwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjE4MDgyMDIwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAB+x+32dQJe+HlV23ej672XPDnZVY91JzcJlA2p5Vgm0kjJN
IS4bc+kSgNEMfPiMPF6ttC+8DKxpHw2lW9/rh/B0HyPLTfM0NmCBBe9ic62C7NsuHEpN6KDWtUJg
+7dDkMbA7t5bPLFIAlkGjqRNHaUhA+igRefxt8OEKYoOkjJzayQfeKLaMAoQNIQVC8exnxifmwr4
jXoVKbVUBVgEsvhk0JWK2oRDu+IzxTFco9CvO4VEGzZHLVsXdBk8CB61DCEhu5WOslZh0YNtBjVE
lx6uAd/+UR8s7SkDC+Xps0DT4jF+w1co0B/DEMTVWAvHESBy6hO+GiL9b3QpLgsFyNM=
--000000000000c4ef9b062e664fa1--

