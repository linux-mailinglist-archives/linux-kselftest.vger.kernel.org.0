Return-Path: <linux-kselftest+bounces-9638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349168BEADB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6434B22245
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15A16D307;
	Tue,  7 May 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5pdE+Oj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765F16C855
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104440; cv=none; b=MAW7t8D+hgwm2gH0Thqoe89VHPFP/LdmWDVAvorZCU0SozveBy8IwngjyeQucqdYVzXxJE24QnuhpS+CL/okprq0qYV+kH1c+CHCevAy0etMm/Zm03nnchqz77Iju1W76TNK6zP2+qRXZFHxFqS5VoTWnnJhrndlNjWS+WB8je0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104440; c=relaxed/simple;
	bh=f4jkcb6eCGK9z9a2d3qPQI3YlfWTfGaPefAR0W1j3LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO6Rb0MN5gol7sv1dpeBt3IZSudS8QiBXfjHumviiCKD2w2/bYWNXP8MhV5ghCpcvmEs1wgDMpgNtdfYMOHPVGXXtcjtRPAml53b+zGobNhOMGd96HsEhFzvmsN2KuC8yxi/1mL2YOEO95VhgeXKrCt63HWWCqo37fg1g9OHgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5pdE+Oj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418820e6effso12625e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2024 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715104436; x=1715709236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZSBxoniVFCnSwsRyNGGB/5WVFKEVwOzPElRSvx/1EU=;
        b=R5pdE+Ojdt2Cf5snoCts3zjuPF+NBboucpKaRWvWgyataQj2lyuCl8muFmDUew1dIJ
         pDT0/AfQStpl9KL5fIHOuhGp/GFnj/lvtdIgkxXj0TeJyfYCJsmg5l0+Nx+iRcwvEK2K
         +T6bgg/8EupoWfWeKz4F5PGwEWZJF4OgUdYAptkWRbt9z2bCz7HQwYNdNLQW+vO7DY7R
         1Otjr7MtGzNjSh1KPtRe1WvnwHFWbbZhX/C+UnSGdcFMNNX1gox1bnmmu0UY9B8fWjhB
         gN01Ma6l8bRH9yRsacL7Pq/XGNZPAciiYzX4QcNJNRYeOr5H6ak9cuiYu73daIk4JlMb
         PXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715104436; x=1715709236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZSBxoniVFCnSwsRyNGGB/5WVFKEVwOzPElRSvx/1EU=;
        b=uHJMDjaFy8gCqkU5DXWF0sc2tbF4bfx6hGR1Wgn7FuircT6s4Pui37nLy6hDRgS5Mh
         vGojNgmtSCtjAXt0/14dl8QfPaUxVsGaVuChb1aHJJ4cDnvNFT0/KCyISwbxbw5IENwB
         WRxrTIul6RYiGtUjfqVBsdXaBXGNs7kwemenTEHD0vAN8s6iXIzyin+kHoUxfYOhrO/X
         Xy2VxzScL/5YwVMD/O0uMFrtclxMpMld3HmOBZEk8I+y/A7fpYjex4OxRsOc+aJLjVnY
         dgpFgzRLVSaSA5dcg7vlKw/yFm2SGf4Meb/GrI40J4+eJLXkyZCSFqegN1q8vxpK54P9
         bKUA==
X-Forwarded-Encrypted: i=1; AJvYcCWzDOe0DkQRnTqy/HymMLMs39iMsIdto3QYdUihdPy9f/9uTOcOd1iM7R7Dj5HLzvqdaQYD8H8lS4KksU5WT0aU/4ZFM2gfClmX8nIs2xd8
X-Gm-Message-State: AOJu0YzjmZ1l1RK+OrguNdTb4wES2m2z8+klSt2QVs4++AmFMfm90dol
	pEnmVqSDDmkb/pit7AB3xuuWN6CG4My3RUiA0SqZBB9zToxZnd6WW45ixX8PTwJvGOLkqt64Ax2
	imCG3zk3kseSJDyTSiulI3CpH23U1T+mkCOAQ
X-Google-Smtp-Source: AGHT+IGz1XnPd5AWeO8uJ/y11xaVSFsWnWF3iUnew2fdVCadE6k0qGy9DNTjKr8tWwxbE8CeHiLNiXoVqCbHcy7HxH0=
X-Received: by 2002:a7b:c046:0:b0:419:b16:9c14 with SMTP id
 5b1f17b1804b1-41f7a8634ffmr90295e9.1.1715104436438; Tue, 07 May 2024 10:53:56
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com> <ZjGiGq-_kUVht63m@finisterre.sirena.org.uk>
 <be921714-b684-401e-a89a-8256df5fcb86@collabora.com>
In-Reply-To: <be921714-b684-401e-a89a-8256df5fcb86@collabora.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 7 May 2024 10:53:28 -0700
Message-ID: <CAG4es9V1SYe-JA3xfkwqchZ37Oc3PY6O36hGcA26-JHZ2MmSCQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Define _GNU_SOURCE for sources using
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, shuah@kernel.org, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:41=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Thanks for the fixes.
>
> On 5/1/24 6:59 AM, Mark Brown wrote:
> > On Tue, Apr 30, 2024 at 11:50:09PM +0000, Edward Liaw wrote:
> >> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> >> asprintf into kselftest_harness.h, which is a GNU extension and needs
> >> _GNU_SOURCE to either be defined prior to including headers or with th=
e
> >> -D_GNU_SOURCE flag passed to the compiler.
> >
> > This seems like something that should be handled centrally rather than
> > having to go round and audit the users every time some update is made.
> The easiest way I could think of is to add -D_GNU_SOURCE to KHDR_HEADERS
> definition in tools/testing/selftests/Makefile. It wouldn't be obvious fr=
om
> KHDR_HEADERS name that there could be other flags in it as well though.

I'll try this approach and see.  It looks like there are also some
Makefiles that don't currently include KHDR_INCLUDES.

Also, this will cause _GNU_SOURCE redefined warnings wherever #define
_GNU_SOURCE is present.  Should I also delete them or wrap them with
#ifndef?

>
>
> --
> BR,
> Muhammad Usama Anjum

