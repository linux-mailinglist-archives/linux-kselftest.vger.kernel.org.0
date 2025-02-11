Return-Path: <linux-kselftest+bounces-26397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB4A311E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88CC188C7E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92425A331;
	Tue, 11 Feb 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR7eoagT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676525A2C6;
	Tue, 11 Feb 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292018; cv=none; b=GHKw2yTfsm/58hP8UATsw0levHCe5gHj4+zQYcWP01NSM4Om4rsfiC++6qb15pZvx4pvQX5bFFr+I0nMS9DiPC8eUZgYnSe7fDL4c6sD9f4Fd4R7qV9MukSA448Bo+Hm88OcYSUWhibl9KOcFLEP2PZgR1gB6htVcO0YbOXXbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292018; c=relaxed/simple;
	bh=nZtI7PetkZp3+eY+AkK3cc4om3sr4dFcTc7+7+vCFV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL7Xw9X6fNPGXWIWWiB0PALRyc937LrK/k9b0Da95Y4e7hx15XbCyCu5e78Q//hJSQEH0tWZzXvn6B/DNL/SZnPmZK3SDHuUAy7UUk4euHb7FLe7mLMOmh3BlruqdclJ7EN8uLJMizPbIFgvdpxTxi6h/O6x3PIjqq8rb/ha7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR7eoagT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso25187851fa.1;
        Tue, 11 Feb 2025 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292014; x=1739896814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZtI7PetkZp3+eY+AkK3cc4om3sr4dFcTc7+7+vCFV8=;
        b=FR7eoagTyPDrW/M3UjTqCDUMf1MlNRKqsPEEJmmN734j653q3e3AAHfa4YPyG4re4g
         OCGVWHTgKY3YuS8MP5FuWMH60JqiWt9r3Fi3LX9cLnv/aoRSknD/T7YYLAUjofpNTPcw
         dit9gfLmGVt3v+6Kll5KU2GjqetzpP8UJ1gSL4Z77XAyHiaNVtMf+oC8YQ+BEuwe2F4d
         6rn+S7eecdc4hP9Dw6+TSAMcUmhtj7Yy1dFZHGvNq2NA90c2oELmlPmktexp34QzOzvN
         3bGEYrbOFNSUr/qvYDA4906L4KSwAyOz7Hf8aOVfaW/JSYvKa5+8vnx7/HP11ch3Hi/o
         i0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292014; x=1739896814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZtI7PetkZp3+eY+AkK3cc4om3sr4dFcTc7+7+vCFV8=;
        b=GQbQgwI4/8HjALi3Z9t56KtIB3MGVN6MgK7ehRiO+bLFOW8Vf/uhxQky6sXweJkL1h
         E3n3YUbn29PRHb4ZPsNEZCK2B7ueZbGr48v5MRiOj4bHzVzfRzwUzsu7QLyaONFT7MyV
         QXGP7ksG/oAcWAQVlZJcEQyWbO/4JLDIPIHZSMUBGCkSRrv7smrOucfjT2fMnmlZatiz
         8HXKyYF5IPrQfgxA8GJF5jKCJn2dIpOKz64JMWRIIZ5PQxOVnmljsh20Nn2Rmdo4ihDV
         TWRYuEhtPxkNpAmJEfQmkl6hpzki5jluqzPL3SG+ZKNgb4pyKBCdXmbhmJWbY0qMh8RX
         EAVw==
X-Forwarded-Encrypted: i=1; AJvYcCXm1G2L4zA67KHgU+dpRGcaCeNZIDMAiZY2mJmivozTBO+bxWpDJcMfmxmqk5GCPWp4otdST0WUJ/xjPjQxIPjz@vger.kernel.org, AJvYcCXs0guj2pJ1ZZEmP/FGGpA48KdM6kJreDNJP4NNVmslyhDu/IcBcoKj4ZF7+nZt1yVt39UDpwDmbONmfRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Fsh/woTWCme/EW8l48BMBBvKCnriyNQc14BQhaXzjMF3DDOM
	4npfyYu4CJSxlp3SMwjNdx5BZ3XSSyDR7jYFq70uQ4uJ5RTlUJ9pdG2Wi8R0N72ipKm4mOcgNGW
	5uUAJ5cl0Oh1shEtDgf5FMF5hf8A=
X-Gm-Gg: ASbGncufwamdCqZu+fceA5DMqIFJxTJZynG7Dm6IcadhP8JaWTo6iJBfoAqFn5jmpFE
	Q+M+nbwGp3/4XOnrOOSePPnYDEwvThyrhvVIXaKxi91KeIrWYQRGdJ8sz/EXVU3VZrdyIWC3a7S
	pUsLELawaqRe6Z
X-Google-Smtp-Source: AGHT+IH2y4vcUIomFZgJSvYLyL7GVzd7jygwhpA5T2bHuSWHKK+JhxyZ+eb0f884MI2buGhnMXS1/CbfcHpE7JdSrWs=
X-Received: by 2002:a05:651c:502:b0:308:e54d:6190 with SMTP id
 38308e7fff4ca-309036d78c5mr841101fa.26.1739292014313; Tue, 11 Feb 2025
 08:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
 <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>
 <202502101836.2B3E7BC4@keescook> <CAJ-ks9=pU6FsOfMk+fSwG2oLG95L2C-jwBDNad1FTGzQ5seiuw@mail.gmail.com>
 <CAJ-ks9nDH9Zk9vaiBP599LN-Jx3aN+JyxFXP16ikV0cayc01SQ@mail.gmail.com>
 <CAJ-ks9nK2oNz7s+QW5eF=W_SRZuuu5j4_DNQj9WM5iqH2ECZnw@mail.gmail.com> <202502110835.2FEA5CCFD@keescook>
In-Reply-To: <202502110835.2FEA5CCFD@keescook>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 11:39:37 -0500
X-Gm-Features: AWEUYZkTItEhvk62W4CEKQnZw-a4jGH1doWzPInK1LvJtAKSL-Nl251hmEb_Kmo
Message-ID: <CAJ-ks9=Dj9eYD0HJf4YnvWTwrWobYFsz8oNmNG6gDmCya=PVBw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 11, 2025 at 06:51:09AM -0500, Tamir Duberstein wrote:
> > Kees, it looks like the private header didn't make it to your tree.
> > This bit is missing:
>
> Whoops! Thanks. I've added it (and fixed the comment style).
>
> I really need to do my build/run testing from a fresh checkout instead
> of in the same work tree. :(
>
> --
> Kees Cook

Thanks! I think it's customary to have comments only in the sources -
I see you also included it in the header.

