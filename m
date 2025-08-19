Return-Path: <linux-kselftest+bounces-39309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F8B2C680
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D131BC0494
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCD1FBEB1;
	Tue, 19 Aug 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh2dMWgb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55EC1F9F70;
	Tue, 19 Aug 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612061; cv=none; b=DIy2BVH6cIFjtWgHD9gLXjXWS6b5x+PV1NK+ZBRTqcwc5d/euw3dUwhyto0gVREIh0yFPLpgxugmbLUpHuc5aVkWeQRYnsDHlardyrn5PSx9NWPvOeMKeO/uTNaRB9aqDQx/ZnDxIJwMUPyGsZP9mEdTtHLzwSeBeX+8LxaWth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612061; c=relaxed/simple;
	bh=ha4t6RRIk6XpkYKIpDFUbToR4GM8kq4XAbtG+yoAZGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1ydCru2uPQLgRynnuVcYcNhFVavP6tmLT+tMuqmfyiHIIqHTYUg2k5tXqEmK4NiE9lmHpoGKaRx2f1M1td3bXcNiiGWUKqDIrEDp2lJXuEXW2OmB+d9v6MLAlyMnSBoPCHP4vQII8FcxLUGDl/uqu7Gm9MfgqHvmtmZhjrso24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh2dMWgb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806ca1aso8743895ad.1;
        Tue, 19 Aug 2025 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755612059; x=1756216859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50WBtMPwvOw9oYEsHnoDkF8zoLwvDN0HfFQfOPg/bdE=;
        b=nh2dMWgbCDu5AGJ5xW/9cG4QrklpAoGC1S3SdMLEwfs9g7Nox+KouDbsffmfLailTw
         LQ+yx7DmexZnBFGbao+S40IUIj3FE09PBldBcmPee7MBphBd9Bvb9Std0rOI2HJL8MYU
         cTMMf+YZdtiKYqkV/6qD38lzxlJZi6E6amOScO7/kuKvwonvZ2iVEfoQFqAVprkJJBVC
         4fbKn1ywqED/837t/g3OXpWJEQtAW9T5bt/VFDVVKvLMfo37gGWygs/zd9zIxeg0puvi
         w6VcEDtRy9zyQq/ewz6H+38TPqIv3LHJHDw3SQiae4RjHqF5a6bu2U9u/k51iDTInWce
         vwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612059; x=1756216859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50WBtMPwvOw9oYEsHnoDkF8zoLwvDN0HfFQfOPg/bdE=;
        b=CDPLTqTz+5ryZwP4rmR/RlV6QSOAV2qS1OZPsbfpCmHO2Qeyar1jTp0PB/Cko8LhWB
         woa1vN1ntSf8I9MiDVIy+qc4gam0lfhuoGmaWhJFLT3UQpzo9DMWF6nLF55aaZQyUJXr
         e8BmJZJN6jIc/wQk3DqlwrWyDH4eQO70u7tsqAtco0VqnL3cV0ufbhNsKtFrqxAY+82A
         AwJwFlDyamT0NrJb5cDUG/Db2PK2R+bBhdYCs+rQYPuamSbDOzwX3INlL4quhetMxvXF
         f7eSjrXcoH+qQBtVAKc3JJgichVN4UQgZKOZubUIEgQ/s2zHQ+tGZIMZl0qYMQHx2x6d
         nj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzq952JYccvwR6Q7b1p1YJdiStIYPuiw2WYAjwqGyYU07geVM0u/Lai3zOZA3sFey+dh7M9Cwl9Q3ivBYtBUE=@vger.kernel.org, AJvYcCVaobag3aOyiGVRig/1mP9o2LVV4pWPNcQK0oTHKBGRkuIZYTlxPj/Mnbx71W0+rRVwFiCT7z2U98eIQsJbI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLwRG2avELWhUqcA7rsNWEZyqZ3eZvXvDwe4qPJVeIMLvSI7G
	6BEPyOJOtOVacK8894j86+kfvEPZjQBLBlW9A0BdFYYabx/EfGJZ2SCcY3emeMyRC58sg3zhi96
	LapXKLB1X6daPPRl0+9LRQCsbVRFl4Ps=
X-Gm-Gg: ASbGncublnRTzT5d0thur2zLC7iytXaNAfkvTEkbUiGuY+dJS0WEUiCzP5lTLXw3ZM/
	vFjn6s+iiPjzmqCAhz9a/+iHeyW2lbdgFQzLyHiGtXo2p0GlHsycKODV5kCP3D2VuklcH9UfYVu
	pLOzyQO7cb+wQV9nRC3DiehZhI0d/HQDe0ChowZ8PR32b1tA1MX3CI7R8KkyTUfRHQKFuOkrsug
	MsFp+Fn
X-Google-Smtp-Source: AGHT+IFGLtNsuaHcZ9bLDDqN7J8ChtiAW1fZ0dZtuV570UBvC/PTJYsyK7ZfZ8g0ZH1WGMch8OcgtZ3J7WCfv1Mzp/4=
X-Received: by 2002:a17:902:f547:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-245e02ba0ecmr19746985ad.2.1755612057723; Tue, 19 Aug 2025
 07:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv+gELzgcL4y8rOQbTxv2Y2JQTFhNkgUcLbzPJ_yDTziA@mail.gmail.com>
In-Reply-To: <CA+G9fYv+gELzgcL4y8rOQbTxv2Y2JQTFhNkgUcLbzPJ_yDTziA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 Aug 2025 16:00:44 +0200
X-Gm-Features: Ac12FXxTFIhGwb8CqneZObiwy9IEE8bW5R6jDoBMnubJoMsWPuCWTeTncYkgRXU
Message-ID: <CANiq72k-Z9=EVVXgJp1OuKwSbQ3qq723B0F2PaPzRD4P+QEQ=A@mail.gmail.com>
Subject: Re: next-20250818: rust: `ARCH_KMALLOC_MINALIGN` is defined multiple times
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, rust-for-linux@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>, Miguel Ojeda <ojeda@kernel.org>, wedsonaf@gmail.com, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:40=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Build regressions were detected on multiple architectures (arm, arm64,
> riscv) with the Linux next-20250818 tag when building with Rust-enabled
> configurations (rust-gcc and rust-clang) from selftests/rust/config.
>
> Duplicate definition of ARCH_KMALLOC_MINALIGN in Rust bindings is
> causing build failures across affected toolchains.

Thanks a lot Naresh, this was reported already by Thorsten and me yesterday=
:

    https://lore.kernel.org/rust-for-linux/8aa05f08-ef6e-4dfe-9453-beaab7b3=
cb98@leemhuis.info/

A patch from Danilo is in flight to fix it:

    https://lore.kernel.org/rust-for-linux/20250818180923.192042-1-dakr@ker=
nel.org/

If you could test it, that would be great. I assume Danilo will apply
the patch on top of alloc-next, since the issue is just inside that
branch that goes into linux-next.

Thanks!

Cheers,
Miguel

