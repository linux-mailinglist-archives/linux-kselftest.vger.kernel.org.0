Return-Path: <linux-kselftest+bounces-28498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1515A56DAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF4C1895008
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C323BCFA;
	Fri,  7 Mar 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJO7iZRA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426F2222D5;
	Fri,  7 Mar 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364904; cv=none; b=LZWXMAXFfmZcL8uh9G1O6Fjki9fpaErwtHrAoiHoPqM/234UgDJ3OKErj//gOY4VGUQdFWdrAojRxwUeeocBtW6V5aS/l5I5CpmmQkWIkkmx0YaGGgB/d+PSk5GIeY8Ozkj111JtCqpLtgKZ/n2fBeoCQv25S60xc4TkYFx8r60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364904; c=relaxed/simple;
	bh=VxcHd1H17cUMYI5rNpPX51cxBoA6PriWVOZUqZM5llk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmrovpGzNUJtwZySqlUB2HtLZTjEmwt2UiTFJOEVRB75D5u0rcJJt5wxIKN8669iTakJUkhtDMXd8SgKO+nJKHuuPVENh79G4V3BkL/LCvlpBXV9Tshqej6H/pIHIImtlsEGsuUEGJyXlh3bDtPQb+HW2rdleeU/GeL5jyQvhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJO7iZRA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf251025aso11006681fa.1;
        Fri, 07 Mar 2025 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364901; x=1741969701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LDrfNP0P1DLF6th+Id2FgZJU1V1LRDhdOalVdghfLk=;
        b=UJO7iZRA/s+eEo4vtouBfs+EMUHqhupk5zlnPTZeYbuhFgDYZc6Q2p2SVzInRnYNKi
         4ErfGOEfkIc83OjeDepYuXGAGzsEtzy6x2WFkcHupJx5lfpBwqZQQSOHYpFmwH3anEGr
         IvAbs2QHIMDFScxfj093rtoWLIvNzPiU8zMfCJZheHkDqYRAQaMWF0DsyNlWRmJFEJYc
         87Sd+fOJvS20IjgjnoNWWUUNu1BaCctpL2LJpDLlh/8TFiMAP8THwdb8ZaplrxwvYH9r
         jDvnokImZ0KiG/BLPQA4S5xcjPEVVyK23WfPtTCz2Arij2/6pPZVZsJQgawCb6a1qZtd
         TaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364901; x=1741969701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LDrfNP0P1DLF6th+Id2FgZJU1V1LRDhdOalVdghfLk=;
        b=g3myABsF0LDdNKA1sN2MqhFZaVe+WGsWPcDMNfekRkWzau0mPf3uHrfFm8Xq2QT6G7
         +PF5Rf2GRNh6h8t1NryfqvknDoJEnyBfmuttpR5TNbSuoXS7hcRXTIXxG5bvi+gqORxJ
         nNPYtBfUy4nrm/ZWYC726QnSvbtCVKm59+7NqnrrWVPUwIIJQEKUngPU7zENGGjPCX6z
         lmKiccp8XK0qUUxx67YjzfPsQZYQdhIDeqGuSAYGjzqCNJmkV0mSqjd++gLHKK2FfbXd
         +ySIMba0Qje17g2eXwIqtYjY1TZSyieS/uHFFOYhf9dZJ3I/cXrLUNw/AcVA4G09yW2A
         b75A==
X-Forwarded-Encrypted: i=1; AJvYcCUjudRXTiGuEwAve9myPgND+WsDHgXHPnpQSjl0jOwmZRLaO6f43o5GZHz1MzNZ1/QBi2rVXOB6lnRotM27nu5/@vger.kernel.org, AJvYcCVStAEekYawjyo5tGTQHTLjA1UmflSXTajw9f9mrUvrNN6Er9IqeOZgWqRVZWV1wigEE5TJjIWRnaU9MFE3@vger.kernel.org, AJvYcCX1OQJ/QvOakEmVoNVw0qQBCaolT9CRHpzQ9R2hw1ahh06wIHXwFBgva0xgUqlishd+5FC8Nv07mHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJokAj1ZNs16Eth5BqRwbgpIR6m+q2Dzwjs9b53y5QkWaqyDym
	vx52DOw/HCsh5L5N/07WUOavD9ihw+PW64QukZpm/WmAE6GbDG6s+va4JSJGN5ZBwY3bLJ5eTf1
	5XQT8/Mv6Hm5TEHxzBM7HmaEXjeY=
X-Gm-Gg: ASbGncspQ73BnnuIGlzDXRjZUTNu5gpMvNind5AanlzVTBMnFtaDInomaougt5fxJiv
	RhRMtA4z8hR7fGUv4gke4z6Vmhia3oFUwNeG8sYN9+lY93XvxPMsDDXXLGyJENsWMDKH2VRWRF8
	+Bsh06kIEnUXXSXTnsIUuL3IK7eLvV54d/eHJr7fOnfRBvThmJs06ontu5/bdQ
X-Google-Smtp-Source: AGHT+IHx1kUvjF00AHJ9J3L5ITEytbdRfQvXtFGFxoLSrqiRjEGD72zbGCOCsERKFlZxWvUyGiVWpVwdMG0d68/WjgE=
X-Received: by 2002:a05:651c:1502:b0:30b:d187:622b with SMTP id
 38308e7fff4ca-30bf452957cmr18814461fa.18.1741364900897; Fri, 07 Mar 2025
 08:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
 <20250221-printf-kunit-convert-v5-1-5db840301730@gmail.com>
 <Z8mUH0comOCpycpK@pathway.suse.cz> <CAJ-ks9nFSzRXFauavzSWhvhr2Rou7qqkWi_LZ=4e1Tyr4_bn3g@mail.gmail.com>
 <Z8sYOm4qovtdOSI7@pathway.suse.cz>
In-Reply-To: <Z8sYOm4qovtdOSI7@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 11:27:44 -0500
X-Gm-Features: AQ5f1JqgJJnekMi4RiL3kK2pqFYWGaUWb_12GtlPRw-AyLWVF2WVbXCe9PmZGXQ
Message-ID: <CAJ-ks9k5wLpeg7JFL-T6SYN62y7FWeQDbS9Q34TC-zY-dyM3HQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] printf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 11:01=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2025-03-06 09:25:43, Tamir Duberstein wrote:
> > On Thu, Mar 6, 2025 at 7:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > >
> > > On Fri 2025-02-21 15:34:30, Tamir Duberstein wrote:
> > > > Convert the printf() self-test to a KUnit test.
> > > >
> > > > In the interest of keeping the patch reasonably-sized this doesn't
> > > > refactor the tests into proper parameterized tests - it's all one b=
ig
> > > > test case.
> > > >
> > > > --- a/lib/test_printf.c
> > > > +++ b/lib/tests/printf_kunit.c
> > > > @@ -57,52 +58,50 @@ do_test(int bufsize, const char *expect, int el=
en,
> > > >       va_end(aq);
> > > >
> > > >       if (ret !=3D elen) {
> > > > -             pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d,=
 expected %d\n",
> > > > +             tc_fail("vsnprintf(buf, %d, \"%s\", ...) returned %d,=
 expected %d",
> > >
> > > 1. It looks a bit strange that the 1st patch replaces pr_warn() with
> > >    tc_fail() which hides KUNIT_FAIL().
> > >
> > >    And the 2nd patch replaces tc_fail() with KUNIT_FAIL().
> > >
> > >    It looks like a non-necessary churn.
> > >
> > >    It would be better to avoid the temporary "tc_fail" and swith to
> > >    KUNIT_FAIL() already in this patch.
> > >
> > >    I did not find any comment about this in the earier versions of th=
e
> > >    patchset.
> > >
> > >    Is it just a result of the evolution of the patchset or
> > >    is there any motivation for this?
> >
> > The motivation was to keep the width of the macro the same in this
> > first patch for ease of review, particularly in the 7 instances where
> > the invocation wraps to a second line. If you prefer I go straight to
> > KUNIT_FAIL, I can make that change.
>
> I see. It might have been useful when the patch removed the trailing '\n'=
.
> But you are going to add it back. So there won't be any hidden change.
> So I would prefer to go straight to KUNIT_FAIL().

=F0=9F=91=8D I've restored all the newlines and added a few previously miss=
ing ones.

> > > > @@ -842,13 +836,15 @@ test_pointer(void)
> > > >       fourcc_pointer();
> > > >  }
> > > >
> > > > -static void __init selftest(void)
> > > > +static void printf_test(struct kunit *test)
> > > >  {
> > > >       alloced_buffer =3D kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL)=
;
> > > >       if (!alloced_buffer)
> > > >               return;
> > >
> > > I would use here:
> > >
> > >         KUNIT_ASSERT_NOT_NULL(test, alloced_buffer);
> > >
> > > And move the same change for the other kmalloc() location from
> > > the 2nd patch.
> >
> > I didn't do that here because I was trying to keep this patch as small
> > as possible, and I wrote that in the commit message.
> >
> > As for using KUNIT_ASSERT_NOT_NULL here, that would have to change
> > back to an error return in the 2nd patch because this code moves into
> > `suite_init`, which is called with `struct kunit_suite` rather than
> > `struct kunit_test`, and KUnit assertion macros do not work with the
> > former (and for good reason, because failures in suite setup cannot be
> > attributed to a particular test case).
>
> I see. KUNIT_ASSERT_NOT_NULL() can't be used in the .suite_exit() callbac=
k.
>
> > So I'd prefer to leave this as is.
>
> I agree to leave this as is.

=F0=9F=91=8D

