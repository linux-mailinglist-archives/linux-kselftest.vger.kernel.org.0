Return-Path: <linux-kselftest+bounces-44012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F2C0759B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA553AF1D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE002749CB;
	Fri, 24 Oct 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZTbNWIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934627C84E
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323897; cv=none; b=pFy+auoYFUCclB0xdhHJxJhIOVCLvEZ7036tTb9LDotT72qPG3Cf+wmZ+kidnSsT3l3cBZMvgdt/y0QFg/ack4HI1+3v7HKbXqV5K69heUtJIJntQvP3YGEd4YC5NmVI2I7gLBkElB8R0hw1HAbNSEHhKQx5qc2Jn0baKzK+DJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323897; c=relaxed/simple;
	bh=4RdmMOkVFovv6W3PG0hz9kHh4ekzafNn8MrGb3gvNds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4hLdaebF05GjwgsOag8rgciXBxEpXDdfItK9p4GGzLw3sfR/L3cn9umtlrgD8K7WgejhrOGGDgcKZyRY13zc3iINHkjbNKAUrG0uwmOPIbG3fz2jdvGpd7JVqayFx/mwajtRSU3TWGwi6OIq4n4v6N9UTpy6fmSv01rOkG6uiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gZTbNWIm; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761323883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yk3pEU/ACNai1/q+WeDU0CKJXNjGIfc4+FFbTTAuSvo=;
	b=gZTbNWImdS5DbYczGLOS/duKMTfC1P2/KqR8Fj2/eycDa09s2PtKWcKM0HCsLRm/Rzw2XX
	nVchMoKRZKM1GI44f0wW9auzTW8aQUS7K3YF06nYI9s4mrYLtWXESoCt6Tz19rX43UQIRp
	M2MWPeJxq1A/HmUTimc2gQYTS9AjZ9w=
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
 colin.i.king@gmail.com, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Sat, 25 Oct 2025 00:37:51 +0800
In-Reply-To: <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
	 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
	 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
	 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
	 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
	 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
	 <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
	 <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2025-10-24 at 09:21 -0700, Eduard Zingerman wrote:
> On Sat, 2025-10-25 at 00:13 +0800, KaFai Wan wrote:
>=20
> [...]
>=20
> > For non-scalar cases we only allow pointer comparison on pkt_ptr, this =
check is before
> > is_branch_taken()
> >=20
> > 	src_reg =3D &regs[insn->src_reg];
> > 	if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_re=
g)) &&
> > 	=C2=A0=C2=A0=C2=A0 is_pointer_value(env, insn->src_reg)) {
> > 		verbose(env, "R%d pointer comparison prohibited\n",
> > 			insn->src_reg);
> > 		return -EACCES;
> > 	}=20
> >=20
> > and in the end of check_cond_jmp_op() (after is_branch_taken()), we che=
cked again
> >=20
> > 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg]=
,
> > 					=C2=A0=C2=A0 this_branch, other_branch) &&
> > 		=C2=A0=C2=A0 is_pointer_value(env, insn->dst_reg)) {
> > 		verbose(env, "R%d pointer comparison prohibited\n",
> > 			insn->dst_reg);
> > 		return -EACCES;
> > 	}
> >=20
> > this time we=C2=A0check if it is valid comparison on pkt_ptr in try_mat=
ch_pkt_pointers().=C2=A0
> >=20
> > Currently we just allow 4 opcode (BPF_JGT, BPF_JLT, BPF_JGE, BPF_JLE) o=
n pkt_ptr, and with
> > conditions. But we bypass these prohibits in privileged mode (is_pointe=
r_value() always=C2=A0
> > return false in privileged mode).
> >=20
> > So the logic skip these prohibits for pkt_ptr in unprivileged mode.
>=20
> Well, yes, but do you really need to do forbid `if r0 > r0 goto ...` in u=
npriv?

Currently `if r0 > r0 goto ...` is forbid in unpriv, but we can allow it.=
=20

--=20
Thanks,
KaFai

