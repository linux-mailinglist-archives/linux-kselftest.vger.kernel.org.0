Return-Path: <linux-kselftest+bounces-24532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654BA11442
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9159D167306
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0172139DA;
	Tue, 14 Jan 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpeQPIIZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA726AC3;
	Tue, 14 Jan 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894437; cv=none; b=S/zRU008DZg/TJ/TZMAEQNR2cXO+3PiLt9w5XAh3z/tR8edyrQF65izePhaPjHt03g2QJOQUSYbwyFKSCNpPe4+sxgq8FxI4xfCNX6VeI+QLi6QcpBZu9zr2fv0TsTVi14u6udVdWwhwnAmFrL/MArkvL7Oca8lYxqCdsssMqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894437; c=relaxed/simple;
	bh=Zo2bkjUTBySFnsPWZreskWOEgAqjuWQ+FRk7VZIqhUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYv07xzC3KDMDmxBtNran7JN0a8wzysa4WnrPY7NyAtwhzmSNyG7XOCIjOg/i9TEkwNl0MP9pY6wtzSW8suUOYe95vQX1XiRqtB0HIc6E5s3g+7pnK7Lrlz0PZFkcrCZBRbKvJjS0dMwpjtl6Rr3DVtRWLBHKo50YMXLO8osMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpeQPIIZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216426b0865so106845725ad.0;
        Tue, 14 Jan 2025 14:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736894435; x=1737499235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyI2pPZ//8Q6bRl3RAD5qrhTONZNK2HwFua8F8lwyHE=;
        b=JpeQPIIZVhNDYiu8vBbBy9ibi/R0S8QDiEz4wY7IMvWybs+Yu9dD2pM7CzVkO6lwq0
         IPyklxByPd0Etpmbh60FWjwEW+8gzNRo0DndElJC3pkMghr8jIjGYMiBBRqL5uHQfUJG
         Q1IMfzK9t2oeReMBajGCouqojmF1GIYDZ53c6m9PnlxbFb/PFFFk29yYTbmsh+bVyetQ
         eisqwO+5GBI2mgKPuzNaKZvEGVRBga3+40qhnilkpMQh+q64B0ffkdPcapwFOJdf9sPb
         BUJPaRPGWYrdMp4zw6jWoxLMG/jFJb0Pd0/V3AaXJTYtYvqOpsuXGI/gt6OY2r4OcKjJ
         7buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894435; x=1737499235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyI2pPZ//8Q6bRl3RAD5qrhTONZNK2HwFua8F8lwyHE=;
        b=AY/n3RhT2eCwIFcngo1tbLIjaTSLCH/YMVots+MtJxb/04AFTH9BsOPvYOnJDeVfjt
         zbjtgoUCkShJhhkNpBjmzEs5jOYwqCpDkFZsH+gvwQVfxoRUsENi3+CkxhQ9vOzPGG68
         /eL8fgYBopT7FM6gFZ1Oz376PpabTYhF1H0MFYXCcLrC0XpsbmqekyqFqxqVr7DIa38M
         zjnVs8dSiyxFz1bAVBif6nGdeuGLijNU6g9qrbCbAkmjAx50LyABRaBTgzOnSxq48usQ
         9BIZCZ7baloxbtVa2FaSZU6l6XL4Z9DSMgyBO4VCiPinauR5zRn9N+0662d+s7+SXD0/
         W36g==
X-Forwarded-Encrypted: i=1; AJvYcCWHlb8QTwOzMepjorSKFH7LpB6rIa+1Vjt1CnTgYzD1hWIS05uXj4ejo7QpxUXbY1iwY3NN5tsylxrqtF/b36E/@vger.kernel.org, AJvYcCWIUjMsX2m4b2G3Put8dY243R67rE/L9X3A6j+NUxwDyx8YIP258HXz+hS3h8bJ7CKWjCUg+Wbpu7Qz9Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94bBU6VpZ3yhecReb0VhHlOnR5MIWfo6s4NIsJSjp5lnscPIp
	thhf5Ut/L6PZbfb/YBGg4WQxFCBT3NpxDXeyQTMH/0Z4nzzf/s2RirH/QsTDGlXOLk+NAChgbML
	K/9yL59qAlVgMQvnPFR2WJD0+rVU=
X-Gm-Gg: ASbGncudFA0KkoHjKkuomLDFkZoYuSrisUdlMZuGvs6P9r+1mGsqy/Zs7eZaFf0CCTA
	d11CfUDq4xELN59Gi0D61DgekKbNB5qDvLdyK
X-Google-Smtp-Source: AGHT+IHdp6kJr+e6F/9E4FXCaRv1jqfjBAwy19yJM6RrASBofBgY1sQNQJchTPwyIw3fwD/zfnO9bhik6XC5LGl7CWs=
X-Received: by 2002:a05:6a21:2d05:b0:1e0:d8c1:cfe2 with SMTP id
 adf61e73a8af0-1e88d09c675mr50503821637.34.1736894434646; Tue, 14 Jan 2025
 14:40:34 -0800 (PST)
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
 <Z4LMPn4u+l1qIi9T@linux.ibm.com>
In-Reply-To: <Z4LMPn4u+l1qIi9T@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 14:40:20 -0800
X-Gm-Features: AbW1kvbESFjUHMilkcWX2wiyga0sm7JUG_75hUy32mYH1trv62UVqyMqQ37cCEQ
Message-ID: <CAEf4BzZbfc2o0hVnXVQ1vegMGhM8h76F2aGVske3wd8hFQeM+g@mail.gmail.com>
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

On Sat, Jan 11, 2025 at 11:53=E2=80=AFAM Saket Kumar Bhaskar
<skb99@linux.ibm.com> wrote:
>
> CCing Maddy and MPE
> On Fri, Jan 10, 2025 at 02:29:42PM -0800, Andrii Nakryiko wrote:
> > On Fri, Jan 10, 2025 at 2:49=E2=80=AFAM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > On Thu, Nov 21, 2024 at 04:00:13PM -0800, Andrii Nakryiko wrote:
> > > > On Wed, Nov 20, 2024 at 6:52=E2=80=AFAM Saket Kumar Bhaskar <skb99@=
linux.ibm.com> wrote:
> > > > >
> > > > > On Fri, Nov 08, 2024 at 10:43:54AM -0800, Andrii Nakryiko wrote:
> > > > > > On Sun, Nov 3, 2024 at 9:00=E2=80=AFPM Saket Kumar Bhaskar <skb=
99@linux.ibm.com> wrote:
> > > > > > >
> > > > > > > Since commit 94746890202cf ("powerpc: Don't add __powerpc_ pr=
efix to
> > > > > > > syscall entry points") drops _powerpc prefix to syscall entry=
 points,
> > > > > > > even though powerpc now supports syscall wrapper, so /proc/ka=
llsyms
> > > > > > > have symbols for syscall entry without powerpc prefix(sys_*).
> > > > > > >
> > > > > > > For this reason, arch specific prefix for syscall functions i=
n powerpc
> > > > > > > is dropped.
> > > > > > >
> > > > > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > > > > ---
> > > > > > >  tools/lib/bpf/libbpf.c | 12 +++++++++---
> > > > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > > > > index 219facd0e66e..3a370fa37d8a 100644
> > > > > > > --- a/tools/lib/bpf/libbpf.c
> > > > > > > +++ b/tools/lib/bpf/libbpf.c
> > > > > > > @@ -11110,9 +11110,7 @@ static const char *arch_specific_sysc=
all_pfx(void)
> > > > > > >  #elif defined(__riscv)
> > > > > > >         return "riscv";
> > > > > > >  #elif defined(__powerpc__)
> > > > > > > -       return "powerpc";
> > > > > > > -#elif defined(__powerpc64__)
> > > > > > > -       return "powerpc64";
> > > > > > > +       return "";
> > > > > > >  #else
> > > > > > >         return NULL;
> > > > > > >  #endif
> > > > > > > @@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int t=
oken_fd)
> > > > > > >         if (!ksys_pfx)
> > > > > > >                 return 0;
> > > > > > >
> > > > > > > +#if defined(__powerpc__)
> > > > > > > +       snprintf(syscall_name, sizeof(syscall_name), "sys_bpf=
");
> > > > > > > +#else
> > > > > > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sy=
s_bpf", ksys_pfx);
> > > > > > > +#endif
> > > > > >
> > > > > > The problem is that on older versions of kernel it will have th=
is
> > > > > > prefix, while on newer ones it won't. So to not break anything =
on old
> > > > > > kernels, we'd need to do feature detection and pick whether to =
use
> > > > > > prefix or not, right?
> > > > > >
> > > > > > So it seems like this change needs a bit more work.
> > > > > >
> > > > > > pw-bot: cr
> > > > > >
> > > > > Hi Andrii,
> > > > >
> > > > > IMO since both the patches 7e92e01b7245(powerpc: Provide syscall =
wrapper)
> > > > > and 94746890202cf(powerpc: Don't add __powerpc_ prefix to syscall=
 entry points)
> > > > > went into the same kernel version v6.1-rc1, there won't me much k=
ernel
> > > > > versions that has only one of these patches.
> > > > >
> > > > > Also, to test more I tried this patch with ARCH_HAS_SYSCALL_WRAPP=
ER disabled,
> > > > > and it the test passed in this case too.
> > > > >
> > > >
> > > > Keep in mind that libbpf is supposed to work across many kernel
> > > > versions. So as long as there are powerpc (old) kernels that do use
> > > > arch-specific prefix, we need to detect them and supply prefix when
> > > > attaching ksyscall programs.
> > > >
> > > Hi Andrii,
> > >
> > > Sorry about the delayed response, I have started looking at this afte=
r
> > > a vacation.
> > >
> > > There are unlikely to be any old kernels that use arch-specific prefi=
x
> > > as syscall wrapper support was added to powerpc in v6.1 and
> > > commit 94746890202cf that dropped the prefix also went into the same
> > > kernel release (v6.1-rc1). So, is it worth it support both sys_bpf an=
d
> > > __powerpc_sys_bpf cases?
> > >
> > > But yes, there can be a kernel without syscall wrapper but having the
> > > sys_bpf symbol. So, how about identifying syscall wrapper enablement
> > > with __se_sys_bpf instead:
> > >
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 66173ddb5a2d..ff69a30cfe9b 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -11163,11 +11163,15 @@ int probe_kern_syscall_wrapper(int token_fd=
)
> > >         char syscall_name[64];
> > >         const char *ksys_pfx;
> > >
> > > +#if defined(__powerpc__)
> > > +       snprintf(syscall_name, sizeof(syscall_name), "__se_sys_bpf", =
ksys_pfx);
> > > +#else
> > >         ksys_pfx =3D arch_specific_syscall_pfx();
> > >         if (!ksys_pfx)
> > >                 return 0;
> > >
> > >         snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", =
ksys_pfx);
> > > +#endif
> > >
> > >         if (determine_kprobe_perf_type() >=3D 0) {
> > >                 int pfd;
> > > @@ -11176,16 +11180,28 @@ int probe_kern_syscall_wrapper(int token_fd=
)
> > >                 if (pfd >=3D 0)
> > >                         close(pfd);
> > >
> > > +#if defined(__powerpc__)
> > >                 return pfd >=3D 0 ? 1 : 0;
> > > +#else
> > > +               return pfd >=3D 0 ? 1 : 0;
> > > +#endif
> > >         } else { /* legacy mode */
> > >                 char probe_name[128];
> > >
> > >                 gen_kprobe_legacy_event_name(probe_name, sizeof(probe=
_name), syscall_name, 0);
> > >                 if (add_kprobe_event_legacy(probe_name, false, syscal=
l_name, 0) < 0)
> > > +#if defined(__powerpc__)
> > > +                       return 1;
> > > +#else
> > >                         return 0;
> > > +#endif
> > >
> > >                 (void)remove_kprobe_event_legacy(probe_name, false);
> > > +#if defined(__powerpc__)
> > > +               return 0;
> > > +#else
> > >                 return 1;
> > > +#endif
> > >         }
> > >  }
> > >
> > > Actually, all architectures could use this '__se_' prefix instead of
> > > arch specific prefix  to identify if syscall wrapper is enabled.
> > > Separate way to handle powerpc case may not be needed. Will
> > > wait for your inputs to send v2.
> >
> > the problem is that __se_sys_bpf is not traceable (it's a static
> > function), so it seems like this won't work
> >
> >
> > it's been a while, let me try to clarify my understanding of the
> > issue. The problem is that powerpc is special in that when syscall
> > wrapper is used, then, unlike all other architectures, they opted to
> > not have arch-specific prefix for syscall wrappers, is that right? and
> > that's why all the dancing you are trying to add. Am I right?
> >
> Yes, you got it right. For more details, you can refer to the
> reasoning behind the change here:
> https://github.com/torvalds/linux/commit/94746890202cf

That was an unfortunate decision to deviate :(

Alright, so where are we? We can't do __se_<syscall> approach, but we
need to have some reliable way to determine whether powerpc uses
syscall wrapper. Can you please summarize available options for
powerpc? Sorry, it's been a while, so we need to re-page in all the
context.

>
> Thanks,
> Saket
> > >
> > > Thanks,
> > > Saket
> > > > > Thanks,
> > > > > Saket
> > > > > > >
> > > > > > >         if (determine_kprobe_perf_type() >=3D 0) {
> > > > > > >                 int pfd;
> > > > > > > @@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach=
_ksyscall(const struct bpf_program *prog,
> > > > > > >                  * compiler does not know that we have an exp=
licit conditional
> > > > > > >                  * as well.
> > > > > > >                  */
> > > > > > > +#if defined(__powerpc__)
> > > > > > > +               snprintf(func_name, sizeof(func_name), "sys_%=
s", syscall_name);
> > > > > > > +#else
> > > > > > >                 snprintf(func_name, sizeof(func_name), "__%s_=
sys_%s",
> > > > > > >                          arch_specific_syscall_pfx() ? : "", =
syscall_name);
> > > > > > > +#endif
> > > > > > >         } else {
> > > > > > >                 snprintf(func_name, sizeof(func_name), "__se_=
sys_%s", syscall_name);
> > > > > > >         }
> > > > > > > --
> > > > > > > 2.43.5
> > > > > > >

