Return-Path: <linux-kselftest+bounces-24687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42391A14568
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 00:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67663AAC9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455EC2442F9;
	Thu, 16 Jan 2025 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ/BfoFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D72442E8;
	Thu, 16 Jan 2025 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069562; cv=none; b=mXfLV6/K1t4P5B7at4zd/jnyS4EXsF/r7lCX6cBu0vCclfLgBmR6o8zfvmqRAQpnLCXS7oGA8W1xFlOkQ7ti6mccbGswCwZy6mZNRTbUmKgvqWFvDy8EhPGG7sn/gKebk7rmV3CnP6KVW2JYxAO0ojANCSb7SZhYDEcXo8+heS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069562; c=relaxed/simple;
	bh=xMAqRHryI/rwucVGtdZ17LFpwg086brv2Et5qs6FV10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj8k2J6gf2crl/7W+sANEsiAB7orJmAm5lo7q5difPqmgokY+781XLnKNpQNL2TawvLYxOG4/GRBVM2wM/NOHA88M43tG65jMGeaqIil2S3Mt0sJwDYsTi5L99zkru9oMtgUazTXhPaIK1wSC3dPPeKocMJ2DxCfBalKWeHPKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ/BfoFD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso2177979a91.1;
        Thu, 16 Jan 2025 15:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737069559; x=1737674359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHGQnPZwnnrXcQFPANQYOEEHzigbTEMvtEMeH0+F998=;
        b=XQ/BfoFDk2NIn+llxIo+VeU6v0ma0U9PtSigi492bac99YlbGs8IjxgnAcBfR9/DIJ
         cvtqyrQ7hp5Z1DtJV9cIIk6YxM3vu0Td17M7Xr2p1Jv8j9BsDnp3dAPv8EiFtnd5HwMC
         kufl3F8nHEXgaVoHS7cSWJiWD+HWkdDFjuF237+h0xYpof1FkXk3DBzbBlVEY8KRaSMM
         LNIBxp5i0jBLy6chWPdezdu7Yg9fHgna23Bl2KBwJnTKfzRgMOdjCiEjnL2XqYQ1IanW
         gV3B7LoHcfD+SYSEm++4iH33BUzqDCBZY5GsFIRCyYZ8g3fsJGgS1EsxSRNsKW4nwUti
         dpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069559; x=1737674359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHGQnPZwnnrXcQFPANQYOEEHzigbTEMvtEMeH0+F998=;
        b=RJXJXMS/2Q+PkayQ+L24gpMkoC0CMxHUioMSC/rAXVxOEBgOoW0teo/ppqvLpONDbD
         QoPJXIMyJ4ob3FHsRIlIpgsnR19tFuNpnla+gSmZ3YfCRWlhkQfJNlBnBjQAPpNixUHz
         qWldGyfiE355256480nPwHWIFn2S00Oeb6W7NqeHkjWFCHixSg1KkjpW+fqmquIt0HgC
         +dTXn/W4cNKQJIn1KZC4Tl3IapK7Zt1svMrSfkLwOOd13Or0SxjVS+Wls5e7jTdzILac
         HAml/vngu846xuUlhn3xSqH7iMf/1L7exYz9RPcL77DR4jBsxNXDxKQwW3aX+J8sBphz
         NbOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8Ig5c7UQzgW8mCu9JT5jEeb1jkZLyg1lFYhXhYov4AUbEkxJBacxHEvQLSPV/9m9t2BoBB+tnZ9Z6vhG/JLE@vger.kernel.org, AJvYcCVmV1MQL47y2PJsJm/joSOT2doc2TBEzBoi4eEoVbB735n8OeJjku6mLef4TlFME5nRB+2Qb5Pyl80uXh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9U5ClYflPgoraKVM5fF1ovuXJL/wCbt0gmM//12jKJQFCVE5
	Vt0YymcSka4MJbw0hCvPdT7yIkphTFDF4PT8yHd2l+LKMjoGOcwXjYAobOceVtCoVGLOI1MlbIr
	z1/EepGDjbFPJ8CS2NFHkliOwOzk=
X-Gm-Gg: ASbGncuJydVhwWHQZAP1LqUD7/mJeVRYH5aN7qagXBbtz1Jxcp7Uwm+ycV382XyQIt/
	LODleNp2s/mnidKvJDVvdzuJKTsYBDz2Q522s
X-Google-Smtp-Source: AGHT+IGdB59zqZcx9zNHpctB8/u29yWsIw4wdxVo0VhEeDLjYx9weQ1IRHWB3Z+xwYjbx7rQHhPCDirbip6eEFkmdlk=
X-Received: by 2002:a17:90b:2751:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-2f782d9a1d5mr547669a91.31.1737069559453; Thu, 16 Jan 2025
 15:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104050007.13812-1-skb99@linux.ibm.com> <20241104050007.13812-3-skb99@linux.ibm.com>
 <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
 <Zz33lM0rTJBZpaJR@linux.ibm.com> <CAEf4Bzbek6CYbx5Atz_xwwx5J3gC1ELdVmW-kFrrR=CWNLMyBA@mail.gmail.com>
 <Z4D7Qx6pQEZ/bHDa@linux.ibm.com> <CAEf4BzaEwvP-eVd=AWzvXPCfVCa5m0BKCe6q9tE5fT7VCAVDmA@mail.gmail.com>
 <Z4LMPn4u+l1qIi9T@linux.ibm.com> <CAEf4BzZbfc2o0hVnXVQ1vegMGhM8h76F2aGVske3wd8hFQeM+g@mail.gmail.com>
 <Z4fDBSvtJ+jgm05+@linux.ibm.com>
In-Reply-To: <Z4fDBSvtJ+jgm05+@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 15:19:07 -0800
X-Gm-Features: AbW1kvYFrD4g7WVNyHpQiXv1zNzkyE3H-9-MvMjUgn4VSXhcSZTnrTWqKa3QCb0
Message-ID: <CAEf4BzY9TQBb8Y0PqRB1SeC742qw_vYX2KVgg4bH5dsaQrfQJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libbpf: Remove powerpc prefix from syscall function names
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com, 
	andrii@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 6:16=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Tue, Jan 14, 2025 at 02:40:20PM -0800, Andrii Nakryiko wrote:
> > On Sat, Jan 11, 2025 at 11:53=E2=80=AFAM Saket Kumar Bhaskar
> > <skb99@linux.ibm.com> wrote:
> > >
> > > CCing Maddy and MPE
> > > On Fri, Jan 10, 2025 at 02:29:42PM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Jan 10, 2025 at 2:49=E2=80=AFAM Saket Kumar Bhaskar <skb99@=
linux.ibm.com> wrote:
> > > > >
> > > > > On Thu, Nov 21, 2024 at 04:00:13PM -0800, Andrii Nakryiko wrote:
> > > > > > On Wed, Nov 20, 2024 at 6:52=E2=80=AFAM Saket Kumar Bhaskar <sk=
b99@linux.ibm.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wro=
te:
> > > > > > > > On Sun, Nov 3, 2024 at 9:00=E2=80=AFPM Saket Kumar Bhaskar =
<skb99@linux.ibm.com> wrote:
> > > > > > > > >
> > > > > > > > > Since commit 94746890202cf ("powerpc: Don't add __powerpc=
_ prefix to
> > > > > > > > > syscall entry points") drops _powerpc prefix to syscall e=
ntry points,
> > > > > > > > > even though powerpc now supports syscall wrapper, so /pro=
c/kallsyms
> > > > > > > > > have symbols for syscall entry without powerpc prefix(sys=
_*).
> > > > > > > > >
> > > > > > > > > For this reason, arch specific prefix for syscall functio=
ns in powerpc
> > > > > > > > > is dropped.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > > > > > > ---
> > > > > > > > >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> > > > > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbp=
f.c
> > > > > > > > > index 219facd0e66e..3a370fa37d8a 100644
> > > > > > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > > > > > @@ -11110,9 +11110,7 @@ static const char *arch_specific_=
syscall_pfx(void)
> > > > > > > > >  #elif defined(__riscv)
> > > > > > > > >         return "riscv";
> > > > > > > > >  #elif defined(__powerpc__)
> > > > > > > > > -       return "powerpc";
> > > > > > > > > -#elif defined(__powerpc64__)
> > > > > > > > > -       return "powerpc64";
> > > > > > > > > +       return "";
> > > > > > > > >  #else
> > > > > > > > >         return NULL;
> > > > > > > > >  #endif
> > > > > > > > > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(i=
nt token_fd)
> > > > > > > > >         if (!ksys_pfx)
> > > > > > > > >                 return 0;
> > > > > > > > >
> > > > > > > > > +#if defined(__powerpc__)
> > > > > > > > > +       snprintf(syscall_name, sizeof(syscall_name), "sys=
_bpf");
> > > > > > > > > +#else
> > > > > > > > >         snprintf(syscall_name, sizeof(syscall_name), "__%=
s_sys_bpf", ksys_pfx);
> > > > > > > > > +#endif
> > > > > > > >
> > > > > > > > The problem is that on older versions of kernel it will hav=
e this
> > > > > > > > prefix, while on newer ones it won't. So to not break anyth=
ing on old
> > > > > > > > kernels, we'd need to do feature detection and pick whether=
 to use
> > > > > > > > prefix or not, right?
> > > > > > > >
> > > > > > > > So it seems like this change needs a bit more work.
> > > > > > > >
> > > > > > > > pw-bot: cr
> > > > > > > >
> > > > > > > Hi Andrii,
> > > > > > >
> > > > > > > IMO since both the patches 7e92e01b7245(powerpc: Provide sysc=
all wrapper)
> > > > > > > and 94746890202cf(powerpc: Don't add __powerpc_ prefix to sys=
call entry points)
> > > > > > > went into the same kernel version v6.1-rc1, there won't me mu=
ch kernel
> > > > > > > versions that has only one of these patches.
> > > > > > >
> > > > > > > Also, to test more I tried this patch with ARCH_HAS_SYSCALL_W=
RAPPER disabled,
> > > > > > > and it the test passed in this case too.
> > > > > > >
> > > > > >
> > > > > > Keep in mind that libbpf is supposed to work across many kernel
> > > > > > versions. So as long as there are powerpc (old) kernels that do=
 use
> > > > > > arch-specific prefix, we need to detect them and supply prefix =
when
> > > > > > attaching ksyscall programs.
> > > > > >
> > > > > Hi Andrii,
> > > > >
> > > > > Sorry about the delayed response, I have started looking at this =
after
> > > > > a vacation.
> > > > >
> > > > > There are unlikely to be any old kernels that use arch-specific p=
refix
> > > > > as syscall wrapper support was added to powerpc in v6.1 and
> > > > > commit 94746890202cf that dropped the prefix also went into the s=
ame
> > > > > kernel release (v6.1-rc1). So, is it worth it support both sys_bp=
f and
> > > > > __powerpc_sys_bpf cases?
> > > > >
> > > > > But yes, there can be a kernel without syscall wrapper but having=
 the
> > > > > sys_bpf symbol. So, how about identifying syscall wrapper enablem=
ent
> > > > > with __se_sys_bpf instead:
> > > > >
> > > > >
> > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > index 66173ddb5a2d..ff69a30cfe9b 100644
> > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > @@ -11163,11 +11163,15 @@ int probe_kern_syscall_wrapper(int toke=
n_fd)
> > > > >         char syscall_name[64];
> > > > >         const char *ksys_pfx;
> > > > >
> > > > > +#if defined(__powerpc__)
> > > > > +       snprintf(syscall_name, sizeof(syscall_name), "__se_sys_bp=
f", ksys_pfx);
> > > > > +#else
> > > > >         ksys_pfx =3D arch_specific_syscall_pfx();
> > > > >         if (!ksys_pfx)
> > > > >                 return 0;
> > > > >
> > > > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bp=
f", ksys_pfx);
> > > > > +#endif
> > > > >
> > > > >         if (determine_kprobe_perf_type() >=3D 0) {
> > > > >                 int pfd;
> > > > > @@ -11176,16 +11180,28 @@ int probe_kern_syscall_wrapper(int toke=
n_fd)
> > > > >                 if (pfd >=3D 0)
> > > > >                         close(pfd);
> > > > >
> > > > > +#if defined(__powerpc__)
> > > > >                 return pfd >=3D 0 ? 1 : 0;
> > > > > +#else
> > > > > +               return pfd >=3D 0 ? 1 : 0;
> > > > > +#endif
> > > > >         } else { /* legacy mode */
> > > > >                 char probe_name[128];
> > > > >
> > > > >                 gen_kprobe_legacy_event_name(probe_name, sizeof(p=
robe_name), syscall_name, 0);
> > > > >                 if (add_kprobe_event_legacy(probe_name, false, sy=
scall_name, 0) < 0)
> > > > > +#if defined(__powerpc__)
> > > > > +                       return 1;
> > > > > +#else
> > > > >                         return 0;
> > > > > +#endif
> > > > >
> > > > >                 (void)remove_kprobe_event_legacy(probe_name, fals=
e);
> > > > > +#if defined(__powerpc__)
> > > > > +               return 0;
> > > > > +#else
> > > > >                 return 1;
> > > > > +#endif
> > > > >         }
> > > > >  }
> > > > >
> > > > > Actually, all architectures could use this '__se_' prefix instead=
 of
> > > > > arch specific prefix  to identify if syscall wrapper is enabled.
> > > > > Separate way to handle powerpc case may not be needed. Will
> > > > > wait for your inputs to send v2.
> > > >
> > > > the problem is that __se_sys_bpf is not traceable (it's a static
> > > > function), so it seems like this won't work
> > > >
> > > >
> > > > it's been a while, let me try to clarify my understanding of the
> > > > issue. The problem is that powerpc is special in that when syscall
> > > > wrapper is used, then, unlike all other architectures, they opted t=
o
> > > > not have arch-specific prefix for syscall wrappers, is that right? =
and
> > > > that's why all the dancing you are trying to add. Am I right?
> > > >
> > > Yes, you got it right. For more details, you can refer to the
> > > reasoning behind the change here:
> > > https://github.com/torvalds/linux/commit/94746890202cf
> >
> > That was an unfortunate decision to deviate :(
> >
> > Alright, so where are we? We can't do __se_<syscall> approach, but we
> > need to have some reliable way to determine whether powerpc uses
> > syscall wrapper. Can you please summarize available options for
> > powerpc? Sorry, it's been a while, so we need to re-page in all the
> > context.
> >
> Hi Andrii,
>
> 1. On powerpc we are able to set kprobe on __se_sys_bpf, we are thinking =
to
>    use this to check if syscall wrapper is enabled.

I'm not trying to be difficult, but what does guarantee that this is
always the case. I'm looking at this:

static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))

in arch/powerpc/include/asm/syscall_wrapper.h

It's static, so it's up to the compiler to decide whether to inline
this function or not. Once inlined, it's effectively not there.

>
> Snippet from kernel where syscall wrapper wasn't there for powerpc:
>
> # uname -r
> 6.0.0
>
> # cat kprobe_events
> p:kprobes/p_kprobe2_user_events_osquery netlink_ack
> r64:kprobes/r_kprobe_user_events_osquery audit_receive
> p:kprobes/p_kprobe_user_events_osquery audit_receive
> p:kprobes/my_probe __se_sys_bpf
>
> # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 20/20   #P:64
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>       test_progs-1971    [034] .....   532.732614: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.732843: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733120: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733485: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733499: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733507: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733512: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733552: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733577: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733581: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733586: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733592: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733596: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733601: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733606: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733612: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733622: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733658: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.733740: my_probe: (sys_bpf+0xc=
/0x40)
>       test_progs-1971    [034] .....   532.736043: my_probe: (sys_bpf+0xc=
/0x40)
>
> 2. The other is sys_bpf, but this symbol exists in both cases(kernel wher=
e syscall
>    wrapper is enabled and where it is disabled).
>
> Kernel with syscall wrapper not introduced in powerpc:
>
> # uname -r
> 6.0.0
>
> # cat /proc/kallsyms | grep sys_bpf
> c000000000383630 t __sys_bpf
> c0000000003844a0 T bpf_sys_bpf
> c000000000384510 T kern_sys_bpf
> c000000000384840 T sys_bpf
> c000000000384840 T __se_sys_bpf
> c000000001030c80 d bpf_sys_bpf_proto
> c0000000014a8bf8 d __ksymtab_kern_sys_bpf
> c0000000014eac1f r __kstrtab_kern_sys_bpf
> c0000000014fa53b r __kstrtabns_kern_sys_bpf
> c000000002151e90 d _eil_addr_sys_bpf
>
> Kernel with syscall wrapper introduced in powerpc:
>
> # uname -r
> 6.13.0-rc6+
>
> # cat /proc/kallsyms | grep sys_bpf
> c0000000003d7750 t __sys_bpf
> c0000000003d83ac T bpf_sys_bpf
> c0000000003d8418 T kern_sys_bpf
> c0000000003d8734 T sys_bpf
> c000000001243328 d bpf_sys_bpf_proto
> c0000000017776b0 r __ksymtab_kern_sys_bpf
> c0000000021b7520 d _eil_addr_sys_bpf
>
> Thanks,
> Saket
> > >
> > > Thanks,
> > > Saket
> > > > >
> > > > > Thanks,
> > > > > Saket
> > > > > > > Thanks,
> > > > > > > Saket
> > > > > > > > >
> > > > > > > > >         if (determine_kprobe_perf_type() >=3D 0) {
> > > > > > > > >                 int pfd;
> > > > > > > > > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__at=
tach_ksyscall(const struct bpf_program *prog,
> > > > > > > > >                  * compiler does not know that we have an=
 explicit conditional
> > > > > > > > >                  * as well.
> > > > > > > > >                  */
> > > > > > > > > +#if defined(__powerpc__)
> > > > > > > > > +               snprintf(func_name, sizeof(func_name), "s=
ys_%s", syscall_name);
> > > > > > > > > +#else
> > > > > > > > >                 snprintf(func_name, sizeof(func_name), "_=
_%s_sys_%s",
> > > > > > > > >                          arch_specific_syscall_pfx() ? : =
"", syscall_name);
> > > > > > > > > +#endif
> > > > > > > > >         } else {
> > > > > > > > >                 snprintf(func_name, sizeof(func_name), "_=
_se_sys_%s", syscall_name);
> > > > > > > > >         }
> > > > > > > > > --
> > > > > > > > > 2.43.5
> > > > > > > > >

