Return-Path: <linux-kselftest+bounces-3905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F71844B65
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 00:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A01C20C27
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97BB3A8FD;
	Wed, 31 Jan 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+jPDyWj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055C3A8E7;
	Wed, 31 Jan 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741996; cv=none; b=DUkir+jH5PhqDtNNwxplJv0EmyE99QXogiALSWbmGvhq+RZpl1B46csZRroM/jm28+xk/WW0Rrcn2U5pO2cdx7Q5ETcXxuY8RRHwK747j4YDhzfk4706RuDzdw7j0X44PYry3/BeMLgcPY2mZL+4nWd/I5vQ8XM7wLrOWc2o4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741996; c=relaxed/simple;
	bh=zdzGQukzuFM99odXc1XHFwDNHwjEYQ2tT1RmuJLmutg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=umGzoTOASmkTVaL9hLMtdTINI+Li/AoeOv/ZGcFsCLh/DI+G8cPUzKuxBzhrrH8iX5TXtu2e3107kfmPX6yGRjlLC/JzbtWd28neSCGh7wwWirM5IhC2IrMTh9l9T7Lo3Ah2pZz261NfAurtniEFHhEhRiCKEzv6EPnDZFsJPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+jPDyWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BF5C433C7;
	Wed, 31 Jan 2024 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706741995;
	bh=zdzGQukzuFM99odXc1XHFwDNHwjEYQ2tT1RmuJLmutg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=M+jPDyWjW3p2BFL4c7Lq/tJLbKE0eoQKC70P1AS5REFlY4kdxkNB5cTBbAFNDw1hI
	 2jP/AbKdvUAxefuvOQh22+j7DgdGVzQ3I5QRhy0N9Upe1mX/GsYF0W6i+Dm2K8IfgK
	 aaCTibLiwPJs/QYgWz4pNrt86vq2TzlHrW3LD7GcPXNqA4xfdMx+OxZJ6gsGzi6zOq
	 cmGZ0fU6BVOtgwkZbi25gi+5Oow8v+mf8eSt9A4C6pMEL/aZOrLzK4IrofeZrybwYI
	 wWu727yJvBE5SN5Rr+8ryTsDlTV0UA0rTEGgaRgBFH3pcLi4e0ZYUxqKCbcyxmDqcE
	 ceTxausFkQgQg==
Message-ID: <efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240131205405.GA2249327-robh@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org> <20240130004508.1700335-2-sboyd@kernel.org> <20240131205405.GA2249327-robh@kernel.org>
Subject: Re: [PATCH v2 1/7] arm64: Unconditionally call unflatten_device_tree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jan 2024 14:59:53 -0800
User-Agent: alot/0.10

Quoting Rob Herring (2024-01-31 12:54:05)
> On Mon, Jan 29, 2024 at 04:45:00PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > Override 'initial_boot_params' to NULL when ACPI is in use but the
> > bootloader has loaded a DTB so that we don't allow both ACPI and DT to
> > be used during boot. If there isn't a valid initial_boot_params dtb then
> > unflatten_device_tree() returns early so this is fine.
> >=20
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  arch/arm64/kernel/setup.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 417a8a86b2db..ffb1942724ae 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char =
**cmdline_p)
> >       /* Parse the ACPI tables for possible boot-time configuration */
> >       acpi_boot_table_init();
> > =20
> > -     if (acpi_disabled)
> > -             unflatten_device_tree();
> > +     /* Don't use the FDT from boot if ACPI is in use */
> > +     if (!acpi_disabled)
> > +             initial_boot_params =3D NULL;
>=20
> I still think this is a problem for kexec. See=20
> of_kexec_alloc_and_setup_fdt(). You see it uses initial_boot_params. At=20
> first glance it looks like it would just write out everything we need.=20
> But for UEFI boot, I think we need all the chosen properties like=20
> linux,uefi-mmap-start preserved from the current boot for the next=20
> kernel we kexec.

Ok, got it.

>=20
> I think you'll have to check acpi_disabled in unflatten_device_tree()=20
> and unflatten the empty tree leaving initial_boot_params alone. That=20
> means our FDT and unflattened tree will be different DTs, but I think=20
> that's fine.

It's sort of scary given that 'initial_boot_params' is an exported
global. Maybe that should be hidden away and accessed with a function
instead so that this mismatch doesn't break something later on?

