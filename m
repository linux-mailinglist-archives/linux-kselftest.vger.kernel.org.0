Return-Path: <linux-kselftest+bounces-29074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D582FA61E20
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB50C19C353A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129B18A6C5;
	Fri, 14 Mar 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjrVbzoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7F1DFED;
	Fri, 14 Mar 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987912; cv=none; b=XWSqDwzmGy0HILW+/ZLmnCpS9ixzDxv6uCk8kJzH0Ag3D+iDM9cUfTEYdrJd2pmOW2qEVFp+0lmaNEIGPY8r7THnxiBigOquqTj/udxUUwBynUfSs9w7mNRdOArrsSw7L5g5C3GT1/y7MkhCW6tNr+G6EWV/UI6NVqS3MNQxhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987912; c=relaxed/simple;
	bh=tdMHO0jj9RFU5MULcgSTnXLqIZQqh2jLw20/uhG/UvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1ZK9m9K8QNwRjTFT9D8acdPfKZUYlNksukknCk2OS3rhcuqNKYArxfWn+hkItMic/s1RXlbQgbWNCUiKCUqJMsRSDfv2KcvARqPrT0Bg7HAPu7j99Ac8h7vJxNEWnxFbLKiC672cspItCX84tJjVSKP1EdqkwuKaryGsSyQMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjrVbzoY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf1d48843so23271881fa.2;
        Fri, 14 Mar 2025 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741987909; x=1742592709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFXMMPpZWxz33l8FJhCnqL9k4pO7ympJw9WZ9XEWmCM=;
        b=fjrVbzoY69B3q+dkoJYjJejEm7NKsTAOJdl4IQ+bDy0/Jnsk/KRu59ms3tdQEbCxzA
         6Q4dx6nIc8bxO2gbE3QGxmfiw5FUZnZshbPN8uNRWKKMh6bV42dP1AIN1NfiDYFhk979
         ohnbI/3zc8CJDA9p9kQxz0p98r3uDdvpXNRul3JqtU61AD+iCj6L1HdIBEgSFhBMZME/
         7zBj3BwfwFCqXcEfH1Z2vxpGCTGtaRpotuCYZZaR+MSgem567Eqkz+WHgvF15cY3/5gd
         aoPSy+DQ5gi0wJnlUMxKpJfTq8KMBinLf39kK1VU/FwvREgXrWsRjPGmleLhkV9q3xD3
         Zqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741987909; x=1742592709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFXMMPpZWxz33l8FJhCnqL9k4pO7ympJw9WZ9XEWmCM=;
        b=gzv4V4e/bEahrNIkWNVEMnmA4NpIDvRZF+mWmh6NkKBv/PRe6AKHsmLNF6+w5AahPP
         M3YNU5SSiG4GjgEdeXz2mDnr2cl6ijW19uym/oDYzKNWfSAaRl1vMWqfNHwDnI0Vex9Q
         gYyUP1Z9yEqneVcwjZdDmF5QRrBsdmCWJk7YZQdfGl3gCxhjAMkqNMAF7/k7eYlXDJju
         jH/YwH4wnEvssm2LIL90/MW5mdjQ/23yXc8vanUh68CssPtgopuwrtZWU8glWr8iUvla
         xETHroZttkrXqIxC70Jt2GHqEPzMz8rRoC2Q9/T4oVboYYmwhF1FHQRYwR19bEwxNxCr
         2n+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2h/wZ95npG/misURhmTN3JHGFLV3EG0OcHzOUXNGXqJ2Y2yjINT9MqlqZycbUs1vONia5jjB/aLnynhg+3uk5@vger.kernel.org, AJvYcCX+HmzGTchWBBINOE3/6S033PhNIv/4MiGeBMtA/kKatmPQwj3sWdXP7+FM13RLyeTMkv9dj/xz/QMZUmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMI7H5919O04iIxzKeDRdKKeSeHGxB2QmEx/PpPYHe0rP4pRax
	TA+E+8UA1NIRLwHY0FujZJU1clffmYiCTjchG/5kF2A41+eF0FFPFs/iDQaO1trDOEL1ftV7Znr
	jmuoz0RNUagqaRUsO5UveUjRJmSE=
X-Gm-Gg: ASbGnctAYe9eeqf2tTCUo+TnSA6N3m7dJfyd5sHPDlPKOXVe74JNKJsuVASyodsBXbj
	MAbrHHEEuntXcN4CNbWulEjMAPyFcmbm9B9Ofu/YeaJTvOQMIo/eCt8cXFNMrfzamoXjRYLR//k
	T1+yR2jwM71Hw5L0wsqNq8+jYOuGaBTONg04L91AfyUnj+RGShiqaAm2gdaAhN
X-Google-Smtp-Source: AGHT+IEtWT4VddWn6SOUrtR/atH2QmgVmvC8h5A6OHeGOpq918BGiPw69dJEpIGNtjkeGi+d9+Kll0e+2xNj6VEs/zc=
X-Received: by 2002:a05:651c:2127:b0:30b:b184:a904 with SMTP id
 38308e7fff4ca-30c4a75e6eamr16856411fa.4.1741987908479; Fri, 14 Mar 2025
 14:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com> <174198596655.151146.11778711834752944011.b4-ty@kernel.org>
In-Reply-To: <174198596655.151146.11778711834752944011.b4-ty@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 17:31:12 -0400
X-Gm-Features: AQ5f1JrYArdxNFd2qwfXi-WujPoyGdtOJ9PdMwGeio2CLt0IFrT9Z8SBBffsYsw
Message-ID: <CAJ-ks9nJSoj-3HmG4LRTA=1LMERJ5O5aAPLcWy_ZYCQc_jp9qg@mail.gmail.com>
Subject: Re: (subset) [PATCH v9 0/6] scanf: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 5:00=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, 07 Mar 2025 06:27:33 -0500, Tamir Duberstein wrote:
> > This is one of just 3 remaining "Test Module" kselftests (the others
> > being bitmap and printf), the rest having been converted to KUnit. In
> > addition to the enclosed patch, please consider this an RFC on the
> > removal of the "Test Module" kselftest machinery.
> >
> > I tested this using:
> >
> > [...]
>
> (I had to rebase on the printf move, but I think it got it all.)
>
> Applied to for-next/move-kunit-tests, thanks!
>
> [1/6] scanf: implicate test line in failure messages
>       https://git.kernel.org/kees/c/5866730da723
> [2/6] scanf: remove redundant debug logs
>       https://git.kernel.org/kees/c/6340d61b9005
> [3/6] scanf: convert self-test to KUnit
>       https://git.kernel.org/kees/c/97c1f302f2bc
> [4/6] scanf: break kunit into test cases
>       https://git.kernel.org/kees/c/d62f8c95470c

Looks good to me. Thanks Kees!

