Return-Path: <linux-kselftest+bounces-25431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C78A233F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 19:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ACD3A5CD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449D1F03F1;
	Thu, 30 Jan 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="SIYI2UPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGJxb52a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD21487E1;
	Thu, 30 Jan 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262543; cv=none; b=cfA/6ydnkhOjQV8Jl26h+L5XtGn+nuImMo64Xf4rrHLUPLQZj0zv4eClyi1W4GZSO66rHwcNtkE1Gf+EVllrnRJh8E3DDaJmvKoKA5EV0Fjiu9caJZAQm6/ZmM2yTE1q1K2ltw5v4JfRKrl+uiKLa4cuUvbIIkLYli9DSNAeCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262543; c=relaxed/simple;
	bh=g0IQwxMYVVFXX2ZDTdvXAiamvpAiO+krIPQp++uGEec=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IEozjyoJ8ronrm9fHZYyzb7A+KBRy6hN1heIQscCdxtetfdrRv2+nFhUJyDM99r30TujernIuudrxEfnlJhv2YB9MoOB+29bwwNO6jNec8iBDR93hOfSAVyOt4UcCyb/kRGYQ6A93bDT+Q9SM2071AHN4pVdX3hh4BVm336p5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=SIYI2UPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sGJxb52a; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B84081140100;
	Thu, 30 Jan 2025 13:42:19 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jan 2025 13:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738262539;
	 x=1738348939; bh=Z9bH9AOEMGGz/NR9FlqFzvsaqJ/UrZx/S0LGxttDpvc=; b=
	SIYI2UPcEjF5HcjpRsfjFTPQtwe4jgR0bCGFcHSXiCla5Y4y5khnAIvv9WvEi3Cb
	BRmVtf28CvGbosSqlN6IQJk411SGJOgIjInQ4ng5b+jQST1eQZu1dRULmRqTss4X
	lsWuuoj111SWFawQsVJlWLylFEKts71PPuExgplx50sWKIckMtm25KJKZZkPVzC8
	eQ1U5iOPTfRRkoFE4C+p62S3zXPmCxtE3lXXH1Kj1VBBByhwDHcixtN8rEsl7Wqm
	nPbytlFrXRt3STtHhwSZt9b/SBik+HH06bNameG8y8jFD2xIbCpZt13kdMFKmt8H
	24mIEynV+euJyPLVw/bpQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738262539; x=
	1738348939; bh=Z9bH9AOEMGGz/NR9FlqFzvsaqJ/UrZx/S0LGxttDpvc=; b=s
	GJxb52aQpaiX/9m91Wv6xvjGVh0l0GocgdN6Bwbu+FafDvkGHryzLBMrZvUpBJWq
	v6AAnV8SCL5JFaSJZcDDlS8DkKlJvOlAssGE5/DpzGhuINekfNBqJG4JmuUiUdxx
	2yDMpZJM5ami4SUkD1wz7qnASkmsVmKGjocno8VUPUrSC82xNi50mCHl2psS8rig
	ge3fS7hAgY/aPTGMIYJC7aD1htDQ8lD6IJOoDbOLXnl0R9C9AgCBFcXzfDnuhB5g
	3kJMC5luvUZjCheGvhubMwDfslLJvBuapb6ilO1HiCoU/lcQtGocXrKQL+dPrqC+
	jHh0nG9gbLooX4wNvkQ2w==
X-ME-Sender: <xms:CsibZ0RCX2RniUwj5NA7a-JRF5VLBxDb5JWyxAY84gbexV4aqsYkrA>
    <xme:CsibZxxrvqiEd0LFmGPM1m-fFF3mp_lP_rM3o4s8l_AYKNbDn2N8y4eeROz33F3g-
    uuAgy-3dbFhnKmwqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeduveeiffekveffieeh
    hfdtffdtveetjeefieevveffveevudetkeffffelleenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudelpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthho
    pehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepvgguugihiiekjeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdr
    tghomhdprhgtphhtthhopehhrgholhhuohesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghnughrihhi
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CsibZx0bf-oM7sRzQD2nQwp7CJxC32Z_awPJdUTEMa4p64dcG3vJwQ>
    <xmx:CsibZ4AFGnRDSnGphGEfzvlMo9fxFMRxUFDTJcaG2x8tKmP9GTng5w>
    <xmx:CsibZ9gbSR6KnXYZ7FykB_EqKbxNURAdWMKoINs36Qn2BVCy8YT81w>
    <xmx:CsibZ0qHKxDFCm0uDWMH62yEde5v1vR9vVd_9UQykZVJ2BSUc6u95w>
    <xmx:C8ibZ2ZkX53eIRsKzYFQJnsDHp84WSNOKVoG9X0ZBwDYaAnn9eT46acm>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1E0B18A006B; Thu, 30 Jan 2025 13:42:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jan 2025 10:41:58 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Shuah Khan" <shuah@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Marc Hartmayer" <mhartmay@linux.ibm.com>
Message-Id: <20f56c02-688d-4f22-97dc-cc5b3800de3f@app.fastmail.com>
In-Reply-To: <ae5e32ff2269eb4c190aeb882b17cb1bb8e6c70d.camel@linux.ibm.com>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
 <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
 <78b2e750b4568e294b5fc5a33cf4bc8f62fae7f6.camel@linux.ibm.com>
 <hsgmutuoi4kvjkr7erm5ty2fdrhdrjpz4fpp5doe65l3pzguxv@lcbmvmjpyykq>
 <f7rhmwrp3fgx3qd7gn3pzczxeztvsg45u4vrl6ls3ylcvflapx@3yi3shfnrmb3>
 <ae5e32ff2269eb4c190aeb882b17cb1bb8e6c70d.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map lookup nullness
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On Thu, Jan 30, 2025, at 2:06 AM, Ilya Leoshkevich wrote:
> On Wed, 2025-01-29 at 10:45 -0700, Daniel Xu wrote:
>> On Wed, Jan 29, 2025 at 09:49:12AM -0700, Daniel Xu wrote:
>> > Hi Ilya,
>> >=20
>> > On Wed, Jan 29, 2025 at 03:58:54PM +0100, Ilya Leoshkevich wrote:
>> > > On Tue, 2025-01-14 at 13:28 -0700, Daniel Xu wrote:
>> > > > This commit allows progs to elide a null check on statically
>> > > > known
>> > > > map
>> > > > lookup keys. In other words, if the verifier can statically
>> > > > prove
>> > > > that
>> > > > the lookup will be in-bounds, allow the prog to drop the null
>> > > > check.
>> > > >=20
>> > > > This is useful for two reasons:
>> > > >=20
>> > > > 1. Large numbers of nullness checks (especially when they
>> > > > cannot
>> > > > fail)
>> > > > =C2=A0=C2=A0 unnecessarily pushes prog towards
>> > > > BPF_COMPLEXITY_LIMIT_JMP_SEQ.
>> > > > 2. It forms a tighter contract between programmer and verifier.
>> > > >=20
>> > > > For (1), bpftrace is starting to make heavier use of percpu
>> > > > scratch
>> > > > maps. As a result, for user scripts with large number of
>> > > > unrolled
>> > > > loops,
>> > > > we are starting to hit jump complexity verification errors.=C2=A0
>> > > > These
>> > > > percpu lookups cannot fail anyways, as we only use static key
>> > > > values.
>> > > > Eliding nullness probably results in less work for verifier as
>> > > > well.
>> > > >=20
>> > > > For (2), percpu scratch maps are often used as a larger stack,
>> > > > as the
>> > > > currrent stack is limited to 512 bytes. In these situations, it
>> > > > is
>> > > > desirable for the programmer to express: "this lookup should
>> > > > never
>> > > > fail,
>> > > > and if it does, it means I messed up the code". By omitting the
>> > > > null
>> > > > check, the programmer can "ask" the verifier to double check
>> > > > the
>> > > > logic.
>> > > >=20
>> > > > Tests also have to be updated in sync with these changes, as
>> > > > the
>> > > > verifier is more efficient with this change. Notable, iters.c
>> > > > tests
>> > > > had
>> > > > to be changed to use a map type that still requires null
>> > > > checks, as
>> > > > it's
>> > > > exercising verifier tracking logic w.r.t iterators.
>> > > >=20
>> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> > > > ---
>> > > > =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 92
>> > > > ++++++++++++++++++-
>> > > > =C2=A0tools/testing/selftests/bpf/progs/iters.c=C2=A0=C2=A0=C2=A0=
=C2=A0 | 14 +--
>> > > > =C2=A0.../selftests/bpf/progs/map_kptr_fail.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> > > > =C2=A0.../selftests/bpf/progs/verifier_map_in_map.c |=C2=A0 2 +-
>> > > > =C2=A0.../testing/selftests/bpf/verifier/map_kptr.c |=C2=A0 2 +-
>> > > > =C2=A05 files changed, 99 insertions(+), 13 deletions(-)
>> > >=20
>> > > [...]
>> > >=20
>> > > > @@ -9158,6 +9216,7 @@ static int check_func_arg(struct
>> > > > bpf_verifier_env *env, u32 arg,
>> > > > =C2=A0	enum bpf_arg_type arg_type =3D fn->arg_type[arg];
>> > > > =C2=A0	enum bpf_reg_type type =3D reg->type;
>> > > > =C2=A0	u32 *arg_btf_id =3D NULL;
>> > > > +	u32 key_size;
>> > > > =C2=A0	int err =3D 0;
>> > > > =C2=A0
>> > > > =C2=A0	if (arg_type =3D=3D ARG_DONTCARE)
>> > > > @@ -9291,8 +9350,13 @@ static int check_func_arg(struct
>> > > > bpf_verifier_env *env, u32 arg,
>> > > > =C2=A0			verbose(env, "invalid map_ptr to
>> > > > access map-
>> > > > > key\n");
>> > > > =C2=A0			return -EACCES;
>> > > > =C2=A0		}
>> > > > -		err =3D check_helper_mem_access(env, regno,
>> > > > meta-
>> > > > > map_ptr->key_size,
>> > > > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_READ, false,
>> > > > NULL);
>> > > > +		key_size =3D meta->map_ptr->key_size;
>> > > > +		err =3D check_helper_mem_access(env, regno,
>> > > > key_size,
>> > > > BPF_READ, false, NULL);
>> > > > +		if (err)
>> > > > +			return err;
>> > > > +		meta->const_map_key =3D
>> > > > get_constant_map_key(env, reg,
>> > > > key_size);
>> > > > +		if (meta->const_map_key < 0 && meta-
>> > > > >const_map_key
>> > > > !=3D -EOPNOTSUPP)
>> > > > +			return meta->const_map_key;
>> > >=20
>> > > Mark Hartmayer reported a problem that after this commit the
>> > > verifier
>> > > started refusing to load libvirt's virCgroupV2DevicesLoadProg(),
>> > > which
>> > > contains the following snippet:
>> > >=20
>> > > 53: (b7) r1 =3D -1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ; R1_w=3D-1
>> > > 54: (7b) *(u64 *)(r10 -8) =3D r1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ; R1_w=3D-1 R10=3Dfp0 fp-8_w=3D-1
>> > > 55: (bf) r2 =3D r10=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ; R2_w=3Dfp0 R10=3Dfp0
>> > > 56: (07) r2 +=3D -8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ; R2_w=3Dfp-8
>> > > 57: (18) r1 =3D 0x9553c800=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R1_w=3Dmap_ptr(ks=3D8,vs=3D4)
>> > > 59: (85) call bpf_map_lookup_elem#1
>> > >=20
>> > > IIUC here the actual constant value is -1, which this code
>> > > confuses
>> > > with an error.
>> >=20
>> > Thanks for reporting. I think I know what the issue is - will send
>> > a
>> > patch shortly.
>> >=20
>> > Daniel
>> >=20
>>=20
>> I cribbed the source from [0] and tested before and after. I think
>> this
>> should work. Mind giving it a try?
>>=20
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9971c03adfd5..e9176a5ce215 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9206,6 +9206,8 @@ static s64 get_constant_map_key(struct
>> bpf_verifier_env *env,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return reg->var_off.value;
>> =C2=A0}
>>=20
>> +static bool can_elide_value_nullness(enum bpf_map_type type);
>> +
>> =C2=A0static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct bpf_call_arg_meta *meta,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const struct bpf_func_proto *fn,
>> @@ -9354,9 +9356,11 @@ static int check_func_arg(struct
>> bpf_verifier_env *env, u32 arg,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D check_helper_mem_access(env, regno, key_si=
ze,
>> BPF_READ, false, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (err)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 meta->const_map_key =3D get_constant_map_key(env, reg,
>> key_size);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (meta->const_map_key < 0 && meta->const_map_key !=3D
>> -EOPNOTSUPP)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return m=
eta->const_map_key;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (can_elide_value_nullness(meta->map_ptr-
>> >map_type)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->co=
nst_map_key =3D
>> get_constant_map_key(env, reg, key_size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (meta=
->const_map_key < 0 && meta-
>> >const_map_key !=3D -EOPNOTSUPP)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return meta->const_map_key;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ARG_PTR_TO_MAP_VALUE:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (type_may_be_null(arg_type) &&
>> register_is_null(reg))
>>=20
>> Thanks,
>> Daniel
>>=20
>>=20
>> [0]:
>> https://github.com/libvirt/libvirt/blob/c1166be3475a0269f5164d87fec62=
27d6cb34b47/src/util/vircgroupv2devices.c#L66-L135
>
> Thanks, I tried this in isolation and it fixed the issue for me.
> I talked to Mark and he will try it with his libvirt scenario.

Thanks for testing!=20

>
> The code looks reasonable to me, but I have a small concern regarding
> what will happen if the BPF code uses a -EOPNOTSUPP immediate with an
> array. Unlike other immediates, IIUC this will cause check_func_arg()
> to return 0. Is there a reason to have this special?

That's a good point. Lemme check on that.

Thanks,
Daniel

