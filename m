Return-Path: <linux-kselftest+bounces-27460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE71A44210
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5973A8DFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B92698A8;
	Tue, 25 Feb 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LH+T2tIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108B26869E
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492457; cv=none; b=ehHbEukHCxF4bDSrcdTU2BtKHigpaRHSpffPQP5idIC7SPOglfHGZvVhb6vuXHjr/IsWh9T/S8L4sPDoGGUfril7oeV9Bt0U7v5jOcocLAIJeG1eGgo38nmWGUnZMxttPiAp6fI8nksgedbr3CXLmXmzwyhzvx92EyL1zTtDH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492457; c=relaxed/simple;
	bh=ETtbGfre+8vSSFzKt9ffhumK3/zdteTUO6XQ0C3bBjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIwW9+AMGU62r0z7rvjevWs9SX+CaOasbtaEbr+9sDW6k96/oAt0sjn7JL7tK+s9ZRjXEzp0NklC0tNFefvG41NXjykllRUkTTcB/J3i47h5/DJYM++/csFq0Sesx5TSt4GZmZqbLL3t6Ud061skF2V1K4sUFgMfXlH7n/Qnp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LH+T2tIp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso9115145a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 06:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740492454; x=1741097254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52CPMxSHvISiy3Wem3SvA0rcU6ZBPvQeZSq+VknVkPQ=;
        b=LH+T2tIpPx+3OFkO6sCUd9tdPB58WVN9RwewDrON/AQztGGEv9RlSftC4ODM2NS+iB
         qcLeORO43fsyj4vHCpIHTsfzGJ1ol01bXOm6YYMQi1Pct63mD+fTiLoR1yeMW1vOJDGR
         b38XW7xtR6fzG83GdfyqrU3ti2D5kWzanUGzJK0Mb2TdENfkPKQx7x79VMnXranmSg2E
         aTdrEfKx/tR4RdbTpvaKi1s5nlPqa3znvzx0oJOFAGiwBSArwqUwdXq/i+XKHaRSQ0UP
         gFUXrmFh+UtbgVOr9OdrnXLM6LJZgur13cE9D7cigFe6vLK7oQ/dPjrfJcZc+dwLiitv
         qbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492454; x=1741097254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52CPMxSHvISiy3Wem3SvA0rcU6ZBPvQeZSq+VknVkPQ=;
        b=R0sylWrvbfNhy2qBIr15ZH9/0dpqTJNLE9rkS3OPLfMh2Ru9jeOioHaDkSvc3EYUp6
         +0KSH8lx8l9dBKaU3+wu9V4s4ez6x3oKcm+pB3bigfoMpmCZk40fyLiVmSs+cv+rTofx
         ALp6CJPaRCK7Zi0sBBHI+TMVmhkF77G+sAS6QL5/vUOuCpSPqWx843Mo40GF0BGQakjY
         WG0MV/JUIr8XoJk2C0m8oJQCTBsDYSbmhI+egSRlw0p0m5MGDNongFHs0l4gdGiOIILo
         37/Pak4q9rvHKJtr+qHpggefEfzu5NRSsJVI9q5DVKzah3AmCECxvjRcVKPOqVanguyt
         Wm3w==
X-Forwarded-Encrypted: i=1; AJvYcCX+iD6bPZyB59N+04O1pQmNgSvSDHbbyFJRGYRc2BzQUdAi4/fA03t3NBdrw7syGL4DsFC7xIYLiNE6enx1fxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGQD9r6zgVeWNLEGGCIpC7yvDzR1i9nVd9ep69rrbFV8ZyZ04
	RIGYtTEkWcIU2y09mvDxxvaoOVFFJ/A9xkPHj7QJv5Pp6TY9heen0KFfh0bH4Hr7Pz/NVWztiET
	f6ng/EVEYqAMvwbnln4VrruckgGzEWDZkfISRXA==
X-Gm-Gg: ASbGncu5Qo4pIFEooYc8LEgnuvF1bdtM8zmoIBTlAJdeFIuKM48Tf0kEs3/fXkknRaL
	UfloEBWIXn2ovKx/7rpRS11eOdNVKcTvMnlLqtLDqqtJb3Ky/iUjSn+yMskPcddtkNRuJLouuF1
	vW/oPWdLc=
X-Google-Smtp-Source: AGHT+IEQN2EDCAAeHFkbNRXvx783uJdY53BszHXjfFa/MVQdphVBraQZDPpAVQvXLTkAQT+0PQSNrmUIWMt1Q9RBz8w=
X-Received: by 2002:a05:6402:42c9:b0:5d3:cff5:634f with SMTP id
 4fb4d7f45d1cf-5e0b721e1famr17991883a12.24.1740492454054; Tue, 25 Feb 2025
 06:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
 <CAHVXubhapunBD_+cZ=WeEp9GPJec795xOWSnMKmh_iSH09r2Yw@mail.gmail.com> <CAEEQ3wkeLrTFVqVZEAYSsROSLHzkC-EeKvuPHmW=qH3CxamwhA@mail.gmail.com>
In-Reply-To: <CAEEQ3wkeLrTFVqVZEAYSsROSLHzkC-EeKvuPHmW=qH3CxamwhA@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 25 Feb 2025 15:07:23 +0100
X-Gm-Features: AQ5f1Jq1ao-dkwxD2tcF7rBD5LcSaT1gKrmPFXFhH7IkW09oLtBAZAZXrkzMTtc
Message-ID: <CAHVXubhCOivB8oxG7gcCNKTfK0DgHdu721SxsyGX2E4XAjbi6w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/3] Enable Zicbom in usermode
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: ajones@ventanamicro.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:27=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Alex,
>
> On Tue, Feb 25, 2025 at 9:21=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Yunhui,
> >
> > On Wed, Jan 15, 2025 at 3:40=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > v1/v2:
> > > There is only the first patch: RISC-V: Enable cbo.clean/flush in user=
mode,
> > > which mainly removes the enabling of cbo.inval in user mode.
> > >
> > > v3:
> > > Add the functionality of Expose Zicbom and selftests for Zicbom.
> > >
> > > v4:
> > > Modify the order of macros, The test_no_cbo_inval function is added
> > > separately.
> > >
> > > v5:
> > > 1. Modify the order of RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE in hwprobe=
.rst
> > > 2. "TEST_NO_ZICBOINVAL" -> "TEST_NO_CBO_INVAL"
> > >
> > > Yunhui Cui (3):
> > >   RISC-V: Enable cbo.clean/flush in usermode
> > >   RISC-V: hwprobe: Expose Zicbom extension and its block size
> > >   RISC-V: selftests: Add TEST_ZICBOM into CBO tests
> > >
> > >  Documentation/arch/riscv/hwprobe.rst        |  6 ++
> > >  arch/riscv/include/asm/hwprobe.h            |  2 +-
> > >  arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
> > >  arch/riscv/kernel/cpufeature.c              |  8 +++
> > >  arch/riscv/kernel/sys_hwprobe.c             |  6 ++
> > >  tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++--=
--
> > >  6 files changed, 78 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.39.2
> > >
> >
> > So a v6 needs to be sent with:
> >
> > - the fix for hwprobe_ext0_has() reported by kernel test robot
> > - a rebase on top of 6.14 since patch 2 will conflict with
> > RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0
>
> Thank you for the reminder. In fact, version 6 was sent out almost a
> month ago. Reference:
> https://lore.kernel.org/lkml/20250124035959.45499-1-cuiyunhui@bytedance.c=
om/

Oh sorry, I missed it somehow!

I think we can fix RISCV_HWPROBE_MAX_KEY when merging the patch.

Sorry again and thanks!

Alex

>
> >
> > Do you think you can do that soon so that it gets merged in 6.15? The
> > patchset received a lot of RB so it would be too bad to miss this
> > release.
> >
> > Thanks,
> >
> > Alex
>
> Thanks,
> Yunhui

