Return-Path: <linux-kselftest+bounces-40055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FCB383F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A43916A047
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A7335BBB;
	Wed, 27 Aug 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgun3t+j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CC3FE5F;
	Wed, 27 Aug 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302400; cv=none; b=EA5939BXxQKRrdZnpoNrRkAVQu9Okf3T5K9UjnP4LdWecDq/yt0dV+4EVycSzYrgg5OjW9NWkIJVBLy43VkIGz3xZl5+l/aHUaheHB95Gu4ReH/R+mwZf2nwBHH2+BtzlnVRDLrEf0yFz2rYwEkBzJJzOTatQqUPQndmSiksV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302400; c=relaxed/simple;
	bh=ABbdD6yXiVtlSO5sN6EoHkrH1qwzdeNHbiyk7uPLQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLNrgrXP08rFrPYoV/kbvDHvIizaSqVCZKhGuTx+EEW20XhHsjK+GzZVqr2+tq13QyMnFYYRB5huir/0LwZO9Odh8ywJIU2jmdO0UlMEksrPPRoOsxRZANGgdl8nu+fbay061w8TDE5UFVy9xWJx5K1pIxS3QznWR6UJvybZXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgun3t+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EE1C4CEEB;
	Wed, 27 Aug 2025 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756302399;
	bh=ABbdD6yXiVtlSO5sN6EoHkrH1qwzdeNHbiyk7uPLQxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qgun3t+jcovWILqlrziWMu49Xw6zj5VkZhDSE4JydACQOjWc/+qqzIAHCX3g02Dgi
	 9byl/qVB84xC/mlAejIrlD9npfldc+PzsW53DGGQHefKx3Zp/ff7WJYDcRXSPFDBE/
	 lj9AMcjhyWEn+/FpOLX2Lpf+6EjGu9LB8y/Wu+5fVbmZHWsSxQRzLmRMsctxxx42xe
	 UWfL54HZZNsIDn4XGTIFexIIxhccCFKwflJppI5PiIC3OVIZ4taqG6qwZrKrU/jmJ2
	 Ni1ZylroYym1fRO4/fCbPTWmBIOowJ1HzqnN4w5ySh0Mf1bFyUEcsMvf5xYf6jV3HW
	 u7sLZXe5yfcAQ==
Date: Wed, 27 Aug 2025 06:46:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Petr Machata
 <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 3/3] selftests: bonding: add test for LACP
 actor port priority
Message-ID: <20250827064638.6fc32630@kernel.org>
In-Reply-To: <20250825064516.421275-4-liuhangbin@gmail.com>
References: <20250825064516.421275-1-liuhangbin@gmail.com>
	<20250825064516.421275-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 06:45:16 +0000 Hangbin Liu wrote:
> Here is the result output
>   # ./bond_lacp_prio.sh
>   TEST: bond 802.3ad (ad_actor_port_prio setting)                  [ OK ]
>   TEST: bond 802.3ad (ad_actor_port_prio select)                   [ OK ]
>   TEST: bond 802.3ad (ad_actor_port_prio switch)                   [ OK ]

The last case failed twice since posted:

https://netdev-3.bots.linux.dev/vmksft-bonding/results/271601/8-bond-lacp-prio-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-bonding/results/271601/8-bond-lacp-prio-sh-retry/stdout

