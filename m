Return-Path: <linux-kselftest+bounces-24356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B9A0B5B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 12:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE0F18833E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D122CF2E;
	Mon, 13 Jan 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="emuyriMm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8222CF23
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767794; cv=none; b=EOp8ABQwXjJ6Ys1k4Kx8/nAgcv/HdUl2WmXgW1Vy8MpSItVRZuWuJjFN1AIQkwjQybGac/qPXuZ1osgiSW2wJ4dtgRyFcqlBMdrHgr0YRReUbbh4Jv999pOc1OPPn2JGD2NXMJgU7L2khgnfnSEvAv1vNr7VT/j59e/6goSMeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767794; c=relaxed/simple;
	bh=HsY4lN9JnVDWPfE+u6AprMygYjbd//6tBydPZAXXZ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGSuzxvYNYpQvTh9Rp8XoKMlRjjhecGEaE7e9DmjmpOtE+fYaDhgzNPbW4wbJzheCNLxhXlcY3JAzwNUjFNZ3hVNz4gj9nnzr1WRFMyyAOxFhtBbR8wVoVf+vAkotcODnXplXWy7kljz6xkuQMgLGSI4YI1Pmnf3GVTdJM4XGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=emuyriMm; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29e70c9dc72so2179989fac.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 03:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736767791; x=1737372591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1oNLuALwfKPcxcMaw300mn/ndsMj7w+nf7EvNjeH1I=;
        b=emuyriMm/C7/XoxQY6VV9GAQcvAXhcO2RZ9lDYsleSpkI06KDCH/xkshN4L76J1VN7
         PDlGk0Xta6CTA666VYhopaOhPyJ5BD5WQVbu/+PvHUwneF9RwkESyBuNiOhnEwPz3cQt
         7vjppbHcXVCrzDV58HT0eZ4ak2l8S3kRkvgUYvkwFl0qK8aR3qnwxD/99FvJXmjhWMd4
         7Ci5TYdDTu7mrlBf971TiuAbi+F7KKey4wSRAWu/XydaRBIyvs/K5hq+wx+EW8uLqb4m
         UvC5swV4rQzvJm42YHWZ8mlIcVJsc2jP7pEnN9RxZ6Uj6JvNGUl8IEX0hLmMZbJivtuW
         thsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767791; x=1737372591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1oNLuALwfKPcxcMaw300mn/ndsMj7w+nf7EvNjeH1I=;
        b=biMPZFs0T/5TySScyxLLs4sLOjjYkfA4A4LYJE7/g1Y9pggoRSU+Lu9V5ZeV6rwiXk
         u/K3y3kZXVmypLV6qUkM5za4r61Iz1oJOwJ+Ab22lfHNSSglZKIM0tuUQlRwzl/bXObP
         42i+f894R8hp75T9HvqHB0uk8PD1LV0y/ZRcgSrXGGDxVqBCxHaBvSKVaCfUAEanAh3T
         +exLbm84xm60MiY0A5ztnOTH0sQoXmFBjimu/BcRMRdqpDwJ92bos2iqbKyydnatOyx4
         0R5u/r0WkDXUZz4AioU+tGcB36I2AFfqQv2lwab+KgDoJo5vV/FG51S98KP7Jd++StTj
         Eauw==
X-Forwarded-Encrypted: i=1; AJvYcCVJoA8JiSmnU9PQ6ZdQA9pF1/vV0hz0NjB3LdH9KDsoHJzK1jenQw2SbaU7vbj1O87IFxlBZZj0tPI0K2LiuBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyVtgeIC7Y/39YkwVkp5Pxq37grNr4fHlGxZQVXR1EhxW/yi8
	3wmMPTCQNntacBHzaFsso1Zld1g8xKiFLjeOqVnwwheroNURt/Gx9qrKy/o9vU8wtYPWlATrbPU
	0P6dFdZ0ptdPmZWqJegBOGuj2tqgsGZqu79wErA==
X-Gm-Gg: ASbGncvNrfRXfsIBjQzY0s7270Ecu5ea0P/IvJ0C8LBiXmfqB8pTGWxQpOod5558p1/
	jezWsip1k+JWCgNIuh7vgzSO1MUtS6/z6DwH1/s9p
X-Google-Smtp-Source: AGHT+IFy17OZn7f/tSfO2jEbRT7YAGzCK+oRC58OSKvdfFecQunHYY4uItTShRvfINeTtd4YufQ5rkoxaECN8na/eBk=
X-Received: by 2002:a05:6871:581e:b0:2a3:c59d:f09d with SMTP id
 586e51a60fabf-2aa066ee020mr12295921fac.14.1736767790649; Mon, 13 Jan 2025
 03:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113083635.73826-1-cuiyunhui@bytedance.com>
 <20250113083635.73826-2-cuiyunhui@bytedance.com> <20250113-65f27ad723c0f6585f86ae7f@orel>
In-Reply-To: <20250113-65f27ad723c0f6585f86ae7f@orel>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 13 Jan 2025 19:29:39 +0800
X-Gm-Features: AbW1kvbpyOAFPxL3X1Ko2GPHhJdVip_TGmXjyMWfNjCUNBIKd-MlEVf9Wb9TG1Q
Message-ID: <CAEEQ3w=fgb7Jxg6SP_hp0Z+T0Tfb-_Pa4-CzU8PpGUKA+dHxyA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/3] RISC-V: hwprobe: Expose Zicbom
 extension and its block size
To: Andrew Jones <ajones@ventanamicro.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Mon, Jan 13, 2025 at 5:07=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Jan 13, 2025 at 04:36:34PM +0800, Yunhui Cui wrote:
> > Expose Zicbom through hwprobe and also provide a key to extract its
> > respective block size.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
> >  arch/riscv/include/asm/hwprobe.h      | 2 +-
> >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
> >  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
> >  4 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index 955fbcd19ce9..7a47cbdbcf8e 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -94,6 +94,9 @@ The following keys are defined:
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is suppo=
rted, as
> >         ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv=
-CMOs.
> >
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is suppo=
rted, as
> > +       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv=
-CMOs.
> > +
>
> This should come after RISCV_HWPROBE_EXT_SUPM since this document has the
> defines sorted in the order in which they are introduced (although I
> personally wouldn't mind if we ordered them alphabetically instead)
OK

>
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZBC` The Zbc extension is supported, a=
s defined
> >         in version 1.0 of the Bit-Manipulation ISA extensions.
> >
> > @@ -273,6 +276,9 @@ The following keys are defined:
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int whic=
h
> >    represents the size of the Zicboz block in bytes.
> >
> > +* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int whic=
h
> > +  represents the size of the Zicbom block in bytes.
> > +
>
> Should be moved below RISCV_HWPROBE_KEY_TIME_CSR_FREQ

Why should it be moved below RISCV_HWPROBE_KEY_TIME_CSR_FREQ?


> >  * :c:macro:`RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS`: An unsigned long =
which
> >    represent the highest userspace virtual address usable.
> >
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/=
hwprobe.h
> > index 1ce1df6d0ff3..89379f9a2e6e 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -8,7 +8,7 @@
> >
> >  #include <uapi/asm/hwprobe.h>
> >
> > -#define RISCV_HWPROBE_MAX_KEY 10
> > +#define RISCV_HWPROBE_MAX_KEY 11
> >
> >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> >  {
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index 3af142b99f77..892dd71a3793 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -73,6 +73,7 @@ struct riscv_hwprobe {
> >  #define              RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
> >  #define              RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
> >  #define              RISCV_HWPROBE_EXT_SUPM          (1ULL << 49)
> > +#define              RISCV_HWPROBE_EXT_ZICBOM        (1ULL << 50)
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0  5
> >  #define              RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
> >  #define              RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
> > @@ -90,6 +91,7 @@ struct riscv_hwprobe {
> >  #define              RISCV_HWPROBE_MISALIGNED_SCALAR_FAST            3
> >  #define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED     4
> >  #define RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF     10
> > +#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE  11
>
> Move below the bit defines of RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF
> (notice how its bit defines are indented, indicating they belong to it)
OK

>
> >  #define              RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN         0
> >  #define              RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW            2
> >  #define              RISCV_HWPROBE_MISALIGNED_VECTOR_FAST            3
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index cb93adfffc48..affcc3e58df9 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -107,6 +107,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
> >               EXT_KEY(ZCB);
> >               EXT_KEY(ZCMOP);
> >               EXT_KEY(ZICBOZ);
> > +             EXT_KEY(ZICBOM);
>
> This list is in alphabetical order, which means ZICBOM should come before
> ZICBOZ.
OK

>
> >               EXT_KEY(ZICOND);
> >               EXT_KEY(ZIHINTNTL);
> >               EXT_KEY(ZIHINTPAUSE);
> > @@ -278,6 +279,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> >               if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> >                       pair->value =3D riscv_cboz_block_size;
> >               break;
> > +     case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
> > +             pair->value =3D 0;
> > +             if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
> > +                     pair->value =3D riscv_cbom_block_size;
> > +             break;
> >       case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
> >               pair->value =3D user_max_virt_addr();
> >               break;
> > --
> > 2.39.2
> >
>
> Thanks,
> drew

Thanks,
Yunhui

