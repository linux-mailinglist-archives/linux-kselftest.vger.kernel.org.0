Return-Path: <linux-kselftest+bounces-13740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5134093195E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1101F22919
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1C446D1;
	Mon, 15 Jul 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM1epBm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD43BB2E;
	Mon, 15 Jul 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064740; cv=none; b=C0SxWltFOJirgoCqZPWY2mu8nsP26FfnsxOOm/XRw8IhHscT0vBisJT2hlG3I1+LACTB/4CJ9amWJWur4BRn6W/80QbzjVChBPtOvGQE5ZXAmOr+X/QyJBhdeqSCWvrxnQfPPx7NhduqWBitwhf+i0dOxsgulLo4KVt38MfQQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064740; c=relaxed/simple;
	bh=Ld9cDA3lpvsmdK2nYMlNTaSs7LqOmiT44dFooljuzFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahzpVeljORVpOEKINGw8zUM13e5rOb2oHiAGCYTFMCi2L2EXaKeqEDy+2m0++AQtMT5EhkgpNkE3Ym3BckO2i3br7hdciUPw9RVhp1HiokcBk4JDbZ6HyQYvAelS0BUxDWv/jWL/0hQMZBy6vNsjno5ATDSUvEksVPMikG41AA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM1epBm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31650C32782;
	Mon, 15 Jul 2024 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064739;
	bh=Ld9cDA3lpvsmdK2nYMlNTaSs7LqOmiT44dFooljuzFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SM1epBm8MSPpexKCCvXL47i3FptPaZ7EwLUvGLmtJ6ozHQsxV0KGTr5X2ZTn9Kp2b
	 khWr7AhKUiHuFvnypUfCmpcco40pRewuepBENg5u82267UBftGC2VAatmDrfdqqR2m
	 39CoC+mFoIg3KJPLnyrrXK5VIF95uAbE1osE1q/MH8I22Ib1FKfYsLgflrhH3xthit
	 qdEn9j12mvVHR4Do9yYxhbdysWJdm7FUS9+Ii0/+PkQ3AAZuGo9Pb4TQPsqPxkFHzE
	 UHI+kUA/m7NwpiwEjBfYzzZ3/oq729MLenpcuMKrI2XN4TYN6KxOs8r4T1x2OxkgOp
	 fIDMVXPCI2LLA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Manu Bretelle
 <chantra@meta.com>, KP Singh <kpsingh@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@meta.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent
 Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
In-Reply-To: <CAADnVQKXEM5LaGktduyG=EH+2udkH-ZJpo4u57BUchregJy8NQ@mail.gmail.com>
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
 <mb61p5xtcyqo5.fsf@kernel.org>
 <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
 <mb61pjzhmpqff.fsf@kernel.org>
 <CAADnVQKXEM5LaGktduyG=EH+2udkH-ZJpo4u57BUchregJy8NQ@mail.gmail.com>
Date: Mon, 15 Jul 2024 17:32:09 +0000
Message-ID: <mb61p8qy28sti.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Jul 15, 2024 at 9:32=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>>
>> Hi Daniel, Manu
>> I was able to reproduce this issue on KVM and found the root cause for
>> this hang! The other issue that we fixed is unrelated to this hang and
>> doesn't occur on self hosted github runners as they use 48-bit VAs.
>>
>> The userspace test code has:
>>
>>     #define STACK_SIZE (1024 * 1024)
>>     static char child_stack[STACK_SIZE];
>>
>>     cpid =3D clone(do_sleep, child_stack + STACK_SIZE, CLONE_FILES | SIG=
CHLD, fexit_skel);
>>
>> arm64 requires the stack pointer to be 16 byte aligned otherwise
>> SPAlignmentFault occurs, this appears as Bus error in the userspace.
>>
>> The stack provided to the clone system call is not guaranteed to be
>> aligned properly in this selftest.
>>
>> The test hangs on the following line:
>>     while (READ_ONCE(fexit_skel->bss->fentry_cnt) !=3D 2);
>>
>> Because the child process is killed due to SPAlignmentFault, the
>> fentry_cnt remains at 0!
>>
>> Reading the man page of clone system call, the correct way to allocate
>> stack for this call is using mmap like this:
>>
>> stack =3D mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | M=
AP_ANONYMOUS | MAP_STACK, -1, 0);
>>
>> This fixes the issue, I will send a patch to use this and once again
>> remove this test from DENYLIST and I hope this time it fixes it for good.
>
> Wow. Great find. Good to know.
> prog_tests/ns_current_pid_tgid.c has the same issue probably.

Yes, I checked that test as well using gdb and fortunately it gets a 16
byte aligned stack pointer, but this is just luck, so I will send a
patch to fix that test as well.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZpVdGhQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2ncNtAP9ccbKwshl53VerOv2daBOQnK2BZ41e
aLgFtIkQzm5jVQEAnvyxFRzuNIA60GgUagu+nAhYZ/Voo3z3sxJvjHAIwww=
=Jnla
-----END PGP SIGNATURE-----
--=-=-=--

