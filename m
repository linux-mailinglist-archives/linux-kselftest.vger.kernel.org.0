Return-Path: <linux-kselftest+bounces-43887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A29C0202E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A9A34EAF21
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C12F6188;
	Thu, 23 Oct 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ECHIRuM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397791DFDA1;
	Thu, 23 Oct 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231903; cv=none; b=tqplRIdIvmQW6pb45otz20vq8ZGjO7cNRQnFL2/vdEe9uq2Bbaae8KEthDKAi/wJ2tzU3ZlaT5pbWT/uhmlwEkuFKHjTTMHxF4MqMTXYio8wcjPMD2OKPfQ5b7TFYdpkYTwtnByEEYtnyaB9vWsHTPXz9vDwH9WigwjoUi3BSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231903; c=relaxed/simple;
	bh=sSADxihFYG56dUPwBXVm5dgS7uR5ionLyMUqwxUrAHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyYYrxoqJ3zVlb7rmRr2jaspXya67/QulfCkFDZtibH05YBGgC+dkGOdRRQD/i+CFDzKqLZ/6So+GD8OSf8PEmKPh77VjfyLJUy2c7XZY2yksDHkoaLcpcemMW5KhIiCl3rHb0ADbuMb5xAzloK/eE7Mmasozdg+RDaXrujUKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ECHIRuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3931FC4CEE7;
	Thu, 23 Oct 2025 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761231899;
	bh=sSADxihFYG56dUPwBXVm5dgS7uR5ionLyMUqwxUrAHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2ECHIRuMQs1yDGt+txPCxc3ZEZ4ozW1JQg36tKddm9pEROtnsUFa+bB1MRG8loLJa
	 CuFF3jjzBbQWg5WWftdhQof21re1P4SS+gFsCKDmPrCD54DuT42FN467L98ljM+0sd
	 x9/xzFIZao++II1lrUBVFV0U5FIixPbIAzOqWZms=
Date: Thu, 23 Oct 2025 17:04:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <2025102321-struggle-fraying-52ff@gregkh>
References: <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023145131.GI262900@nvidia.com>

On Thu, Oct 23, 2025 at 11:51:31AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 23, 2025 at 10:22:01PM +0800, Tzung-Bi Shih wrote:
> 
> > I was misunderstanding about the "sync" we were discussing for
> > misc_deregister_sync().  The "sync", is analogous to synchronize_srcu()
> > of revocable_provider_revoke() in the revocable version [1], doesn't wait
> > for closing all opened files.
> 
> Yes, and my remark is we don't need to obfuscate simple locks in core
> kernel code.

{sigh}

Yes, that's not the goal here at all.

I've refrained from jumping in as I think we are thinking of different
stuff here, probably talking past each other in places.

The original goal of having "revocable" is still needed, despite you
feeling that cdev can live without it (I strongly disagree with that,
and the v4l, gpio, i2c, and other subsystem developers have feelings
along those lines as backed up by the many talks over the years about
this.)

The use of it in the Rust code already is kind of proof of this, it
enables driver authors to not have to worry about a ton of real-world
issues they would have to otherwise.  Which is why I suggested copying
that pattern into C to help us out here.

Anyway...

I've been traveling a ton, and it's not going to let up soon, but I'll
try to dig into this more later next week, or on the next 12+ hour
flight that I'll be just after that, to give a more detailed review and
response, sorry I've not been able to do so yet.

thanks,

greg k-h

