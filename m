Return-Path: <linux-kselftest+bounces-8481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910FF8AB763
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C611C20BFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033B13D612;
	Fri, 19 Apr 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5+gnBW/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C713C3F2;
	Fri, 19 Apr 2024 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713567615; cv=none; b=laMzeiUm3uSKHsD+zSd1x4zT/iBYJnd1TGyeg8/0UIyaIzZDQ6mb2w+YSgB/g+tXjyB/35tCd+gBv/QgC8ng0OLnTgRm4TiEMAlMYupVIu0bnvlszHCpIfVEWOCS1uRigmc9/cbvYUoX+CZM4BgJ1CJFQhS+nwesscRx7xahWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713567615; c=relaxed/simple;
	bh=jKqhQuL4HMmgp75/H449YSPn0tvy9xa7IQaFqYZbfTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K01Y9SyTlTwQwNCfbh+3qKleyF/B7uoCoBRfS98vL33jNmWBtkpkWIxGnNuejjOS88rQOa4T3W+R1lkFE5O5qGHLjKJK5H1D0Jeb7XlEAjOjNt4aSJlUjltVn9CLQRZkucYOKSjuOchH7Bq5+/jTpkBdk9yMVDyDnpNdnhRG6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5+gnBW/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ad21f3e5dcso596944eaf.3;
        Fri, 19 Apr 2024 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713567613; x=1714172413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6mNoY+63y0TWZ+UKVJ/Zs5Cs6/wNKkluXxkqj1Vg0Mc=;
        b=a5+gnBW/l+SRlMekTQmBIh1rBmhAMBbrEj9WtHa6KKyWD9xUPk0Id1OHuerD9op9ea
         44l0a6Yg8+UMKBErwRHCX7SLM9ukcOdm3MJd0Ze89nwFhbTXRggHREuknPNiVR72J2u2
         dfnwGIaMI9lY4H9cPBoPy/yCNLQ3vMOfkfKO5iuLNzvC2hlhYn7SqKBVL5nrP0Kvgrux
         e27+Ph4zAxuLTTpf64o7/j+DV2eojMjc+RYVW51AXntikzeC0MIRtiU9o7W+INOnTxYI
         2AEkhSVcXFV5XGJIYELjbwX+gBsZeSy/pfE3V619/989jPup00GQolyxiPAuobMRIn/2
         XPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713567613; x=1714172413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mNoY+63y0TWZ+UKVJ/Zs5Cs6/wNKkluXxkqj1Vg0Mc=;
        b=tesuhbd1jUw0KgD4WYSQJqwNFTLl9e/5CsoO/MrKMxWEnIRQKB+al+WGVEWMmrenIy
         pM6P1o9kesse2Q+QhcnQ4CRNDwbtNBvq5cNBeW0fN/TSdY/H2+qKcyEpU21nB3k/cBzO
         wdSyTrwtr6Wc6fUMoHqDJD18k7ywKJBmlctdyzs5YNCOk7x2WhKRdUv8uZlymR48FufT
         SqIw4cyeVtIYOSYBtOrbQxW5HhnxhSY/WVAziSPfjJ72oTGIrAZWFVNtoqr1yMrFMNL2
         AaY8NgSg8lILbfErQ1wNEqSmpL+A3GDJdO9IU2bIOw/qTlIxrGWYFNd5a2WzAEJ8jG7F
         gwMw==
X-Forwarded-Encrypted: i=1; AJvYcCWlz+mhRup7KEOY0NhtBEKGld6I5qVkLLKvTb+lq7AnRUX+bLbzb5ULiusir7aCWTup1cHp7TUF0US6TVEJZFK7d3A6U5o/jlrlva/FeJ/AV/vqbBB07rypqN+lVZd+USxBsAdsEYbiOaLKkx1t3W3XDNBv6p3CTdzSi80ibVR69eB/abPn87eCg/KjX1QOkGr83Uen4BnVGcCiAaMzurGp9zoQ
X-Gm-Message-State: AOJu0YwFaeNM7lFnEW4BHcliwd2EgmNSWpK1u991pTEz0eaHMHkM1YUh
	YvxutG6c/b36MeuknC5jc0dNI9u+fVDtiY/uPtBDZpxpQ6yDhwIa
X-Google-Smtp-Source: AGHT+IElFsz7C2/xa7LvzuBo6XRD8qxVuJ8nQLRSUordf41ohWT0Nht6guK2hYR3sFLHfeaZZO1tog==
X-Received: by 2002:a05:6870:96a1:b0:221:bf34:b15f with SMTP id o33-20020a05687096a100b00221bf34b15fmr3928563oaq.25.1713567613268;
        Fri, 19 Apr 2024 16:00:13 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:cc9b:cd8b:e2d0:f16f? ([2604:3d08:9880:5900:cc9b:cd8b:e2d0:f16f])
        by smtp.gmail.com with ESMTPSA id fb33-20020a056a002da100b006ed14fed3a5sm3757361pfb.154.2024.04.19.16.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:00:12 -0700 (PDT)
Message-ID: <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski
 <mattbobrowski@google.com>, Brendan Jackman <jackmanb@chromium.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek
 <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, John Johansen
 <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Fri, 19 Apr 2024 16:00:11 -0700
In-Reply-To: <20240411122752.2873562-8-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
	 <20240411122752.2873562-8-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_i=
d_opts
> is rejected by the verifier, and the log says:
>=20
>   0: R1=3Dctx() R10=3Dfp0
>   ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test=
_libbpf_get_fd_by_id_opts.c:27
>   0: (b7) r0 =3D 0                        ; R0_w=3D0
>   1: (79) r2 =3D *(u64 *)(r1 +0)
>   func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
>   2: R1=3Dctx() R2_w=3Dtrusted_ptr_bpf_map()
>   ; if (map !=3D (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_i=
d_opts.c:29
>   2: (18) r3 =3D 0xffff9742c0951a00       ; R3_w=3Dmap_ptr(map=3Ddata_inp=
ut,ks=3D4,vs=3D4)
>   4: (5d) if r2 !=3D r3 goto pc+4         ; R2_w=3Dtrusted_ptr_bpf_map() =
R3_w=3Dmap_ptr(map=3Ddata_input,ks=3D4,vs=3D4)
>   ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test=
_libbpf_get_fd_by_id_opts.c:27
>   5: (79) r0 =3D *(u64 *)(r1 +8)          ; R0_w=3Dscalar() R1=3Dctx()
>   ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
>   6: (67) r0 <<=3D 62                     ; R0_w=3Dscalar(smax=3D0x400000=
0000000000,umax=3D0xc000000000000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=
=3D(0x0; 0xc000000000000000))
>   7: (c7) r0 s>>=3D 63                    ; R0_w=3Dscalar(smin=3Dsmin32=
=3D-1,smax=3Dsmax32=3D0)
>   ;  @ test_libbpf_get_fd_by_id_opts.c:0
>   8: (57) r0 &=3D -13                     ; R0_w=3Dscalar(smax=3D0x7fffff=
fffffffff3,umax=3D0xfffffffffffffff3,smax32=3D0x7ffffff3,umax32=3D0xfffffff=
3,var_off=3D(0x0; 0xfffffffffffffff3))
>   ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test=
_libbpf_get_fd_by_id_opts.c:27
>   9: (95) exit
>=20
> And here is the C code of the prog.
>=20
> SEC("lsm/bpf_map")
> int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
> {
> 	if (map !=3D (struct bpf_map *)&data_input)
> 		return 0;
>=20
> 	if (fmode & FMODE_WRITE)
> 		return -EACCES;
>=20
> 	return 0;
> }
>=20
> It is clear that the prog can only return either 0 or -EACCESS, and both
> values are legal.
>=20
> So why is it rejected by the verifier?
>=20
> The verifier log shows that the second if and return value setting
> statements in the prog is optimized to bitwise operations "r0 s>>=3D 63"
> and "r0 &=3D -13". The verifier correctly deduces that the the value of
> r0 is in the range [-1, 0] after verifing instruction "r0 s>>=3D 63".
> But when the verifier proceeds to verify instruction "r0 &=3D -13", it
> fails to deduce the correct value range of r0.
>=20
> 7: (c7) r0 s>>=3D 63                    ; R0_w=3Dscalar(smin=3Dsmin32=3D-=
1,smax=3Dsmax32=3D0)
> 8: (57) r0 &=3D -13                     ; R0_w=3Dscalar(smax=3D0x7fffffff=
fffffff3,umax=3D0xfffffffffffffff3,smax32=3D0x7ffffff3,umax32=3D0xfffffff3,=
var_off=3D(0x0; 0xfffffffffffffff3))
>=20
> So why the verifier fails to deduce the result of 'r0 &=3D -13'?
>=20
> The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
> "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
> "r0 &=3D -13", the verifier erroneously deduces the result from
> "[0, -1ULL] AND -13", which is out of the expected return range
> [-4095, 0].
>=20
> To fix it, this patch simply adds a special SCALAR32 case for the
> verifier. That is, when the source operand of the AND instruction is
> a constant and the destination operand changes from negative to
> non-negative and falls in range [-256, 256], deduce the result range
> by enumerating all possible AND results.
>=20
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Hello,

Sorry for the delay, I had to think about this issue a bit.
I found the clang transformation that generates the pattern this patch
tries to handle.
It is located in DAGCombiner::SimplifySelectCC() method (see [1]).
The transformation happens as a part of DAG to DAG rewrites
(LLVM uses several internal representations:
 - generic optimizer uses LLVM IR, most of the work is done
   using this representation;
 - before instruction selection IR is converted to Selection DAG,
   some optimizations are applied at this stage,
   all such optimizations are a set of pattern replacements;
 - Selection DAG is converted to machine code, some optimizations
   are applied at the machine code level).

Full pattern is described as follows:

  // fold (select_cc seteq (and x, y), 0, 0, A) -> (and (sra (shl x)) A)
  // where y is has a single bit set.
  // A plaintext description would be, we can turn the SELECT_CC into an AN=
D
  // when the condition can be materialized as an all-ones register.  Any
  // single bit-test can be materialized as an all-ones register with
  // shift-left and shift-right-arith.

For this particular test case the DAG is converted as follows:

                    .---------------- lhs         The meaning of this selec=
t_cc is:
                    |        .------- rhs         `lhs =3D=3D rhs ? true va=
lue : false value`
                    |        | .----- true value
                    |        | |  .-- false value
                    v        v v  v=20
  (select_cc seteq (and X 2) 0 0 -13)
                          ^
->                        '---------------.
  (and (sra (sll X 62) 63)                |
       -13)                               |
                                          |
Before pattern is applied, it checks that second 'and' operand has
only one bit set, (which is true for '2').

The pattern itself generates logical shift left / arithmetic shift
right pair, that ensures that result is either all ones (-1) or all
zeros (0). Hence, applying 'and' to shifts result and false value
generates a correct result.

In my opinion the approach taken by this patch is sub-optimal:
- 512 iterations is too much;
- this does not cover all code that could be generated by the above
  mentioned LLVM transformation
  (e.g. second 'and' operand could be 1 << 16).

Instead, I suggest to make a special case for source or dst register
of '&=3D' operation being in range [-1,0].
Meaning that one of the '&=3D' operands is either:
- all ones, in which case the counterpart is the result of the operation;
- all zeros, in which case zero is the result of the operation;
- derive MIN and MAX values based on above two observations.

[1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e96=
13985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp#L5391

Best regards,
Eduard


