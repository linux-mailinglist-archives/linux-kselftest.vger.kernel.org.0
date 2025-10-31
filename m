Return-Path: <linux-kselftest+bounces-44520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE346C257D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570915610E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37434B687;
	Fri, 31 Oct 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJi3phsT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096D21FF25;
	Fri, 31 Oct 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919592; cv=none; b=tpXxb6P/EhBA228q3UqT4epeMZBdLSww82c7Q2s+osgJTaG4SMaSgTZd+cNNe6kPwV1Ch76hyZEVsMC0bKEcDX4Owtpn7dx66lHvivwqVuq2REKImRaLCNVXwsMZe539Te6YKVCiJWs6c1NlcQWm2X3/JfsxAyluej6O6+xQVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919592; c=relaxed/simple;
	bh=mg/BfrVx0H6DIgjvX7SYssHp/Rl5Ia8S1SAoha1sRSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC6/5B4C+qK2cmNykwHzFyKEhPbFjOmZ+UKP5Bnb85MF4Qll9+f78OYvrSIo/Vc6QxFLFmoxDqcLUfQXRIbPKjAUbL/J0z1aU+sqezty3XLfFrNuvZMhVF1mvhB5buMvdIPFwObY7tgAo4hhJF/seHn9u8vbUFtch7Gt38y1dCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJi3phsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5529BC4CEE7;
	Fri, 31 Oct 2025 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919591;
	bh=mg/BfrVx0H6DIgjvX7SYssHp/Rl5Ia8S1SAoha1sRSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TJi3phsTNrGxKXy+hXcyMs5QgXJjMdWmHVA3kLEO8NXWRIuTbrfIxU6kXYfLFaEbC
	 Im01dqsTsMVNcJOEq80Nmj0hpl018VqlJdkMYGvDQ/ce7K7C5nDVTWT/0yMimRhd0Y
	 cDy9dgWaTtfXVmhqGVKAgNWzupscBq+JCKLNZ0l8EBerC+ArLNxgiEMIUYSXb/b3OP
	 6RpEIxGEAk1Vw59+LH7AV3pK8XpF4jBuK1qrrbI3bNRJrVWcZWh9OP+3enKBqeC8sV
	 G8Zb2iQsNnEaEdf9DLd3qHe1VUmYqKnquTG5fZMzTfp7EhlFqt3+Cid0NThvahsiRb
	 wo3XPqnbLTf3w==
Date: Fri, 31 Oct 2025 07:06:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
 <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
 <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: Re: [PATCH v5 net-next 00/14] AccECN protocol case handling series
Message-ID: <20251031070629.38b05909@kernel.org>
In-Reply-To: <PAXPR07MB798409CBEC44A185BD40ED42A3F8A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
	<20251030175650.69d77ddd@kernel.org>
	<PAXPR07MB798409CBEC44A185BD40ED42A3F8A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 07:32:27 +0000 Chia-Yu Chang (Nokia) wrote:
> > Is this a pure repost or you changed something?  
> 
> It only removes one empty line between "Fixes:" and "Signed-off" - no
> error was reported when using checkpatch.pl, but an error showed in
> patchworks pipeline.
> 
> Shall I resubmit with v6 tag? Thanks.

No need. Just make sure to add the changelog each time going forward.

