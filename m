Return-Path: <linux-kselftest+bounces-27586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B269DA45CB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3477172F25
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5261213E90;
	Wed, 26 Feb 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g8JJHqY1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F52139C7
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568229; cv=none; b=goIonrR/sCk+rxlGfQyvqbjbR1C6EGX0Wx2aoEtMz247a55yGlAxST1N/cB0mEp/xxco1dBzqEea8HR2IhlSQJ9Aj96ozwat25VTEkEli8qppR2HVST14qVE6V1AJW8A8xtyC/9PUqGfQXWT1jsq28edZrF0e1u+uLYcTP7A7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568229; c=relaxed/simple;
	bh=J0FW/ZpAPbGl+eGdpRYfVmEBIhxvySS/tVwrm7wt8mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX0uRYfRSoZ6ePOqpJuS1FYurQOs78KBMgwYwf2lYSuUFyfowp6H09aoQAR+pJdQaB4Ne8MhIl9TRIYDQdk5AX1ekzLi+anLTv1mF3mSV1Fh0xxIJkxEkaHc1xtBvyCbeogco7zfhute5bisAVCPNVIk/CRAqYYhOo4ZtfO4jXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g8JJHqY1; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72720daed05so3337813a34.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740568227; x=1741173027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBMoR/ArodhoSoFeh7LaWi6Owi/0ZX4Wd5Am5SNNHF4=;
        b=g8JJHqY144jbtrjSVO1qoQkXDAtpTNgXMpqjzpnsyX1ngM+aG7uIxxwIyPea69B8AS
         lbr/xGej6N6TdSdmgYNh6RM2x77hVcLFqZE5afe9r5ksmUXLENBQQjrOm7XqU0VVYW/4
         sqzeFjrQbMsHwZh5C/tohLhIMpF2ZDMf9YEzDuNHNRlGJ+uoS3ZqXWYasdI2xbk9CCZq
         VmtenI+h16mCG45xqywsqYQe+RmW1MEkrz07N4858RUz5BwB6TVsZs00M5dTddNhrh2I
         Fd8OCE0dLZfb9LnfLMYUenwPM2ykaHP7xMS1ONGDoSjBaOUUvmIW/7r9YeruTRWNJNZn
         P8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568227; x=1741173027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBMoR/ArodhoSoFeh7LaWi6Owi/0ZX4Wd5Am5SNNHF4=;
        b=jYuy65SSzVd40Gub6l9N0+Vzhy9/xHRsIB8b1Z76Qnk+UeelsfeTp7KKbpHwiZUbU0
         wfixA/Gocac89C/ACJ/DjmVhby00vD0SsRc8/OWlrJLtQisle/AUEUOZpmETqqGApnFs
         MwmU7Qag2PEJ02DFlP5reF7otyj5eay/MAsKQaPcA1k1A8z1MWdWpc7BbaekKunFNZ8c
         vBU+E7/mAUaWWEgQ23iYXKsU/Ep0KMTUIZHGswhZ39IiJ7SCjpJBLKHlR3G3L0RzyBXB
         dNYsIlM2egYXXpCIAg+SGapNWiDQ0ryZJdI7oM3sxfX9R5RTjv5+OTF2tHA+CxWZujey
         yjQA==
X-Forwarded-Encrypted: i=1; AJvYcCXHtNmKxZ49sAxJMYv98fuWFfXK5uUYPVlqTOhJtrQ0kDWvKRdxkzHmUJAsAD2wv/nBbLIVclQWGB/4odOVT5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiI5dZAB3EGmKzkeGVYDPQQVc5nujPhYe2QRWy/0Jj4157dNSb
	mq5lO4g2BK7kzyreiW6urJx56f2sG1F0bpPM3wjFKrRYlJDHxPj+j3gT+rS8i09hXqrcvrP6YEn
	JHDDy2Q4M4fEpyZPu9X7QNfmHH9zAw0EeAtSw2Q==
X-Gm-Gg: ASbGncvGyoIHUF6vSzT06queC4Ux0D3xTLKukDl8lR0wtBHcWbY4IOLIm8iAFXdoLRI
	2fd1GDNlmviFUTdh777b1e7k3sjaZrnZ536FUPSwKadDK3kKtXoNg0hLd0U3kdjHBum8wAyZyiL
	Ly2eEmur7fmw==
X-Google-Smtp-Source: AGHT+IFY+L/f4Zs9pF53F2VadmOaBwoDscmttE66sKkMkDrENSfkvd4Uv+2+QT/1Y3Me6cp5dQ64I9SS9F3F4i971AM=
X-Received: by 2002:a05:6808:124b:b0:3f4:1fd2:1bac with SMTP id
 5614622812f47-3f547e08930mr1518804b6e.20.1740568226922; Wed, 26 Feb 2025
 03:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
 <CAHVXubhapunBD_+cZ=WeEp9GPJec795xOWSnMKmh_iSH09r2Yw@mail.gmail.com>
 <CAEEQ3wkeLrTFVqVZEAYSsROSLHzkC-EeKvuPHmW=qH3CxamwhA@mail.gmail.com> <CAHVXubhCOivB8oxG7gcCNKTfK0DgHdu721SxsyGX2E4XAjbi6w@mail.gmail.com>
In-Reply-To: <CAHVXubhCOivB8oxG7gcCNKTfK0DgHdu721SxsyGX2E4XAjbi6w@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 26 Feb 2025 19:10:16 +0800
X-Gm-Features: AQ5f1JqM3klrVlTfvA2HKaStjUgmmSxXZxwlOv1ogVvdE4509n751aKn9XVYGRs
Message-ID: <CAEEQ3wnu11zS+C8xfF0-gk0S5Ck-W4Ep8DuqEU-kvgsX_DTSug@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/3] Enable Zicbom in usermode
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: ajones@ventanamicro.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Feb 25, 2025 at 10:07=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> On Tue, Feb 25, 2025 at 2:27=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Alex,
> >
> > On Tue, Feb 25, 2025 at 9:21=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Hi Yunhui,
> > >
> > > On Wed, Jan 15, 2025 at 3:40=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > v1/v2:
> > > > There is only the first patch: RISC-V: Enable cbo.clean/flush in us=
ermode,
> > > > which mainly removes the enabling of cbo.inval in user mode.
> > > >
> > > > v3:
> > > > Add the functionality of Expose Zicbom and selftests for Zicbom.
> > > >
> > > > v4:
> > > > Modify the order of macros, The test_no_cbo_inval function is added
> > > > separately.
> > > >
> > > > v5:
> > > > 1. Modify the order of RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE in hwpro=
be.rst
> > > > 2. "TEST_NO_ZICBOINVAL" -> "TEST_NO_CBO_INVAL"
> > > >
> > > > Yunhui Cui (3):
> > > >   RISC-V: Enable cbo.clean/flush in usermode
> > > >   RISC-V: hwprobe: Expose Zicbom extension and its block size
> > > >   RISC-V: selftests: Add TEST_ZICBOM into CBO tests
> > > >
> > > >  Documentation/arch/riscv/hwprobe.rst        |  6 ++
> > > >  arch/riscv/include/asm/hwprobe.h            |  2 +-
> > > >  arch/riscv/include/uapi/asm/hwprobe.h       |  2 +
> > > >  arch/riscv/kernel/cpufeature.c              |  8 +++
> > > >  arch/riscv/kernel/sys_hwprobe.c             |  6 ++
> > > >  tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++=
----
> > > >  6 files changed, 78 insertions(+), 12 deletions(-)
> > > >
> > > > --
> > > > 2.39.2
> > > >
> > >
> > > So a v6 needs to be sent with:
> > >
> > > - the fix for hwprobe_ext0_has() reported by kernel test robot
> > > - a rebase on top of 6.14 since patch 2 will conflict with
> > > RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0
> >
> > Thank you for the reminder. In fact, version 6 was sent out almost a
> > month ago. Reference:
> > https://lore.kernel.org/lkml/20250124035959.45499-1-cuiyunhui@bytedance=
.com/
>
> Oh sorry, I missed it somehow!
>
> I think we can fix RISCV_HWPROBE_MAX_KEY when merging the patch.
>
> Sorry again and thanks!

It's all good. I've rebased a version:
https://lore.kernel.org/all/20250226063206.71216-1-cuiyunhui@bytedance.com/=
.
Could you help to merge it? Thanks.


>
> Alex
>
> >
> > >
> > > Do you think you can do that soon so that it gets merged in 6.15? The
> > > patchset received a lot of RB so it would be too bad to miss this
> > > release.
> > >
> > > Thanks,
> > >
> > > Alex
> >
> > Thanks,
> > Yunhui

Thanks,
Yunhui

