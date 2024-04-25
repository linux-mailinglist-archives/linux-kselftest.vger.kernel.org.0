Return-Path: <linux-kselftest+bounces-8829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C608B180C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 02:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D579C1C255E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030EA3F;
	Thu, 25 Apr 2024 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzGSqQIJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA421816;
	Thu, 25 Apr 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005002; cv=none; b=KlRvIg/EYWF2/4+MHWJAFqdQAdqHJOo9Ow08yiBrBeXi3228H/U5VhfmihqNCcz9QsspxH1ZA5PWuN+2qu8Y4IRy161Z4va6Z66yPc7N9RapakzG7ItMp5r1BsmvxZkhB+6531Arku7vfmEQkXknJ8UDmOdsLah2HD3cB+F7mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005002; c=relaxed/simple;
	bh=WbIAErx155OHROJyjjTEAtiQOif5dHzxJ/2nLoOUoVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVuRW41D5hmtcbwpWp2JiPTqo6sDXt85mjK44vSMbueFRYIYMmQz93+f/3UKCf2jUJSwqs/ONLaA/s9FprXcuj72fM+CeLANUsmfUCdP0W3xngCojboOlvGqPu6VCRnvNrK+6hip3MJXGVif1uCH8Fwcg2CzFFqIma3ElZOZz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzGSqQIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A7EC113CD;
	Thu, 25 Apr 2024 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714005001;
	bh=WbIAErx155OHROJyjjTEAtiQOif5dHzxJ/2nLoOUoVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WzGSqQIJYqVVmeR0Axg/A/1a59UPQAstvMECUJJMfi9jFPynFjQtyradhBzYRrxQG
	 Z5T9Bsea8kDdH6Z0YHs1Tkuyy+VrdMELSWyDy0ZuWZc3eM2dLzDWCl6b0O9LXWJNJ+
	 KIM4+IN/J0FiEcm1atseZC7zVkuDU44WarmCe2/Pt06EeQIBo67Zhw8UseJY+MXjfO
	 FTMzANnAba2dkmfiNqZ+bMd2KAJ+1LgLcQgaGwpoB4lVt2PrZZewbe3TGEDHzcIVMe
	 8rT1975sZaAsBjIBvyj1vU76pJqeZ2BAKkLpVs+ziEmV9cFxnrSG7y7+ipUHYjCR4Y
	 bE0NZrOtuPrOQ==
Date: Wed, 24 Apr 2024 17:30:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: selftests: openvswitch: Questions about possible enhancements
Message-ID: <20240424173000.21c12587@kernel.org>
In-Reply-To: <20240424164405.GN42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 17:44:05 +0100 Simon Horman wrote:
> I have recently been exercising the Open vSwitch kernel selftests,
> using vng,

Speaking of ovs tests, we currently don't run them in CI (and suffer
related skips in pmtu.sh) because Amazon Linux doesn't have ovs
packaged and building it looks pretty hard.

Is there an easy way to build just the CLI tooling or get a pre-built
package somewhere?

Or perhaps you'd be willing to run the OvS tests and we can move 
the part of pmtu.sh into OvS test dir?

