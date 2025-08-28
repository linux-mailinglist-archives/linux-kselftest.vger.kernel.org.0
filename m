Return-Path: <linux-kselftest+bounces-40119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73315B38F9C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C331B2351B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C36E1798F;
	Thu, 28 Aug 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb7L0Oo6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16512B73;
	Thu, 28 Aug 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339966; cv=none; b=U7tvsXbjAY93AbJn86MfypbxAsgQzUu1aJqfmDx+jKiEyuiRlXrVxtsRP1jdZcIX2xaJzZKepsrC3SjBRs5eouMfxCxRvmN1epDxLbfGH+ewuEkG26oRnwRHD08UU9JA52+pm0GE7vmr3othXjHisF8S1RgFYSRJrjLO6QaxoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339966; c=relaxed/simple;
	bh=xCDAwDY5Vrgtw4wfBdOE2Yu4K+viAWMY83889gyo8lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0D/VqqH81Xqxh1CglG8B/0yaQzhRUCZo1Y7EpVI67OcxT0SX68oQtJe6LS9I6NPjn27G+mS4GVvdO2PKDIkhCvVkNOTjl2YxhCcwa5LASeJIBB/7sDiKGTCnC5QqrLR1ZOdlqL5lFVopyEp6oV5P2zcnAELpUWSYZd0shHj1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb7L0Oo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC62C4CEEB;
	Thu, 28 Aug 2025 00:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756339965;
	bh=xCDAwDY5Vrgtw4wfBdOE2Yu4K+viAWMY83889gyo8lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xb7L0Oo6KqZdkBkm26fYqus/ec8UyE5F3n7+0gVYYsDhxvTYsUXhC1WlG0Xc3EHQM
	 xaVe+5KxdMnUAXqadhQJL7lmhwKfdnmWJyVFhqktEhghafQcQQ40WGBKeF9z+TAr7J
	 013IZQ7qOTs3WWnsgd/7HGyhHJY0zlTPhy6OV50cqwpjsxibqqqdQrPyKHV9xpK6wA
	 3b9a7lzQ0Uze7MDQacJXuNJm4bkuetPCDX1COmdXasyHv/Bz9hklPQ3mgoeIau+2Ox
	 8xANcA8Su5ROv7iMeO0MZju3tRC3wwRl/TQk2oAQNTWoD/VAfDHSrZ3qYqf5LQ6mKC
	 3i60ZOYjfjSbA==
Date: Wed, 27 Aug 2025 17:12:44 -0700
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
Message-ID: <20250827171244.61d3ecb3@kernel.org>
In-Reply-To: <20250827064638.6fc32630@kernel.org>
References: <20250825064516.421275-1-liuhangbin@gmail.com>
	<20250825064516.421275-4-liuhangbin@gmail.com>
	<20250827064638.6fc32630@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 06:46:38 -0700 Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 06:45:16 +0000 Hangbin Liu wrote:
> > Here is the result output
> >   # ./bond_lacp_prio.sh
> >   TEST: bond 802.3ad (ad_actor_port_prio setting)                  [ OK ]
> >   TEST: bond 802.3ad (ad_actor_port_prio select)                   [ OK ]
> >   TEST: bond 802.3ad (ad_actor_port_prio switch)                   [ OK ]  
> 
> The last case failed twice since posted:
> 
> https://netdev-3.bots.linux.dev/vmksft-bonding/results/271601/8-bond-lacp-prio-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-bonding/results/271601/8-bond-lacp-prio-sh-retry/stdout

Looks like it may have been a one-off.
Let's see if it happens again while we wait for reviews.

