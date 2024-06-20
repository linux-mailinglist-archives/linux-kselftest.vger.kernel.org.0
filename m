Return-Path: <linux-kselftest+bounces-12365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58753911431
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 23:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2061C208DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E981AD0;
	Thu, 20 Jun 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2teeYkrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC080055
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918032; cv=none; b=bBQVR6bWP5iLri/8W+ueEOQramiCd68lEn1lH2RqcEm0+QHoJfIIOqmfsxuoIDcF3LPQuWxUzna2UEzEL3MB/2iL3Z2Kz4L21mwMQ5zViFhBJ3CxkfZUakjEVJMk1JRIoOJ+T2EGItzrcEAwvdLcl8hzuuOY1FglISUd3tvbQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918032; c=relaxed/simple;
	bh=/XhhmhhowDYXjOJixYSeA/pTMAKP6y9kWx5xd+g6HSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Igl16yZoEC8OFm2m+zXIT5hHvklZhBm43nI4MLpN8OBG0GI9VLi23+4dQ3MBkJBCHG23lPclQy3KKcx+ACIK6pOcX9b6yNSxhUC5sgvYRxtA+vShdaUJxytiQywSO1yAaP4W8879CuEa5Il0tlvgdgAW4J3v3jrDx6vhMeBJ41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2teeYkrw; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc25a7b9fso1379e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718918028; x=1719522828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J5efzHbrBSBEUK5Mw1SAdOtVm61ZWMUI1FF8AD69eY=;
        b=2teeYkrwq4d7hQgYPLM8sQgVwStRk2Wbxca3QqACfhyCeSet4np7WykAlsovLTxTgP
         gevqBPywOzZ9agMGpTlAGbn6elyE5FZ0Z4fVwnCbr4vTlk5QUYiGUyR1X20N5/3uBV1X
         HCIJzLVOXhaSboWSDvnCLaSr/B2U32TevWL2sPwp12KADsqdD013l6rDOd5GWC7ZJCyA
         lYcxUxxyopA7/CGd39IdHCJ9RkOhsLoKUVItTi9ROpp/x5/aE6QVVEnIe3/Gvvj1MeQZ
         d6bd+bWrR+CVVUIgH5OlXkMzWKWQN/Lu7Dy6DSAJftpxzfaeJ1URnU3NeDjWMl+uBr8q
         XCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918028; x=1719522828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J5efzHbrBSBEUK5Mw1SAdOtVm61ZWMUI1FF8AD69eY=;
        b=B3vn/UVaJTF5nkxyzIaWmHNt+8EscKYA8b8CRB0pG2ZRiYhn5KPWKXpSj5DQEW+545
         CeV0nEc+tmqtz+vyj4d3wHdN0EWfwKOtZX4M+3/4JwAi3vA4Z6jf6BMa+QDV420aw4r8
         5/tROHLJTWf38sHi8NHcSI47cwxaDFBdjOHuNUPZ9ocR2mHixpDbs9pu/bW06T6UEn8P
         HGi2+aHXtSfWNqEcLdWDXLUvizFHi+DOFyGPJclC+uQFRZXjdBSeqJKXW5Im5GyClmsZ
         2talruJZ6NBEzFhlrloHg5sQORcIcJXsysZGC5YL1YZ18XImoegevWJ3VUmeZQ55wdqm
         JT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5b8Rqm3xn2T7j0dX07fSN/sTvJHcwnpD2KgnAmnjg1DaNCw05wNxFEyTy32dnV8qWuagvP9o3+H3Amvf8glN3GdbMxTzlIzYLqmdmsDro
X-Gm-Message-State: AOJu0YwM9+2fSyXPmD3Q5VwNCnCmLJZVzCSVcqQ45jjOpHvS+EuC76es
	I/vTLCozNWleWQTFzoDduSxE0EyRKl295/wEE3SrxMzT99b8ua5f2f0vjwVfm1WREtnxWEg//a9
	1z+0HTB/2/1iZw0EoD1Jzw5F0ajQa3WE9JyJZ1PqOd5JdUC1vcA==
X-Google-Smtp-Source: AGHT+IEn8AqNmJKcntBraToyOLUgVbU+xEWQhtkU0QjCiHRU8X5rQAoXIzT/mO+rjYRWXps3yrWu2Ehhip3ibGm/BdE=
X-Received: by 2002:a05:6512:acc:b0:52c:cbdf:f9ed with SMTP id
 2adb3069b0e04-52cd46a7379mr147587e87.0.1718918027535; Thu, 20 Jun 2024
 14:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619202511.it.861-kees@kernel.org>
In-Reply-To: <20240619202511.it.861-kees@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Thu, 20 Jun 2024 17:13:35 -0400
Message-ID: <CA+GJov5ZpFxKxK44SAb_B8SzWUF9uQV13A8BcVPijo0CV0mStg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
> this test there.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@i=
ntel.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Hello!

This looks good to me. And seems to fix the problem. Thanks for the fix!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
> Resending as v2 with Shuah in To:
> ---
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  lib/kunit/user_alloc.c | 4 ++++
>  lib/usercopy_kunit.c   | 5 +++++
>  mm/util.c              | 2 ++
>  3 files changed, 11 insertions(+)
>
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 76d3d1345ed7..ae935df09a5e 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -30,6 +30,10 @@ static int kunit_attach_mm(void)
>         if (current->mm)
>                 return 0;
>
> +       /* arch_pick_mmap_layout() is only sane with MMU systems. */
> +       if (!IS_ENABLED(CONFIG_MMU))
> +               return -EINVAL;
> +
>         mm =3D mm_alloc();
>         if (!mm)
>                 return -ENOMEM;
> diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
> index 45f1e558c464..e819561a540d 100644
> --- a/lib/usercopy_kunit.c
> +++ b/lib/usercopy_kunit.c
> @@ -290,6 +290,11 @@ static int usercopy_test_init(struct kunit *test)
>         struct usercopy_test_priv *priv;
>         unsigned long user_addr;
>
> +       if (!IS_ENABLED(CONFIG_MMU)) {
> +               kunit_skip(test, "Userspace allocation testing not availa=
ble on non-MMU systems");
> +               return 0;
> +       }
> +
>         priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
>         test->priv =3D priv;
> diff --git a/mm/util.c b/mm/util.c
> index df37c47d9374..e70e8e439258 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -484,7 +484,9 @@ void arch_pick_mmap_layout(struct mm_struct *mm, stru=
ct rlimit *rlim_stack)
>         clear_bit(MMF_TOPDOWN, &mm->flags);
>  }
>  #endif
> +#ifdef CONFIG_MMU
>  EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
> +#endif
>
>  /**
>   * __account_locked_vm - account locked pages to an mm's locked_vm
> --
> 2.34.1
>

