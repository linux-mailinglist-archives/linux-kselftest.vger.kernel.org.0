Return-Path: <linux-kselftest+bounces-12062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C590B326
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56BC1C218DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537513A885;
	Mon, 17 Jun 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzTkO4Co"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34C13A87E;
	Mon, 17 Jun 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633299; cv=none; b=aMJ9+BCqBQem+/RhinfxqOTWea9BbU8RtOKtBjQsnR/r0eV5aDI9K/L6nl9J5i5Et/JCXHzFTud43+4Rwhoba+PMhKHlijza4v7sO3HAteOyE117yZEHGVeHimgM82Btv/F8gGzxqPViM1vW49bq/y0E+HifaJPQNg0z2yaKHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633299; c=relaxed/simple;
	bh=VDZUhwNjkG3pJs10hYRM/sN2hB2r+IdiNzMss5536HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl/JJMHHcwdQkcPLlB9LOr9fquUIlpAwzpLnZd7/Ix868fJqgo5P+iD7qYKgYRgBuEK+BFRNhdogn8tPZ0rnetQiVEzTrXNFv891oB2Sa7v/mcsX3PCmYnlJw5z10o7vf1AxJzVk4Wz8sWXbeURF8+RfEqdn5FR+jamS2YvzX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzTkO4Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF42C2BD10;
	Mon, 17 Jun 2024 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718633298;
	bh=VDZUhwNjkG3pJs10hYRM/sN2hB2r+IdiNzMss5536HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzTkO4CokjBGBd1coSbf4mpqCBFV57CfVwyivUM2tcke7Qicrn+M2H0ullnFTtFxp
	 THx2m2FSW82Gi4xUI9G5HTv/kZbKWjfIVBRycWnwTFf1Lgmmdg6oZU751e/w7Y3mwF
	 1Y58U6hdrIcMJfZAGSeXeaRKGRaIkez+5qrSB91wwl+7rhXJxmUeC4l4qhetxVsecc
	 7FtYYRfJHG70A9divfFlzj7UNlQWMJMRLcJPFk/+w/Q7gbXAXRwl/BBZBpJ15EwVWu
	 Db9VXh/03antn2lqStQF/q64vfHOtxchVSG6cczsR/hDIqZzs70cGzl/Egf5tT+JWo
	 uxdTrGwmaMFOA==
Date: Mon, 17 Jun 2024 15:08:13 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] selftests: mptcp: userspace_pm: fixed subtest names
Message-ID: <20240617140813.GU8447@kernel.org>
References: <20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org>

On Fri, Jun 14, 2024 at 07:15:29PM +0200, Matthieu Baerts (NGI0) wrote:
> It is important to have fixed (sub)test names in TAP, because these
> names are used to identify them. If they are not fixed, tracking cannot
> be done.
> 
> Some subtests from the userspace_pm selftest were using random numbers
> in their names: the client and server address IDs from $RANDOM, and the
> client port number randomly picked by the kernel when creating the
> connection. These values have been replaced by 'client' and 'server'
> words: that's even more helpful than showing random numbers. Note that
> the addresses IDs are incremented and decremented in the test: +1 or -1
> are then displayed in these cases.
> 
> Not to loose info that can be useful for debugging in case of issues,
> these random numbers are now displayed at the beginning of the test.
> 
> Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


