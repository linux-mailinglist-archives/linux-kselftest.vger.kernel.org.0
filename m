Return-Path: <linux-kselftest+bounces-15905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CC95A51F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FB9B2108B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B3F16DEC3;
	Wed, 21 Aug 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjREyH91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DF79CD;
	Wed, 21 Aug 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267498; cv=none; b=GA1bLdMmdU1coDBZBhShukqhcLuKC81U2p8zCZ2Tfjw0/EbIL11yEnlyoXHDI+/1Z2FHGWxqkqGKWmV8Nd3OmeVypJoL6MT0FVxAIfkLLSGm4ZnojdlpGscGGIDt90NKDIL0IH9uFuzVAJ4BFa4ujwoR4PF1a8/3ZIHULtVsJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267498; c=relaxed/simple;
	bh=VS4isC8wAxpYzYpfppti/HPw1YUm5zFlKprIAEzxoao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXsdH4pIFJwj12rs4c8rJPOzUgdAHvlhYKS5OwSif/U1Wf/mK3GwvmRP1g1/goZenjaC+ST9TzMLFe517Z8xT+4ZIkXxa6fxkDfd2d8HB6kCfkBLcM1R/LQtPCU2MiMTwxtRjx7BI2DxFljYGZ8qNJ5obWoRnnOhYzy7x6aKX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjREyH91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD380C32781;
	Wed, 21 Aug 2024 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724267497;
	bh=VS4isC8wAxpYzYpfppti/HPw1YUm5zFlKprIAEzxoao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjREyH91EH7uZDI5Nf5yLCnnr0wIDCzUtz+rJR0ibuv3MLK6+Sm1o0t1Lxx9oOIdN
	 niam4cDB0XytexAzuWPNhUZ6YxxIV+dZ6rWfQ7yoVZBwJnGCBOFKFF2zzImSsEEL40
	 corrfTfUauqPh5ek2R3JAbg+oAFdpMqrm4ajyHKIiEYjsKAzodkwsdKE/5xkEl95th
	 PU5qcS6FrxgANSlYKFDhY/TdKdJ/ebojn0Jbws/SJI4FtHXNAEC0r+cr0iIVPFXAnw
	 vB2DERn+vKVjvIOB61abLkcxJntnxY6TGRyNdHA2mYNi5usQwAdd+HIAcyALo7LEog
	 zJFhKzVlCrDpA==
Date: Wed, 21 Aug 2024 20:11:33 +0100
From: Simon Horman <horms@kernel.org>
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] selftests/net: Open /proc/thread-self in
 open_netns()
Message-ID: <20240821191133.GG2164@kernel.org>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-4-7bd2e22bb81c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-4-7bd2e22bb81c@gmail.com>

On Thu, Aug 15, 2024 at 10:32:29PM +0100, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> It turns to be that open_netns() is called rarely from the child-thread
> and more often from parent-thread. Yet, on initialization of kconfig
> checks, either of threads may reach kconfig_lock mutex first.
> VRF-related checks do create a temprary ksft-check VRF in

nit: temporary

     Flagged by checkpatch.pl --codespell

> an unshare()'d namespace and than setns() back to the original.
> As original was opened from "/proc/self/ns/net", it's valid for
> thread-leader (parent), but it's invalid for the child, resulting
> in the following failure on tests that check has_vrfs() support:
> > # ok 54 TCP-AO required on socket + TCP-MD5 key: prefailed as expected: Key was rejected by service
> > # not ok 55 # error 381[unsigned-md5.c:24] Failed to add a VRF: -17
> > # not ok 56 # error 383[unsigned-md5.c:33] Failed to add a route to VRF: -22: Key was rejected by service
> > not ok 1 selftests: net/tcp_ao: unsigned-md5_ipv6 # exit=1
> 
> Use "/proc/thread-self/ns/net" which is valid for any thread.
> 
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

...

