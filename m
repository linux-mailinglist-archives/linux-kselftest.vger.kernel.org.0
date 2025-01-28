Return-Path: <linux-kselftest+bounces-25301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80DA20A88
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CFF3A6F78
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43319995B;
	Tue, 28 Jan 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2jK+SfV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802A290F;
	Tue, 28 Jan 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067069; cv=none; b=iACGHHnwssZcWuqt6iz4s6QraGDlt5Ax9oSQtw7cF8TPSxb29nM0zKJyNTGjBmjjcHPv+9REUodDZmwvRpex4XM8EaE2wcaLTdplBm7nS4VFE2y6+WzpfzwuDUs65ZJWBOHOuPFFrTOssl6xQJawaO27WgNqqwUIUk1GCzsKE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067069; c=relaxed/simple;
	bh=rk6I/LnsK1V1KhN/DyrVi7LTONTlzqX5P1y04J1b8bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHL2DBO64bzOd0KgIZ4K+XkWdx5qMfxK88NkjIZ9IBmXLFu4sapbH8tUGdSN1EmYapud3RUN39qhTrvVnW1uy36JIcX7scbjo1D477a3sIMQZHIHl09yQWTV9u5X423najnGZ/p0Y5gl5mztBesVqYDClecr1PU1ZM8ip1Xh6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2jK+SfV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30227ccf803so51157971fa.2;
        Tue, 28 Jan 2025 04:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738067066; x=1738671866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upRXrAeVaXyeQyXXNAUwtCIwIXa5qrKpW/iheEjVT/Y=;
        b=G2jK+SfVhf82ipSexsfFs5xaA7GYoPqIz1nT/4IOF2+KD8iVXl3bTMgYozaFrY0Oxl
         6/4C+xwvrx6FvydTktTF0NxyfGpYWE60aFLeB6Aekp2zISKAhy5SIkxFOn+1iKqUkMu8
         6Uto6rQwq0NhHCV1jA+ZGlZFlzPS0riBeQswr6m26bWAHO0TdFLYLOwhSsmFpOLMYPjz
         B2iRzYbwSynhj1INhel1522KIgugb5iUZ98Ryb1BsXun/AylaF6TY1kNCR+R9TWjTV1s
         oY5jnG4eaYDPFtKUepOL0APN5rAoLVk+N1dWEHXxP8e3IC4X+QWLZmhjaPZFOeaSl94P
         nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738067066; x=1738671866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upRXrAeVaXyeQyXXNAUwtCIwIXa5qrKpW/iheEjVT/Y=;
        b=UyVmo+2p2q4pYNDcihgn/tY7Zx15oLWqtGqFrc3L6yA4jZH16aaZgYqadzHn25Bloj
         ilXiONYsY3hH+0SF/ayLIwU553tfR5O2VlpXPL7buAT95BAXdmWnPm72B8APUdGaqfaI
         ZJ1vTBThH424SNGTwBZytdFdOVHKnDiUBcgpE/4YLNCYtMdy136s+OavEiyKndEAWh/J
         4xEG6hhJ1OMwEf3h0UowcJY+6KX2r2nEGxGiWNiUhsvNftwjqNchLnSjCSRe/ai3Ujhg
         ikIxqXv5mOiQ5lKmN3t7waYxm40SmxvOK6Pjm2f97SMW/+5xNN/PUTopy1cX5LLYnXp5
         741w==
X-Forwarded-Encrypted: i=1; AJvYcCUWlB3CKKNugSzoAQ07qLUq7JuwbZc5SoRpVebvCdK7W4E/pdKuiFucIXi4hTxwUWUx01hoNKioZ3nllHTFWYA=@vger.kernel.org, AJvYcCVXnBYSVnJI6UB+3n/apUvdHFr0CdwYqftvr7XBVeV2PtoOf76BOGzww0AMSEshwrp7XPgOyx/UJYTx7Lm9HIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0RJcATpBXho7ioyWQj/3ND4vKnb35RZYLAWALkg8kL19YpzNW
	QrTIH9ZIundQ9mgIYBM3nKdoetcVm5VDao+Bz03Wz/b4D3EcM5MhZqXzK3iYrxBbeAr8igTk71y
	w1STUw4z2wJWA++VR3xhaxmx9Mc0=
X-Gm-Gg: ASbGncuTIBaT6GanZUkcRntrptdMBjdm3AEq2Q++npgFsZfU8XlHl29ZJ+GPiWlg/zg
	/eUQ7/xVHnTy14eEXY6NoW8BEMBy5iQkPLEK6K9wvqChpV8cne8A4Voc3Re5vgMG2wrs43xM=
X-Google-Smtp-Source: AGHT+IGLL+AKov+Gd71cOdThKlFX3LEp+ZilobVybmABWfEGX4KABD1qXwSeDo/SBrRdK5AvSL+k+S2AlCxtVILQH7Y=
X-Received: by 2002:a05:651c:210c:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-3072ca9802bmr205489661fa.18.1738067065617; Tue, 28 Jan 2025
 04:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126223627.732451-1-sergio.collado@gmail.com> <CANiq72koWg-GGD3w5mJw3F-hGrOBZ7hiK1G4pHY+y_rQmtG5+Q@mail.gmail.com>
In-Reply-To: <CANiq72koWg-GGD3w5mJw3F-hGrOBZ7hiK1G4pHY+y_rQmtG5+Q@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Tue, 28 Jan 2025 13:23:49 +0100
X-Gm-Features: AWEUYZlPVvqoCCNBcf6_DwYt5qwGz4hCazoVpJdHrjVLI_sVKl59qTzx-rvl_YM
Message-ID: <CAA76j93kQG0GjaMWpR+AnxPWDO1ud0SLECCE3uxN7FAyNB6Dsg@mail.gmail.com>
Subject: Re: [PATCH v6] Kunit to check the longest symbol length
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

> > +#include <linux/kallsysms.h>
>
> Typo?

#include <linux/kallsysms.h> is needed to be able to read
KSYM_NAME_LEN: https://elixir.bootlin.com/linux/v6.13/source/include/linux/=
kallsyms.h#L18

In the file insn_decoder_test.c, is added otherwise, when configuring
that test with CONFIG_X86_DECODER_SELFTEST, you would get the error
```
arch/x86/tools/insn_decoder_test.c:110:24: error: =E2=80=98KSYM_NAME_LEN=E2=
=80=99
undeclared (first use in this function)
  110 | #define BUFSIZE (256 + KSYM_NAME_LEN)
```
This was proposed here:
https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/

Cheers,
 Sergio

 Sergio

