Return-Path: <linux-kselftest+bounces-16468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8730B961904
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 23:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99051C22BA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901BD1D31A3;
	Tue, 27 Aug 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMyY3g16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62289156661;
	Tue, 27 Aug 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793043; cv=none; b=VR5dgopsOdVP6H/zsyu/Ch0qXCxgAOTkz32vfziS1mvT9RsPRWulXd0zHSy3mLG+TvUHUdXg/p80DX029AeeZHFT0R9PNkdcWpRgXl0v91n8+1HGR++8XcCqATtoDb3mJZ953M+GYo3UxIy2sjtq7zVGb6AZD0gdAX+VN1W1UZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793043; c=relaxed/simple;
	bh=Lg4iEMS7bS1Rv0HvbxACs1qOLdsM8mTeV3VcM50LMYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YX0ACTllNNus7VE2PH/REk7jOF3ctc1zTI2KJd0NhXr+wQK0+thLzIaXg7oxyYuK6jfQ61Fwf19t3YTNE7SlTMPQVKzkFDnm2awAhVWYpiPi8oytKL0q2asoht3/QDCeoFwhVPGSUKyaqOuYdW7fsgAoc3nIcskEYsdQeDU9L+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMyY3g16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D2C4E699;
	Tue, 27 Aug 2024 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724793042;
	bh=Lg4iEMS7bS1Rv0HvbxACs1qOLdsM8mTeV3VcM50LMYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GMyY3g16/EgYsToWiRA36+RaUBS23NlwnBFjtsglIhQhseOaRcjjoRT1Xy1PDfLsQ
	 ZK3mPnSHpCc4lt+RNPBBU3ObmSIcdUDr9OoaFXdtV2WJnxZAaguRhdttFBlY09FK1L
	 UguBfEWna9vBMugY8Flp7hk8gZXaBycI09p+r33hIdogMNciIZ9PmI0YSnwjA7MSSf
	 C4NM6DHc3WUCN9ICrp6bg/KAOURgaEKzS62cvZ8JXsW0DJbI2JSTo1oQqRyaqhvI3p
	 mtgAwNAS2C0CBguoOROycLl37D718EJHDjZHjV+Zg5jzS1zCS4cI2SybH5Nv7wdNSa
	 ef3LOWX7WAjFQ==
Date: Tue, 27 Aug 2024 14:10:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Mohammad Nassiri <mnassiri@ciena.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/8] net/selftests: TCP-AO selftests updates
Message-ID: <20240827141041.0c815dbd@kernel.org>
In-Reply-To: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
References: <20240823-tcp-ao-selftests-upd-6-12-v4-0-05623636fe8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 23:04:50 +0100 Dmitry Safonov via B4 Relay wrote:
> First 3 patches are more-or-less cleanups/preparations.
> 
> Patches 4/5 are fixes for netns file descriptors leaks/open.
> 
> Patch 6 was sent to me/contributed off-list by Mohammad, who wants 32-bit
> kernels to run TCP-AO.
> 
> Patch 7 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> the issue, but I hope it will fix netdev flakes for connect-deny-*
> tests.
> 
> And the biggest change is adding TCP-AO tracepoints to selftests.
> I think it's a good addition by the following reasons:
> - The related tracepoints are now tested;
> - It allows tcp-ao selftests to raise expectations on the kernel
>   behavior - up from the syscalls exit statuses + net counters.
> - Provides tracepoints usage samples.

Looks like we got no flakes over the weekend, so applying, thanks! :)

