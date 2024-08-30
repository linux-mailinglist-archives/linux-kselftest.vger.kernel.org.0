Return-Path: <linux-kselftest+bounces-16824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD107966653
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF0F1C24401
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B31B7901;
	Fri, 30 Aug 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mbbSvikq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265731A4ABC;
	Fri, 30 Aug 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033515; cv=none; b=ZwDK6WKpv2E557b/fu2oVS2gFy+PgyASbcDU2EFDGkIpIEPFoaBJmOEBFO//l0ZQnVTIhQUBHrddJ8Dsg5mlx7rn5OPN7RnDr+KEHeRQzHf44PLUFEGaNaAl7p5j53lWAtkcS/MgWICtTY7JMcN2dVtKSW2C45CLZGOnfGDmeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033515; c=relaxed/simple;
	bh=IgJNWd6Ws4XvhF4rLOHFUckxw3fRjWEoc/Cc8A2fYTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGYLKtQeZMMQNwpp/5q+DGC1E0b/dMGwfBLFR98e4h/AgeBJXLJYZCNkSOmFQUghVG5iZTMC/fdgzROyQQi8dq03UpUl/4hIEDCZzVb9hbxfYohtJMV7hbRevgqJPuo6ZZ/UkF8eiC3eQefj3KphSYLkzbHkoJSfvC+KeKy+Kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mbbSvikq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DEFC4CEC5;
	Fri, 30 Aug 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mbbSvikq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725033512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7gVH6NK+evII4TCVyFkNSDtsvCqgIr20IJ23JOLdrs=;
	b=mbbSvikq0cJmQS6/N+cW9D0t8yCKywoUEoP0syHMNs2iq1DrUwZGW588Mz/IiS0F2xaEYM
	25iY3ueaTTMx5h67JtYhSP2SsSXcrdHaFHQly1ijgR2jQfz1scWBN2syPKjxbogPjXxdY/
	zaUQwxmtd8jTlQRllXStWW1uXZ//Jks=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bcec5268 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 15:58:31 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27051f63018so1217308fac.3;
        Fri, 30 Aug 2024 08:58:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnQR6dTkeNX1ovgPhN2Whw3XzXbr4d+Qel64+qlyiH/Xgl6nN6PaW782xkNRth89b9lwDYnKrcNTtZDIxk5X2v@vger.kernel.org, AJvYcCV/Qp7pguD3OWu3TYtMyYW2MvKgHZ8PKL7Wam8whrEH7Zyho4u8JDiEY9YlucQigyPKVEPQYnpgz95Yhok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywte4MEruFdwAuFb+4SrYf2474WwB2ZZVyhorzmR7apO712PF5s
	J+fKzwzFZ6ay6X4NaESRRGOjF1HGohFzOQDHTE0roy/cjOLrik+Gp6amww27G9Tf4RsOtKiTHit
	CD3ynBBAMRxQD1k2L0J3YxWqFenM=
X-Google-Smtp-Source: AGHT+IGgRBcOgowLqG7ineKZ5FfASiW7SLDFdlk8al0cf28zDyQDVNrhiUbg0+OmGzOoe3vnujVcUdXdvj2WdXOdsSU=
X-Received: by 2002:a05:6870:3906:b0:250:70bb:1a97 with SMTP id
 586e51a60fabf-2779014a9a2mr7396135fac.24.1725033511053; Fri, 30 Aug 2024
 08:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>
 <ZtHlf1qaXTPwJQkJ@zx2c4.com> <caca9716-9429-47c2-ab9c-38eda4459c79@sirena.org.uk>
In-Reply-To: <caca9716-9429-47c2-ab9c-38eda4459c79@sirena.org.uk>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 30 Aug 2024 17:58:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9py_zPhh4v7GqM-BMM_ey=nJ+1=+kkrjjAi4PGzmgf=PA@mail.gmail.com>
Message-ID: <CAHmME9py_zPhh4v7GqM-BMM_ey=nJ+1=+kkrjjAi4PGzmgf=PA@mail.gmail.com>
Subject: Re: [PATCH] selftest/vDSO: Fix cross build for the random tests
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:42=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Aug 30, 2024 at 05:30:07PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Aug 30, 2024 at 03:06:35PM +0100, Mark Brown wrote:
>
> > > The x86_64 build is still broken for me because nothing installs
> > > tools/arch/x86_64/vdso/vgetrandom-chacha.S (I beleive it's supposed t=
o
> > > be copied from ./arch/x86/entry/vdso/vgetrandom-chacha.S but I don't =
see
> > > how?) but this at least fixes all the other architectures.
>
> > There should be a symlink installed for that. Are you using this tree?
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
>
> > That's where all these fixups are going for 6.12. (And yea, there are a
> > lot.)
>
> I was using -next, hopefully it's getting merged in there (I see the
> master branch is included).  This is also breaking in for example
> kernelci:
>
> https://storage.kernelci.org/next/master/next-20240830/x86_64/x86_64_defc=
onfig/gcc-12/logs/kselftest.log
>
> in the same way.

Ahh yea it looks like that is running into the same thing as your v1,
which the v2 I posted fixes via SRCARCH:

make[4]: *** No rule to make target
'/tmp/kci/linux/tools/testing/selftests/../../../tools/arch/x86_64/vdso/vge=
trandom-chacha.S',
needed by '/tmp/kci/linux/build/kselftest/vDSO/vdso_test_chacha'.
Stop.

Here it's looking for arch/x86_64/ instead of arch/x86/, because
$(ARCH) was used to interpolate the path instead of $(SRCARCH).

