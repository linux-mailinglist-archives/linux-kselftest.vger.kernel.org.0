Return-Path: <linux-kselftest+bounces-34104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D01AC99EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9271BA5413
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55AF236435;
	Sat, 31 May 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaCzPK7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA022D9F4
	for <linux-kselftest@vger.kernel.org>; Sat, 31 May 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748677986; cv=none; b=TzzXNE3/+4UoQXdceEdCL5BQ7KWMA0d63+mNk1jnYERRL5vfLPK3K4pbEwXjQBEuM5ch9m6yXzWV2xvkCqL2HLa4B+iknbQ5qrLge9adho7VjvfgmxSBsq2KOxeMtoBzci4p/1oaXT5VkZEKJ7H/BBfCaujGs5lUvBzF86uMPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748677986; c=relaxed/simple;
	bh=gi33k+BwXBcmYBnpVFvtvjKKqtQOvvRzm/GhWc+31uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRKs5WEHKYJS6mzvwL5twMXLmNZbXXJEt+q+BWO+2fudG+ScLYLwOuvuebRPls2EdMMhP/A0ZUM1P60zMbEYhanrbvRu5DnPF7OEBCnF+SdrI6LSImWB2eEbgRvQERfk/1w2yw6ADf+WyKAJlkRlZf4fwI95P7AHBR/qfvqCkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaCzPK7E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748677983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ohg5fHfGT0uyzMgKziJAeADzuAKD9RxJfWVtgxptZlg=;
	b=LaCzPK7EXSESs7qF/PxlGwtJ1DP4qZOlbTzKmglU/uZ3jAoUb8zZ36P3u1QAM3xIBgH9qy
	eTqZHYC0EP9+3W8OxtZrDSaOYSQgIV2QfflOV0lsatZpaRJHEDlRpT6VtAuFaFp6CbF5aM
	9QNUcSmlu0eek1DcgPWZzGU1cuKe8dY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-VjzYFcdZNq6rqbGJa-2rcA-1; Sat, 31 May 2025 03:53:01 -0400
X-MC-Unique: VjzYFcdZNq6rqbGJa-2rcA-1
X-Mimecast-MFC-AGG-ID: VjzYFcdZNq6rqbGJa-2rcA_1748677981
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c38df7ed2so1954781a12.3
        for <linux-kselftest@vger.kernel.org>; Sat, 31 May 2025 00:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748677980; x=1749282780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ohg5fHfGT0uyzMgKziJAeADzuAKD9RxJfWVtgxptZlg=;
        b=HVnyDB25b2IQCduoC3MIgyAWZTC4qMIxBdTNKXgsr2liIIhoDgGPZ/LM3LBUbnAR7n
         nsXIjBhNN4yQvCy/oV2yAspr9CUHCIpIJSEQXh3iV6OcCxZIKT4ymSoli950s0RM/GdC
         xowRQL2kL1wW44BjhVkXFcgem2dOlJYnQYgJS7/wHjcUtFB83A3U1zd2mjOEZhIFCL+0
         wFQRPYY+dy5aScv0FaqjhYyc/jFCpejr+PBlPedQZeezq3tw74t7Q/CptE05qIPecoB5
         MGLAxLroRt2TQ6m2saZ2xQiK3SqtjzKM1y5bFXPNKRWmrBGZyuJuy8SwY/yz6kmYTkmj
         gDfQ==
X-Gm-Message-State: AOJu0Yx380SlWy+YxWkK+3fVP+C1ZDHfBQDVrgMtJnvvS8Lf6bFEbgB5
	3639kvLfKhVpsJLwGQudNMC1Ag0QmCmK2QbHPO76irjbV+G++qojQ0EECRSesD5hOFXoay1oAk9
	sSqqc8KWggRKt1cOMhWQoyH2Hq9LIYYiFJp8XzjJovqJCCBD2Mfdpp9cDkwGEZYpHynd7OVHg6O
	q4Or0STSQ+7/w8HobNxD+CZL4K3KZcdwE/rJai0KDacVn5WGvoNRLUDJU=
X-Gm-Gg: ASbGncv2JRqur3CcvfLiOx7PGWhr/TFvrbDGSvJNs8qdNLVCWZegGqeb6ajdvV9uaZn
	71CuuGCMcVgojAKnLGlt6njEL6+G3GS4nRoXp79HW1QeIfYCR8kdk2vSi0tEqI8zPoHQ=
X-Received: by 2002:a17:90b:1646:b0:312:959:dc49 with SMTP id 98e67ed59e1d1-3127c6c6ac5mr1874356a91.13.1748677979875;
        Sat, 31 May 2025 00:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwPb15HB+x5LlixDkbF7gwe9jHKDNEMcaqP3sUfYw07TfO/w5/C6AzdnYsr2gdlgDJLMrrXiAq57x6HSqDjjw=
X-Received: by 2002:a17:90b:1646:b0:312:959:dc49 with SMTP id
 98e67ed59e1d1-3127c6c6ac5mr1874323a91.13.1748677979477; Sat, 31 May 2025
 00:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526132755.166150-1-acarmina@redhat.com> <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net> <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
In-Reply-To: <20250530140140.GE21197@noisy.programming.kicks-ass.net>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Sat, 31 May 2025 09:52:47 +0200
X-Gm-Features: AX0GCFvDRExJEUZAsyc3Pz18fgK0YsOWafT6qSf9X6kJzNpcf_7G6rLG7qkegQQ
Message-ID: <CAGegRW5phz1L7WF478jssaxhv4XDrH1H6wYer_MhU_h8gWQdfg@mail.gmail.com>
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
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Peter,
thanks for the clear explanation.
I finally understand what was bothering you, it wasn=E2=80=99t the __bug_ta=
ble
size or the execution time overhead, but the code size itself.

On Fri, May 30, 2025 at 4:02=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> +Mark because he loves a hack :-)
>
> On Thu, May 29, 2025 at 12:36:55PM +0200, Alessandro Carminati wrote:
>
> > > Like I said before; you need to do this on the report_bug() size of
> > > things.
> > >
> > I fully understand your concerns, and I truly appreciate both yours
> > and Josh=E2=80=99s feedback on this matter.
> > Please rest assured that I took your suggestions seriously and
> > carefully evaluated the possibility of consolidating all related logic
> > within the exception handler.
> > After a thorough investigation, however, I encountered several
> > limitations that led me to maintain the check in the macro.
> > I=E2=80=99d like to share the rationale behind this decision:
>
> > * In the case of WARN() messages, part of the output, the
> > user-specified content, is emitted directly by the macro, prior to
> > reaching the exception handler [1].
> >   Moving the check solely to the exception handler would not prevent
> > this early output.
>
> Yeah, this has been really annoying me for a long while. WARN() code gen
> is often horrible crap because of that.
>
> Everything I've tried so far is worse though :/ So in the end I try to
> never use WARN(), its just not worth it.
>
> ... /me goes down the rabbit-hole again, because well, you can't let
> something simple like this defeat you ;-)
>
> Results of today's hackery below. It might actually be worth cleaning
> up.
>
> > * Unless we change the user-facing interface that allows suppression
> > based on function names, we still need to work with those names at
> > runtime.
>
> I'm not sure I understand this. What interface and what names? This is a
> new feature, so how can there be an interface that needs to be
> preserved?
>
> > * This leaves us with two main strategies: converting function names
> > to pointers (e.g., via kallsyms) or continuing to work with names.
> >   The former requires name resolution at suppression time and pointer
> > comparison in the handler, but function names are often altered by the
> > compiler due to inlining or other optimizations[2].
> >   Some WARN() sites are even marked __always_inline[3], making it
> > difficult to prevent inlining altogether.
>
> Arguably __func__ should be the function name of the function you get
> inlined into. C inlining does not preserve the sequence point, so there
> is absolutely no point in trying to preserve the inline name.
>
> I'm again confused though; [2] does not use __func__ at all.
>
> Anyway, when I do something like:
>
> void __attribute__((__always_inline__)) foo(void)
> {
>         puts(__func__);
> }
>
> void bar(void)
> {
>         foo();
> }
>
> it uses a "foo" string, which IMO is just plain wrong. Anyway, do both
> compilers guarantee it will always be foo? I don't think I've seen the
> GCC manual be explicit about this case.
On this point:
even if not explicitly stated, __func__ will always be "foo" in your exampl=
e.
I=E2=80=99m confident in this because, according to the GCC manual[1],
__func__ is inserted into the source as:
static const char __func__[] =3D "function-name";
At that point, the compiler doesn't yet know what the final code will
look like or whether it will be inlined.
I=E2=80=99m not a compiler expert, but this definition doesn=E2=80=99t leav=
e much room
for alternative interpretations.

>
> > * An alternative is to embed function names in the __bug_table.
> >   While potentially workable, this increases the size of the table and
> > requires attention to handle position-independent builds
> > (-fPIC/-fPIE), such as using offsets relative to __start_rodata.
> >
> > However, the central challenge remains: any logic that aims to
> > suppress WARN() output must either move the entire message emission
> > into the exception handler or accept that user-specified parts of the
> > message will still be printed.
>
> Well, we can set suppress_printk and then all is quiet :-) Why isn't
> this good enough?
>
> > As a secondary point, there are also less common architectures where
> > it's unclear whether suppressing these warnings is a priority, which
> > might influence how broadly the effort is applied.
> > I hoped to have addressed the concern of having faster runtime, by
> > exposing a counter that could skip the logic.
> > Kess suggested using static branching that would make things even bette=
r.
> > Could Kess' suggestion mitigate your concern on this strategy?
> > I=E2=80=99m absolutely open to any further thoughts or suggestions you =
may
> > have, and I appreciate your continued guidance.
>
> I'm not really concerned with performance here, but more with the size
> of the code emitted by WARN_ONCE(). There are a *ton* of WARN sites,
> while only one report_bug() and printk().
>
> The really offensive thing is that this is for a feature most nobody
> will ever need :/
>
>
>
> The below results in:
>
> 03dc  7ac:      48 c7 c0 00 00 00 00    mov    $0x0,%rax        7af: R_X8=
6_64_32S       .rodata.str1.1+0x223
> 03e3  7b3:      ba 2a 00 00 00          mov    $0x2a,%edx
> 03e8  7b8:      48 0f b9 d0             ud1    %rax,%rdx
>
> And it even works :-)
>
> Hmm... I should try and stick the format string into the __bug_table,
> its const after all. Then I can get 2 arguments covered.
>
> ---
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index f0e9acf72547..88b305d49f35 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
The rework is impressive.
I=E2=80=99m not in a position to judge, but for what it=E2=80=99s worth, yo=
u have my admiration.

That said, I see a problem, the same I faced when embedding __func__
in the bug table.
__func__, and I believe also printk fmt, are constants, but their
pointers might not be, especially in position-independent code.
This causes issues depending on the compiler.
For example, my tests worked fine with recent GCC on x86_64, but
failed with Clang.
Changing architecture complicates things further, GCC added support
for this only in newer versions.
I ran into this in v3 when the s390x build failed[2].

As mentioned in the patchset cover letter, my solution to avoid
copying the strings into the bug table is to store their pointer as an
offset from __start_rodata.
[1]. https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html
[2]. https://lore.kernel.org/all/202503200847.LbkIJIXa-lkp@intel.com/


