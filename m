Return-Path: <linux-kselftest+bounces-30365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BADA812CD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648C4173937
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61922FF40;
	Tue,  8 Apr 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q33ff+Sk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922422B5AC;
	Tue,  8 Apr 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130975; cv=none; b=Uadem+aiEkwxEJpESfIBeA5b6YQGUuFfW03eDJrmn+U5YLMcdRKZXgXP5LMTV/j1zfhmyRh57Y0sQKqlWzlbRl1hyWHXdKx/2zMeprVmI3kU1VG2/WjfCX1hTukn6uc+jQFfuykz2+4r3HVqqKJVm9eDleH4bSwHIZkuuehHdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130975; c=relaxed/simple;
	bh=+jZsPvQTIMoF2l2DyJq1cw3AEzqCD7vE7q8SNeELS6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imc7rbW2UR1d/Duuciigy0s87tF1oZyYdJCI2QtpVtD57UK9tqk+lYOhUcWT7sRP8ceJFTEDr/XVmX4LXZljol94tAK/VTvLTBOsBlJ65KFgXxpC0uJAAVKjhhWGWC9NOmTznN1NPNb++GrVzZPWkJ5efAjgvQxlYbklo+Cm2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q33ff+Sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A22C4CEE5;
	Tue,  8 Apr 2025 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130974;
	bh=+jZsPvQTIMoF2l2DyJq1cw3AEzqCD7vE7q8SNeELS6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q33ff+SkaKH1AGj8srqndNhCTJLNWqj0GaNNNDlEb1jyZ7zWYO9P4VEOeM47NsUak
	 ym646T4k11Urv9dcA8Rs3XLguz66PPeCn7pEC4jVn1ndM4LE6I1uYFlAqzkgxK7sjg
	 APTpIrJsWqoXLi54hof22fpErOU73zOvtH5nSFHsFnSx476PRwRSp8ybmZIgR7yixi
	 8ZbTWnivZWlekWJp7ofr9vL3RCrikk9nxBL/bNImLJvurzwNUnNguYbUqixCsa5qdC
	 ik+pNTFUXU5DQrTPL6ca24L7VHVh+q5f97eA0h5UdDcGjZyibktJmai2lYo80NMoTb
	 M/RWJciJuJmgg==
Date: Tue, 8 Apr 2025 17:49:30 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] mptcp: only inc MPJoinAckHMacFailure for HMAC
 failures
Message-ID: <20250408164930.GF395307@horms.kernel.org>
References: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
 <20250407-net-mptcp-hmac-failure-mib-v1-1-3c9ecd0a3a50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-net-mptcp-hmac-failure-mib-v1-1-3c9ecd0a3a50@kernel.org>

On Mon, Apr 07, 2025 at 08:26:32PM +0200, Matthieu Baerts (NGI0) wrote:
> Recently, during a debugging session using local MPTCP connections, I
> noticed MPJoinAckHMacFailure was not zero on the server side. The
> counter was in fact incremented when the PM rejected new subflows,
> because the 'subflow' limit was reached.
> 
> The fix is easy, simply dissociating the two cases: only the HMAC
> validation check should increase MPTCP_MIB_JOINACKMAC counter.
> 
> Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_subflow()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


