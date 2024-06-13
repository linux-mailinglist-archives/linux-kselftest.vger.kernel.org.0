Return-Path: <linux-kselftest+bounces-11831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615E90633D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 07:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866AB2850F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68108132104;
	Thu, 13 Jun 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="helzs7hf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0737E1;
	Thu, 13 Jun 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255037; cv=none; b=EwmutxDLrv7Zvltst4wZD6OXSzuNljR1hl6pz9Rukvf8Jdw0t8Q8b3B6ADdQ60EIeo/rHc5N47mEKlsY4OSQPb+aqiqxKEeW/2fR1yLk8kYQ0C6kbzjuzsTW6/KQL98LzM1anoyHVPPmkIL4WTEwYDfCK7oxDsaf7Kgou+pmGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255037; c=relaxed/simple;
	bh=GX2a40HEDEHHW6TPclVUxneUVRJo7Bvo8UyHXhijbxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKXsakBN6+JQXmwOOmNJHl9g/I2z2O6LvvdYl/iHuzAXLw5vjN0uJKhpi5jaebtSt1ByP+wwa9HvC/NeSrfY69+QlBWboZ1m0U0/ACzQlfuj84L7xggoEqh1iBFNSpEbO5VJqu2fzrRaQLMawoObDfiKb5cw6MLC7RClWnoQkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=helzs7hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02C4C32789;
	Thu, 13 Jun 2024 05:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718255036;
	bh=GX2a40HEDEHHW6TPclVUxneUVRJo7Bvo8UyHXhijbxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=helzs7hfLHd4OevazVNmYpfJPJThbMPx8BLH1rhyA9ViX4aNR29vadgRYLbZtYBeJ
	 RMJtKIh2uzunFghOQDVsIABXKt3bYhowTCqrdgVpTdELu+OBQqgag+lozCVZ03S3Vj
	 vl5wa8q6I8Sjld4BDHKmEu/Tk0O9gyM1YbRl7/3NfE8kiPSyW0Lh4PnGv1uaGNyiOI
	 84FfetFBMZ5J8yweot2iO09SYWY+MiZTE5l5VR65FPyn+pxcYZjXoJLckQeZXiqSjV
	 JmduIKQ71X1VkZrIZM26UsYA87cxDRdJolGA29jEnSSY2c2Tw6NTRC6/mWqkeQhGVd
	 yiHXVr88ClGoA==
Date: Wed, 12 Jun 2024 22:03:56 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] usercopy: Convert test_user_copy to KUnit test
Message-ID: <202406122203.475178DE@keescook>
References: <20240612195412.make.760-kees@kernel.org>
 <CABVgOSn+ApgyT0imi9cNLz2ojRoSE08H6Z8iYNhxXiKmG=FGzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn+ApgyT0imi9cNLz2ojRoSE08H6Z8iYNhxXiKmG=FGzg@mail.gmail.com>

On Thu, Jun 13, 2024 at 12:41:43PM +0800, David Gow wrote:
> On Thu, 13 Jun 2024 at 03:59, Kees Cook <kees@kernel.org> wrote:
> >
> > Hi,
> >
> > This builds on the proposal[1] from Mark and lets me convert the
> > existing usercopy selftest to KUnit. Besides adding this basic test to
> > the KUnit collection, it also opens the door for execve testing (which
> > depends on having a functional current->mm), and should provide the
> > basic infrastructure for adding Mark's much more complete usercopy tests.
> >
> >  v3:
> >   - use MEMEQ KUnit helper (David)
> >   - exclude pathological address confusion test for systems with separate
> >     address spaces, noticed by David
> >   - add KUnit-conditional exports for alloc_mm() and arch_pick_mmap_layout()
> >     noticed by 0day
> >  v2: https://lore.kernel.org/lkml/20240610213055.it.075-kees@kernel.org/
> >  v1: https://lore.kernel.org/lkml/20240519190422.work.715-kees@kernel.org/
> >
> > -Kees
> >
> > [1] https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/
> 
> Thanks! This looks good to me (and passes everything here). Unless
> there's a compelling reason not to, I think we can take this via the
> KUnit tree.

That would be lovely, thank you! :)

-- 
Kees Cook

