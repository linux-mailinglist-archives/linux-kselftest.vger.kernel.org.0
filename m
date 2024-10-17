Return-Path: <linux-kselftest+bounces-20055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6C9A2E84
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2091C22251
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2A1E0488;
	Thu, 17 Oct 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FD02RFCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7g0R1p1U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048E17BEC8;
	Thu, 17 Oct 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197111; cv=none; b=udzY5c/zJzw/3PqdaZym7toFfsprAKtPmbEx+TaUHgoecQI17yvv2I233lhEgI+ub7h/2+ecjbDJNGpnXM26928Zw+u+GVofYyq1WC/FxwZlx1Y1zFRn8NXGASjRTFawztKf/ye7dffI48OD32+LHpp/yMVbiUFiyGpDMPniZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197111; c=relaxed/simple;
	bh=BdoDePqd/76KbiMN5yIWSOPyuTWeVihx4HVEpxW4AsQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HL+zqXYB3tdlERXZBJld2mw1/vAzbAnC/M2zFECfixF0BO+gfMqnm0DRRj4XOKWCgkuuWcnDGQF4UACxeKhYkt+Jw0UT1Pg6T1d9IGIFdTxK7rOISkkldMVYC3GlwYmhfMud5GSfg8peJGr/ZGN+YMfJTyYqsPbaSTV0IE0zqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FD02RFCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7g0R1p1U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 22:31:39 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729197103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdoDePqd/76KbiMN5yIWSOPyuTWeVihx4HVEpxW4AsQ=;
	b=FD02RFCzdm8a0+VmZu6N2ziW8VL+XtRquCFZKg0CX/jX1IOXVdIs+FiFWMEqYVJ9DOdxqI
	2YHDsPMtrDcRlMs0qCt/cx+yqyhg9EWka+hCWYIefQVD63ncNBkdN42OVJN9lvzknAX48P
	yGgZSmMwaDFEntIeCZHnbwU4IgJioSvlVJuRRb1v0k7koQ3s+6Wwz86SS41HhY58V2bJme
	xPXuMuYshPK4dRxkPncVc6CAKss5+u8/ODVZgaqaFxQKYRx0A6nHCkXwB1dc7T0AdpAF1y
	Afj7rgbTAdwTazncwJZnZlrfVjFrGfy9jrbsseg9bEo3GEsNSwrC4HCqtmE20Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729197103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdoDePqd/76KbiMN5yIWSOPyuTWeVihx4HVEpxW4AsQ=;
	b=7g0R1p1U6RQw5dQCsv0tMx5NNC+WW4RxluVPeJiZIaYZVmTqJkjcYnR3UxDBhj7oqR31qw
	IZ2vz4YQOE51dTCA==
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Message-ID: <3a49d3e2-2d76-458f-a0fd-fe52a413f376@linutronix.de>
In-Reply-To: <878d5f26-ef05-44f4-93e8-01f66088c0cc@linuxfoundation.org>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de> <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de> <878d5f26-ef05-44f4-93e8-01f66088c0cc@linuxfoundation.org>
Subject: Re: [PATCH 2/4] kunit: qemu_configs: add LoongArch config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3a49d3e2-2d76-458f-a0fd-fe52a413f376@linutronix.de>

Hi Shuah,

Oct 17, 2024 22:27:29 Shuah Khan <skhan@linuxfoundation.org>:

> On 10/14/24 05:36, Thomas Wei=C3=9Fschuh wrote:
>> Add a basic config to run kunit tests on LoongArch.
>> This requires QEMU 9.1.0 or later for the necessary direct kernel boot
>> support.
>> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>> ---
>> =C2=A0 tools/testing/kunit/qemu_configs/loongarch.py | 16 ++++++++++++++=
++
>> =C2=A0 1 file changed, 16 insertions(+)
>> diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testi=
ng/kunit/qemu_configs/loongarch.py
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..e7bb7c07819677dfdefac012=
821a732555813cae
>> --- /dev/null
>> +++ b/tools/testing/kunit/qemu_configs/loongarch.py
>
> Missing SPDX-License-Identifier.

Tue others configs don't have one either.

>> @@ -0,0 +1,16 @@
>> +from ..qemu_config import QemuArchParams
>> +
>> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'loongarch',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kconfig=3D'''
>> +CONFIG_EFI_STUB=3Dn
>> +CONFIG_PCI_HOST_GENERIC=3Dy
>> +CONFIG_SERIAL_8250=3Dy
>> +CONFIG_SERIAL_8250_CONSOLE=3Dy
>> +CONFIG_SERIAL_OF_PLATFORM=3Dy
>> +''',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qemu_arch=3D'loongarch64',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kernel_path=3D'arch/loongarch/boot/vmlinux.elf',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kernel_command_line=3D'console=3DttyS0',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 extra_qemu_params=3D[
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '-machine', 'virt=
',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '-cpu', 'max',])
>>
>
> Please send v2 with all the reviewed by tags. If there
> is a resend 3.4 and 4/4 in this series, send them.

I'll do that. But it will take some weeks, as I just went on vacation.

Thomas

