Return-Path: <linux-kselftest+bounces-44652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A6C2CE20
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657294655DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994C283FD6;
	Mon,  3 Nov 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4djKIx7F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ADF27990C;
	Mon,  3 Nov 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183891; cv=none; b=KmFO058PHqkcks7cw3Uy74sUhh5R1fwryAxx7ANbMlVIgV0GUFecXhwXRD2DnXux6qis3wSH+wOrwkgLifNoZCYmykGUKCkgf0Yz9QJihryBeAyZzMdVqqUP13h514x3UszfOKk9yzF05q158oy7NfGqcht15FWH+yDiKQpSlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183891; c=relaxed/simple;
	bh=fSjfZHeRH3jjgZmY2OhRdseXte5F6TtMVyjoub4ROIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR6gf9GYVxRUn310Gl1YLXy3Dhuk6Vf8GDcWgMDLCyurXh9HyP3SocE+DQcH69oIgdSf8k10mB6S8SHCDM6AqzqsZmZd35t7/QlTnprb9Qk5LcDifnf/M6px4YwGHgf1VFuhgsT3xP2YX+VbNGYlaA+BoN74DRpoPe8NXNhDDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4djKIx7F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YhNU6F3e7O+GIKBJPqJUCA4XLZNOk3X8LOJVjqbpazU=; b=4djKIx7FgIHxgQaShMONodK0DK
	CALstbfnOlSnmh2+IshZ7q6H/nrRaV7S3V6weJsdquIy9ew4znG64QmQV3l5v/thpL9A5KJrDas4W
	XMTC4t5LPzklGa8mzL63Rt/d7Gjhpa2TEK8GObgmovf48fFeY0QSP4YrTjjbGVh5c2mo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFwWW-00CnMr-L8; Mon, 03 Nov 2025 16:31:12 +0100
Date: Mon, 3 Nov 2025 16:31:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Wang Liang <wangliang74@huawei.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <4cd4c178-4dcc-4a31-98f7-48b870380d5f@lunn.ch>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
 <20251030170217.43e544ad@kernel.org>
 <aQiANPQU9ZEa0zCo@krikkit>
 <e014c4c5-105a-43cb-9411-ec139af2b2a1@lunn.ch>
 <aQjDrMH34QVz6e1E@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjDrMH34QVz6e1E@krikkit>

On Mon, Nov 03, 2025 at 04:01:00PM +0100, Sabrina Dubroca wrote:
> 2025-11-03, 14:36:00 +0100, Andrew Lunn wrote:
> > On Mon, Nov 03, 2025 at 11:13:08AM +0100, Sabrina Dubroca wrote:
> > > 2025-10-30, 17:02:17 -0700, Jakub Kicinski wrote:
> > > > On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:
> > > > > >  set -o pipefail
> > > > > >  
> > > > > > +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then  
> > > > > 
> > > > > I guess it's improving the situation, but I've got a system with an
> > > > > ethtool that accepts the --json argument, but silently ignores it for
> > > > >  -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> > > > > output), which will still cause the test to fail later.
> > > > 
> > > > And --json was added to -k in Jan 2022, that's pretty long ago.
> > > > I'm not sure we need this aspect of the patch at all..
> > > 
> > > Ok.  Then maybe a silly idea: for the tests that currently have some
> > > form of "$TOOL is too old" check, do we want to remove those after a
> > > while? If so, how long after the feature was introduced in $TOOL?
> > 
> > Another option is to turn them into a hard fail, after X years.
> 
> If the "skip if too old" check is removed, the test will fail when run
> with old tools (because whatever feature is needed will not be
> supported, so somewhere in the middle of test execution there will be
> a failure - but the developer will have to figure out "tool too old"
> from some random command failing).

Which is not great. It would be much better is the failure message
was: 'ethtool: your version is more than $X years old. Please upgrade'

We could also embed the date the requirement was added into the
test. So when $X years have past, the test will automatically start
failing, no additional work for the test maintainer.

> > My
> > guess is, tests which get skipped because the test tools are too old
> > frequently get ignored. Tests which fail are more likely to be looked
> > at, and the tools updated.
> > 
> > Another idea is have a dedicated test which simply tests the versions
> > of all the tools. And it should only pass if the installed tools are
> > sufficiently new that all test can pass. If you have tools which are
> > in the grey zone between too old to cause skips, but not old enough to
> > cause fails, you then just have one failing test you need to turn a
> > blind eye to.
> 
> That's assumming people run all the tests every time. Is that really
> the case, or do people often run the 2-5 tests that cover the area
> they care about? For example it doesn't make much sense to run nexthop
> and TC tests for a macsec patch (and the other way around). If my
> iproute is too old to run some nexthop or TC tests, I can still run
> the tests I really need for my patch.
> 
> But maybe if the tests are run as "run everything" (rather than
> manually running a few of them), ensuring all the needed tools are
> recent enough makes sense.

I've not do any of this sort of testing for kernel work, but i have
for other projects. As a developer i tend to manually run the test of
interest to get the feature working. I then throw the code at a
Jenkins instance which runs all the tests, just to find if i've
accidentally broke something elsewhere. It happens, there is a side
effect i did not spot, etc. Regression testing tends to run
everything, possibly every day, otherwise on each change set. It costs
no developer time, other than looking at the status board the next
day.

       Andrew


