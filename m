Return-Path: <linux-kselftest+bounces-25707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39297A27822
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F077D1883C46
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F9215F5F;
	Tue,  4 Feb 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Styy6zuo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184E175A5;
	Tue,  4 Feb 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689536; cv=none; b=Wgg61sSiTrp9xDzEaP33de8RYpTlQhwO/KexTdhDs7okb38aPBh7qLprK7xeKZlkQxuCXQzj133P93h8pmnmGQH2okze9c8dQ8SP4sqk5T15NZrISYq2fgNX3nVHSPVyzyGKMilUEjruuQtRsDHFXHhHk6sXI6a23q6zJGl30+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689536; c=relaxed/simple;
	bh=iCKigJ0HZA68QSj6vDaNOuse7H6mg4VWTsT+3IwbyPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGcS3L3FFeBmRGSx7au4r0xNew4wO14gjc8EZ5iDVDmu7HpgTWxmHqSZPHyUtqml9ZIDNqxnSvGrNaMDhN8rjZwJkD4Zo6PTbqyzSdc0Gyi3qRJ5FceUcGODyDH+8fkyBfneXCCWFnzOiAPXnpycNfk/HFYnSd31fjgWCCQ7Hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Styy6zuo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38db104d35eso499019f8f.1;
        Tue, 04 Feb 2025 09:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738689533; x=1739294333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48HwAkSZSqOHaazP0j1e1zula7SeoySs4jwygMRaYcc=;
        b=Styy6zuoeNY1rVOs32hbk92+/+d8XxGrmBv9Mu1/eIO+agBiYrqnENjR2qLz61AMNe
         vGqA5UIhSMtaPBkIzjYAb2qTyNxzsVAD2XgEj02bSAu31ZI98pSussP1rNeRy8Yx6S4V
         s3OPHf0lvpd7NwzEjev8GdJqdNfURt/s9D9of24JvnZCsBKVx/vLOZEBfXshaoHU1FJq
         J1orbpS8ixwpoSMVsmbJe508+tPXXQV/8Y8CmMnPaJc8gNVi7CgXLG43OXTbsHzdvJOf
         mRWo0Y4GlwHZPw8/EEkq1Oi7dm1bAxa66qZCDXafcykY+HLICpcLLkUuhqiCG8qjZwAD
         2DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689533; x=1739294333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48HwAkSZSqOHaazP0j1e1zula7SeoySs4jwygMRaYcc=;
        b=n4XogT8eNgCIZZrI2rI5LI2/XECexyaN+aEF5HiO8bB5vmss+dOoPtO3B+Tyqz21/D
         xuIo2PigaTBwVD7DSnTnWCK5pTCnTyexGhaQCrcFOhGXwBk4kqGcA5v+pH2kK2Whd8qF
         EnAKa8T6zwEVKuOZZXOjChdmVyIeBqSN70tIDAWO4MGRSNj3d9A/dEVx7I8y1aPZoE2v
         mDsCBS/TdqCi6CE9Olk+A7XcSFhIbJOxKzcKDb2atPUE9Ko+QNo3+vB4k8DYktXAbW+v
         p9j5kM74huF0gjQxhOJ22EmStUEV4P0zk+2aRlF0oe3dIXEBSxITyejiXBpzXt6evtw0
         fEcw==
X-Forwarded-Encrypted: i=1; AJvYcCU2zjjZl9V2vzmT9+CShM1CNCj7Pxw4NJxfk348QIxYBOUKrUT/M06kmiOnR9U3IsJbie0=@vger.kernel.org, AJvYcCUuVOr+sXNs44Iala61CGYxmuLi70E4Sn+i1db+FcQz3RZWPZ1NQeVgjzXH/6RXsxI05zn0y8m3k94QT0Fc7yAzLw==@vger.kernel.org, AJvYcCVA0elEs7IQiweSJJFRJMU90C5qFO0UVVeFdpCIMk3ofeYG5EB+WLv0sFXzUNQE9Zv+pGU8pmp4fK2vgQjNYg+cygyV@vger.kernel.org, AJvYcCVLb93l1v9mtfQiBAjh4hWbGebVDx4OQX6szuZzC9FHLuBcuzuEMavj+X4gdIXRVPrLKCpc3Mrd5qTywSFe@vger.kernel.org, AJvYcCVh7WyvinaBGXVoMaNvXeZIJkPt7S11Ecs6Vx5JQDtD7Ggo1ZBIdT0JwM6HnkejV91pja1RiORkFGZ4xMo=@vger.kernel.org, AJvYcCW92UNRtt550k0Jn395byJcMBz4bgSx3IM1adyjhMNh9YqTht1Ib+JmaLrmbMKXlNme5rebejZ4gzMpu24uZdR4@vger.kernel.org, AJvYcCXSXDcWV1EQj+Vxv9/v6o8KKTt6DqWOJ2WnvG+wQgArQTTWwr0z53KtBOIOXoYhI5a3sKPwGT+fOfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HgOgFgWeoaQHunkBOkximaU+kqdySKHIbJnCH19GC2clg7to
	RPjR7E+QQtxKuapk16nfDjZNGWABecMDxLrlE0YHXmtANVS2J9LDt0eOA5YhpDDfY5zpJhkSHtm
	y+C0v57GXccdgtLRkQqW+tkKmsJs=
X-Gm-Gg: ASbGncsQY+UrkVcmm60TEbE8sajvqO9SVBteO8nNIQqmOEDvU0HT6dhlbKcLDGlmdgq
	R75oiuWzZstReSgltWzZDy5w8RDrFLh2pskuR0gUn2UY+qJ9R4NxNc4Xah7tBsgt9gvigONCU+z
	dSxhVQIY13z/AX
X-Google-Smtp-Source: AGHT+IEXetkSjzbQZIwp25yXpZlrJ0E0C2WLKrhLJmskRoaWd8NBYMuAQjs4C4NMhIU3irD5IAyKftnklG5C+REE50Q=
X-Received: by 2002:a05:6000:1a86:b0:38a:888c:7df0 with SMTP id
 ffacd0b85a97d-38c519380demr24381826f8f.1.1738689533094; Tue, 04 Feb 2025
 09:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
In-Reply-To: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 17:18:42 +0000
X-Gm-Features: AWEUYZntw4tyOlfb-7X3bQw5d_xFnYc5vrj6eRh2uvuHo7xJkIfniobyMxPX5XQ
Message-ID: <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Quentin Monnet <qmo@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:10=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> The quiet infrastructure was moved out of Makefile.build to accomidate
> the new syscall table generation scripts in perf. Syscall table
> generation wanted to also be able to be quiet, so instead of again
> copying the code to set the quiet variables, the code was moved into
> Makefile.perf to be used globally. This was not the right solution. It
> should have been moved even further upwards in the call chain.
> Makefile.include is imported in many files so this seems like a proper
> place to put it.
>
> To:
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Charlie Jenkins (2):
>       tools: Unify top-level quiet infrastructure
>       tools: Remove redundant quiet setup
>
>  tools/arch/arm64/tools/Makefile           |  6 -----
>  tools/bpf/Makefile                        |  6 -----
>  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
>  tools/bpf/bpftool/Makefile                |  6 -----
>  tools/bpf/resolve_btfids/Makefile         |  2 --
>  tools/bpf/runqslower/Makefile             |  5 +---
>  tools/build/Makefile                      |  8 +-----
>  tools/lib/bpf/Makefile                    | 13 ----------

Nack.
libbpf and bpftool are synced independently to github
and released from there.
This change breaks it.

