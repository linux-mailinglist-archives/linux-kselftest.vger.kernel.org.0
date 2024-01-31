Return-Path: <linux-kselftest+bounces-3858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FB844534
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3721F2398A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864212BF1C;
	Wed, 31 Jan 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJwAgMef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6212BEB7;
	Wed, 31 Jan 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719924; cv=none; b=n05WNlzY19uApzAR5zHVBRp0f4ZCCwKNDqAO1BIEHn7v6EdSPbFUy08roysZ7OasU3ZZi3X17e5w8FkBHY5/U3iZGOuloqRhEmmYDsBcnJtRhB4hwB8TQ+3HoVzdbHK6PQKFb+oRS7R8FoZPYNSHpQBAeb3HnCYyijWfqn1g+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719924; c=relaxed/simple;
	bh=apKmdFeasx/n46RJjkvhzFtb/MkFti7bmqOveLrpMRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIrRDHHt2vz9dBUGzJAI81VX/cjVPvfzZCUt4OdSwZKKAmhhHymkkmxsCwy/yAK46pEmLJ3lPGMzqRxHb6ylWhZs0BtXDpW0bDO0fapOvEfwpH+ZYw8W66LxZ2xBUxMgdnt+6SLwm+reWLbc/j5WgIPC6186RUhxX1vHwQZHoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJwAgMef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845C6C43390;
	Wed, 31 Jan 2024 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706719924;
	bh=apKmdFeasx/n46RJjkvhzFtb/MkFti7bmqOveLrpMRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJwAgMefhiB4YdTc7DkbX6TagPi2hal816ViMdavF8fFK+q7CF1GEcAS2m6Ls0l6q
	 ErcfXNSeHsauCuh5T9EnHdN6HS+UAvOrzbWy2nptbtI34+iRtYMRdJgyEdIBJu2voM
	 +JqOpIuSIIFa3GnJWtEieBLNE59GqXY9QkCxV1OnYsEOr8GI0VW9Y+JJvsdq+qSROM
	 q22msuHeZB2sY2Ijw6Qnr8KQzB3GAzOL+6/+Fech36A1nKGaOAbwXJMusrpGtRw3tP
	 PR7TrAS6rCSkSPYVf1ne6qEpylCW9k0/t+hA3mBuaL6n8ndswU0LP1tWhwhJhilqgU
	 ibut1SUaVbgBQ==
Date: Wed, 31 Jan 2024 08:51:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias May <Matthias.May@westermo.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: add missing config for GENEVE
Message-ID: <20240131085159.21313974@kernel.org>
In-Reply-To: <20240130101157.196006-1-matthias.may@westermo.com>
References: <20240130101157.196006-1-matthias.may@westermo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 10:12:18 +0000 Matthias May wrote:
> l2_tos_ttl_inherit.sh verifies the inheritance of tos and ttl
> for GRETAP, VXLAN and GENEVE.
> Before testing it checks if the required module is available
> and if not skips the tests accordingly.
> Currently only GRETAP and VXLAN are tested because the GENEVE
> module is missing.
> 
> Signed-off-by: Matthias May <matthias.may@westermo.com>

I reshuffled the option to sort slightly more alphabetically,
added a fixes tag and applied to net, hopefully this will help
folks testing stable.

Thank you!
-- 
pw-bot: accept

