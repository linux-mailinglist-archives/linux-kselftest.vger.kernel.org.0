Return-Path: <linux-kselftest+bounces-44246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14798C1758D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 00:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EDE40192D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57AB36A5EB;
	Tue, 28 Oct 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLO69Ue3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56F38F9C;
	Tue, 28 Oct 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694197; cv=none; b=rk9AfrFz3zkPMBGCSdekba+GuWbqeZ/aIET7p6hDRKvFA9FPxNgtSkj6cNWBE3VfhMBYdKfOex+DIq/Wr7Nzzt78+SwobpOvq7JnwGEg8dhf5izbjEkuevr9TFo70zgWVtO6Y0akKevakyAw2Wu6c81QoJNlIkl7lznjC1SIXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694197; c=relaxed/simple;
	bh=lLyQRFMtzlpmMQDsKpK+plkgZgB97hok3pYUed1Q3dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utP+HdcdXkMoHczVGn1SnqY2edV/nP68ZRXKlS1d1DVYsfPI4LTqbWGovusU9o0vNXeEhQXqGTzXH4GZpAj+CgWxypNY4v4Vt3sNqRaotGNdoYLXojXcPuL4G+1T+W0hoC7+4rEvEr6Z5Zj54zlJSZ2czypn9qfZkz02deU2o4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLO69Ue3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CE8C4CEE7;
	Tue, 28 Oct 2025 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761694197;
	bh=lLyQRFMtzlpmMQDsKpK+plkgZgB97hok3pYUed1Q3dY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cLO69Ue3ymc4yuex48L0of+f+Sy8rxhWhAl9ji0bAFXavPGrVpLwknAv2fxVhIfgX
	 +y6thYYuXiBrFfKVfF4S67pBHKRzLeCpv0nu5OcOlYiJu5/FzTzS+5OwoBc2g8wov9
	 pmtA91TjzZfYotU3sVcIotJIL23x1/BbdI/eUjphE544n6JP+JKfZhti+MiSu9+6Uf
	 g95QOf77LSWQilupkpSzxsK07KuxdowRXdrX+/LHpWqm6RRYTGqLavIO1I5Y5viC7J
	 zOilrk+x+2ET2pHfEB8YjBlVgJ1kcVrZuO7AQBjm8WRsADTFX8Q213lzdZwyn0L+lz
	 UaA28mWfJxWMw==
Date: Tue, 28 Oct 2025 16:29:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: drv-net: replace the nsim ring
 test with a drv-net one
Message-ID: <20251028162956.6011e15d@kernel.org>
In-Reply-To: <a55df0a7-4adf-45bf-b448-eeb68ba5592e@lunn.ch>
References: <20251027192131.2053792-1-kuba@kernel.org>
	<57359fb9-195c-4a4a-b102-f7739453a94f@lunn.ch>
	<20251027171539.565e63f2@kernel.org>
	<a55df0a7-4adf-45bf-b448-eeb68ba5592e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 03:05:03 +0100 Andrew Lunn wrote:
> On Mon, Oct 27, 2025 at 05:15:39PM -0700, Jakub Kicinski wrote:
> > On Mon, 27 Oct 2025 20:46:00 +0100 Andrew Lunn wrote:  
> > > We expect failure to leave the configuration unchanged. So i would
> > > actually do:
> > > 
> > > try:
> > > 	before = get()
> > > 	set()
> > > except:
> > > 	after = get()
> > > 	fail(after != before)  
> > 
> > Please allow me to introduce you to the magic of defer() ;)  
> 
> That is why i don't like magic, especially in tests which have no
> documentation of the expected results. For me, tests should be dumb,
> often boringly repetitive, and at least 50% comments, explaining what
> is being tested, what the expected outcome is, and most importantly,
> why that is the expected outcome.

We actively avoid creating framework-y stuff.

defer() is one of the few things we added. Single config change is fine
but undoing a sequence of actions quickly becomes gnarly. And defer()
itself is very straightforward.. once you know about it ;)

https://github.com/linux-netdev/nipa/wiki/Guidance-for-test-authors

> > This registers a command to run after the test completely exits:
> > 
> > +    defer(cfg.eth.channels_set, ehdr | restore)
> >   
> > > Also, does nlError contain the error code?
> > > 
> > >         fail(e.errcode not in (EINVAL, EOPNOTSUPP))
> > > 
> > > It would be good to detect and fail ENOTSUPP, which does appear every
> > > so often, when it should not.  
> > 
> > Dunno, checkpatch warns about ENOTSUPP. I don't that think checking 
> > for funny error codes in every test scales :(  
> 
> How about in the nlError constructor? That gives you a single
> location, and you can accept EINVAL, EOPNOTSUPP, ENODEV, ENOMEM, maybe
> ETOOBIG. Cause the test to fail for everything else. If anybody
> reports test failures with other errno values, the list can be
> expanded, if they are sensible.

Maybe it's just my subjective preference but I think we need to be
judicious about what we test. I see no value in checking errno here.
This is mostly a "crash test", IOW must common issues it will find
will be crashes, WARN()s or broken device. Nothing subtle.

> > > Is 0 ever valid? I would actually test 0 and make sure it fails with
> > > EINVAL, or EOPNOTSUPP. Getting range checks wrong is a typical bug, so
> > > it is good to test them. The happy days cases are boring because
> > > developers tend to test those, so they are hardly worth testings. Its
> > > the edge cases which should be tested.  
> > 
> > I believe that 0 is a valid settings. I don't have much experience with
> > devices which support it. But presumably using 0 to disable mini/jumbo
> > rings would make sense for example? And max validation is done by the
> > core so nothing interesting to explore there at the driver level :(  
> 
> Looking at the code, it seems to cost nothing to actually test 0, if
> you say it could be valid. That might also find an off-by-one error,
> if it causes something to go negative/large positive.

Okay. But for the record I'd strongly prefer it the level of nit
picking was correlated with reviewer's authorship of tests :/

