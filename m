Return-Path: <linux-kselftest+bounces-9433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225718BB528
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA711C20CEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5673E479;
	Fri,  3 May 2024 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h0mK38A9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F60364AC
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770214; cv=none; b=D9d510zWuOtNN86xwBC+2gZRAV4+pbkIPVJ4GW4OG/M6NnZ0LCXL4N7sh4wm3XB7fqbFbGnhXGRZZEnaHzob4zWovz7knbF+DO+mC5+fAncP3dPC+IJZRTs+APvCxNWVIGyjiC5th7IQ4GP21dA9X14Pw0GTskNDkl2s8aWWfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770214; c=relaxed/simple;
	bh=Rd8OjNaRvWOeeFwsUuLYY+v1uRTD/QKNpcqqy3mvWT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdR89nFxwF21BhtaoS7uEkApuUAEXsKAgdt4MX/yJoL1QzcimhHsIDqWkTeYp5jZsQKQNPeGYv8vlAvdAlp2pdnMtOWOrHqw6DbRspyA7b4Gp4h9s7aPTaSvQpHtDOzUjD+v9ia0i9pyHXlbbncf9zSSj0QWMlQx6szMpzTEzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h0mK38A9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51fd87ce075so83110e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714770211; x=1715375011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rd8OjNaRvWOeeFwsUuLYY+v1uRTD/QKNpcqqy3mvWT0=;
        b=h0mK38A9o9/MlQ5JvaWm+GxoJwsnbzITaYa3AcOlAmObqW65pD2U1bdwNy6DhRyj1n
         xOj4p2HgjjLffWrDtH5MbeIU8h/TYE/McZTCb2A5WfCaVxfB8RSeih3O5t9ef0tIsvnv
         yao6vdxTj3J7Z+c+WNWGE076yoS+kjvhVXZ5FUaCea1iPXkCEz9C1oRHFQL9wW5QVvqr
         hCzYB9r8hAVZnjH/SmKo1G1qdIw3g8Ln9sZMCsWxy3PE376tu5mDHBsf0OxYdCHfu58M
         +DjoTXG3uLpdB6AqK4dUfBmLNEuT1ks15NzVJPmLYQGXZ/bsQzttd5XJZbZA/WAyrsqU
         zvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770211; x=1715375011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd8OjNaRvWOeeFwsUuLYY+v1uRTD/QKNpcqqy3mvWT0=;
        b=oG8rUhTZ1sXfAKUyqF1JqbfcZPelWtPfcoOuKHVwb1p8LbZbk74gBxCVZrQHvDuaVS
         8DoEy8skxAGQTL2DNmDT+NGog4HWDA2ZgKrvAH+n7ZLS7PqqF1eglSQv4HcMCiAdEhus
         /6jV3aifUBu0ettZrQu5nKi82sXiei7g6KOcWT1sztyEY1jOEmzuNRMdzOA/+lVURVhj
         /mvwDcJN0j45bEfXOtsIMhvKUXlb5DqDvlhUxZkCndxrRFkcYbYIQQt28C/KAwfJkN8B
         Js/JHvQam88tYs71PBx1oCFkjRXU/Ik67cKcaglsxmr03U48XP3fimweAm6XMrGt0dnl
         HLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaiPV3bqjldQpwosRPptmpgFZe0TsGVzdaMHb68ELyhW2FEG81qhEaeEwJ5HatO+9v7oQTwk1Lk2NG6E4KtvTPkXMwCvCnlQIVE+fEhHsf
X-Gm-Message-State: AOJu0Yw+1SeGOahMwWO4YbB2NupU3mhKqoURqss78EXLdnjQ+YYe6EFj
	HwL9pp1kejR62B0XZRP3AyduUe4o+b9eRK7DZbdwudmW4w1RPBgX/AiUDQa6GOQ+GFHCEjdlxxx
	RSy996GHbij0k42ew/bM8hTbDxOe3iWg17RSoeg==
X-Google-Smtp-Source: AGHT+IEwpEu81rH/FVNGePHBQCeqISBNzWjs4+w0Krz4xOnwCzY8XdmmXYuma+LSuWoMAtSFSqV0h7lUFLzfoGC8UUs=
X-Received: by 2002:a19:2d5c:0:b0:51f:5760:dd34 with SMTP id
 t28-20020a192d5c000000b0051f5760dd34mr2358407lft.55.1714770211432; Fri, 03
 May 2024 14:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-5-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-5-cb7624e65d82@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 3 May 2024 14:02:54 -0700
Message-ID: <CALs-HsuS_DWoUjwF0ozLH2drWJ7VzfdA-14XocsHNXt9CTT7Wg@mail.gmail.com>
Subject: Re: [PATCH v6 05/17] riscv: Extend cpufeature.c to detect vendor extensions
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:18=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Separate vendor extensions out into one struct per vendor
> instead of adding vendor extensions onto riscv_isa_ext.
>
> Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> code.
>
> The xtheadvector vendor extension is added using these changes.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

