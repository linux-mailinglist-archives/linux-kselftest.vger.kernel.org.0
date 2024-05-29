Return-Path: <linux-kselftest+bounces-10833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE48D3774
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F345DB2588E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C111CAB;
	Wed, 29 May 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTnEyw4y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61817BB7;
	Wed, 29 May 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988858; cv=none; b=bjapMWeQFWiEaqhtZZbK/GExOuOONhM9tjjgxBynl4c1kQwbP6RZhx0w3clX5H7JBChopscz+wlAQaxKTfbjiLfpR3PLMPjPzd2TDKHtd+bSPpaBNEoqS8gLkOhy/dwmz2XjsI8ljm65Qu0ntgU3FsBFde4CqscgIjN5+VdLPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988858; c=relaxed/simple;
	bh=h4qNSa/Xgp1wiN/CSulCke9c2s5mwDYQecyU4kT+C9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4HTvXY1Md2as5NQEZgIEUkmtIgFTYx8OLPvU2BbzTvBsu2XB3EuA5Hun8c5BY9tBCltN/4FkV0BH+Fn1x+g3zDkbP+baC2zu8F4eUeredJlQ7jjFYJWUiNkuWmh4qbwCL/nxisVfa1U+13pMjMij7kLQs/h7jbKcqEQypNL1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTnEyw4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E400C2BD10;
	Wed, 29 May 2024 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716988858;
	bh=h4qNSa/Xgp1wiN/CSulCke9c2s5mwDYQecyU4kT+C9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DTnEyw4ycRe4DMZJaVFSJsuWttV02mc2aldsrm44bQzMbIYbqlikQP0bZ00bw6/vh
	 bpQYr9/212vBDTPHL5xLZgsCFsl2F9a3JEpA9GnrEdiyjwGmu+49kD21M+T5mq9e+X
	 iQv3Eexl+V1nRTVyUix5mbQzBio/voNVdg+xEoI/ikIiKrTB8PQyYOOyQMIXCCW0gp
	 xxwmxow5xMtxlbnDVb+YsUJBD50EJ0w3FB82qrHhWdsEDW9dCKZeCCANRR9k1xyzH8
	 MV9Ovg2cPLBIUTaQ2eGsyd0a1sfR3eUJii3wssFdFwFIpWqH93TwyVzRyu+WuXf0WW
	 1dggP/pK9f4aQ==
Message-ID: <508155be8f2e76f2c8fc8f792b49cd511b9bad85.camel@kernel.org>
Subject: Re: [PATCH net v2] selftests: hsr: Fix "File exists" errors for
 hsr_ping
From: Geliang Tang <geliang@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,  Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Hangbin Liu <liuhangbin@gmail.com>,
 Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Date: Wed, 29 May 2024 21:20:52 +0800
In-Reply-To: <20240529144351.44719939@wsk>
References: 
	<6485d3005f467758d49f0f313c8c009759ba6b05.1716374462.git.tanggeliang@kylinos.cn>
	 <20240529144351.44719939@wsk>
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

Hi Lukasz,

On Wed, 2024-05-29 at 14:43 +0200, Lukasz Majewski wrote:
> Hi Geliang,
> 
> First of all - thanks for spotting and fixing this error.
> 
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
> 
> Interestingly, on the QEMU setup with -4 switch this error was not
> present.
> 
> Instead, the not re-initialized name space caused some subtle errors
> when tc's netns and netem were run (a few packets got dropped).

I got these errors on my Thinkpad T480 laptop, not QEMU. So I didn't
get the errors you mentioned.

With this patch, hsr_ping tests passed on my side.

Thanks,
-Geliang

> 
> >  INFO: Initial validation ping.
> > 
> > That is because the cleanup code for the 2nd round test before
> > "setup_hsr_interfaces 1" is removed incorrectly in commit
> > 680fda4f6714
> > ("test: hsr: Remove script code already implemented in lib.sh").
> > 
> > This patch fixes it by re-setup the namespaces using
> > 
> > 	setup_ns ns1 ns2 ns3
> > 
> > command before "setup_hsr_interfaces 1". It deletes previous
> > namespaces and create new ones.
> > 
> > Fixes: 680fda4f6714 ("test: hsr: Remove script code already
> > implemented in lib.sh") Reviewed-by: Hangbin Liu
> > <liuhangbin@gmail.com> Signed-off-by: Geliang Tang
> > <tanggeliang@kylinos.cn> ---
> > v2:
> >  - re-setup the namespaces as Hangbin suggested.
> > ---
> >  tools/testing/selftests/net/hsr/hsr_ping.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh
> > b/tools/testing/selftests/net/hsr/hsr_ping.sh index
> > 790294c8af83..3684b813b0f6 100755 ---
> > a/tools/testing/selftests/net/hsr/hsr_ping.sh +++
> > b/tools/testing/selftests/net/hsr/hsr_ping.sh @@ -174,6 +174,8 @@
> > trap cleanup_all_ns EXIT setup_hsr_interfaces 0
> >  do_complete_ping_test
> >  
> > +setup_ns ns1 ns2 ns3
> > +
> >  setup_hsr_interfaces 1
> >  do_complete_ping_test
> >  
> 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de


