Return-Path: <linux-kselftest+bounces-44328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD0C1C506
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C094E2615
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E333507B;
	Wed, 29 Oct 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsim+f4U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE672F5484;
	Wed, 29 Oct 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756988; cv=none; b=h+9khaJfqlkIfs+YAtFF5kcqMzG1lZBl+wn1vdn9cwuI4DIbbLF8GVeRDYbAy8RduVsBK7uqBExAf5MMkTUmXuBlwgeaOiCGLMU2McE4Bk2K2NMgLDth5Y1Q2zjqXrshl50kSMyPab56cPG/p7bxzZXojAm+ctMu/2O0n1T7hXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756988; c=relaxed/simple;
	bh=Oa13GPH1llD3qXCFZYwJ2bGtThuhGwzIJ6GZwuWlg8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5n7EepMm382yJy87Pyfj7zUdrbaaUymAp1lM3h1ZJqNypN41AdXoMoo8onlm33EzEZYi6A34nk2yD3+s3dQ9v2tZdM2d93J3DYsTVtCUDfrKxPV5xpsWwlPLAeelUJJQ4UAHNgEWM7fZYyHli5hqMDR/A+hGPU6NyOcep6dZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsim+f4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B0BC4CEF7;
	Wed, 29 Oct 2025 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756988;
	bh=Oa13GPH1llD3qXCFZYwJ2bGtThuhGwzIJ6GZwuWlg8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsim+f4Us6tf7GPVHovGBJalZUC/7lmoNPKAqpsZOw3sb6MzpZR/LLR1SBhHjAjty
	 +o3l88CIMGAgzkLgw7fP/AdMryqw9z1gBr4xYA6XMCakvAehy4YRrxmB9nfC9AYs+Q
	 TmT3/LQ5bcSwA+W7OLsdz2WH+BW15ug+zN9Tt2DJZm4HIGs1kP0nj4PHHIUl0Jb/Q5
	 F2eMPGjqQzVr8R3SQqNU47Lp/mVpnMF7/4rogSNZZjbNWtte0VHnLsRF8cULI1mdNN
	 gb9422zro3HI75h4cy0BqsI1BR0H2kVRz7LIn4QjKdl/JxWj9lGhYanpA/kUtS681m
	 klC0DZnCtQzXQ==
Date: Wed, 29 Oct 2025 16:56:24 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Message-ID: <aQJHOIGW_bIzBpYc@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
 <aP-iXJQVPBCjfPHi@horms.kernel.org>
 <aP+yKDYZR6+/kzI2@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP+yKDYZR6+/kzI2@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 10:55:52AM -0700, Bobby Eshleman wrote:
> On Mon, Oct 27, 2025 at 04:48:28PM +0000, Simon Horman wrote:
> > On Wed, Oct 22, 2025 at 06:00:06PM -0700, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Save/restore pipefail to not mistakenly trip the if-condition
> > > in wait_for_listener().
> > > 
> > > awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
> > > exiting upon finding a match causes false-positives when the pipefail
> > > option is used. This will enable pipefail usage, so that we can losing
> > > failures when piping test output into log() functions.
> > > 
> > > Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > ---
> > >  tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > > index 561600814bef..ec3ff443f49a 100755
> > > --- a/tools/testing/selftests/vsock/vmtest.sh
> > > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > > @@ -243,6 +243,7 @@ wait_for_listener()
> > >  	local port=$1
> > >  	local interval=$2
> > >  	local max_intervals=$3
> > > +	local old_pipefail
> > >  	local protocol=tcp
> > >  	local pattern
> > >  	local i
> > > @@ -251,6 +252,13 @@ wait_for_listener()
> > >  
> > >  	# for tcp protocol additionally check the socket state
> > >  	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
> > > +
> > > +	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
> > > +	# an error, causing the if-condition to fail when pipefail is set.
> > > +	# Instead, temporarily disable pipefail and restore it later.
> > > +	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
> > > +	set +o pipefail
> > > +
> > >  	for i in $(seq "${max_intervals}"); do
> > >  		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
> > >  		   grep -q "${pattern}"; then
> > 
> > Hi Bobby,
> > 
> > I agree this is a problem. But I'm wondering if you considered
> > moving the pattern matching into the awk script. I'm no awk expert.
> > But suspect that would lead to a more elegant solution.
> > 
> 
> I bet you are right.
> 
> Playing around with awk, I find that this seems to work:
> 
> $ pattern=":$(printf '%04X' ${port}) 0A"
> $ awk -v pattern="${pattern}" 'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0}
> 	END {exit rc}' /proc/net/tcp && echo FOUND
> 
> I think it beats doing the save/restore on pipefail?

Yes, I think so.

