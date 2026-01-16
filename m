Return-Path: <linux-kselftest+bounces-49162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BBD33335
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C863162B61
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991953385A2;
	Fri, 16 Jan 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmWbvFDF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE827146A
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577261; cv=none; b=CnwO+suSDk1d/dkK/h72fIuR2MuijJRzHNDWtf5FJf9i+PEIKoXot0VsgqHxfr9hWYrGVbikCWPPyIjQMgo7GPkUuFh/1T5h6j6EDIbXvUqr21eRbcbEc/mBkgk777UqYXWyWiDzpT/3OnIQwOQBdXriXbeZ89MDRm/FMz1tNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577261; c=relaxed/simple;
	bh=oy+oDQg69oRiKkw6u3e47Ejf8DbCCwkCscmr6o/Xmp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aopiNtXDg8ZxSyn0VybIh0Rol2EDNf+38tn2/o81718g5SSHJfi2v61hBwix3cxHrivHLlFypSwCiil+uv7l5V7Q/ZU+lQDE58g4/IdWRYtWELTCaZK4I+PdVp6J2wyUqKscv5WYI+sbgZFWGZCzPOmiyi44x76l6gpdyDBOIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmWbvFDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483CAC2BCAF
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768577261;
	bh=oy+oDQg69oRiKkw6u3e47Ejf8DbCCwkCscmr6o/Xmp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LmWbvFDFg5yW/RgaFNzhGXCBHIqLMNhGykiU/iYoYF4+7Egic2j45nEmpDSL0QPwL
	 Gr2+US4VOnYTrscPU/tvN+6T3x9Dwa3lFrnpLD5FmBqWuMfQz2ltrMq/KHvbiNu2rg
	 n6U0iPteIpnuR+wwvueWlkXVKkhpJ27jxgPlN2WqATUpXNZUxXo8WBoyQVg/7c5IAc
	 kSoV0Gne9gmuBdEDyvojC1n0pkYfkNupmFkLAZgO1wi5qXDVLK3zDBeELHM1geToEZ
	 TeocM6WFDdaPFn7G9z94w8aqdGpRhrweqmxcvGEQom/XKrtgVGT8hQcR2H2DFVHvep
	 SF5LM7wJF3utQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b79f700a1so2093406e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 07:27:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL9b/bwb4pSeqzkUPu5iq6LVW+T7vFsKP8JkTHPBDS30Adx4gESu9kX13Gy/aoHhPurt5RghehHlocQ/zDJZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPpY0Q31wgiV4X6ondCtwJWQ3tLgtYQVRUvih7oC98zQG69tw
	FsISxBd+MWoB2xWHZZaNgZDnOH8f45XmHG2TVLTgiQ1hk398H+IhaeP3BTWx+o2UiEgG3f+WVGl
	fd4FS6VcWE9TOZsCCpckdCP4ubwGjxYps2mFhYbCNAQ==
X-Received: by 2002:a05:6512:2244:b0:59b:67cf:ac0c with SMTP id
 2adb3069b0e04-59baf188751mr1188971e87.17.1768577259688; Fri, 16 Jan 2026
 07:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116080235.350305-1-tzungbi@kernel.org> <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
In-Reply-To: <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 16:27:27 +0100
X-Gmail-Original-Message-ID: <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
X-Gm-Features: AZwV_QhexDGBLPur6KXBiX5v5UlgefBBx6UNCnW-Gys53WIr1Th56tAxsqbMKFE
Message-ID: <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 4:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri Jan 16, 2026 at 9:02 AM CET, Tzung-Bi Shih wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a671e3d4e8be..fd683c62012a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22517,6 +22517,13 @@ F:   include/uapi/linux/rseq.h
> >  F:   kernel/rseq.c
> >  F:   tools/testing/selftests/rseq/
> >
> > +REVOCABLE RESOURCE MANAGEMENT
> > +M:   Tzung-Bi Shih <tzungbi@kernel.org>
> > +L:   linux-kernel@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/base/revocable.c
> > +F:   include/linux/revocable.h
>
> NIT: I think we should add this include to the DRIVER CORE entry as well.

FWIW: I'm not even sure drivers/base/ is the right place for this.
Except for a few devm_ helpers, nothing here is inherently tied into
the driver model This could be useful outside of device drivers and I
would suggest to put it under lib/ with devres factored out into a
separate source file.

Bartosz

