Return-Path: <linux-kselftest+bounces-37990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172DCB1201B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CE11CC539C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C2123F405;
	Fri, 25 Jul 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4YgZ2A2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B21F0E26;
	Fri, 25 Jul 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453657; cv=none; b=QesejEBi1nxCFVTCn+IJZ5NyShsuKJqwy1dvxhzZWtoF6i9S3tdK2zWT7xEtJ7bBr8Ww2XU/yU3ZXlc/lqTmo4mY9LZadEojZTBURdyzAJqcfRnZkTemLHj/kVYjtZjHILf+cpfBzCdaqsfjIYJ8mMY7UfVSfy5GBySWeX6xzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453657; c=relaxed/simple;
	bh=mqwCd3pCZtqjfleIUz2MTJfCbDov6dL32aRctSoDosY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpVE2KHpGbc/Blm+5TkPtgps2H5WjL0tuXkYBsGhQgpt4rNBeXWiHFS3hLSGvUwLA3mTJkgLNpjP13T43K66XUllK57QA8M/P9nPHotIUF3xiPHOCnmZGfOHV3WQVvXTUWK9mOFkycw15w9pbmFFwJmIZyGr5pmbjj5kiY+aJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4YgZ2A2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F1AC4CEE7;
	Fri, 25 Jul 2025 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753453656;
	bh=mqwCd3pCZtqjfleIUz2MTJfCbDov6dL32aRctSoDosY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4YgZ2A26mSzRoGwQtEy5goLtF+06lFN4rgNqS/n6bRPWnVPIqyl7gli3cfEJEMCO
	 1o3/JoUaTaDd31EPmsjSHOlHgD/weBW0L8tk2O0VV253F7aG7uUzdz/ML1DsPXPtYj
	 i4GmxknVYbYRnPfLnkK75pNhnzGl5VmFhCaurQH7sCC3IydrOMO4FDvpYTVbPCPQtL
	 BZMBzJx0eMiiIG33Rir6ERifJtKy0H1KQ0iOlXeG07caeiULFIWQ7ZoY+wBjo4kPj0
	 +AN5OSlI2ouCdAybpqypPFE53UIYREE5k4Kk1eC+T0wGq/3n+U0P3cbqLZzkByJC6P
	 VuASGIh91MhtA==
Date: Fri, 25 Jul 2025 07:27:35 -0700
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
Message-ID: <20250725072735.536abf3e@kernel.org>
In-Reply-To: <aILp0UfIyC5-NYrM@fedora>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
	<20250724081632.12921-4-liuhangbin@gmail.com>
	<aIJDz3AgQtnzSR59@fedora>
	<20250724073501.1c0357c6@kernel.org>
	<aILp0UfIyC5-NYrM@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 02:20:01 +0000 Hangbin Liu wrote:
> On Thu, Jul 24, 2025 at 07:35:01AM -0700, Jakub Kicinski wrote:
> > On Thu, 24 Jul 2025 14:31:43 +0000 Hangbin Liu wrote:  
> > > Should I drop this selftest as it needs the new iproute2 feature that has
> > > not applied yet?  
> > 
> > No need, I'll add the iproute2 patch in the CI.  
> 
> Cool! Do you run CI for all posted patches?

Yes, the quick checks like shellcheck we run on individual patches,
but selftests get batched. I mean we collect patches from n hours
(currently 3) and test them all together.

> I just found that I forgot to rebase the code to latest net-next, which will
> have a conflict in include/net/bond_options.h... I see your email that the
> net-next is closed. So I think we can just leave this patchset for reviewing.
> I can post the next version after net-next re-open.

Right..

