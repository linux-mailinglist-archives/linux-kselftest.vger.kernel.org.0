Return-Path: <linux-kselftest+bounces-35207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA8ADCC1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9BA3B7DD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFFD28C2D2;
	Tue, 17 Jun 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfpONRB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19B28BAA4;
	Tue, 17 Jun 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165176; cv=none; b=DcfgOYAnLj/F+Vo/r0F0MbyWRi0QtQLTx7+WfD3w2xQd3XmAf25GAfGYTU1xvy4vK79v4sYPBnwqEPDn80n+gnHUPSpXxR6z7MI4UYCgqCTzaP52lhFy0v4nV+XSYljY+/IC0xTyjTL5QqfgQ0JRcVHW/l6GpHljJtLN54pV6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165176; c=relaxed/simple;
	bh=aIK2wnwgcxtmTmwtKOfHykGGdw3wB5ydycAxXeFYp+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvepmLeh5KmM5H9ceibZtb9CHKdZFe4BL4n+Oak5trK1SXarUxX17y7L2lEXApG7DAUKBAvuZC77fatelbllBVdV5yS6kMZo+Q5kz/Kz/nwMOWUpDXg9xiVfv24I6qLE16OoSLGz6HW+bQjeaN7WA5Ls2kgfbAQRZlLTplbSs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfpONRB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DB3C4CEE3;
	Tue, 17 Jun 2025 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750165175;
	bh=aIK2wnwgcxtmTmwtKOfHykGGdw3wB5ydycAxXeFYp+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QfpONRB2dfHGZnqXZHUWKaABo/6hD3MxxLOaZJrN4+zrF39+c4PAShKgsSzKqcIvH
	 rSIV7AE9VpX24GffCXbfqzMXKEHqgP7ZpsfISiUDuwxV4UVLGudKeq3rkE2qIj+FfJ
	 AjJUoHqIO1KzVBNexEx75vdt6nYniFae5k9Xcz5wfWFGasDVhp8ZCZ1xhENJeYOjVr
	 IFdcT92yEFhRiExqHoPPegEx3v4pSZmLu/vWx1tpFGV919U8m2K0QdQpAQW8kfCd61
	 ACPcDL0tJe/F1oezbwnNysoF3AA08GiLKbhb6dUbHJD/pVZrqEPeIftninpxG0M9V5
	 E2iThAsBFEBmw==
Date: Tue, 17 Jun 2025 05:59:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v3 4/4] netdevsim: account dropped packet
 length in stats on queue free
Message-ID: <20250617055934.3fd9d322@kernel.org>
In-Reply-To: <20250617-netdevsim_stat-v3-4-afe4bdcbf237@debian.org>
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
	<20250617-netdevsim_stat-v3-4-afe4bdcbf237@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 01:19:00 -0700 Breno Leitao wrote:
> -static void nsim_queue_free(struct nsim_rq *rq)
> +static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
>  {
>  	hrtimer_cancel(&rq->napi_timer);
> +	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);

here we are in process context and debug checks complain about the use
of this_cpu_ptr(). Let's wrap this in local_bh_disable() / enable() ?

>  	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
>  	kfree(rq);
>  }
-- 
pw-bot: cr

