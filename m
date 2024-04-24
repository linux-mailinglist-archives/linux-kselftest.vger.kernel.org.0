Return-Path: <linux-kselftest+bounces-8752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6C88AFEDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C971F22AFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619A29429;
	Wed, 24 Apr 2024 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6kHTLcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783E171CC;
	Wed, 24 Apr 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927387; cv=none; b=tWAS3PeQTJ5Wd0kdqiEwMJB1stT+vYfoqoyz0rrSkLp9JPPWp+aTC0I/BLW+PvCON5IpgTadxSIXGcoiPUk1o3HsLFgGkPMmeBSPjOvIEJWiZ+WPv8ISrfN5JIa8SDNl/JGI7t7LPMI/X9MO4Ft5dSe4GuKWTJboFIikHMiBnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927387; c=relaxed/simple;
	bh=3F8Ljp1pZPV1emCV1Jv8jlUViTo++vaW01K6L3+V/Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXC/IYCuMyrdQE9outf51WekzYUxqD5jonzhmjhPu/h14YpVFuKvtBkWUeJ2x2s4M0MuZjh/PCwNfHSx3b2nfmZ/nCIqTLLxtGcGE1W9ILsrUwjAmvvgg3lCCIRm7AZzLl/eaPNtVG7ffDlQLLkzuYilSSwgCGPr+8r1C42Sz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6kHTLcj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a72f3a20dso20519165e9.0;
        Tue, 23 Apr 2024 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927384; x=1714532184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B917gxSMtiV9f/CrLtxYPwm85pplJTB5epaSS3BtCKg=;
        b=N6kHTLcjuzxm4wWk7PWe6KBAiqBmc3E1fSimVps6dgViVITTCDQqPPPHrro3hGLTZW
         MwtNtef42raDCpSA/D7rl/mrcW8Ro1Us71IGWsKO9Bh6t37IYbzRO2yQpINvG3wlp9QF
         fe2SZkhKAQoZpAwHYGJB4npn2cM5jhd3KssBkVX1nu6nxlqWOMBHyunw3QimxgmKIjuX
         19OkUqxh/m1yK6Nhw0yqoz9bZpxTFE6r3VZQHS7mQTgFIoQH+T+H2IivC3hRGA6chM1U
         sP5E1aWzEeKgwtPxlh+XhiuoNAuymSaHKDAc1ZjGkCdDMawYFkaZmSmvhkhQ3FfH/l6o
         C4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927384; x=1714532184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B917gxSMtiV9f/CrLtxYPwm85pplJTB5epaSS3BtCKg=;
        b=ESiqcSvD+IFjn0NEF0ezb1TT+j88u4F+kcOl90Xi568w4itdQRVj2cBoCjbCx45jJg
         KPsY37evdZKTviCuH+KL1tIe0CMaFS6MTyszs6l085qpNiTK76y8/0NIcyAocel7KWaA
         Zgxa6Ceb3wnFb3OQ9duEQlptAIJ/jkXADJJmi+KDnoDpqdLoe/MO8F4Msgt84VzCEmON
         WmLuP4rotB2IUSrpcCeCBvI/xSnuBL408u+ng8tdzZXnGr7M3TN3Wj+IZXYGJyBKkElb
         W9/pldUkf29UpTDhHVnxj+QC7Xe/yXQTpZkvo4H6f+lBKbiI7qpWXLoYVcnJCzJ1tOtx
         ZiQA==
X-Forwarded-Encrypted: i=1; AJvYcCXHBkDfL+nseciS617Enym5o/qi6Sm1scuQI+fJ5WP11bFuoHh9jp5dxpFn5qwf4VXfwpdTw9e85jl8rsqfIh/Qh3eOy5FsxgBd76rghQYFa+3/vnAg3w+iWQmcImvFPJUPx/wbY2Q4vIYdeO2btoEujMDEiv/0BG1EPHM7xk/Uj21E
X-Gm-Message-State: AOJu0Yy9PyCDNw2i83K5ycqgrb85b00QtDp2L/D26EOLjlatzHNgUQLK
	qbbSMiZSL3fFtdEUcPqWexXCRsUT3X6mbWUTTqbZ/zqCmsqhSBUtATKOMrghnLF66ksqujgU7jl
	2ujSM1IydpIx6WBIVMS6RACH7yew=
X-Google-Smtp-Source: AGHT+IFt+uJn6bADlCJRAfLO2sYIqxeWgiQ8Ib/eiyitEnpA1LQrIHQHRW3pb7lwgHFPG9OJ1X9gYBmU/dcG513CNyw=
X-Received: by 2002:adf:ec49:0:b0:34b:e79:2677 with SMTP id
 w9-20020adfec49000000b0034b0e792677mr707877wrn.63.1713927383986; Tue, 23 Apr
 2024 19:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-13-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-13-6c986a5a741f@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 19:56:13 -0700
Message-ID: <CAADnVQLbK2LajKjGRCxCUcSVOoPc5rQh=Gvz=AhYCon25CHxUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/16] bpf: wq: add bpf_wq_set_callback_impl
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
> @@ -11018,6 +11027,7 @@ enum special_kfunc_type {
>         KF_bpf_percpu_obj_drop_impl,
>         KF_bpf_throw,
>         KF_bpf_iter_css_task_new,
> +       KF_bpf_wq_set_callback_impl,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -11044,6 +11054,7 @@ BTF_ID(func, bpf_throw)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(func, bpf_iter_css_task_new)
>  #endif
> +BTF_ID(func, bpf_wq_set_callback_impl)
>  BTF_SET_END(special_kfunc_set)
>
>  BTF_ID_LIST(special_kfunc_list)
> @@ -11074,6 +11085,7 @@ BTF_ID(func, bpf_iter_css_task_new)
>  #else
>  BTF_ID_UNUSED
>  #endif
> +BTF_ID(func, bpf_wq_set_callback_impl)

This is broken on !CONFIG_CGROUPS.
KF_bpf_wq_set_callback_impl in enum special_kfunc_type won't
match special_kfunc_list.
I moved this line up while applying.

>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -11402,12 +11414,28 @@ static bool is_sync_callback_calling_kfunc(u32 =
btf_id)
>         return btf_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl];
>  }
>
> +static bool is_async_callback_calling_kfunc(u32 btf_id)
> +{
> +       return btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback_im=
pl];
> +}
> +
>  static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
>  {
>         return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
>                insn->imm =3D=3D special_kfunc_list[KF_bpf_throw];
>  }
>
> +static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
> +{
> +       return btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback_im=
pl];
> +}
> +
> +static bool is_callback_calling_kfunc(u32 btf_id)
> +{
> +       return is_sync_callback_calling_kfunc(btf_id) ||
> +              is_async_callback_calling_kfunc(btf_id);
> +}
> +
>  static bool is_rbtree_lock_required_kfunc(u32 btf_id)
>  {
>         return is_bpf_rbtree_api_kfunc(btf_id);
> @@ -12219,6 +12247,16 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 }
>         }
>
> +       if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
> +               err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> +                                        set_timer_callback_state);
> +               if (err) {
> +                       verbose(env, "kfunc %s#%d failed callback verific=
ation\n",
> +                               func_name, meta.func_id);
> +                       return err;
> +               }
> +       }
> +
>         rcu_lock =3D is_kfunc_bpf_rcu_read_lock(&meta);
>         rcu_unlock =3D is_kfunc_bpf_rcu_read_unlock(&meta);
>
> @@ -16982,6 +17020,9 @@ static bool states_equal(struct bpf_verifier_env =
*env,
>         if (old->active_rcu_lock !=3D cur->active_rcu_lock)
>                 return false;
>
> +       if (old->in_sleepable !=3D cur->in_sleepable)
> +               return false;
> +
>         /* for states to be equal callsites have to be the same
>          * and all frame states need to be equivalent
>          */
> @@ -19653,6 +19694,28 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                    desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_=
cast]) {
>                 insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>                 *cnt =3D 1;
> +       } else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {
> +               /* The verifier will process callback_fn as many times as=
 necessary
> +                * with different maps and the register states prepared b=
y
> +                * set_timer_callback_state will be accurate.
> +                *
> +                * The following use case is valid:
> +                *   map1 is shared by prog1, prog2, prog3.
> +                *   prog1 calls bpf_timer_init for some map1 elements
> +                *   prog2 calls bpf_timer_set_callback for some map1 ele=
ments.
> +                *     Those that were not bpf_timer_init-ed will return =
-EINVAL.
> +                *   prog3 calls bpf_timer_start for some map1 elements.
> +                *     Those that were not both bpf_timer_init-ed and
> +                *     bpf_timer_set_callback-ed will return -EINVAL.
> +                */

Also removed this comment. It's not correct here.

> +               struct bpf_insn ld_addrs[2] =3D {
> +                       BPF_LD_IMM64(BPF_REG_4, (long)env->prog->aux),
> +               };
> +
> +               insn_buf[0] =3D ld_addrs[0];
> +               insn_buf[1] =3D ld_addrs[1];
> +               insn_buf[2] =3D *insn;
> +               *cnt =3D 3;
>         }
>         return 0;
>  }
>
> --
> 2.44.0
>

