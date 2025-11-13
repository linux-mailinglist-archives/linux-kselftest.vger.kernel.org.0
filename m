Return-Path: <linux-kselftest+bounces-45472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C2C54EC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 01:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16BB44E0484
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F51339A4;
	Thu, 13 Nov 2025 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVLW2eG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A035959
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994243; cv=none; b=sXGLBq4Q2zpn9/7rQ5y44LD5VN6DuZBkDvk88gUOe87U76Wt1GObnshJXHczI5jwinMm3ib+iY/reVt0bx7/6OcaQFGgM7SLAa9mFVp4j+FP0rMugCZtPG8pX8c+jZJO3+ybspCgAGNZ439cC2mwiS6FJMu2KRx7YgAn/uN2rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994243; c=relaxed/simple;
	bh=gQAFEkuis6MxG6DQ2tXr7tvJKT50Xpw9bu5kwP7LPfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddv6MA8TT8aXtNcZVWmVypsUelqVyGwSBhSdFXl/nNkP9NP/PDw5d7vLTGTg7rstgKNSXEKZ4yAbbwMN+r9vb67OykWSe3C2oJUG5AyDchEQLhBH6GCNW5GwQxRh58o/9QpEWFrZYSHmHx3BzBj2ai9snqQx0eudUT3qk5CulPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVLW2eG/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-594285c6509so210982e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 16:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762994240; x=1763599040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQAFEkuis6MxG6DQ2tXr7tvJKT50Xpw9bu5kwP7LPfM=;
        b=cVLW2eG/gPr1sJMBKzZEY21OMPLNeE6ftCtoZGHFrgcHGQMGOmRzQwNKGGJstI1jGa
         Gg6Hv5kPDIeXEeO8S4KLCDmgwMymhkrsr+tePT1TYm12oOLrpQUaMdy41Xv7IODsHaBw
         jjAhtP4CWpRn7sqY7/yBtNDygBBUn/od2EdUKJ54dbbYnV6oJSWwo/r2ZxUTe4umFmp1
         HuRpJvZNBLZKXi5egl/3aUzoLFntjduxNVHuLz5MAgQ7T4Zmiwz8Qe1syrNpqiYkWyJn
         t0y2vp2sgvULVGYQ/k5JNQWy6YWdm1qWIQOeI+2bdT+QL7pGtDdMfADQPU/asLIz0jjX
         72NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994240; x=1763599040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQAFEkuis6MxG6DQ2tXr7tvJKT50Xpw9bu5kwP7LPfM=;
        b=QqBdoWUNhdGDtwbzYE4T1UHyg9ccRLjrUILrpyT8GwjZDY4RhI2z/rJ3inG3SG6ZWe
         3wr4h4T15IceEZTQqbzfTMGCAX/27CIfkbH+RiVOoltX6L9zpiTiFB3WzNED6/9xRGQH
         KpAFwhJRT0wOfqUeXDSxX3lmFLvXMMEFTeHqfhZIu+hGaWNCUSd+w7qdZ5ndyk5bS7At
         AOT7458MFWa1P+fbaAN5sFeTmxj5ophZbE6kNf6kG+lECKSU3FHB7iHlT3TVZz4jyP+x
         DaC+udaOy9GK1tcP+vtcG84ouOslMR1Ro2wMTjMlJPXsNnbZdJA62vTiIUrllN4Gw7C/
         sDKw==
X-Forwarded-Encrypted: i=1; AJvYcCWeF7/pmeEyI8xbBFB+o+4WGUGEPxZMdYlsEOHYXnKa7YPRbeoMSJKiWPhlRzUZuFrJXPlMGnv6pp6M8cAzPYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzPiVNglHz5jtrlhUsH6tVjUdcBBiNZXyQQ53Q+WNPD+9zL1M
	qNxBswRBX8tXq4BOfTlW0LTgewKyRj0UqSaeycf3v+ZNPPkHgPJY7fYIMJmpdRxk01JqE0rg5bq
	Iw4AzFrnCNV0HWDBnLr6LBISb58eVoem1q/W991nY
X-Gm-Gg: ASbGncv4ig9ZcdI0wWql8U0coCxz9NyQGDSmTfpTLf++/0WX/YlKw/X8F49LWjdGOtC
	G56RuaEqXT/TXOyQjje/fDvAkNsQgDRnx264IKREtpn+FzHOAoP7fuEpBi5MPy+JBnIAc16gfQW
	3TX64r5hN+KiqO2QEEn/wnvDkLCMwiYSlfpq+26sCsKJub6V0ShB2UK5U7JhEIRlgasZgDag0iF
	t9A9OCQrfyXvlkDVHpfFf0QT51lz4S2viNsYooR6DrlUxmd8g4UXLu4dsmN6TVUMdBZA78=
X-Google-Smtp-Source: AGHT+IES/CJsPbrAgyWQnLon15KjjafWzvib+JwHwpBetgA1Zmgy6sN5eKJD/4qlHX/bLU4ksRV0aZSNvBB5EL/4rWs=
X-Received: by 2002:a05:6512:3d17:b0:595:7daf:9425 with SMTP id
 2adb3069b0e04-5957daf9557mr931008e87.28.1762994239481; Wed, 12 Nov 2025
 16:37:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com> <aRUFGHPe+EXao10B@devgpu015.cco6.facebook.com>
In-Reply-To: <aRUFGHPe+EXao10B@devgpu015.cco6.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 12 Nov 2025 16:36:51 -0800
X-Gm-Features: AWmQ_bk8b8m7l1BLL99RYzxjgrX9eX0t8GUscVQicIffm6eZO-IaDbPjTlCoDjg
Message-ID: <CALzav=fYCutTptee2+9ZDYChxDGFUaOytSwmf4qZhFTRSGRGNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:07=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
>
> On Wed, Nov 12, 2025 at 07:22:14PM +0000, David Matlack wrote:
> > This series adds support for tests that use multiple devices, and adds
> > one new test, vfio_pci_device_init_perf_test, which measures parallel
> > device initialization time to demonstrate the improvement from commit
> > e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").
>
> The new test runs and passes for me.
>
> Tested-by: Alex Mastro <amastro@fb.com>

Thanks for testing!

