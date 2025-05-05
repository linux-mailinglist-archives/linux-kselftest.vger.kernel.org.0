Return-Path: <linux-kselftest+bounces-32341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB63AA93CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383D33A6F27
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E87252283;
	Mon,  5 May 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G531Kove"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80E2517B1;
	Mon,  5 May 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449902; cv=none; b=g/ahpeU06URXCWZA85ujX4lnm5/8sq+iK71gKZa+sfwsY6TLA7IOV8kOJ9quFggEtiFPK7nEX3xEP6U/UzC767RWJXCH7Vg4DRIsnCLk7LJspVjbGuTXIxCYZU81hxPtprDLzhL5lDtLAXQY3QkvarDtvETM1uxYEhZ1IXQOzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449902; c=relaxed/simple;
	bh=zUJfziWAGP2+Gb35t5MMHAlc3r4VppAN3Xf6keJyrXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEGqt9bTDjrvcT4Mwmqo7PCH6vlWedaX8Q+efXGk5psBSm5DMkiGNJWU4kb5fVhovEzfrClW3NfKrlQVH1240kNfDAkRuo7mJuEDovOgt2eKtuOWnIs8prDphEMPyzfMF+g3arBOIgMILVU7JTdhWSkK/RRk1PdhZgYYVX3BxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=G531Kove; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC196C4CEE4;
	Mon,  5 May 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G531Kove"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1746449900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1E2O4wlc3qZ5ZvfelMaj2liJE8Ndd4lVZIoL+xu/sQ=;
	b=G531KovetTj6YEJp7dqR6JpiEvhYN9hsFAPbcXKFeJ6VoYXowTUCohtkd+9ddYIRw8METt
	xwP0fY9iK+bqzBiUXRgo3Hnjbz/dRV4eI1IEg3QOj38WSCBwAdoNbtA0NjG+BL4xo+RSqx
	YpqvYSAZyBCurtu2Z+LY1yu/FMWslVo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 796f16d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 May 2025 12:58:20 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2d4f8c42f49so3044566fac.1;
        Mon, 05 May 2025 05:58:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIsw5T+qHOi7PpP6t5Uip1tGNLe4K46Wl1sgL4triwcKT4e1uhcHvCwQEUJNz8BLlzjn65iyCCMqmM4y8=@vger.kernel.org, AJvYcCXQ9bQbQbsFQTIMa81g3n2GLJhedIVilcSMcqn3nGJvzvDnOxK7HCI4QRs9dh8/dY9Iktst2U+UykKd4RrBnW/D@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+9m9sq5OkjrH9Nkk/35VmASanC6AluKIAGNtRYdr2zaLl4qq
	96rxlVbrHoWFtVv8wifqEvp6U9nDsx3i7f6OZdVhoF/mLvqMXIomidr+xwYda4wBaHpNlSf6bTM
	HiIKqEQ2BII2aEsjdLTGX3aI60uQ=
X-Google-Smtp-Source: AGHT+IEdrqURA6nv3beJvV2jOQXW2GGmyAGQrNeF8oucxH1ZUimpuTLl8YKIlHxEGlHM5TMIx7/V0i0OUvDgadLOgk0=
X-Received: by 2002:a05:6871:208b:b0:2d8:5015:1a8d with SMTP id
 586e51a60fabf-2da93aaeb9emr9482003fac.11.1746449898844; Mon, 05 May 2025
 05:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de> <20250505-selftests-vdso-fixes-v2-4-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-4-3bc86e42f242@linutronix.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 5 May 2025 14:58:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9ppP0mAh6HMaHDi+XTuU8E6be9wSPYTYO-GvX=vYJCYeg@mail.gmail.com>
X-Gm-Features: ATxdqUHCIk4fN7_3pTZKn2m-GTOYNSlswNMtBkbYEcmnRNWz1C-sSyFjRBS4m_w
Message-ID: <CAHmME9ppP0mAh6HMaHDi+XTuU8E6be9wSPYTYO-GvX=vYJCYeg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] selftests: vDSO: vdso_test_getrandom: Drop some
 dead code
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, May 5, 2025 at 11:19=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> vgetrandom_put_state() and the variable ret in kselftest() are never used=
.
>
> Drop the dead code.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/vDSO/vdso_test_getrandom.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/t=
esting/selftests/vDSO/vdso_test_getrandom.c
> index f36e50f372f935e6d4da3175c81e210653bdce1d..b0e0d664508a38d6dde9df0a6=
1ec8198ee928a17 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -100,15 +100,6 @@ static void *vgetrandom_get_state(void)
>         return state;
>  }
>
> -static void vgetrandom_put_state(void *state)
> -{
> -       if (!state)
> -               return;
> -       pthread_mutex_lock(&vgrnd.lock);
> -       vgrnd.states[vgrnd.len++] =3D state;
> -       pthread_mutex_unlock(&vgrnd.lock);
> -}

This sort of acts as example code / basic reference code for libcs and
such. So I like having this function around. Could you just mark it as
unused with an attribute but otherwise keep it?

Jason

