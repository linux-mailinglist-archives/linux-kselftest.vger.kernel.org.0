Return-Path: <linux-kselftest+bounces-26322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB61A301B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181BF1889525
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BC1CEEB2;
	Tue, 11 Feb 2025 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch2/J/Vo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125126BDB3;
	Tue, 11 Feb 2025 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242374; cv=none; b=BAzk+yDj5Tj6dBvg4W401ulPoHjP6iujFvanz9dk/m5cFvWRvUiZJmE+hEeFLcRqaTsMuiQ6QQxibTyayhH2pPHIaJTywxhc83odT+y+kF1ke3Ex+zI+TFYBEpldcnPNGoxl4TtxuCpH8HXWUUZXzg5zzhga3Xc3ugxPSpEoj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242374; c=relaxed/simple;
	bh=zQw2a+CpxvAFUw4sXsEA97Fgbn2DgsUG3ckUtxNNYdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBj8NNNyANlZoryc18XRv+thmJc7Qp89TJxJaEeNVPfrKRuS9Oh1S5vLtne8AWTQIyadqOvsUM22I0/mk/fq3oyi59ygNO8NnzfZaRoCT8xs1io5m8YN+9mqtKExa7im5Oky0m8GV04Whdgvl3X6ZZQBYl2hyHlUB+wPUqlTkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch2/J/Vo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308f04beb24so12222711fa.2;
        Mon, 10 Feb 2025 18:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739242370; x=1739847170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7zoGSKaCzaFrCZcucDgRUUxiAaI1ZXSr2r+w8mi1+Y=;
        b=Ch2/J/VoXKAt9mbFAX8x2Oc9LcIQD4gIpm+tuDLHBTFeS7GZwOC0sjS9FyEU+sn1DE
         ttetgm3Mkuc9GacjGiagcUQxlVm0wcm8BOLgz0xS2EaxZLvGHeVftv+kVX6QqJaPASPc
         MKvjIpNZmwsf7X2dG0DPO8gRXYXnz/6PiFFIDOicAxl+4ikOxrIH6FH9DDliwxOo9cR8
         NmnR2KJXwVOC6XV442twojq7XiABe+lj+D2Oh08Fqv0pTLiNpTxyiVsbIfW1kuviLJ3t
         /S8V3jcv7MtgcJeI4bS61lljwUQ+1eTUKyeK8kMNJSj0SyC8vvcFdIVtfl4lBZPoH5DC
         63uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242370; x=1739847170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7zoGSKaCzaFrCZcucDgRUUxiAaI1ZXSr2r+w8mi1+Y=;
        b=d6PMFMliIZt9dYq54Og3mSuIIsRetK6BHZZza6Wt6LBKVyBDcyO234gmWWb8NodhYG
         I4UGSIdIkk4KLy3gr3h10a0rI3u0NVhPfqOXXxNiHC8J8A8hUFVP+MQ5//qDHkvphZXP
         NV/vTNFmbqIVbHW1bvWUzokrWZlyjbJOSKhEu62qg1zdlY3LRf3mU21d2el+IOxpYbfa
         Z++JcvDvUuXJI2nFfAb2mdV1ogyR/95yplZz89UZetEFS805osEamuEBVW9idkfE+iwM
         /xejM4AntcIJKGjEGQpP0b4Tj1AHRvLE+PHm8I6CYOPUlghoZ2E/Gp6s3Sr0MEpMWGoS
         E+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUieuDIsk9By/+hGSkDBNeuCL3KybxoV6G05v3eTQqdS4le2BYfN3Zj2KbKS2dJbBDPD2gAw7ZPbJbzGiY=@vger.kernel.org, AJvYcCUkTg0Ouu0/SMDbekrnagn30KmjHwjFVQOQP3zSbDDv5FxCoVXslDDKRZ9TRf3ypm9GnXSYjwwAeroq5ZwYbBKI@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfU4cslI/+mzudjbxhnKtnfMErxwy2ONtTEBmpGPQmjmXiKYm
	NZJdkqnfJBwgWP4E9NFnLFyhwoBeIfMiX2As/j5SLaJLDBJ5mDojR7W5tQI80hixUxPDukovRQT
	dNuuaVmEnkIIh4a4jJ/TZbh0Rywo=
X-Gm-Gg: ASbGncswa6+j/LRB7SNRBZlub2BiBcEQIicl8NahYVTwm+Cf1mlcW+gRN+z3FqhVknZ
	PQOMShxRHwrghgaAo1C7rUfs5FU8xE4d8DaaOtPG2nzTpSL4jJ4mf5vKK+MK+o4HnEZJmX8d4l+
	iDEDa76hhWY3Gh3GLrZsfod1daTSRq
X-Google-Smtp-Source: AGHT+IHZF8Pt1ouhTRhWC5nSvn5LiA7JiRKpNhRHquI/TMMTbGiFuAXQE9EO3401ZKj4Dc2d1xl9wZk8fB7hYd0o4rY=
X-Received: by 2002:a05:651c:b29:b0:308:f479:5686 with SMTP id
 38308e7fff4ca-308f479594bmr12679821fa.0.1739242370155; Mon, 10 Feb 2025
 18:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
 <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>
 <202502101836.2B3E7BC4@keescook> <CAJ-ks9=pU6FsOfMk+fSwG2oLG95L2C-jwBDNad1FTGzQ5seiuw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=pU6FsOfMk+fSwG2oLG95L2C-jwBDNad1FTGzQ5seiuw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 21:52:14 -0500
X-Gm-Features: AWEUYZnq2E-MPFeEevhTJkReUu_OvCFyN77M215DtLw-KJEuWzZCIAW1L8rsJaQ
Message-ID: <CAJ-ks9nDH9Zk9vaiBP599LN-Jx3aN+JyxFXP16ikV0cayc01SQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, I see https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/co=
mmit/?h=3Dfor-next/move-kunit-tests&id=3D3e50ba8fc834cadead733e4feeb969fce2=
f3b6e1
now.

On Mon, Feb 10, 2025 at 9:47=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Feb 10, 2025 at 9:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > On Sat, Feb 08, 2025 at 09:44:39PM -0500, Tamir Duberstein wrote:
> > > Extract a private header and convert the prime_numbers self-test to a
> > > KUnit test. I considered parameterizing the test using
> > > `KUNIT_CASE_PARAM` but didn't see how it was possible since the test
> > > logic is entangled with the test parameter generation logic.
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  lib/Kconfig.debug                            | 14 +++++
> > >  lib/math/prime_numbers.c                     | 87 +++++-------------=
----------
> > >  lib/math/prime_numbers_private.h             | 17 ++++++
> > >  lib/math/tests/Makefile                      |  1 +
> > >  lib/math/tests/prime_numbers_kunit.c         | 59 ++++++++++++++++++=
+
> > >  tools/testing/selftests/lib/config           |  1 -
> > >  tools/testing/selftests/lib/prime_numbers.sh |  4 --
> > >  7 files changed, 106 insertions(+), 77 deletions(-)
> >
> > Thanks! I've applied this and rebased it onto:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=
=3Dfor-next/move-kunit-tests
> >
> > --
> > Kees Cook
>
> Thanks! Could you also take the first patch in the series[0]? The new
> test won't build without it because lib/math/tests/Makefile is dead
> code.
>
> [0] https://lore.kernel.org/all/20250208-prime_numbers-kunit-convert-v5-1=
-b0cb82ae7c7d@gmail.com/
>
> Cheers.
> Tamir

