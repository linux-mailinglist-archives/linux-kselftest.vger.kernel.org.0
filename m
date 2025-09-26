Return-Path: <linux-kselftest+bounces-42480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC22BA4010
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BAB626BC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EBF2FABE7;
	Fri, 26 Sep 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkMN+Ijq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919F1A8401;
	Fri, 26 Sep 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894964; cv=none; b=kF58pJPemC4HXWVmF2dpeRIcJVnU+FusCpHne20gkvi4o5MrNIf1psMgCwuqfqLVN7MmefjQl9038sluGlgRcZI8EKPRz/jNArgqMtU8A3HRf55Dwj4AJ3Z/NzrauepsEradFh1ppq80e8+xb8q8jVhaAvvZzWXlW4TntDrZw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894964; c=relaxed/simple;
	bh=wPtpbHU5qiztePCOTexXeHRsovutabSkWdRfmhv8X9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4L79uRD1Np+SllBJ3rLjdgmfWn9p7X2rmdsDTaAYAxJYbwXe1IHO900obmRMTnqY3dKnlp9b8EKgGGo9tAH7H1sKvvrlDkufhAq/rgbs/dmw2y7gtvzPC/wgyLa2z3urXyo+xZP/+szhdWeDkpwoaA9Mkot4JiiFX/9jvjiZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkMN+Ijq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F0DC4CEF4;
	Fri, 26 Sep 2025 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894963;
	bh=wPtpbHU5qiztePCOTexXeHRsovutabSkWdRfmhv8X9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkMN+IjqmFXod++aT9ALMT0q+LgnMRTyddLK2qfdxeK5HkW3xkZK03Rajqt9BHUzX
	 0AWVtzAHzYB60TXh9LjDH0EO3WKiSlqSglv63oBRueUv/DxbPmDwQ7gE2rxoE3MwO6
	 VA5oTGBN6mnI6K+ogIRnv5ToNflVRqEVbQXYJtIb87cg64hKjJB+DBZkr9QJ1rp20K
	 quckP7nX7UznX2K1Div8Abc3IHcku+66TC+kU5qpQyC3lCfNQTSMMJ/O3ZS2ILQZOP
	 pl3DGUcJ/KJZTkokREQbmSV4+9ygamEYebggVfz5aWmAFoPP3MRzGPXQXf1vO4MZOJ
	 J6W6GSwlC4jRA==
Date: Fri, 26 Sep 2025 14:55:58 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>, David Yang <mmyangfl@gmail.com>,
	Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net-next 10/13] selftests: forwarding: lib: Add an
 autodefer variant of vrf_prepare()
Message-ID: <aNabbluqBcw_wJvI@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <2f2000e54ae700d560a8d6128322dade3bd2207e.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2000e54ae700d560a8d6128322dade3bd2207e.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:53PM +0200, Petr Machata wrote:
> Most forwarding tests invoke vrf_prepare() to set up VRF forwarding and
> vrf_cleanup() to restore the original configuration. Add a helper,
> adf_vrf_prepare(), which is like vrf_prepare(), but takes care of
> scheduling the cleanup automatically.
> 
> Convert a number of tests that currently use defer to schedule the cleanup.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


