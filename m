Return-Path: <linux-kselftest+bounces-13320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F892A5C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1535E282028
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48DB13EFF3;
	Mon,  8 Jul 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq7WV/bR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758813AA2B;
	Mon,  8 Jul 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452932; cv=none; b=GAQn3lx8ylCIA9d1rGISsKkzg3Swvlt/y3koFyZmgYNTpu4PbjZPG9oNu0zYtWiEuSF9NA/7zb2MyBLiAMYcWDl1rMveBoRWBy+kVZUTaO49938z7pfmZCmUhNFHzF98d8P1BrRxtiLSoy82FYaE/4Dx6ZBgR+P938y7iEcVHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452932; c=relaxed/simple;
	bh=LymzIXFG81NnbVQNmq2RHcpSnmq/qlynscbuDCrr8VU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ucWR74JHEcg1SKfIpXnb/j2eS78c81io65W7r+0O2Y6ThbDjWCb+Ybpz65iPCJLzbJPIcbLn5tH3OXYqfCznm/PP45fhBP8oJriXLb/7ECJ/Ug5JJBMY3HBrwxyOS6SKy5lCNkCNHnaNX5kBaZCSvBCdOcufEt0cL0sBr5mxQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq7WV/bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F60C116B1;
	Mon,  8 Jul 2024 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452932;
	bh=LymzIXFG81NnbVQNmq2RHcpSnmq/qlynscbuDCrr8VU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bq7WV/bRfp5tm7SJwxMVVfnCsT6NDxp1dpx7XBnWCsS0nk3/Bye5EGx2SRiP4jb8P
	 Zdboqiip0ahuwxIKlRcxTXNETKOFzm9nhAGWMsjvSwdDVYj8QiSb3wCS6vOLIte07D
	 0jYJ0iVGT0qn0fLMJRi+7pSM4znqs6qEs7rKTo0FUsoBRarO22iAkLwGIb4Fkokcw8
	 DUdG2UqzhqM7HPHiokSa/nODkbH5meJhpzAcE2XTP3G+hV5MpaVzZruku9cui637ss
	 IdCvS4HlMQpkJYONY4NFV3uDxypJltS3en8rc6f4YKvM/wxm0yvPJmPixjUHoc+28H
	 alqN3jE5kAZwQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>, Florent
 Revest <revest@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
In-Reply-To: <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
Date: Mon, 08 Jul 2024 15:35:24 +0000
Message-ID: <mb61ped836gn7.fsf@kernel.org>
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

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 7/8/24 5:26 PM, KP Singh wrote:
>> On Mon, Jul 8, 2024 at 5:00=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>>
>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>
>>>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
>>>>> fexit_sleep test runs successfully now on the CI so remove it from the
>>>>> deny list.
>>>>
>>>> Do you happen to know which commit fixed it? If yes, might be nice to =
have it
>>>> documented in the commit message.
>>>
>>> Actually, I never saw this test failing on my local setup and yesterday
>>> I tried running it on the CI where it passed as well. So, I assumed that
>>> this would be fixed by some commit. I am not sure which exact commit
>>> might have fixed this.
>>>
>>> Manu, Martin
>>>
>>> When this was added to the deny list was this failing every time and did
>>> you have some reproducer for this. If there is a reproducer, I can try
>>> fixing it but when ran normally this test never fails for me.
>>=20
>> I think this never worked until
>> https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium.or=
g/
>> was merged, FTrace direct calls was blocking tracing programs on ARM,
>> since then it has always worked.
>
> Awesome, thanks! I'll add this to the commit desc then when applying.

The commit that added this to the deny list said:
31f4f810d533 ("selftests/bpf: Add fexit_sleep to DENYLIST.aarch64")

```
It is reported that the fexit_sleep never returns in aarch64.
The remaining tests cannot start.
```

So, if the lack of Ftrace direct calls would be the reason then the
failure would be due to fexit programs not being supported on arm64.

But this says that the selftest never returns therefore is not related
to ftrace direct call support but another bug?

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZowHPRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nc7hAP9t3PLfFY0hJyZ/XSqBK6NC1A99VLl1
7RR5XOfGPUB26wD/VwKM4GfZN1o/DuCEzZUj+NqKTkkiHr33DQS9qguFWQU=
=BtrD
-----END PGP SIGNATURE-----
--=-=-=--

