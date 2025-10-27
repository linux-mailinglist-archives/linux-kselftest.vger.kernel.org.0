Return-Path: <linux-kselftest+bounces-44141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C7C11579
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20F10507320
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C20324B15;
	Mon, 27 Oct 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+WJCknY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B00322A27
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595760; cv=none; b=mRWP82tPyxPXmnPleneUlnl7N2jhx9v6CcDkvEpl5yMKNLauIL4y9Hps1LCAPO3HWCcR9nozBN8Y8d9Tix9N7vAP1pDHUv9he1nkFpvelI1jdK4gA+1Br560pi39Zh5rwityMcUCxWm2AkGRpFpNXdRFaKkw1SEx6ijUYVeXBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595760; c=relaxed/simple;
	bh=VrzfHj3otmmBCDNQvZHD/YIyZ6ahyrf9WNnnwjmbVIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qIiQuN2DSUYktupVmxZiuXgHh0kaGsQaWh/FNtbgOwIlRkmMLNn1nZSOT63WAb34zz0G/pEnW7RvQUeOKX+RNX5S3YE8JJWP+utYN8CrmNzMe+T9bDXJFBIxHNnBD4Ed6r5f3TzXinIaMxU3UgEqsF/1SGxYU1s+0NuFgqfNdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+WJCknY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so5328653a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761595757; x=1762200557; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=00/tGJs0RfNksXOaDOXennpkTn/k8VAdCGvJj00dDEc=;
        b=C+WJCknYInavndh00gYe5TCpC3X9Q1qhw5H55Ng0Ckc7zE4U5h844bdohWIMVAlH01
         zgBMDaRrcY657BQ9c+Incsfv63Tc6olZaYAhyXunO7UO1AjGghRzYuzc1fWN4SU0wOLJ
         094kiyG+U1GlNSHQy3DXev+EwNmfGRWkGg4QpECQbMERnvKPeC3X/s0UtRvKRvnl6J+Z
         3asCCAzVO4XsrhCHZ1l7OAZhZvYf8ZGZdofwMHE14W/Wle75V54nuPFEjvyvwX4Lk7bJ
         E5ENb+KqDIpiOq4XMiAWgsCQfcr8LvOKW5y1HEdy1fx05iqxiWjLIb+G6gkA9cg+2vsW
         8f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761595757; x=1762200557;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00/tGJs0RfNksXOaDOXennpkTn/k8VAdCGvJj00dDEc=;
        b=JusVYNOpgzL/vB2KW687Mz5I8GrZNa6VSW4o89WB+HMzEbn2V53GOaiDQazcn1UO4W
         YLgrOEG6lN7jKlRtbm5sboZeoGuH1+ntpkEsGISa9KNOEimNCDmR8MONjxDNCdSgVTHv
         SEyhyJ/eV3gldQWJKLl6gAt0byziexeNQisDOqhrRwsYJR/CFWWl95eXVV9OqbO1Tecg
         a91OxeCRlES5ZoCFNzjGUetS/gXYEw8t3PkFgPFbIqHh9L+EjgT0h9vpsLVH414LbSiu
         zKQ2EuzHN3zAVFV6MUbwpvjSKdodSSqPCzdVG0nL0+PsRrv4a6zu/ymMgxiDLT7evgP2
         8lyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuqrsrn5SYh/VwwGGxjvSEAHjAzCVxraaF4Eko6TMq72m2VdxylcB1k7TnjelRKCyLAsY09Vv8qFZepNdtBgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZaDFkgD1SaevW3Qo2E16gkmfNnQp7OtncROMKaFfp5CE0Hrn
	vrmytiJtHMgqZeOB/97vgiPC7kieS99aWyFA9zNqt8gOraTRafcnAGVt
X-Gm-Gg: ASbGncugjefN25s7DI8+qsaK54jCIOg3vmRn08F5z4huflsw6r0K13iTsDCrxLUZ36Y
	1ytuxwolNfzm7EPCPFJb5ydYs8B5xta9mA7F9k5szezsUN8BqRfRvTHaG+/lxR3ZZdH0Ry8KjA9
	wGdfoBep2Qwp7IikiYd236wNlfjcB4bJQ3fSs9Dhs/yQ/K8A/ctyTqgt0qP3Yq5DfROLavOSEXO
	oFsG2HkVPpBSU/xJyW0lWJHQXHNueJINQc7jcos/Z9M3L/6rs+KIRdwXwFABA9vs2mNMCZ1XfEq
	N1lFRwEw8xZ2Ps6vOORCmvT8FI9qHiOTwJBg8er0tiiONX0BDtDnEFEek/W+pHP5Ta3sgWirXex
	VslEma5ruppFPHrJzg/xGeBY1RiaIu05k4lAqApnykm7jZXG0btucqsd42UDmUxj5Y1oDKr/kRj
	VMpla8ndqv
X-Google-Smtp-Source: AGHT+IFl4hWhOQRPaNuwDWpNGSweJYl2JxtBvdEdtnPBHu5jRqebty3eUExo/muCgqOvDIJ7QiPuXg==
X-Received: by 2002:a17:90b:38cf:b0:33d:a6a6:2e26 with SMTP id 98e67ed59e1d1-34028989872mr853354a91.13.1761595757297;
        Mon, 27 Oct 2025 13:09:17 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402910b3f8sm207808a91.1.2025.10.27.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 13:09:16 -0700 (PDT)
Message-ID: <51769170ba3cf9eb4007fb0fc22f2434302d9aa5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>
Date: Mon, 27 Oct 2025 13:09:13 -0700
In-Reply-To: <20251025053017.2308823-2-kafai.wan@linux.dev>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
	 <20251025053017.2308823-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-25 at 13:30 +0800, KaFai Wan wrote:
> When conditional jumps are performed on the same register (e.g., r0 <=3D =
r0,
> r0 > r0, r0 < r0) where the register holds a scalar with range, the verif=
ier
> incorrectly attempts to adjust the register's min/max bounds. This leads =
to
> invalid range bounds and triggers a BUG warning:
>=20
> verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violatio=
n u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x0] var_o=
ff=3D(0x0, 0x0)
> WARNING: CPU: 0 PID: 92 at kernel/bpf/verifier.c:2731 reg_bounds_sanity_c=
heck+0x163/0x220
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-de=
bian-1.16.3-2 04/01/2014
> RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> Call Trace:
>  <TASK>
>  reg_set_min_max+0xf7/0x1d0
>  check_cond_jmp_op+0x57b/0x1730
>  ? print_bpf_insn+0x3d5/0xa50
>  do_check_common+0x33ac/0x33c0
>  ...
>=20
> The root cause is in regs_refine_cond_op() where BPF_JLT/BPF_JSLT operati=
ons
> adjust both min/max bounds on the same register, causing invalid bounds.
>=20
> Since comparing a register with itself should not change its bounds (the
> comparison result is always known: r0 =3D=3D r0 is always true, r0 < r0 i=
s
> always false), the bounds adjustment is unnecessary.
>=20
> Fix this by:
> 1. Enhance is_branch_taken() and is_scalar_branch_taken() to properly
>    handle branch direction computation for same register comparisons
>    across all BPF jump operations
> 2. For unknown branch directions (e.g., BPF_JSET), add early return in
>    reg_set_min_max() to avoid bounds adjustment on the same register
>=20
> The fix ensures that unnecessary bounds adjustments are skipped, preventi=
ng
> the verifier bug while maintaining correct branch direction analysis.
>=20
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.k=
aiyanm@hust.edu.cn/
> Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>  kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6d175849e57a..653fa96ed0df 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16037,6 +16037,12 @@ static int is_scalar_branch_taken(struct bpf_reg=
_state *reg1, struct bpf_reg_sta
>  		}
>  		break;
>  	case BPF_JSET:
> +		if (reg1 =3D=3D reg2) {
> +			if (tnum_is_const(t1))
> +				return t1.value !=3D 0;
> +			else
> +				return (smin1 <=3D 0 && smax1 >=3D 0) ? -1 : 1;
> +		}

I think this logic is fine, but it needs tests for multiple cases.

>  		if (!is_reg_const(reg2, is_jmp32)) {
>  			swap(reg1, reg2);
>  			swap(t1, t2);
> @@ -16172,6 +16178,25 @@ static int is_pkt_ptr_branch_taken(struct bpf_re=
g_state *dst_reg,
>  static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
>  			   u8 opcode, bool is_jmp32)
>  {
> +	if (reg1 =3D=3D reg2) {
> +		switch (opcode) {
> +		case BPF_JGE:
> +		case BPF_JLE:
> +		case BPF_JSGE:
> +		case BPF_JSLE:
> +		case BPF_JEQ:
> +			return 1;
> +		case BPF_JGT:
> +		case BPF_JLT:
> +		case BPF_JSGT:
> +		case BPF_JSLT:
> +		case BPF_JNE:
> +			return 0;
> +		default:
> +			break;
> +		}
> +	}
> +

I think Alexei was against my suggestion to put it in
is_branch_taken() and preferred is_scalar_branch_taken() instead.

>  	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is=
_jmp32)
>  		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
> =20
> @@ -16429,6 +16454,13 @@ static int reg_set_min_max(struct bpf_verifier_e=
nv *env,
>  	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
>  		return 0;
> =20
> +	/* We compute branch direction for same registers in is_branch_taken() =
and
> +	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_J=
SET)
> +	 * on the same registers, we don't need to adjusts the min/max values.
> +	 */
> +	if (false_reg1 =3D=3D false_reg2)
> +		return 0;
> +
>  	/* fallthrough (FALSE) branch */
>  	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp3=
2);
>  	reg_bounds_sync(false_reg1);

