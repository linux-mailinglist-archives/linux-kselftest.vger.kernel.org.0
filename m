Return-Path: <linux-kselftest+bounces-26343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE28A30774
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B993A1E8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88451F1527;
	Tue, 11 Feb 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1LTG0oo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4EF1F0E5D;
	Tue, 11 Feb 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267108; cv=none; b=VGL9SdmYszSKaXWp0saLbSBX795ePUGe7IBKpjE1+a56P6lXyL53g5A+34yq94ftPEco0k1SGjpO+OnqE/BYjD7P/P+zn93nj4drn6oefOU2kfEj2JHAk2ViAvbS1/0x4nFJIuXayA3XRMKHmpp3hZx9hoJJRq/MYYA3aX+pNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267108; c=relaxed/simple;
	bh=TEIGhxaUGI1Ch0iRLAsquvf+IbizuWIMupKqf+DJGxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Il8c7cWjUaH99ighd0U462Vov/U7czcNTx8bSOp03tCalOCo/BpxpWaQ4ukg6OiUQ528YJftQD6vNZe3NtV1vjoB4DV0ut2GU4/T3rlgQ/R+mMjcCbs8g1k5WuLtzPtTo6UjgOCg2I9mtC7aS/wg4/tUWD4B7j47bJes5m9Hq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1LTG0oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA9C4CEDD;
	Tue, 11 Feb 2025 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739267108;
	bh=TEIGhxaUGI1Ch0iRLAsquvf+IbizuWIMupKqf+DJGxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C1LTG0ooUZOdimnGuXhiNYOefueMslV3i7o+W8QdDIhVNXF6UTDXakEZ8TNYX+q5x
	 lVyTC1SHxiU57uO+nzy4J9g7VzmmUAt6UN30rTvORrFy8cha999sm37lRre7loyPCu
	 S11Ve3JSAVPljFmZKqnlItf9Ryj+4I1TbPEUsWyDcO/hn3qag7vWze9IRozjuoSkel
	 G8RqNnGHNPhFDpUuMzoMKSRsnGc/FHvP08RJZFR9jVXlPwj3YZH28hkBncZ9eAfvI1
	 5MPJZMcOTJwcED5e0o6/BZQ703gzBUV3UXBdAIkHBdqy2iZKQfu0mrVfMYC/wkKsBk
	 EcqdsEep/cBUg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54504f5cfe9so2780198e87.0;
        Tue, 11 Feb 2025 01:45:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCMu2CPtjZg8PEBY7U9kt8j4hp/OhsL0y8cH8CDsrTAJ7PCDayB+xfyDo8sMvJJepr++igSPk3Of+/n9IlYOWI@vger.kernel.org, AJvYcCXZ8708aeJiiYoazMVKZ8qIHzBCQjWWK8nXabAn2ouQY4ze6MyWzGG9C4hXwhuRCT/+yy8xjCMERcreOII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYM7smwNjTvmveqzoIvTYNjj1Cj0FCBWxY3KGy+r6CbobLlbIR
	NG3CBYK47py1Tqz0Oz1nScLcj8D9QaYfz4ELA9Q9wHNRZb2L4lwIUc9yddjkSTS3GiKv0ZU0cFv
	6TVLWNw2C8qXJ8hl4cV5PbyqvpwE=
X-Google-Smtp-Source: AGHT+IF6XwIqkJ39zHWGHM0UWjL3iYehWiVzR3d1VUmFeuhbDWBXdIje0bEMCWuMHQr9arz59/vIQAFS2v1AebUG9PM=
X-Received: by 2002:a05:6512:b18:b0:545:f90:2771 with SMTP id
 2adb3069b0e04-54511c0f535mr821015e87.3.1739267106753; Tue, 11 Feb 2025
 01:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218115126.264342-1-mic@digikod.net>
In-Reply-To: <20241218115126.264342-1-mic@digikod.net>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 11 Feb 2025 18:44:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuekKKAtp7W+vzwEmaPW52YzPzqTfrJNKpXPV1kGhR8g@mail.gmail.com>
X-Gm-Features: AWEUYZlxs5ljAxmQ5fnQIyTDHuO4EjtuB_ANQXA3Mw46Hy-lJAVDttQsZXAYmK0
Message-ID: <CAK7LNATuekKKAtp7W+vzwEmaPW52YzPzqTfrJNKpXPV1kGhR8g@mail.gmail.com>
Subject: Re: [PATCH v1] kbuild: Allow building of samples with UML
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:51=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> It's useful to build samples/* with UML and the only blocker is the
> artificial incompatibility with CONFIG_HEADERS_INSTALL.
>
> Allow the headers_install target with ARCH=3Dum, which then allow buildin=
g
> samples (and tests using them) with UML too:
>
>   printf 'CONFIG_SAMPLES=3Dy\nCONFIG_HEADERS_INSTALL=3Dy\nCONFIG_SAMPLE_L=
ANDLOCK=3Dy\n' >.config
>   make ARCH=3Dum olddefconfig headers_install
>   make ARCH=3Dum samples/landlock/
>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Richard Weinberger <richard@nod.at>
> Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straigh=
tforward way")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  Makefile          | 1 -
>  lib/Kconfig.debug | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e5b8a8832c0c..6e2cce16a2a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1355,7 +1355,6 @@ hdr-inst :=3D -f $(srctree)/scripts/Makefile.header=
sinst obj
>
>  PHONY +=3D headers
>  headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archs=
cripts
> -       $(if $(filter um, $(SRCARCH)), $(error Headers not exportable for=
 UML))
>         $(Q)$(MAKE) $(hdr-inst)=3Dinclude/uapi
>         $(Q)$(MAKE) $(hdr-inst)=3Darch/$(SRCARCH)/include/uapi
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f3d723705879..fac1208f48e4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -473,7 +473,6 @@ config READABLE_ASM
>
>  config HEADERS_INSTALL
>         bool "Install uapi headers to usr/include"
> -       depends on !UML
>         help
>           This option will install uapi headers (headers exported to user=
-space)
>           into the usr/include directory for use during the kernel build.
> --
> 2.47.1
>

This patch was not even compile-tested.

Apply this patch.
Enable CONFIG_HEADERS_INSTALL and CONFIG_UAPI_HEADERS_TEST.
"make ARCH=3Dum" and see the errors.

The reason is obvious, UML is a kernel. No such userspace.

--=20
Best Regards
Masahiro Yamada

