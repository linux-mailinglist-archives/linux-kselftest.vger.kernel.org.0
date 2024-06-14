Return-Path: <linux-kselftest+bounces-11922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBBB908A52
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10051B2A8D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB191946C3;
	Fri, 14 Jun 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcQ+Y7w4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83F193091;
	Fri, 14 Jun 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361611; cv=none; b=Jf3HYy2icj9VcwGX/R95j2HpqdhwPjJUPNjIZ0q7x/EH9xc4dhw2O12bmzO2jWdvCP1J4LOuWTH0s/s/XzLHrVdwSAgsKLeGa38KqDCngreEHvngg5wyVdzCRyZZ8sNrhegL4sl/0eb/5CxgmYvzVH15KUJx6fRSd4Wq+Eg82j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361611; c=relaxed/simple;
	bh=tyNmttcGD7mv/zaQQ53j3wvOf7uHsqj2O50VjgoUkpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruvUxFqlDWsjvqNYqwp8M/fn4x74Wpojz2eE0AAJ8uMK46uYB50VcAK3tgUxQxmDC189lqiLuyTHoEaMp7/fpiXNhVUWpSrMIj6tLhkkWHtq3c7YyEp/jgdtUCs9KLEjXOWyIftHGscKYQHP3XWVtOKNvOUpgrLp1B4oPWVE/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcQ+Y7w4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7CBC4AF1D;
	Fri, 14 Jun 2024 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361610;
	bh=tyNmttcGD7mv/zaQQ53j3wvOf7uHsqj2O50VjgoUkpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcQ+Y7w4qf9bivaz88L7K7po5QtSYgk2n2Eeh5TbOPy9BSqXeEDV6ZkNhudlxONrG
	 Yxjox3pM355owrdGkdRIMih0dPLa1cMd4Wc2k2itoBlgSB8GXtX5/LNLUzYzAI8wkr
	 yHd/bWXKsLzCd4aEbxK9YTrTzX6t9wYMgkrHKD2V2QDobfbW5zp9AZ+as9ol40L0tq
	 lahkb3GV2g29hZZGBdnU7zrx2CmwzhsHs+SruSn96MGyOqjfijvHModslg5YJzMPVL
	 en7Sh5/qd6sbnVlBV/fi9wnGG5rlA7GKtPpjjwiHAZZf1cgnFvXvWTfsenLrLKU5cV
	 XDEetV5VdyphQ==
Date: Fri, 14 Jun 2024 11:40:06 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] selftests: net: lib: remove ns from list
 after clean-up
Message-ID: <20240614104006.GC8447@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
 <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-2-e36986faac94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-2-e36986faac94@kernel.org>

On Fri, Jun 07, 2024 at 06:31:03PM +0200, Matthieu Baerts (NGI0) wrote:
> Instead of only appending items to the list, removing them when the
> netns has been deleted.
> 
> By doing that, we can make sure 'cleanup_all_ns()' is not trying to
> remove already deleted netns.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Hi Matthieu,

I like this, and I am happy to see that it has been accepted.

I do wonder if we can go a step further and use an associative array for
ns_list (maybe renamed).  I think this would reduce remove_ns_list to
something like:

	unset ns_list["$item"]

OTOH, perhaps this breaks with older versions of bash that we still
care about.

...

