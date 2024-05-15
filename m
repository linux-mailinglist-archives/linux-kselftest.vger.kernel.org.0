Return-Path: <linux-kselftest+bounces-10263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA78C6C31
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC9A2832A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2993A27E;
	Wed, 15 May 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWVyaIS0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFF3BBF6
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797991; cv=none; b=BEblGLKht+prREtGlUPJgm8wlWSXzr2iuVCzDJHBvVnLQTtAt/wCeXQ7U5cVjKcqUmBljO62kC4B6kW2EBdkoiyHtWFxPy/L8eTMwCytx18sFsh9dtV/FX81cTXbxvc+jnEnI3dFDszgkhsIoCM8a+ZnVY/8GAu0HQNm5r6z13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797991; c=relaxed/simple;
	bh=yw+ipdvPqTKvzHRePFMCEGB32d2gTHY4yIizWZv9K1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFP377RMy8OR9XQkAFiMI/JLMZKtE8Z/3QY0KlSOCVBveHiidJdyBZgXKt2t+Wms19/EbySHrEvZoSeDT9meHLYYo6/7VPhwydlVkVKb+O2L2o3DSnZs8K5goRBTjKsxA//ZxYDigVZIRUmSjMbvFMjEdtKoQ8sZsGcU9WVuMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWVyaIS0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso36275a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715797988; x=1716402788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKkDnLN7qusp5ZEvAbHRefNjI/EUrE6vZKOBSo4hBmc=;
        b=HWVyaIS0npQb1JpKRAJZztkST62euTKgxU7HH4B6I6s6UY/JYNOS2+GnzcMboRQuVg
         Fxe0U5VxQAL0Ls3kn4GeWlqSHkrhcbxxrWdlpCEa0vZMqL3b1dI2pIQ6g2n0sz3sgNPE
         JwcBZdn1f1bOMgbU+PaS3KTeYNOQD8os0uq/t+xk/OoCKm7pkDtBetoRpM46sq3dyR6q
         bNpCf1RiuFA/Ilr8CBHZ11X8ClH5V6GLBY1V8GlsgcOUfyj8ABab5tXExe6IH6X3M6/U
         twwvmxwnswpF3uucX+dFrHAMNi+3HPoHsJxTkuGT3E9juJneaEWM0SR4txt686dpHO2Z
         1hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715797988; x=1716402788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKkDnLN7qusp5ZEvAbHRefNjI/EUrE6vZKOBSo4hBmc=;
        b=ggqUJ0xhPbGW1Sx3DHZnjPOUr/h0R5x3X8TU2AOpioU+pDIp72HwPdAbR9xxoJuOSS
         WKZGPPjt6NFSp1155nTlNY7zoA6JY9RXRUaxvC74q6AYeh2FPH9JKBpjTFmJ1ivbn2CP
         KKoVLTf7ETXTF8jLMJeK2q6jTqR/gFPr0aCnfdjc8kwxVBvcC326OhTPeNbj2gRmHqyo
         Pj9yyr4fepzHbbcwgWmTMnOdn9F9ZdmE7PqI1Q/6YZmzlRZnOv38HIgN4fV3pZSUm04o
         gYth43tnP6TFb9QCVtu24aiUsBvdumU1jfNzcD1efqmTcOib7eCUjgtHrkHVVg1Euwxo
         qMLg==
X-Gm-Message-State: AOJu0Yy5wYZtG4lS3suBzHXJFejMoArrn0WmitVFu9cKMHoQEVDPD/Dc
	4goPIY4hYBjeW7qjZjGOlLlk/YxBSaR9PVrKvDlsL+1fkgWs1P5u4DwBvbtpM0C7wepMAmWoFlT
	+fjeDnig8VnX/LaCq57ibOjYNhyVSWdh5g93U5B617z2UyIlXwoYDwg==
X-Google-Smtp-Source: AGHT+IF6MleNTArg5bIvPJ3/eiTCxrRw7G9TB8KN62fOFsAAIP5+dlj2ACr18vI1mrmdbbKTxO7t/JgL68s+ize3a8I=
X-Received: by 2002:a50:85c6:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-574ae418342mr914673a12.1.1715797987465; Wed, 15 May 2024
 11:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515010805.605511-1-xandfury@gmail.com> <20240515010805.605511-4-xandfury@gmail.com>
In-Reply-To: <20240515010805.605511-4-xandfury@gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Wed, 15 May 2024 11:32:48 -0700
Message-ID: <CAGG=3QWyeWuLmJg1R7X8T4CsSgM+EiDToxjd_-8MD94D=DCLtw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] selftests/binderfs: Macro argument 'fd' may be
 better as '(fd)' to avoid precedence issues
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:08=E2=80=AFPM Abhinav Saxena <xandfury@gmail.com>=
 wrote:
>
> Change the macro argument 'fd' to '(fd)' to avoid potential precedence
> issues. Without parentheses, the macro expansion could lead to
> unexpected behavior when used with an expression having different
> precedence levels.
>
> Example Code:
>
>     #define CALC_SQR_BAD(x) (x*x)
>     #define CALC_SQR_GOOD(x) ((x)*(x))
>
> CALC_SQR_BAD(2+3) expands to 2+(3*3)+2, giving 11 as the incorrect
> answer. Enclosing with parathesis CALC_SQR_GOOD(2+3) sets the correct

s/parathesis/parentheses/

> order of precedence and expands to (2+3)*(2+3), giving 25 as the
> correct answer.
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  .../testing/selftests/filesystems/binderfs/binderfs_test.c  | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c=
 b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 4a149e3d4ba4..d5dba6c1e07f 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -30,11 +30,11 @@
>
>  #define close_prot_errno_disarm(fd)      \
>         do {                             \
> -               if (fd >=3D 0) {           \
> +               if ((fd) >=3D 0) {         \
>                         int _e_ =3D errno; \
> -                       close(fd);       \
> +                       close((fd));     \
>                         errno =3D _e_;     \
> -                       fd =3D -EBADF;     \
> +                       (fd) =3D -EBADF;   \

While I agree that it's generally good to add parentheses in macros,
this line ensures that 'fd' must be an lvalue and not an arithmetic
expression.

-bw

>                 }                        \
>         } while (false)
>
> --
> 2.34.1
>

