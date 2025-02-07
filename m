Return-Path: <linux-kselftest+bounces-25983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D172DA2C01A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE73169D1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFF1D63EB;
	Fri,  7 Feb 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="P+HaF7qw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1C1D31B8
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922490; cv=none; b=jmsBchc7b81adbKzyj0tjvjdZXaOs7q/a8TwYYOnJ/x0i1Al25I+rEgU2njCsr8x0FQM1SqR+RHFpiSRtgRPol3f+t28xvEDsZr8/CVzFO13lPhQIJWZCO5XFkp4jmtQ6QUttyZ3CUo+62yn8WtzvJXZDvt96OF62Wp8bQ6aIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922490; c=relaxed/simple;
	bh=k4Iax+rVsxQ2OZILw0McvF0gD8dT6wLCmKggAsyIyjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dURCHR66cxFb0rinbbVgnpJeQrJodoK+uFmxr/oW/9SMXIKsrx3+EMmadawXTIGiB51YwNRpKbWe02MiSnzCM6ae5DIdeSZvW5xv+1xWrVHG5aQgDzTrzltscnM+/29AiQPgfBExrN42fpDVSxolWS74DSA/H5QztiDv92SFVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=P+HaF7qw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543cc81ddebso2153536e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 02:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1738922487; x=1739527287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bXaE9uM1wAIJE3wNAl6avT4onwqnNJr2t6nZiCghwI=;
        b=P+HaF7qwGYWoKYLSZkZVnvvItwX/Dw2AX7A3G/DqcN/kGHwlrkCvFhdJLwHhwMm72z
         uJ/C+L36E4Yw8B0yXOJZAMPq8Vmz2Pq+8KpiC/h64EdGo5GxQL3aQTf3TfsZQxdcstD+
         ii54IRW6BlltPaKmwqhtO/s7DVuY+khxV6jUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738922487; x=1739527287;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bXaE9uM1wAIJE3wNAl6avT4onwqnNJr2t6nZiCghwI=;
        b=QA1vOg8GgAp9XeyqXzohduzmF3KCxZObNs2xBam/3Uuz9PMw382TG4KFZryQFlhq2H
         Vo8Y6lHQvejKB41Ox0UIMZRO+rT4Wl4PBfA48nuuEjz7XrJ6nM1Tt+A2tdUN6FA21K/8
         HUnulrI0axzoTo7BsZChZH6Ilzo/zaU7+MAGD+rHLdvb9VAXaYzmOcnmbYZ+hLNph1sy
         YFD8AkNa7Itu0sBO58XldPPzDDs/DVjDrPSBAxwtKWyLqZQgpmMCJpaJaGtNnRkdEFm1
         MjXQ425qYxdAv9TsUQcHONl+9Obz+ivjuJzk+sb0tSLYRdnUBgON4Xn1DiHDkztnfMIE
         AW8A==
X-Forwarded-Encrypted: i=1; AJvYcCVzJ+RdQWq8TfWY1UzeGT62JlAwR8KjAP89Opaxw94BB6OMoR3m1iSb5jPZ+T1HeXvsizqpRXgmDbixGDx7XfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvI+5xNMwaHOsH5tKskAnhcF17vevp4Fe3nNI8LfcR1xNBorR
	gti9bcJhLviVAeYNQET0pF7IBbTuNhUc4bhOmSq4AMLjKW86RPg/hjYJAgP1ADU=
X-Gm-Gg: ASbGnctlDB1jdtEpOwM0odpernEXhV3N/6pq2ZJyDkJMIPutPMNn0e0gI5UggB7pyi4
	2imWs8c0vmSdDSodpenfEJXC27aDLToqW8ln+IjTBLa3VeFFmFbhUXu7u+8oMWHR/RSvrrNs06N
	YyBXiE+NrNMOBvxINfF2ZgBEvKaeaplaLvEu0wby5CGWZ0n/X0qHP/GX/rJJ4XYNsa5x1ZqROW9
	9NRL6Q12bhgoPv0bU7+R+aYUA+ICfpACtVWPyxOQfEUTDy/OSblcF7kB0YFshlhzl3ojMPzdad9
	qYB2JKOfrX0zWOEY
X-Google-Smtp-Source: AGHT+IFVC+fHVOR3o3VNmty7EZKqILMlaL5Bz5efSjdDmNBg7RVjDgnayqGUPxgvIQNjMG3MjFdD7g==
X-Received: by 2002:ac2:5f6d:0:b0:53e:395c:688b with SMTP id 2adb3069b0e04-54414ae629dmr580950e87.47.1738922486685;
        Fri, 07 Feb 2025 02:01:26 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5441053ec2asm396233e87.49.2025.02.07.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:01:26 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>,  Petr Mladek <pmladek@suse.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Shuah Khan <shuah@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
In-Reply-To: <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
	(Tamir Duberstein's message of "Thu, 6 Feb 2025 10:42:03 -0500")
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
	<CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
	<CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
Date: Fri, 07 Feb 2025 11:01:25 +0100
Message-ID: <87bjvers3u.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:

> On Thu, Feb 6, 2025 at 4:27=E2=80=AFAM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On Tue, 4 Feb 2025 at 20:36, Tamir Duberstein <tamird@gmail.com> wrote:
>> >
>> > This is one of just 3 remaining "Test Module" kselftests (the others
>> > being bitmap and scanf), the rest having been converted to KUnit.
>> >
>> > I tested this using:
>> >
>> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D=
1 printf
>> >
>> > I have also sent out a series converting scanf[0].
>> >
>> > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-38=
6d7c3ee714@gmail.com/T/#u [0]
>> >
>>
>> Sorry, but NAK, not in this form.
>>
>> Please read the previous threads to understand what is wrong with this
>> mechanical approach. Not only is it wrong, it also actively makes the
>> test suite much less useful.
>>
>> https://lore.kernel.org/lkml/f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmus=
villemoes.dk/
>> https://lore.kernel.org/lkml/876cc862-56f1-7330-f988-0248bec2fbad@rasmus=
villemoes.dk/
>> https://lore.kernel.org/lkml/0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmus=
villemoes.dk/
>>
>> I think the previous attempt was close to something acceptable (around
>> https://lore.kernel.org/lkml/57976ff4-7845-d721-ced1-1fe439000a9b@rasmus=
villemoes.dk/),
>> but I don't know what happened to it.
>>
>> Rasmus
>
> Thanks Rasmus, I wasn't aware of that prior effort. I've gone through
> and adopted your comments - the result is a first patch that is much
> smaller (104 insertions(+), 104 deletions(-)) and failure messages
> that are quite close to what is emitted now. I've taken care to keep
> all the control flow the same, as you requested. The previous
> discussion concluded with a promise to send another patch which didn't
> happen. May I send a v2 with these changes, or are there more
> fundamental objections? I'll also cc Arpitha and Brendan. The new
> failure output:
>
>     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
> vsnprintf(buf, 256, "%piS|%pIS", ...) wrote
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
> vsnprintf(buf, 19, "%piS|%pIS", ...) wrote '127.000.000.001|12',
> expected '127-000.000.001|12'
>     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:131
> kvasprintf(..., "%piS|%pIS", ...) returned
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'

That certainly addresses one of my main objections; I really don't want to =
see
"memcmp(..., ...) =3D=3D 1, expected memcmp(..., ...) =3D=3D 0". And you sa=
id
you've kept the control flow/early returns the same, so that should also
be ok.

I'll have to see the actual code, of course. In general, I find reading
code using those KUNIT macros quite hard, because I'm not familiar with
those macros and when I try to look up what they do they turn out to be
defined in terms of other KUNIT macros 10 levels deep.

But that still leaves a few points. First, I really like that "388 test
cases passed" tally or some other free-form summary (so that I can see
that I properly hooked up, compiled, and ran a new testcase inside
test_number(), so any kind of aggregation on those top-level test_* is
too coarse).

The other thing I want to know is if this would make it harder for me to
finish up that "deterministic random testing" thing I wrote [*], but
never got around to actually get it upstream. It seems like something
that a framework like kunit could usefully provide out-of-the-box (which
is why I attempted to get it into kselftest), but as long as I'd still
be able to add in something like that, and get a "xxx failed, random
seed used was 0xabcdef" line printed, and run the test again setting the
seed explicitly to that 0xabcdef value, I'm good.

[*] https://lore.kernel.org/lkml/20201025214842.5924-4-linux@rasmusvillemoe=
s.dk/

Rasmus

