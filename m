Return-Path: <linux-kselftest+bounces-23737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B5F9FB354
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C3C1632D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9A1A8F8B;
	Mon, 23 Dec 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM6Djv83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7F80038;
	Mon, 23 Dec 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972635; cv=none; b=Yj2tlDxiJhr2pGrEBfGGgXc4BWJ/wzLg2Gfzwxw8yXWhN7G2hjM4k+j+csVQKIiQo/T87c/ypZH6kP5IRamxkmdlHc/iOSODPKk6mfNg9qEgI4ZeahQi++WzAW3vephPleQTpramaN3vhA2+SBeDL1BYbsJBPSr4KG5i48dTBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972635; c=relaxed/simple;
	bh=1ICzWEYg/SjkAHesfsZYH1PIBuyI7JOU8lzjwZ72/nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgNdYluVQbzKkna4KNR1SC9UDikig5a2cNLRyZ1+uGIq3B6jL4RoMsiFOo7wUiL8y7fq1Km9NPk3/F+cPe4XG5wjXqKBmr+bPHbLjWiFfaYMpnlntXnDomYy2LfwYEy7Hs3XXKM07ee5aQkhL+XUazoYPUyilHisEqv6QlR+7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM6Djv83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631A4C4CED4;
	Mon, 23 Dec 2024 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734972634;
	bh=1ICzWEYg/SjkAHesfsZYH1PIBuyI7JOU8lzjwZ72/nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WM6Djv83uHOx8hadDlR39Pf9KBY1yCY9se48fzkwqMwU3kLAJIKmqpavrHw0GdJ48
	 f8it/EH/s4+kKbDKMSvkd4yPKvwNi/LMskJWfhRGb7gSBDlUAdpnjFiIonb9ABMu1P
	 ukr8lM/OMuH9AOw8Xer9a+aGTjE6TKJRO/UggXUdPiiD8WgQKkgFE05yrcCKFGQAgK
	 gb8NLJ10W8NcXCHJJRsed9gy+eOk5dZK9QcMxtYUY61BWOj2LZJygW+R62DAZlhpiv
	 uOBL9Sef0HXeFrs42DIvrr8KUCq0JCdnygIeLUKGnWKYp3zqTrwCI/W+IWW/+t1+zZ
	 huhRHvdV+pNOA==
Date: Mon, 23 Dec 2024 08:50:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Soham Chakradeo
 <sohamch.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Soham Chakradeo <sohamch@google.com>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import
 multiple tests
Message-ID: <20241223085033.5926d1a6@kernel.org>
In-Reply-To: <6768dd1289ee2_3cff202943a@willemb.c.googlers.com.notmuch>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
	<20241218100013.0c698629@kernel.org>
	<19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
	<676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
	<20241219180144.7cf5226c@kernel.org>
	<6768dd1289ee2_3cff202943a@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Dec 2024 22:46:26 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Thu, 19 Dec 2024 14:31:44 -0500 Willem de Bruijn wrote:  
> > > All three timestamping flakes are instances where the script expects
> > > the timestamp to be taken essentially instantaneously after the send
> > > call.
> > > 
> > > This is not the case, and the delay is outside even the 14K tolerance.
> > > I see occurrences of 20K. At some point we cannot keep increasing the
> > > tolerance, perhaps.  
> > 
> > I pinned the other services away and gave the packetdrill tester its
> > own cores. Let's see how much of a difference this makes.
> > The net-next-2024-12-20--03-00 branch will be the first to have this.  
> 
> Thanks. It does not seem to resolve the flakes.
> 
> At this point I think the best path is to run them in debug mode to
> get coverage, but ignore errors. With the below draft patch, error
> output is still logged. For instance:
> 
> # tcp_timestamping_partial.pkt:58: runtime error in recvmsg call: Bad timestamp 0 in scm_timestamping 0: expected=1734924748967958 (20000) actual=1734924748982069 (34111) start=1734924748947958
> # ok 2 ipv6 # SKIP

Makes sense. Can we make this XFAIL instead of SKIP, tho?
Not exactly accurate but we try to use SKIP for reporting env / setup
problems like missing commands. We have FAIL_TO_XFAIL and
xfail_on_slow() in the lib for netdev bash tests, already.

