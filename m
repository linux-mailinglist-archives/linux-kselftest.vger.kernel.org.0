Return-Path: <linux-kselftest+bounces-34134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE50ACACF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 13:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E5A162533
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA1204840;
	Mon,  2 Jun 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJvGo5Eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99A1A0BE0
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862308; cv=none; b=J6LjUKVUrajv64KjsFWCh+fMFE3Gzq71dsKNkL5tWxb+NkflqJ/AD9udszzsgc5e88Wjy74tuOyEii7KTaOELgRtjkdhQZ7d9iHObzjEK81qeH7DupVCWmYw+emxFB18y2XZrzGcBqv9uTPf1bozSHOgj04M9hjOgYVhqbwQuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862308; c=relaxed/simple;
	bh=A4OkNO6pKJdoJr7vYx9FCXoetIQb+v3bG4umPUpfy0U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=mOqQ1ZPg+ISw41U3SQlQCQuu2IwrLh20Yt7tdGkewyocu+on2Hkgoc0Lo0aFXO5c7NyfE8+nGydyGT+ft5IrfMITJPyyf+hBkeClD6mG56urxFWorxMSaun4Sx6Ut6QJw/LrHKs5E+sbq476cAOrUGjk06981+J5xWhbtQMrSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJvGo5Eu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748862292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgzGn7mX9LPHdW6wIq04NEoY4o/2aPy+ycvjiVMwLpA=;
	b=RJvGo5Eu4br18T4wfwZrZxPFmIVPvINsrBo79u62AgI5wKOCaCRHE5yQvXLFeAq1u04q7N
	FBhRi1ecNlz/GAEFqwRlNVaOJYJYYo9zPrbLJtzhOBJSXiooO43G0A3vV6B3AcV6RBQC9Y
	LKGiZjm0w1tEwp6JhnEU7ycN1A/x6fY=
Date: Mon, 02 Jun 2025 11:04:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <d99805aaeadd9cd041c9048801084648832a6da1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/2] bpf,ktls: Fix data corruption when using
 bpf_msg_pop_data() in ktls
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, "Boris Pismenny" <borisp@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Mykola Lysenko"
 <mykolal@fb.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Ihor Solodrai"
 <isolodrai@meta.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <aDika2FRd4n+VRmZ@pop-os.localdomain>
References: <20250523131915.19349-1-jiayuan.chen@linux.dev>
 <20250523131915.19349-2-jiayuan.chen@linux.dev>
 <aDika2FRd4n+VRmZ@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

2025/5/30 02:16, "Cong Wang" <xiyou.wangcong@gmail.com> =E5=86=99=E5=88=
=B0:



>=20
>=20On Fri, May 23, 2025 at 09:18:58PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> When sending plaintext data, we initially calculated the correspond=
ing
> >=20
>=20>  ciphertext length. However, if we later reduced the plaintext data=
 length
> >=20
>=20>  via socket policy, we failed to recalculate the ciphertext length.
> >=20
>=20>=20=20
>=20>=20
>=20>  This results in transmitting buffers containing uninitialized data=
 during
> >=20
>=20>  ciphertext transmission.
> >=20
>=20>=20=20
>=20>=20
>=20>  This causes uninitialized bytes to be appended after a complete
> >=20
>=20>  "Application Data" packet, leading to errors on the receiving end =
when
> >=20
>=20>  parsing TLS record.
> >=20
>=20>=20=20
>=20>=20
>=20>  Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> >=20
>=20>  Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  net/tls/tls_sw.c | 15 +++++++++++++++
> >=20
>=20>  1 file changed, 15 insertions(+)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> >=20
>=20>  index fc88e34b7f33..b23a4655be6a 100644
> >=20
>=20>  --- a/net/tls/tls_sw.c
> >=20
>=20>  +++ b/net/tls/tls_sw.c
> >=20
>=20>  @@ -872,6 +872,21 @@ static int bpf_exec_tx_verdict(struct sk_msg =
*msg, struct sock *sk,
> >=20
>=20>  delta =3D msg->sg.size;
> >=20
>=20>  psock->eval =3D sk_psock_msg_verdict(sk, psock, msg);
> >=20
>=20>  delta -=3D msg->sg.size;
> >=20
>=20>  +
> >=20
>=20>  + if ((s32)delta > 0) {
> >=20
>=20>  + /* It indicates that we executed bpf_msg_pop_data(),
> >=20
>=20>  + * causing the plaintext data size to decrease.
> >=20
>=20>  + * Therefore the encrypted data size also needs to
> >=20
>=20>  + * correspondingly decrease. We only need to subtract
> >=20
>=20>  + * delta to calculate the new ciphertext length since
> >=20
>=20>  + * ktls does not support block encryption.
> >=20
>=20>  + */
> >=20
>=20>  + if (!WARN_ON_ONCE(!ctx->open_rec)) {
> >=20
>=20
> I am wondering if we need to WARN here? Because the code below this
>=20
>=20handles it gracefully:
>=20

Hi=20Cong

The ctx->open_rec is freed after a TLS record is processed (regardless
of whether the redirect check passes or triggers a redirect).
The 'if (rec)' check in the subsequent code you print is indeed designed
to handle the expected lifecycle state of open_rec.

But the code path I modified should never see a NULL open_rec under norma=
l
operation As this is a bug fix, I need to ensure the fix itself doesn't
create new issues.=20

Thanks.


>=20 931 bool reset_eval =3D !ctx->open_rec;
>=20
>=20 932=20
>=20
>  933 rec =3D ctx->open_rec;
>=20
>=20 934 if (rec) {
>=20
>=20 935 msg =3D &rec->msg_plaintext;
>=20
>=20 936 if (!msg->apply_bytes)
>=20
>=20 937 reset_eval =3D true;
>=20
>=20 938 }
>=20
>=20 939 if (reset_eval) {
>=20
>=20 940 psock->eval =3D __SK_NONE;
>=20
>=20 941 if (psock->sk_redir) {
>=20
>=20 942 sock_put(psock->sk_redir);
>=20
>=20 943 psock->sk_redir =3D NULL;
>=20
>=20 944 }
>=20
>=20 945 }
>=20
>=20Thanks for fixing it!
>=20
>=20Cong
>

