Return-Path: <linux-kselftest+bounces-13985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C8938CE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 12:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1692867EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54216D9C8;
	Mon, 22 Jul 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5/+pC3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783916D9B3
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642161; cv=none; b=TrxAuIgzAbQNIU/Gd8gWVCBzP/LDRzZyrIPvfPgH37t08zAzhD89jKG84p0xpjAdwvhc33RJyjG0J5IIQ5cq+3rHZ1dS5aG/ni3Yp/94Mm6s+t3+iwf4XfUcH/Zfcv4a5NgljvXlP5XmZJV4QIPN2HDW4obmHI9/WALV/iflUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642161; c=relaxed/simple;
	bh=o8nGtEc2kpnMUmf2U71YT6yCSot9yCpI/7sIaXOluA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVVSR1zMU/g1FAhlK/PaKnV1TWP8awnNxXtfcXoUZoGaMSNOw3cWgihEaBUa0+S1qPKIiPHMyFNsjeJbngUGo3ykYug6ivb26WcGIoD8R4MlW7FRPG4drYSiIDnfSDKal1mE/ZcYCtxPkfcTasLnZOjo4Z+fC9vMb19U1bKP8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5/+pC3Y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so19897365e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721642157; x=1722246957; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTtJ+vDA5uzuu0VDx7khbFQ5AXZbG+ve0g3qIVvAkRU=;
        b=v5/+pC3YV4VYwpXMDMw+v72zsuqk0K4uIjeWuN138Lw9rlaVkLSGdsMOiG9txwChNj
         yCMizxby7sKqEZUdjBqlVwdKWb6zKx4z+j0WIZ80rLYXUMocJWNCsXY7TOE9aqCkC/rA
         yDvm3tlLoxDoRIn8gilPv1UcGT8YGCPbHXvgZOdzXMIGKKxZpgSqxUR3OEfo4AZUcGlt
         gdAj9l6KfmO3loIv7S6lPWOaPYNpggzkBlowi7A7d4rmAYZLIHqojse0+ZDx2eCS5/3m
         /T6hLAFARKwCmfhwaI+dgW+qoRafB0KCE3jinjiwkgqm1c5+imniIRvPzRhDz4UKsfbP
         Vp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642157; x=1722246957;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTtJ+vDA5uzuu0VDx7khbFQ5AXZbG+ve0g3qIVvAkRU=;
        b=DcToi3oNop/O3AOt0I6HLG7Ag4eiOP7YcC/yTXgAceG2qgl6pLhlEw2xXVg2a0/A4Z
         P39+plFdCGd0NRxipqyzd6XFHB1ycp2IPYzXL3cGZBf7g55389SQblosVQvlMqpI+PZ+
         TdxFFPR4LGm/VnRnbRyT+FAtxn6apgbpKPOvJsRLkeWOPXMCOrGo8fv5midglU0y2ILn
         EVzusdhZQ+bHVWviMABI8p767NMgovBz0HSncdVqmoWYPW28dZSRYszAKIkKsMMQttYN
         +gYoXsLCs8HCu3kvdzk2wItcLrl7D7cWUtfQkSbyyVRAyIFWnxwfAOgOwHy9JXfdcIL+
         ruAw==
X-Forwarded-Encrypted: i=1; AJvYcCUWxurLQKpT5NAwXWfVdP2jXNTghakZnn3y0Ykmr9SfEXAtpRNm9FM3ZKiE0IXLHgCZDwlZv42Rubm8HoYh0QvV1U6ChB3eHR/3+VaaY2Ic
X-Gm-Message-State: AOJu0YzpHirg/bTa0WcTRpShYS0k9EC4I/HEZLP9cmLQcSOK8c9IB2co
	gAtRsfGQmyLYTCAGf/AotqjFAEfUcFeMjTtIt6SLTCQKkaWdy6F9AA1hP61/3g==
X-Google-Smtp-Source: AGHT+IHipZhj7Y2KFl3PDY3WTjrKvQpfTpc9/K6/8B/38O0e+y0ScKh6+mqCVh+sNi1ktWRbzCY1Sw==
X-Received: by 2002:a05:600c:5486:b0:427:aab7:976b with SMTP id 5b1f17b1804b1-427d2a8e1b1mr80885665e9.5.1721642157104;
        Mon, 22 Jul 2024 02:55:57 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:4fae:446:e08f:a725])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d692996bsm120952255e9.37.2024.07.22.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:55:56 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:55:50 +0200
From: Marco Elver <elver@google.com>
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: KUnit: Update filename best practices
Message-ID: <Zp4spjsaqQ85fVuk@elver.google.com>
References: <20240720165441.it.320-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720165441.it.320-kees@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Sat, Jul 20, 2024 at 09:54AM -0700, Kees Cook wrote:
> Based on feedback from Linus[1] and follow-up discussions, change the
> suggested file naming for KUnit tests.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
[...]
>  Documentation/dev-tools/kunit/style.rst | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> index b6d0d7359f00..1538835cd0e2 100644
> --- a/Documentation/dev-tools/kunit/style.rst
> +++ b/Documentation/dev-tools/kunit/style.rst
> @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
>  Test File and Module Names
>  ==========================
>  
> -KUnit tests can often be compiled as a module. These modules should be named
> -after the test suite, followed by ``_test``. If this is likely to conflict with
> -non-KUnit tests, the suffix ``_kunit`` can also be used.
> -
> -The easiest way of achieving this is to name the file containing the test suite
> -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> -placed next to the code under test.
> +Whether a KUnit test is compiled as a separate module or via an
> +``#include`` in a core kernel source file, the file should be named
> +after the test suite, followed by ``_kunit``, and live in a ``tests``
> +subdirectory to avoid conflicting with regular modules (e.g. if "foobar"
> +is the core module, then "foobar_kunit" is the KUnit test module) or the
> +core kernel source file names (e.g. for tab-completion). Many existing
> +tests use a ``_test`` suffix, but this is considered deprecated.

What's wrong with the `_test` suffix (if inside a "tests" subdir)?

Rules are good, but please can we retain some common sense?

I understand the requirement for adding things to a "tests" subdir, so
that $foo.c is not right next to a $foo_test.c or $foo_kunit.c.

There are exception, however, if there is no $foo.c. For example:

	- mm/kfence/kfence_test.c
	- kernel/kcsan/kcsan_test.c
	- mm/kmsan/kmsan_test.c

In all these cases it'd be very annoying to move things into a "tests"
subdir, because there's only 1 test, and there isn't even a $foo.c file.
While there's a $foo.h file, I consider deeper directory nesting with 1
file in the subdir to be more annoying.

The rules should emphasize some basic guidelines, as they have until
now, and maybe add some additional suggestions to avoid the problem that
Linus mentioned. But _overfitting_ the new rules to avoid that single
problem is just adding more friction elsewhere if followed blindly.

> +So for the common case, name the file containing the test suite
> +``tests/<suite>_kunit.c``. The ``tests`` directory should be placed at
> +the same level as the code under test. For example, tests for
> +``lib/string.c`` live in ``lib/tests/string_kunit.c``.
>  
>  If the suite name contains some or all of the name of the test's parent
> -directory, it may make sense to modify the source filename to reduce redundancy.
> -For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> -file.
> +directory, it may make sense to modify the source filename to reduce
> +redundancy. For example, a ``foo_firmware`` suite could be in the
> +``tests/foo/firmware_kunit.c`` file.

I'm more confused now. This is just moving tests further away from what
they are testing for no good reason. If there's a directory "foo", then
moving things to "tests/foo" is unclear. It's unclear if "tests" is
inside parent of "foo" or actually a subdir of "foo". Per the paragraph
above, I inferred it's "foo/tests/foo/...", which is horrible. If it's
"../tests/foo/..." it's also bad because it's just moving tests further
away from what they are testing.

And keeping tests close to the source files under test is generally
considered good practice, as it avoids the friction required to discover
where tests live. Moving tests to "../tests" or "../../*/tests" in the
majority of cases is counterproductive.

It is more important for people to quickly discover tests nearby and
actually run them, vs. having them stashed away somewhere so they don't
bother us.

While we can apply common sense, all too often someone follows these
rules blindly and we end up with a mess.

Thanks,
- Marco

