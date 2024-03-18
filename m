Return-Path: <linux-kselftest+bounces-6409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FA87F442
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 00:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5821D2826EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888855F870;
	Mon, 18 Mar 2024 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBoI8BDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C35F861;
	Mon, 18 Mar 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806082; cv=none; b=cR4x/avIEvb9AbNvRDmD3ev9b3TKY7f3uJwJra7BQmGn4ss7rdy9RbqWASjvItg0RtVaA0afoNXfuD82k7jKskFqCblhVF07todVuBpREL37p2oTHoevrzC8r2/ItyL312f4DUJnXIi//f84sOxGPUC83r2drf52ucQ64+41fGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806082; c=relaxed/simple;
	bh=2ampYUB3qmvgKnA422RU+89kfH3qiVaLbH2sevIcLo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nD+E75GWP1Nq89iwoo9Nx1eOEabqnhK/4dNurydJZ8Yk1XnKjlUpKUPgtHOp3guIhTVZselv9mEOzAGicyEZc306RIT8wpIyKApMsDosEMwvUtvRM9zautHCH1SdiU1K74dqN1JA7VXmB3ABEkN1B8EXhgHjhwSnhe+3nWANW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBoI8BDN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d24a727f78so57987381fa.0;
        Mon, 18 Mar 2024 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710806079; x=1711410879; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xsqudSCPxYDZb7vIDJzkGeBhlTUqtvhnvvGW1FIJAQA=;
        b=VBoI8BDNj/0XcIyEPIW4qBJ6ENa/RDVcGllGjTGtHxnZBA6uusLJHBcd6dkhDYWzjS
         rP2Hh206SPH3TIFGaC5T3BcwgnfJU+UyH/eS1N8VZJo4VHLUmzheYTU05WZvsCbh93He
         e7HnLVVILC+//9f8jcXqPAFNaeVPf2MFyLymCeeU/5y2B1ufzPczrYO51tNfxUYn+TWq
         Ir5V2vxGDsJ1MHf7mpKvqLde4rxFcyBktczsYo5UBM8CF7jYi6Im9bP8M9utTeY5DvqF
         X+FqHS8d8hjfsZn7M+F3WFu099AexrrNuocvHHSt7pPiJ6JTQbTFzFmLDXMhxTCs1sT2
         RrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806079; x=1711410879;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsqudSCPxYDZb7vIDJzkGeBhlTUqtvhnvvGW1FIJAQA=;
        b=bOzGF33hOPvRwmRfDHrc859qeYZm+9kRDKGBaW2vXeVeO6ZDebfPx3xYPahkF7j1MF
         o10wETCZTTvU72OCfk1tLO9N2EReWnct3hQyM3LAn900K+PO+zA/NYR/bEgnP++cs50i
         DahOy4RkDeH0OXzkhEmAbIGoZw6BfzjtKtGXcER+82S7hzKdZaUnOlD52vGRttGZNm/z
         i7qXKdABvwDIYAIrfT7mi930HRTF2hOOpt/nRgrVndNQMKXSHs1+tSKahLrImVeI4VJT
         fQm4xIxU+1boh0s5342Fq2KXR8NmGQJN4jT53Zc6VFViLUGIcgtI1G5iu21Tn1tOVXZd
         QlqA==
X-Forwarded-Encrypted: i=1; AJvYcCXw6vcHErWYZyGv+VSEaVbA4iic/cked4YV0pgSGxVukUVTlI2sQr1ILQB8UfhD+WlCZEiQ47ylN3j5eYWJGizvJ14bqEauo7wYYwJ7zZxi41peq2L1rVj8R+f0kxEGNvugG+memmoAOjDVNuVN
X-Gm-Message-State: AOJu0Yz/11x03ZQUsknGT1CQ+uQ/GXB87YJKSKXC1Zp1wX8orV09S4N4
	bdQdyM8xQeXK2+cah/ZbpvpK/FoPTpdnjQHSvsVtAMcRXFxERu65
X-Google-Smtp-Source: AGHT+IGu+JLoqo0gIozPOStNDZMLbGGn/PwGQf5p0HeA7JWQkGAltvBsa97RHkp5tDqPRcj12SbM8w==
X-Received: by 2002:a05:6512:3687:b0:512:f6a0:1311 with SMTP id d7-20020a056512368700b00512f6a01311mr8317091lfs.47.1710806078749;
        Mon, 18 Mar 2024 16:54:38 -0700 (PDT)
Received: from [192.168.6.255] ([5.1.5.0])
        by smtp.gmail.com with ESMTPSA id di17-20020a170906731100b00a45aa7cb029sm5340411ejc.36.2024.03.18.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:54:38 -0700 (PDT)
Message-ID: <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
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
Date: Tue, 19 Mar 2024 01:54:36 +0200
In-Reply-To: <20240315-hid-bpf-sleepable-v4-4-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
	 <20240315-hid-bpf-sleepable-v4-4-5658f2540564@kernel.org>
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
[...]

> @@ -5279,7 +5281,8 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
> =20
>  static bool in_sleepable(struct bpf_verifier_env *env)
>  {
> -	return env->prog->sleepable;
> +	return env->prog->sleepable ||
> +	       (env->cur_state && env->cur_state->in_sleepable);
>  }

I was curious why 'env->cur_state &&' check was needed and found that
removing it caused an error in the following fragment:

static int do_misc_fixups(struct bpf_verifier_env *env)
{
		...
		if (is_storage_get_function(insn->imm)) {
			if (!in_sleepable(env) ||
			    env->insn_aux_data[i + delta].storage_get_func_atomic)
				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
			else
				insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
			...
		}
		...
}

When do_misc_fixups() is done env->cur_state is NULL.
Current implementation would use GFP_ATOMIC allocation even for
sleepable callbacks, where GFP_KERNEL is sufficient.
Is this is something we want to address?

> =20
>  /* The non-sleepable programs and sleepable programs with explicit bpf_r=
cu_read_lock()

