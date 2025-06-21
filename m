Return-Path: <linux-kselftest+bounces-35540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7754DAE2938
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924727A31C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A29182BC;
	Sat, 21 Jun 2025 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raOarjOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7EDDC1;
	Sat, 21 Jun 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750513883; cv=none; b=HNScdm1sKVnor1UKW0QxkL8cDcxzfBCU1D9xo7fAZnYEgJeNqXbKSzEV98xsfTjvJHDU0YuWhd/b7+j7zKZhZBittjXeSl57jJsbUguk9fjxC9oJYkvceBqiryPeHURfeAqk6ixRpXKWv5MwKelqU37bEiofixPidt1EBhj3UP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750513883; c=relaxed/simple;
	bh=3QbgTsGgkQlH7378Yf3ycRQ+kZiBFzQcoRQrL4I0uZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNNtidJyGLT/CgTJ42pRp4EY3FI44x0Aws/Z+h+yboFSXapWsYn2htuh5SjFr9aH0kAFMkd+40SX0LfcBJxmuvbXbEPFiErw4IuPa0vaKrslotfmPqJseRFmVsLfNdktEON4FKUrNvCuyv1gA60kRp8owc37kGYvQ5A2BM1qe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raOarjOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CD1C4CEE7;
	Sat, 21 Jun 2025 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750513882;
	bh=3QbgTsGgkQlH7378Yf3ycRQ+kZiBFzQcoRQrL4I0uZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=raOarjOKg8rjKBsKPoNTyd7Dk951Ywp2471mwmLSu0W8028h1ibAvBmrPHbedMuSE
	 EoBaQew/HUinbCgsaB9e1HrJwGCjmri1q+21l3M81h84jJb187303flfFIRb3Zk0W1
	 gafeJ8xIR1naKdYq+6wSw5dOo1YUeTCfidkG8r8Z1LhaPzsUUAZ7yBrgnr4joQqv66
	 i/UlMSrnBQCu2j/B51nLzlL1eCrZYPrufiJzodbiBNprQclU2E1AwrGkuow3I5ZQgy
	 eDnFCLacBvOCAhJOW9kBYzKL4VClSMr0euv9UwfF6HznAACBsoQh1P/F72XBjkgt/1
	 CA+uhR9vlK/4g==
Date: Sat, 21 Jun 2025 06:51:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250621065121.78701641@kernel.org>
In-Reply-To: <aFUeT8HSPYiDyALB@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
	<684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
	<aEwd9oLRnxna97JK@gmail.com>
	<20250613174233.0dd5e7c1@kernel.org>
	<aFUeT8HSPYiDyALB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 01:39:43 -0700 Breno Leitao wrote:
> > FWIW you can steal bpftrace integration from this series:
> > https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/  
> 
> Yes, that would be great. I think we can iterate until we hit the poll
> path, otherwise we skip the test at timeout. Something as:
> 
> 	while (true):
> 		send msg
> 		if netpoll_poll_dev() was invoked:
> 			ksft_exit
> 		
> 		if timeout:
> 			raise KsftSkipEx
> 	
> As soon as your code lands, I will adapt the test to do so. Meanwhile,
> I will send the v1 for the netpoll, and later we can iterate.
> 
> Thanks for working on this bfptrace helper. This will be useful on other
> usecases as well.

Right, you're the second person I pointed that patch out to. Would be
great if someone could steal that patch and make it a part of their
series so that it gets merged :S But it's alright if you prefer to stick
to non-bpftrace testing for now..

