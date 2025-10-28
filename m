Return-Path: <linux-kselftest+bounces-44169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8EC12A09
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 03:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3D23BE3F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C919FA93;
	Tue, 28 Oct 2025 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sGanh5Ne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A0F50F;
	Tue, 28 Oct 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617121; cv=none; b=WrB1JYUyZhpdz4ItHV/ljx8/bMYTnGHAOxEPNbX3+Co9B/TVgGzMXGdm92o1HoCN/u/EKkRHou5jqsgQkQbh0olOZZYUNqQ+zwFBwSc59+e0Foz/iSxZqx77ykpFs6Db8jr2CnEgz5TRUWbPmpq4j3fJsFQFAlgsG20YCMJPuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617121; c=relaxed/simple;
	bh=/QtiO7t/dggNE4jC07IMjjMm/+jAfX83TmfutRs9W2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC+auW5GxyhiQb9fQ+E5VEtA/JYmwn9DrUNFmb7RdEd0a0ZYmhOcjJzpZ8IojX0RfRHgKgJINUxBwFb0pKbcq79Fr1J7ZXPsRy/86OZkXFgRoj5BZP1clgSWo/vpHdQ8HFSOiJjDMw6YAkdfHW29kbHus/l3wOAKZf61x/6gWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sGanh5Ne; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GQuLB8waf5DwY5p0Hg1kGKo+ab3hK5Wpw4AlIb4e7Ro=; b=sGanh5Ne98mP44YSdlFCUu5WI5
	bKVrHiVM//qLgkKjfnOr6y06C9e3zsiqQ4Fw/pbwP+/mN57FR+PhRLVXLMu/odZE7dzbrS3f8DIwD
	lAs1BzN0eIscDZ+lPAQXfuICdjPM90mVuXQQOkgsWBpmiv3KCAFc/2nWXRHN/DCTMfrc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDZ55-00CFpt-46; Tue, 28 Oct 2025 03:05:03 +0100
Date: Tue, 28 Oct 2025 03:05:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: drv-net: replace the nsim ring
 test with a drv-net one
Message-ID: <a55df0a7-4adf-45bf-b448-eeb68ba5592e@lunn.ch>
References: <20251027192131.2053792-1-kuba@kernel.org>
 <57359fb9-195c-4a4a-b102-f7739453a94f@lunn.ch>
 <20251027171539.565e63f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027171539.565e63f2@kernel.org>

On Mon, Oct 27, 2025 at 05:15:39PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 20:46:00 +0100 Andrew Lunn wrote:
> > > +    def test_config(config):
> > > +        try:
> > > +            cfg.eth.channels_set(ehdr | config)
> > > +            get = cfg.eth.channels_get(ehdr)
> > > +            for k, v in config.items():
> > > +                ksft_eq(get.get(k, 0), v)
> > > +        except NlError as e:
> > > +            failed.append(mix)
> > > +            ksft_pr("Can't set", config, e)
> > > +        else:
> > > +            ksft_pr("Okay", config)  
> > 
> > We expect failure to leave the configuration unchanged. So i would
> > actually do:
> > 
> > try:
> > 	before = get()
> > 	set()
> > except:
> > 	after = get()
> > 	fail(after != before)
> 
> Please allow me to introduce you to the magic of defer() ;)

That is why i don't like magic, especially in tests which have no
documentation of the expected results. For me, tests should be dumb,
often boringly repetitive, and at least 50% comments, explaining what
is being tested, what the expected outcome is, and most importantly,
why that is the expected outcome.

> This registers a command to run after the test completely exits:
> 
> +    defer(cfg.eth.channels_set, ehdr | restore)
> 
> > Also, does nlError contain the error code?
> > 
> >         fail(e.errcode not in (EINVAL, EOPNOTSUPP))
> > 
> > It would be good to detect and fail ENOTSUPP, which does appear every
> > so often, when it should not.
> 
> Dunno, checkpatch warns about ENOTSUPP. I don't that think checking 
> for funny error codes in every test scales :(

How about in the nlError constructor? That gives you a single
location, and you can accept EINVAL, EOPNOTSUPP, ENODEV, ENOMEM, maybe
ETOOBIG. Cause the test to fail for everything else. If anybody
reports test failures with other errno values, the list can be
expanded, if they are sensible.

> > > +    # Try to reach min on all settings
> > > +    for param in params:
> > > +        val = rings[param]
> > > +        while True:
> > > +            try:
> > > +                cfg.eth.rings_set({'header':{'dev-index': cfg.ifindex},
> > > +                                   param: val // 2})
> > > +                val //= 2
> > > +                if val <= 1:
> > > +                    break
> > > +            except NlError:
> > > +                break  
> > 
> > Is 0 ever valid? I would actually test 0 and make sure it fails with
> > EINVAL, or EOPNOTSUPP. Getting range checks wrong is a typical bug, so
> > it is good to test them. The happy days cases are boring because
> > developers tend to test those, so they are hardly worth testings. Its
> > the edge cases which should be tested.
> 
> I believe that 0 is a valid settings. I don't have much experience with
> devices which support it. But presumably using 0 to disable mini/jumbo
> rings would make sense for example? And max validation is done by the
> core so nothing interesting to explore there at the driver level :(

Looking at the code, it seems to cost nothing to actually test 0, if
you say it could be valid. That might also find an off-by-one error,
if it causes something to go negative/large positive.

	Andrew

