Return-Path: <linux-kselftest+bounces-23295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256BB9F035E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 05:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D33188B233
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E017C7B6;
	Fri, 13 Dec 2024 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba+oFRq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732317BB34;
	Fri, 13 Dec 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062693; cv=none; b=KQTdGwRH2cJRE3CLkIP3Zb4UqNmrAJpzjOqN6sPGSX7zJWgFVWiAdDvhegoecbxQ0kO5WNkJbAJcnje1m0bxb+f6eGKNrjEi6ght0c/vh9st59h1Yhsc5YLjspJllb0wvU+5RC2YOxNuZcDjubzfBD7XI6EnHF0K2bcI/C2cUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062693; c=relaxed/simple;
	bh=VYEwYTh4meAMKcxZgF3yTMcdoRqjlcIbP4/merjlEv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOJq+B5CfoDEpp/hFhoVXfU402L0pA8Ar1gNLAkUaLqmTAYOwVRzZYfSzIiV8lqRib9Sb2NQHAxfRkPO/l//YNDmj6eTxDv+KGOvRKll5NPeJuM+FiGu76joMG94O/XhB5BgzF16MGaOOjuCZoMmEwjF52XLqaTLzmcI4f+IAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba+oFRq6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso10334985ad.3;
        Thu, 12 Dec 2024 20:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734062691; x=1734667491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pTTUiqA1JaNZpV3zkUZn5BbgQBGF1lbLwZtKk2rpqZg=;
        b=Ba+oFRq6JHBt0aVVT4+8qtekOFDooz0UYXArMw0vCu3zFWwwr8j7f7vyyyFsrSjwfv
         maqsNo7jH+NaEor+jexXyBhKUvZbgWt7jTiiMzPGuQNFX/Soyi1a6NDofwwCVT1TPDFJ
         S883OcwiqWTEu3c85jOqyejO+4P9BasgHzSUXnsOP1c0K0ZSsKW9l4GJaIo+LV1SpKOI
         MNQgrEmSJJuxaWsq3jkkHofs/fATVUNHIXlkD47U7WfHFqshl7Pg6vvzpdgtF42gqRSC
         U1R6ORydmL2ZSsnnNFWG3qRVeQR+OMssCRb8UhZBCZ1048mDh7ZroaBDAd9Inpdq2GNR
         RwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062691; x=1734667491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTTUiqA1JaNZpV3zkUZn5BbgQBGF1lbLwZtKk2rpqZg=;
        b=tRqL6jzeOr4dR/7aCbRYZaG/1HDRb+wPKLgqV3jeHcvwUx5DdwxXFt6iZLETZPTOau
         431GXAQWZlGbEfI1iK4xBvTiWZv6w3YMPzChqbglbn6GBMc9qQfzg/h2LFZeCH2WA3cF
         32y1hLwUrAoSmYC7N6Bl9hf6e11mI+ebCDu3aZSGeceSsuS0gk+jpU3aAKB7smMSX7z0
         SsZhkd6OCGWKOtE4TDIJk8FE6/oux9/+v2IIE86h4zT24WlmMYBZ6lCTxZceHuBsz5UQ
         ZERC0JtlVt6K52YSQYMYiTR4/3TQoprO76izGcU2CRMAPLfym7vOGcEh33GIUB34Hzhb
         gpGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAql1FDTM1fIaQwAIddXXAdXor2AMd9xXEpZLGTCOf3MofaIpq1qrZKdq9VSDbw25VPvGFtwlW7xzeDsD/sQgS@vger.kernel.org, AJvYcCUUQhxaLz1ZIIRDcmIGfX6mo/qFFiW26StZtAYMwKj7bfnNzDT4omMe6JlWnPWABBUtPBo=@vger.kernel.org, AJvYcCUsNbpYCWuFQnieihqf1Fg758oAoeYRjGilrOiswd5XoM7U90Go1SpmY0c97qjTBy6ahw0qw20tFTaqHSXp@vger.kernel.org, AJvYcCVBt5JBhy0sjAwJXNGnastDxrcfUUqcdkArt+DMh9XqsThjQcBn0sLsZLHMLVq/+Jn6xkJtMrR+@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRF+qvEQa3s810xTLM5zWF4OehNAJI5aM2rDxHm0cWKGLeh/U
	iImTGS4XuOPLGtPcrHM7UVLtbtTNjZ6OBzVj44/5yAzt0n9gbovq
X-Gm-Gg: ASbGncu4uB6MTWclx8WIzkRjaRBEWs8Tsm8MhDIaLNN+Fh8XD6xCsi5MC+6FiZApZwP
	s4IPc1j7Mw/MB6mgVSVa//nHVsNZUKxvSOs/FKfQv/QVGmrlryymfzP2Eq3xUZA17WsioPLTOmg
	JiglTj8SJf6vUJHIhU/i0FaOGgYy2XCsnEV7owdP52cszizic1Ag90uuOgF2y5L29wwZI8xZcQf
	za+CR6TKl4OOH8Gv/MURelbJ5zKwuUGRbXH7tF2wAMaWFAKnZhzew==
X-Google-Smtp-Source: AGHT+IEKy1GALG5iBgebmvW+KMj+zATRP8zpKqCAK01KBRgfIQNZW1RurQVztjBNlutr98NGSOSlrg==
X-Received: by 2002:a17:902:db04:b0:216:414e:aa53 with SMTP id d9443c01a7336-21892a42244mr16122635ad.52.1734062690694;
        Thu, 12 Dec 2024 20:04:50 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4cd45b18sm7777975a12.73.2024.12.12.20.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:04:50 -0800 (PST)
Message-ID: <1b0e59ee87b765513c6488112e6e3e3cf4af7cb6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org, 
	shuah@kernel.org, daniel@iogearbox.net
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Thu, 12 Dec 2024 20:04:45 -0800
In-Reply-To: <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
		 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 16:22 -0700, Daniel Xu wrote:

I think these changes are fine in general, but see below.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 58b36cc96bd5..4947ef884a18 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -287,6 +287,7 @@ struct bpf_call_arg_meta {
>  	u32 ret_btf_id;
>  	u32 subprogno;
>  	struct btf_field *kptr_field;
> +	s64 const_map_key;
>  };
> =20
>  struct bpf_kfunc_call_arg_meta {
> @@ -9163,6 +9164,53 @@ static int check_reg_const_str(struct bpf_verifier=
_env *env,
>  	return 0;
>  }
> =20
> +/* Returns constant key value if possible, else -1 */
> +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> +				struct bpf_reg_state *key,
> +				u32 key_size)

I understand that this is not your use case, but maybe generalize this
a bit by checking maximal register value instead of a constant?

> +{
> +	struct bpf_func_state *state =3D func(env, key);
> +	struct bpf_reg_state *reg;
> +	int zero_size =3D 0;
> +	int stack_off;
> +	u8 *stype;
> +	int slot;
> +	int spi;
> +	int i;
> +
> +	if (!env->bpf_capable)
> +		return -1;
> +	if (key->type !=3D PTR_TO_STACK)
> +		return -1;
> +	if (!tnum_is_const(key->var_off))
> +		return -1;
> +
> +	stack_off =3D key->off + key->var_off.value;
> +	slot =3D -stack_off - 1;
> +	spi =3D slot / BPF_REG_SIZE;
> +
> +	/* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE */
> +	stype =3D state->stack[spi].slot_type;
> +	for (i =3D 0; i < BPF_REG_SIZE && stype[i] =3D=3D STACK_ZERO; i++)
> +		zero_size++;
> +	if (zero_size =3D=3D key_size)
> +		return 0;
> +
> +	if (!is_spilled_reg(&state->stack[spi]))
> +		/* Not pointer to stack */
> +		return -1;

Nit: there is a 'is_spilled_scalar_reg' utility function.

> +
> +	reg =3D &state->stack[spi].spilled_ptr;
> +	if (reg->type !=3D SCALAR_VALUE)
> +		/* Only scalars are valid array map keys */
> +		return -1;
> +	else if (!tnum_is_const(reg->var_off))
> +		/* Stack value not statically known */
> +		return -1;

I think you need to check if size of the spill matches the size of the key.
The mismatch would be unsafe when spill size is smaller than key size.
E.g. consider 1-byte spill with mask 'mmmmmmrr' and a 4-byte key,
at runtime the 'mmmmmm' part might be non-zero, rendering key to be
out of range.

> +
> +	return reg->var_off.value;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn,

[...]


