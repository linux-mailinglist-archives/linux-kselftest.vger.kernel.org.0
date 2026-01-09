Return-Path: <linux-kselftest+bounces-48621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0BD0B43C
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D7D13058446
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEF2222C0;
	Fri,  9 Jan 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsSq+IG6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237826ED28
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975897; cv=none; b=Pi6RwAZxoPmTaJk8OD+KCXueYH764lRwtq4JSTKWUmGJlJtZSWBE7o8RaktjlDJ0CJ2LWpfcKtGTRv48VfSjfcyiupBVaZLwWw9VXZY2iY5as2Ihjzch/5d6Gd9V+5b7sfYcKomUbXeS7JU58echvh335Pau6Wqsif1RqhXKqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975897; c=relaxed/simple;
	bh=DsoNiErAyhf3A90GHQfACdBGfpojvMzHJ+IZ5BcSxgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhmzZn++ytWVwrFIQISrJH3M5EuxZx4f4LpfjBgDAxAmdF9Qbltjb+v2Zee9o+4akky5ZjNl61CgEOgXmfYTcH4dg0WQU4oxn8cmTI3u2Gx3y40RCFe4QwANPj2K7Rm2eVo1IyLZRa07lqLnNzUr7Iqsb9jqqzsLpcv/hdWZAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsSq+IG6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47755de027eso26251555e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767975893; x=1768580693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHmfnqgDCEmK613FRrQHV+ATkk1Rai86bVueukmcvOY=;
        b=TsSq+IG6ozA/zUfAyQkCipaHBAEicf6+Ng74O2wCD1FeL0qNNProlDRua6tcy9fiNR
         JqzuXzC2g1OSOgPjDpueIaELTRS5X14TU9V7T+XflgzxaNVXlWHdO0rpUkGcPF6XIrAW
         4VsjspW06kmKN3iYDduKFPzZYUDMzn/AfJTihRgeGSKCZw7RPKySM5kQB3Py+YY2/EBQ
         EBYNUzoc+3Xy33QaB3Cm/PPNGv59DYFvbHkXpYxV+Izy0HnDjrkxNFH07fWgO9fUsQkM
         rfzgWuggSjQTUSEHTEGOspr+ajiQI9gDDOE5gO8I8AX/ZsriLNFU56pS3nywr5QcmmdW
         wTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975893; x=1768580693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHmfnqgDCEmK613FRrQHV+ATkk1Rai86bVueukmcvOY=;
        b=p4TljVrn7k7gE8oZ8YJV3ahpbnnd+fIg7P00RHgbCG5iR1fV5LFYLuM53E+AHmXkXi
         52KUnBOAiIvJ1SFZ6ZGE+iTqw/HXSugXdwynSBOie81NWM4W+4CKs0lot6DhiAuug/4N
         JtU/9jCXKhnc4Re1zc8c+nI5tXWSW0kusFClAQ5IlXNluTqzEWhzabH+RghOSbOjUw7Y
         A4zGNuRYe2K2/Ms5cQ4pmlSHAWAqGiKp0KTqYoRRrPFbUsf3OL8JjMKFeOPsf+dq34Y2
         Brl+vftu7JZ4h5EKqJvog7pevgEecDCauR9dyGDvLxDH6C2mh4RkX1NTwDYRV7HD21ue
         Cnmw==
X-Forwarded-Encrypted: i=1; AJvYcCXUhw8qF6o9199h626sjzoNszSsrSFCiyhYyDKMSW8V84pxAsko82rM1WhllXKA2www6VzvbBq38uNu7t76Bi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKer70slm1DtaHNMocVXq9rQd9dJ7L3ithm5AsXlfrMlQu8mmZ
	BQRoh6InSpvO328lCEBCVMfkH+CsqEMq1/X50WX1GWQll7f+j4CHYvdVJyYDQIINukABSnFOPox
	PjwcU6iTn5ykdmm5Fdc6LYTYmOXRB6m4=
X-Gm-Gg: AY/fxX4BIvM/Jt6hwffJDaU+ljB+cfevSVPKWLVK3KqZdbOkpTGQU1UwYkCRE930mEH
	4qwYWfN/cdQBm8+cInaifz0NmjN4Dmm8HgerPDXLRWyHipRgP0oS6bUoqKMP3BZh6GXllGI+CUe
	+pQ7SS03+xCV7XF4V2xCnvVPnhI+7yqosSmlhQbkGCWdIi1CObJzCeHBUyuKglY+Jr3sylTuBxN
	0sHxL+leaVvMaOtIlnTwmwvA1HVDLShR43yxpGHw0OQPkMgCLZCVukyMXjbkAI9fzGjSxLpnyMw
	q5uwwehNuzNzS3IGnzMnyUkaB39f
X-Google-Smtp-Source: AGHT+IH8/QRjd++hMR8vlKQXLENn7AamAuc5FJZXDbW/uNvxUAJMk5qvZVioKDc46eg8K59Ls8JDHizJk5fuymSkcis=
X-Received: by 2002:a05:600c:4694:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-47d84b3db20mr97255695e9.34.1767975893237; Fri, 09 Jan 2026
 08:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109153420.32181-1-leon.hwang@linux.dev> <20260109153420.32181-2-leon.hwang@linux.dev>
In-Reply-To: <20260109153420.32181-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 08:24:41 -0800
X-Gm-Features: AZwV_Qjs-h5Q6oTESWcQ85ioWJXfjnRIPt3WHmpg0AdmKGFJ63hMwzpPEGHOOQk
Message-ID: <CAADnVQK4O-igzuSvfgjG1ZqdUBXrjNL=4tJZuS1uy36GCD2mVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf, x64: Call perf_snapshot_branch_stack in trampoline
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> When the PMU LBR is running in branch-sensitive mode,
> 'perf_snapshot_branch_stack()' may capture branch entries from the
> trampoline entry up to the call site inside a BPF program. These branch
> entries are not useful for analyzing the control flow of the tracee.
>
> To eliminate such noise for tracing programs, the branch snapshot should
> be taken as early as possible:
>
> * Call 'perf_snapshot_branch_stack()' at the very beginning of the
>   trampoline for fentry programs.
> * Call 'perf_snapshot_branch_stack()' immediately after invoking the
>   tracee for fexit programs.
>
> With this change, LBR snapshots remain meaningful even when multiple BPF
> programs execute before the one requesting LBR data.
>
> In addition, more relevant branch entries can be captured on AMD CPUs,
> which provide a 16-entry-deep LBR stack.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 66 +++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 16 ++++++++-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..a71a6c675392 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -12,6 +12,7 @@
>  #include <linux/bpf.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
> +#include <linux/perf_event.h>
>  #include <asm/extable.h>
>  #include <asm/ftrace.h>
>  #include <asm/set_memory.h>
> @@ -19,6 +20,7 @@
>  #include <asm/text-patching.h>
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
> +#include "../events/perf_event.h"
>
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
>
> @@ -3137,6 +3139,54 @@ static int invoke_bpf_mod_ret(const struct btf_fun=
c_model *m, u8 **pprog,
>         return 0;
>  }
>
> +DEFINE_PER_CPU(struct bpf_tramp_branch_entries, bpf_branch_snapshot);
> +
> +static int invoke_branch_snapshot(u8 **pprog, void *image, void *rw_imag=
e)
> +{
> +       struct bpf_tramp_branch_entries __percpu *pptr =3D &bpf_branch_sn=
apshot;
> +       u8 *prog =3D *pprog;
> +
> +       /*
> +        * Emit:
> +        *
> +        * struct bpf_tramp_branch_entries *br =3D this_cpu_ptr(&bpf_bran=
ch_snapshot);
> +        * br->cnt =3D static_call(perf_snapshot_branch_stack)(br->entrie=
s, x86_pmu.lbr_nr);
> +        */
> +
> +       /* mov rbx, &bpf_branch_snapshot */
> +       emit_mov_imm64(&prog, BPF_REG_6, (long) pptr >> 32, (u32)(long) p=
ptr);
> +#ifdef CONFIG_SMP
> +       /* add rbx, gs:[<off>] */
> +       EMIT2(0x65, 0x48);
> +       EMIT3(0x03, 0x1C, 0x25);
> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
> +#endif
> +       /* mov esi, x86_pmu.lbr_nr */
> +       EMIT1_off32(0xBE, x86_pmu.lbr_nr);
> +       /* lea rdi, [rbx + offsetof(struct bpf_tramp_branch_entries, entr=
ies)] */
> +       EMIT4(0x48, 0x8D, 0x7B, offsetof(struct bpf_tramp_branch_entries,=
 entries));
> +       /* call static_call_query(perf_snapshot_branch_stack) */
> +       if (emit_rsb_call(&prog, static_call_query(perf_snapshot_branch_s=
tack),
> +                         image + (prog - (u8 *)rw_image)))
> +               return -EINVAL;
> +       /* mov dword ptr [rbx], eax */
> +       EMIT2(0x89, 0x03);
> +
> +       *pprog =3D prog;
> +       return 0;
> +}
> +
> +static bool bpf_prog_copy_branch_snapshot(struct bpf_tramp_links *tl)
> +{
> +       bool copy =3D false;
> +       int i;
> +
> +       for (i =3D 0; i < tl->nr_links; i++)
> +               copy =3D copy || tl->links[i]->link.prog->copy_branch_sna=
pshot;
> +
> +       return copy;
> +}
> +
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
>         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3366,6 +3416,14 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>
>         save_args(m, &prog, regs_off, false, flags);
>
> +       if (bpf_prog_copy_branch_snapshot(fentry)) {
> +               /* Get branch snapshot asap. */
> +               if (invoke_branch_snapshot(&prog, image, rw_image)) {
> +                       ret =3D -EINVAL;
> +                       goto cleanup;
> +               }
> +       }

Andrii already tried to do it.
I hated it back then and still hate the idea.
We're not going to add custom logic for one specific use case
no matter how appealing it sounds to save very limited LBR entries.
The HW will get better, but we will be stuck with this optimization forever=
.

pw-bot: cr

