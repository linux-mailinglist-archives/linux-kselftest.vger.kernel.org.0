Return-Path: <linux-kselftest+bounces-3733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75436841965
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 03:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02942288BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88C28E17;
	Tue, 30 Jan 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hNx5bJ5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76C36102;
	Tue, 30 Jan 2024 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582369; cv=none; b=aFUkcw7tUpiHAmjvJeh8q1JHND3EvoMa2qr/kRSbBlRw7XMMqoK1JHxfwVOd8BkTFKun8H/nLxBIIDoQRM79lRMRXi37KebI0hXr5giuvDKNu3TlkAYK08ITb3kp8Zn7SpofMD0JMIKs98hGEF1Om2D+Vh2q2TL2tXQthdzO6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582369; c=relaxed/simple;
	bh=mLIHH2Kvrz2ktWktDgk4SLJ9bsUAEwSpmycE93omaYE=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=FtiowyCTa6o1ceDUvUtQbrEqsgDj7wljcAVCamROTyuMmBKtsDhQehG/FH6wmqinoUvtO3OH8rv+3/xjTSUszJ2NVxiQsU96YhT+B+hSrGnBjKQvRhgHMWrgYRo0HRix0s72p0NmthrKSddvd5wRyuE+lg1YZgEjm4gKBOyJXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hNx5bJ5+; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706582057; bh=8E/e8D3rKgg6BW9Nd4UCl+YuxiR1gxvHcsdFPnL3EdQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=hNx5bJ5+SpHw5tdiee02HyZWtP19kF9j847pn/nwBcR6Z7o3RrYgOBjvMc2ftRj9v
	 gEmEG405XbEujdsNy1yk0RT6+84IKAM27dSljldg6u+z2RrANzhy3h11FcJbrK1Vec
	 qZw4xMHRNEMRuteM6fRKRFML5FYlx2cNv366R1IU=
Received: from smtpclient.apple ([2409:8934:22a2:1426:2cc9:5406:8a0:e7c])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 88D8D4CC; Tue, 30 Jan 2024 10:34:13 +0800
X-QQ-mid: xmsmtpt1706582053t6s5d0gw2
Message-ID: <tencent_F34C3BC7F1077728A62E84A7D183EF5BF005@qq.com>
X-QQ-XMAILINFO: NMiAo2azIaDAi/rSxKp8KRcmxf09H6ettD8ShiQpLNA1dpvHLxgnxVFZigU4i3
	 W3/Uj4QWneeWSrLx+HXIPnlVmO5QOmhKVgpheBN1/EwGlccRybQRtyPKJ5IWHh7DGaSVXLDeZMPk
	 zvC21+DUIouTcg9O2V/eCfUR3m+KdERxmSFvXbVgmDlSVZJYkd0oJl0HU0m/gKVd4WoAmKTDKGyl
	 mvZoA8QU16dF7RRDIXymDQ6Yque6O4oHsZitO7qgXjPN7ytF1zqmQYYCF0ua8L8XAyHHStc6+1fS
	 l/S245vc1dmc8hhOWBufdOp1y79Dd78+2zKXxQlp1TJ5vDHMIV5zESGxnIbGq16nBL905VKV6cvP
	 /lSL7OqHLZnawePU/UbCnSDAAfU6Csb3pwKbkczi3dIldg7fXMzpAonRjpYzJ2jcMFlSCgeXNOaL
	 HHEPiLF3ODOp/qSWNpxIK0pzURKAOjoVdw4iNVw1iSi5ol4D9HhgRnAc+FHhT1iENTEhYTDYD00E
	 JTNG208rTRxwb3v+60Ggmnl+JCrDZCr8OKbqe6UaahuFQUpNstnCG+pWudLmO3Tpra8jzFPGqJZu
	 DtGx67UmKlKqdtojlDYJsKDYkbYBoPi/xp+0VKz0b55QKwz889hw9Ar/jHV3fLB/y4CCZwmT596f
	 4ipQBbZC/U8Of7xavaLb0JZ+JFrHmlPnQMmnWPunYya1XE5hDZVL/nVAkXA2Tc2p1Fg9EwFG/DsG
	 QqPE+ju9I2NZDSz//a6Km1ljbH7c0jaD3M5UGqamhHy35C3uX5n/jHPL5Ec/mR2QQ3d1Ww0e26rk
	 7KgtAM2NdDBed/hZYV9VnsK5dzVVmM+BDx23gDeRUIhRuu2ylss5ZrjrG/F5bDEeNb0ESXQNADB1
	 6SN4ZJUaXnrsfQEMxGPf89ZLpi6YWFTA2Xcb2P+9J3MDCbfv+VwpjSWXWpjW6aoXTNAlWHfAHubp
	 k87IMYHS1wlATanpqVhuptShejVuS4HyWb9EwoZX3+wHkrEfzCYagAOAq+MnnP
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/3] riscv: mm: Use hint address in mmap if available
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
Date: Tue, 30 Jan 2024 10:34:03 +0800
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <D622ED9C-FADE-4E26-A095-AC959E588543@cyyself.name>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
 <20240129-use_mmap_hint_address-v1-1-4c74da813ba1@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


> On Jan 30, 2024, at 08:37, Charlie Jenkins <charlie@rivosinc.com> =
wrote:
>=20
> On riscv it is guaranteed that the address returned by mmap is less =
than
> the hint address. Allow mmap to return an address all the way up to
> addr, if provided, rather than just up to the lower address space.
>=20
> This provides a performance benefit as well, allowing mmap to exit =
after
> checking that the address is in range rather than searching for a =
valid
> address.
>=20
> It is possible to provide an address that uses at most the same number
> of bits, however it is significantly more computationally expensive to
> provide that number rather than setting the max to be the hint =
address.
> There is the instruction clz/clzw in Zbb that returns the highest set =
bit
> which could be used to performantly implement this, but it would still
> be slower than the current implementation. At worst case, half of the
> address would not be able to be allocated when a hint address is
> provided.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> arch/riscv/include/asm/processor.h | 21 ++++++++-------------
> 1 file changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/processor.h =
b/arch/riscv/include/asm/processor.h
> index f19f861cda54..f3ea5166e3b2 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -22,14 +22,11 @@
> ({ \
> unsigned long mmap_end; \
> typeof(addr) _addr =3D (addr); \
> - if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && =
is_compat_task())) \
> - mmap_end =3D STACK_TOP_MAX; \
> - else if ((_addr) >=3D VA_USER_SV57) \
> - mmap_end =3D STACK_TOP_MAX; \
> - else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D =
VA_BITS_SV48)) \
> - mmap_end =3D VA_USER_SV48; \
> + if ((_addr) =3D=3D 0 || \
> + (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) || \
> + ((_addr + len) > BIT(VA_BITS - 1))) \

How about replacing BIT(VA_BITS-1) to DEFAULT_MAP_WINDOW to make the =
code
more general.

> else \
> - mmap_end =3D VA_USER_SV39; \
> + mmap_end =3D (_addr + len); \
> mmap_end; \
> })
>=20
> @@ -39,14 +36,12 @@
> typeof(addr) _addr =3D (addr); \
> typeof(base) _base =3D (base); \
> unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base); \
> - if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && =
is_compat_task())) \
> + if ((_addr) =3D=3D 0 || \
> +    (IS_ENABLED(CONFIG_COMPAT) && is_compat_task()) || \
> +    ((_addr + len) > BIT(VA_BITS - 1))) \

Same here.

> mmap_base =3D (_base); \
> - else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BITS_SV57)) =
\
> - mmap_base =3D VA_USER_SV57 - rnd_gap; \
> - else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D =
VA_BITS_SV48)) \
> - mmap_base =3D VA_USER_SV48 - rnd_gap; \
> else \
> - mmap_base =3D VA_USER_SV39 - rnd_gap; \
> + mmap_base =3D (_addr + len) - rnd_gap; \
> mmap_base; \
> })
>=20
>=20

What about not setting the upper bound as x86/arm/powerpc as [1] did?
In this case, user space can directly pass a constant hint address >
BIT(47) to get a mapping in sv57. If you want this, this code also =
allows
user-space to pass any address larger than TASK_SIZE. You should also
limit the mmap_base to (base) + TASK_SIZE - DEFAULT_MAP_WINDOW.

I=E2=80=99m also aware of the rnd_gap if it is not 0, then we will not =
get
address mapped to VA_USER_SV39 - rnd_gap.

[1]. =
https://lore.kernel.org/linux-riscv/tencent_2683632BEE438C6D4854E30BDF9CA0=
843606@qq.com/

> --=20
> 2.43.0
>=20


