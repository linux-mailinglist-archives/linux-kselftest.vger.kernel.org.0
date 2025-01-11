Return-Path: <linux-kselftest+bounces-24277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE428A09FE6
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 02:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047FB3A8305
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF3E567;
	Sat, 11 Jan 2025 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxnZxTRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B05C96;
	Sat, 11 Jan 2025 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736558200; cv=none; b=brczzx+x+UfXfnz3GDNx5gYb79DIxbm/flr1JbuV0ioCXjI6vxRhTr/b7LW8GMXZMk1j4P0/BfSmreKVUmWU7JvfMiXAKn42SBfxtWCiGEFBxx5WH4VSNsAG0d3pfWjzuDNFJ0xh37Wr6gqUEdACNG6Z0M3730JJn6mM4gDXLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736558200; c=relaxed/simple;
	bh=N//O/4kEjwuDXDFnjwe6re/D/EDYzyDmRFj8C6C5drI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmvoA+ZEmr7hIWUkhal9IQ6Jq0LyABT8BONYxWeA4DW5RiH3fd4ns36JyktVHmnqPHnohRqnL1uF9iv/20AJ5EfpQmO7ZQTOGag8sj6LawRI/Z8WKbwIvAVesFhBtzdAq0X0aLWJqz6lqjK3WUDseRQj36WMEteGhhgj7oQIwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxnZxTRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF89C4CEDF;
	Sat, 11 Jan 2025 01:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736558199;
	bh=N//O/4kEjwuDXDFnjwe6re/D/EDYzyDmRFj8C6C5drI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxnZxTRRGHZfA0fxIsZnreynkVM9sWMseRe2DIN1e4H79Ukol43Hbu/h6B0YoZi3F
	 lqdAX5YCbOldP7x3yAFnJxguwBVdxTO1j/I77UCFTpHf6gGDvWA3cwJ7Q8b6Jdi4YF
	 Mns5NVxbWTcaERotFQ67MhkzTLmFQdpe6PBy6U6nEcAL8hfNmeO13zZaVl51TSjqlG
	 QgEfEZVsVbE85eOemj1vZKQnk78XZQbCWqg9pajC/C1y+yH2HVgjtqrIYgyzCcIQ1/
	 EwSjNM92RAmIe2ar+Rx0Keoj2nU2HW+9klpZtIlo4TPUts6xpM9t8XPkUOwQDPMPqb
	 BZSXEnTwppdrQ==
Date: Fri, 10 Jan 2025 17:16:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, petrm@nvidia.com
Cc: Hangbin Liu <liuhangbin@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net/forwarding: teamd command not found
Message-ID: <20250110171638.58114f75@kernel.org>
In-Reply-To: <s564xh7c2xtmjz2cfwqq3zl4krjxiy4hqjeuvjpa6uhabcgvcb@k662t5irg2yi>
References: <20250110000752.81062-1-alessandro.zanni87@gmail.com>
	<Z4CdYzmSn2cySE_h@fedora>
	<s564xh7c2xtmjz2cfwqq3zl4krjxiy4hqjeuvjpa6uhabcgvcb@k662t5irg2yi>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 15:35:23 +0100 Alessandro Zanni wrote:
> On Fri, Jan 10, 2025 at 04:09:07AM +0000, Hangbin Liu wrote:
> > On Fri, Jan 10, 2025 at 01:07:44AM +0100, Alessandro Zanni wrote:  
> > > Running "make kselftest TARGETS=net/forwarding" results in several
> > > occurrences of the same error:
> > >  ./lib.sh: line 787: teamd: command not found
> > > 
> > > Since many tests depends on teamd, this fix stops the tests if the
> > > teamd command is not installed.
> > > 
> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > > ---
> > >  tools/testing/selftests/net/forwarding/lib.sh | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > > index 7337f398f9cc..a6a74a4be4bf 100644
> > > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > > @@ -784,6 +784,7 @@ team_destroy()
> > >  {
> > >  	local if_name=$1; shift
> > >  
> > > +	require_command $TEAMD
> > >  	$TEAMD -t $if_name -k
> > >  }  
> > 
> > I saw team_create() has `require_command $TEAMD`. Is some test called
> > team_destroy() before team_create()?  
> 
> Actually, the errors seem to raise in the "cleanup()" method.
> 
> So, first, during the test preparation the "team_create()" method is called
> and checks if teamd is installed. 
> When it fails and skips the test, the "cleanup()" method calls
> the "team_destroy()" that raises the errors.

Actually, maybe we're better off switching the team handling to the way
REQUIRE_JQ REQUIRE_MZ etc are handled? That way we'll validate and exit 
when lib is imported / sourced.

Petr, do you have a preference?
-- 
pw-bot: cr

