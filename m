Return-Path: <linux-kselftest+bounces-13307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1B929E9E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06419B21CE7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0055481B9;
	Mon,  8 Jul 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiWNSv4M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813532230F;
	Mon,  8 Jul 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429274; cv=none; b=HIiABF84CEpzum24jCpmn8wFm+zp8TysmiMAxj4s/A1/Dw9q1or3VoLWmC53o/CK74M/x/YjD50bxmtlvKDaUGSR6YoZNjx3rhZGSj1pBCSbXGCk1xcbIzsq95kUSf0WoJZht1QNx5lhTXYdc1HCT6eek/3qVs415GK4Y/iAgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429274; c=relaxed/simple;
	bh=G7Dca81lMSRaqm81bu8/Y8SoMKKKxH6gCOE0bmD6FX0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A60Rj8U/Avk2siq+txBL8/S6GfSffvBYMBooGI34z6EVIr4yMJQJyZARNk8h3eiWmBGxbW1ICX2Jv+uIuO/zk1lEexEln9oYjlcBmN5gHlkKQ6ghtVnZWOka49ErI61mEERBQGt9vKcsjMgUHEObdSXXAIdCMRGaXmNPedPq3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiWNSv4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC641C116B1;
	Mon,  8 Jul 2024 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720429274;
	bh=G7Dca81lMSRaqm81bu8/Y8SoMKKKxH6gCOE0bmD6FX0=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=QiWNSv4MPOC8qdh/aYWkLJgZOUSur/V8UWjtr0comuqPlVhDaqVn6RiPl49l/RX1w
	 IK0XHUtpl2slYi1GOkKgYPAlzgwijxvh9ERuCt2dEcXPTI9QEZHXDV2D2ScE06bvwz
	 zWeyY0TuFWFFob8MIb0mQIi75RX7WsjVPF80F9Y8vcjM9PXtZd58kTyOw78iwH21kF
	 XRtQO5jm3GseVuOyQNxV14OAjdgB1wW8aNmcKKB/fXrZ9vA0r6AGXD6XvERrRbUboj
	 QMcmsbbJpB3j4xRrfmeU6wA/g0j8R+PQTaOoSs8uusY1b/AsnkdS96B+Mbcx9yQMvx
	 zjgSpVxye251g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] arm64, bpf: Add 12-argument support for bpf
 trampoline
In-Reply-To: <5c43f532-c849-41c9-92dc-83925f5835d7@huaweicloud.com>
References: <20240705125336.46820-1-puranjay@kernel.org>
 <5c43f532-c849-41c9-92dc-83925f5835d7@huaweicloud.com>
Date: Mon, 08 Jul 2024 09:00:58 +0000
Message-ID: <mb61py16c45rp.fsf@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 7/5/2024 8:53 PM, Puranjay Mohan wrote:
>> The arm64 bpf JIT currently supports attaching the trampoline to
>> functions with <=3D 8 arguments. This is because up to 8 arguments can be
>> passed in registers r0-r7. If there are more than 8 arguments then the
>> 9th and later arguments are passed on the stack, with SP pointing to the
>> first stacked argument. See aapcs64[1] for more details.
>>=20
>> If the 8th argument is a structure of size > 8B, then it is passed fully
>> on stack and r7 is not used for passing any argument. If there is a 9th
>> argument, it will be passed on the stack, even though r7 is available.
>>=20
>> Add the support of storing and restoring arguments passed on the stack
>> to the arm64 bpf trampoline. This will allow attaching the trampoline to
>> functions that take up to 12 arguments.
>>=20
>> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst=
#parameter-passing
>>=20
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>> Changes in V1 -> V2:
>> V1: https://lore.kernel.org/all/20240704173227.130491-1-puranjay@kernel.=
org/
>> - Fixed the argument handling for composite types (structs)
>> ---
>>   arch/arm64/net/bpf_jit_comp.c                | 139 ++++++++++++++-----
>>   tools/testing/selftests/bpf/DENYLIST.aarch64 |   3 -
>>   2 files changed, 107 insertions(+), 35 deletions(-)
>>=20

[SNIP]

>>   fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach=
_kprobe_multi_opts unexpected error: -95
>
> It looks like this patch, similar to [1], also does not handle
> parameter alignment properly [2].
>
> For example:
>
> int func(__int128 a, __int128 b, __int128 c, int64_t d, __int128 e, int64=
_t f, __int128 g)
> {
> }
>
> parameter a~d are passed through register x0~x6, while parameter
> e~g are passed through stack. Since __int128 is 16-byte aligned,
> parameter e, f, and g should be placed at sp + 0, +16, and +32
> respectively, with 8 bytes **padding** between f and g.
>
>
> And the compiler's alignment or packed attribute may make things
> worse, causing parameters to be placed on the stack at positions
> that are not naturally aligned.

Hi Xu,
Thanks for explaining this. I was not aware that you have already sent a
patch[1] to add this support to arm64.

So, I see that it will be non-trivial to calculate padding for each
argument passed on the stack. If you are not planning to work on this
then I can try to implement it.

Alsoi, do we currently have a selftest that checks for this edge case? if
not I can try to add that too.

Thanks,
Puranjay

> [1] https://lore.kernel.org/bpf/20230917150752.69612-1-xukuohai@huaweiclo=
ud.com/
> [2] https://lore.kernel.org/bpf/CABRcYmLtk8aQEzoUFw+j5Rdd-MXf-q+i7RHXZtu-=
skjRz11ZDw@mail.gmail.com/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZouqyxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nbMPAQDpdTE3b1Tz96u8+mfJQWhg1vrpKyo3
h3Y2wiHVir54wQD6A5rJer1wPwC54AWaZBAj1PJBojyZt9Zp55oJTDTNqw0=
=z3XV
-----END PGP SIGNATURE-----
--=-=-=--

