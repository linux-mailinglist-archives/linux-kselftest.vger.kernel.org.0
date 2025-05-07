Return-Path: <linux-kselftest+bounces-32627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F4AAEF50
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 01:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E673118965EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3651DE4C4;
	Wed,  7 May 2025 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHadYZ1K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38372322E;
	Wed,  7 May 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746661146; cv=none; b=C6qE3MrFxvl48Exhjai9YPosRF8U7Z0Ls8gPAIdTdBD51Ra94cWvXJCUvvf9UojpRKlNKB6oDYbWmlsxp0YuHEh90jEFGOst/fXIF0rvVov6l/4wLMe4dUXWMM4zVCPAY8tWR3m25D9fvnEQQXg4KkoMWajulj57cK4RnnwVEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746661146; c=relaxed/simple;
	bh=bepzADMBmeJubYU52S00C2Sj4qWm1A/DTh0PH7TT7nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJ0WosYSRFj0vfXTVItwbjDEdGNGuz7j1kxHSaf481EcAYKD6AxVKOJLdNV+jV7dB3SyyPxBdkeT2PS35rT5LxZF0JqdLLcyB5XJTUOfWc+chL8OrfOAJWpeyvAMrEU6cQgBRaI2xvKnJzHpe7TDq5ocGyiuajCxphoS/GvRp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHadYZ1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18303C4CEE2;
	Wed,  7 May 2025 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746661145;
	bh=bepzADMBmeJubYU52S00C2Sj4qWm1A/DTh0PH7TT7nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHadYZ1KoLNnRNVb9ztDvpUgTMEOay4qPgO4bALGYoBL6B+/GR+G+nw8HgxoAGBBP
	 6OdZf3NQOijhqtrrwNIn5HD7ZcekbMkyXm4k86PXIsYof4DAsi8siPCMVOMh86Xxex
	 HTnsHHpJCH68bOXdd9eJWpAX0km/L+jUWeH3+4jqF0K1eRRq3SdXNWD4TnGDU3WMuk
	 Ph6VswS+n5r9d9bmCj6i01Yrg409vlDU68t+jmtSFtW9/itqnv5lwP2RLPlIs6+7/R
	 fGVu26FMdAEHqDCxiUAverLitKo2IFonrSmx5QhL4INtMILPnuRhQX6oW+Gf9ZzH1J
	 4D0mVTr+TA8rg==
Date: Wed, 7 May 2025 16:39:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef
 Kadlecsik <kadlec@netfilter.org>, Andrea Mayer <andrea.mayer@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 4/6] selftests: net: use setup_ns for SRv6
 tests and remove rp_filter configuration
Message-ID: <20250507163904.0cf86c59@kernel.org>
In-Reply-To: <20250507131856.78393-5-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
	<20250507131856.78393-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 May 2025 13:18:54 +0000 Hangbin Liu wrote:
> Some SRv6 tests manually set up network namespaces and disable rp_filter.
> Since the setup_ns library function already handles rp_filter configuration,
> convert these SRv6 tests to use setup_ns and remove the redundant rp_filter
> settings.

Missed some get_nodename calls, I think?

# ./srv6_hl2encap_red_l2vpn_test.sh: line 470: get_nodename: command not found
# SKIP: Setting up the testing environment failed
ok 1 selftests: net: srv6_hl2encap_red_l2vpn_test.sh # SKIP
-- 
pw-bot: cr

