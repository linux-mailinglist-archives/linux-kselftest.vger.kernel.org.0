Return-Path: <linux-kselftest+bounces-19538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC699A2EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD3A1F23E51
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9E6216A04;
	Fri, 11 Oct 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PGfRjZYv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAE216438
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647023; cv=none; b=im6alKYn7pXZNaW4Ms4Q0dc8KQ2UDe32IuZTrJsrwIz3ToIqShs3W4XWSNI7qL8dzDZk1nqr4/jRyBce9mZlC4StcMQrWd/N4tCbl9KLYWggKUALEdh4tIL1EPAx9CS/Bq8doF46JvxAnLkDmjjb33iS30zeqAgT+J8Joi6VPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647023; c=relaxed/simple;
	bh=mWcKeontfzrfp7f60f6MmEETNBLjE4zS3Mc56feFD20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dszotmYRawN2F6lG9Q9J5m6OKtiNhPEmvStt6ez0sc+QJQRwyIPYX0Ij3edHoK7R7tvUUBApHZxPAwFR7YGr216J+fw+ju4yk+9/Tdexe15wOgML7jp3NpFQ6246/mWGIh7pOA4aYsHwqRHgNyKQS9rg4ehw4/Nv7aP8eFS59oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PGfRjZYv; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8377fd760b0so38735239f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728647021; x=1729251821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ovf+VMWvRmikxbDrCpt5EY3ct9SPxEo1lO8nMoHDCU=;
        b=PGfRjZYvIezoX3JRlMEjwe9iTXQKrgdzxUCbg6PunShEpmU/pd7Qh6pKIU3cQ+ld6Q
         1xIUr66mYx+ituRCxmphlzHXRCD1QoaKQaPM0x+WEDulBy124mkzVWaCo9T3Nb86emJq
         CkQ2kCcm9r8EpFOYXZbMIVve5f4FV2NCaTg5nRXuEWk8Fd20Ao9PhrHbbPV6pP0CAaUx
         5DWGS6t7/NE7CEsrdBOUC9/G7cQ3wHASGyWS/VfwhBMSEnGpTkD25p75gX6fHswyaEH4
         UITt0+AMxWmT5lyrzDmgnfjRa9HO3oSfpLlVPpQoZpJ7wEWPDnqFZ4B3h8E+dssxloZ9
         YgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728647021; x=1729251821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ovf+VMWvRmikxbDrCpt5EY3ct9SPxEo1lO8nMoHDCU=;
        b=Ml33jPDDAVd1G9rO2zqZNIDA1qXH3Niv4sdep2A/XQ6JCbBIxgiF8sswTeH7+luvfv
         gdDIiCJfF28fUfOzfrtqCPkFJoEO+2blRYPr6UxXPTn0O82LwFJrLkFbI56XJzV/HlpO
         gcLRGkQcQg/MTWVdLPDJSAMrKHyn76fvFmP+G4xThagdvdfxWIOV1Ir2+R6qRQKRFLQA
         4+9kGAtaf0DbbTQCJZshI7G+2IPgcVIti9ZjkTWub4QOYOsdqTGraLkFGJPqkGnIbEUM
         YOtCy/yqPrmXXGFITC67qGy6rGRCW0WIJp44FK5ysG1R07m8WiZld+nVI4fpDHyrET3Q
         MMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmCBXhESfUFbd1PDRjSS3Q1QmQuUgs0LMGONjGnixbIJbpms2lS9N0KeTGFcEVDz3e9ZSfgSh5qYw9KOriXnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2gMJKGhgNRbzczpXAXzTMMArPLhGWVftw5y7rJtg+JhWM/NK
	gIagqbKEBqsGmnR2SlXh0XN0pVFtVH71/iDUEF5oclkh7Da8IUzj5wLMUSgdU84z9i56hL3N93I
	vYpJcWvUwKbSU2Qk1ptoLHewJjTvDd2oG/Yl3VQ==
X-Google-Smtp-Source: AGHT+IHrNQBq2saNjK73V1T6HuEouWOtzpJQWDAr8+Lmcf5QP/uhztfapf3Yw6Qr2s1M/KXX4B0xAsxQWbLFxqc5Tgg=
X-Received: by 2002:a05:6e02:2192:b0:3a0:7687:8c2d with SMTP id
 e9e14a558f8ab-3a3b6019b61mr12545025ab.26.1728647021428; Fri, 11 Oct 2024
 04:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-33-60d9fe073f37@rivosinc.com>
 <CANXhq0pXVS2s-hZNusPLoQ4qPkyi1S2BTQ-FyAvcz=cDctKQng@mail.gmail.com> <Zwj7aZj36TBGzpZa@finisterre.sirena.org.uk>
In-Reply-To: <Zwj7aZj36TBGzpZa@finisterre.sirena.org.uk>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 11 Oct 2024 19:43:30 +0800
Message-ID: <CANXhq0q49k6q3ZGYqzczMeFr+_rrfa9mL7FMu62xPHeUKfvhMw@mail.gmail.com>
Subject: Re: [PATCH v6 33/33] kselftest/riscv: kselftest for user mode cfi
To: Mark Brown <broonie@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 6:18=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Oct 11, 2024 at 01:44:55PM +0800, Zong Li wrote:
> > On Wed, Oct 9, 2024 at 7:46=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
>
> > > +       if (si->si_code =3D=3D SEGV_CPERR) {
>
> > Hi Deepak,
> > I got some errors when building this test, I suppose they should be
> > fixed in the next version.
>
> > riscv_cfi_test.c: In function 'sigsegv_handler':
> > riscv_cfi_test.c:17:28: error: 'SEGV_CPERR' undeclared (first use in
> > this function); did you mean 'SEGV_ACCERR'?
> >    17 |         if (si->si_code =3D=3D SEGV_CPERR) {
> >       |                            ^~~~~~~~~~
> >       |                            SEGV_ACCERR
> >
>
> Did you run "make headers_install" prior to building kselftest to get
> the current kernel's headers available for userspace builds?

Yes, I have run "make header" and "make header_install" before
building the kselftest. This error happens when I cross compiled it,
perhaps I can help to check if it is missing some header files or
header search path.

