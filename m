Return-Path: <linux-kselftest+bounces-31342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A5A9745C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2F73A7F4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62D28FFC4;
	Tue, 22 Apr 2025 18:18:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA5A59;
	Tue, 22 Apr 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345931; cv=none; b=Wn0jRA2AuAomTXkH4fEzkuxvJKa+9dB4gV0zM+35pLqzHt+Q0TDWt4cMKkfVJfsGMA39yF2KpQG2qs3f0yvFqqM3y8fCUB9PjWSCx1xSumaE/+0Jph5NyfC8H360XBu+Po6QRYzftNAeVw5HmC7I+04r1AqHLPcNU8kswbgK9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345931; c=relaxed/simple;
	bh=TkG8zcBa7KfXe1GXRQCpN45740PFccsRwnCtPJ9YJlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYKA27/KSFEeXVXzSRYaluEEi1PVfyzerysdTRS5aytJPh9Pf/nWw2YRxn8sY8BeUJ2dpe4QJGQ9fsvdXaQ8mIps8pQ61OUivcTuqtoGbrbhUQhbtkAyoLaBFKWFXvQjO5uKLfa3itJROchDPSO3YL79xzo5WfS+LvZgAG23NiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-525b44b7720so2104441e0c.0;
        Tue, 22 Apr 2025 11:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345927; x=1745950727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9Uj7nSS8274bk83vAZdkd/UvrMtjHtOyVSltqRyvBo=;
        b=vssXj0Y0gotZyrOS1HKclgo2uGGqLHBBg2D9oFTEtysjMRqTQzdg5lcdeTqArAaZOl
         zpQm7LLNYSOToMA5tUtczCI/dPhTfx9pvt3pjO93z/boSpXez0HAoHKJmUipVBRNFoHE
         jbq/DylRluBtOFMm13N2pks8cFPhx/TlfcqAVQqfjMMKUekXcHzI3OWmY6UPVU2quBOj
         aCpI7Rrmhrtn2AKFjC96vpXhXVq0mlss0Shy++IErNZjjNbVgGDZM44HBnsLig/VLJhV
         kcEfQf61nmhupL6nkf1fM9mNj2vLFZ8rMY5SKtA5P79VOuVXwDek1jqoQxjA7J4hGsMc
         rsHA==
X-Forwarded-Encrypted: i=1; AJvYcCV+dY1rLE8ea4yer5nBr8ANL+StDAGvjSm7jubqKmzE6st3dMkQsSRI0Dm4/FXdCKOg52K36mP4Skf+MhwS0dOC@vger.kernel.org, AJvYcCXIX6MwzGg4mJHEcCosPgZdDsXu4PEbgGkCDAeQmMLcCtfqQj4Frn+t2RZhIjFar605OP+Akq9qPS/7OdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVwNTIPcRF8PxrdxcriV0UFrZp3uaTzX16JJKC1+a0SnjLlcz
	ZQ2LOtWkQmk6P/fHAOo0oydXQzU904MxY8ZHxkinviqeUGp2/901PAsQWHwM
X-Gm-Gg: ASbGncv70M+lvMnRxrDRVftgW4P8ZnGg6kFZ284oWgiQW8jWl57qfW/79VYgNuuQq7z
	2l5vGHezcXKCNeL9QnRKIH8kRhHvAfnb73qXMgvLr/gw/YeB+2GP/w6030anLV4PPITEKkADn/h
	pJkOJXn7wYUMB7fMoJweQt+u1AfXVgg+PhmIEEATR+Li+RsqxiLuvnHhZpU0//FF+Q+q2aTNju1
	3DO8EWKdLnU8IANPm7Z7Wa6ZhOOJpYs+jshpUteD1mCoab+Zya/dOKYz1eZGe4v8eKFQ5aCS0LC
	wkACU6Fm8GSjxsTs0MumuGH3ItRQYEkEWQC0mJNtg7CHcU1uDgwXCx/zZP1SefYfCNqTgHHnZao
	FpGk=
X-Google-Smtp-Source: AGHT+IHD5nyOEHlW7+Qg6RWb3fNazEajANp02OLIRp/F2N6JuPmLr/VTiEO4IGb/QPmEd72zU5zneA==
X-Received: by 2002:a05:6122:2a13:b0:520:60c2:3fd with SMTP id 71dfb90a1353d-529253df487mr14224907e0c.3.1745345927456;
        Tue, 22 Apr 2025 11:18:47 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922bebf8fsm2009586e0c.3.2025.04.22.11.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 11:18:47 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso2063428241.2;
        Tue, 22 Apr 2025 11:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMQEGNi3kRfNHEhMIZvFDdTFLS+QBkaPAdeJ88SGdrUEL69lpRKjCwcLE91Y28jm5qdnuPHezRenih9g4=@vger.kernel.org, AJvYcCXkRUZB96cLTR9um7KuOXFLQxUn9DDrS9XhtjYhUALkjcuAYTC7QAGdwpY5+HfapfTpxbuuf741U+sWmOAnklcw@vger.kernel.org
X-Received: by 2002:a05:6122:793:b0:526:19e6:fa34 with SMTP id
 71dfb90a1353d-529253b90d1mr12333603e0c.1.1745345927133; Tue, 22 Apr 2025
 11:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-lib-fix-prime-numbers-kunit-v1-1-4278c1d4a4ae@kernel.org>
In-Reply-To: <20250422-lib-fix-prime-numbers-kunit-v1-1-4278c1d4a4ae@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Apr 2025 20:18:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWj_bap0Lb3OXuLQBfLwTVVD0_-Jpm-VYf6fbFfK8MOUw@mail.gmail.com>
X-Gm-Features: ATxdqUFX3oavo1tFI9SarX7EhH7m_kTLzABVcQKLqBnzcLzgWkOGb3ggZLd8XAI
Message-ID: <CAMuHMdWj_bap0Lb3OXuLQBfLwTVVD0_-Jpm-VYf6fbFfK8MOUw@mail.gmail.com>
Subject: Re: [PATCH] lib: Ensure prime numbers tests are included in KUnit
 test runs
To: Mark Brown <broonie@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>, Kees Cook <kees@kernel.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

Thanks for your patch!

On Tue, 22 Apr 2025 at 17:43, Mark Brown <broonie@kernel.org> wrote:
> When the select of PRIME_MUMBERS was removed from it's KUnit test
> Kconfig nothing was added to the KUnit configs, meaning that when run
> via the KUnit runner the tests are neither built nor run.  Add
> PRIME_NUMBERS to all_tests.config so they are enabled when the KUnit
> runner builds the kernel.
>
> Fixes: 3f2925174f8b ("lib/prime_numbers: KUnit test should not select PRIME_NUMBERS")

Sorry, I wasn't aware there was yet another config file that needed
an update...

> Signed-off-by: Mark Brown <broonie@kernel.org>

> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config

Given this is the sole file that contains CONFIG_REGMAP_BUILD=y,
it must be the right one ;-)

> @@ -43,6 +43,8 @@ CONFIG_REGMAP_BUILD=y
>
>  CONFIG_AUDIT=y
>
> +CONFIG_PRIME_NUMBERS=y
> +
>  CONFIG_SECURITY=y
>  CONFIG_SECURITY_APPARMOR=y
>  CONFIG_SECURITY_LANDLOCK=y

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

