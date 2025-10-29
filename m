Return-Path: <linux-kselftest+bounces-44331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC38C1C527
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BD3188C77E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35733DED3;
	Wed, 29 Oct 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGS3cZ1T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5124113D;
	Wed, 29 Oct 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757158; cv=none; b=AWKP8KNcSTe/CWeGeibJvI80+E8MaS6aOmrCnZpUXYrbUKXkcTjJYSsjGaU8BrWQFMPBWpAwPUgDQA3Sg46jvg3Q7IDyo7nJZLjdfNz0Wui/GfMEQYCeXDAxzgDetuFbo510mmR/iZmUAiDsOleQyZJHC992ZnaesmOgjDtsDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757158; c=relaxed/simple;
	bh=cq9FRbC1uoLV1g1AWfwYfVmonPzFmlTMYY4Ey/5BDBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZuZW+hZeossE0UxMyHpQtpmIC7VZZ17E7e/a1ptQBXQKuk2GeqJka0D+J6MSmlj9puvws4+VM3LHl2FsrrZHEzJPGWr1Ek8cikltUHRj5vbgvKL25ZcPrSAGE55uCnsJxgCQluVQhu4g8HenMRwxFIe331/R9lJvZrEs8TDPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGS3cZ1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183ECC4CEF7;
	Wed, 29 Oct 2025 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757157;
	bh=cq9FRbC1uoLV1g1AWfwYfVmonPzFmlTMYY4Ey/5BDBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGS3cZ1TrBsy/y9U2p0BYB60DW0TV75feVd8WIxw9BZEZ0RYG8kHNrQxSUF6tRKLr
	 AZHYP7KmztrXUq6Dw2pNHkPnsUtYFVDtt6g379llyr8qx8PhELSX0wE/9iU66+Q5MB
	 xAFFuUvRBjr0KKOB9U8vWf69vD43ho93QnpjIOo/+qmK3z0wTaX+FOY9+5eBq/I9gP
	 oFqV1bsznvJf5uK7Vtd4bKYsxjv3o08Jkpv++xAdrxj6Gz3JkXoY6+nhzWkzTmdHhm
	 c+JMDqyKpLspUOG1onKWasIR38Qqxz3aQ835s41EDSIhycH4OJ1WDRGYYtsjCEHiyb
	 ymbixFZ2GCm2A==
Date: Wed, 29 Oct 2025 16:59:14 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Message-ID: <aQJH4mTKNVlEDgjC@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-6-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-6-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:10PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Reduce the time waiting for the QEMU pidfile from three minutes to five
> seconds. The three minute time window was chosen to make sure QEMU had
> enough time to fully boot up. This, however, is an unreasonably long
> delay for QEMU to write the pidfile, which happens earlier when the QEMU
> process starts (not after VM boot). The three minute delay becomes
> noticeably wasteful in future tests that expect QEMU to fail and wait a
> full three minutes for a pidfile that will never exist.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>


