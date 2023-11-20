Return-Path: <linux-kselftest+bounces-290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484F7F0DC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4771F222AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CD7479;
	Mon, 20 Nov 2023 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcJ9DPOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9206FAD;
	Mon, 20 Nov 2023 08:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13542C433C7;
	Mon, 20 Nov 2023 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700469729;
	bh=fLc5vRlCd94li3PsvI3TLAtWvXpeLlLbzMXnMlcIdI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcJ9DPOgFkqPd7ZJjvJ2Qr6UnvMDCu7Zuc/oJqUVY6BTzNPb5buqv26BDe0TtDK6p
	 kSO/Xr1IwDi0B3kVDdJSpQeNFV4gaB2au8VC50tp48ZM4j5g9yCVj2RZ/G8+2VU9lv
	 4nr20aovcyOcZCPqgYBYsxfJNvbA+HX6w5mAP83MQwuA4YgS9Z37Llnc+JgY0p3AYK
	 U5VEL4PX/Cx8eCNNyWeng2gwTYpDMf5BLk14ZWvD0+uQXJgS6IvPcKVYjQ5E6nE4fX
	 m5b77KdG8BsnqY+OB7H2zWt7YQbTCo3W5kuZIo6pSm45XXmVMv6+QQvKhi/ukca3Oe
	 WnhgmYemLbrKw==
Date: Mon, 20 Nov 2023 08:42:05 +0000
From: Simon Horman <horms@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] selftests: net: verify fq per-band packet limit
Message-ID: <20231120084205.GI186930@vergenet.net>
References: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>

On Thu, Nov 16, 2023 at 03:34:43PM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Commit 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR
> scheduling") introduces multiple traffic bands, and per-band maximum
> packet count.
> 
> Per-band limits ensures that packets in one class cannot fill the
> entire qdisc and so cause DoS to the traffic in the other classes.
> 
> Verify this behavior:
>   1. set the limit to 10 per band
>   2. send 20 pkts on band A: verify that 10 are queued, 10 dropped
>   3. send 20 pkts on band A: verify that  0 are queued, 20 dropped
>   4. send 20 pkts on band B: verify that 10 are queued, 10 dropped
> 
> Packets must remain queued for a period to trigger this behavior.
> Use SO_TXTIME to store packets for 100 msec.
> 
> The test reuses existing upstream test infra. The script is a fork of
> cmsg_time.sh. The scripts call cmsg_sender.
> 
> The test extends cmsg_sender with two arguments:
> 
> * '-P' SO_PRIORITY
>   There is a subtle difference between IPv4 and IPv6 stack behavior:
>   PF_INET/IP_TOS        sets IP header bits and sk_priority
>   PF_INET6/IPV6_TCLASS  sets IP header bits BUT NOT sk_priority
> 
> * '-n' num pkts
>   Send multiple packets in quick succession.
>   I first attempted a for loop in the script, but this is too slow in
>   virtualized environments, causing flakiness as the 100ms timeout is
>   reached and packets are dequeued.
> 
> Also do not wait for timestamps to be queued unless timestamps are
> requested.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Thanks Willem,

this looks nice and clean to me.

Reviewed-by: Simon Horman <horms@kernel.org>


