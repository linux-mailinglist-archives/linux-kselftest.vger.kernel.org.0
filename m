Return-Path: <linux-kselftest+bounces-6505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151588713E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C879281C2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3865D47B;
	Fri, 22 Mar 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvwRa8y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963DE5674C;
	Fri, 22 Mar 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126251; cv=none; b=ICf4M0iS91CF60xBVRBTSxMtNN7aB0gwji4gH1HpygOs4QsrNx95y0hsQcF4tyVG9NxDzI8hNATI/nXsUHExklLh6A/fKhxwuTdMpBMEbwN7u0H9/inNC5toiTHtOK8yc4XwtosZ0V8BiD7v5mC3FIljTQO20P4Z2jm3hCGyFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126251; c=relaxed/simple;
	bh=zWVaHDgjOuHVfjlI/i15WMIyLZ98z083v88nOntCkzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7khhA9i2mQ5iZ7ptcIZdkRHgsyUtUp3Byofhi81Qr+73ChhOi3UaxjfBQ9IZc9Qeo0NcguMKHRjkgdZEE5xg7eRyxqpgInvDJBZNbIWMFzZqlvNedmbBve47JUgewTnEzRf+sKlS29FJgRAV0/6bnwjU72vF7w7GfW4g9IEv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvwRa8y8; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-221e76cad07so1447972fac.0;
        Fri, 22 Mar 2024 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126248; x=1711731048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IMFU2MbnOsDAXDgvuXOEwtIjtmzVMSKHwsLZ0yMQ728=;
        b=mvwRa8y8y0NVCZQTP6gYYfL2NdtzJDBAszJKffHH2YUiClTQGqOc4A7sJCPL61vwFa
         z4PToPUrBUUDrnF+APL75PiEC1ITnc5R5mDLijFRhQ3uwnBGoZXJIwGOavBZXSaS4ejD
         SpcvzKWPDQaj4cO9ZlnXJv9PGhxJUQyVOkBlRtwkc+k9vlV9FYpkm94dWrEeGoy+R4rn
         OEtG6oR7qji5iF/3NBZ2eu+yXAEjJZvY9S0zUPMJJ7K8hAVRNz5oT6cScVPErrxfTk3b
         1Ms9zj9ZjcubL+BRApkOR1Ura0h0w54rJys7J3y+TP/xalGkttS3FBIaPXQAjt3fX5/p
         /xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126248; x=1711731048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMFU2MbnOsDAXDgvuXOEwtIjtmzVMSKHwsLZ0yMQ728=;
        b=tnBbXGiMUIrYpBFRR1FCrbJmtQw7nBLZaxD2fSkwFoMMmJjMJ3HwVNbAJmcyO3MvWS
         sM5eJ32dt8v6/J6oBVu/WrqTzPezrppidA3vMYpM++CdH6KciVysm+2AbcashsQ4Ovxo
         yW51nfT0MfVwgRok/I74qCmU6aPe2hv8XvyybGPSfVYiPqbE1bybCNyDHEyXe08Qry/a
         dry/OqcatJ7l7tFAeBu4979y6uMH6w708KEqjqLuYaJKoI0RPnnCnpbQ4lf2x5OLveAq
         k8+w/7P44IzGxauH0gG1Os/cpl2oFMq7E7t2bSmwHUSmJ3C61L7A6J6fOu2psCBEd5+s
         17hg==
X-Forwarded-Encrypted: i=1; AJvYcCU3U2JZrFi+3ZV3WoudLu2vis1Un1wQzzidnHqQlFh2ATdruRfs36tLZjYh5+kvYQFMwxgk23b3v60FsIZwPVHC2hzP5lGMPU5tUW0Uoa1bgODczvXblNzmmPXGpA4evHb7XqBKW1/WY2odLGYKmNzn1atltaHvzbl54plPP6QkZs5L
X-Gm-Message-State: AOJu0Ywcrsq8mqsZP7OIGEtlFApCeuYCXa+aN3YWJT7Kak2LKvNLPuHQ
	C9yv0xXv7fYvAmR7U1WkNVCJzNMhkioR0ZGAeAjPmSgbS++F8h/MbjNmNI9+A+q6yjuzJdNGLoY
	5D0WYQlh87M45lwcR95x2ppfhNI0=
X-Google-Smtp-Source: AGHT+IGPOoEEYRbtKYoZlOJzHAn0rx0HGoNUpSFoPMOl2wuDeaJmXaacZVSR2+zxC3yP7RBZl0VWSvbJ/3xnqjcqyb8=
X-Received: by 2002:a05:6870:332a:b0:229:b0b5:a3db with SMTP id
 x42-20020a056870332a00b00229b0b5a3dbmr63284oae.3.1711126248523; Fri, 22 Mar
 2024 09:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org> <20240322-hid-bpf-sleepable-v5-3-179c7b59eaaa@kernel.org>
In-Reply-To: <20240322-hid-bpf-sleepable-v5-3-179c7b59eaaa@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Mar 2024 17:50:11 +0100
Message-ID: <CAP01T74+naPau2_=1G2_TUSjY_ZCAWQ2XVBKxs9xSKHobZcEeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 15:57, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> In this patch, bpf_timer_set_sleepable_cb() is functionally equivalent
> to bpf_timer_set_callback(), to the exception that it enforces
> the timer to be started with BPF_F_TIMER_SLEEPABLE.
>
> But given that bpf_timer_set_callback() is a helper when
> bpf_timer_set_sleepable_cb() is a kfunc, we need to teach the verifier
> about its attached callback.
> Marking that callback as sleepable will be done in a separate patch
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
> [...]
>
> @@ -19548,6 +19582,28 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                    desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>                 insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>                 *cnt = 1;
> +       } else if (is_bpf_timer_set_sleepable_cb_impl_kfunc(desc->func_id)) {
> +               /* The verifier will process callback_fn as many times as necessary
> +                * with different maps and the register states prepared by
> +                * set_timer_callback_state will be accurate.
> +                *
> +                * The following use case is valid:
> +                *   map1 is shared by prog1, prog2, prog3.
> +                *   prog1 calls bpf_timer_init for some map1 elements
> +                *   prog2 calls bpf_timer_set_callback for some map1 elements.
> +                *     Those that were not bpf_timer_init-ed will return -EINVAL.
> +                *   prog3 calls bpf_timer_start for some map1 elements.
> +                *     Those that were not both bpf_timer_init-ed and
> +                *     bpf_timer_set_callback-ed will return -EINVAL.
> +                */
> +               struct bpf_insn ld_addrs[2] = {
> +                       BPF_LD_IMM64(BPF_REG_3, (long)env->prog->aux),
> +               };
> +
> +               insn_buf[0] = ld_addrs[0];
> +               insn_buf[1] = ld_addrs[1];
> +               insn_buf[2] = *insn;
> +               *cnt = 3;
>         }

Would be better to handle the fixup of all kfuncs in one place, i.e.
fixup_kfunc_call.

>         return 0;
>  }
>
> --
> 2.44.0
>
>

