Return-Path: <linux-kselftest+bounces-5342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0138615F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5342287FBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3828D82D6D;
	Fri, 23 Feb 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abskwHR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CB81ACB;
	Fri, 23 Feb 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702526; cv=none; b=CoBTj228uaYjG5MOEfa9Y2BJxAv8KziyQfXxyUimRT6oWr8qZbxKEaOZkd7tdAqRXQEr//HaqK1HcvXyY9nZomhx4MZhu+KZYaoYLVcFmHFrq4Qkacz0ds3G+Ja3y/BujkBGqFyOSGyHU8bUY0pqUhB2vlJ47avJxumuUYVQSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702526; c=relaxed/simple;
	bh=tY1h/501teFgiCPr6RmDbD0tP/QViR2mW9o+4KD5XKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRq5lxUJMrg0qTI4cbotyj+LQEZEfo+cG7hck3g92qZj+sPSsiDQngBP7Nyx7HeoEGJMmftfxVEtB8oaRJ+nkRdLYiHpL+eUOlS+rQ0noSwUSXAPQydWm59Whgk1ArdCRGF2qS+a670LNsoO4gJs50eNBLJkbKnKvHTXIxynzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abskwHR+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e706f50beso125046566b.0;
        Fri, 23 Feb 2024 07:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708702522; x=1709307322; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MK6dDwiB3ZrZ3H37ABX4rh9mpjc5RyLXRl57mHMaXp0=;
        b=abskwHR+JgZtzhVbWZXWfX6uTeCFONTsUyEC5x8NWelVIYB7mZ1M6crdX4UHiu+O++
         JNzQkOQoUxshDwqkgkhQnGlWjLbSCQTvz/sCRYcgPzTjzJkbCttdJos6PfxGj6ZPkthM
         AzbboJfYuOVcZ/Ne0880/ySrNc67DkA/HpzLxll/6ByHm0KJvWwGSNkFwzrMegpM7j3f
         m0T68DSwFwAQ6WpgmvBQWr1SfGs6M1RHBf+s+TNpLC0vmsjdIDhgdQc+vSWL6NN405pX
         p6HVHS300ntlE+u6pOv5w2CsRjFRz+1KeAB9c3TIZMKfbU8Z0J0WIH/9T6oCyeQDccm9
         kDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708702522; x=1709307322;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MK6dDwiB3ZrZ3H37ABX4rh9mpjc5RyLXRl57mHMaXp0=;
        b=WvIrnVTFXRGxM0Jt3gxEna2k65MNwOGpiYo2e2MIewsrz/7GhJOq8wkVv4aKvtr3TM
         qiUquKbzEfrY4sAH7ikqpsFkZYInCU2ItaOFTl9YIpjP9t7DIxO86BhaDF5mTNcFgyn5
         J9IlWzdTYScNNL8DX7gCVT5EMRu4cuYpz2/00xHgqbRKVCTRUKgdmv0jqc1tA2Lw/lwd
         V8SnkR0LRfEJQrnSDgkKS7zMfcwnf3mPuDl1/zGZm3ZImkohewq5e+OV3+vQTZpp/lZn
         8hlRzz9RZmCkAkonGVwqxO75XLnvl2jY6z1nne3/mHvJW07uy3Leq335cTjP8FxPPIoE
         cCYA==
X-Forwarded-Encrypted: i=1; AJvYcCW9J5SyXKcoVPVoR6f+T2NtsVejalCSsGo5GK3HfAHxV0w3rIEgHYAdmy9KZNpGq5vSMMnzRFvxrPYKkPCRBqfkbvx9PlvGpxPN0PSpCtcUcVFWtDZY7BmmiwI/L4cpoO1DTh+dDCK+nx7AwhOZzcoED3T1e97RLaeEqesbv8LcjtSZkDIJaVUugk/dkI6zBRvngxbqmESOQz/qiIXBcv5PLVAgDrg=
X-Gm-Message-State: AOJu0YwI0oc4TvWsklsgqMfiIC9ARAba+d+mjY9wvLKeNQLUVQb5udzY
	MCVyW6IDcHVRJBimJA2fHEO3Tk/Mujs7nuzGRBKUCnmmtro78hdx
X-Google-Smtp-Source: AGHT+IFEM/soxWfQoKXx3QMSwZcKetXJTH+EFcrwlfV0CLAETQZh68TaytBVM9F5G8Wef91zbJl1fA==
X-Received: by 2002:a17:906:4f13:b0:a3f:cc6:57dc with SMTP id t19-20020a1709064f1300b00a3f0cc657dcmr68689eju.56.1708702521582;
        Fri, 23 Feb 2024 07:35:21 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qo8-20020a170907874800b00a3e4fc3919esm6047507ejc.31.2024.02.23.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:35:20 -0800 (PST)
Message-ID: <1310411e1224f6635ba5c70c34563a4b7fafd523.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 07/16] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 23 Feb 2024 17:35:19 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-7-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-7-1fb378ca6301@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:

[...]

> @@ -626,6 +627,7 @@ struct bpf_subprog_info {
>  	bool is_async_cb: 1;
>  	bool is_exception_cb: 1;
>  	bool args_cached: 1;
> +	bool is_sleepable: 1;
> =20
>  	u8 arg_cnt;
>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];

[...]

> @@ -2421,6 +2424,7 @@ static struct bpf_verifier_state *push_async_cb(str=
uct bpf_verifier_env *env,
>  	 * Initialize it similar to do_check_common().
>  	 */
>  	elem->st.branches =3D 1;
> +	elem->st.in_sleepable =3D env->subprog_info[subprog].is_sleepable;
>  	frame =3D kzalloc(sizeof(*frame), GFP_KERNEL);
>  	if (!frame)
>  		goto err;

[...]

> @@ -9478,6 +9483,7 @@ static int push_callback_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *ins
> =20
>  		/* there is no real recursion here. timer callbacks are async */
>  		env->subprog_info[subprog].is_async_cb =3D true;
> +		env->subprog_info[subprog].is_sleepable =3D is_bpf_timer_set_sleepable=
_cb_kfunc(insn->imm);
>  		async_cb =3D push_async_cb(env, env->subprog_info[subprog].start,
>  					 insn_idx, subprog);

I'd make is_sleepable a parameter for push_async_cb() instead of a field
in struct bpf_subprog_info.
I had to spend some time convincing myself that bpf_subprog_info->is_sleepa=
ble
does not have to be computed before do_check() in check_cfg(),
or what would happen if same callback is passed as both sleepable and
non-sleepable callback. These questions won't arise if this is a parameter.

[...]

