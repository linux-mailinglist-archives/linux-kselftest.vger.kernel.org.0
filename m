Return-Path: <linux-kselftest+bounces-43684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7EBF8FBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B8B18A45F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 21:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277928CF66;
	Tue, 21 Oct 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2g9BtgC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9B241665
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083597; cv=none; b=s3be94xr5Sm/yGhaSk02OWLyZIfXyhFLdRAZcFLQlCLv3vQVs8B/jiOw5Joq4PIgA7uEyxmi0M3bhRK/Vu52e4gTzjfPmGTcmFuQvCxhptbPE3U723HyY9MHGOnkt+xKaN0bKxAAPpfSPX/Ho6yfBb0ov1voIfsgSA3SzAYT54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083597; c=relaxed/simple;
	bh=Lc3WtDTd1WYQC9A9nm1WTBB9FxsPLQHScnVEcTR59VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7vb4hxY/68YqhlDFeZEcDHqrTDClgJNVcBPcMIf6HyDqJ5YqFn0ftvyJ8OVadeCket1ryCv1ET6lgYmfrJcEUMZUfHE3wUP1HJ7ACxlkHLn9Y17UV55C6baHgaVTKLDo1ilSI/LGuEaKBuqS/QjInNgKA56V34spOFtH9TUS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2g9BtgC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d80891c6cso55105366b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761083593; x=1761688393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc3WtDTd1WYQC9A9nm1WTBB9FxsPLQHScnVEcTR59VM=;
        b=a2g9BtgCQBcF4R1QXWCynwW3o0KpJTJid/msuZBMqqoVCsifab0apduzrNWmaxrd7e
         bLpeUqThWv3tL4dMUTIg+QpSLnbmTnqUQ/N+QDGaZmbIqBPHTM3albwzaQ6TgbFs2i56
         zpGR1k+7s4H+7acQDMFExA+lF1SBzo/sbPRv8WfHxuBW/ZY7JRihcvrVkCl8hDnJa7Mi
         7YD/dMz2HXwHcrFrSCp9FuD4LY7q1RMQgfeB1bxoJMr+inLgNocCb7hz4H37RdJjAXBN
         88+0uIfP9YTVX1fAJpxeMs5yQ2V4LKCd7E5FAaqlZNnWXhXHg//MknucTgrA+/nf5Yz8
         gC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083593; x=1761688393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc3WtDTd1WYQC9A9nm1WTBB9FxsPLQHScnVEcTR59VM=;
        b=l6Ya6+WJQIZhQAsMU1104o/rnEFCqSQbuXURne7mpuzZf+/fi1kpYsFH0vFvsLC1R3
         EWwH1A1TzGlwEw0j29YpP+AKMwKzEurKmvcjdJZfb8yRlPsLx0Gm8E79vB6nQjcOGJNC
         2DkLTcVnu/rE5tYrmpVmWlzv8w89kxuefqiSt6vSiTmGmKRjSZN9m9OWAir3C4JAv3e8
         Q1orJlYIFVvjiFXdKvZvZ1E1BH3XSVW55GRzrsDwpcv0FrvqpWUvVB14ZFnMaNKydaXw
         ATqAtu64FE98/UELirXe/SXdxSLV1Vw97p1p7yV3Tn2BeZOKaPc+KITfWT19tpCW8VhO
         cUHw==
X-Forwarded-Encrypted: i=1; AJvYcCXSetKy6pBj0XQLpv5YBhxKfkqwc408FGyPVQGbNRy65PEtNMp6z5Dq0LrN5lTvMv6LGUhQOIzvAd3RV49RR6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBEFFBCLe0P2IY1W31fooluSuyePv8mHjHI+f8vyDnxhCTiFI
	pIP4uEWqNanb5IaUUpQQPETN0RZ6rMVkWlHgqVPoDVpfrap61y7JgBfpdxCr0kLYkOnqMePDMU2
	PslJ52cO/Haq6DUPo7FoU8mF2YHhX/2c=
X-Gm-Gg: ASbGncvQamnfLGnJY5SEH0DJp0sLjnpJCCBPiPWL6ii9NHnsYI3oYauW1SjZaucT1A8
	Xs80DLvVSZQ8JQZoRIZ69aukDsWAp8hYYkDGHCQ4gNVznolG8KG7G+JYYSYx7uEai1qX88ODZ7R
	Y8pjuEVxxYWbikSJNRgoQVEAYfDIWtE4GzmPbncIAHlnqOzKsltGUympUjIZoH5xDWAkTseCnhz
	MXh8IUvMWga3xbXYcHLJe+od1HlTXOHYykPaK2/niy1mzpB4SyhwAH3OLBYntB/vWY5
X-Google-Smtp-Source: AGHT+IHgL6OS1zyNh0o71e3k4WV5Tf6ETzDakWmigXYDAG5OGfCGMEg6wbmkgvp8Wv+rjUuXZp2cr5meg9MQtWIDPkc=
X-Received: by 2002:a17:907:60d1:b0:b4a:e7fa:3196 with SMTP id
 a640c23a62f3a-b6d2c0f0100mr178904766b.20.1761083592864; Tue, 21 Oct 2025
 14:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007115840.2320557-1-geomatsi@gmail.com> <20251007115840.2320557-5-geomatsi@gmail.com>
 <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
 <CAFTtA3NoOZEMqYD6+vjP=09T15GiThjVy1LeDX0U8CC-4HMKOA@mail.gmail.com> <aPVYIOz8XRZ-737r@curiosity>
In-Reply-To: <aPVYIOz8XRZ-737r@curiosity>
From: Andy Chiu <andybnac@gmail.com>
Date: Tue, 21 Oct 2025 16:53:01 -0500
X-Gm-Features: AS18NWAt2pbpVXFat7QXlAftkjLF0aVf0hUbqLUhJriBx4VQpw1cMjJ_tGTeY0o
Message-ID: <CAFTtA3Op5e9gNrCrO1arpUw18oLQ4MX6cJxsiKCS+SZn48_qaA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] riscv: vector: allow to force vector context save
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Han Gao <rabenda.cn@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Nam Cao <namcao@linutronix.de>, 
	Joel Granados <joel.granados@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 4:29=E2=80=AFPM Sergey Matyukevich <geomatsi@gmail.=
com> wrote:
>
> On Wed, Oct 15, 2025 at 04:32:05PM -0500, Andy Chiu wrote:
> > On Wed, Oct 15, 2025 at 3:18=E2=80=AFPM Andy Chiu <andybnac@gmail.com> =
wrote:
> > >
> > > On Tue, Oct 7, 2025 at 6:58=E2=80=AFAM Sergey Matyukevich <geomatsi@g=
mail.com> wrote:
> > > >
> > > > When ptrace updates vector CSR registers for a traced process, the
> > > > changes may not be immediately visible to the next ptrace operation=
s
> > > > due to vector context switch optimizations.
> > > >
> > > > The function 'riscv_v_vstate_save' saves context only if mstatus.VS=
 is
> > > > 'dirty'. However mstatus.VS of the traced process context may remai=
n
> > > > 'clean' between two breakpoints, if no vector instructions were exe=
cuted
> > > > between those two breakpoints. In this case the vector context will=
 not
> > > > be saved at the second breakpoint. As a result, the second ptrace m=
ay
> > > > read stale vector CSR values.
> > >
> > > IIUC, the second ptrace should not get the stale vector CSR values.
> > > The second riscv_vr_get() should be reading from the context memory
> > > (vstate), which is updated from the last riscv_vr_set(). The user's
> > > vstate should remain the same since last riscv_vr_set(). Could you
> > > explain more on how this bug is observed and why only CSRs are
> > > affected but not v-regs as well?
> >
> > From looking into your test, I can see that you were trying to set an
> > invalid configuration to Vetor CSRs and expect vill to be reflected
> > upon next read. Yes, this is not happening on the current
> > implementation as it was not expecting invalid input from the user,
> > which should be taken into consideration. Thanks for spotting the
> > case!
> >
> > According to the spec, "The use of vtype encodings with LMUL <
> > SEWMIN/ELEN is reserved, implementations can set vill if they do not
> > support these configurations." This mean the implementation may
> > actually support this configuration. If that is the case, I think we
> > should not allow this to be configured through the vector ptrace
> > interface, which is designed to support 1.0 (and 0.7) specs. That
> > means, we should not allow this problematic configuration to pass
> > through riscv_vr_set(), reach user space, then the forced save.
> >
> > I would opt for validating all CSR configurations in the first place.
> > Could you also help enforce checks on other reserved bits as well?
>
> Just to clarify, the suggestion is to drop the TIF_RISCV_V_FORCE_SAVE
> entirely and use only careful validation of input parameter in riscv_vr_s=
et,
> rather than using both checks. Is that correct?

Yes, exactly

>
> If that is correct, then I assume we can rely on the simple rule ELEN =3D=
=3D XLEN
> to validate vsew/vlmul supported combinations. Additionally, reserved vse=
w
> values (see 3.4.1 in spec) should also be rejected.

I am sorry but this assumption may not be correct. The spec does not
restrict a 32b machine from supporting ELEN=3D64, according to my
search. There is a way to infer ELEN though, by inspecting if zve64x
is present on isa.

Thanks,
Andy

