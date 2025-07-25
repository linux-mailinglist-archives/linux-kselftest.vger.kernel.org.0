Return-Path: <linux-kselftest+bounces-37989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84540B11FFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD65F58397B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D401E834F;
	Fri, 25 Jul 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ0MslJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913291ADC97;
	Fri, 25 Jul 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453273; cv=none; b=n04jp4zwAzTsH8IIDz34oY3Lu5PHEAfq/b8KPaV8vZhIscCufJ2Icg+wL+cc74fTS/oTBKNHpkEPBGZacqYySLXaxLQGbdt+befAPJbkaGEWHITOaqoDkrb1lWUI0vmH5di1r67igQUVCeLnaJrzCDIKfRQ0gYS5NkpciAnzAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453273; c=relaxed/simple;
	bh=qOBzhdHXUMAKH9/SEbg5zcTYo1ip3m6nvd56DPH8fls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sS6uQoaHJi3DZdKcqf51bvG3E/WuhjLJMRzKpFci0MuXlRktxFxuxkQ+eeY85rfdKyrt6wYDRzMNZcZLiwoA8RLFpv7zHOfoV495pqn7sQngGbH8PIInsfn64sGsD7UoGo/Fj1gsAFUKLmPyMBHr+OJditCjg3JGZNO/BwcuCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ0MslJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D6BC4CEE7;
	Fri, 25 Jul 2025 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753453273;
	bh=qOBzhdHXUMAKH9/SEbg5zcTYo1ip3m6nvd56DPH8fls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OQ0MslJXYPd4zQklrpF953956qTK70VQd16mltsjV794cyVoNPRdMyzKxRrNMAJuP
	 5Gy5YhCyNF3Yeh0wAs+tLcchd9zQtiSnWM3GKvEr2uEelIAqsC4SaQBCFPuLlIF2XO
	 XB6VCAyyWUJteZ5jEV2Yc8gGKXrO8pTK+/OlHpn2UHQKo8IIQZNvPuP/ad2yo+idLi
	 GH3/ZcQcXa+raSiTdZ5ExwGe/UzcZlbmWhQ2rjztW+lpu43UlHsjOliMnv8bQCjeiB
	 PDXsCcJ0R/dDsZuS6g2r+1/cH5zh15/34bKOGgZPYzojnP4ISNNG+Dqe6VEADblGZ0
	 wRNywJ5c90nEQ==
Date: Fri, 25 Jul 2025 07:21:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Petr Machata
 <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Alessandro Zanni <alessandro.zanni87@gmail.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
Message-ID: <20250725072112.6b3c4f83@kernel.org>
In-Reply-To: <20250725062848.18889-3-liuhangbin@gmail.com>
References: <20250725062848.18889-1-liuhangbin@gmail.com>
	<20250725062848.18889-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 06:28:48 +0000 Hangbin Liu wrote:
> Add a selftest to verify bonding behavior when `lacp_active` is set to `off`.
> 
> The test checks the following:
> - The passive LACP bond should not send LACPDUs before receiving a partner's
>   LACPDU.
> - The transmitted LACPDUs must not include the active flag.
> - After transitioning to EXPIRED and DEFAULTED states, the passive side should
>   still not initiate LACPDUs.

Strangely this test fails on a normal kernel build but passes with
debug options enabled:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-07-25--09-00&test=bond-passive-lacp-sh

