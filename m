Return-Path: <linux-kselftest+bounces-43030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B407BD618E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0F5C34ECCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE6309DB1;
	Mon, 13 Oct 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0TGhUDG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F633093CD
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387564; cv=none; b=n7rbDCYDmj1ULSdPn4RWDDxVBJaOOasBfwc1ldPwRLFlGHDESkT9moyd8bbb/18R5WERukffK+3oLeKVuKRMTG5ZbvAoeRGK2IOWlaMj3F1dD7SJrnrPV2pvlhSgxdSwvWpnokEeGh1CzFQUeAHUCVc8sS58q+RhoZoEzdANif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387564; c=relaxed/simple;
	bh=EQamDqz1jKPoQmI1VU+7+EDF4P83/GJiuJy793deQ/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKewHkINYKD+MO9jIDUAM3T7o4vdGsMn+n6O95mDaVjnpUdCbZMsDS122Ybg/vvsByeD9x3xTe2n4a7ypElimB66yd3a9XsLO/CxZ04+lTnXvfnXRu92rKxO2n80fT1Y7lNYvbrGGlLj+aLgxFTscXrVpUNAznYx5cJAeB/AR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0TGhUDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCBDC19422
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387564;
	bh=EQamDqz1jKPoQmI1VU+7+EDF4P83/GJiuJy793deQ/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a0TGhUDGi+/iEdmyQcN7ciepwiJneRt84J2Q47Mg0Hfd4qYoV0nDT/VW7h0s2ry3Z
	 UVV00W9Ei/GJlG+rdKc6ZlPYFwTl+/bCLj16ev+4AU8/JDhlDu/JcXQTbJYciVtIBJ
	 cO3woUFa3/jybo72rgiF1rduIh3xpL/lHTEG4r7c4Fp9eLly+DErNgLe+27VBIJc1s
	 zdn8viiPJ1iye98izFeQmaI6k6oIq38bCfMoNBM+78rD+g+zSlHLdR0LScRisdtrZs
	 Paxcu7Y/ygZr5dqIHFp51TS2CjZ9WkewPvGMZvbHxkAdueG+YfnDLKCxr2gIievjdV
	 W25v0hLI2v1eg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59054fc6a45so1464297e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 13:32:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZxlyoKUypdNyJDi+bpTLUjuRZiT9q8zh9l8D7AR1mbbWVPYAK5gPYoS+zONJxZBBKGNj+O/I+rhldeKQ0PLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCcr2WwPNQRn69ditX+9RnHOW0avuxI0uhqktDAb1tZwq/Po5
	37iO/RRckGsweD6IxlnUwfRGdnHp/5CbWMDsxWECPIPla+QqpEbc/IDOvVgX/0x04QYLC8qjNLa
	Kd8nd4RCX0X3Li4JmWD4YMKuGqHTwi35sXSjEe6Zz
X-Google-Smtp-Source: AGHT+IFm/qhJPRKGc+a+TWhUwJHmseKnmX3UsC7EjJHnIC1kG1AUHBMR9nLxzbY5e9K0EIzQFCLgbzgnfLD4YXcOdbY=
X-Received: by 2002:a05:6512:3045:b0:58b:23e:253 with SMTP id
 2adb3069b0e04-5906db04028mr6538684e87.7.1760387562236; Mon, 13 Oct 2025
 13:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
 <e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com> <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
 <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
In-Reply-To: <494caf29-8755-4bc6-a2c3-b9d0b3e9b78d@zytor.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Oct 2025 13:32:30 -0700
X-Gmail-Original-Message-ID: <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
X-Gm-Features: AS18NWDkjUWHXDVipeI6h9oFzsXdlHdU2eK-6BrfttbpUi-mL82DSNY6ulu9J34
Message-ID: <CALCETrVuW_MmksnkprK5Ljm-5RBSS=FUA8R8fgGMhZ3BxW15Sw@mail.gmail.com>
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Shuah Khan <shuah@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:45=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On 2025-10-13 10:14, Andy Lutomirski wrote:
> >
> > I don't actually remember whether the kernel ever used this.  It's
> > possible that there are ancient kernels where passing a wild, non-null
> > pointer would blow up.  But it's certainly safe to pass null, and it's
> > certainly safe for the kernel to ignore the parameter.
> >
>
> One could imagine an architecture which would have to execute an actual s=
ystem
> call wanting to use this, but on x86 it is pointless -- even the LSL tric=
k is
> much faster than a system call, and once you account for whatever hassle =
you
> would have to deal with do make the cache make sense (probably having a g=
lobal
> generation number and/or a timestamp to expire it) it well and truly make=
s no
> sense.

The global timestamp would just be some field in the vvar area, which
we have plenty of anyway.

But I agree, accelerating getcpu is pointless.  In any case, anything
that historically thought it really really wanted accelerated getcpu
can, and probably does, use rseq these days.

--Andy

