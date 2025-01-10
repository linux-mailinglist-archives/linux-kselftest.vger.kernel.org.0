Return-Path: <linux-kselftest+bounces-24271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9073EA09E0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7EF169E87
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC6219A9A;
	Fri, 10 Jan 2025 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm4f57Rr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE5207DE7;
	Fri, 10 Jan 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548196; cv=none; b=DiwiS2+D09FG9UdSiSmurkSIY8i2JImQS1pQubcPCBldFRu+xq+rln1QVB/0Oqk0rd5V2DxHAYaMKmGunPEGbwvETDs6gT9D2xmt7MNdIN0e1pGojRbyNt3s3KvfkwyjJP3rRqDf7GDdt4WK98KSA8KvL/aF1b6dJR56ZaZGXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548196; c=relaxed/simple;
	bh=D7PDCBALGMgsrGA4Ju9xLwFsjblcirChRU9/7qE762Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJeerGosq8N04gifHXwFx2tpGEGUfoHCAwkb0RlPh5hpUpjWQvlWZO+3CFxc72tJLIcLGgOguSKL3Ck0u94OX2rQGgu5/iWEJho62Zn7GXYOkknQnzpzqM9AnUIfQ4EoAmoTBxqfoeZZmM3rUX5+n/oj98akg/R7T6UGjLktgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm4f57Rr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso3500074a91.3;
        Fri, 10 Jan 2025 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736548194; x=1737152994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaMldOfoJMytMtII3O6hfgmNyW73elsB8dhBg1r1x50=;
        b=Jm4f57Rr3l2fuXvBXZuoCppX2qK36YYPhsLKEa2XTvc/grzOMWrgvlNqAq0ghD9pBN
         VJts1wP6eWax/fReANfIw4Wwfnt8Oht9npLUfF4VS8iSkZiSCSAnqq5HU4Iyn8HgLqov
         bFbh1/CUt6Oxaq9Djl+ktdD8zAf6HD8n1luDExL+gfBSk8vwr1YceOVVYC8zX0ch3pOT
         pAnDOFjTdG+V3JzdZBRWU4zNyUBdQe3cR3vaa8jvyz4N26oeXoZEtiAmYVlnGruv8vOG
         jvWnpbZcqEqiagtaXtWk+upx4eAq+B1woUnzFolwHVE8s2t0odfBB3GodFpr0Qn0mcJA
         Y7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548194; x=1737152994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaMldOfoJMytMtII3O6hfgmNyW73elsB8dhBg1r1x50=;
        b=cw8aUpDbSU9lLiMGyeA5qrsr/vgzkSyYsNY19K8Y8k2nHvmV8uanjnRdkyH74Zn2n9
         ouqm6T6lOcFmS/baCa3/UOKIl5qKJZD+fvHu3Xh2ryb5LB2tMNPLTOCgzKfMo87tJZZS
         BRnhFG8E9IRgqW4ssT/1bSUzPgRtS2BxJ7UAkZT13H8x6fIXAlm8IurnTEmPzfnwm6vB
         t6FfGuZrjeD9y1cOk8ysR9xvT26hgTp7blGuYSkt6AVZGfwg8iApKj4OEAKHhcFj8+8m
         27oZEew/4/PTZvUyt2AICA2ABHd1x3vA1PppYUlUoeuzMZpD0/Fefd56KhFNE7bGUQT6
         EJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEUr2bW4Szp6UUsUkCSIlm1zM1E1rrtoqNdIPlEOp4RmgoUKaFEw2U3+z1vDRtGp4dTzK3lnLGWd5unC8=@vger.kernel.org, AJvYcCW+TOb5zjkPLbJpl8Od8dvy6pSUaWd9PS0o0xiy5jcZspT1tWAyN2JuWYWLFJhHNOXep7BKliHt0b5bZBp40Qeo@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLZPyueQO/1q1pjCNLywCMgQpHzruTzn3WUeWuOhdOhClOXcO
	xJ4QBiQEStepfG4es89fDTZIvD3pwlC4Pk7joBjujK8GSSrP3SWiRrvQf7wm6/Rubiqc2MugwJQ
	YEYOKsO+ZE4dbyuc41BVz4I35KM4=
X-Gm-Gg: ASbGncu/mzucwgQpxFw2OQKybZ2zsv1mpfghv0GK4YpsYjglDeKXOgNCp0rs7YblI3w
	LXqTrnqbrMHL4Za1a4Nv2foQcOutJscbhrVxEKxJqWQsZPUIeMr9e8A==
X-Google-Smtp-Source: AGHT+IHDfjFEkXa5up+8la/Umre/apfOKDK282kbL7f6Fslvloy6T3K2FQdcSZl/HJ4rTMl6ytZ9uz0XILRNkq7YiNg=
X-Received: by 2002:a17:90a:dfcb:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2f548eac5afmr18949337a91.9.1736548193853; Fri, 10 Jan 2025
 14:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104050007.13812-1-skb99@linux.ibm.com> <20241104050007.13812-3-skb99@linux.ibm.com>
 <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com>
 <Zz33lM0rTJBZpaJR@linux.ibm.com> <CAEf4Bzbek6CYbx5Atz_xwwx5J3gC1ELdVmW-kFrrR=CWNLMyBA@mail.gmail.com>
 <Z4D7Qx6pQEZ/bHDa@linux.ibm.com>
In-Reply-To: <Z4D7Qx6pQEZ/bHDa@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 14:29:42 -0800
X-Gm-Features: AbW1kvaBIMHjC1BlMRJQ3_b3BRF7IUU8hwbQAKs6TjLzV4O-zP_Yax047P-Vlq4
Message-ID: <CAEf4BzaEwvP-eVd=AWzvXPCfVCa5m0BKCe6q9tE5fT7VCAVDmA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libbpf: Remove powerpc prefix from syscall function names
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 2:49=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Thu, Nov 21, 2024 at 04:00:13PM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 20, 2024 at 6:52=E2=80=AFAM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wrote:
> > > > On Sun, Nov 3, 2024 at 9:00=E2=80=AFPM Saket Kumar Bhaskar <skb99@l=
inux.ibm.com> wrote:
> > > > >
> > > > > Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix=
 to
> > > > > syscall entry points") drops _powerpc prefix to syscall entry poi=
nts,
> > > > > even though powerpc now supports syscall wrapper, so /proc/kallsy=
ms
> > > > > have symbols for syscall entry without powerpc prefix(sys_*).
> > > > >
> > > > > For this reason, arch specific prefix for syscall functions in po=
werpc
> > > > > is dropped.
> > > > >
> > > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > > ---
> > > > >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > index 219facd0e66e..3a370fa37d8a 100644
> > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > @@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_=
pfx(void)
> > > > >  #elif defined(__riscv)
> > > > >         return "riscv";
> > > > >  #elif defined(__powerpc__)
> > > > > -       return "powerpc";
> > > > > -#elif defined(__powerpc64__)
> > > > > -       return "powerpc64";
> > > > > +       return "";
> > > > >  #else
> > > > >         return NULL;
> > > > >  #endif
> > > > > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token=
_fd)
> > > > >         if (!ksys_pfx)
> > > > >                 return 0;
> > > > >
> > > > > +#if defined(__powerpc__)
> > > > > +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
> > > > > +#else
> > > > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bp=
f", ksys_pfx);
> > > > > +#endif
> > > >
> > > > The problem is that on older versions of kernel it will have this
> > > > prefix, while on newer ones it won't. So to not break anything on o=
ld
> > > > kernels, we'd need to do feature detection and pick whether to use
> > > > prefix or not, right?
> > > >
> > > > So it seems like this change needs a bit more work.
> > > >
> > > > pw-bot: cr
> > > >
> > > Hi Andrii,
> > >
> > > IMO since both the patches 7e92e01b7245(powerpc: Provide syscall wrap=
per)
> > > and 94746890202cf(powerpc: Don't add __powerpc_ prefix to syscall ent=
ry points)
> > > went into the same kernel version v6.1-rc1, there won't me much kerne=
l
> > > versions that has only one of these patches.
> > >
> > > Also, to test more I tried this patch with ARCH_HAS_SYSCALL_WRAPPER d=
isabled,
> > > and it the test passed in this case too.
> > >
> >
> > Keep in mind that libbpf is supposed to work across many kernel
> > versions. So as long as there are powerpc (old) kernels that do use
> > arch-specific prefix, we need to detect them and supply prefix when
> > attaching ksyscall programs.
> >
> Hi Andrii,
>
> Sorry about the delayed response, I have started looking at this after
> a vacation.
>
> There are unlikely to be any old kernels that use arch-specific prefix
> as syscall wrapper support was added to powerpc in v6.1 and
> commit 94746890202cf that dropped the prefix also went into the same
> kernel release (v6.1-rc1). So, is it worth it support both sys_bpf and
> __powerpc_sys_bpf cases?
>
> But yes, there can be a kernel without syscall wrapper but having the
> sys_bpf symbol. So, how about identifying syscall wrapper enablement
> with __se_sys_bpf instead:
>
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..ff69a30cfe9b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11163,11 +11163,15 @@ int probe_kern_syscall_wrapper(int token_fd)
>         char syscall_name[64];
>         const char *ksys_pfx;
>
> +#if defined(__powerpc__)
> +       snprintf(syscall_name, sizeof(syscall_name), "__se_sys_bpf", ksys=
_pfx);
> +#else
>         ksys_pfx =3D arch_specific_syscall_pfx();
>         if (!ksys_pfx)
>                 return 0;
>
>         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys=
_pfx);
> +#endif
>
>         if (determine_kprobe_perf_type() >=3D 0) {
>                 int pfd;
> @@ -11176,16 +11180,28 @@ int probe_kern_syscall_wrapper(int token_fd)
>                 if (pfd >=3D 0)
>                         close(pfd);
>
> +#if defined(__powerpc__)
>                 return pfd >=3D 0 ? 1 : 0;
> +#else
> +               return pfd >=3D 0 ? 1 : 0;
> +#endif
>         } else { /* legacy mode */
>                 char probe_name[128];
>
>                 gen_kprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e), syscall_name, 0);
>                 if (add_kprobe_event_legacy(probe_name, false, syscall_na=
me, 0) < 0)
> +#if defined(__powerpc__)
> +                       return 1;
> +#else
>                         return 0;
> +#endif
>
>                 (void)remove_kprobe_event_legacy(probe_name, false);
> +#if defined(__powerpc__)
> +               return 0;
> +#else
>                 return 1;
> +#endif
>         }
>  }
>
> Actually, all architectures could use this '__se_' prefix instead of
> arch specific prefix  to identify if syscall wrapper is enabled.
> Separate way to handle powerpc case may not be needed. Will
> wait for your inputs to send v2.

the problem is that __se_sys_bpf is not traceable (it's a static
function), so it seems like this won't work


it's been a while, let me try to clarify my understanding of the
issue. The problem is that powerpc is special in that when syscall
wrapper is used, then, unlike all other architectures, they opted to
not have arch-specific prefix for syscall wrappers, is that right? and
that's why all the dancing you are trying to add. Am I right?

>
> Thanks,
> Saket
> > > Thanks,
> > > Saket
> > > > >
> > > > >         if (determine_kprobe_perf_type() >=3D 0) {
> > > > >                 int pfd;
> > > > > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksy=
scall(const struct bpf_program *prog,
> > > > >                  * compiler does not know that we have an explici=
t conditional
> > > > >                  * as well.
> > > > >                  */
> > > > > +#if defined(__powerpc__)
> > > > > +               snprintf(func_name, sizeof(func_name), "sys_%s", =
syscall_name);
> > > > > +#else
> > > > >                 snprintf(func_name, sizeof(func_name), "__%s_sys_=
%s",
> > > > >                          arch_specific_syscall_pfx() ? : "", sysc=
all_name);
> > > > > +#endif
> > > > >         } else {
> > > > >                 snprintf(func_name, sizeof(func_name), "__se_sys_=
%s", syscall_name);
> > > > >         }
> > > > > --
> > > > > 2.43.5
> > > > >

