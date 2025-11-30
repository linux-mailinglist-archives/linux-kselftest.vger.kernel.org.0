Return-Path: <linux-kselftest+bounces-46740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB3C94A2D
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 02:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740384E06EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775920FAA4;
	Sun, 30 Nov 2025 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApOR9XWy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C136D508;
	Sun, 30 Nov 2025 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764466733; cv=none; b=dseezKnk0z/sy3EFFGyIhLX/RehuJMOzqpo8NMWZAOfUaJkFnfeaVm9nlSG+tgHOyyZZZI/vCoUxbSPjm8liwhOiYUQ0pQLX7RHwRW2kwpQQZgUCSgbyU5tJxiYAUkNPr1MJXtmOskV/u+ZF3wsG2US5FHOpvwBZUITwK0k2Fz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764466733; c=relaxed/simple;
	bh=kjXIBPSdMJGSrRIilQYegmLZIIHSEpG7cS43KSfhv+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p35vVPMKYvlnG/d1yBUQ6pQ3MQayXSWCvimK2keaxqgmpayH/KF7IGGYvcurkinby6RvSLyVdi8K6QMbRI/EZbU/zk2C62W9n9vF+IUiXVDCO64xhM0W5YfJUfzRyL5fwox8X2Z3XYMuxYyLFfxaBIHyT4grk5EwcMHEmsrgKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApOR9XWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A66C4CEF7;
	Sun, 30 Nov 2025 01:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764466732;
	bh=kjXIBPSdMJGSrRIilQYegmLZIIHSEpG7cS43KSfhv+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApOR9XWymAja3frRZV7W4oc0Zv4j8FYCZJzvi62C0BSm/v3b+ogV6RQCEfF3S+Yfc
	 YoY0Pm6czQFQhbFSaxYUEPmBinCaPeCmi8jv+KVYm7H5M51yvUrwsKmATZSqtv05D6
	 o0cG4fTFd62aGSTbf0kiur3JwcmKsay4fkECMOUuQYUmnPzDH4RW2cHFYDMyL63XXj
	 sjuahy+T3qns6m0xXB+nfIUvWOhOJQyq5bP6CAgYoRnhJvGE3pXK3GJ4rbsJGI1Wez
	 YXCdghffLB14viu1lUd4QKZh2JllQiIHGhIddSYHWUTpWei0rx/T9mHrvasUcX6rku
	 ERbLszktRPOyw==
Date: Sat, 29 Nov 2025 17:38:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: gro: run the test
 against HW GRO and LRO
Message-ID: <20251129173851.56cf3b18@kernel.org>
In-Reply-To: <willemdebruijn.kernel.468ae2cb7a74@gmail.com>
References: <20251128005242.2604732-1-kuba@kernel.org>
	<20251128005242.2604732-2-kuba@kernel.org>
	<willemdebruijn.kernel.468ae2cb7a74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 15:42:40 -0500 Willem de Bruijn wrote:
> > +    elif mode == "lro":
> > +        _set_ethtool_feat(cfg.ifname, cfg.feat,
> > +                          {"generic-receive-offload": False,  
> 
> So GRO off disables HW_GRO, but not LRO? That difference is behavior
> is confusing. Could we still see this as a regression and make the
> ethtool HW_GRO feature equally independent from SW_GRO?

I couldn't convince myself that it's justified. Of course it would have
made testing a lot easier. But apart from that - what's your reading of
the status quo? Working backwards from were we ended up (and I
haven't dug into the git history) I'm guessing that LRO disable is used
to prevent changing geometry of the packets. GRO would presumably be
disabled when user knows that it will be ineffective, to save the cost.
Or when some portion of the stack (XDP?) can't deal with super frames.

If those are the reasons, practically, I don't see why user would want
HW GRO without SW. Ever since we allowed SW GRO to re-GRO HW GRO'ed
frames it's always better to leave SW enabled. HW leaves a lot of
aggregation opportunities on the table.

I concluded that changing the current behavior would not help any real
life scenario, just testing. LMK if you see one or the inconsistency
is a big enough reason.

