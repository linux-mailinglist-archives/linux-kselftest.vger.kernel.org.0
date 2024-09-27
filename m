Return-Path: <linux-kselftest+bounces-18514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC9988B8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B881F23ECD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA41C2DC6;
	Fri, 27 Sep 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNvUxch6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3B381B1;
	Fri, 27 Sep 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470363; cv=none; b=WnIcLmsuDSqfzZK6w9E04chDfAj0P/tib60ugzKdg60GhD+nP2YfWeUhmyLT8V3gbdbakAGer2ERfn8qe0vkw/0cmhEE4wnYa0tYM/zo0GrWPApn52gPXBPTu6QDGGcF6RMO4qNpkxFPXWqCnH/wBytybZ4alb9KCzFfXniLNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470363; c=relaxed/simple;
	bh=5HQ7nexSna66xPv4Uft4SvJSqfBv9IvTVQKyrU297/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+PHfDxsUeq5j4ueQ38THPY44fbHmIVn0yYlq9wgZNfvv5S7ftGquEXeyc/h+Zeyv7Py57Q/sERG7FjW9P2u3EWTngF6eLoIJE4FQrNCxDU9UiuI2OOwfma+02pjSMCcpVn6XdxnEtcUJVO021XSyW4wy0R8t5FtbvYS68F/fLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNvUxch6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so1078963a91.0;
        Fri, 27 Sep 2024 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470360; x=1728075160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3TYipBZ3m1z5f8qjnQDPEJvDOrdajfpoFzHpH9lwD4=;
        b=HNvUxch6BsPg4OHbIxYtsyx+Gcqrg8OzvlwJTrgJLJ0tmOHM8cG5V0p3whmA1tHEZn
         aovsmTIb44/0TTSZvoV6DYRGljbgNO1HlGVRRWGl1suqdLO+O3i1uAFFJ/4W5YGq0VoR
         bWpU06Rfc9jat6QH+VuEm8NApEN1lr7nLw2yK2mGDszWIg5I3e8MPCA9C0hUeb9pB9lY
         BAPZ5rH4WuorpOv5zTQnKMnDNMNisGuPcdetJSVbPKIA4BHubbwQCOcGVbpKjfqNlc/Y
         dWyfw2/flkA/3u7X3Z0+fwvNTDZsrMsRTb//PL4a4AW5f4LDfV1j6hJ4J+CmCFoqXOlW
         1V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470360; x=1728075160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3TYipBZ3m1z5f8qjnQDPEJvDOrdajfpoFzHpH9lwD4=;
        b=K1xaY7DxeR2o4yRcj1zE9EnmY69185T0oElQP65g1Gg6KNr+AWNyq0eCHJ598nzX4q
         hlXcsC3zC2/BJbd6LNJUdgz8c+Yi/EtuV6i1uFnbrEAvQBkgHPktks8yx/xht6rH4SpA
         I5HPr8BCQ24dLHl+4xBgE2AaZuz+1sO1EQZJXtp3I/4j7K4XSSQ4TPp6PE832Whbdg55
         sejdMdl1LDAlpCem1D4JUBE7XRXP5zDjltI0PVyPTXb++KRS03/hDd6XIdOI6BDh/1YQ
         4Y40D33C2tSSMNw2yo92iKJ58OM2QJtCGCSYTcm4MTcG6ux4kz1Dv5qGnER2Cb0COP0K
         IakQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFUsDTAwyXNojwKkE4lCKsH6Ehe9lSnnMC0DDQJF1Y17srFNpVk6cQZN26iZVaJymRro8VWQqS@vger.kernel.org, AJvYcCVk3n89lwjdQ2AVOde6pg0qcVsKxvLlvFcFaPiqpD4Hpr4PdvTJ57ujQZRnFzPo0iGA41/qBMFn2wz2KXt6zfQw@vger.kernel.org, AJvYcCXEaYgiDenSgPsLGo+9UtSo08DBfCwknghfSBSzapaeJfOpjAmWoG6vI7rO1+fH+uFx4vvuDPYivb9GHKTf@vger.kernel.org, AJvYcCXZDLRhL0S8LwhQhJlRQXy6UJS3pVZ9zpFAAe0Ljl3aHb5VzTYa5Os95D2oX4eNS4YRkf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67Y8sri786ELITfipm+Z5jwocXj96mcwVbnl602jUKu7e9Mdj
	7gBRnXtl4YxtuDzLRF/DPWczSsCYZvhldf9kSt/sdmNrwc82qNT8FrfaPzYNU0ZC7/XCFJDkMuU
	DJqV4l8c1fjJoFY1pD+nvZ7NaRes=
X-Google-Smtp-Source: AGHT+IEFhFMPeqUPjTgmjT1tXk15Ei+RGYN6cAMgWrzG7SlH7HHLGBUE3WXEHcKrs4bM5vI2Sf3P/hNnxP6niY+vBKE=
X-Received: by 2002:a17:90b:3587:b0:2d8:94d6:3499 with SMTP id
 98e67ed59e1d1-2e0b8ed4c1fmr4973657a91.37.1727470360536; Fri, 27 Sep 2024
 13:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131355.350918-1-bjorn@kernel.org> <20240927131355.350918-2-bjorn@kernel.org>
In-Reply-To: <20240927131355.350918-2-bjorn@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 13:52:28 -0700
Message-ID: <CAEf4BzaWneXBv401rOdW8ijBTqRn_Ut4FFvhbsPShh5_pjV33A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: Add missing per-arch include path
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:14=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The prog_tests programs do not include the per-arch tools include
> path, e.g. tools/arch/riscv/include. Some architectures depend those
> files to build properly.
>
> Include tools/arch/$(SUBARCH)/include in the selftests bpf build.
>
> Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 365740f24d2e..d6a53afa449f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -10,6 +10,7 @@ TOOLSDIR :=3D $(abspath ../../..)
>  LIBDIR :=3D $(TOOLSDIR)/lib
>  BPFDIR :=3D $(LIBDIR)/bpf
>  TOOLSINCDIR :=3D $(TOOLSDIR)/include
> +TOOLSARCHINCDIR :=3D $(TOOLSDIR)/arch/$(SRCARCH)/include
>  BPFTOOLDIR :=3D $(TOOLSDIR)/bpf/bpftool
>  APIDIR :=3D $(TOOLSINCDIR)/uapi
>  ifneq ($(O),)
> @@ -44,7 +45,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                  =
                 \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> +         -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)

Eduard was going to switch selftests to use kernel UAPI headers, I
wonder if we should do just that and then set up arch-specific
includes from kernel (not from tools/) as well?

>  LDFLAGS +=3D $(SAN_LDFLAGS)
>  LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
>
> --
> 2.43.0
>

