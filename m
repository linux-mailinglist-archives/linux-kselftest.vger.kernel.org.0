Return-Path: <linux-kselftest+bounces-19199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA0993EB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D3B2141C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011817E00F;
	Tue,  8 Oct 2024 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cmFj8rpX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262413C3F6
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368353; cv=none; b=qEUM3BC43/xYHB+3FxCOJFNS9eaw0/T4qGeaP2ehU5A/kCkvHwVGn/hj+2/H2k4Sg2BdawqGNTGPf5WsMe7xsKEVrIEsV2YIOFrfFClphVBnU2q4CjsT4eYSr00DRrXmByeFI16Tp1FqM6hXxV8wCqc0XebNkN6JquGBlpNONdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368353; c=relaxed/simple;
	bh=99T99fkhxyl05NOCSdwgSHdnxbr2uaqIW2y8IKVz1Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOhheZttvbNImOQvFS1XiA7ZllmFqLx0jeXqyHvRHhJ+VDhUChzYLCcjp/HpO+v+vwMb/0gEv7f+a8QYKJXMmE8fsCLr6J4giygPHnaXbbfKmqq6gqi9HE638oftnnLulaCfmv2ekgfwpxkr7n/saom2HTMBa+WxM90a2bwGfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cmFj8rpX; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83493f2dda4so201515739f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728368349; x=1728973149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRr5KbJ5pCun9Ui+yXUQXX9sN3Sf5UKx3OLBX37YeoY=;
        b=cmFj8rpX2U7Pk7sWVT2QvCzFW7jiDGmJMRyhDw4U/5oSgrO1suZrnX1Qaw5wxuZLvM
         pRmaO1VwVqRCMdIDWOOXdAcIlepbfiVf97sbLOQcpSSsAexgMJMIlDBqJcglE0XlR1BU
         vBjxB8hMBSsgQBHYxbJCO76mHtMovYr88RBPpZ1YBm7N90Al8z7ICJ8/g2fIDqwlsuEh
         kuBoTkG2dS3WNCGd9piy//T9OhVypoqbpZK43vXrW1jtYYGOVkW4dyxcc+JNKJAdnKyl
         1V/aczokanFGQdaHltxFvOebjQKp+07/ECLEnXpEbJFu/MCcfN4OG+CxiofaITUV+K6h
         bMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368349; x=1728973149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRr5KbJ5pCun9Ui+yXUQXX9sN3Sf5UKx3OLBX37YeoY=;
        b=ddkNULITe8DkvWvyuMnttF8L+boJ3bdmRxVeCb/LSghouy9fxzQ62WG+wjLZeLO12U
         Vd5p93QM2rpSRZ4MH/cqO+P+fUanU3kzTpQ7C385r1+Im3xD4TXEX94rgYBvO63YNxWk
         9NGvfekrm1zGBD3hmofqQ4/yrDG8opCv9eueSXCCn+QOiy79fTP3rKbQhyEPzAKIYyit
         ewWjmvo5ioNAodXws/1nENQVMm4SFdK5Ayw92tyh5Fs3HEWM2PnEmbDvUEEinsH3k8kW
         JYzNUYee3gGiSKZP4VVYzqKTDFbaHYYYeTOX7pV5vdH7Lv/kBccsq0lNuQTlqG6ZxC9g
         kt6w==
X-Forwarded-Encrypted: i=1; AJvYcCV/QnRqiNu5433NnE0Rlx5c8oAa7vGXLz+hNu/FaL2jR12yT/8cGaMjkNB99qoR3BEYaNQBCMohqKDb5GpZMuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJUkJfdlhMNI1RPwbtRkXIbRMUWis3YvFQWOmoA9hKSCqSBg3
	7F6VxwKSQHv0dh9PPvdyICs4101HEN3PMb2ok+G3x9I2a7jPzmMVkVpTdQ9n0nobpv0hoMVK+Q4
	bXc0NzCPS7cYloMQFgMuT0PWJrbzZT5q4MFmy3A==
X-Google-Smtp-Source: AGHT+IEEV1iKS64xo2W8tSXTVgZ9wK0tVm8MaNOWH+N+f0lrse/SrQLSt9EsGck2HE3GwEbRPJ5ayCLs8lBdAbKu4jQ=
X-Received: by 2002:a05:6e02:1a2c:b0:3a0:abd0:122 with SMTP id
 e9e14a558f8ab-3a38af6a526mr16553285ab.8.1728368349400; Mon, 07 Oct 2024
 23:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
 <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com>
 <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com> <CANXhq0qaokjDC9hb75_dpGuyOd_ex8+q7YNe8pAg7dbTcxuLSg@mail.gmail.com>
 <ZwTDonkiATv999sS@debug.ba.rivosinc.com>
In-Reply-To: <ZwTDonkiATv999sS@debug.ba.rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 8 Oct 2024 14:18:58 +0800
Message-ID: <CANXhq0r611Hi7pohDGRXhvi2E_uOFjwLRDrqZcL2WdLHcs+oHA@mail.gmail.com>
Subject: Re: [PATCH 16/33] riscv/shstk: If needed allocate a new shadow stack
 on clone
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:31=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> On Tue, Oct 08, 2024 at 01:16:17PM +0800, Zong Li wrote:
> >On Tue, Oct 8, 2024 at 7:30=E2=80=AFAM Deepak Gupta <debug@rivosinc.com>=
 wrote:
> >>
> >> On Mon, Oct 07, 2024 at 04:17:47PM +0800, Zong Li wrote:
> >> >On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Deepak Gupta <debug@rivosinc.=
com> wrote:
> >> >>
> >> >> Userspace specifies CLONE_VM to share address space and spawn new t=
hread.
> >> >> `clone` allow userspace to specify a new stack for new thread. Howe=
ver
> >> >> there is no way to specify new shadow stack base address without ch=
anging
> >> >> API. This patch allocates a new shadow stack whenever CLONE_VM is g=
iven.
> >> >>
> >> >> In case of CLONE_VFORK, parent is suspended until child finishes an=
d thus
> >> >> can child use parent shadow stack. In case of !CLONE_VM, COW kicks =
in
> >> >> because entire address space is copied from parent to child.
> >> >>
> >> >> `clone3` is extensible and can provide mechanisms using which shado=
w stack
> >> >> as an input parameter can be provided. This is not settled yet and =
being
> >> >> extensively discussed on mailing list. Once that's settled, this co=
mmit
> >> >> will adapt to that.
> >> >>
> >> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> >> ---
> >> >>  arch/riscv/include/asm/usercfi.h |  25 ++++++++
> >>
> >> ... snipped...
> >>
> >> >> +
> >> >> +/*
> >> >> + * This gets called during clone/clone3/fork. And is needed to all=
ocate a shadow stack for
> >> >> + * cases where CLONE_VM is specified and thus a different stack is=
 specified by user. We
> >> >> + * thus need a separate shadow stack too. How does separate shadow=
 stack is specified by
> >> >> + * user is still being debated. Once that's settled, remove this p=
art of the comment.
> >> >> + * This function simply returns 0 if shadow stack are not supporte=
d or if separate shadow
> >> >> + * stack allocation is not needed (like in case of !CLONE_VM)
> >> >> + */
> >> >> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> >> >> +                                          const struct kernel_clon=
e_args *args)
> >> >> +{
> >> >> +       unsigned long addr, size;
> >> >> +
> >> >> +       /* If shadow stack is not supported, return 0 */
> >> >> +       if (!cpu_supports_shadow_stack())
> >> >> +               return 0;
> >> >> +
> >> >> +       /*
> >> >> +        * If shadow stack is not enabled on the new thread, skip a=
ny
> >> >> +        * switch to a new shadow stack.
> >> >> +        */
> >> >> +       if (is_shstk_enabled(tsk))
> >> >
> >> >Hi Deepak,
> >> >Should it be '!' is_shstk_enabled(tsk)?
> >>
> >> Yes it is a bug. It seems like fork without CLONE_VM or with CLONE_VFO=
RK, it was returning
> >> 0 anyways. And in the case of CLONE_VM (used by pthread), it was not d=
oing the right thing.
> >
> >Hi Deepak,
> >I'd like to know if I understand correctly. Could I know whether there
> >might also be a risk when the user program doesn't enable the CFI and
> >the kernel doesn't activate CFI. Because this flow will still try to
> >allocate the shadow stack and execute the ssamowap command. Thanks
>
> `shstk_alloc_thread_stack` is only called from `copy_thread` and  allocat=
es and
> returns non-zero (positive value) for ssp only if `CLONE_VM` is specified=
.
> `CLONE_VM` means that address space is shared and userspace has allocated
> separate stack. This flow is ensuring that newly created thread with sepa=
rate
> data stack gets a separate shadow stack as well.
>
> Retruning zero value from `shstk_alloc_thread_stack` means that, no need =
to
> allocate a shadow stack. If you look at `copy_thread` function, it simply=
 sets
> the returned ssp in newly created task's task_struct (if it was non-zero)=
.
> If returned ssp was zero, `copy_thread` doesn't do anything. Thus whateve=
r is
> current task settings are that will be copied over to new forked/cloned t=
ask.
> If current task had shadow stack enabled, new task will also get it enabl=
ed at
> same address (to be COWed later).
>
> Any task get shadow stack enabled for first time using new prctls (see pr=
ctl
> patches).
>
> So only time `ssamoswap` will be exercised will be are
> - User issues enabling `prctl` (it'll be issued from loader)
> - fork/clone happens
>
> In both cases, it is guarded against checks of whether cpu supports it an=
d task
> has shadow stack enabled.
>
> Let me know if you think I missed any flow.

Thanks a lot for the detail, it is very helpful for me. But sorry for
the confusion, my question is actually on the situation with this bug
(i.e., before the fix)

>
> >
> >> Most of the testing has been with busybox build (independent binaries0=
 driven via buildroot
> >> setup. Wondering why it wasn't caught.
> >>
> >> Anyways, will fix it. Thanks for catching it.
> >>
> >> >
> >> >> +               return 0;
> >> >> +
> >> >> +       /*

