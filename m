Return-Path: <linux-kselftest+bounces-12004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB2909697
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 09:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EF32835F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443C17BA7;
	Sat, 15 Jun 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILeH0ixd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379118637;
	Sat, 15 Jun 2024 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718437211; cv=none; b=i9shQzjnekdlb9FG98tOvcDkzwewLIM64Xwy941jqfNrWL6NAes2nD/d2O0nP3UlIDLZO/yT0qxaV5wPUkaCs/jTSdZiu+nFXuJ2F8fK6ckH+i1neCgBVG/HcO0ZXhXpjmBxSG2OLpTeoC2ZnZqRJw3wk1nESEGUpKsQS23Dp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718437211; c=relaxed/simple;
	bh=5E36F1hoIXadjD9zZM5/pSWRGkOJeeo4SUAJ1PtAlbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyAIxCpY3cl8AF/s/rDL6jXJTxKTakFqv2ZBAiDSdCzYFbvnB+8JiCTHS30a9z72ozDtvaTHlXrhqxZDY19aLNL5hp+wXI9Apm/aOBqeWQO5RoKNgUKWVTbc9eXlHu+N1AOy/xkMQYOrlZgdqi88qxZbDhvKfw6y/p6lB2dM80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILeH0ixd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8E8C116B1;
	Sat, 15 Jun 2024 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718437210;
	bh=5E36F1hoIXadjD9zZM5/pSWRGkOJeeo4SUAJ1PtAlbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILeH0ixdjcxDCLWVf+63wI1nFsGK/yl8btuJY9vFg68XHCjSZpbj7xaPIhzOGdJvj
	 rUhXlhidunG+qU6CpUGgVUp7X9SYhLCyPm5aknRDlZ6VMKXhzgVJ74ayokfQaWqr03
	 0I0thoV/qZ9N7X8A2wgWntmbDxsnOPr4Z1pQNtykjYqZhae5GOX3QyG92gEA2xQbxV
	 H+/RvQitzv+guzu5Go0lriN0mT5UCkjqng9Y8aMI0VlBadruaJmEFVGwsa0pcZZAr2
	 sVcLUJORYEDCdd0IWekj2padDhMvA/Qeo3uxjP5b7HDJ1PDT6C0vxtlJ6Cgxadwee9
	 /x6FaBcWsgt0Q==
Date: Sat, 15 Jun 2024 08:40:05 +0100
From: Simon Horman <horms@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] selftests: net: lib: remove ns from list
 after clean-up
Message-ID: <20240615074005.GB8447@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
 <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-2-e36986faac94@kernel.org>
 <20240614104006.GC8447@kernel.org>
 <54e9c949-da29-4a19-af29-55aac52afbf9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e9c949-da29-4a19-af29-55aac52afbf9@kernel.org>

Hi Matthieu,

Likewise, thanks for your response.

On Fri, Jun 14, 2024 at 04:42:38PM +0200, Matthieu Baerts wrote:
> Hi Simon,
> 
> Thank you for your reply!
> 
> On 14/06/2024 12:40, Simon Horman wrote:
> > On Fri, Jun 07, 2024 at 06:31:03PM +0200, Matthieu Baerts (NGI0) wrote:
> >> Instead of only appending items to the list, removing them when the
> >> netns has been deleted.
> >>
> >> By doing that, we can make sure 'cleanup_all_ns()' is not trying to
> >> remove already deleted netns.
> > 
> > I do wonder if we can go a step further and use an associative array for
> > ns_list (maybe renamed).  I think this would reduce remove_ns_list to
> > something like:
> > 
> > 	unset ns_list["$item"]
> 
> I agree that it would ease the removal of one item -- which is not
> complex to deal with the new helper :) -- but do you see any other benefits?
> 
> For the moment, there is no other value to associate with, so we would
> do something like NS_MAP["$ns"]=1. We could link the name of the global
> variable, but that's not needed for the tests for the moment.
> 
> Also, I don't know if it is important, but when we will iterate over the
> list of netns, it will not be done following the same order items have
> been added into the hashmap. So we will change the order in which items
> are deleted.

I agree that it would probably end up being a NS_MAP["$ns"]=1,
i.e. a dummy value as there is no natural one to use.

I had not considered the order issue.

And yes, the benefit I see would be limited to removal.
Which as you point out is not a terrible burden with the helper you added.
While, OTOH, my idea adds complexity and unknowns elsewhere.

So overall, perhaps it's best left as an idea for later.
As the code changes for other reasons (who knows what?)
an associative array may make more sense than it does now.

> > OTOH, perhaps this breaks with older versions of bash that we still
> > care about.
> 
> Good point. I don't have the answer, but associative arrays are starting
> to be quite old now :)

Yes, I think so too.
But I also thought it was worth mentioning.

