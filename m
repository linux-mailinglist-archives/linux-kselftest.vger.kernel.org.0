Return-Path: <linux-kselftest+bounces-43346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D28BE4DD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 19:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3FF19C495A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12234F486;
	Thu, 16 Oct 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biocjUso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713934F470;
	Thu, 16 Oct 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635832; cv=none; b=sQRnoWM25tsrmRhHjTTcDVgtdA2ApyVfogAWM3w4jczi9nm0XWoweTSZTaXjSpmm3nQ0qguJdHLGXOURCoYr0mRvLdnTCeEKixjLxZs77g7QI7SBBhZcWVZVOf5zF6rsmuaulJXpiqqybx2ayuMkVA0dBK9bHqPEK1gVwASTaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635832; c=relaxed/simple;
	bh=O1PeDs+ueaf6tTqY3uTzigyg4af7TbN5NLCGU6ditm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrCJZ3rHaEQVoO3OBA5RSr4MMyk+4m/lriYrIVt0SxHtCRBIl22EsV7FghyhqlRBGF+4IggTSje1tuzxSA3rp0aJtiRrJXUpi8/N44+jpeJEO9a8/Q8G5cqE6rRWhtZRuwA/uf+b+HDsZSaHYbp9KTcqN95WtRsD06/fwLRGfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biocjUso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A100FC4CEFE;
	Thu, 16 Oct 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760635832;
	bh=O1PeDs+ueaf6tTqY3uTzigyg4af7TbN5NLCGU6ditm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biocjUsoQunlT8LPzGwXoaMftmMLyNtQUGK0upt4nFv+6zS5o/8KHL/QlKhW7RNT2
	 lMMpYFTZJJFVzKc3ct/vaGiAtKMfUGXWP5RVolXqJafCGbcmeeI1xHQuv9tFduCxpK
	 lI9LD2YQdSwYy7rZ62XcwPFSfYGqakBf64Q5+oVvFkR68zODKNu1Z//HuEJe8YiPqF
	 aLEhCGh6/z7jqnre8xvXnUaWEdvV9OX9JwdlqPIcQI2jKnMFCg27Ar2PT4IC+bexEQ
	 C+WbCmS1vDnv6k1Yrt9Lvf240+FMRYUZ1PzmG10etWJrf6es0p9lot8KZHSvVd7vrO
	 V5AtGDnq1aN3A==
Date: Thu, 16 Oct 2025 20:30:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v5 6/7] liveupdate: kho: move to kernel/liveupdate
Message-ID: <aPErsBFxgxJ5VntU@kernel.org>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
 <20251007033100.836886-7-pasha.tatashin@soleen.com>
 <aO9WvF_WMkKKqYo5@kernel.org>
 <CA+CK2bBC57v_CYdpT-Jcu4LX4MxZZ5CyAJBVTZVXdMnCXR-AmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBC57v_CYdpT-Jcu4LX4MxZZ5CyAJBVTZVXdMnCXR-AmA@mail.gmail.com>

On Wed, Oct 15, 2025 at 07:50:59AM -0400, Pasha Tatashin wrote:
> On Wed, Oct 15, 2025 at 4:09 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Oct 07, 2025 at 03:30:59AM +0000, Pasha Tatashin wrote:
> > > Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
> > > core kernel related files to the same place.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thank you.
> 
> >
> > One comment below.
> >
> > > ---
> > >  Documentation/core-api/kho/concepts.rst       |  2 +-
> > >  MAINTAINERS                                   |  2 +-
> > >  init/Kconfig                                  |  2 ++
> > >  kernel/Kconfig.kexec                          | 25 ----------------
> > >  kernel/Makefile                               |  3 +-
> > >  kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
> > >  kernel/liveupdate/Makefile                    |  4 +++
> > >  kernel/{ => liveupdate}/kexec_handover.c      |  6 ++--
> > >  .../{ => liveupdate}/kexec_handover_debug.c   |  0
> > >  .../kexec_handover_internal.h                 |  0
> > >  10 files changed, 42 insertions(+), 32 deletions(-)
> > >  create mode 100644 kernel/liveupdate/Kconfig
> > >  create mode 100644 kernel/liveupdate/Makefile
> > >  rename kernel/{ => liveupdate}/kexec_handover.c (99%)
> > >  rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
> > >  rename kernel/{ => liveupdate}/kexec_handover_internal.h (100%)
> > >
> > > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > > new file mode 100644
> > > index 000000000000..522b9f74d605
> > > --- /dev/null
> > > +++ b/kernel/liveupdate/Kconfig
> > > @@ -0,0 +1,30 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +menu "Live Update"
> >
> > KHO can be used without Live Update, let's make this "Kexec HandOver and
> > Live Update"
> 
> IMO the current menu name is OK, as it is an option presented only to
> users configuring the kernel, my rational for that thinking is that
> KHO is an independent module, but it should be enabled as a dependency
> by other kernel features that require it.

I think that we should allow enabling KHO on its own. For example, preserving
tracing data in reserve_mem usecase does not have a strict dependency on
KHO and it surely does not drive it. 

-- 
Sincerely yours,
Mike.

