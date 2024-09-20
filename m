Return-Path: <linux-kselftest+bounces-18186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11797DA7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 00:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C8C282D16
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0F13B58C;
	Fri, 20 Sep 2024 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfWUoVDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F971EA6F;
	Fri, 20 Sep 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726869944; cv=none; b=R8FSO3Ip4rpfvTND4jEJuqVBvfkp1yFXvbiL2qJFQ8ZEFpwxTZWRTF8EGc685NLMeNyF6H4foKFHLziEv9rnwZwTix5zeM3t718lf0wgMH+YvXuF9Xd0qwb+t5+q0t8GoWl+9z0YpFJqoee0lD21Oz6FKvxTkf4RX/uDMJtCRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726869944; c=relaxed/simple;
	bh=H/4w5FLbbZLWbGyLRGOT4UzmyRmBUjq6fzlFcWlHc2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijMOZSC7E9d14ZfP14E1F3wqFNFalgF9tTFpp8Xam0ofzfCzMairEYBdOlU28Cxn3WsFxKgviRq3gq0RPmo6+3Y1eogwDN674aszXp3rp9OvAKAIqjKV+qVn1RpAAoQ6SFHhFaKMkJnNjx9t2tLZ5M4qLhcDulVWQzVim6be/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfWUoVDW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2054feabfc3so24987145ad.1;
        Fri, 20 Sep 2024 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726869942; x=1727474742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5wq1lw5wjCE0kL7PAoVymCcvATcPRjXhjMM7XRmRKc=;
        b=jfWUoVDW4VxqbbeCX7M+WuPNJY/7IAr6i8ThjH1QXpmnev+KR4++8PuSyFFDw+gAIH
         1+nPiDsD5bGWHGZ2qPRSDz1vlrorF173zXrdju1TLbT+9GIvlw4AEB2947tAn2QoCizz
         1NeBb7tpTYIsIBuT6nClRXPe3kriHLg0Gmxu9kQFSDDNmSC93QJxICIkHY6MEAw0R4xd
         fL9cdsoCDCP8E5T3UigS+DdUPvsMGu+oFRkDdp4gRApRa8kfgTUiOGt7v9orQVNjR/S0
         Ay0PJqthTmmRrgjCyJT1mSsHb+rM+JWhkLJ66lZfN6ZSOkOd6bRyadb5uwgVpx/M+sk5
         PftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726869942; x=1727474742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5wq1lw5wjCE0kL7PAoVymCcvATcPRjXhjMM7XRmRKc=;
        b=JdXK5eDMKGDbQsnue/BIe/3KQAbCBYZ5FhXScZafqQFYRa0rIdFIfUghDUU3pgcPpe
         70GlQ5yylwp5uTSkfT+6UGy9uvoGHR75nSQzmgjtLtOOe/z//LrLnzOcGcSgM2PrAC/4
         KdbV9TbkJJF5x0OZhCD+ILQeTe1QJacPg0YypXiBNzZn0Aj0+q0m2kVRbMLoTjG58x+r
         uLtvSBEbQNXSN9gplCBg4gCJBTwfUOZ1keb3G2h7ksBggQn1LUn5fyecmZueeRQ2lh0a
         l79+JNiPi55e4DBC6GSWd7oF7FDMi3RimvBZ6JHK6y+IoCLOciDS7JCy96LqM+RnIlG2
         XmGw==
X-Forwarded-Encrypted: i=1; AJvYcCU8YzBGLlE9G3db5z2NSxW/pyZBLPa3XzaBrUBwHVSb9Dgf8AJk/vXR5JJuksgUuMonjLJ5SY2XyHxG1/yr@vger.kernel.org, AJvYcCVDXm8+2AeD1kfZv6cbqrBuiTc6G4OxjfiluUy3eID215HSQafxSpd+F9eH0LvcyVCtPP7FRc9oJxhCAKUmDslL@vger.kernel.org, AJvYcCXkTQveX8r66/Kg4KzSh/rdsPQqNWWYQcbnlQaeSyg/uOZYO6hvEn8xQUl4PYgoyhze/2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYu+YKc3XSNx64xsVNWlQrwe6b+LKA40PmeJlQIKtTZ9f0Qq7
	ok/qBMFMsQuUDpDYKeRNbQR6AQzXsaeBJIiC0ollGzPL3Jq0ckli
X-Google-Smtp-Source: AGHT+IFZCO+86n9yLwACZAASLlSETdKiO04pznmV+OUnNrKBUc1gUnlR+6lIG721pm3BYGECCK+DWg==
X-Received: by 2002:a17:902:f546:b0:202:301f:36fd with SMTP id d9443c01a7336-208d980bfb0mr56320825ad.18.1726869941964;
        Fri, 20 Sep 2024 15:05:41 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d150fsm99236645ad.153.2024.09.20.15.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 15:05:41 -0700 (PDT)
Message-ID: <a1b7e902e6f8be05f7d42bf340484b64583e1389.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, shuah@kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com,  jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kernel-team@meta.com
Date: Fri, 20 Sep 2024 15:05:35 -0700
In-Reply-To: <3b54139f8d4877e0487daebdd799c3878ee27ed0.1726458273.git.dxu@dxuuu.xyz>
References: <cover.1726458273.git.dxu@dxuuu.xyz>
	 <3b54139f8d4877e0487daebdd799c3878ee27ed0.1726458273.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-15 at 21:45 -0600, Daniel Xu wrote:
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

Nit: maybe add a few lines why tools/testing/selftests/bpf/progs/iters.c
     has to be changed.

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
> +	if (slot >=3D state->allocated_stack)
> +		/* Stack uninitialized */
> +		return -1;

I'm not sure verifier guarantees that key->off is negative.
E.g. the following simple program:

    0: (b7) r1 =3D 16                       ; R1_w=3D16
    1: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
    2: (0f) r2 +=3D r1
    mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1=20
    mark_precise: frame0: regs=3Dr1 stack=3D before 1: (bf) r2 =3D r10
    mark_precise: frame0: regs=3Dr1 stack=3D before 0: (b7) r1 =3D 16
    3: R1_w=3D16 R2_w=3Dfp16

=3D> I think 'slot' should be checked to be >=3D 0.

> +
> +	spi =3D slot / BPF_REG_SIZE;
> +	reg =3D &state->stack[spi].spilled_ptr;
> +	if (!tnum_is_const(reg->var_off))
> +		/* Stack value not statically known */
> +		return -1;
> +
> +	return reg->var_off.value;
> +}
> +
>  static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
>  			    const struct bpf_func_proto **ptr)
>  {
> @@ -10511,6 +10557,15 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  			env->insn_aux_data[insn_idx].storage_get_func_atomic =3D true;
>  	}
> =20
> +	/* Logically we are trying to check on key register state before
> +	 * the helper is called, so process here. Otherwise argument processing
> +	 * may clobber the spilled key values.
> +	 */
> +	regs =3D cur_regs(env);
> +	if (func_id =3D=3D BPF_FUNC_map_lookup_elem)
> +		meta.const_map_key =3D get_constant_map_key(env, &regs[BPF_REG_2]);

Nit: there is a long 'switch (func_id)' slightly below this point,
     maybe move this check there?

> +
> +
>  	meta.func_id =3D func_id;
>  	/* check args */
>  	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {

[...]


