Return-Path: <linux-kselftest+bounces-10170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2768C4FA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F31281FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 10:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70812DDA1;
	Tue, 14 May 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxoBnodU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3556CDC8;
	Tue, 14 May 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682240; cv=none; b=guU9W7PFaU9yhv216FuonLOwKVa+FvNsabMCssGGH9Onh6blqHpKC2lQ1v3Vhp9Ov9SPF7ewGej9HubNxykWU9fdHoEQlrDQZHfaXZcHU3Zw6hRlU6AaXldE0NcMdzYpZzsbmLY616Tc/LGtaQa9ON17V3Qfc+hqRFFcjDawPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682240; c=relaxed/simple;
	bh=L/RIHl3uYTZqFAHadVBuoSMdsGV0jXRCjRcgvtVTtd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtYzdtpND9aPGINhCR8saL5EnwJZ2xg3vG0+x1J+ebSezazd1Pp+nBhbMK6faVZLDNjuoJRQbxZ3LGqBYPkfsUs4yEzf0MVx/Bt8YanVv6Oidez0f23Q/ZlizzUcE9vbIkUEq/nvfVa0trxdfCEqhgm/DPiIxybnqDcZkRIPf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxoBnodU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01713C32782;
	Tue, 14 May 2024 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715682239;
	bh=L/RIHl3uYTZqFAHadVBuoSMdsGV0jXRCjRcgvtVTtd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxoBnodUtQr32PtJ+RQ7ho9iDJnFVQ4BnMn1GxD95yRY24N+XOvDaasxSqWggDqoR
	 WSTBavOrQ2R7W8cG3eoFpJweiIAm6MUPp5K13y3NzgI1XGNYiHDONvWA4VXU5u4n1W
	 tZzijsyDmLG+lWGuTa6BWJ1IcxiF9IkXCzM85LN1XpDt16OMamTGrVqXgdMCxsYTMW
	 85qRofX0cA58wrWLuikA+TXUfrGZYrZzh8BlvaizW+mVT2QWGZrfBLF/uDe7kIWGLI
	 gImRhfGFNMoUF9fbYuV/vgMIuAZt5PllWIF3VEQneNxQCAZYgLCj3vUyYLKokzwMgV
	 uA9Wuhi3F4Tew==
Date: Tue, 14 May 2024 11:23:49 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests/net/lib: no need to record ns name if it
 already exist
Message-ID: <20240514102349.GC2787@kernel.org>
References: <20240514023400.1293236-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514023400.1293236-1-liuhangbin@gmail.com>

On Tue, May 14, 2024 at 10:33:59AM +0800, Hangbin Liu wrote:
> There is no need to add the name to ns_list again if the netns already
> recoreded.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


