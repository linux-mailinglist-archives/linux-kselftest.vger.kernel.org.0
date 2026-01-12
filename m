Return-Path: <linux-kselftest+bounces-48740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEED124A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 12:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F113006A7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECC34DB7C;
	Mon, 12 Jan 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fI3zlEyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE9311966
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217027; cv=none; b=i7NQQlLq8ZGc/uNZiNWyaLPOG8TzhYg+784MhmLTrqHTRDlDbXlNjRMfVO6Pz7pcU52E4Za9NVVBmPZv4z3eJVNhGDxuKN3MarbXGkRVbjuSMqGzny7pSUjmBSM7Q+vOfB2s8l9Aw5E/XlsEW2hqS+ZLDx8oXht2ffHbDz+GBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217027; c=relaxed/simple;
	bh=ajRMqfg3Iu6ftKzqCsT8+HOpCzk+/0m03nVwJlD6Hjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klY0ZKnUq2BzFeBtqWLFDgx7SfOElwhQJX4MlsWGz+7vGDyouuZSfM3yfBeSZOOcwNn9YRHi+5KOoyDKAju3jp70tTtSyssZYkKYy1qv45W6ZFAok0LI81jduVvXnhVYe5l83NIwegK0llHYIZ6jfTHHeX5EVUwuE+iw30r7RIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fI3zlEyG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so8315200a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 03:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768217024; x=1768821824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBJVwmKcRSoH6AlMQ+Hm8Jv3D91HO1Kgm39cLD3CPfU=;
        b=fI3zlEyGHtynWjzV9FAd/7d1lfs4UmncdWmQ4fbZNibCC171+YI4QyuztOou+pLV4G
         PBVqURpQnueiE5qVmDdhZgdJBOirwuB+PM0ytSvRc2xMSDDSB1mywDa0HNiA/zCGj8B+
         GcXC26mg7DncNy6BVIr5AvTJbehhCCywf0/tJfGvEa+0iPmuxWuPKtUe0F7+Nk+obeK8
         6KoAlTbqm3AZNqshliWhYe3zqDhD+vXNpE45Yz1iyGP7tgh4Uk6rYA/bZIZyhFHIWbxb
         /GzhgOdgf03vEqjaeNRve1PxqRcjWhQHyA3dF5Lf7/U7Jv0+VF7POqiJ6XYnqAuRYXT8
         cVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768217024; x=1768821824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBJVwmKcRSoH6AlMQ+Hm8Jv3D91HO1Kgm39cLD3CPfU=;
        b=ePk+XbNqqY7yl4rTgqYRprkpkn+lwtyoT8u9iHg4sCntlsqHRy8TrrhaaMpjUXn4Lf
         kB3aTHjWFnUEF5Ngs81/dk4L1dDlzSigtfGfm8PE/jYZEroGzN7llqhwznwIV8SK0o8t
         QZTn2t8JC0VVADlSZPj8OfqMnxLc/yuY4iEtU225ibv8J8X0yv5JM7XMrisC9hGYY623
         tWtuOAEMvXhpIqecTIIC6qD9m0uElXqp9X32DI3JRC+6FKK910YfAJLy75AGjU3RXAv7
         X0TjGy8wlEUg4NRyk8Hk8BwBY59wXCddUPYem41F3fHiNLgiEfU5SheAF7BsUTo0IKBe
         1kuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEESMrgu9ABS/sNFejrDEboBGBk6aIVQIGEsHXnQ6gPbGrxNDKnjyWBOp2XtR2ncRpCk40rByDLmLq1sr/FGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71xsoiD0LWdeblbO54JYjGw32hH861zWEWnaEnbMtrylN3TFA
	udmwCJW1Kbe92EGHWpZ8n8jL5TxMeezTHoqI5pSFHWxrShr4AeoqO4h4ZzliJCh1Q9wi1ID/7m7
	UXrlcqZ9NK7SgYVqhqlzIoOg3Ki/HvwzOnUNugpSe
X-Gm-Gg: AY/fxX43RbtdyOHwKRml2KeBdeyIL+rGqjUbL99EF/iiAOc0yjKXlu4DvIIYv+Qr0ZU
	ZyCq9asLXFkyoI9shsFHKTZG8if5n4vWQFYKuY/sRH/q0zlV18fu3fG0PdHU9ylgDatAehg9wNU
	anHeTkifxEcRhH1gQ00OHRWht6pViF+vWZ3kGKmno4rRgziLp6LwTV4qKoIH7y8rBfRmGjGkxn3
	CnOo89DU3hwqN1EfjJMoqYfS1gvUSpqcTCvcdv4n2wl5IxNGhgmN1TMCQvF+ByMf6ONZcDNEstt
	A9eG7CHNGxaHI4uad1amdsNx2A==
X-Google-Smtp-Source: AGHT+IE7mYy/I/wZ3UnKMF/2mwv7TKwH9ZjdmBtE7eAT0PoUPJwFXGs7Zady4+kVApq9n/DdYO8m2jqqfn8UYx10X5M=
X-Received: by 2002:a17:906:209a:b0:b87:29ae:2b96 with SMTP id
 a640c23a62f3a-b8729ae6e6dmr97176566b.12.1768217023973; Mon, 12 Jan 2026
 03:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217135932.3153847-1-srosek@google.com>
In-Reply-To: <20251217135932.3153847-1-srosek@google.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Mon, 12 Jan 2026 12:23:31 +0100
X-Gm-Features: AZwV_QiMqEjwSuw2IGPfD1uXX-KUFhP_vmbO9F1M6B2k1mlrhaoHaE3lgQFout8
Message-ID: <CAF3aWvHbSgDYxgFHF05FkEGQncMUXsuwMPDBCcoXUGoQgESuEg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] selftests/x86: Skip int80 if not supported
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: Betty Zhou <bettyzhou@google.com>, Wake Liu <wakel@google.com>, 
	Kazuhiro Inaba <kinaba@google.com>, Jeff Xu <jeffxu@google.com>, 
	Alistair Delva <adelva@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:59=E2=80=AFPM Slawomir Rosek <srosek@google.com> =
wrote:
>
> The IA32 Emulation support can be either removed from the kernel,
> disabled by default or disabled at runtime. Some of x86 selftests
> are crashing for all of above thus is_32bit_syscall_supported()
> helper is added to skip int80 syscalls if they are not supported.
>
> Slawomir Rosek (2):
>   selftests/x86/ldt_gdt: Skip int80 if not supported
>   selftests/x86/ptrace_syscall: Skip int80 if not supported

Hi all,

Just a gentle reminder, it would be really great if someone could take
a look. Thanks in advance.

Best regards,
S. Rosek

>
>  tools/testing/selftests/x86/ldt_gdt.c        | 21 +++++++++++++++++++-
>  tools/testing/selftests/x86/ptrace_syscall.c | 20 +++++++++++++++++--
>  2 files changed, 38 insertions(+), 3 deletions(-)
>
> --
> 2.52.0.305.g3fc767764a-goog
>

