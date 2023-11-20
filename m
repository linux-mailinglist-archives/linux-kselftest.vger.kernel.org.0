Return-Path: <linux-kselftest+bounces-337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9A7F1CE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 19:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187FC1C21144
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0251EB24;
	Mon, 20 Nov 2023 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaU9UTsV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E9C8
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 10:49:01 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so1761a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700506140; x=1701110940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdPcdKbJJEtVfw0r849sRaSkguh4va/xoo2bi7A5PKo=;
        b=XaU9UTsVbp7T7EK1Miut3YjYPcys2eKun1AaFRMtELwSFiKtjm938L0MaIQHL+04z/
         sqhvt84o7BryJd1d3YJu6BGgfaiwLKO1d+MsF+T8W5sdJKsp+5z+2zEPrZm/iiJaquPb
         Qt9MacWDdhBSPDDQSew6+xP6Ahx7nEe/IwnLlmJKBn3OYZpYY65A3VGdBfSmC55dohND
         u9GqqRDp4FTcKHxVKGyhoMuzfy15Th+mYHMI/MKAVKfG42oRZXTRtck8vWH9lTbbUgBP
         /HHz8JN4LpjpgiEzJa6oAsCfwVFbWs34ACpimQWNrnr3K6ueu962geeSJN4IW/K+Y60P
         gvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700506140; x=1701110940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdPcdKbJJEtVfw0r849sRaSkguh4va/xoo2bi7A5PKo=;
        b=VuuPRPrDkJ2hSm4QaD9fFrnAUr8yZvJXefb8P0rqHNaqtqHvDWOAMmGIgtBibBYdvI
         NftKFiyv5jX5Sp2z1uCwpRLp0p3eH804yxs76HRJmH7oPqpp6PZKV2s8CUXinFeT0JD1
         4+WPI+TJJ4Vjmv9pplGn9MsRCgnUGRDKYcjvFyZ0BuV+U3oWUyVa9iFvbdSNoTXnssI+
         VPTsUqBzLJF7vND6cQbk1n1QA8yDUC5xLMwE5uNdlxS0mkJymBHWLf016xoi4GRJqhUN
         e3EWna+JKBCmNnqWN8rMS8pDWz37ChQDqXvFd+Awk6mMKi+hk5MKE0aNVsbG/M7Nlb0P
         V0gQ==
X-Gm-Message-State: AOJu0YzCQOngcTNus0DXSpQIm8m0cntwA6ZDerrurrMb1w6T9MudEsyf
	t8bzHAZHjMAjZtUdlcPe2Z7jCmw9jRQkoz7R9kzh8w==
X-Google-Smtp-Source: AGHT+IHq1hNH843682vHffeGYc3GnkUtzYfC3xNjbXwDnYLAsQHGWgA3K2SQs1zb1ehyjwsV2INDePz3p5PhpVYrMgA=
X-Received: by 2002:aa7:d8cf:0:b0:544:e37e:d597 with SMTP id
 k15-20020aa7d8cf000000b00544e37ed597mr231268eds.7.1700506139627; Mon, 20 Nov
 2023 10:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com> <20231115175146.9848-4-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115175146.9848-4-Nikolai.Kondrashov@redhat.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Mon, 20 Nov 2023 10:48:46 -0800
Message-ID: <CAGS_qxpfnQ6kmanEUQWosuixo+FGUxp3VJ_TSjBdRf_p9riTSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Require kunit core tests for framework changes
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>, 
	Andy Whitcroft <apw@canonical.com>, "Theodore Ts'o" <tytso@mit.edu>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:52=E2=80=AFAM Nikolai Kondrashov
<Nikolai.Kondrashov@redhat.com> wrote:
> +kunit core
> +----------
> +
> +:Summary: KUnit tests for the framework itself
> +:Superset: kunit
> +:Command: tools/testing/kunit/kunit.py run --kunitconfig lib/kunit

Note: we'd want this to instead be
  ./tools/testing/kunit/run_checks.py

That will run, in parallel
* kunit.py run --kunitconfig lib/kunit
* kunit_tool_test.py (the unit test for kunit.py)
* two python type-checkers, if installed

> diff --git a/MAINTAINERS b/MAINTAINERS
> index f81a47d87ac26..5f3261e96c90f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11626,6 +11626,7 @@ L:      linux-kselftest@vger.kernel.org
>  L:     kunit-dev@googlegroups.com
>  S:     Maintained
>  W:     https://google.github.io/kunit-docs/third_party/kernel/docs/
> +V:     kunit core

Maybe this topic should go in the main thread, but I wanted to call it
out here since this is a good concrete example.

I'm wondering if this entry could simply be
  V: ./tools/testing/kunit/run_checks.py

And what if, for ext4, we could have multiple of these like
  V: kvm-xfstests smoke
  V: tools/testing/kunit/kunit.py run --kunitconfig fs/ext4

I.e. what if we allowed the `V:` field to contain the command itself?

# Complexity of the tests

I appreciate the current "named test-set" approach since it encourages
documenting *why* the test command is applicable.
And for a lot of tests, it's not as simple as a binary GOOD/BAD
result, e.g. benchmarks.
Patch authors need to understand what they're testing, if they're
testing the right thing, etc.

But on the other hand, for simpler functional tests (e.g. KUnit),
maybe it's not necessary.
Ideally, KUnit tests should be written so the failure messages are
immediately actionable w/o having to read a couple paragraphs.
I.e. the test case names should make it clear what scenario they're
testing, or the test code should be sufficiently documented, etc.

# Variations on commands

And there might be a bunch of slight variations on these commands,
e.g. only different in terms of `--kunitconfig`.
We'd probably have at least 18, given
$ find -type f -name '.kunitconfig' | wc -l
18

And again using a kunit.py flag as an example, what if maintainers want KAS=
AN?
  ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit
--kconfig_add CONFIG_KASAN=3Dy
Or what if it's too annoying to split up a larger kunit suite, so I
ask people to run a subset?
  ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit <suite_glob>


P.S.
Tbh, I have always hoped we'd eventually have a field like
  V: <one-liner test command>

That is part of why I added all those features above (--kunitconfig,
--kconfig_add, glob support, run_checks.py, etc.).
I wanted kunit.py to be flexible enough that maintainers could state
their testing requirements as a one-liner that people can just
copy-paste and run.

Also, I recently talked to David Gow and I know he was interested in
adding another feature to kunit.py to fit this use case.
Namely, the ability to do something like
  kunit.py run --arches=3Dx86_64,s390,...
and have it run the tests built across N different arches and maybe w/
M different kconfig options (e.g. a variation built w/ clang, etc.).

That would be another very powerful tool for maintainers to have.

Thanks so much for this patch series and starting this discussion!
Daniel

