Return-Path: <linux-kselftest+bounces-29367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BDA67AC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FC919C11D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6220F077;
	Tue, 18 Mar 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+/qXefg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C61AAA10;
	Tue, 18 Mar 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318580; cv=none; b=nHLCOGvSiCaUW85nLlvlAp2uN8PKKnAGBFlEHV/Y7TiLFPvx8R0T37cgzqLkO0HjNGbFbczkal3vjQLvwZ8ly1cRQr7rnppWgojyqGKyWLlyGcsGq6dGCC/IKTHSV2Dz7Go8jcLovBB2Xj9lmoUzrmZkJIZHUBCTZmHOfXOl0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318580; c=relaxed/simple;
	bh=g39vkfmbESh0PFO4IyKdFj/cvaUvQEaMmLBHG7zGzbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enbxAvr06Bd2qEe9suXndH75nrvaXANdjRunc4MhTsAm7Kr0SuVYjftndn9zOUaJo5HTNkKaqIWaVH6kQjjqmwRnWqE5AOBuW9qxCYqnXeeWzvk+SytQTM09leFctCOFCWhuSbGcEqRtNQ77tTbbqx8G4+gkYmfZwgpunUTmbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+/qXefg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBF0C4CEDD;
	Tue, 18 Mar 2025 17:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318579;
	bh=g39vkfmbESh0PFO4IyKdFj/cvaUvQEaMmLBHG7zGzbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+/qXefguyBrU4Y2rnE2hzWT0JxkKeS4iNejFSJv3k6j6GOc6Z0VKsfS6zXzHm6Ni
	 frX6Hf7o4hjwAoMjJughyHcaozLBLZkXVwCdZL7KMOIYy/TG78SsdxwpIzT5R3UdxB
	 1lO2ZjDNQeddRrWYD6P8vHSF+aTFZissks4q+n9j9Vdu9OVhnK0Kas5elD/gVgmTnO
	 2tPyH7qKfvNrBffR5cUvzdzhod7t3j4rCgqOY+yeNzzavgPs2vj4aIaehfAOEwfqLr
	 6OUNiWgKx/IEuF1bCpynyV0zSctPQ88iZZVmnsIVug4mx7JyZRKrWX2tV9qlWzFCFU
	 aCest+ogkdpWw==
Date: Tue, 18 Mar 2025 17:22:54 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] mptcp: pm: only fill id_avail_bitmap for
 in-kernel pm
Message-ID: <20250318172254.GI688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-4-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-4-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:53AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> id_avail_bitmap of struct mptcp_pm_data is currently only used by the
> in-kernel PM, so this patch moves its initialization operation under
> the "if (pm_type == MPTCP_PM_TYPE_KERNEL)" condition.
> 
> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


