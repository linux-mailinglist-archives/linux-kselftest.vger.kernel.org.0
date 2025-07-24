Return-Path: <linux-kselftest+bounces-37948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C52DB10DB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EFA1C879D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0893D2BD58A;
	Thu, 24 Jul 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ+OyHSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FA291C16;
	Thu, 24 Jul 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367705; cv=none; b=G9ZINkimI7Umvy/QzQY+OmzKYf0aCgzpN7s98BZg8sRgA0kJjrPtzW+Nt/jB0xADZt9k3tH+T7nd5dAwOl6Zh7YXKnXAlZ3TpSORlZiuW+bFLjmv5kaMq4031Pgd3pDk8SnIKwYPDSzTwFsWqSwZuRHKR8eFEU68z6NCZhOad4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367705; c=relaxed/simple;
	bh=5psh7yEe3Xi6LRR7E6HhzRkflXNDxhFntpQpk6AAwdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxwStlMzo87tik6hkhOdpgViahmht2pJxB/y7DCypgvKbizc6Sed31lYhd1eXiW7b7WpnC+iSo2Vzp6WpHHCGNShODvvKZwvTsbOyzpwp/Gg0q9m9R1zaqeYIpim15gfnBwHSkvWjeCWmtT05UI3PSzgsyAOKrPOf2VaoGglwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ+OyHSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BDCC4CEED;
	Thu, 24 Jul 2025 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753367703;
	bh=5psh7yEe3Xi6LRR7E6HhzRkflXNDxhFntpQpk6AAwdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZ+OyHSB/aTgsSKk4Vjwoz7QzsfA04RxX0KPmLW5a3BR4j6N7aiaF8wO3mNFYM1h9
	 uMes4Nr3pK3P0P7sWQOB/KM97Jc6krkxWhbe65Zv9Zd78Z/9tR5aXUcRILHVneOKqo
	 c5fEBNXqFVcZT/7w1ZMEABMYgf0R8t6whS9ccKs8CndP1fSFXNm/IRDp5HHMJUinYL
	 O2POlvnMhT7aepTdc16aohCf2Tv06SbPZA+KU9IYbCQAY2CFgDtcnwfNWgtLiaxVMg
	 +6FMSg5GKeiLLFDxi9KdJgbuUWM3BYTApit2XWt1tkeOwwn4bs+WYxBAN4xI5rvHR6
	 6Eb6pmQNjrDMA==
Date: Thu, 24 Jul 2025 07:35:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>, Amit Cohen
 <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Alessandro
 Zanni <alessandro.zanni87@gmail.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: bonding: add test for LACP
 actor port priority
Message-ID: <20250724073501.1c0357c6@kernel.org>
In-Reply-To: <aIJDz3AgQtnzSR59@fedora>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
	<20250724081632.12921-4-liuhangbin@gmail.com>
	<aIJDz3AgQtnzSR59@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 14:31:43 +0000 Hangbin Liu wrote:
> Should I drop this selftest as it needs the new iproute2 feature that has
> not applied yet?

No need, I'll add the iproute2 patch in the CI.

