Return-Path: <linux-kselftest+bounces-26353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72AA30A60
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F05B1616C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E79253B67;
	Tue, 11 Feb 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws7G5vBd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76E253B45;
	Tue, 11 Feb 2025 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273699; cv=none; b=FO4+4aDledEA7J2JqZQ/NSn8uM1HcNFUsFsl8vWBXBtrPeRU7rBTto2wLq5zNrcVL4wijwSgBwY5GvVmfoghR8ELK1KegmyA0EphOdWOaB2EXYy8R+JCdCoJ3+rIPt86zUV6ra7SNKzI03HlwmHt7p2axzDflf8hcIW1QKqGaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273699; c=relaxed/simple;
	bh=wyXvLopBFLQlFPW/k8CEdG/b31WiZUfzxGhdq0vg/wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+c17gKidrmjungnwsRsZuxohQqWoCLRaEPv28oYJEhXpddgd/iQFqOHwfahwP4sOQ9h1t3k0O3MtII5PkOVGDXCkirp0A+xR/sT3ouSc6ln0/IcHrvsl8KC2PANpmEewMaUyv9fQ5hVQ56uQ/JBDsxCju9q1naD42XuzDxRq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws7G5vBd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308f04beb24so15084201fa.2;
        Tue, 11 Feb 2025 03:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739273695; x=1739878495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyXvLopBFLQlFPW/k8CEdG/b31WiZUfzxGhdq0vg/wU=;
        b=Ws7G5vBdXc532VwwgvWCO80RlkUrk7X0fVbu1HgpFuF9yDSUNuW6gPDWU5NgVjPUMJ
         FfgEsxF/DDxeLn+svRjWUJOFYgt6na/Qb0EU7Hrzf9M1jkyCKoYHuyQrDI0le6fZd9y7
         BY1yaDFjL+4/WkJMGwuSCEKvqcece95SbTGdluyvntQdgsTgkESz3gJRo08YmNZ1Y3PR
         P9+/AKh/oxIXADb7QBaaFRPO+VHRuB5m7T41fsl7CQWIzXhfBuMjr0s3ZX1BuSxjX62k
         BLzYND54jDjC6YwgqsFla1qF2FZXjDGRGhLGdzhtrjC2xjym4npb3ZX9QD9IAszKNaCl
         pglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273695; x=1739878495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyXvLopBFLQlFPW/k8CEdG/b31WiZUfzxGhdq0vg/wU=;
        b=qspmgNnkVsgsENrT9rn7gIDnvBipyzdaf4viLsXOBzqMBLZb+7EE8dpmLNNzSbaUAJ
         U6YPVCzHGR2Qgudaht9p8vrD2pLUgAKco0IkcxbK44Xl59SeQXAWUXLcwrECEcYSTyPO
         lejE6Rssz1U861xzYHwSNMLVszW9qVMQ4J5MXTme3DDKmJix0sOtxIYg8mHvzUjNYjQp
         sZfIsOccQXdaQt/KGi66F84MsrVA66W408F8QBX1KZjsRQofru9ZHG/7/SNu7PPuNTAY
         k/lt7maGkAaMKKcMIWn+OIMqO3aPuPrZgSbILd3QIlgsFjisLQ5ubHRXoH/URnSG9xnS
         xscQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg2Shpp/deQxXGf8vr00kwvz3Y2r0AsP79JH9dMgYtnxGyaMuzJUWhyJv+9ohe+s8YgC0+5PVz/pAOvRn3Sf97@vger.kernel.org, AJvYcCWXAJ8Gy6N2keboY09/Hkve78YcHBy9a67hkL/nxDaw0eY67058i9k5UQZ7cUDtmdD7tBbdmcD+87Yj/d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUzAWMm5yMw9uT91VCb5w2OQv1hDGqpkBXHT+kSFwqzoqRMU5
	v34HwQC5vFeOr797a0MunznhUwwR16YubgMw+7KknbX+zFQmm6dStTvgiFImhkF/YpOETtjq4Rc
	+D9rRmmXUz2taUHf0/U0YNWIsztU=
X-Gm-Gg: ASbGnctNogzY+QhbrNL17sNQRtrPwVnPrQnKfeQ7IjqnLChk7ecAHX0QHiYsopkSD1g
	9p588D52sn7TtLjor8SMsTQQfsBROeqALp1zHgmmbcSMEcbhlyQoKTAb9drXDllHTGnFKlZNbnN
	8g/o1H29pn27XbBzdrEMSx/UiBsw6+
X-Google-Smtp-Source: AGHT+IGmEB14jF8lIa6nowbA8IXD6SluUmrQkSpS116NgUH3mpfZzJ0Ewrr7WpDNnU+D8BsYok6UUzkBmcfw4FO1/dg=
X-Received: by 2002:a2e:9fc2:0:b0:308:f01f:182c with SMTP id
 38308e7fff4ca-308f01f1e9cmr25851901fa.12.1739273695238; Tue, 11 Feb 2025
 03:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
 <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
 <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
 <87bjvers3u.fsf@prevas.dk> <CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
 <87y0yeqafu.fsf@prevas.dk> <CABVgOS=dfuX+X8=EVHcrCZnbOZj3T+wGD922eoeHb-dcOmmzXw@mail.gmail.com>
 <87h650ri08.fsf@prevas.dk>
In-Reply-To: <87h650ri08.fsf@prevas.dk>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 06:34:19 -0500
X-Gm-Features: AWEUYZmFwRkMBeNDX4ZekpNR0Cqv80Jbd9Y15e5FsQCQTm0FfAKPwbtociTRA6o
Message-ID: <CAJ-ks9mKZVSZzgaPbJ3t3qcx0bMc1LUH+GueOtVX4UAWbntdvg@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:40=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Tue, Feb 11 2025, David Gow <davidgow@google.com> wrote:
>
> > On Mon, 10 Feb 2025 at 19:57, Rasmus Villemoes <linux@rasmusvillemoes.d=
k> wrote:
> >>
> >> On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> >>
> >> > On Fri, Feb 7, 2025 at 5:01=E2=80=AFAM Rasmus Villemoes
> >> > <linux@rasmusvillemoes.dk> wrote:
> >> >>
> >> >> On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> >> >>
> >> >>
> >> >> I'll have to see the actual code, of course. In general, I find rea=
ding
> >> >> code using those KUNIT macros quite hard, because I'm not familiar =
with
> >> >> those macros and when I try to look up what they do they turn out t=
o be
> >> >> defined in terms of other KUNIT macros 10 levels deep.
> >> >>
> >> >> But that still leaves a few points. First, I really like that "388 =
test
> >> >> cases passed" tally or some other free-form summary (so that I can =
see
> >> >> that I properly hooked up, compiled, and ran a new testcase inside
> >> >> test_number(), so any kind of aggregation on those top-level test_*=
 is
> >> >> too coarse).
> >> >
> >> > This one I'm not sure how to address. What you're calling test cases
> >> > here would typically be referred to as assertions, and I'm not aware
> >> > of a way to report a count of assertions.
> >> >
> >>
> >> I'm not sure that's accurate.
> >>
> >> The thing is, each of the current test() instances results in four
> >> different tests being done, which is roughly why we end up at the 4*97
> >> =3D=3D 388, but each of those tests has several assertions being done =
-
> >> depending on which variant of the test we're doing (i.e. the buffer
> >> length used or if we're passing it through kasprintf), we may do only
> >> some of those assertions, and we do an early return in case one of tho=
se
> >> assertions fail (because it wouldn't be safe to do the following
> >> assertions, and the test as such has failed already). So there are far
> >> more assertions than those 388.
> >>
> >> OTOH, that the number reported is 388 is more a consequence of the
> >> implementation than anything explicitly designed. I can certainly live
> >> with 388 being replaced by 97, i.e. that each current test() invocatio=
n
> >> would count as one KUNIT case, as that would still allow me to detect =
a
> >> PEBKAC when I've added a new test() instance and failed to actually ru=
n
> >> that.
> >
> > It'd be possible to split things up further into tests, at the cost of
> > it being a more extensive refactoring, if having the more granular
> > count tracked by KUnit were desired.
>
> I think the problem is that kunit is simply not a good framework to do
> these kinds of tests in, and certainly it's very hard to retrofit kunit
> after the fact.
>
> It'd also be possible to make
> > these more explicitly data driven via a parameterised test (so each
> > input/output pair is listed in an array, and automatically gets
> > converted to a KUnit subtest).
>
> So that "array of input/output" very much doesn't work for these
> specific tests: We really want the format string/varargs to be checked
> by the compiler, and besides, there's no way to store the necessary
> varargs and generate a call from those in an array. Moreover, we verify a
> lot more than just that the correct string is produced; it's also a
> matter of the right return value regardless of the passed buffer size, et=
c.
>
> That's also why is nigh impossible to simply change __test() into
> (another) macro that expands to something that defines an individual
> struct kunit_case, because the framework is really built around the
> notion that each case can be represented by a void function call and the
> name of the test is the stringification of the function name.
>
> So I don't mind the conversion to kunit if that really helps other
> people, as long as the basic functionality is still present and doesn't
> impede future extensions - and certainly I don't want to end up in a
> situation where somebody adds a new %p extension but cannot really add a
> test for it because kunit makes that hard.
>
> But I hope you all agree that it doesn't make much _sense_ to consider
> test_number() and test_string() and so on individual "test cases"; the
> atomic units of test being done in the printf suite is each invocation
> of the __test() function, with one specific format string/varargs
> combination.
>
> Rasmus

Rasmus, does v3 meet your needs?

https://lore.kernel.org/all/20250210-printf-kunit-convert-v3-1-ee6ac5500f5e=
@gmail.com/

Weirdly the cover letter seems to be missing on lore, should I resend?

