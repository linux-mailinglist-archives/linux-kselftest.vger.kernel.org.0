Return-Path: <linux-kselftest+bounces-44109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89629C0F030
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E3114FA694
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F330C62D;
	Mon, 27 Oct 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+2T6J8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303C30C34E;
	Mon, 27 Oct 2025 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579328; cv=none; b=q8r+s1FfPEm2ZgkFhTnSWOBYMGI3H3SKv1PfrXs7c/ynSbobuBabzWgKTlj/rjSx6eGCy65loxgmouUfjcBMEC28yb+feXhigfMUvyxiyolk/iPm4ZiNqWIMazZtdD85Ww9rVVX83TgQv3JiE1vxqoaikNbtbghjaBY8G68yDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579328; c=relaxed/simple;
	bh=2jKlo9CQ/dgzw3BhTA23TcVV3xpme89NObWAlxIMQwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DS0ySE36gwvze1KOzbR/XuqmkSdfUcvWod7rJf2I8RHoQaB26Fc0pFqMpPEjrIXUZOEEx5B25v51sN5KsdxTHbrvTO1hRmjW+m9KzChHtFCKE2VhRJR4okJTVT8tLdY4OE6Gyl0bZc3Ga/nw+wA0WtIuXnUs68G58IGVP5KNw8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+2T6J8Y; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <769c6167e9e650348f92b90c538b93c565a9ae11.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761579324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPoQ5R6AJCTgJgv4zmVqGWOWmnF17b06dGH2ttmgY3E=;
	b=G+2T6J8Y46X7fBUECpVr9zzKh3p7TLcgEv+4WME/UG6QlxoyNr98VGDWgUCKLmAY17gsxA
	bE4SXhmrT3IRPLUfx28q5i3MKX53ZbONg3mYaxHswMLZm2IRtnvj08jOrlloa5U5w91ZNh
	9cpsnCaFeHjw4kOc1keD5EDgb213hQ4=
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix tnum_overlap to check for zero
 mask first
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org,  yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com,  memxor@gmail.com,
 harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com, 
 luis.gerhorst@fau.de, shung-hsi.yu@suse.com, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Date: Mon, 27 Oct 2025 23:35:05 +0800
In-Reply-To: <20251026163806.3300636-2-kafai.wan@linux.dev>
References: <20251026163806.3300636-1-kafai.wan@linux.dev>
	 <20251026163806.3300636-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Sorry, this patch is wrong, please ignore.

On Mon, 2025-10-27 at 00:38 +0800, KaFai Wan wrote:
> Syzbot reported a kernel warning due to a range invariant violation in
> the BPF verifier. The issue occurs when tnum_overlap() fails to detect
> that two tnums don't have any overlapping bits.
>=20
> The problematic BPF program:
> =C2=A0=C2=A0 0: call bpf_get_prandom_u32
> =C2=A0=C2=A0 1: r6 =3D r0
> =C2=A0=C2=A0 2: r6 &=3D 0xFFFFFFFFFFFFFFF0
> =C2=A0=C2=A0 3: r7 =3D r0
> =C2=A0=C2=A0 4: r7 &=3D 0x07
> =C2=A0=C2=A0 5: r7 -=3D 0xFF
> =C2=A0=C2=A0 6: if r6 =3D=3D r7 goto <exit>
>=20
> After instruction 5, R7 has the range:
> =C2=A0=C2=A0 R7: u64=3D[0xffffffffffffff01, 0xffffffffffffff08] var_off=
=3D(0xffffffffffffff00; 0xf)
>=20
> R6 and R7 don't overlap since they have no agreeing bits. However,
> is_branch_taken() fails to recognize this, causing the verifier to
> refine register bounds and end up with inconsistent bounds:
>=20
> =C2=A0=C2=A0 6: if r6 =3D=3D r7 goto <exit>
> =C2=A0=C2=A0 R6: u64=3D[0xffffffffffffff01, 0xffffffffffffff00] var_off=
=3D(0xffffffffffffff00, 0x0)
> =C2=A0=C2=A0 R7: u64=3D[0xffffffffffffff01, 0xffffffffffffff00] var_off=
=3D(0xffffffffffffff00, 0x0)
>=20
> The root cause is that tnum_overlap() doesn't properly handle the case
> where the masks have no overlapping bits.
>=20
> Fix this by adding an early check for zero mask intersection in tnum_over=
lap().
>=20
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Fixes: f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken logic")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
> =C2=A0kernel/bpf/tnum.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index f8e70e9c3998..af2f38b4f840 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
> =C2=A0{
> =C2=A0	u64 mu;
> =C2=A0
> +	if ((a.mask & b.mask) =3D=3D 0)
> +		return false;
> =C2=A0	mu =3D ~a.mask & ~b.mask;
> =C2=A0	return (a.value & mu) =3D=3D (b.value & mu);
> =C2=A0}

--=20
Thanks,
KaFai

