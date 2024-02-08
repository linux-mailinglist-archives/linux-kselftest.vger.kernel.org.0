Return-Path: <linux-kselftest+bounces-4345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DA84DFBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87D51F2A76F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD46F51F;
	Thu,  8 Feb 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyW/JpIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08586F518;
	Thu,  8 Feb 2024 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391817; cv=none; b=MexBJJM779ren4Hu51fxTD4JRC6rTnKls6ZQHGbRD5ExuAZ24xWcYnW3w9ldo7AiJe0Z4t1bvIiujVq0wbTgNCgxy6Wod/0ZKvcqaOeY/0sRsCh2+9HTPgUgeOAAgwKcl2qECOvFxFYaMqZdRJUw5uuOZjtLALss8edZCE8tOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391817; c=relaxed/simple;
	bh=mNFsocaCO+sMH82OvbyHqSqCbxLmwULZl8cas/ULl7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjby9wtsFIGTMt9Z+7AqloEj7UBnLKrCXenievTuuAwZ2GsD3TvmihnJJtloKGwRLQ5HQe9pp45yFoNLj+GegQ0uUjWGglqfNb0LsEMtRpwku7a39fPURubBCCaK9EV0CX7nMs+zfo8x6cYd84UgXZ9eQW7aW+4gJ/E5gtRYUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyW/JpIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77185C433F1;
	Thu,  8 Feb 2024 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707391817;
	bh=mNFsocaCO+sMH82OvbyHqSqCbxLmwULZl8cas/ULl7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyW/JpIBraeZyrtGd8fj6zaeA58f0P0wm2x24Y924VlzLoMHmeQkJtAFOJtNGxVvX
	 5LJasuIJItr7GZcPrWFP28VXE4o+PGzsGVYVrzq1Ya7hzqGYbiI6zdMHAP5aI3Kg74
	 fyk1xvhtEBA3EHRCSRDGmJeLKouYX7OC00gbdxcB1NXvmMJ2KQrjrT9qoeoaRhJIb6
	 kV4M819oJmtp1+IQTQWpSni3DX39o/LlftXeC2gCQepes/ItXIijSFhLTjhLFvbI2l
	 dKoTLGvR4dYWuJjfxIKK+FHZ1Xb1uTlsXrkUO4zc0Df5aS0EORyaqUQU9qJ6bZm2qk
	 J9wVzO3LZuNnw==
Date: Thu, 8 Feb 2024 11:30:12 +0000
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, andy zhou <azhou@ovn.org>
Subject: Re: [PATCH net v2 2/2] selftests: openvswitch: Add validation for
 the recursion test
Message-ID: <20240208113012.GH1435458@kernel.org>
References: <20240207132416.1488485-1-aconole@redhat.com>
 <20240207132416.1488485-3-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207132416.1488485-3-aconole@redhat.com>

On Wed, Feb 07, 2024 at 08:24:16AM -0500, Aaron Conole wrote:
> Add a test case into the netlink checks that will show the number of
> nested action recursions won't exceed 16.  Going to 17 on a small
> clone call isn't enough to exhaust the stack on (most) systems, so
> it should be safe to run even on systems that don't have the fix
> applied.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
> v1->v2: Used a slightly more portable io redirection semantic for the
>         clone() flow test case.

Reviewed-by: Simon Horman <horms@kernel.org>


