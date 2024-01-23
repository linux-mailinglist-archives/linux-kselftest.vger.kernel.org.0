Return-Path: <linux-kselftest+bounces-3422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC02839382
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59965293B17
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63360258;
	Tue, 23 Jan 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XotvOHPp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26713627EF;
	Tue, 23 Jan 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024367; cv=none; b=mjexxFshojosxEP9ZdpiuZPRPX65LR1Jshdg8DoomD+JkvhuiMcC+1wmAneUvrXwiRGbPKRFGfV80OFC5daZNKDGbaP8fFR+DPIHnWr+Ji+gdPFBi9nJN9OZw48kRstq3MpzkJFUyEHnMoBLlN3H+PgLx1ot5UWU6CSF+vvjnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024367; c=relaxed/simple;
	bh=8geYsNLiY1v6cDcVxFP5+/QUvwGDMSb9dGoII5DVFAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAtkXp0mqw0TwPcy4AcpoZVXTooX0I7mLz/jxy8FmNxb8RytDyA1+RSmBI80lA2j/9U5KC9hd4NzXgoSDhlEesV344uLI4pFcngX9R1YBt42Zw5eCDUcjJSQbYQO03hXSPeDkgz2iLSY0HwqOr6h6VWU2K1ls4RFb86rVIdJ5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XotvOHPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4948EC433C7;
	Tue, 23 Jan 2024 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024366;
	bh=8geYsNLiY1v6cDcVxFP5+/QUvwGDMSb9dGoII5DVFAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XotvOHPpEFnEucJsRpgj6xlcST4NzvSBc9Nly7jpGQ88bH+52e4lc0Ks4Aqf7Ur4w
	 VfAdjnkWC/DSKJ51aDwmlcbxZCSSfqvMNEazyaW/b4dA01sxn7QBne4L7+312PfQ/4
	 XpOQVPfIKb4gHRZw1MaVokA9JE5vV8qgczHFqh/q6EdkrIbTtk3VGC2K2cDT03JNVQ
	 EehkMdZXW4dw6sD/lnIr1fPOhyqEWYGeOvnVLrGHg9io+UDGNRPqGgePmnQlBgdSPo
	 GpfwQObbG74XT30UU9HQHZ/B1Orjd/pV4Kk8PON5vaUyhEZ/pABY7LnrO+kQ0f1QwT
	 dHNBGN4zKbSgA==
Date: Tue, 23 Jan 2024 07:39:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 shuah@kernel.org, horms@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: netdevsim: fix the udp_tunnel_nic test
Message-ID: <20240123073925.416d3746@kernel.org>
In-Reply-To: <c029e9d7891fcaf1f635e2a76eae9a5df898f3f6.camel@redhat.com>
References: <20240123060529.1033912-1-kuba@kernel.org>
	<c029e9d7891fcaf1f635e2a76eae9a5df898f3f6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 09:27:17 +0100 Paolo Abeni wrote:
> > @@ -270,6 +270,7 @@ for port in 0 1; do
> >  	echo 1 > $NSIM_DEV_SYS/new_port
> >      fi
> >      NSIM_NETDEV=`get_netdev_name old_netdevs`
> > +    ifconfig $NSIM_NETDEV up  
> 
> WoW! I initially thought the above was a typo, before noticing it's
> actually consistent with the whole script :)
> 
> Do you think we should look at dropping ifconfig usage from self-tests?
> I guess that in the long run most systems should not have such command
> available in the default install.

Good point, there's only one use outside of this script.
I'll queue up a conversion for -next!

