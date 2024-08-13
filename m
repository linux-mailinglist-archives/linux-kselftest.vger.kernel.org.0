Return-Path: <linux-kselftest+bounces-15223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0F95072D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353FB1F24937
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72719D069;
	Tue, 13 Aug 2024 14:07:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC2194C73;
	Tue, 13 Aug 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558073; cv=none; b=OCQH1ErmduTQuG5aPc/Q9/oVXmUXc+5c60Dl6e7n7MRlj0lyRwJPWyYQlvkfB6n7ZCL4UL9xr4vSmIS6kZUHWvqzMYvfl7zNbUnckX8foXVAqpr6hpB7rQvJxen7qtlmOURl8k7MZXrA+mrPEvODYLe/TR/DjwnXRYEjIh0Ev18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558073; c=relaxed/simple;
	bh=cCW3aBvhSCz3U+gCpqcWNl2UDrguBHKjGrXFQvPEzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZHoSpIDqyzslnx79g+YT7SSOCdq5esRq/2Xu7zClaoIK3obiRHYuKMNdu7+Cbj2spgtawgdP9JDi66xD/6OidNJreHn/Nbn8bD+Z1d//5Tpk5eNZnMUlMbkNp67sXnt6bYVXXblhA7AQndDnT+H7t+jhlwh1IdxTi3kGnZo9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sdsBX-0001KS-2q; Tue, 13 Aug 2024 16:07:39 +0200
Date: Tue, 13 Aug 2024 16:07:39 +0200
From: Florian Westphal <fw@strlen.de>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
	Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: Re: [PATCH net] selftests: net: lib: kill PIDs before del netns
Message-ID: <20240813140739.GA4937@breakpoint.cc>
References: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts (NGI0) <matttbe@kernel.org> wrote:
> When deleting netns, it is possible to still have some tasks running,
> e.g. background tasks like tcpdump running in the background, not
> stopped because the test has been interrupted.
> 
> Before deleting the netns, it is then safer to kill all attached PIDs,
> if any. That should reduce some noises after the end of some tests, and
> help with the debugging of some issues. That's why this modification is
> seen as a "fix".

Thanks, this makes sense to me.

Acked-by: Florian Westphal <fw@strlen.de>

