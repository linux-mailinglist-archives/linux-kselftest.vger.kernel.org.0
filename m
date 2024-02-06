Return-Path: <linux-kselftest+bounces-4201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC584BCBC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8312AB25995
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59512E68;
	Tue,  6 Feb 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QldzI7L+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818C134A6;
	Tue,  6 Feb 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243012; cv=none; b=kmtP2PEUF+MXPdyp5LfoC3yftXI8BE1GeJZ+4OmaY/j5QQNUJKf5ev+0MXJaOx8k6eIdIvzmkc29OvUYfLGK0lvsGZMchh3jSFwuieEMsJXR4U2QcRZH6tQhebP0SVrgaaji3Tt7bt0AttHhyqrJs7eRRRP92t5PpeO7Wrcj9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243012; c=relaxed/simple;
	bh=5Ep/icrKIBVbIG9jTfdCXqZucuvW5B3kxdrojjiHyT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snc4Oy0p4FWUqVdtnOXuTsFa95z5R09uMyQucivo6wxFUXY+kC00AB/4duV4jHGsL0lM/HmsVCIz62da15WxIR+jHHVpV6HHkjh1WnC6E1NwpEBCXlaZ2h/uekfkiSygasccfVALbqNvnqvJQjD5SjSXKexstvcpvJ0eLpO8VRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QldzI7L+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F96FC433F1;
	Tue,  6 Feb 2024 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707243011;
	bh=5Ep/icrKIBVbIG9jTfdCXqZucuvW5B3kxdrojjiHyT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QldzI7L+E46DmTqquKCw/SdA/j0Fre7trga4q8NUXKLEqOVBDIv69ijKK3lENncaO
	 I2lxXTQCnxOKV3OTxnwS5D92ZiNT7N9OWIble3OJgOhRCNyEM/EAyYcOBFhky4XjhE
	 D761PM+a5nYAnAMIQxZJuFRz8Ke6803DE7Mngi33QVBe7yx4Px/mJLnXEO4fMZpkQu
	 qUrpQaN7D9m7yiEFmpIP1wAkhhGCqGFIxrb+eTC73nVI/5ehpP+W5gOhdpM8ZHy11h
	 gGMYKqLznzLDp6utpfr0/tOrbXsnF/k8bfe6Yc20WzlMPEWMg2XSWuS0Msmb+IRZAm
	 ls7Ey0UyLa/rg==
Date: Tue, 6 Feb 2024 18:08:38 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: cmsg_ipv6: repeat the exact packet
Message-ID: <20240206180838.GH1104779@kernel.org>
References: <20240204165618.1489880-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204165618.1489880-1-kuba@kernel.org>

On Sun, Feb 04, 2024 at 08:56:18AM -0800, Jakub Kicinski wrote:
> cmsg_ipv6 test requests tcpdump to capture 4 packets,
> and sends until tcpdump quits. Only the first packet
> is "real", however, and the rest are basic UDP packets.
> So if tcpdump doesn't start in time it will miss
> the real packet and only capture the UDP ones.
> 
> This makes the test fail on slow machine (no KVM or with
> debug enabled) 100% of the time, while it passes in fast
> environments.
> 
> Repeat the "real" / expected packet.
> 
> Fixes: 9657ad09e1fa ("selftests: net: test IPV6_TCLASS")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I'm not sure if it is important, but doesn't this also:

Fixes: 05ae83d5a4a2 ("selftests: net: test IPV6_HOPLIMIT")

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

