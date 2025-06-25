Return-Path: <linux-kselftest+bounces-35739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC2AE7ED4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70875A3F87
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184F2BD5A0;
	Wed, 25 Jun 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mphwUbRo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928F29B205;
	Wed, 25 Jun 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846264; cv=none; b=XJ+I4Veet3viZ8M2oQId0xK338OiDhOB0tUysKxmN/BAJIXP2fuOnbATjI9DIPZnmDVsJxSghRkZQfoTLi7c9AV88/M9KxLEm7C8mHvbH1c234PShJfP7hUvilwm9pLo+XwREEiR5NeLpjMd59D9svCqVRq3ZKmgvX89CyHPDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846264; c=relaxed/simple;
	bh=NwTJ5PPP27/rCSfWuv+FtUT/aFui2Wgz+XXfCohOF6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTrkk24bZWzSbjI3MS3aR/lwEHYALdmuGMf40lbEKaIhkVnexxY242MGhho4M3U1Xv2RBCKn/n2fkfeLV5ZF5EaefRQw/li8fbPeNwun95OiIeOBwt4i4iNzXIjVJe/Vq0UQvgMwN5zUSwjRUbgEn0vDtk7wF151w/s/bkhlB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mphwUbRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9551C4CEF1;
	Wed, 25 Jun 2025 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750846264;
	bh=NwTJ5PPP27/rCSfWuv+FtUT/aFui2Wgz+XXfCohOF6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mphwUbRoNuqPd1spfj2i4euFYm2aegLZg0nYHMQ9FvB2CfikTQfdR9a6Qm0Akrd0E
	 Xe4y4P9orJTeuJ/ojRBpSNDu0ymAjKL2/F9Fe/BUH+m101nx6V09UbWX6gaMxIrFMV
	 KNWgJxMGHk/7OMXk26aqz0EVhtQZsTCnhfKW5dBgKe64eQ+rNciTOYkrNjTYiNeF+D
	 /fBK2mMNa0foJcw+dVe/TkHPhQl8ioQHJaBxlGzCCrHU365l/W3Ka6awKOjA+MJ/2H
	 zvb+Zdpz967THwMiUVUFbVUFQOY4bSK8AUOrGZtnGJFKgNzCw2MkOYvvJFwtg4tRPQ
	 22nJAXGBRV73w==
Date: Wed, 25 Jun 2025 11:10:57 +0100
From: Simon Horman <horms@kernel.org>
To: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
Cc: Ferenc Fejes <ferenc@fejes.dev>,
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"pctammela@mojatatu.com" <pctammela@mojatatu.com>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"xandfury@gmail.com" <xandfury@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: Re: [PATCH v20 net-next 0/6] DUALPI2 patch
Message-ID: <20250625101057.GV1562@horms.kernel.org>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
 <6f880f49c2d9ef20ab087c6e9d1a6d6c8f6e500a.camel@fejes.dev>
 <VI1PR07MB5567EDDD3F6F999B7B082575B978A@VI1PR07MB5567.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR07MB5567EDDD3F6F999B7B082575B978A@VI1PR07MB5567.eurprd07.prod.outlook.com>

On Tue, Jun 24, 2025 at 01:53:31PM +0000, Koen De Schepper (Nokia) wrote:
> Hi Ferenc,
> 
> We spend a lot of effort on the tc version of DualPI2, mainly to share the know how with others as a reference implementation. I hope this tc realization can be accepted now. 
> 
> This shouldn't stop any other realizations (using other technologies) that can be done in parallel by people that are interested in those. The performance and correct functioning of those other realizations can then also be compared/verified with the tc DualPI2.

+1

