Return-Path: <linux-kselftest+bounces-15110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120F94DC50
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 12:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F40E281D18
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867D156C4B;
	Sat, 10 Aug 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI1l3Kko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9914E2C0;
	Sat, 10 Aug 2024 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723286097; cv=none; b=dToWKoY4verSQJ5ZQlrbhf11OIPOwPuMEzlfYfBEih6wn7UBt70OF9v1xlmVFSPRFSKZvfcIKnb2YuYY9c1zCqeZEFkQjzU9H0F8rVMDeb0pNRIz2E60sA+pbu8yeLHF5PveJ9QpPHBcmbI0P4HUeBXZ7H4A7nftJPy9ZFqylJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723286097; c=relaxed/simple;
	bh=bZW3wVjp7+9zA4pIm9iIi9zx0S5TgK2QEyTc0Gze+bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+FOjdGZUGkrfCLRqGCZg9uLvfgzog8x3sRbgNEDmQgWzAHuJjwRox/vuwrVfkipU/2Q3fQKTaWfgSUl3k2vEO7mKAUieoJZlxtvmnuQSGXtU7KiTyZdQCoxWsVlf2GYVtKTszi4Kx5vUtRhbLvo//dWtIuGTsg9DWfT1X0gvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI1l3Kko; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so2838985a12.0;
        Sat, 10 Aug 2024 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723286096; x=1723890896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZW3wVjp7+9zA4pIm9iIi9zx0S5TgK2QEyTc0Gze+bg=;
        b=PI1l3KkooR6On9MhkQsTFEbhWCWEAktHf37/j/0k8OzoGtue60D4trCWZ7Usgn36BE
         AiqjbU+GjtUE+LHn5G4QsVrw2NaPzUikK8sNJjCFoyOBMGsd0Co0CPM/8Cvu3VeUV/jI
         rs+pvL0oQSE/XR0wG71Adh3bQ/Y4+7Rkz0E0axBIjYM5EcX24HwbVgcJVJIvTW5ibdqi
         t/XfMu4FsNh3Ojf5DlrPqV1q8VHLAwJfYS37y92lLXW4jFQAfJ46pGvZNINcVvqOdyT7
         bxlxQDgebuSf2d1HVAEoaHm9Dxx13pSg1tiwZXr+pxMwg4uYjMY/sDSppBUkzKr0z6dE
         eVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723286096; x=1723890896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZW3wVjp7+9zA4pIm9iIi9zx0S5TgK2QEyTc0Gze+bg=;
        b=QsRzLY3EnAn9QuzrpvZOQpOdNb1pNYHazzrlm3hMCY8l/XVQH8OxDXF7oJ95CoMdru
         3GR7+9Nxzzh1WQkYOL4s+1EoDazcKk39fdu8ZosO3nMHE/4g1+ZprkO+3k4GYRD4lDmQ
         Ah7Eonp5fEv9LZjmGhjO3Shgk5Cc9kH8G2mZy0jmQ1IK8YhTRJ8vftqv3426/xa/hEqc
         y9gcviePM1sfYzY1smdGgSu2ZsWZJTn1kWg/uDb4MCqBOrYHG3cfclxyhU1xumuTHywb
         aWNJzhiTI9ZI/dggWLU6dbVGcGDQCMd9QBXk7T33EKKMsr8fXcd9SaOyUrILFR4NgM1d
         3Uog==
X-Forwarded-Encrypted: i=1; AJvYcCWlL/0569EAwo3A2YUtalSiJ/s7tj4lyUXGQm0rTwZGLKFSG2hjOyVYjlczvNK4iIlKt0ggklY4+mRQBAfVvsy5gvT4CgB+DQrqS7FJJuPkBtsLp21/R4uMjrb3GCxJFJOCuIQWt88P8wVhTokJdYUSBC1zp/zPjquKFy1NQ3dd506/UZ+vHskDDhxzB7g=
X-Gm-Message-State: AOJu0Yw4WFJZGgL+HgfYVftweaHdPESeNvApm8XlF33XHxE/4rhC5rBN
	DJW3HGysyVNk+FNA7eYIiBcWYSIRnl5IRkI/jdNsa+2mOL2qgPHUPVMLe+Qz+0/9RdhUu9Inoqu
	/M9MVzeKBIAwvVXAk6YsNlu54/r7n5x8UXRk=
X-Google-Smtp-Source: AGHT+IG2EhrfCQGZpybZk9Zk/Risy0Rk6+C7uAFv1cW8iDmmShSmLA5zvW3rWSvXfscTYf4ZvlCpOXAdQRHTafHPw5U=
X-Received: by 2002:a17:90b:1e49:b0:2c8:2cd1:881b with SMTP id
 98e67ed59e1d1-2d1c4c468demr11570308a91.20.1723286095818; Sat, 10 Aug 2024
 03:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802124536.2905797-1-anders.roxell@linaro.org> <20240802124536.2905797-2-anders.roxell@linaro.org>
In-Reply-To: <20240802124536.2905797-2-anders.roxell@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Aug 2024 12:34:43 +0200
Message-ID: <CANiq72kb9mDd0xndGFnMQXP4Hg-GE91eQ07yYiQW1HwWv75Qtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: rust: config: disable GCC_PLUGINS
To: Anders Roxell <anders.roxell@linaro.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	shuah@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:45=E2=80=AFPM Anders Roxell <anders.roxell@linaro.=
org> wrote:
>
> CONFIG_RUST depends on !CONFIG_GCC_PLUGINS. Disable CONFIG_GCC_PLUGINS
> in rust/config file to make sure it doesn't get enabled.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

When https://lore.kernel.org/rust-for-linux/20240731125615.3368813-1-neal@g=
ompa.dev/
goes in, this could also be relaxed.

Thanks!

Cheers,
Miguel

