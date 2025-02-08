Return-Path: <linux-kselftest+bounces-26103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B39A2D687
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 15:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FF1188A565
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87E2475C3;
	Sat,  8 Feb 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS3z42sa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527221DDE9;
	Sat,  8 Feb 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739023686; cv=none; b=OxvMoPCfS0/pH699CnfI3HBPUpTCOIHpYbY7wtaPVYF7DEaIe5BkQTpDZPQiAuIiURDzQOqdXW7NhBPzj1VZI+4Nnqkud5cJ3ioiGKkaFIJIkkWHGpTi3n8YHzTa28N2ZixaA+7A6Xi+jhJGFLnLOM2wOMPrW2it0qIzgVuuRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739023686; c=relaxed/simple;
	bh=ukEa5XK/fbvZ+kOzOgajfYHBFDKhGTZ1zwJtm3mW+AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYf+tXhDa6mPJUMFDWkFSu5t99JNjOrZsb/oW5icKu+eQ73hbukmiEt7iTT/ttoDaGTcqcdp0kKxmvoV1qQJ+SI1MfizGqiXGdzSFj0zzmEIzsQiVA7A7x1dHb7rhSJCiK6PuCQl0NR7fiNC1PNYpkaoreM/Bhe0/rRVa6Lypxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS3z42sa; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30615661f98so31633881fa.2;
        Sat, 08 Feb 2025 06:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739023682; x=1739628482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvVvqYfa0K3hSBZJohhJTyzLukhxxEshJdnpWZxz49k=;
        b=dS3z42sayBvRU2b+lMAVIpZOviSjR8hE9Z0ibyZSwJZ/bKao93Zuj30T+JSsMB2pUX
         liE62ozPIo/FaHc4jb50qqUyeaiDAqAadEAoSLmInniJ6JLAmnB6xbhZIpkUIwEibYqh
         HIpxGVN07GqmBhTnOUYTbO4aVcmr2MKDO+S9aWcrgVF3xPXDSK/sjcozYyp79E2OC8CH
         yfaGcDA6NIi0gh931bCrrBHf+6s9tuvzriBixwW+43+DvVqMwWzkW33rnRh6+83StWoc
         RCUXnzaHoDq1DhP37msicjf7WcefVvmphvGf7nQrVq/7eTRUoq52vgR6xBEYE8X9U8LB
         91nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739023682; x=1739628482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvVvqYfa0K3hSBZJohhJTyzLukhxxEshJdnpWZxz49k=;
        b=UBWAqZWIpBg2iC20Z9hpI3DMfvPRkLaosGHTgyx/azq7Dl5ufJVWU1y2qMv9YCneuV
         fVMh7w4Ato9db6lxCcdEoG47XTUSsAsEtvi0LubJeLMHSEVJKPVAISC8hjdnfPTWU3Yx
         jmOKNuzssUUG4++DF1v6vfdW5NLLfpdhEd9tetdGePGRIzoOvMSfAsoMkRje2i/K8vB3
         bkZHmLNjs32gzVZBJMJOzmkubGi2XM50qXN+BJrd460EsC68/MLNukCEiiw0sIDLUqPJ
         9jDUuHb+k5iptsa0pwr04sdn4hjbwraOK2BsMu1wqw/ZH1dokMFdNSOgTKS3eRKRvLOL
         9rxA==
X-Forwarded-Encrypted: i=1; AJvYcCWHvFxtpF6X/O2O7vuCp1Ni6oT1624QrQ5/eIS68fRz0Le7UEHDSvjU+CeqD4Z5rbAcj2o3dY2mwqtMf5yjY/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbo1pzTVlZFbcflXzFDJQb02ajGSFUoTBliZhHJnZDwYKlf4M
	4go54Ns4mSPP8kwZbrjVSBUaeJHyG38Ss6KehqQIyeRUJUz/SF+6LMAoPzUTeqwk9mrHuto4uVf
	e3q8ed46YlNPcgBV+XIJ5CDwSoAM=
X-Gm-Gg: ASbGncsqugvzGE3bLuQeSs4mq2K8E+b+g1i0O/vpW61CiYj77LbanRvmmdGNK+AAlrU
	gc0QlBWMGbSUM3ab9vExLf9rVTtV1Al/cx8/0zFvUz9MMpYyeP4BeTfQBl/tWztulWdS6dMRiDM
	nc2oZx0jqCEB/TKbHCP+IKGaadsi4CKMA=
X-Google-Smtp-Source: AGHT+IFvOGIF4LfMhYYdGspRLaGgOv7gxDCTVh4wothvBFE6N+wt6sBv5sH2njrq2CoeoLMqMw5YyHYNAUbDZ0Ob6ak=
X-Received: by 2002:a2e:bc12:0:b0:300:1aa5:4938 with SMTP id
 38308e7fff4ca-307e57ff04bmr26395391fa.18.1739023682085; Sat, 08 Feb 2025
 06:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com> <20250208-prime_numbers-kunit-convert-v2-2-863119447e04@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v2-2-863119447e04@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Feb 2025 09:07:25 -0500
X-Gm-Features: AWEUYZmd7KySeiONhiS4__nLYzXpCIb40MrStvhI0h7vsHBq5LMwvwMt937TQ78
Message-ID: <CAJ-ks9k4enQzhq6akAMWZ0FeZ-Sfz2PbcG386-YYD1yxpjQgaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lib/prime_numbers: convert self-test to KUnit
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 8:58=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> [...]
>
> diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
> index 9a17ee9af93a..540d9b7b178f 100644
> --- a/lib/math/prime_numbers.c
> +++ b/lib/math/prime_numbers.c
> @@ -64,7 +58,13 @@ static const struct primes __rcu *primes =3D RCU_INITI=
ALIZER(&small_primes);
>
>  static unsigned long selftest_max;

Shoot, this snuck into v2. Please pretend this isn't here, I'll remove
it after your review in v3.

> [...]
>
>  module_param_named(selftest, selftest_max, ulong, 0400);
>
> [...]

Same here.

