Return-Path: <linux-kselftest+bounces-18320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9515984B41
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF00B22A55
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5431AC895;
	Tue, 24 Sep 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdEafUwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742C1AC880;
	Tue, 24 Sep 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203481; cv=none; b=py36uPUW91JTGk2EjEpkDSYbaukWOhCWAz+oD6pWcl49b7DwXwdvQF8Gh9bGaI8RsLZL/pRrdycErogZdTvKMXxxnd+cr0w6o1547dWoQGFoExbCxI6ZIOVpL6ZgwQ5PEvEHYiuDi/y73a5I0r1b1kfUp+qo9zxUeuccbKivSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203481; c=relaxed/simple;
	bh=m+/VvRQ+++wCtbEd9ey3Gz7C1C/Zkqpv+B5faIBfK0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aQwum0Uvqwp110CIhU2oyOvAPJ5GeX4eePHLAj4tCopB4bPTzQCnhNGoFeo0yEeu/l3MJbwZ6rSzhzzDIhBKl0u5FeCSg2vMNn+vDmwfCFwEiGX4ls3f8JMXdHs8O+vSDaDql4wdFCmRDCCz8TrNJxA14s6i5Yjfzvs6FEsd7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdEafUwB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso4111441a91.3;
        Tue, 24 Sep 2024 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727203479; x=1727808279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q1TSmoyn8iXw1Hwv/qLhBv9Dztb3b91fPaP0YK6BdNM=;
        b=MdEafUwB9MdSyi+5yDkzRNixkanje/AL56lUhR9pCwynp5LSK74PsZfaRymRKoJLWj
         GTeG7Ic/U1XPmHrVQQI2L+0oPCWicj1sr96+6X7Gkjm40XG0TOpKQaT20rEk8rniIH+n
         n9YzAEfuuV7xisvgHRy/x/3eF5mWXol8iPodNaSIDTsaTGz/ugFrnd1SmpfpqWC6SWDB
         YcS6aeYuyhQZqFUrpBAlsQhHhlgja4CDyBSTvvhaLVBZR7d9OfQXOUOy1RJceAhgqlHj
         taKV9EyJgCUGznIS78p6KH+qd3Y7EyYawC3FExodcz9zsdPXci7e1QOyH80LgPlcuRFG
         uvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203479; x=1727808279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1TSmoyn8iXw1Hwv/qLhBv9Dztb3b91fPaP0YK6BdNM=;
        b=sUqVZkZOX5omRwN6boDnyFS6PnrQn3Nc5Eo+uJuZ83JS5Rc4bH9usAM2aaPqij5Lpd
         QYOlSIGNydb/s1p4Yce+5CD5VU13xYq3MtVxw3XJXJiOmcAGvD+/KcnmDBkUfStLN0/M
         iIiPKNzSq5h+kcxAGumMRI0r/jnqvwsWsLhjp4tp5W8iM00YoG5ULIpR4XFlsJDwfc8y
         zdWksIzKq1IhiYDPers5TJUYUJ6Z8cRg3FzDsMd2BShvZfBoEr4lkjG9OchMKaaPSED1
         3oS9K88wZIFR/mAKM0nLJOinB5Eo4W8VK1WonoTGcAnrKRo79+OC89JVQmiqY0vM6lLs
         joRw==
X-Forwarded-Encrypted: i=1; AJvYcCVXtBJgnolDXKpDc5hfrrfiCHd9M4vtIzFWrKxMch6iC//F8GDUE5imOo5WF49g6iRKLV0=@vger.kernel.org, AJvYcCVuZ8iyqSP1C2x8g19SDev877PPPE2J0QuPsQGe4AFtrYUGOTBSKBg9LIhN+zLLCBnQQ1RbDeuQluHyb2LRZW6S@vger.kernel.org, AJvYcCWlNbFTeL6FJTI/kP2WBtEUA2+TfxbGvP9kVT6HJG/F8smbLDIZcrlFrioMlSR4bfyBMDZwTyfrOfA4VKjm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iMmo6ZvyuRrFWtOAAm/5YGQK8e77LvKtCQG8XfPiN2be7GYV
	j/iZHUgulsfJbwagyQt0x4NsbCkarv7GycNCb8jffZEtPX0y9m+7
X-Google-Smtp-Source: AGHT+IE0VymKndO2jnvRjxP3110G2PKk/L89WWltJ4sm3Qb6iXETmYcoRM6hJuqYAODg6uZeBcco4A==
X-Received: by 2002:a17:90a:3d86:b0:2d8:8509:85cd with SMTP id 98e67ed59e1d1-2e06b0074demr73099a91.40.1727203479168;
        Tue, 24 Sep 2024 11:44:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6eecaea5sm11710719a91.34.2024.09.24.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 11:44:38 -0700 (PDT)
Message-ID: <b9012c196537e64fb148232de3f97053891c1de8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, andrii@kernel.org
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com,  jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@meta.com
Date: Tue, 24 Sep 2024 11:44:33 -0700
In-Reply-To: <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
References: <cover.1727174358.git.dxu@dxuuu.xyz>
	 <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 04:40 -0600, Daniel Xu wrote:
> This commit allows progs to elide a null check on statically known map
> lookup keys. In other words, if the verifier can statically prove that
> the lookup will be in-bounds, allow the prog to drop the null check.
>=20
> This is useful for two reasons:
>=20
> 1. Large numbers of nullness checks (especially when they cannot fail)
>    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> 2. It forms a tighter contract between programmer and verifier.
>=20
> For (1), bpftrace is starting to make heavier use of percpu scratch
> maps. As a result, for user scripts with large number of unrolled loops,
> we are starting to hit jump complexity verification errors.  These
> percpu lookups cannot fail anyways, as we only use static key values.
> Eliding nullness probably results in less work for verifier as well.
>=20
> For (2), percpu scratch maps are often used as a larger stack, as the
> currrent stack is limited to 512 bytes. In these situations, it is
> desirable for the programmer to express: "this lookup should never fail,
> and if it does, it means I messed up the code". By omitting the null
> check, the programmer can "ask" the verifier to double check the logic.
>=20
> Tests also have to be updated in sync with these changes, as the
> verifier is more efficient with this change. Notable, iters.c tests had
> to be changed to use a map type that still requires null checks, as it's
> exercising verifier tracking logic w.r.t iterators.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +/* Returns constant key value if possible, else -1 */
> +static long get_constant_map_key(struct bpf_verifier_env *env,
> +				 struct bpf_reg_state *key)
> +{
> +	struct bpf_func_state *state =3D func(env, key);
> +	struct bpf_reg_state *reg;
> +	int stack_off;
> +	int slot;
> +	int spi;
> +
> +	if (key->type !=3D PTR_TO_STACK)
> +		return -1;
> +	if (!tnum_is_const(key->var_off))
> +		return -1;
> +
> +	stack_off =3D key->off + key->var_off.value;
> +	slot =3D -stack_off - 1;
> +	if (slot < 0)
> +		/* Stack grew upwards */
> +		return -1;

Nitpick: I'd also add a test like below:

SEC("socket")
__failure __msg("invalid indirect access to stack R2 off=3D4096 size=3D4")
__naked void key_lookup_at_invalid_fp(void)
{
	asm volatile ("					\
	r1 =3D %[map_array] ll;				\
	r2 =3D r10;					\
	r2 +=3D 4096;					\
	call %[bpf_map_lookup_elem];			\
	r0 =3D *(u64*)(r0 + 0);				\
	exit;						\
"	:
	: __imm(bpf_map_lookup_elem),
	  __imm_addr(map_array)
	: __clobber_all);
}

(double checked with v2 and this test does cause page fault)

[...]


