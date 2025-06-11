Return-Path: <linux-kselftest+bounces-34746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF21AD5B15
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF71165D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10F1DE4E7;
	Wed, 11 Jun 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p82osuCq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F291DBB2E;
	Wed, 11 Jun 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657129; cv=none; b=YXCT6U1XcL/QNOOpBFBxu8PaBwgMbUP9I+3ISog3YWI9jtH/3sWARcIUJIi86wDouAngZTwZ48U8QdCnzqH1v/iKiKsPCqI6CyaoCxXP1GeUV3eKj7vI7zAD+nvIsGcvlAZpD0F+SZcxBEfmjaZmuffrmmt4uWd2dKEQsE4ZdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657129; c=relaxed/simple;
	bh=H+t9tjRHIA8C++mfzT7VcREpAeny7fShVlSpoU8v4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DARHNnDtF0f1660N2BOiMqDyjaYF+GziLvKW6KrU0EuhDVI3AnHuz3QhMZyEmZ0jgCfiprdgDWNSKHjBuiFm5zHyGPrNBawR25zP2G3IwlgFXf0p9QkJvrjsYioT8QUcAJuq5XtAUOPRLwe+7Q8qmKNfdDb93cVeJKRmkldDdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p82osuCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612AFC4CEE3;
	Wed, 11 Jun 2025 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749657129;
	bh=H+t9tjRHIA8C++mfzT7VcREpAeny7fShVlSpoU8v4qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p82osuCqBZ4/HlGpok9FUBqU59/SilHd1sQB/YyW42QYzZ3pNWP4EnKvF0mVW1ACf
	 6oT0eclprargf8NefenmN0WZ7yZKoCQzrx5iGxf7Yrbtp0WVy49eo7w8PYqL6SoYte
	 isy6F10pmv1xhVmfxqKR8Rr/zTwXv6mWgopH9SJRE2FNqeWE3rpvdPR1E8V82It5Pm
	 g0yNz5fSaulfE38vqEL+wNoVRiKAM1RiDzfq/7IfKl6FUZ4w3a+UEZmL15y1JbuQ8J
	 GrE54yOtRy4gyZ33YrD2yENDV+cfAUetTaGNZKh++VbTXiX1OcS7uJdfLiA4tEpmTl
	 XZxBrb5uNUn4Q==
Date: Wed, 11 Jun 2025 08:52:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
 linux-kselftest@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for
 ntuple rules targeting default RSS context
Message-ID: <20250611085208.42cb7271@kernel.org>
In-Reply-To: <1f1ecf24-9be1-4822-83f2-104420d39933@nvidia.com>
References: <20250609120250.1630125-1-gal@nvidia.com>
	<20250609120250.1630125-3-gal@nvidia.com>
	<20250610143225.7dde37a9@kernel.org>
	<1f1ecf24-9be1-4822-83f2-104420d39933@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 08:06:38 +0300 Gal Pressman wrote:
> > tools/testing/selftests/drivers/net/hw/rss_ctx.py:788:0: C0301: Line too long (103/100) (line-too-long)  
> 
> Are you sure you want to blindly break this line?
> It's a single string.

Yeah, if it's a string leave it be. This one is just a check, the other
one as a warning. Unhelpfully I don't see an option in pylint to add the
bad lines to the report so its a bit hard to tell at a glance. The long
strings and the lack of doc string in the main function are the two
checks that we are definitely okay to ignore.

