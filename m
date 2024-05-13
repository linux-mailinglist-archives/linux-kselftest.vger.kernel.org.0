Return-Path: <linux-kselftest+bounces-10136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080BC8C3E47
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B285628191A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EA1487F3;
	Mon, 13 May 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INyNBbtK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF78219E7;
	Mon, 13 May 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593402; cv=none; b=kKpoerESjOJPP2aZAXXYxkDFVU6scAMYOEdOCmZBMWHBE6++7+jI5tfoA4ZKhXGk4oZgnqbgnMJ6I1h3hZ0BnUgiwjvDysUtFC08M9SQ5S0hjqkHmmB0ItHY3eUrWNosM92IJKp7J6wDDB0JC/PKfuCxVKevZc5obgMB4WRFMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593402; c=relaxed/simple;
	bh=izkCTqpLBQCSN8vjmeX4sZ24IBrC0VWu/QzOxgrxUeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e56KrySqYFZ8EvqJLUH8HhbmNu2+lr9JtCS74ERxr2WeN2kNeKkN5bMjtHz19pyCzF3gVLm6rMQuIEo1EodoZ3VUlIJvxob1vddY1N287LDm54HFloud8bGBM5d7KMdMUjP+DSGgCPojxJho2k8SY2OJYyS4Qh8JFs9ApZUdfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INyNBbtK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-622e32414ffso9356627b3.1;
        Mon, 13 May 2024 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715593399; x=1716198199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/gJ7W9jK8yRpC+gXkb+9v8zR17FUBWTE2nmLOEIu8o=;
        b=INyNBbtKG6nD5gZRtOpJtwmZQq1hwWz0cCCbxsHy8YP7jJkHBtD9bGcW6r7M075SEs
         JuGgplnfoQ3S1Uj133wF0vEqlfaVh3tcu801yUVOdZ7iu6mBXnnX6jJOhnLZ2CNlIehu
         w/rZngexW13BK3XMZsLbJzO/4Nqbmz7NNASXLcGGQZ117mNB6HmvHEFbduJi1Hzljqyz
         CUetNFp17pRPz70UaiHJ08FxcRHp4jUwAh2/Dv5yoUBLVqBV17CNQXXjfK0Ix3xFfnXU
         DQdZZqznIJorpCg5XuR4wQKeFJq3GlSN/Qy2lQKN5BJQfJNtRWn8TSMmp/5ahSy0LO7n
         Ao5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715593399; x=1716198199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/gJ7W9jK8yRpC+gXkb+9v8zR17FUBWTE2nmLOEIu8o=;
        b=wsLwSpaoNOTh9Uha5WW5qOdQPdrIk8E0fYEF10uEf1kYiPiZum2kvaewS+ZoGZXRiB
         0klOpPm4oLeB0pYo9hSDkWKUkgm64+jEGYgNn7EPH3rEn7uDMLM5KItPjlTKr13hqwt1
         x4/Hc6WFGmKRKBEjr/BHGAOyo2iMwjbWTzHb2YizY1VkabTx6ROjOtIIEZdxyYiRDQoc
         VA8/J+2rVDCEarV5hjXu4lj8cabTpIb+vrpRLkvCW+tun7BPUhlbGmLs+EQ3m+XN7W3y
         GEz34yPonrriQn8Igm74rul3bKQ640UWc2oIK1tML2L+IegGePVlhqHSlMVBNNPgIHtU
         9V9g==
X-Forwarded-Encrypted: i=1; AJvYcCUZD//lIYGZR9xpQWE28T+KBesyxhnRjM4BdKV9Cb2coy8ujNPHpay7ZkZxJlipPkxNsuOlfkHPXioAP2G7YWsASfEIAuXoN9HioNPbsYb8WbOFPJ4YFzqYGc3xlAajrDbKkcACZQ0W2ITxJ599LmxQcHFsjlqMks09V8ibq3BMC22InmQrCe9K
X-Gm-Message-State: AOJu0YycqpVpzeuo29eVcD1IUHlAZo5FiE8Etpof8Il6z+M5R5KDEx5v
	Sttvz3tf9lpLboZNzL8Sn857ncbj12g5nm96VRE53LUAbFpM5bH4JSoNi4ceXfpQr1lHvb/eLAT
	urNnd/wFODq7uBXYr1GD8nGRPPe0=
X-Google-Smtp-Source: AGHT+IFbjzOztndJSlKdpP3r9xNRThifVHYHVwA0PtsZ/VjMun5yi3vbEXBsk//OEAy4FEhPddw6zeI0a6E7nZjWDQs=
X-Received: by 2002:a25:26ca:0:b0:de5:4cd0:8da4 with SMTP id
 3f1490d57ef6-dee4f35b6f2mr11944212276.33.1715593399330; Mon, 13 May 2024
 02:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
 <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com> <65a79654-90e8-42b9-a840-e2ef404fe1f2@gmail.com>
 <D181GV24ULEA.UWQHOSM80TEV@kernel.org>
In-Reply-To: <D181GV24ULEA.UWQHOSM80TEV@kernel.org>
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Date: Mon, 13 May 2024 11:43:08 +0200
Message-ID: <CAJ3WTWRQcZN5JSNAhUKXfpH8Q5sW_-EorMpgCE24G3NpczpqZQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your explanation.

I did not realise that __USE_GNU is evil. :-/

FWIW, there is a sound explanation of the difference between
_GNU_SOURCE and __USE_GNU
here: https://stackoverflow.com/questions/7296963/gnu-source-and-use-gnu

Thanks,
Mirsad

On Mon, May 13, 2024 at 1:02=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Sat May 11, 2024 at 12:02 AM EEST, Mirsad Todorovac wrote:
> > On 5/10/24 22:52, John Hubbard wrote:
> > > On 5/10/24 1:37 PM, Mirsad Todorovac wrote:
> > > ...
> > >> The fix defines __USE_GNU before including <stdio.h> in case it isn'=
t already
> > >> defined. After this intervention the module compiles OK.
> > >
> > > Instead of interventions, I believe the standard way to do this is to=
 simply
> > > define _GNU_SOURCE before including the header file(s). For example, =
the
> > > following also fixes the compilation failure on Ubuntu:
> > >
> > > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selft=
ests/sgx/main.c
> > > index 9820b3809c69..bb6e795d06e2 100644
> > > --- a/tools/testing/selftests/sgx/main.c
> > > +++ b/tools/testing/selftests/sgx/main.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /*  Copyright(c) 2016-20 Intel Corporation. */
> > >
> > > +#define _GNU_SOURCE
> > >  #include <cpuid.h>
> > >  #include <elf.h>
> > >  #include <errno.h>
> > >
> > >
> > > However, that's not required, because Edward Liaw is already on v4 of
> > > a patchset[1] that fixes up the _GNU_SOURCE problem for all selftests=
.
> > >
> > > [1] https://lore.kernel.org/all/20240510000842.410729-2-edliaw@google=
.com/
> > >
> > > thanks,
> >
> > Hi,
> >
> > Yes, I actually like Ed's solution more, because it solves the asprintf=
() prototype
> > problem with TEST_HARNESS_MAIN macro for all of the tests.
> >
> > Sorry for the noise and the time wasted reviewing. 8-|
> >
> > Best regards,
> > Mirsad Todorovac
>
> Yeah, well, it does not cause any harm and I was not sure when the patch
> set is in mainline so thus gave the pointers. Anyway, never ever touch
> __USE_GNU and always look at the man page from man7.org next time and
> should cause less friction...
>
> BR, Jarkko

