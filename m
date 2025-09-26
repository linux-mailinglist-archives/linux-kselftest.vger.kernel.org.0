Return-Path: <linux-kselftest+bounces-42508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD1FBA5100
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBED7B2D28
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883328640C;
	Fri, 26 Sep 2025 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAqwO0/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917582857EF
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918555; cv=none; b=Ypx3ga05BRsu9AZDU1J2w+Om3BmRkaPxxSIZ5AhhlvpPEzEL2TERnuSZg/ArItYERZaUfo7clUulih0ztPtSrap9OfDzrcMmP0b1eyuynU05xsRrA93iBb8mfFm3SfoHBAszr6VbvVgxHbsTCg0W6SXSE8maGGfvOXXKxiX6A/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918555; c=relaxed/simple;
	bh=bRGyg/YupvYwH5/eSncCy/iOLbX94aLX9RWO5iOHIDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HALExuw8dfJbF6Htyp6t5YIVg3/tGilb59jx17s8PP3sJLwljh0HLpQRJRjid+aVj5q4JiSdpYoHlqjv0b+P5y+amBV/vb1XuoP9IGaYer8sQMObdB1TpEGVLtWmlDKaJ6kKiBfWjj1IbaPmCQl4TO97yFQNwm3zio1VnPPKnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAqwO0/h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758918552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQdtd6aty7MhbXUeyU1S7f0YHdth4v9lOBvY3WPAYoQ=;
	b=UAqwO0/haYgLqv70vKhvH2fGzZ34TFf2QqN46SRJGuCv/J1zcL//8dA9cVCFCnCjnyYo0+
	mxYS9yUmVdFv9St0DXheRk+7KO8e+fXIVOb0d15DPbVDwZsJRHwCFYmSqQd4dk0VqzSCYl
	xKNztcBBPLXUrQN+M+gk1VdxVTHNAnY=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Cqj5FYMuOuGwZ8bb7couOA-1; Fri, 26 Sep 2025 16:29:11 -0400
X-MC-Unique: Cqj5FYMuOuGwZ8bb7couOA-1
X-Mimecast-MFC-AGG-ID: Cqj5FYMuOuGwZ8bb7couOA_1758918550
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-54a7a912f1aso1673802e0c.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 13:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758918550; x=1759523350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQdtd6aty7MhbXUeyU1S7f0YHdth4v9lOBvY3WPAYoQ=;
        b=GSES4mF6PSs4fmuuHn6APlK1TT/gOKLQHsWW5a/tTX3z+Pbm3OLIAwOq87JG23lc3A
         j9gM9mKeQeuIsDhT/E3O/C4e4QUQyaHC/iT2P6x9BTgjKp/58vBkCQBU+4HWLa0yjSxS
         fjd9qyN5H67XsEnYDRFmbGaaUpuRfbsw6pxX4VYCsju17gWMWmboKOnCD4USGdKhtqz1
         Xl8vs88tT7/QU06Pa7smqCrOoEmuIdwLWQ96U0O1+T2Ji93oooYrln9d3dAh/5pjwcBP
         jEXyjuahG2W9NBX7LbemPzib4lhqDQfJnhfnirNDo5joJAcTfbUl/FHW7mSqhEEWia/9
         td0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo39IU2r45I9bCYeGRGYFcbZajffNkZFAMW9sJKx866aWfAqpW0z6g+/2sKDyk4WYZvpEUjCf+2N7WHbAQ56Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPTncTTEnm4y5agKN4TNTx09AXNLi4NXTVvz/g/VIoATz72gO
	SCVYUQRLxfO1pKk3BkSFdJlPqRO088Y6tOvsspFcKrjg/I5vAMKKYKAc/H4OEie0oG+cPHYFeL0
	zWlmQtgAdUfQZIhiqs+UGjOm6NRkXcnaqDwXVgJm8OPYDgjyXGpzh5ENIpvxKvaNK1PJsqNxnX5
	TYOOCXvumMvc5/+BCnRIw9OWQ/DD565TT6CGNr5tKvUQ18
X-Gm-Gg: ASbGncsR3v1DWQgGv+++9iGc7rWk9YSSs1+gq7zV6NTbydccLKNC3b5/7vN8DJBAfnZ
	6VyNKJcV/17A8EadexvMqjkMEFyEqlKgxI6A8O9xlCoMEGJMycaIa0MgLUJ5HFI5e1kp+VaeR5X
	ibqApUs7Y+MxWkanE88EeJu5SNsx//Pg==
X-Received: by 2002:a05:6122:7cf:b0:54a:a1f1:ef42 with SMTP id 71dfb90a1353d-54bea1c094amr3516260e0c.5.1758918550378;
        Fri, 26 Sep 2025 13:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7vlUmlGwUwL1AFRKnR2zoH9F3EoJncOgSNp7RigeP+sdlLnxuFXDBvEmapswDg4BXwIBnMV2DKbzUxG+jaYQ=
X-Received: by 2002:a05:6122:7cf:b0:54a:a1f1:ef42 with SMTP id
 71dfb90a1353d-54bea1c094amr3516251e0c.5.1758918549953; Fri, 26 Sep 2025
 13:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <20250926192919.349578-1-cmirabil@redhat.com> <aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
In-Reply-To: <aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Fri, 26 Sep 2025 16:28:58 -0400
X-Gm-Features: AS18NWAFmNYbXfsrHSUccPVQ7i16EPHPLja0OCz6y6mucuuIuUMLPbxAtsOG_bI
Message-ID: <CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
To: Deepak Gupta <debug@rivosinc.com>
Cc: pjw@kernel.org, Liam.Howlett@oracle.com, a.hindborg@kernel.org, 
	akpm@linux-foundation.org, alex.gaynor@gmail.com, alexghiti@rivosinc.com, 
	aliceryhl@google.com, alistair.francis@wdc.com, andybnac@gmail.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, atishp@rivosinc.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, bp@alien8.de, 
	brauner@kernel.org, broonie@kernel.org, charlie@rivosinc.com, 
	cleger@rivosinc.com, conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@redhat.com, devicetree@vger.kernel.org, 
	ebiederm@xmission.com, evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com, 
	jannh@google.com, jim.shu@sifive.com, kees@kernel.org, kito.cheng@sifive.com, 
	krzk+dt@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com, 
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org, oleg@redhat.com, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org, 
	richard.henderson@linaro.org, rick.p.edgecombe@intel.com, robh@kernel.org, 
	rust-for-linux@vger.kernel.org, samitolvanen@google.com, shuah@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, vbabka@suse.cz, x86@kernel.org, 
	zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak -

On Fri, Sep 26, 2025 at 3:57=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Hi Charles,
>
> Thanks for response. Rest inline
>
> On Fri, Sep 26, 2025 at 03:29:19PM -0400, Charles Mirabile wrote:
> >Hi -
> >
> >Hoping that I got everything right with git-send-email so that this is
> >delivered alright...
> >
> >Wanted to jump in to head off a potential talking past one another /
> >miscommunication situation I see here.
> >
> >On Wed, Sep 24, 2025 at 08:36:11AM -0600, Paul Walmsley wrote:
> >> Hi,
> >>
> >> On Thu, 31 Jul 2025, Deepak Gupta wrote:
> >>
> >> [ ... ]
> >>
> >> > vDSO related Opens (in the flux)
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >
> >> > I am listing these opens for laying out plan and what to expect in f=
uture
> >> > patch sets. And of course for the sake of discussion.
> >> >
> >>
> >> [ ... ]
> >>
> >> > How many vDSOs
> >> > ---------------
> >> > Shadow stack instructions are carved out of zimop (may be operations=
) and if CPU
> >> > doesn't implement zimop, they're illegal instructions. Kernel could =
be running on
> >> > a CPU which may or may not implement zimop. And thus kernel will hav=
e to carry 2
> >> > different vDSOs and expose the appropriate one depending on whether =
CPU implements
> >> > zimop or not.
> >>
> >> If we merge this series without this, then when CFI is enabled in the
> >> Kconfig, we'll wind up with a non-portable kernel that won't run on ol=
der
> >> hardware.  We go to great lengths to enable kernel binary portability
> >> across the presence or absence of other RISC-V extensions, and I think
> >> these CFI extensions should be no different.
> >
> >That is not true, this series does not contain the VDSO changes so it ca=
n
> >be merged as is.
>
> Look at patch 23/27. It does have vDSO change. Although shadow stack
> instruction are inserted as compiled flag for vDSO only when cfi config i=
s
> selected by user. Right now default is "No". So it won't impact anyone un=
les
> user explicitly says "Yes".

Yes sorry I caught that after hitting send and replied to my own email
(but then I said 19/27 instead of 23/27 *facepalm*)

>
> >
> >>
> >> So before considering this for merging, I'd like to see at least an
> >> attempt to implement the dual-vDSO approach (or something equivalent)
> >> where the same kernel binary with CFI enabled can run on both pre-Zimo=
p
> >> and post-Zimop hardware, with the existing userspaces that are common
> >> today.
> >
> >I agree that when the VDSO patches are submitted for inclusion they shou=
ld
> >be written in a way that avoids limiting the entire kernel to either
> >pre-Zimop or post-Zimop hardware based on the config, but I think it
> >should be quite possible to perform e.g. runtime patching of the VDSO
> >to replace the Zimop instructions with nops if the config is enabled but
> >the hardware does not support Zimop.
>
> Why kernel need to do this extra work of carry two binaries and patching =
it
> runtime?
>
> If for instance we do this, and then this allow this kernel to be taken t=
o
> pre-Zimop hardware, it is assumed that entire userspace for such hardware
> was compiled without shadow stack (thus no zimop). In that case, kernel
> should have been compiled without CFI option.

You raise a good point, it just breaks the tradition of runtime
detection and backwards compat that has been the standard for riscv
extensions in the kernel so far.

It would be nice if a kernel could be built that would run on both
pre-Zimop and post-Zimop hardware and be able to offer CFI to
userspace when running on hardware with Zimop (and Zicfiss / Zicfilp)
but agree that it is a burden.

>
> Just for sake of thought exercise, let's say Fedora 43 is first release w=
ith
> RVA23 compatiblity (zimop and shadow stack), there is no way this and fut=
ure
> release will be able to run on pre-zimop hardware. Unless redhat is going=
 to
> start two different binary distribution. One for pre-zimop and one for
> post-zimop. If that would be the case, then compiling two different kerne=
l for
> such two different hardware would be least of the worry.

It would be one thing if there were hardware supporting
Zimop/Zicfiss/Zicfilp readily available, but I am not aware of any
platform other than qemu to test this code. Since it breaks
compatibility with hardware I am not sure anyone will be able to do
anything with this config option and it moves the burden on to each
distro to go in and specifically enabling it vs just making things
work to get important security improvements if the hardware has
support and not if it doesn't in a backwards compatible way.

>
> Only other usecase is of a seasoned kernel developer or build your own st=
uff
> in embedded environment, those users can anyways are advanced users. But =
it
> forces complexity on rest of kernel. There will be more extensions taking=
 zimop
> encodings in future, we will end up patching vDSO and keep this complexit=
y
> while rest of the userspace will not be patched and will be separate bina=
ry
> distribution (if OS distros endup distributing multiple binaries per rele=
ase)
>
> >
> >However, that concern should not hold up this patch series. Raise it aga=
in
> >when the VDSO patches are posted.
>
> As I said earlier, these changes default cfi config to No. So whenever th=
is
> is selected "Yes" by a distro, they can drive such patches (if there is a=
 real
> need)

If we did the patching we could make this config default to yes to
that you are building a kernel that is set up to be able to offer CFI
when running on hardware which supports it as long as you have a
toolchain that recognizes the extensions which I think would be good
for moving this important security feature forward.

>
> >
> >>
> >> thanks Deepak,
> >>
> >> - Paul
> >
> >Best - Charlie
> >
>

Sorry for stirring the pot on this. I really appreciate your work on
this patch series.

I agree that this is a difficult call, and I could see it going either
way but I lean towards trying to maintain the backwards compatibility
because the hardware doesn't exist yet.

Best - Charlie


