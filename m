Return-Path: <linux-kselftest+bounces-4073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27960848416
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 07:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435831C22100
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 06:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5841642076;
	Sat,  3 Feb 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkpHGo/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244D42070
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Feb 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706943012; cv=none; b=kQkojVbh9vTWVemqttzooYwI6prnDvnx8AYnhK1s7vFSC9kmNtvzQRdWYvrcpNv7BCiR4pOT/l/hNYMimDsDrxb+6PZRqPMKsTBcWuc2FBy49rtIptd/eliBPtHTvgpLzhUzeuji6tXWJFV9dTptcOY5xFj8VIxCOv4GgueUUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706943012; c=relaxed/simple;
	bh=kFeWGZ6bQrkNRd1j0gtUCLYRARHz00YZUlkw6sDfIbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiZwMr1EUTQAaUxlDQMAjOl5VKFDSYORvmYiGZzu0Tb9aUmbR2E9L6lEXpuubJUmx2LIue4PIG0OGYfYj8kZbhl6HBbxnJSfoVhNxq0NvbpgOsKbJ8XLeofND71S8EVh585ZJJWFV9iyeb5fbTUJE02px5MhBvTpXm9DM80JY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkpHGo/f; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f63fd3dd8so5320a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 22:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706943008; x=1707547808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFJJOesty7VEcORfgd5DczFc+4UyQZklLLGX6HJCYNI=;
        b=TkpHGo/fOMm1m118vd8ygSyNZiTi91Sv81m2uqPilBpf7c/gdEIUhJHipZKjydoCyy
         IA2QvrTsf30aI91x1nzIwm9YXYGFc+vVfNt0rDgli1iZcchPXXfv+3SLotnbc5dtj4jH
         ZuRc45KHSR/6EZCo8mHoxggdi7iQ+w35aiQi7R7VBCaz0B+f1nW9QtnhdyJccSwqp1/b
         VfGjsZcnhH1mqOy1sB2kYek8TY5NPBloMJVr/f+gfcO6KrXsthEEBbhxbJ3MvUbhW1gO
         Tc2abT3ixSLYgja/tWaJRTwGA0Hec6qdevbzOcn7ldW6iHdSe50ml0eWAr1UDWh6U2bR
         G7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706943008; x=1707547808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFJJOesty7VEcORfgd5DczFc+4UyQZklLLGX6HJCYNI=;
        b=Tm8rPJscHFr2XCeraiPoMyAeWnp7ZQAMO/pcHk1vPZeD/3B7awNAanbYyfJSH/l2FS
         QEt2PUVmL2mSwYv094GJjIqJP0qOyKcyJnYEmBZLuTf/b9mSxsPOEf7Kn40ygbmYtpcH
         cUiEIZ9l72dTVCVwDe2XF59cITkAczQnYfXomkOIYwoztH04DmUWBxNX9VLblv/+Uj+k
         bp5onM8CAbIxIzFvKVbqlf8pNWtufkn8glitjqQ8OE87ztaZbfpWWnkkQLyvkHG8+9+r
         LLumLz6Nvi+OEK5Nhtrn22uFXlc/xozxeyNzeXRM0Wsc9+wFHdkPA3R/T5sJuOoYSp/M
         Qj5w==
X-Gm-Message-State: AOJu0YwjozlBgwQO80sR3wpI0oXtIV6ZfXg4XsQnZh4yao4bnW+G9Vj6
	vnF1pYAv4ojR8MB0nTz8ApUe8kdyWGG3sVgCws8DhRjth8Bdmz74Q8jn/kJglS4raMeCxms04Jm
	4zyfDISoWG20FO8Bgv9CspDLXhX19ZuLQsAOV
X-Google-Smtp-Source: AGHT+IHtR6+NllsoEXb+PjJZydGX5HfqQo35hMrwheGkoCQau/BwYCen80zD/GkByJIstLPv7WiheikBU5Y9wF+xawQ=
X-Received: by 2002:a50:d517:0:b0:55f:98d7:877c with SMTP id
 u23-20020a50d517000000b0055f98d7877cmr66344edi.5.1706943006426; Fri, 02 Feb
 2024 22:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126221426.4173112-1-rmoar@google.com>
In-Reply-To: <20240126221426.4173112-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 3 Feb 2024 14:49:52 +0800
Message-ID: <CABVgOSnOEc2AGteQNwysapxmYhNy625NeErXWpg_vvci5zC-=w@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH v2] ktap_v2: add test metadata
To: Rae Moar <rmoar@google.com>
Cc: frowand.list@gmail.com, keescook@chromium.org, Tim.Bird@sony.com, 
	shuah@kernel.org, brendanhiggins@google.com, dlatypov@google.com, 
	tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, guillaume.tucker@collabora.com, corbet@lwn.net, 
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac52ad061074a36c"

--000000000000ac52ad061074a36c
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jan 2024 at 06:15, Rae Moar <rmoar@google.com> wrote:
>
> Add specification for test metadata to the KTAP v2 spec.
>
> KTAP v1 only specifies the output format of very basic test information:
> test result and test name. Any additional test information either gets
> added to general diagnostic data or is not included in the output at all.
>
> The purpose of KTAP metadata is to create a framework to include and
> easily identify additional important test information in KTAP.
>
> KTAP metadata could include any test information that is pertinent for
> user interaction before or after the running of the test. For example,
> the test file path or the test speed.
>
> Since this includes a large variety of information, this specification
> will recognize notable types of KTAP metadata to ensure consistent format
> across test frameworks. See the full list of types in the specification.
>
> Example of KTAP Metadata:
>
>  KTAP version 2
>  # ktap_test: main
>  # ktap_arch: uml
>  1..1
>      KTAP version 2
>      # ktap_test: suite_1
>      # ktap_subsystem: example
>      # ktap_test_file: lib/test.c
>      1..2
>      ok 1 test_1
>      # ktap_test: test_2
>      # ktap_speed: very_slow
>      # custom_is_flaky: true
>      ok 2 test_2
>  ok 1 test_suite

This 'test_suite' name doesn't match the 'suite_1' name above.

It also could be clearer that it's supposed to match 'suite_1', not
'main', due to the indentation difference. Maybe we should add an
explicit note pointing that out?

>
> The changes to the KTAP specification outline the format, location, and
> different types of metadata.
>
> Here is a link to a version of the KUnit parser that is able to parse test
> metadata lines for KTAP version 2. Note this includes test metadata
> lines for the main level of KTAP.
>
> Link: https://kunit-review.googlesource.com/c/linux/+/5889

I tested this, and it works well. I think there's a couple of changes
we'd want for a more useful set of KUnit parser changes (namely the
option to support non ktap_ prefixes, as well as an actual way of
using this data), but I'll leave those for a future review of that
patch -- it's not relevant to this spec.

>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

I like this: it covers all of the requirements we have in KUnit, as
well as a few things we'd like to add.

Is there anything obviously missing for this to work with other
usecases? Are there any other examples of metadata people want to
capture?

For me, this is
Reviewed-by: David Gow <davidgow@google.com>

>  Documentation/dev-tools/ktap.rst | 163 ++++++++++++++++++++++++++++++-
>  1 file changed, 159 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index ff77f4aaa6ef..4480eaf5bbc3 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which may be nested: i.e., test
>  can have subtests), each of which can contain both diagnostic data -- e.g., log
>  lines -- and a final result. The test structure and results are
>  machine-readable, whereas the diagnostic data is unstructured and is there to
> -aid human debugging.
> +aid human debugging. One exception to this is test metadata lines - a type
> +of diagnostic lines. Test metadata is used to identify important supplemental
> +test information and can be machine-readable.
>
>  KTAP output is built from four different types of lines:
>  - Version lines
>  - Plan lines
>  - Test case result lines
> -- Diagnostic lines
> +- Diagnostic lines (including test metadata)
>
>  In general, valid KTAP output should also form valid TAP output, but some
>  information, in particular nested test results, may be lost. Also note that
>  there is a stagnant draft specification for TAP14, KTAP diverges from this in
> -a couple of places (notably the "Subtest" header), which are described where
> -relevant later in this document.
> +a couple of places, which are described where relevant later in this document.
>
>  Version lines
>  -------------
> @@ -166,6 +167,154 @@ even if they do not start with a "#": this is to capture any other useful
>  kernel output which may help debug the test. It is nevertheless recommended
>  that tests always prefix any diagnostic output they have with a "#" character.
>
> +KTAP metadata lines
> +-------------------
> +
> +KTAP metadata lines are a subset of diagnostic lines that are used to include
> +and easily identify important supplemental test information in KTAP.
> +
> +.. code-block:: none
> +
> +       # <prefix>_<metadata type>: <metadata value>
> +
> +The <prefix> indicates where to find the specification for the type of
> +metadata. The metadata types listed below use the prefix "ktap" (See Types of
> +KTAP Metadata).
> +
> +Types that are instead specified by an individual test framework use the
> +framework name as the prefix. For example, a metadata type documented by the
> +kselftest specification would use the prefix "kselftest". Any metadata type
> +that is not listed in a specification must use the prefix "custom". Note the
> +prefix must not include spaces or the characters ":" or "_".

We should probably be more explicit about what counts as a
'specification' here, and hence whether a new prefix or 'custom'
should be used.

I'm tempted to be inspired by the OpenGL extension mechanism and say
that new prefixes must be 'registered' before they can be used, where
'registration' consists of submitting a patch to this document linking
to the specification.

> +The format of <metadata type> and <value> varies based on the type. See the
> +individual specification. For "custom" types the <metadata type> can be any
> +string excluding ":", spaces, or newline characters and the <value> can be any
> +string.
> +
> +**Location:**
> +
> +The first KTAP metadata entry for a test must be "# ktap_test: <test name>",
> +which acts as a header to associate metadata with the correct test.
> +
> +For test cases, the location of the metadata is between the prior test result
> +line and the current test result line. For test suites, the location of the
> +metadata is between the suite's version line and test plan line. See the
> +example below.
> +
> +KTAP metadata for a test does not need to be contiguous. For example, a kernel
> +warning or other diagnostic output could interrupt metadata lines. However, it
> +is recommended to keep a test's metadata lines together when possible, as this
> +improves readability.

Should we give an example of this? e.g. ktap_duration will need to be
output after the test has completed, but ktap_test must be output
before any log lines. (And most of the others probably prefer to be at
the beginning.)

I think this is the most complicated point from a parsing point of
view, so we should probably draw more attention to it.

> +
> +**Here is an example of using KTAP metadata:**
> +
> +::
> +
> +        KTAP version 2
> +        # ktap_test: main
> +        # ktap_arch: uml
> +        1..1
> +          KTAP version 2
> +          # ktap_test: suite_1
> +          # ktap_subsystem: example
> +          # ktap_test_file: lib/test.c
> +          1..2
> +          ok 1 test_1
> +          # ktap_test: test_2
> +          # ktap_speed: very_slow
> +          # custom_is_flaky: true
> +          ok 2 test_2
> +        # suite_1 passed
> +        ok 1 suite_1

Would it be clearer to have some examples which have other,
non-metadata diagnostic lines here, so we can see how they interact?

> +
> +In this example, the tests are running on UML. The test suite "suite_1" is part
> +of the subsystem "example" and belongs to the file "lib/example_test.c". It has
> +two subtests, "test_1" and "test_2". The subtest "test_2" has a speed of
> +"very_slow" and has been marked with a custom KTAP metadata type called
> +"custom_is_flaky" with the value of "true".
> +
> +**Types of KTAP Metadata:**
> +
> +This is the current list of KTAP metadata types recognized in this
> +specification. Note that all of these metadata types are optional (except for
> +ktap_test as the KTAP metadata header).
> +
> +- ``ktap_test``: Name of test (used as header of KTAP metadata). This should
> +  match the test name printed in the test result line: "ok 1 [test_name]".
> +
> +- ``ktap_module``: Name of the module containing the test
> +
> +- ``ktap_subsystem``: Name of the subsystem being tested
> +
> +- ``ktap_start_time``: Time tests started in ISO8601 format
> +
> +  - Example: "# ktap_start_time: 2024-01-09T13:09:01.990000+00:00"
> +
> +- ``ktap_duration``: Time taken (in seconds) to execute the test
> +
> +  - Example: "ktap_duration: 10.154s"
> +
> +- ``ktap_speed``: Category of how fast test runs: "normal", "slow", or
> +  "very_slow"
> +
> +- ``ktap_test_file``: Path to source file containing the test. This metadata
> +  line can be repeated if the test is spread across multiple files.
> +
> +  - Example: "# ktap_test_file: lib/test.c"
> +
> +- ``ktap_generated_file``: Description of and path to file generated during
> +  test execution. This could be a core dump, generated filesystem image, some
> +  form of visual output (for graphics drivers), etc. This metadata line can be
> +  repeated to attach multiple files to the test.
> +
> +  - Example: "# ktap_generated_file: Core dump: /var/lib/systemd/coredump/hello.core"
> +
> +- ``ktap_log_file``: Path to file containing kernel log test output
> +
> +  - Example: "# ktap_log_file: /sys/kernel/debugfs/kunit/example/results"

When should we use something generic like 'ktap_generated_file',
versus something more specific, like 'ktap_log_file'?

> +
> +- ``ktap_error_file``: Path to file containing context for test failure or
> +  error. This could include the difference between optimal test output and
> +  actual test output.
> +
> +  - Example: "# ktap_error_file: fs/results/example.out.bad"
> +
> +- ``ktap_results_url``: Link to webpage describing this test run and its
> +  results
> +
> +  - Example: "# ktap_results_url: https://kcidb.kernelci.org/hello"
> +
> +- ``ktap_arch``: Architecture used during test run
> +
> +  - Example: "# ktap_arch: x86_64"
> +
> +- ``ktap_compiler``: Compiler used during test run
> +
> +  - Example: "# ktap_compiler: gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"
> +
> +- ``ktap_respository_url``: Link to git repository of the checked out code.
> +
> +  - Example: "# ktap_respository_url: https://github.com/torvalds/linux.git"
> +
> +- ``ktap_git_branch``: Name of git branch of checked out code
> +
> +  - Example: "# ktap_git_branch: kselftest/kunit"
> +
> +- ``ktap_kernel_version``: Version of Linux Kernel being used during test run
> +
> +  - Example: "# ktap_kernel_version: 6.7-rc1"
> +
> +- ``ktap_commit_hash``: The full git commit hash of the checked out base code.
> +
> +  - Example: "# ktap_commit_hash: 064725faf8ec2e6e36d51e22d3b86d2707f0f47f"
> +
> +**Other Metadata Types:**
> +
> +There can also be KTAP metadata that is not included in the recognized list
> +above. This metadata must be prefixed with the test framework, ie. "kselftest",
> +or with the prefix "custom". For example, "# custom_batch: 20".
> +
>  Unknown lines
>  -------------
>
> @@ -206,6 +355,7 @@ An example of a test with two nested subtests:
>         KTAP version 2
>         1..1
>           KTAP version 2
> +         # ktap_test: example
>           1..2
>           ok 1 test_1
>           not ok 2 test_2
> @@ -219,6 +369,7 @@ An example format with multiple levels of nested testing:
>         KTAP version 2
>         1..2
>           KTAP version 2
> +         # ktap_test: example_test_1
>           1..2
>             KTAP version 2
>             1..2
> @@ -254,6 +405,7 @@ Example KTAP output
>         KTAP version 2
>         1..1
>           KTAP version 2
> +         # ktap_test: main_test
>           1..3
>             KTAP version 2
>             1..1
> @@ -261,11 +413,14 @@ Example KTAP output
>             ok 1 test_1
>           ok 1 example_test_1
>             KTAP version 2
> +        # ktap_test: example_test_2
> +        # ktap_speed: slow
>             1..2
>             ok 1 test_1 # SKIP test_1 skipped
>             ok 2 test_2
>           ok 2 example_test_2
>             KTAP version 2
> +           # ktap_test: example_test_3
>             1..3
>             ok 1 test_1
>             # test_2: FAIL
>
> base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
> --
> 2.43.0.429.g432eaa2c6b-goog
>

--000000000000ac52ad061074a36c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIMA+aseay74EIYxrfZBfZwUctnYKQrAKoUIk2EmK+jF4MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIwMzA2NTAwOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAAigkS
3q8OC4tJsXCsyLxT8fFhqpptTYetnukOEtwQOnW+EfV6R84MmhkjxvKAEGTJDUflcEYDA9ifH/nK
JwXyajrArdejlzW3K6WvNGkrO3Rb0ip9hYQr75G9y32VP9d9Hi4DdXDnzDFvaQWzihTCBwF+D1+A
LluBOEw4GuMKwtb4rAOyOmvWctsqt60QgiR2xfGzmBHOCx7+oUpf6uZBJFMeseszjXT73oMaFFjn
aqEhC6nciw+IwQU6oeIrPy5Jo7uKQ+RQ4wlg2lNGC6aqDbyi2BHaSuR1B17+qQK/t7Uj826bd/HD
y2jW39pQnhVIBCPp5xhNLDeVPr4gM/6n
--000000000000ac52ad061074a36c--

