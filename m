Return-Path: <linux-kselftest+bounces-21910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A69C6BE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 10:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2801F23DF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2DB1F8931;
	Wed, 13 Nov 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCq4k/oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56E1F892E;
	Wed, 13 Nov 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491317; cv=none; b=I3TU46nmnLTjFSFieVdm+QseqJzmhrf+vMZUjASDWyoIp4fPADPH6Z0G7wLUC5NYBxsmtE6o/7EOxTmL6Rf+6zMu73p3vBeHGU8GccfWt8XfMwa6MksR4HiSeqwBRSBr5I8yD+xwDvGA/LjdJ+rMxg8g0gIiuP+h6s2iFryvKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491317; c=relaxed/simple;
	bh=8t44CRZWa3doc2wAxlLVoy8bUIcjfDDp+F/2ou0Sv0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSA7eZ+0OrqXGpbLbS13b5JZkT+F7eA6AVym6RpE3qDDwEzG+kuhzjSM7SdSYSeLNnleVlhj6r5ASqrq9APSd/3rvyAjCYPkZuHcutSTK92PAFgAlwi/WQ0DCYGN2WsfAd0SJzIwqpFZusi+ZM0O+7yvTkpQWynKrsiqoyHr24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCq4k/oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3174CC4CECD;
	Wed, 13 Nov 2024 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731491316;
	bh=8t44CRZWa3doc2wAxlLVoy8bUIcjfDDp+F/2ou0Sv0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCq4k/oaRPAfo0bKlHX/aBbhyOuwXs9dLVkudKyrJ14/dhiSpVeiBfryjf+lwI4OT
	 BBh9iur7GEQZgXxABVrZEvzBrbarrADEvX4Ple8UvYoyajcluP5Vfzrmgdtgifg32V
	 GkFB5NhPmFS+txRoMqLdB+9kWIuzJuhgDUushu6iMZip8o1bnnq8BL7xxqr2hDTmXg
	 783Q+xSXWu5vCgl9wVRFama2gvErvqJrb+HN1lldnSJ4mPsNFQeMdp2IgnDDrk8y+r
	 b4vo9bWiHKJF0AJHfrTnGqyVsz0ecuCNT/bpHOAfd+hr/Gv0XDdZ+otYrWOt83c7sT
	 52kYJ9zWVnCGg==
Date: Wed, 13 Nov 2024 09:48:32 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] selftests: wireguard: load nf_conntrack if it's
 not present
Message-ID: <20241113094832.GW4507@kernel.org>
References: <20241112094828.391002-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112094828.391002-1-liuhangbin@gmail.com>

On Tue, Nov 12, 2024 at 09:48:27AM +0000, Hangbin Liu wrote:
> Some distros may not load nf_conntrack by default, which will cause
> subsequent nf_conntrack settings to fail. Let's load this module if it's
> not loaded by default.
> 
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: load the mode directly in case nf_conntrack is build in (Simon Horman)

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>



