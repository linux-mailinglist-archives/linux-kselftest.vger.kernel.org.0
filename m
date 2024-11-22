Return-Path: <linux-kselftest+bounces-22429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC779D567F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 01:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8988AB211F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2783158205;
	Fri, 22 Nov 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR21Rhmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC322075;
	Fri, 22 Nov 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233627; cv=none; b=Uo8rPvzUkvA5w5geeU154PVf7+41StLtztwFhvuntz4cPFU4l5x0nPyc9rNbtnxtWDxxTCGRu2wTa8UrQNCblmTVLa3hEuSECawO7DEBm6Mll2b6eYeClbHfafilBPkzcllwNVEk+AF1VebzR8iah4QbeU7aV8jFsL0BdkyGL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233627; c=relaxed/simple;
	bh=3cWKZugZJxDOhUapugdR2abukBsPxFZ5p124n5cXN5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXnMz6S+VvBbl9o5WByaB5fEdrkz6ciySSlHbXDi6l+skA0uE2sn1VIdRzcmL7ZqLe9nH/G1OS+riPdcyJpcaAt5Ktu41zjYJwI26YgucKKF47y85EWsI8AsdAwMXxPUtcayT8uWHTESlTbtUJOq6EgnZ0439RvsJdrDY52z6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR21Rhmn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea78d164b3so1303196a91.2;
        Thu, 21 Nov 2024 16:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732233625; x=1732838425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlaaiUw1+qbimgNp5by8wuj8PuQzxZYCtB1SgwFkKMA=;
        b=cR21Rhmn5ULzK+PNcFv3LNEjc+LUEpiQumfQ/flEpxvGXFfms3m6R7ugoyKf3W9Q46
         Xs7oe4h9y2OMVCwJXUR5oCZx3KlZHT2fQfkyZdcZlDBnE4ADBuvQyGf4FaOZFJhBIoJd
         BPmZr7kWUyzz+LmWj7aPx189AH7ri1uAF/QGnibfIj15b+FB4M2Kqxx8HXsiDxio5kaW
         SmQDqyrMEVspBd2lrdxWJ3yJg+moFYt7dolzXWtwiGgJ/7LXd89RkyvIoj8tAkQg/IZB
         ueuvupiYxdkB4JO5fHPVx6xgFgXCUNLfb2bNZQc4oukltAjjzkGvzpTl9Dl5lSwuIBTt
         v4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233625; x=1732838425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlaaiUw1+qbimgNp5by8wuj8PuQzxZYCtB1SgwFkKMA=;
        b=l5UqW0beMKVrBW4GPUDkTz5tAB0zxgUi3OmxDcKl/1h2Vl2Ftq/rea/FGspzLb6hTM
         Mu9tMijJ/TK30vyMnWDma/dWo9YLtZtiEOSHqQY7AeuXMIof18S1H5OEWFlzAMBk0uI/
         CsbwjrU/7BbigE7o5TB6nWcFXixN6nwy+5LELn22cQyQaMY7HYiFX7gj/e4/HCyZTRmM
         ruEEaYgonqgWHWOtvReMt8EC00h8sBwmUKPT3pmWW8sfRiinnLNgo0aXktn5VXw0kwGL
         cCgZGDjLCB81+kiybtJDSOpBQ6kktV9YZBHnh+l+cx2ryAqecWHw9/jVMoaLV6tRPpxG
         mzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUqWw8qlLOo1WCKXoJnSSBCcPudbD89onS9PqHad3MVGrPM3h/uCkkljJeXISZoLxSq4WGfL6TQ4T/o1XV97v5D@vger.kernel.org, AJvYcCVhOLzKk3jhl3MYiHlZV9s+b2OdIjH3RaGX2GUCs5+ZJ+79pquE34uT7tcxXRM151wcbtW9cRCirVvSbkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziwy4xs9E1Jn4DMLAQyxo7o3VL5uscuzWr7recJz5cM4kpeRtI
	nCQJZ5eZOb5RPNH5fDZPj8JWPmbNUE3RoaQNSckgL9Ol9V78psK6zOmleAqxbdgH5FtCzTg4ifj
	4FNKu7x83Ro0mnfHOuXxvcrG9JB47Cg==
X-Gm-Gg: ASbGncsysIyZQMewuW+MsZlz4dPekhkC5nH4Mbpi/mOo+KJfh+njVwZh+gDR480j46w
	UC7ABOqCVw45d8sXe3z+xpzFuQm1rLf3CWOSbDNMx5PPO/Hg=
X-Google-Smtp-Source: AGHT+IHXmGhqDIKiWF0toIfiSYwGNPcAD0woUlH3kLTSEh/GVmAZU3LwJBZT1h8h9Gt+9ZL2zAh5HrYPGyUm0VNNZxA=
X-Received: by 2002:a17:90b:4c41:b0:2ea:9cd6:985d with SMTP id
 98e67ed59e1d1-2eb0e8881d8mr957449a91.35.1732233625537; Thu, 21 Nov 2024
 16:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104050007.13812-1-skb99@linux.ibm.com> <20241104050007.13812-3-skb99@linux.ibm.com>
 <CAEf4BzZ9Bz8a_hY-jDkqaYg6Phi9bjvoxbBeVZqcgjYXg4a-mA@mail.gmail.com> <Zz33lM0rTJBZpaJR@linux.ibm.com>
In-Reply-To: <Zz33lM0rTJBZpaJR@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Nov 2024 16:00:13 -0800
Message-ID: <CAEf4Bzbek6CYbx5Atz_xwwx5J3gC1ELdVmW-kFrrR=CWNLMyBA@mail.gmail.com>
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

On Wed, Nov 20, 2024 at 6:52=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wrote:
> > On Sun, Nov 3, 2024 at 9:00=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux=
.ibm.com> wrote:
> > >
> > > Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix to
> > > syscall entry points") drops _powerpc prefix to syscall entry points,
> > > even though powerpc now supports syscall wrapper, so /proc/kallsyms
> > > have symbols for syscall entry without powerpc prefix(sys_*).
> > >
> > > For this reason, arch specific prefix for syscall functions in powerp=
c
> > > is dropped.
> > >
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 219facd0e66e..3a370fa37d8a 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_pfx(=
void)
> > >  #elif defined(__riscv)
> > >         return "riscv";
> > >  #elif defined(__powerpc__)
> > > -       return "powerpc";
> > > -#elif defined(__powerpc64__)
> > > -       return "powerpc64";
> > > +       return "";
> > >  #else
> > >         return NULL;
> > >  #endif
> > > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token_fd)
> > >         if (!ksys_pfx)
> > >                 return 0;
> > >
> > > +#if defined(__powerpc__)
> > > +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
> > > +#else
> > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", =
ksys_pfx);
> > > +#endif
> >
> > The problem is that on older versions of kernel it will have this
> > prefix, while on newer ones it won't. So to not break anything on old
> > kernels, we'd need to do feature detection and pick whether to use
> > prefix or not, right?
> >
> > So it seems like this change needs a bit more work.
> >
> > pw-bot: cr
> >
> Hi Andrii,
>
> IMO since both the patches 7e92e01b7245(powerpc: Provide syscall wrapper)
> and 94746890202cf(powerpc: Don't add __powerpc_ prefix to syscall entry p=
oints)
> went into the same kernel version v6.1-rc1, there won't me much kernel
> versions that has only one of these patches.
>
> Also, to test more I tried this patch with ARCH_HAS_SYSCALL_WRAPPER disab=
led,
> and it the test passed in this case too.
>

Keep in mind that libbpf is supposed to work across many kernel
versions. So as long as there are powerpc (old) kernels that do use
arch-specific prefix, we need to detect them and supply prefix when
attaching ksyscall programs.

> Thanks,
> Saket
> > >
> > >         if (determine_kprobe_perf_type() >=3D 0) {
> > >                 int pfd;
> > > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksyscal=
l(const struct bpf_program *prog,
> > >                  * compiler does not know that we have an explicit co=
nditional
> > >                  * as well.
> > >                  */
> > > +#if defined(__powerpc__)
> > > +               snprintf(func_name, sizeof(func_name), "sys_%s", sysc=
all_name);
> > > +#else
> > >                 snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
> > >                          arch_specific_syscall_pfx() ? : "", syscall_=
name);
> > > +#endif
> > >         } else {
> > >                 snprintf(func_name, sizeof(func_name), "__se_sys_%s",=
 syscall_name);
> > >         }
> > > --
> > > 2.43.5
> > >

