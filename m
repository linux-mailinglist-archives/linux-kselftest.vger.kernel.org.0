Return-Path: <linux-kselftest+bounces-6407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA6F87F362
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F461F21ACE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532B5A795;
	Mon, 18 Mar 2024 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhN3xtZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC255A786;
	Mon, 18 Mar 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802359; cv=none; b=rU7hYSeR9v7JftJkUAZvjtoDeVEhqnQgtjgbnWLuRP5egWSOUYb3QDk+ykqRBLZvGjElX7ZCm2d6BxpNG6TqCg5pXsQFXvdGMTRBBOkfapwWV/+a/Kbd/MLD3pN++FvfZFlbIj38MvRZCEyANv6v9UZ8Oeo1DDRA57QWUx/2NkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802359; c=relaxed/simple;
	bh=d8ENTjTWcVsCzBvWcyg0cn6pI2/9W2hfTSPfkGl9yqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8heJyqV1RVTyS/xODvHpcQfgy++yq9zw9aEzdnoT7BE1UKV0FwtrPE1pk6wRUxIFcrIYyaFTh6wTBhJPL4KpbkfdvnXhLTU0l6E+OPUgbWwJICiWU6+yNi/K/UtfabUozUUyz/BELlZBsLebCgtFLHdGaPOkI1XttECH1K0oH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhN3xtZd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3416a975840so1174790f8f.0;
        Mon, 18 Mar 2024 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710802356; x=1711407156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDVpvH3kaI7Vdha9XG2iONfusP79xsOJ6QJIxfHa214=;
        b=OhN3xtZdHZoq9MYxnEdRdYI0WxdDK2AiIz2Rir9etOvV1le+Jj/Sq70+ZQDWNSxkIW
         ukD0Vw6nbCxVlZuyuzdbA8z4WjhLEiD4D01Emo91//DHe4ZmyxMRCdDQeriEFOXUszld
         LfPXCBj8XamaokVKuZ7lGrJJawNYgPTaido8lzm+HQ2FSbVa+d6RAvV0J910blnQ6FD1
         znq6KxU2U1ExvNFlwtQA2dR947tgCKXKGTmjmQXNZU/mOTF7zKhyaFdSsfg2wmraDeOk
         rrA/BJFokCDJOEPO5bGf3hm/4yhr9NBL//OtCqqE4aQEbPXvSuvs/L7vOrhLlcxtL3qQ
         O46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802356; x=1711407156;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDVpvH3kaI7Vdha9XG2iONfusP79xsOJ6QJIxfHa214=;
        b=VN4miZhIUGDh9zVnhyhkX/ofQU72zv0Eon3qnovCKMOUBFapgGn/bpi2gdLiyUu8Jx
         XdutIPppw70D4lQP6NGP6CTYiorVMwB/JKLguN2ykX3vHVLQRAZMduQlLbhqKMBY+IzL
         LYs1Q/ltLl0TEV3Lv73tcMuV9UkTf2mR6QuZjHtNt6/U7G4rc8dRwgTwpWHaCQQxzn04
         wEZN+Ffoln7smjblRSQie3ROlEB/ucfTRwp1BMtQojNTbaBB2qPFouMaM11RhA+oH1zl
         a6PmmAOJNjpPysia7lDket715FaDYxPrJCl9aFSrPTpzT48tKsVzEHaRoXMw5dmSXecJ
         cFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM8tBBb/6mhj6hcejXjl2QyBeDKEQ5b5VSaebZK3dwstyahu+wriI9O8gQDNRDQ7chxDehWZh/qILVxsgneqNfE3X6k2GvQHN7JI5VGgWW/t0fczPYYjZ5gVprx4UDtk0KJijnnApib93t/p44
X-Gm-Message-State: AOJu0Yzi0dObV58s0IKIp9wEtvZW9aftawa3vd298OHitgUNqfvKv+yf
	CA/2RoaaEBFvxxjkIpCyijgoy5qRZYmc7v/mqtOiUXG+sUbFE34U
X-Google-Smtp-Source: AGHT+IGYHVV6iNA52cUhhV9tsoy/msDnvWt2qBbnEVgVLxYcFmpA4/NVXUD8b7yDOoLka4qtB5yW+g==
X-Received: by 2002:adf:f38c:0:b0:33e:7a1f:5824 with SMTP id m12-20020adff38c000000b0033e7a1f5824mr9524431wro.0.1710802355640;
        Mon, 18 Mar 2024 15:52:35 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id k7-20020a056402048700b0056a033fa007sm1549937edv.64.2024.03.18.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:52:35 -0700 (PDT)
Message-ID: <70ae8d7d2ed950466a61d118f59c16cb07fc9688.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Tue, 19 Mar 2024 00:52:33 +0200
In-Reply-To: <20240315-hid-bpf-sleepable-v4-3-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
	 <20240315-hid-bpf-sleepable-v4-3-5658f2540564@kernel.org>
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

On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:

This patch looks good to me, please see two nitpicks below.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1350,6 +1358,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern =
*, timer, u64, nsecs, u64, fla
>  		goto out;
>  	}
> =20
> +	if (t->is_sleepable && !(flags & BPF_F_TIMER_SLEEPABLE)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}

Nit:
the BPF_F_TIMER_ABS and BPF_F_TIMER_CPU_PIN don't affect
sleepable timers, should this check be changed to:
'(t->is_sleepable && flags !=3D BPF_F_TIMER_SLEEPABLE)' ?

[...]

> @@ -12151,6 +12175,16 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		}
>  	}
> =20
> +	if (is_async_callback_calling_kfunc(meta.func_id)) {
> +		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
> +					 set_timer_callback_state);

Nit: still think that this fragment would be better as:

	if (is_bpf_timer_set_sleepable_cb_impl_kfunc(meta.func_id)) {
		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
					 set_timer_callback_state);

Because of the 'set_timer_callback_state' passed to push_callback_call().

> +		if (err) {
> +			verbose(env, "kfunc %s#%d failed callback verification\n",
> +				func_name, meta.func_id);
> +			return err;
> +		}
> +	}
> +
>  	rcu_lock =3D is_kfunc_bpf_rcu_read_lock(&meta);
>  	rcu_unlock =3D is_kfunc_bpf_rcu_read_unlock(&meta);
> =20

