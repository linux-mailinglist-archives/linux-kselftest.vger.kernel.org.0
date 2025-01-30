Return-Path: <linux-kselftest+bounces-25413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC0AA22B42
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B711C188410F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2421B4137;
	Thu, 30 Jan 2025 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cAdhZGfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945A372;
	Thu, 30 Jan 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231597; cv=none; b=DYvIQ9W0XgAATrAQtlIE4HTApeyHyl9cisYvHrPcyAYhRMEthE8vpelN9evxS7caaNjN9Qxsm6kjuZQiwtKsm2cgUCnJ1NKqj8qT8mfBVEH9htuV5seMobv/u2rZnppSpmyWOoI0q8cd4wxvfMkGw2xDQYl/1mv3kEgchuipomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231597; c=relaxed/simple;
	bh=zansQwwQO8AW6eGLsqO6BvUiuPrL917pAn1G5Yf2tZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9xY4VtUXq/4mA7ZrvR8fgQ1aQdjypH5KE533OEfhMsDeK4XPdGELUNmNgrdQCWygq5uhgOgp/kwR1LFjjq4XZiTk+RgJaWD7t1uMaaEWZBX1zLHPLjAGnY26DMm0jyxkOLYg0hvALBvhJdeViSi07dhTF2gFXHsKYSunq+lPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cAdhZGfd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U219Wj020932;
	Thu, 30 Jan 2025 10:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u+ERtO
	Zjd2yOUTdjgroZYl4cuMkHyd6zo7sQ1PWp69Q=; b=cAdhZGfdj/GC0rZYZ9krLq
	jtjgqLr73yaY/By4K3fu3gPP8tddg6azXxIpLMcIiRBa/cQJW2HPhu16+PZmRjdt
	O4Xbyo9sF9gd+yWAsD6fLEHrMIvadPpWG3T7Ak7vqyriizlTSKk/E2VwHx0ChZ1A
	+CBHodisPAgiBLky4J6W7jwh8TFl96UlvOLUaLAyu2uErB5pJloDZnbWSm1bMPd5
	R/ESqoLMEJFi2nEsVvTy/ES6drDN7ihqAWv6DJnApWftq1Y9y6NScih3DoNNJKAM
	f5hNPZMHaNHZrDIVF/RKmtPQDPD6L9hx6ldtMEfZyTGbZ/E88hqmhQklZblxT2Pg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44g08ysqfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:06:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50U9oTl2005987;
	Thu, 30 Jan 2025 10:06:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44g08ysqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:06:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U6WeqF012328;
	Thu, 30 Jan 2025 10:06:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44danydqc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:06:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UA66Ur35717828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 10:06:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C3320128;
	Thu, 30 Jan 2025 10:06:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FD7020126;
	Thu, 30 Jan 2025 10:06:05 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 10:06:05 +0000 (GMT)
Message-ID: <ae5e32ff2269eb4c190aeb882b17cb1bb8e6c70d.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: shuah@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Date: Thu, 30 Jan 2025 11:06:05 +0100
In-Reply-To: <f7rhmwrp3fgx3qd7gn3pzczxeztvsg45u4vrl6ls3ylcvflapx@3yi3shfnrmb3>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
	 <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
	 <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>
	 <hsgmutuoi4kvjkr7erm5ty2fdrhdrjpz4fpp5doe65l3pzguxv@lcbmvmjpyykq>
	 <f7rhmwrp3fgx3qd7gn3pzczxeztvsg45u4vrl6ls3ylcvflapx@3yi3shfnrmb3>
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
X-Proofpoint-GUID: rTBXDs4Ib8zCKzEG9_s6HbyOdMbw_K39
X-Proofpoint-ORIG-GUID: FM4pVpcguPeeLI5jjdfJZmNLgxnyFCzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300077

On Wed, 2025-01-29 at 10:45 -0700, Daniel Xu wrote:
> On Wed, Jan 29, 2025 at 09:49:12AM -0700, Daniel Xu wrote:
> > Hi Ilya,
> >=20
> > On Wed, Jan 29, 2025 at 03:58:54PM +0100, Ilya Leoshkevich wrote:
> > > On Tue, 2025-01-14 at 13:28 -0700, Daniel Xu wrote:
> > > > This commit allows progs to elide a null check on statically
> > > > known
> > > > map
> > > > lookup keys. In other words, if the verifier can statically
> > > > prove
> > > > that
> > > > the lookup will be in-bounds, allow the prog to drop the null
> > > > check.
> > > >=20
> > > > This is useful for two reasons:
> > > >=20
> > > > 1. Large numbers of nullness checks (especially when they
> > > > cannot
> > > > fail)
> > > > =C2=A0=C2=A0 unnecessarily pushes prog towards
> > > > BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> > > > 2. It forms a tighter contract between programmer and verifier.
> > > >=20
> > > > For (1), bpftrace is starting to make heavier use of percpu
> > > > scratch
> > > > maps. As a result, for user scripts with large number of
> > > > unrolled
> > > > loops,
> > > > we are starting to hit jump complexity verification errors.=C2=A0
> > > > These
> > > > percpu lookups cannot fail anyways, as we only use static key
> > > > values.
> > > > Eliding nullness probably results in less work for verifier as
> > > > well.
> > > >=20
> > > > For (2), percpu scratch maps are often used as a larger stack,
> > > > as the
> > > > currrent stack is limited to 512 bytes. In these situations, it
> > > > is
> > > > desirable for the programmer to express: "this lookup should
> > > > never
> > > > fail,
> > > > and if it does, it means I messed up the code". By omitting the
> > > > null
> > > > check, the programmer can "ask" the verifier to double check
> > > > the
> > > > logic.
> > > >=20
> > > > Tests also have to be updated in sync with these changes, as
> > > > the
> > > > verifier is more efficient with this change. Notable, iters.c
> > > > tests
> > > > had
> > > > to be changed to use a map type that still requires null
> > > > checks, as
> > > > it's
> > > > exercising verifier tracking logic w.r.t iterators.
> > > >=20
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > > > =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 92
> > > > ++++++++++++++++++-
> > > > =C2=A0tools/testing/selftests/bpf/progs/iters.c=C2=A0=C2=A0=C2=A0=
=C2=A0 | 14 +--
> > > > =C2=A0.../selftests/bpf/progs/map_kptr_fail.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0.../selftests/bpf/progs/verifier_map_in_map.c |=C2=A0 2 +-
> > > > =C2=A0.../testing/selftests/bpf/verifier/map_kptr.c |=C2=A0 2 +-
> > > > =C2=A05 files changed, 99 insertions(+), 13 deletions(-)
> > >=20
> > > [...]
> > >=20
> > > > @@ -9158,6 +9216,7 @@ static int check_func_arg(struct
> > > > bpf_verifier_env *env, u32 arg,
> > > > =C2=A0	enum bpf_arg_type arg_type =3D fn->arg_type[arg];
> > > > =C2=A0	enum bpf_reg_type type =3D reg->type;
> > > > =C2=A0	u32 *arg_btf_id =3D NULL;
> > > > +	u32 key_size;
> > > > =C2=A0	int err =3D 0;
> > > > =C2=A0
> > > > =C2=A0	if (arg_type =3D=3D ARG_DONTCARE)
> > > > @@ -9291,8 +9350,13 @@ static int check_func_arg(struct
> > > > bpf_verifier_env *env, u32 arg,
> > > > =C2=A0			verbose(env, "invalid map_ptr to
> > > > access map-
> > > > > key\n");
> > > > =C2=A0			return -EACCES;
> > > > =C2=A0		}
> > > > -		err =3D check_helper_mem_access(env, regno,
> > > > meta-
> > > > > map_ptr->key_size,
> > > > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_READ, false,
> > > > NULL);
> > > > +		key_size =3D meta->map_ptr->key_size;
> > > > +		err =3D check_helper_mem_access(env, regno,
> > > > key_size,
> > > > BPF_READ, false, NULL);
> > > > +		if (err)
> > > > +			return err;
> > > > +		meta->const_map_key =3D
> > > > get_constant_map_key(env, reg,
> > > > key_size);
> > > > +		if (meta->const_map_key < 0 && meta-
> > > > >const_map_key
> > > > !=3D -EOPNOTSUPP)
> > > > +			return meta->const_map_key;
> > >=20
> > > Mark Hartmayer reported a problem that after this commit the
> > > verifier
> > > started refusing to load libvirt's virCgroupV2DevicesLoadProg(),
> > > which
> > > contains the following snippet:
> > >=20
> > > 53: (b7) r1 =3D -1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ; R1_w=3D-1
> > > 54: (7b) *(u64 *)(r10 -8) =3D r1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ; R1_w=3D-1 R10=3Dfp0 fp-8_w=3D-1
> > > 55: (bf) r2 =3D r10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; =
R2_w=3Dfp0 R10=3Dfp0
> > > 56: (07) r2 +=3D -8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; =
R2_w=3Dfp-8
> > > 57: (18) r1 =3D 0x9553c800=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R1_w=3Dmap_ptr(ks=3D8,vs=3D4)
> > > 59: (85) call bpf_map_lookup_elem#1
> > >=20
> > > IIUC here the actual constant value is -1, which this code
> > > confuses
> > > with an error.
> >=20
> > Thanks for reporting. I think I know what the issue is - will send
> > a
> > patch shortly.
> >=20
> > Daniel
> >=20
>=20
> I cribbed the source from [0] and tested before and after. I think
> this
> should work. Mind giving it a try?
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..e9176a5ce215 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9206,6 +9206,8 @@ static s64 get_constant_map_key(struct
> bpf_verifier_env *env,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return reg->var_off.value;
> =C2=A0}
>=20
> +static bool can_elide_value_nullness(enum bpf_map_type type);
> +
> =C2=A0static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct bpf_call_arg_meta *meta,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const struct bpf_func_proto *fn,
> @@ -9354,9 +9356,11 @@ static int check_func_arg(struct
> bpf_verifier_env *env, u32 arg,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 err =3D check_helper_mem_access(env, regno, key_size,
> BPF_READ, false, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (err)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return e=
rr;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 meta->const_map_key =3D get_constant_map_key(env, reg,
> key_size);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (meta->const_map_key < 0 && meta->const_map_key !=3D
> -EOPNOTSUPP)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return meta->c=
onst_map_key;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (can_elide_value_nullness(meta->map_ptr-
> >map_type)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->const_ma=
p_key =3D
> get_constant_map_key(env, reg, key_size);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (meta->cons=
t_map_key < 0 && meta-
> >const_map_key !=3D -EOPNOTSUPP)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return meta->const_map_key;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARG_PTR_TO_MAP_VALUE:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (type_may_be_null(arg_type) &&
> register_is_null(reg))
>=20
> Thanks,
> Daniel
>=20
>=20
> [0]:
> https://github.com/libvirt/libvirt/blob/c1166be3475a0269f5164d87fec6227d6=
cb34b47/src/util/vircgroupv2devices.c#L66-L135

Thanks, I tried this in isolation and it fixed the issue for me.
I talked to Mark and he will try it with his libvirt scenario.

The code looks reasonable to me, but I have a small concern regarding
what will happen if the BPF code uses a -EOPNOTSUPP immediate with an
array. Unlike other immediates, IIUC this will cause check_func_arg()
to return 0. Is there a reason to have this special?

