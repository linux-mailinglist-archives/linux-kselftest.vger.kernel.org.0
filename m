Return-Path: <linux-kselftest+bounces-15424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242E95379E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8891C245CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39691AD9FB;
	Thu, 15 Aug 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQiuTurO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3115E88;
	Thu, 15 Aug 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737014; cv=none; b=M/yC4GfqvozApulbcE0ponq66iczJAvJPgtfZbervSAz6rvGKFC+tsioOMgS96DGqhOJbPs5lbJrgKSr4h0nXBN9/G9bBAkWaB/WhKbJmiuFkt2kHTUhH2GKjEAMnTteXoPiCDDJxpPEscjTjSQQpMtLhL1Ho9D1p0qr8abvv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737014; c=relaxed/simple;
	bh=xN7UdZrI0x2sSwbrhbNFyqv5rQaHms9/rajWM/qikRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzLLbtnVWlPLQ/v8Zqfe8V1iiK1T1DWm/WUfaViyAsxIu+LCcFKD0IR6Nh87DI3X8eEUYtha9ume+27pk8VJGtiQIPBt0sIiLGBorqhIsMV+UOImC/SR42uY/EHlwZYzfcgX324kL0ElM/+4j9qRkWdfsI1+9NkhXyKNagtd2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQiuTurO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA46FC32786;
	Thu, 15 Aug 2024 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737014;
	bh=xN7UdZrI0x2sSwbrhbNFyqv5rQaHms9/rajWM/qikRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQiuTurOYvuoI1KRGYJYqmsfOEuf0rl9jFywmsfiy6GmUh3Fp6fIrwxku7H8EvOMD
	 CuTieCONOnKJQ0cw0tLPy7X7Vs3qIaeUP3m8Wzz5b1FODZ0VHh457wYgs5w8i1DQ8h
	 yzPupHAe7fim7a9Gro546sB0IkSdXa0NytmPBgPKwucPAZHXg6rxwQse6fUXgmD6Wo
	 /4AD9ZjQjMiJo7p0IAMxTdspbn3+F/yGdMtbcs07DjBMosHQx5EljlmO6cpqe+eKON
	 qhjKBHPMCzeT+aR8MQRZ51JGRkWN7d/sKJmxzq35rOuHU8vg+rHyjJ0sTS269FY46z
	 fLUNw8zPAyv+A==
Date: Thu, 15 Aug 2024 08:50:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH net v6 0/2] Enhance network interface feature testing
Message-ID: <20240815085012.01edb574@kernel.org>
In-Reply-To: <20240815110442.1389625-1-jain.abhinav177@gmail.com>
References: <20240814175748.35889b6d@kernel.org>
	<20240815110442.1389625-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 16:34:42 +0530 Abhinav Jain wrote:
> > > One more:
> > >
> > > tools/testing/selftests/net/netdevice.sh: echo "SKIP: $netdev: set IP address"
> > >
> > > I think the SKIP -> XFAIL conversion should be a separate patch (for
> > > total of 3 patches in the series).  
> >
> > P.S. and please change the subject to [PATCH net-next], it's a net-next
> > change, not a net fix.  
> 
> I have sent v7 now with net-next instead of net:
> https://lore.kernel.org/all/20240815105924.1389290-1-jain.abhinav177@gmail.com
> 
> For set IP address part, I have added logic to XFAIL if veth pair was created 
> and to SKIP if that's not the case in third patch of the series as directed above.
> 
> Right now, there is no logic to set IP address in the script for normal interfaces
> either and it is a TODO as well. I will focus on it next after this one is applied.

Minor note, please keep your guidance on frequency of reposting in mind:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

