Return-Path: <linux-kselftest+bounces-33489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78EABFF6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 00:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09331BA53D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB0239E80;
	Wed, 21 May 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBXxWeYK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F543148827;
	Wed, 21 May 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866273; cv=none; b=oAAXwSndJvtzGOSiPkdFFqxWzTER2cHhLmChYssSagUpznAtXdMJhNySz++VWEE8C+w7d0ChZJFub6I95k2WMRFVFU0D9uIq2PdjXxJV9oNOn/ELpDIib40zncEaUBivsGWu7/oQhMfNPA6RxdjEIuDgIkGSokC3sy0uXOxF8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866273; c=relaxed/simple;
	bh=rcfJMid0U4cIWv6iZ+LwO1ZLuUmxSmI5sKUmm3O/BjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVEsuEe/iDzLwE454miKQY22ocBA2rPwVkLPwCUcwlgg3O0vf6Px/i4bHVB3+yUF33Dwoq6g4EbidSwxK0BLZJVKvOXAQ3dorhimjhrufpGpwENBMDIi2IX8Dof76UNajc9tGy7pLfqyGMa9ENVVnSEtlIpROOW7eFaw41MJQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBXxWeYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3D8C4CEE4;
	Wed, 21 May 2025 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866272;
	bh=rcfJMid0U4cIWv6iZ+LwO1ZLuUmxSmI5sKUmm3O/BjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eBXxWeYKurv7wpSzLSEP6u+SZgbUssr4hTy0pMxj8Ufd3NTDHjXiIvhSCAN9b4YUt
	 7LQ2vMeKG7p1LmhNAuwp7/LdJQevfz9jhtIUVapLokNY4kOsO9KLmWmxGMlC52rHKI
	 A0JD4qQXeY+0FhCCt8EqYjBXa1wBl+lXpCflstA/O+6DW2Pn10mRWqGcIvo7QRVi62
	 Ud6vY5MubCH9s90fkBko3zfp6TUKXcajJro3Z6qodWL8gEfHqaqzZyInKgSygKCqga
	 lKKoDhpVQ0pteUvVMRVJH5ySq4NA7VU0x6dD39puIwcCidn/m99TKduA5IYnXMhyjv
	 we+FplDfZ3hsA==
Date: Wed, 21 May 2025 15:24:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jiri Pirko
 <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V10 2/6] selftest: netdevsim: Add devlink rate
 tc-bw test
Message-ID: <20250521152431.56a77580@kernel.org>
In-Reply-To: <de344976-6117-478f-987c-3d24be590399@nvidia.com>
References: <1747766287-950144-1-git-send-email-tariqt@nvidia.com>
	<1747766287-950144-3-git-send-email-tariqt@nvidia.com>
	<20250520155957.04b27217@kernel.org>
	<de344976-6117-478f-987c-3d24be590399@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 00:05:32 +0300 Carolina Jubran wrote:
> On 21/05/2025 1:59, Jakub Kicinski wrote:
> > On Tue, 20 May 2025 21:38:03 +0300 Tariq Toukan wrote:  
> >> Test verifies that netdevsim correctly implements devlink ops callbacks
> >> that set tc-bw on leaf or node rate object.  
> > 
> > Please add a test that can actually validate a NIC HW.
> > The test probably needs to be in Python to use a remote endpoint,
> > and should live under tools/testing/../drivers/net/hw
> > 
> > We had a long conversation about what we expect from the API
> > vs how your HW works. One of the test cases should confirm
> > the expected behavior, IOW fail on mlx5. Which is fine,
> > unlikely that any NIC will have 100% compliance. But at
> > least we will be documenting the expectations.  
> 
> Working on this. Let me know if the netdevsim selftest should stay 
> alongside the hardware tests, or be removed.

I think it's nice to have. But please share a link to the patches which
add the support in the CLI next time. Can be a lore link if posted, or a
GH repo. 

I need to pull the pending patches into the CI so that the test can run.

