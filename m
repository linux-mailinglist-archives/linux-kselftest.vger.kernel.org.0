Return-Path: <linux-kselftest+bounces-33990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F197AC7BD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A34A1BC5AB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970526B2D7;
	Thu, 29 May 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY1SofqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AF1F1527
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515032; cv=none; b=PwUCdzM+iO1/Al7dTR6MWGA+jjJVxFOYm1mo/c6hNWa0x6jIf9I1m8UT3tIHHLk153Ki8E1PjscORcaFAlPkrjnwaLzRRRmbZY6vj6K4FbHF3QGUQaWBGL4IqfGDagTnA2nyCBRcU+zoqx1CUrkVN2NfwDZM+McCi99w51cvYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515032; c=relaxed/simple;
	bh=3/NuUSudHB5xIKW0/TkamDScusaOGwg20pQxOpKtO3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omPlyfjUUNFeoJM1HiC9jZ69AfayqhPt0MTNnRup2IHpArVMVVrECny56uvLsuHyhUOGnmZLPbqNa/7WSQfOHqy1TjbswVe9oNrnrNEJaT5MgP4hmFBakl1p6/Yxqn08Wi0emrz2RmlmfkYkzLfswo6jBCDN1s1PDn2EzKRlkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY1SofqQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748515029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fz8QX1fdjUroMsYLnfzdC7Cz8h3WJ8EnVkCetCUVw1g=;
	b=LY1SofqQ+GK3H7F9NEelJ/AhyuoMe3dpw1ZzTYCnxIXrbTbPdWQ+JDlIHo8Hvf471FzGlq
	VDvTESye1Wxu/zQPMBF526Bh0twLOONTraA9lC7oo8MBofUkcjrBsLcaC7Sf/dFOWGHk4F
	U46gP3rlb/HdHc41GF8B5RDQNoSZs8c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-tjvceFEiOkmV93qGi5jgHQ-1; Thu, 29 May 2025 06:37:08 -0400
X-MC-Unique: tjvceFEiOkmV93qGi5jgHQ-1
X-Mimecast-MFC-AGG-ID: tjvceFEiOkmV93qGi5jgHQ_1748515027
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3113a29e1fdso1067821a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 03:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748515027; x=1749119827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz8QX1fdjUroMsYLnfzdC7Cz8h3WJ8EnVkCetCUVw1g=;
        b=gm89GaG1/zLTzSIieb1T0va2Qy6KCP1kyXj/bcJPPNNacxJX9XxtazP/BQmNMxffS6
         YfwxkcLfy9vGeFGHnDpIRJkqKN01efELURUMX3lx/n/umEDWBHfypfe0OOlweRoiX0Vs
         4IfXsHuxzox1QstKoJWanjtCRExfiq7BpFvGyGZfw+8vx1/kRT3p+5sbOGbvp7kxFriu
         xkGfZuLhxMRJ8PXWjqQEpDLQ8/27MF3z8+LyZr+Hruqx9+psLlcEzt1pMTSVRCrqilD4
         fgUbq+Cd9d4gLOkEOJoUhnGcSLZ+2fRR48JWCom/vNf9qXNaXbsydEc7PCO+D5YwpHn8
         6V+g==
X-Gm-Message-State: AOJu0YzO8xLJPsjY6JQEKZU0dLGnPiqszGCiiYxbM3zHE8qM2vcM68Fd
	6i5wd6y2P0mH/Ot4b8ksdFTT7btPJiajdGE/f5MW5m0TF4KKVOK6lJZ9zwnwoVKXUk7UCXC8Nix
	Mkks+TJxTgKCVsdedVzIG48A2QF5LeTIx2eSQ33tLPXzLhInSO3qSpzEwTh370dNq5lzu3OD1bW
	IcGOONipz53oQ8uJevk8sYydYJIC04i4aBVE4exKoan6Qu
X-Gm-Gg: ASbGnctLFrTS6twDXbDfLigc7BduS2smUvjgkEGqK0lxa4ExhRf3QMCa9RNPd51/HHD
	/Gyyv2Sn0sYWD07BQKFxmytQpNZd5uBfvhb5MNiNXjp/CuyRu/hIet2/wPxxcqCYGm+s=
X-Received: by 2002:a17:90b:4b51:b0:311:c1ec:7d11 with SMTP id 98e67ed59e1d1-311c1ec7fc4mr15065773a91.18.1748515027150;
        Thu, 29 May 2025 03:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAox7IsAtssu07irh1QLheVHkNdP7Y9lbZWa2nMvcyl1pY0Ab2r7QPJxl0/LISCRlZ0lWUbDAn2F6LjXBI53k=
X-Received: by 2002:a17:90b:4b51:b0:311:c1ec:7d11 with SMTP id
 98e67ed59e1d1-311c1ec7fc4mr15065721a91.18.1748515026685; Thu, 29 May 2025
 03:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526132755.166150-1-acarmina@redhat.com> <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
In-Reply-To: <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Thu, 29 May 2025 12:36:55 +0200
X-Gm-Features: AX0GCFtpfP4yBdraQIoFZcf2VnrqkTd0yjo326QS2M0ocr49FrM6353kuQ9j38Y
Message-ID: <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kselftest@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Ville Syrjala <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Guenter Roeck <linux@roeck-us.net>, Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Jani Nikula <jani.nikula@intel.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you for your follow-up and for reiterating your point.

On Thu, May 29, 2025 at 11:01=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Mon, May 26, 2025 at 01:27:51PM +0000, Alessandro Carminati wrote:
>
> >  #define __WARN()             __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
> >  #define __WARN_printf(taint, arg...) do {                            \
> > -             instrumentation_begin();                                \
> > -             __warn_printk(arg);                                     \
> > -             __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));=
\
> > -             instrumentation_end();                                  \
> > +             if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {           \
> > +                     instrumentation_begin();                        \
> > +                     __warn_printk(arg);                             \
> > +                     __WARN_FLAGS(BUGFLAG_NO_CUT_HERE |              \
> > +                             BUGFLAG_TAINT(taint));                  \
> > +                     instrumentation_end();                          \
> > +             }                                                       \
> >       } while (0)
> >  #define WARN_ON_ONCE(condition) ({                           \
> >       int __ret_warn_on =3D !!(condition);                      \
> > -     if (unlikely(__ret_warn_on))                            \
> > +     if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__fun=
c__))  \
> >               __WARN_FLAGS(BUGFLAG_ONCE |                     \
> >                            BUGFLAG_TAINT(TAINT_WARN));        \
> >       unlikely(__ret_warn_on);                                \
> > @@ -121,7 +130,7 @@ extern __printf(1, 2) void __warn_printk(const char=
 *fmt, ...);
> >  #ifndef WARN_ON
> >  #define WARN_ON(condition) ({                                         =
       \
> >       int __ret_warn_on =3D !!(condition);                             =
 \
> > -     if (unlikely(__ret_warn_on))                                    \
> > +     if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__fun=
c__))  \
> >               __WARN();                                               \
> >       unlikely(__ret_warn_on);                                        \
> >  })
> > @@ -138,7 +147,7 @@ extern __printf(1, 2) void __warn_printk(const char=
 *fmt, ...);
> >
> >  #define WARN_TAINT(condition, taint, format...) ({                   \
> >       int __ret_warn_on =3D !!(condition);                             =
 \
> > -     if (unlikely(__ret_warn_on))                                    \
> > +     if (unlikely(__ret_warn_on) && !KUNIT_IS_SUPPRESSED_WARNING(__fun=
c__))  \
> >               __WARN_printf(taint, format);                           \
> >       unlikely(__ret_warn_on);                                        \
> >  })
> > @@ -157,8 +166,10 @@ extern __printf(1, 2) void __warn_printk(const cha=
r *fmt, ...);
> >  #else /* !CONFIG_BUG */
> >  #ifndef HAVE_ARCH_BUG
> >  #define BUG() do {           \
> > -     do {} while (1);        \
> > -     unreachable();          \
> > +     if (!KUNIT_IS_SUPPRESSED_WARNING(__func__)) {                   \
> > +             do {} while (1);                                        \
> > +             unreachable();                                          \
> > +     }                                                               \
> >  } while (0)
> >  #endif
>
> NAK
>
> This is again doing it wrong -- this will bloat every frigging bug/warn
> site for no reason.
>
> Like I said before; you need to do this on the report_bug() size of
> things.
>
I fully understand your concerns, and I truly appreciate both yours
and Josh=E2=80=99s feedback on this matter.
Please rest assured that I took your suggestions seriously and
carefully evaluated the possibility of consolidating all related logic
within the exception handler.
After a thorough investigation, however, I encountered several
limitations that led me to maintain the check in the macro.
I=E2=80=99d like to share the rationale behind this decision:
* In the case of WARN() messages, part of the output, the
user-specified content, is emitted directly by the macro, prior to
reaching the exception handler [1].
  Moving the check solely to the exception handler would not prevent
this early output.
* Unless we change the user-facing interface that allows suppression
based on function names, we still need to work with those names at
runtime.
* This leaves us with two main strategies: converting function names
to pointers (e.g., via kallsyms) or continuing to work with names.
  The former requires name resolution at suppression time and pointer
comparison in the handler, but function names are often altered by the
compiler due to inlining or other optimizations[2].
  Some WARN() sites are even marked __always_inline[3], making it
difficult to prevent inlining altogether.
* An alternative is to embed function names in the __bug_table.
  While potentially workable, this increases the size of the table and
requires attention to handle position-independent builds
(-fPIC/-fPIE), such as using offsets relative to __start_rodata.

However, the central challenge remains: any logic that aims to
suppress WARN() output must either move the entire message emission
into the exception handler or accept that user-specified parts of the
message will still be printed.
As a secondary point, there are also less common architectures where
it's unclear whether suppressing these warnings is a priority, which
might influence how broadly the effort is applied.
I hoped to have addressed the concern of having faster runtime, by
exposing a counter that could skip the logic.
Kess suggested using static branching that would make things even better.
Could Kess' suggestion mitigate your concern on this strategy?
I=E2=80=99m absolutely open to any further thoughts or suggestions you may
have, and I appreciate your continued guidance.

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/asm-generic/bug.h#n106
[2]. https://godbolt.org/z/d8aja1Wfz Compiler here emits inlined
function and stand alone function to allow pointer usage.
[3]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/linux/file_ref.h#n118
this is one example, others exist.
--=20
---
Thanks
Alessandro


