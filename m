Return-Path: <linux-kselftest+bounces-36784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8383BAFDC59
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD051BC7F0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54039ACF;
	Wed,  9 Jul 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYY7gRPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467511CAF;
	Wed,  9 Jul 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021040; cv=none; b=hIQhupziDqhe3bPdMoxb/UHRVAULELdW9N+PxiOSmQEqurZ1Q3YdBx8m5DVLnT1aa7zA49RjLTvhfwqF4bs7sj/QIuV+l4uUaAhysHfvWL6wcweEaKEEJNYX5euwIhSg/OI4YZ24+q6WnwFpDsjs5Uy49OuVhUOXUw9I1XVKhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021040; c=relaxed/simple;
	bh=IX+f5IYNiy4OuL+44U5och/XYwwWGit0ZCFaSU7M+Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2EgMjesGbe94Aacvbf8rwyGwFkyE8aDQLwGgcWGHOutXxm0MT2C6GJtkFfrlWP8a+ALDTIhBXdmze4nZNihDVbpRExC6M/JZD5jQVxO9jnB+JoMRPsOdvzeGY7VgHKlsfGdyOkvlAf3mBbKX8xYqc4F4Pq2c3+Rf19jtNkxeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYY7gRPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00316C4CEEF;
	Wed,  9 Jul 2025 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752021040;
	bh=IX+f5IYNiy4OuL+44U5och/XYwwWGit0ZCFaSU7M+Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qYY7gRPf2h34WRutsM2qs76Y9UlB4SfbWwoCZ4nl9d6e6cIK7oebAVZih0jvj09wn
	 lcgjoFcarRZup3rPU0+UmEHNFn5IuT7NQaO3rO4sXgFiqBsYDcrZKoFP8dhkBuFegY
	 LBHYuyoFWC8xCNx+w0c7o7BfnRkq5frR3zgqIrSvqNtwtsOt6J3azWU0wK6sstYfCc
	 svLcLCAAnj08qwIAKCrO7jQTF7XD2T0Bvp1z3DM53aA4UyWr7ktuHXTuC2R1PWFtAB
	 +et1Q/Mg7PnxdFv1Cz8x3l2hT1GuGgRhG9pYa5RXDkUpkkTZy4BluP2Q7qgxL0Zfmq
	 LkWiudQYkpvlg==
Date: Tue, 8 Jul 2025 17:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "alok.a.tiwari@oracle.com"
 <alok.a.tiwari@oracle.com>, "pctammela@mojatatu.com"
 <pctammela@mojatatu.com>, "horms@kernel.org" <horms@kernel.org>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
 <xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
 <jhs@mojatatu.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
 <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v21 net-next 1/6] sched: Struct definition and parsing
 of dualpi2 qdisc
Message-ID: <20250708173038.46d25979@kernel.org>
In-Reply-To: <PAXPR07MB798488E0305080CE891E8286A34EA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
	<20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
	<13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
	<PAXPR07MB798488E0305080CE891E8286A34EA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 20:22:23 +0000 Chia-Yu Chang (Nokia) wrote:
> The original patch looks like below, and I see the option is
> mandatory otherwise it will return -EINVAL.
> 
> Is this what you mean in your comments or you mean other things?
> 
> +       if (!opt) {
> +               NL_SET_ERR_MSG_MOD(extack, "Dualpi2 options are reuqired");
> +               return -EINVAL;
> +       }

To speed this up a bit across timezones -- I'm pretty sure what Paolo
means is that you reject the situation where user provides no
[TCA_OPTIONS] at the netlink level. But if the user provides an empty 
one its fine.

So normal config looks something like eg (indent means nesting):

[TCA_KIND]
[TCA_OPTIONS]
  [TCA_DUALPI2_LIMIT]
  [TCA_DUALPI2_TARGET]

If there is no TCA_OPTIONS you'd error out:

[TCA_KIND]

But if TCA_OPTIONS is empty you dont:

[TCA_KIND]
[TCA_OPTIONS]

Just return 0 instead of an error if TCA_OPTIONS is not there.

