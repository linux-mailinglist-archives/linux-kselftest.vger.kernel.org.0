Return-Path: <linux-kselftest+bounces-23841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791AA002E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 03:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E331630F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 02:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE517D355;
	Fri,  3 Jan 2025 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiU7Mv2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFD43173;
	Fri,  3 Jan 2025 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872841; cv=none; b=c69AEC9vou4JOKvcAlhSlayEhsAe/uojsnB/LKqnUckPrxO2pWVBYLaqBf+i6odsrUADgUoQMJ6hbsCdpUIEplnjOMPLcGCyhj7WME7CDNI2DGsbbSAGdtbPeH5tLz746sARf709/TG4Zr4shQhr9Klt0A+KfD2CS8PzbCKIoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872841; c=relaxed/simple;
	bh=VDp/SbqU6Bc5HTFEiWi10wqkHyN/W9x7kql2qAqjTEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzga85DEToZcgNj4Zv1dVLwyzqAADR/mIoR/8OgBNUfx4Vr/1kpqaGbaaLfLjSTYAvYR3vySw3tTyuP2h7HhSbMABl28MwzQ4ogoEyBvwpduSUqmjUvWVV/xCrUtqD+DqQS6yYg4miRbEGE9l4vgRIDWnIUkGZFqtHKl1v2fxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiU7Mv2X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21644aca3a0so83897255ad.3;
        Thu, 02 Jan 2025 18:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735872840; x=1736477640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gezj6yBh5CN5EwIe+NrefENqJzoWnwHcL38luBqMvho=;
        b=TiU7Mv2XdEME3JWus3G0eArjuUiCMul851I+TegopYgKC0toFbaU5nX0xOXNQmiIV3
         KOSzzLMyhIDWHpSX93EkV1JlA/G7cxsU0vmtrB65dkWF1y0hhc4QRIqYV1igdh8Vr002
         DkSBqpuXmE+TzZhxieEGWuQgGi+J+kxFgK53eKHCVCaKLmF3RetGLrIZ2TJJAO81EiAf
         mOVLyV9xT5hpROcK7C6/RP2y9CaTDQhMq5bTEkHXojgI6wIUN4a9Y2uyxFd158JBAa6w
         Ds265N1UKnsqTdhv0OWfoul3TnOCJaftaYzEcapYO/dQthgXpiFoJt3vXVua9cuKvcNk
         NhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735872840; x=1736477640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gezj6yBh5CN5EwIe+NrefENqJzoWnwHcL38luBqMvho=;
        b=D05qhAbg5o5fAshgPxUwoqVIG6ZLs+ogEjj6iFOl/DpGJKXsgxINvlubbqGb82c3X4
         vn4SThHR3TtF706EQdJ9KL28Tax5tgxVba80xBSCdEUdj1tUCiimFWbHsa4eaCUgVLhu
         UuqDBLE5z05FVxuacuDaxwMWvbEwTyx9Anl4lOsXu1hYXjmgpWBHCqt6Bdi+yaSI40gW
         91t0ym8Ulbd0xEGoNwKBezVuAg9bzaw6S16iUUoO+VKizwgliLynGP/H1kjP1EWJvcnZ
         rneEucxZmiC1vFJcBszwF57q/W3zOHDEP+hM4bPebSUMGTtBuIUvk1ZUcXLufquCfKRU
         00sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjzGeuJlQ94/D/r5xFH5FPrDxBmhl1LpEbcfKDo9sbn5MuL93oxZQNg2mthD5znF0enx7SUBHT315uo75y@vger.kernel.org, AJvYcCWUeRLtAV78ULZHiwEmUeMnbX5DehpEDWXXvL+PS0ag4CsVBoABpH8aTIoB7cO9oB62S6o=@vger.kernel.org, AJvYcCXX3B3eMiGUw9dk+5G1lboMrDbJ8zj8PTrcINT+/gx7W2K2/aEDdcIA9YNR93nshe9ISlpZcxDfBDL9q13badaK@vger.kernel.org
X-Gm-Message-State: AOJu0YymRWBBlAL6oxe03ewdiuntEMXFJtMZ8IawIaCpm4WIjYWKt0CY
	3MhGO3CEKBrWrS4FVai+PwqIiHSLvb5gcXg7igMajtp6CN8bskXq
X-Gm-Gg: ASbGncvDfTJnB43WjSWjbzlutbeoATlqHFFWqIbj8scE1b0c8+pD9fhVFBYxhhxcaY3
	9Lj0LD84kG0aHlcCdM9b+cqfMBdJrATQ48QBFoeingFRqeftLnMAYh/jALJGPpojzEYCnrHWb4f
	VjFtud3BIKs6+H5JhAV5TXZJAgjlj5oIoNt3X3JV2mNyhcXGpZEqAHWjCnJiY7+ljYKegf4NCdg
	QnNrJTYCB6mrQcQvt3kM3axfaoPA3h5i+85231dnLRg1TPukTB0ZQ==
X-Google-Smtp-Source: AGHT+IFknURbcsfIZv/zekTR0dGCqCn53wCMhaZv/CVIEW8VMdCo2ExOmdt+7WMTMpYnMg326dVNbg==
X-Received: by 2002:a17:902:c943:b0:215:72aa:693f with SMTP id d9443c01a7336-219e6e8bb89mr730697355ad.9.1735872839661;
        Thu, 02 Jan 2025 18:53:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eae7sm234978635ad.85.2025.01.02.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 18:53:59 -0800 (PST)
Message-ID: <478322da282bbdae28027967ff47bfe2504559fe.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org, 
	shuah@kernel.org, daniel@iogearbox.net
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 02 Jan 2025 18:53:54 -0800
In-Reply-To: <86213ea40c6e6a30bf8ba967da9b9c4c6d77fd0b.1734667691.git.dxu@dxuuu.xyz>
References: <cover.1734667691.git.dxu@dxuuu.xyz>
	 <86213ea40c6e6a30bf8ba967da9b9c4c6d77fd0b.1734667691.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-19 at 21:09 -0700, Daniel Xu wrote:

lgtm, but please see a note below.

[...]

> +/* Returns constant key value if possible, else negative error */
> +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> +				struct bpf_reg_state *key,
> +				u32 key_size)
> +{
> +	struct bpf_func_state *state =3D func(env, key);
> +	struct bpf_reg_state *reg;
> +	int slot, spi, off;
> +	int spill_size =3D 0;
> +	int zero_size =3D 0;
> +	int stack_off;
> +	int i, err;
> +	u8 *stype;
> +
> +	if (!env->bpf_capable)
> +		return -EOPNOTSUPP;
> +	if (key->type !=3D PTR_TO_STACK)
> +		return -EOPNOTSUPP;
> +	if (!tnum_is_const(key->var_off))
> +		return -EOPNOTSUPP;
> +
> +	stack_off =3D key->off + key->var_off.value;
> +	slot =3D -stack_off - 1;
> +	spi =3D slot / BPF_REG_SIZE;
> +	off =3D slot % BPF_REG_SIZE;
> +	stype =3D state->stack[spi].slot_type;
> +
> +	/* First handle precisely tracked STACK_ZERO */
> +	for (i =3D off; i >=3D 0 && stype[i] =3D=3D STACK_ZERO; i--)
> +		zero_size++;
> +	if (zero_size >=3D key_size)
> +		return 0;
> +
> +	/* Check that stack contains a scalar spill of expected size */
> +	if (!is_spilled_scalar_reg(&state->stack[spi]))
> +		return -EOPNOTSUPP;
> +	for (i =3D off; i >=3D 0 && stype[i] =3D=3D STACK_SPILL; i--)
> +		spill_size++;
> +	if (spill_size !=3D key_size)
> +		return -EOPNOTSUPP;
> +
> +	reg =3D &state->stack[spi].spilled_ptr;
> +	if (!tnum_is_const(reg->var_off))
> +		/* Stack value not statically known */
> +		return -EOPNOTSUPP;
> +
> +	/* We are relying on a constant value. So mark as precise
> +	 * to prevent pruning on it.
> +	 */
> +	bt_set_frame_slot(&env->bt, env->cur_state->curframe, spi);

I think env->cur_state->curframe is not always correct here.
It should be key->frameno, as key might point a few stack frames up.

> +	err =3D mark_chain_precision_batch(env);
> +	if (err < 0)
> +		return err;
> +
> +	return reg->var_off.value;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn,

[...]


