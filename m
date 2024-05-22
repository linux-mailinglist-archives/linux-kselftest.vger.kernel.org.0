Return-Path: <linux-kselftest+bounces-10576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF718CBF52
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E8C1F21811
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B983681AD0;
	Wed, 22 May 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNZNIkR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15C405CC;
	Wed, 22 May 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374235; cv=none; b=lfyxnfUzP6dmym/gT1hw9BplsVzaMZ696qmcDQHVR2pEakDYVpEcTahUJAxRwTK61B44fi1hpVIrI+2o/eIyVTHRnlzzzkwZd1RqKmfzlm3U0LIf6zh7yHs+fm15f0+1ajWjCUyIKuA5VJO7rRGwqVdxNqG7hpTZNFzhGYJXI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374235; c=relaxed/simple;
	bh=Ykp2g09jiM5kxlHcqZHsB+1ntvnztoi32uHOzut/lag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSTRpM8nesspovZiaQCYIa4N5aSFq3sAmi/GeFplGpBkmx/QzPvnCwhahICvzKfrcdwJvOeITc5iUK+6ofgnsY9G2WIdrpcrNWBcE0tTkDarBh/Mlsni7QmBupBKpFe41DBMNPQ37hbR4M3VyjQEU0Z+gfSddLjxymzKyGatYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNZNIkR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293C0C2BD11;
	Wed, 22 May 2024 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374235;
	bh=Ykp2g09jiM5kxlHcqZHsB+1ntvnztoi32uHOzut/lag=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YNZNIkR3pMcWC7CHmEitTbuy6+e/0RxOQH60XkbeIN0+0V10VVE5kwgmCQ3z/+Ug+
	 ouO5R4CcCBCnWgEd06F05PbQ7FhsEuqSO3yCP9CCceMmzRhJpu5fmqB9Ff80mVAWcV
	 xt/JbXdvUwJYCpL6PRIH//vv8pMEHT9PQMQ3RIp1DWy+p1M2C4/kx1wZ/TK9jQkKZ5
	 wNgFBKVXXMRt4m9dsy7bbHKhYUItaTIbT819MaVa6VV9yFD7AAHcyeb7KoegjG7LZp
	 uZA5mXxNHtGA9wMQSGEhq7f1kgc+bMraaJzl1920Xy4c+Af6W+zhapAj18rn3tQhvB
	 9LJm0oipMx/zg==
Message-ID: <9226ca162cc2f4717d7777aaa9379adc5a1437f7.camel@kernel.org>
Subject: Re: [PATCH net] selftests: hsr: Fix "File exists" errors for
 hsr_ping
From: Geliang Tang <geliang@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,  Geliang Tang
 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Wed, 22 May 2024 18:37:07 +0800
In-Reply-To: <Zk1g6CRsvSids1Vs@Laptop-X1>
References: 
	<db256340b909f8b6f8bb7f9e42dbe71c228993b6.1716280848.git.tanggeliang@kylinos.cn>
	 <Zk1g6CRsvSids1Vs@Laptop-X1>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-05-22 at 11:05 +0800, Hangbin Liu wrote:
> On Tue, May 21, 2024 at 04:49:44PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The hsr_ping test reports the following errors:
> > 
> >  INFO: preparing interfaces for HSRv0.
> >  INFO: Initial validation ping.
> >  INFO: Longer ping test.
> >  INFO: Cutting one link.
> >  INFO: Delay the link and drop a few packages.
> >  INFO: All good.
> >  INFO: preparing interfaces for HSRv1.
> >  RTNETLINK answers: File exists
> >  RTNETLINK answers: File exists
> >  RTNETLINK answers: File exists
> >  RTNETLINK answers: File exists
> >  RTNETLINK answers: File exists
> >  RTNETLINK answers: File exists
> >  Error: ipv4: Address already assigned.
> >  Error: ipv6: address already assigned.
> >  Error: ipv4: Address already assigned.
> >  Error: ipv6: address already assigned.
> >  Error: ipv4: Address already assigned.
> >  Error: ipv6: address already assigned.
> >  INFO: Initial validation ping.
> > 
> > That is because the cleanup code for the 2nd round test before
> > "setup_hsr_interfaces 1" is removed incorrectly in commit
> > 680fda4f6714
> > ("test: hsr: Remove script code already implemented in lib.sh").
> > 
> > This patch fixes it by adding a new helper delete_hsr_interfaces()
> > to
> > delete all interfaces before "setup_hsr_interfaces 1".
> > 
> > Fixes: 680fda4f6714 ("test: hsr: Remove script code already
> > implemented in lib.sh")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/hsr/hsr_ping.sh | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh
> > b/tools/testing/selftests/net/hsr/hsr_ping.sh
> > index 790294c8af83..0be1d5f78dab 100755
> > --- a/tools/testing/selftests/net/hsr/hsr_ping.sh
> > +++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
> > @@ -166,6 +166,14 @@ setup_hsr_interfaces()
> >  	ip -net "$ns3" link set hsr3 up
> >  }
> >  
> > +delete_hsr_interfaces()
> > +{
> > +	echo "INFO: delete interfaces."
> > +	ip -net "$ns1" link del ns1eth1
> > +	ip -net "$ns1" link del ns1eth2
> > +	ip -net "$ns3" link del ns3eth2
> > +}
> > +
> >  check_prerequisites
> >  setup_ns ns1 ns2 ns3
> >  
> > @@ -174,6 +182,8 @@ trap cleanup_all_ns EXIT
> >  setup_hsr_interfaces 0
> >  do_complete_ping_test
> >  
> > +delete_hsr_interfaces
> > +
> 
> nit: you can also just re-setup the namespaces, which will delete
> previous ns
> and create new one. e.g.
> 
> setup_ns ns1 ns2 ns3

Thanks Hangbin, "re-setup" is much better.

> 
> >  setup_hsr_interfaces 1
> >  do_complete_ping_test
> 
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

I'll send a v2, with your Reviewed-by tag.

-Geliang


