Return-Path: <linux-kselftest+bounces-29330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD1A665CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 02:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8188218840AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0419146D65;
	Tue, 18 Mar 2025 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6zQSoqR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D00290F;
	Tue, 18 Mar 2025 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263036; cv=none; b=qntDjaJg/owG4w+hzsna/XoD/rhi5b9Mo1tcjKjm5V12rf+pNy9wot9CtF5Lle36ISHb6PiWiXzw1deqT9p1VaOaKG+tM+lKRza/JMM0+8NsmSKAULuC4gHAlSJzPSx69Fu+H3LNlfNZkCz+48YbyXnVIOwqMwflGWDWrUSIHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263036; c=relaxed/simple;
	bh=j08dy6Ls6K1QUKVpOOpSx9Ni12kdiHmtqn2Gz5Oybw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt2enkCK4KwSDMCl13uNzvMyLWHlclNid1il8ZNNXEIYSGnXKg4o4Lff4Tnwfyt6PRh7L/4oKtxp2Vk9wdcfnom8O/wnr6DZmw5dVRW9gSXhz6x0elgGn4of1qbZchATNOQcGtpcEi1xG7HsXFOA3xbguNathB7WmZAbmjWPqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6zQSoqR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso5160747e87.0;
        Mon, 17 Mar 2025 18:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742263033; x=1742867833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE7qX8FuCLcfXgHupd4BYIbEoHm+HsFfQFBSZENcXDM=;
        b=X6zQSoqRpPeDFhRwtSmbCiUNo66lIh+hre0L/VEhBDKdfeJLhwTBpuZl/QWuonOpIb
         9dQv57ptW8woWV+wzuKSELlXSB0Ks+pGZtJSTDhOe3IzaOUvURqmUU3N565jsABGAY4R
         RoWHAh2XhajI/BuNgdpU2iBQ8dU94oltFYZAC+weQq2K/0LUCjw2NK4Fq9pYwvSWv/LJ
         qyBTwLfisR4vODh/GV8mgnN69rKtX/dM2pSkQRCE8gmZtjSx6H4fXry6FyJkcyRRyAnN
         8V0Y0bYu/2NJfLmXQUY4k+4iwP6eLn2mtJXG7WTWOCT4zfd0rPrUdDgLVwf4II99hh69
         tmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742263033; x=1742867833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE7qX8FuCLcfXgHupd4BYIbEoHm+HsFfQFBSZENcXDM=;
        b=TS/d166gRG7XBvj7EIfeZDIiA+FmOlctKLh3qK6CLKF0Lhf1ppYcJ63IuI5pR0404g
         FQTuLio2ChEAIAKeJBP0YliruBSjzrAmFlKfQkwnv/71INXhB/NPl9ZVYqF+bHHa92Wv
         3Wfz14NbyMinSNhNvj1zwRxFP4M6DJu4fSicSJ722DtK4dU8j6teF6jbFIQlAxsS4Qax
         f1yYB3pLqIxPc6kjCnJLPoFh0YZA17sSP+tZJAommcq/b5rH2RubT6CHDcQ0RY0n/Rbj
         TtotmnJJ6mM707q4aj5uov4MPzbqETncxzpYTPSIePGGankYBBavEU0vw90pN/6eSDB+
         XRSA==
X-Forwarded-Encrypted: i=1; AJvYcCUVRq1hq5P1Y+5eiO1RrO0nHD9KQemrHkjrscqalbDz9oCRR08yN5woNrP0yqG6r4n1J21QCjcqx2CVJ/U1Vy90@vger.kernel.org, AJvYcCWHApdHgLG3bcrAiyLno5aB4c5kPg/roLxjF6kxhqvBFV1AFKH02tj3GE3WROtwnr6lSiH9avE85ERWMQ==@vger.kernel.org, AJvYcCWQkCRbqjCaNHqaloENH/0RPB/Lqlq0RawDROJPv7fF3PN1zpXVwm9d0B6lUT+5xbB6T29qQnBFPaDtZwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJDY3YAhXS5v24/8LCaWeUUBsEmfIgomz+VS/I1xrtUdStKNl
	vPMQSeEjh+KK8QVRCQ4HTLh3C9g+RCYoVSGkWx541e4JUt1MHFNjqN2AyJ9udKGNDZ82q+fbIY6
	NA4DCLAGjrW5NOI37bSjWk904MFzK/g==
X-Gm-Gg: ASbGncsqPncRCYUq6rkFzmnF5MDhU/RluicQYnLxzNxuB/bgm5CdwFQ5n6+7AANjuZX
	aPdtwOFl+/LbUcNE2wHbMiylyyCd0zqHfkxcQRSlzx371HEX7C0SR3KTD2le4EKGdV+xg29qLor
	uJxZ64gws7Z6LkAPCKK5x1A7ULrNs=
X-Google-Smtp-Source: AGHT+IHV3VMsmkp5g1hvQ1dAI+2OHwFGehDZeJZWpaqHPHNWDue+oqFrkH836Z70y/AALTvehw/mpTpqODtk/ZbEa04=
X-Received: by 2002:a05:6512:10d6:b0:549:b0f3:43a0 with SMTP id
 2adb3069b0e04-549c391a806mr8314430e87.27.1742263032621; Mon, 17 Mar 2025
 18:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
 <20250317073746.GB5114@1wt.eu> <dacaa712-08a8-4fd6-ad47-2226040f02aa@t-8ch.de>
 <20250317181402.GB8377@1wt.eu>
In-Reply-To: <20250317181402.GB8377@1wt.eu>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 17 Mar 2025 18:57:01 -0700
X-Gm-Features: AQ5f1Jo5OANH4Dh7e4judxh1shyUPCsyiAeZ8qg50Am6PaK9PjuWJk5A1PlnCDo
Message-ID: <CAPx1Gvd5JHE6c_de+ZGY4BLPw25Rn1jTd-G9XMhK9xn+cAfbJA@mail.gmail.com>
Subject: Re: [PATCH] tools/nolibc: Add support for SPARC
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:38=E2=80=AFAM Willy Tarreau <w@1wt.eu> wrote:
> OK thanks, but that remains quite strange to me. How can we end up
> here with such an unaligned stack ? At the very minimum I'd expect
> all offsets to be multiple of 8.

It's a peculiar feature of the version 9 SPARC architecture and runtime.
This also ties into your window save area question.  Let's start with these=
:

 * There are 16 save-able registers in a window.
 * Before V9, registers were 32 bits wide.
 * V9 and later, registers are 64 bits wide.
 * Each stack frame must provide an area for register data.

Now 32 bits =3D 4 bytes, times 16 regs =3D 64 bytes. So for V8 and lower, t=
he
register save area is  [%sp+0] through [%sp+63] inclusive.

Now V9 comes along and we need 128 bytes. But we're going to
run old V8 code in compatibility mode! How will we tell that some
function f() is running in V8 mode instead of V9 mode? [footnote]

Someone decided that the way to tell would be to use a deliberate
weird alignment of the stack pointer. If the stack pointer was 7 mod 8,
then we're in 64 bit V9 mode and [%sp+2047+0] through
[%sp+2047+127] inclusive are the register save area. If not, it
must be 0 mod 8 and we're in V8 mode and things are as before.

Why 2047? Well, by observation, it's more common to need negative
offsets from the stack pointer (for a large stack-area array for instance)
than it is to need positive ones (register window save area and
overflow function argument area beyond that). But the instruction
set is more or less symmetric, with a 13-bit immediate constant
offset of -4096 to +4095.  Solution: add some offset to the stack
pointer so that function-stack memory is [%sp-4096] through [%sp+2046],
a 6 kilobyte range instead of a 4k one.

The stack offset therefore helps solve both problems: the offset
indicates whether to use V8 or V9 register dump conventions
and, at the same time, increases the amount of easily-accessed
stack memory.

[footnote] This provides the ability to dynamically link V8 and V9
code together.  As far as I know this was never used, so that a per
process mode bit suffices just as well. Still, the offset went in.

Chris

