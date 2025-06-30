Return-Path: <linux-kselftest+bounces-36117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B7FAEE46E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194777A9E89
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79DC28FFD2;
	Mon, 30 Jun 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMqOArnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9C1BD9CE;
	Mon, 30 Jun 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300629; cv=none; b=igYy5Enopuyjcm4banJ+nHwmcPGiffkIhDUVhA3EcrGk30yN5VdEK7VmQ8OF2R9uyBwP2pVUvTT34GYVis60VXB4/iM/x6+ZBaEmqyMehE7AB+TTcBcq4KhQPWYvtM252YPScccmJi/Q7419WSA8WkNmZ2cgnoJ6PRLKrrlooh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300629; c=relaxed/simple;
	bh=306MnK3zdBbANH2fTCykMEEBXsRSy2zxEHJaHAHXWUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BneJkzw1ynL8avzARcrGRAZdv//Y6Di2v/hbk4zF+WYHN4EuadssKi/C+IvhPKelEg4hVzExeE94URfUqM+XlvHPiJJVoxwE4zuXOkJedUq9anJ5nTWZ9WHMLpScpiazI7QWiEx+eTFE1Qo21an8CqosseBIi2KSr4WtNUaC3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMqOArnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796ECC4CEE3;
	Mon, 30 Jun 2025 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751300629;
	bh=306MnK3zdBbANH2fTCykMEEBXsRSy2zxEHJaHAHXWUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMqOArnHDT1Zqjc27gRtI+rMslF3ARhezsl+jbML64oTsW9i6HrWF24X6vwYrIS2y
	 csmCTKx55lslwO2BfYVjnmqUiZohlkcN2euYmxajv5tR/Hhghz2lxc9Vd8kqGYDWlw
	 q6vZXkRlpKJbGbve5tQOZkiY4R8SnHjOoV5eEF3gdXGyuDl2xG0/WupggNPRSTgE5D
	 iocMSTAADzQarQOT72fcsdImtnnubC84wInuYiNjiqKW7UZQp8O2tYt5KhtcJMV4Bk
	 B9s01u/FQgb8SiSbKQ3PgNQpIuZXEnejqYgTwGsGfEAwFAO6fVxbQarKNDaUrqcVKu
	 rzavW79tic8YA==
Date: Mon, 30 Jun 2025 09:23:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
 "pctammela@mojatatu.com" <pctammela@mojatatu.com>, "horms@kernel.org"
 <horms@kernel.org>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
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
Subject: Re: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Message-ID: <20250630092347.7377b463@kernel.org>
In-Reply-To: <PAXPR07MB7984777E0A2438D287B4A3DBA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
	<20250627161930.385554c0@kernel.org>
	<PAXPR07MB79842E86F802F227C79C05F6A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630081222.528202d5@kernel.org>
	<PAXPR07MB7984777E0A2438D287B4A3DBA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 15:27:52 +0000 Chia-Yu Chang (Nokia) wrote:
> > On Sun, 29 Jun 2025 22:32:15 +0000 Chia-Yu Chang (Nokia) wrote:  
> > > I was thinking could we keep the same strucutre? As we already have 
> > > several rounds of review for both net-next and iproute2-next.  
> > 
> > Not a valid argument, uAPI is forever.  
> 
> OK, then I will replace "step_thresh" (NLA_U32) and "step_in_packtes"
> (NLA_FLAG) with "step_pkt_thresh" (NLA_U32) and "step_time_thresh"
> (NLA_U32).
> 
> Does it make more sense yo you?

yes

