Return-Path: <linux-kselftest+bounces-13586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93D92EA14
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6CC281B55
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0307C16078E;
	Thu, 11 Jul 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQuGXK4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956D14BFA2;
	Thu, 11 Jul 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706449; cv=none; b=ixJaziWfQ0OmUnYtoBTUavX5lTLvSm3OqGyRC+LCsyEAGOH027kTdp08SdjKBqLo0DA8AEHiGaUSVkM3y76JiQbl+NNtMviS6fqGDKXN/cCCwgtc8QDONyjsff4Fmz0sry/O6b42ejq9WZhGapnkp93cIQfD0DSTwRUU9XZjSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706449; c=relaxed/simple;
	bh=v6S/vPhexI0x/jZZefTx2eflhLTX1D20zwHbs7IUE4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ngq81FWJgKG6eZ7U8f2EKYE14wMjSzVKwUXlgc1KmZPXdbQfG8S75FKUeongdLzTFimU050ls+QUvmknhsM6R7li2YYEcEIWPoSPmvUzROsPfcHKEOv2VzU3Rrz0VhpoG9UBaIZ0UZ5a6JRPe1rYHCXpBv3AIMXFaDvX8fxdv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQuGXK4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB46C116B1;
	Thu, 11 Jul 2024 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720706449;
	bh=v6S/vPhexI0x/jZZefTx2eflhLTX1D20zwHbs7IUE4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jQuGXK4vMfYhGkWjnOBfCrYDXpIO9ttKLfbdoVn4cBbstbPFv+ud5HT/zc5TboGQs
	 1jgMLCg05LRuFUqRprlYo7cLXmQqd8mJT/pB8yV8HIv7uXd26oRIO5RuH/8wKEJnUv
	 MYQqcC4KavoLf/lrAYJP7Zv4hc8s2BfSLwWGsZKkILLadlyd9iXKOn2gimaK0/8bCE
	 H6RsNs3aqccdyimbJb3qwG2x+v1K+cZsnKDlC6iAm7r5msGjO1/tuykkMvjp2l+cVy
	 z0nuwGwoO2RidJiIonOn3/7CWiIAKwA5b0h+1+rmPDCkots4Sj+MQN0wF40R8RU7cL
	 z3DySNJkm6IZg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Manu Bretelle <chantra@meta.com>, Daniel Borkmann
 <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Alexei Starovoitov
 <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent
 Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
In-Reply-To: <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
Date: Thu, 11 Jul 2024 14:00:26 +0000
Message-ID: <mb61p5xtcyqo5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain


Hi,
I was able find the root cause of this bug and will send a fix soon!

> Unable to handle kernel paging request at virtual address ffff0000c2a80e68

We are running this test on Qemu with '-cpu max', this means 52-bit
virtual addresses are being used.

The trampolines generation code has the following two lines:

		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
		emit_call((const u64)__bpf_tramp_enter, ctx);

here the address of struct bpf_tramp_image is moved to R0 and passed as
an argument to __bpf_tramp_enter().

emit_addr_mov_i64() assumes that the address passed to it is in the
vmalloc space and uses at most 48 bits. It sets all the remaining bits
to 1.

but struct bpf_tramp_image is allocated using kzalloc() and when 52-bit
VAs are used, its address is not guaranteed to be 48-bit, therefore we
see this bug, where  0xfff[0]0000c2a80e68 is converted to
0xfff[f]0000c2a80e68 when the trampoline is generated.

The fix would be use emit_a64_mov_i64() for moving this address into R0.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZo/lexQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nSWSAP40+KBbPkhEalekcuIWtipqJNWvWOv+
HFovg3WjvmzQHQEApqvzcBklqoFjElN4F2mFoRixDur/X4XPbsFfhUiUoAY=
=0Kvm
-----END PGP SIGNATURE-----
--=-=-=--

