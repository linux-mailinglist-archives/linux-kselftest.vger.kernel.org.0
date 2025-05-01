Return-Path: <linux-kselftest+bounces-32093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C692AA62BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC97F170589
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7F621FF46;
	Thu,  1 May 2025 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aufbs/s6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF692594;
	Thu,  1 May 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123780; cv=none; b=FOcV/QxD9Xa0iBkoEZIY8S8OCVWtihR1rMDz5fQmoZNvH6nltS7Bvj7Ot02MABuuR5MSYZNXyNn09Wh2xWk9NSZaKce7HHOQQFQ4nd1jXs0/Bl+wcCX2f/gpr1i35A8xB5TnpVOHzGWhMNUIPV0wOsam4QbU0riJC9OaoUJaEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123780; c=relaxed/simple;
	bh=ohnFrUmn3P2nrSp6z/go7hgYROwr7dUgd9JnY36lk2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/ypD9V/9/W3nJZRdA40Dfr61NYp+b2cG7KLrBJ/eFqJZ/h420bQlv0timTpDN3QpyGD0daUyyEyY/c3rBqo/Op0Eqxv29aH+EjrMqRWNbcoxgmCNKQ4l0n+zLRqz5uXCEFzWIB+AuJWn4ddin6NNtdidT8Kv4J34MOyaBdW+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aufbs/s6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2279915e06eso14897435ad.1;
        Thu, 01 May 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746123778; x=1746728578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z13IR4R41ZVDKU1pxRT6lsZi2hufZ9axj9XzCLqdM7o=;
        b=aufbs/s62dbVuxp6a+uESF3HKpVHkyJc2nPGvyZ0N1wMf/yXKCb6EfeTOa1vXP1j6N
         eHT+ugPRQQKqvzsPf8/UKvwSF1mX05EESV/KsUc64zS1w7Q8EDBwzRtIQmRkOP5Sj3A7
         qc5alm+y1+YTAMYFrd2oAAZC+aRLVSHiQ08IKsSYPKKuAv2//RxcNqHqaZMBMZhHgfnS
         FBugfkT/n5/MqIl5dC9YIQQgO2KwSPoNgflURq21k75eIkrXenfWlim4XAfGUbYP+nSC
         mt6Z1hy+voT+9eDbiEzL7eWi5JbOWdx7ZU0IzQhgR2sRGzsd1UlNItMM3lpc5X3Fbqsm
         X9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123778; x=1746728578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z13IR4R41ZVDKU1pxRT6lsZi2hufZ9axj9XzCLqdM7o=;
        b=PanMoqiciAo56uN1ewAFLZNwp4WlJ4krT4Gro8JN0AU1kqVNORCj9MtU/xpN6LY//+
         L04lzWMktc7Ns6pLLNmCfE4EFpdwbTTdxyo3yDMi9yGmTf6ugcrok0KCd8po1Tjrcr7+
         unnMOfqimRrqaHjpBrKqWZlvAeFCtarX5R40h4xZcxIADRIfHoBiFLlVvYGu9O+XnA65
         +w9UTXHHKLEe5aem6g1wK3ux1f2q1+UDSPLXjzngFerraJKPwy6wPGXDXo3qClGMFSi1
         ykKKhvghN1qRUxQDbhn9wv05z+rA1qmp0mQExf+/TyeuX9OBceEShte3G3B6MM8KFX54
         +YlA==
X-Forwarded-Encrypted: i=1; AJvYcCWIY9OwadfVvv5eQ5ZpexZNExh6rHmc2h3Kxxwa7XPXO0t9GdxOeC1eZd5wr/rWL9TSPRr0nBLonod1Gf6G@vger.kernel.org, AJvYcCWog7RDh6QGay3RbM7uEogilDUsvxXstzKzXu8ZRzIbITyGVXI3CGFNiLiRkBtg6vfstR3edYwJEbL+jWA/FYVt@vger.kernel.org, AJvYcCXe3ckk5GE9KJZBc1zc0cR9nou7mxxEv87cT7CSy3YdnbogyM+d4bsjjVB1a7ezdZTDrmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywje4hVaqmlPUZUwl0CuOVRia/80plsxujVv+GGO9BUkJPxNIvw
	63T05GiZ2tCx0MzX2ZKEvGdV4UyI+ebZq87BORSCuQxcn5zf/snP
X-Gm-Gg: ASbGncsesMx1uHa9Jx9VYswzdDCpvT/1N8W5wN/eRuaDt5qmgIdlj7YyQ3i+9MmDbjd
	f42jdlG47WaeaE5NR4n6YeuJoAvoc6A+m9GGa2HAhngyrlJf3Nnj6t0QUOI30dOyFBie2lyyzkO
	wp9JnGn/Guy1jfEnYEP7k1J+XoNKaK2wFov7sS2/eUvm/rSxluUFglkWboln7aDRfWw2UAG6o+B
	bn1w0jwrce00alKoikNTVnTtjWFS+ZPScEDiVKWZNLjjVLSAEn6AKToFenYMgcbAEL1lKhsb+ms
	sZsh3TzhO1Cdg+eiDdAMTVuq1Mp8WjozKFPn
X-Google-Smtp-Source: AGHT+IGda6qWln6BFDTM/Gkb68xMR5bi/oz/Rn8j/Adql6uM3+Sv7uKX/O5J0YwlaSlwXSdspZWvYQ==
X-Received: by 2002:a17:902:da90:b0:22c:3294:f038 with SMTP id d9443c01a7336-22e1034037emr552815ad.18.1746123777577;
        Thu, 01 May 2025 11:22:57 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e0bc7b0aasm9869405ad.169.2025.05.01.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 11:22:56 -0700 (PDT)
Message-ID: <15294d369d94cf005c9aa722967e5ddb1fa8cee3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: Move insn if/else into
 do_check_insn()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
 Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen
 <mrpre@163.com>, Matan Shachnai <m.shachnai@gmail.com>,  Dimitar Kanaliev
 <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Daniel Xu <dxu@dxuuu.xyz>, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-kselftest@vger.kernel.org
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Date: Thu, 01 May 2025 11:22:53 -0700
In-Reply-To: <20250501073603.1402960-3-luis.gerhorst@fau.de>
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
	 <20250501073603.1402960-3-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-01 at 09:35 +0200, Luis Gerhorst wrote:
> This is required to catch the errors later and fall back to a nospec if
> on a speculative path.
>=20
> Eliminate the regs variable as it is only used once and insn_idx is not
> modified in-between the definition and usage.
>=20
> Still pass insn simply to match the other check_*() functions. As Eduard
> points out [1], insn is assumed to correspond to env->insn_idx in many
> places (e.g, __check_reg_arg()).
>=20
> Move code into do_check_insn(), replace
> * "continue" with "return 0" after modifying insn_idx
> * "goto process_bpf_exit" with "return PROCESS_BPF_EXIT"
> * "do_print_state =3D " with "*do_print_state =3D "
>=20
> [1] https://lore.kernel.org/all/293dbe3950a782b8eb3b87b71d7a967e120191fd.=
camel@gmail.com/
>=20
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Except two notes below, I think this patch looks good.
Thank you, this is a good refactoring.

[...]

> +static int do_check_insn(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
> +			 bool *do_print_state)
> +{

[...]

> +	} else if (class =3D=3D BPF_ST) {
> +		enum bpf_reg_type dst_reg_type;
> +
> +		if (BPF_MODE(insn->code) !=3D BPF_MEM ||
> +		    insn->src_reg !=3D BPF_REG_0) {
> +			verbose(env, "BPF_ST uses reserved fields\n");
> +			return -EINVAL;
> +		}
> +		/* check src operand */
> +		err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> +		if (err)
> +			return err;
> +
> +		dst_reg_type =3D cur_regs(env)[insn->dst_reg].type;

Implicitly relying on `insn =3D=3D &env->prog->insnsi[env->cur_idx]`
is weird. Still think that `insn` parameter should be dropped and
computed inside this function instead.

> +
> +		/* check that memory (dst_reg + off) is writeable */
> +		err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
> +				       insn->off, BPF_SIZE(insn->code),
> +				       BPF_WRITE, -1, false, false);
> +		if (err)
> +			return err;
> +
> +		err =3D save_aux_ptr_type(env, dst_reg_type, false);
> +		if (err)
> +			return err;
> +	} else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {

[...]

> +		} else if (opcode =3D=3D BPF_EXIT) {
> +			if (BPF_SRC(insn->code) !=3D BPF_K ||
> +			    insn->imm !=3D 0 ||
> +			    insn->src_reg !=3D BPF_REG_0 ||
> +			    insn->dst_reg !=3D BPF_REG_0 ||
> +			    class =3D=3D BPF_JMP32) {
> +				verbose(env, "BPF_EXIT uses reserved fields\n");
> +				return -EINVAL;
> +			}
> +process_bpf_exit_full:

Nit: since we are refactoring I'd extract this as a function instead of got=
o.

> +			/* We must do check_reference_leak here before
> +			 * prepare_func_exit to handle the case when
> +			 * state->curframe > 0, it may be a callback function,
> +			 * for which reference_state must match caller reference
> +			 * state when it exits.
> +			 */
> +			err =3D check_resource_leak(env, exception_exit, !env->cur_state->cur=
frame,
> +						  "BPF_EXIT instruction in main prog");
> +			if (err)
> +				return err;
> +
> +			/* The side effect of the prepare_func_exit which is
> +			 * being skipped is that it frees bpf_func_state.
> +			 * Typically, process_bpf_exit will only be hit with
> +			 * outermost exit. copy_verifier_state in pop_stack will
> +			 * handle freeing of any extra bpf_func_state left over
> +			 * from not processing all nested function exits. We
> +			 * also skip return code checks as they are not needed
> +			 * for exceptional exits.
> +			 */
> +			if (exception_exit)
> +				return PROCESS_BPF_EXIT;
> +
> +			if (env->cur_state->curframe) {
> +				/* exit from nested function */
> +				err =3D prepare_func_exit(env, &env->insn_idx);
> +				if (err)
> +					return err;
> +				*do_print_state =3D true;
> +				return 0;
> +			}
> +
> +			err =3D check_return_code(env, BPF_REG_0, "R0");
> +			if (err)
> +				return err;
> +			return PROCESS_BPF_EXIT;

[...]


