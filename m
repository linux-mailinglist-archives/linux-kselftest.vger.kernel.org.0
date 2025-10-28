Return-Path: <linux-kselftest+bounces-44185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AAAC15149
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 15:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599EA1AA7075
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B8340D93;
	Tue, 28 Oct 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BPIkvW+J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E9340D86
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660276; cv=none; b=QQFTao8RV2bKu8w5jE+ESUR9xsktjEFEkB/+FRRQYWh8C+xIU52fLeI+CwAyfwKrnJMpGcHxi5sEeW5vy1WLdGZmJsc7hQrlrPMJmJBRKzDMQ3TiAV6Yw05ifHL1FIg90U/rbfOu6OFvq7+TMtSlN02BlpJdVKq/yh9P8vMtUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660276; c=relaxed/simple;
	bh=ooS8JvtU0J4Naf7S3re4qX5H2CpAW6f+EdAuwISOM5o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kc/nBzMHiyRjnKAUmvjQ8qNrIl22N3CBk/mB7mM/VcvhcuZ1LGrACG/Oo0LwzWo6flUJoHMzadYa5ExW8wb+XEeWWjC+VMzfbF3C+v0m9pqYLe5dypvP2O4nLKrakSEv7WbwMm5KopreQKGhA7QKA2hu9vLcClGMRBMHhg3l6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BPIkvW+J; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6aec43557116e371b4bf637d72d65d72fee96f44.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjD/VnDX/WvvzkDxHTpw8SXoo2UNhddwV0169HZIrDo=;
	b=BPIkvW+J9rSuH0IdgzRXkrO3D6rTgMlPwTkEiuCE/ppOd8A5lxCryMn8dSlnJrOSIw3GhC
	4bU6zqvo04jEXZkYWSgsPcB22SXl7p6OyEbObOSq3FoCY7KzeABWsY8uJkWwoNB5cJ9fl2
	Riao/1SfATQe0cv31qHaARLFQLr/bPg=
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for BPF_JGT on
 same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net,  john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org,  yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org,
 shuah@kernel.org, paul.chaignon@gmail.com, m.shachnai@gmail.com, 
 harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de,  bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Date: Tue, 28 Oct 2025 22:04:17 +0800
In-Reply-To: <3e3643bdbad74611b5c00bb2d5931647dc7b8208.camel@gmail.com>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
	 <20251025053017.2308823-3-kafai.wan@linux.dev>
	 <3e3643bdbad74611b5c00bb2d5931647dc7b8208.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2025-10-27 at 12:40 -0700, Eduard Zingerman wrote:
> On Sat, 2025-10-25 at 13:30 +0800, KaFai Wan wrote:
> > Add a test to verify that conditional jumps using the BPF_JGT opcode on
> > the same register (e.g., "if r0 > r0") do not trigger verifier BUG
> > warnings when the register contains a scalar value with range informati=
on.
> >=20
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
>=20
> Could you please add test cases for JSET and for one of the *E
> variants?

ok, i will add the tests in v3.
>=20
> > =C2=A0.../selftests/bpf/progs/verifier_bounds.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 ++++++++++++++++++
> > =C2=A01 file changed, 18 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > index 0a72e0228ea9..1536235c3e87 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> > @@ -1709,4 +1709,22 @@ __naked void jeq_disagreeing_tnums(void *ctx)
> > =C2=A0	: __clobber_all);
> > =C2=A0}
> > =C2=A0
> > +SEC("socket")
> > +__description("JGT on same register")
> > +__success __log_level(2)
> > +__retval(0)
> > +__naked void jgt_same_register(void *ctx)
> > +{
> > +	asm volatile("			\
> > +	call %[bpf_get_prandom_u32];	\
> > +	w8 =3D 0x80000000;		\
> > +	r0 &=3D r8;			\
> > +	if r0 > r0 goto +1;		\
> > +	r0 =3D 0;				\
> > +	exit;				\
> > +"	:
> > +	: __imm(bpf_get_prandom_u32)
> > +	: __clobber_all);
> > +}
> > +
> > =C2=A0char _license[] SEC("license") =3D "GPL";

--=20
Thanks,
KaFai

