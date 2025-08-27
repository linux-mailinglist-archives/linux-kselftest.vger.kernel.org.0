Return-Path: <linux-kselftest+bounces-40075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10905B38AC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD42520592A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B542ED871;
	Wed, 27 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahYfFRub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BE2BE642
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326082; cv=none; b=Z4dhNxsmKdRMtRNY8xemc6e3LB2dWOMfM6mFh9yN6yIHjCZ1QNxT/5VRY6XaqBt1xaSvMIcC/j8iF/uzWxLbm3dOJACSdWvAo6i/hHCZaxPIs2dxLnt3tDBrY9jHAaPM5euiIwWlAzlWI4U8Cr1NjsvJilp29czSsYqeIi8LSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326082; c=relaxed/simple;
	bh=EPmt5LrGZnOxH6usgZFhLYZ7ig5qKVo4Uh6i6+JeU1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7hP/IyYAHVl/QqxMEWzIu8vbbEOSrxpRBZM5BbW3VpSzhTmED/4YKagr2xJEaXXH8693+ebanndYNURQEwZAYG09TMuMrc3pzQ9ooSwCdsVaGBb6xG5GSPGDr4g4uvHlnp4hQLE6Ep3uc/32X8C7j5GRK0tR90KR7riOT5ywtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahYfFRub; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f53efe803so290665e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756326078; x=1756930878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLr7uUzFv07Aoh9teNhUx4O4/mbdgJvBiDhs721ddY0=;
        b=ahYfFRub5jMxkOedRO1m49DmNkvsJgHQs2BQH0eQ0+mJzarCLiISDzcLKouJ+xbZjf
         nz+BH0Zeg/wjjL79fN3uzvgcBdMULWSv4E1REVhTnNMZ98z+NwDkhdsy9JU9XMfvmTvm
         WyrPDOvFB3ZmNh1YSx5RdJ223WUJN5+NGRph8CtDJ48S4xs/PTGXV9bD3z6JBlInGRuq
         VEItd6sbvAI6lGi3XIuGFKUZ5DUhp+kmLPUZSJTMxpNLMNDuGqkXMiOHOGaInFDX/M52
         nT0eJSZa+zn2Jm8/qWE4WLdUFbD9JZR63PZ5hln591c6YXFs9KHeZlRk62J3fysmY4Iu
         tQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326078; x=1756930878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLr7uUzFv07Aoh9teNhUx4O4/mbdgJvBiDhs721ddY0=;
        b=i7WAyB2LOLq7VTjmyXUx0C2mlefOkSnbcYw8N9OF4Bctw8c21hbtRdKOdxXVO2TL4j
         ihIZutxCDZ9lZvqVhRcdvTCvXZOPoS0UJlL5EyDVsCzA0QqdSkDTe0RBljtFXCdjux62
         5ClzrNF9N7FLAoa0DAp/6NgL4WzDDmy+keOAAAF8zjLEn4qHFRwlBXpZCfzxM7JMm2Lq
         vA5+msr6Pglhxm/ku38Hsam1VE7sVfxC8a6cUjmpGS4PLIfeFhR3ajfaDnP1kNJN6dGx
         DU2hyaJUbAxHkfzjyrzMj5a6r814LQQP9773uX0xzhLNWc9JXsahf2qvjz/lwVcxzDED
         Vp3A==
X-Forwarded-Encrypted: i=1; AJvYcCWwyGXjwyGtfSPDGFbA0lg/MELgeduBFPX4NzvJpeU1RP0ya/y8vzf3MUPxabxKJl3m6KrYzxaU70lhspXPOv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTQyYxjP5a7U+UX76M937jCkqE3jPzxJ9Fg91VrCQXYrU3I7A
	3ZArrMCdD21QpTSJ7y4wkWOAy2TxEA33tmuFWvyUEqZ8Ez2rSnCH18yFxwyMzQGijmvRDYJPG+c
	00xUObyp7ZpDob9Wzw39blEvfobQZEssFADLQ8pXd
X-Gm-Gg: ASbGnctTSGcCzfN/rZtPI4tYZOMK/x7cJvqD4F/+xO/X56cDz+w7G12np8s/OWrO+f1
	Pis8PE/u8hpBNrmRhJXVIU+eDB0kijSe2mh4Ga2xwBp9lrUbVV8KqfxjJ0Um+CcXq3KgC1ajAIt
	LNxaWYLiubHi+Vo4pmva8gbW9up6OZ+u343tJboOQ6rvIp4ttYwmT9HO8cvMk4BFeuk9ajHPdLo
	I9TsYAIVexFcE/1E1pPtZ3OoYAWbvogWxi3yu1VlkBUwQ==
X-Google-Smtp-Source: AGHT+IEpLLEo7znRhSyceTi4G2eFhlSsLQP0khkgpMkFhV+jSIoxje5uuR+VGeAz6rgFSmW2w5iCfMHGaFhp+W3/+nc=
X-Received: by 2002:a05:6512:2903:b0:55f:4760:ffeb with SMTP id
 2adb3069b0e04-55f476103cfmr2602374e87.49.1756326078222; Wed, 27 Aug 2025
 13:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com> <20250827125533.2fdffc7c.alex.williamson@redhat.com>
In-Reply-To: <20250827125533.2fdffc7c.alex.williamson@redhat.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 27 Aug 2025 13:20:49 -0700
X-Gm-Features: Ac12FXwoFxl3r1pCxE6o1ZVyzkOLMaLqeDJmk1nh6QN75-8qyOTLsGbPKspi_qo
Message-ID: <CALzav=eJhApjaHOPb5JSgHRjJsOhxgQxxD=-NPLVYQAmk0UjMQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/30] vfio: Introduce selftests for VFIO
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	dmaengine@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:55=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Fri, 22 Aug 2025 21:24:47 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > This series introduces VFIO selftests, located in
> > tools/testing/selftests/vfio/.
> >
> > VFIO selftests aim to enable kernel developers to write and run tests
> > that take the form of userspace programs that interact with VFIO and
> > IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> > new features, regression tests for bugs, and performance tests for
> > optimizations.
> >
> > These tests are designed to interact with real PCI devices, i.e. they d=
o
> > not rely on mocking out or faking any behavior in the kernel. This
> > allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> > driver, interrupt remapping, IRQ handling, etc.
> >
> > For more background on the motivation and design of this series, please
> > see the RFC:
> >
> >   https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.=
com/
> >
> > This series can also be found on GitHub:
> >
> >   https://github.com/dmatlack/linux/tree/vfio/selftests/v2
>
> Applied to vfio next branch for v6.18.  I've got a system with
> compatible ioatdma hardware, so I'll start incorporating this into my
> regular testing and hopefully convert some unit tests as well.  Thanks,

That sounds great. Thanks for your help with getting this merged. And
big thanks to Jason as well.

