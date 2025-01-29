Return-Path: <linux-kselftest+bounces-25372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10004A21FD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EFC188560F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063391BD9E6;
	Wed, 29 Jan 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWCIhPe8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC67E9;
	Wed, 29 Jan 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162777; cv=none; b=TnSDSNAoc7WWjnDDNi3FlLxgPxfjPJuFtCxZUXRfYcfyUX0N2O79MMp/ta6y44sAwvxs5Xg5ZZ6Ji9iTmE2NQpo0oSU7cScu8ORFknosOFh9YsrxHTjW4OnpuViS6g8T5ybuzpOonVojAFo+FiRyeTaK4sb30tUmGUPCl2t8VhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162777; c=relaxed/simple;
	bh=j0xf8Wugf7d4B5mcDrAnRANssmaL+WMd5mK+89Bqg30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAChZ7mHgvs76XD8eXJG44u4SvjgFcwVSIRe8PVdmseBzBj0n6qtDairKbQwslKWya7O38jzrwRrNmvawCmWFU2j/+qgzw+wtvV9lRWnX5jf30cmmgHWyLhUaWH/nRb9A510Q/7VoQO/Sc+0u8BN7AcxQgCJ9uLkjheR1b8XTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWCIhPe8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEEEjt028543;
	Wed, 29 Jan 2025 14:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NX52ag
	ti0v8wlGfwn10zvny4iYL1EqJm7zUROtBGTxM=; b=fWCIhPe8C3BNhUUr7A3NYh
	MUFnniVye7i8cWgUIXvSwzfByqQAi7BdFOMl6VAnCkRMh1eZwAj464zwMNTbnCJR
	4f+a8dbAoaVO3IYfgkqU00J9D6A1xaVglzZ+KfMzh0aerScoQGbentQxGQfjrYJF
	auZaL2LuqhhCYeZJv/XnLyqD2hlgZZ46JV64X+nfwdIigE7wcbI/mR2+lUDLOuyr
	yDrP2QA0S648Io8h9xJo+jLH/1Pvar4wubm7EIbCio8ctlUl9cMW3H97+2erC1nu
	6f62BIFXyiGK8XkdqxxJvREsUY+r3fHpVxiIHE50ehh3A/fMSI73Gc1z+ceF74JQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fb60ax6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 14:59:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50TExBhZ003237;
	Wed, 29 Jan 2025 14:59:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fb60ax58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 14:59:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50TCqVOQ012336;
	Wed, 29 Jan 2025 14:59:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dany99u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 14:59:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50TEwxUb40108324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:58:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 007152009C;
	Wed, 29 Jan 2025 14:58:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDEE7200A0;
	Wed, 29 Jan 2025 14:58:57 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jan 2025 14:58:57 +0000 (GMT)
Message-ID: <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, eddyz87@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Marc
 Hartmayer <mhartmay@linux.ibm.com>
Date: Wed, 29 Jan 2025 15:58:54 +0100
In-Reply-To: <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
	 <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FKh6k25TDJ9aQ2qF7PzgdFcKDbgROBqX
X-Proofpoint-ORIG-GUID: wXT9RqwprV3FqDqUF9kRqUy79Xb-QAI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=872
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290121

On Tue, 2025-01-14 at 13:28 -0700, Daniel Xu wrote:
> This commit allows progs to elide a null check on statically known
> map
> lookup keys. In other words, if the verifier can statically prove
> that
> the lookup will be in-bounds, allow the prog to drop the null check.
>=20
> This is useful for two reasons:
>=20
> 1. Large numbers of nullness checks (especially when they cannot
> fail)
> =C2=A0=C2=A0 unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_S=
EQ.
> 2. It forms a tighter contract between programmer and verifier.
>=20
> For (1), bpftrace is starting to make heavier use of percpu scratch
> maps. As a result, for user scripts with large number of unrolled
> loops,
> we are starting to hit jump complexity verification errors.=C2=A0 These
> percpu lookups cannot fail anyways, as we only use static key values.
> Eliding nullness probably results in less work for verifier as well.
>=20
> For (2), percpu scratch maps are often used as a larger stack, as the
> currrent stack is limited to 512 bytes. In these situations, it is
> desirable for the programmer to express: "this lookup should never
> fail,
> and if it does, it means I messed up the code". By omitting the null
> check, the programmer can "ask" the verifier to double check the
> logic.
>=20
> Tests also have to be updated in sync with these changes, as the
> verifier is more efficient with this change. Notable, iters.c tests
> had
> to be changed to use a map type that still requires null checks, as
> it's
> exercising verifier tracking logic w.r.t iterators.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 92
> ++++++++++++++++++-
> =C2=A0tools/testing/selftests/bpf/progs/iters.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 14 +--
> =C2=A0.../selftests/bpf/progs/map_kptr_fail.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../selftests/bpf/progs/verifier_map_in_map.c |=C2=A0 2 +-
> =C2=A0.../testing/selftests/bpf/verifier/map_kptr.c |=C2=A0 2 +-
> =C2=A05 files changed, 99 insertions(+), 13 deletions(-)

[...]

> @@ -9158,6 +9216,7 @@ static int check_func_arg(struct
> bpf_verifier_env *env, u32 arg,
> =C2=A0	enum bpf_arg_type arg_type =3D fn->arg_type[arg];
> =C2=A0	enum bpf_reg_type type =3D reg->type;
> =C2=A0	u32 *arg_btf_id =3D NULL;
> +	u32 key_size;
> =C2=A0	int err =3D 0;
> =C2=A0
> =C2=A0	if (arg_type =3D=3D ARG_DONTCARE)
> @@ -9291,8 +9350,13 @@ static int check_func_arg(struct
> bpf_verifier_env *env, u32 arg,
> =C2=A0			verbose(env, "invalid map_ptr to access map-
> >key\n");
> =C2=A0			return -EACCES;
> =C2=A0		}
> -		err =3D check_helper_mem_access(env, regno, meta-
> >map_ptr->key_size,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_READ, false,
> NULL);
> +		key_size =3D meta->map_ptr->key_size;
> +		err =3D check_helper_mem_access(env, regno, key_size,
> BPF_READ, false, NULL);
> +		if (err)
> +			return err;
> +		meta->const_map_key =3D get_constant_map_key(env, reg,
> key_size);
> +		if (meta->const_map_key < 0 && meta->const_map_key
> !=3D -EOPNOTSUPP)
> +			return meta->const_map_key;

Mark Hartmayer reported a problem that after this commit the verifier
started refusing to load libvirt's virCgroupV2DevicesLoadProg(), which
contains the following snippet:

53: (b7) r1 =3D -1                      ; R1_w=3D-1
54: (7b) *(u64 *)(r10 -8) =3D r1        ; R1_w=3D-1 R10=3Dfp0 fp-8_w=3D-1
55: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
56: (07) r2 +=3D -8                     ; R2_w=3Dfp-8
57: (18) r1 =3D 0x9553c800              ; R1_w=3Dmap_ptr(ks=3D8,vs=3D4)
59: (85) call bpf_map_lookup_elem#1

IIUC here the actual constant value is -1, which this code confuses
with an error.

