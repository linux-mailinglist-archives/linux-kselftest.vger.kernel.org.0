Return-Path: <linux-kselftest+bounces-39381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4DDB2E133
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35893A25C3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7E322535;
	Wed, 20 Aug 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAbY8fe8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680252D7813
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702944; cv=none; b=QwGdLtpVRlYMg4JPjR3MQJzTl+vszP6Wd8xTGIGw7olY5V04257FVLZbbUwDV/bHOGKPoTbB9BGdnPFcAtpd0AHf0tJK2vCDqds5sBJvN1GSyKmOZ1uL4sENr7NH10g52n64nb2A2OInN6KYpOdDX4uGiBus6kV1XImzbrMg6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702944; c=relaxed/simple;
	bh=13FUGJW12CjFo+iuPJUPd57hxgV9qCf1JSMfv2fgBBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ss2/ehSWi2p1k4OqeWKjR24UQWPS65Hz07YiKnUjyQVUsWNKM/fIiHncazbbPrtav2kP8KRLd+9dDPXMC42ncIQr8S0MkeC8muOqWlqDMofhwCxXGTmMgeI71Uvd3XpespNPgde8zSxLTsEvVPLxNz+7loY3ZdLhwNdMM7Ac/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAbY8fe8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso27452a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755702943; x=1756307743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLQGbBV6UkGThqaYqD2VruRxdB/oQfuxLhj4lvw4NUg=;
        b=BAbY8fe8vUD4tZmgf16I7et6IvdjCRoipuPdW3FpoU56l4Hdnwk9h8iWdFZ4x3Iy1Y
         9va9+WytawnsJ4WKlUxSAN2Cpu6R02tIX0FEqD5JzkHrjJiV6tMSFfQ0hMOkMi20Tg/E
         nz66T2cIUDXfaOpHECqUDWjGpRh56E/fATuP3T7n0oGcUH949nf4XYwS3kuglx2xcsIA
         9IyizZH8DuK3lPus5LQ/6/S9J6ZNR8lQLEBQuIFuxCy/OeIHNyikFnbCxdCJi8N3Hlyv
         2PtAwEdcpAgpwmqS6fBdr4rWrNLm+ZE1/efwO3Jx23wGjMxAX5EyGpOfRzF5yxi3FvT6
         ehng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702943; x=1756307743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLQGbBV6UkGThqaYqD2VruRxdB/oQfuxLhj4lvw4NUg=;
        b=KuSQTDqnfLpr2rVuK+T7AJ0kV53O7jecn3gol7OqYfnkNi9jlxz2Mk3RROw2BeH3bI
         GFJC0xvbshGxNO2JKOHNf4aQRv1NPtwFyIG258p+qA84Hk6TbF05E3aBPBs2Na9Mh0Km
         3j96ebHM/KKK9Bu5oXO7VZTT3aukfzyr7blCZ9Eckr2U6+2qTGQ1sGK8cQx6w9aYyTjE
         9VK3CAfYebJuGEzNdy3/jQXLWA9ITfRw8pnNFAi7pjLeIyObPg7wfHyOpNByL91+seZT
         4NkK4h51QjjhJE0E3doGI9ix4NlrK9O30kPnQ3fJgqo5kyVCae4oBOO0XamE+FnbXBIY
         E0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXAQ4LxiXXyptqNSS/85Jkwes1vfxwPLdDxED6h1LglpKI/DhEnjbCMiCa95pMH8tZmfxJ98LUaAO98Fbs4VD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+OGIjrsrlA8ngYulEbeblKtdkWaKG7x/8B4UlH/EHwXFfCTk
	PEgpc2JBvnO3HrBoX/YX6Xr4S/kY3KUbIKn+18VstZe67moq6ad7JtYMb1+q+Obesdc3Vy4emSN
	O0mAlrg==
X-Google-Smtp-Source: AGHT+IE9iGk/sRCwAsdU6VesQcmBbVaZpEaJBxTmZ5Qv6evdaW0ytYvrMeubSC1IlHptd/SUUkon+wRAZeA=
X-Received: from pjg11.prod.google.com ([2002:a17:90b:3f4b:b0:31f:f3:f8c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558c:b0:321:cfd5:3f95
 with SMTP id 98e67ed59e1d1-324e1425be1mr4887657a91.35.1755702942762; Wed, 20
 Aug 2025 08:15:42 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:15:41 -0700
In-Reply-To: <aKXFKaJuZZTbAbJD@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624231930.583689-1-seanjc@google.com> <18f2ea68-0f7c-465e-917e-e079335995c1@sirena.org.uk>
 <aKXFKaJuZZTbAbJD@google.com>
Message-ID: <aKXmnRTBzNklwdYk@google.com>
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 20, 2025, Sean Christopherson wrote:
> On Wed, Aug 20, 2025, Mark Brown wrote:
> > On Tue, Jun 24, 2025 at 04:19:30PM -0700, Sean Christopherson wrote:
> > > Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> > > of the same name defined by linux/overflow.h.  Note, overflow.h's version
> > > takes a type as the input, whereas the harness's version takes a variable!
> > 
> > This patch is in -next and is causing widespread breakage in the
> > selftests -next on at least arm and arm64 due to:
> > 
> > make --silent --keep-going --jobs=15 O=/build/stage/build-work INSTALL_PATH=/build/stage/build-work/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> > 
> > ...
> > 
> > In file included from test-pcmtest-driver.c:10:
> > ../kselftest_harness.h:59:10: fatal error: linux/overflow.h: No such file or directory
> >    59 | #include <linux/overflow.h>
> >       |          ^~~~~~~~~~~~~~~~~~
> > compilation terminated.
> 
> Argh, many selftests don't add tools/include to their include path.  The least
> awful thing I can think of is to go with a minimal fix to avoid the collision.
> AFAICT, nothing outside of kselftest_harness.h uses is_signed_type(), so this
> shouldn't cause a different flavor of breakage?

I force-pushed a straight rename.  Please holler if that somehow still breaks
builds.

[1/1] selftests: harness: Rename is_signed_type() to avoid collision with overflow.h
      https://github.com/kvm-x86/linux/commit/dce1b33ed743

