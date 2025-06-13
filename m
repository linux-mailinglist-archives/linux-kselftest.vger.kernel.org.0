Return-Path: <linux-kselftest+bounces-34908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73365AD8FF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCAE3B426B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4419B7F477;
	Fri, 13 Jun 2025 14:47:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD710F9;
	Fri, 13 Jun 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826038; cv=none; b=L7aPJiTIchiNMnkN1BNEKZBxwTvkiVMn5HVNd/G41ah96dC8USZNHqGG71UrQFCK9cMhyO6srLbbmxXdxClRYLof2E/IRY9mnoLzoQeM2GwjwJp90ktH+lwgigdKfMrwwxOZemKX+0LHFW9Jm+K4oDxMCAhCEJ6NViNYo0S+XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826038; c=relaxed/simple;
	bh=ERWxMeHhioNfPsdKe7XiVsTeKQhpBmGUmbGktlPg+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ+UBSAAC3LQHGbXLSCX45icTlAU5vGEg0HpzbX5z8m0Xw88YQbCb3xd6BCcIqPyXqe9/WrNBDAn+1gcdKJCrK/N2AlOsr2gKF8NnvQUF3+ldYB5WzsWY3/hyHKMzA6XUjOz2vvCh4n9U0BREohLQKZ4UkXdvF/1x+6PimXsquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb2e9fd208so433217766b.3;
        Fri, 13 Jun 2025 07:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826035; x=1750430835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba5rtWXHw98X49Jgpy1we8+pwJv0vzJYUJGITyfZEgU=;
        b=ZXHTNVPtHCdJ0MbVcwwpToRRyrh2svGY0GyKY5gpsTkYEi/hEc9Ilsx+FK2pkma8bZ
         iyYNcn7vVHIOt3Hs7SR5fK/kToN37aN2LVohNgJHL1FJS3FniCJgHEpoEFwk/KRPdBEt
         fz2r5jm6chU66PX3Q220imgTk5GX5qrYHfT+wVw0jR5JDxrmLiWCXIOqrHBneBVHpQN1
         WgufYLzzCgQT4zltzGsxaLKztSQcrixheDnyBwKb5YUXNNILhJPLS8lUzkEUj4ddD4iI
         JDCI//UCpajTO+meSqxx3e2i5O40kkUyVI3Io6belzk+jnxjkDX29FrXIE3GegjoZJ7f
         lxzw==
X-Forwarded-Encrypted: i=1; AJvYcCWW1yed78PQOJ06S/nvLBPo9aXATdIgcbrc8brgQbOhibjyPxb05UHyvACvPv4Nzvo3vdrrr7qhpPFhTzA=@vger.kernel.org, AJvYcCXcXSTEOgEPWqIq9vJxRRpnbGln8IyLw58w6i4/2An4P5r/uECiM6ILeiVi4VQkJ54m81B0gU951zEzRoE1Btg6@vger.kernel.org
X-Gm-Message-State: AOJu0YydsAVOC/F1AEzAmdf3SgqUjWb4E5uKzNy/CIzMKPOy7qTD7Dig
	QIGHhYqScLq28gM+h7jMtxYE75SrLRCaVPu2iFH/kLJIRwN4byvzRjHh
X-Gm-Gg: ASbGncvelgapNNwUjvem7WK9FZbLmZJZiBrIrErcNpBWmSBmjyFRw2/DxnOES2m0B4Q
	aNr+dNcFE5Q8oA1iOG+OgxQLGvsKrEtxbccaFFaE13MWGhvpyQkf3HXJj4XwfS38FHtsyPYf2L9
	i12GhBga1moXK19juI46ORHkq1H4GLiF+XkUnsYpHSNRCVrfxhu0zwzc+FmT0Hj+RlrjpvlEUEy
	d4KThi4MD3HBRThk150ReyWYBQkbWQZkiuAAa265QFpJWAUAnHC7atIgELdm94nUgbWbej3H6ao
	g8jA/Db1zXDHlZ1aPD2I2A57eubJ/b2/PVdtlK8OTcuq9HUrqoicCSZtOditQ2g=
X-Google-Smtp-Source: AGHT+IGIoUifCDQIiPJ4VVQegeNUofVJ2y5IzyBemUy+n1oa8GSrv3o5HP6cOyjuaOlLMoE/7CUmRw==
X-Received: by 2002:a17:907:c1f:b0:ad5:5302:4023 with SMTP id a640c23a62f3a-adec5d6daf8mr349836266b.44.1749826034398;
        Fri, 13 Jun 2025 07:47:14 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48a836asm1291134a12.13.2025.06.13.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:47:14 -0700 (PDT)
Date: Fri, 13 Jun 2025 07:47:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, joe@dama.to
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/4] netdevsim: account dropped packet length
 in stats on queue free
Message-ID: <aEw579mm+3aiXti+@gmail.com>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
 <20250613-netdevsim_stat-v2-4-98fa38836c48@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-netdevsim_stat-v2-4-98fa38836c48@debian.org>

On Fri, Jun 13, 2025 at 03:40:01AM -0700, Breno Leitao wrote:
> Add a call to dev_dstats_rx_dropped_add() in nsim_queue_free() to
> account for the number of packets dropped when purging the skb queue.
> 
> This improves the accuracy of RX drop statistics reported by
> netdevsim.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

> ---
>  drivers/net/netdevsim/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index de309ff69e43e..6e8fb8922ace2 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -634,7 +634,10 @@ static struct nsim_rq *nsim_queue_alloc(void)
>  
>  static void nsim_queue_free(struct nsim_rq *rq)
>  {
> +	struct net_device *dev = rq->napi.dev;
> +
>  	hrtimer_cancel(&rq->napi_timer);
> +	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);

This is wrong and it will cause the kernel to crash in some cases, given
we can get here with dev == NULL, in the following path:

	nsim_destroy (drivers/net/netdevsim/netdev.c:1067) netdevsim
	nsim_dev_reload_destroy (drivers/net/netdevsim/dev.c:426 drivers/net/netdevsim/dev.c:1429 drivers/net/netdevsim/dev.c:1440 drivers/net/netdevsim/dev.c:1661) netdevsim
	nsim_dev_reload_down (drivers/net/netdevsim/dev.c:?) netdevsim
	devlink_reload (net/devlink/dev.c:462)
	? lock_acquire (kernel/locking/lockdep.c:5871)
	? devlink_remote_reload_actions_performed (net/devlink/dev.c:446)
	devlink_nl_reload_doit (net/devlink/dev.c:?)
	? devlink_reload (net/devlink/dev.c:520)
	? __nla_parse (lib/nlattr.c:732)
	genl_family_rcv_msg_doit (net/netlink/genetlink.c:1115)
	? genl_family_rcv_msg_dumpit (net/netlink/genetlink.c:1088)
	genl_rcv_msg (net/netlink/genetlink.c:? net/netlink/genetlink.c:1210)
	? genl_release (net/netlink/genetlink.c:1201)
	? devlink_nl_pre_doit_port (net/devlink/netlink.c:257)
	? devlink_reload (net/devlink/dev.c:520)
	? devlink_nl_post_doit (net/devlink/netlink.c:288)
	? __lock_acquire (kernel/locking/lockdep.c:?)
	netlink_rcv_skb (net/netlink/af_netlink.c:2534)
	? genl_release (net/netlink/genetlink.c:1201)
	? netlink_ack_tlv_fill (net/netlink/af_netlink.c:2511)
	? down_read (./arch/x86/include/asm/atomic64_64.h:20 ./include/linux/atomic/atomic-arch-fallback.h:2629 ./include/linux/atomic/atomic-long.h:79 ./include/linux/atomic/atomic-instrumented.h:3224 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:256 kernel/locking/rwsem.c:1247 kernel/locking/rwsem.c:1261 kernel/locking/rwsem.c:1526)
	genl_rcv (net/netlink/genetlink.c:1220)
	netlink_unicast (net/netlink/af_netlink.c:1314 net/netlink/af_netlink.c:1339)
	netlink_sendmsg (net/netlink/af_netlink.c:1883)
	? netlink_getsockopt (net/netlink/af_netlink.c:1802)
	? __might_fault (mm/memory.c:6991)
	__sys_sendto (net/socket.c:715 net/socket.c:727 net/socket.c:2180)
	? __ia32_sys_getpeername (net/socket.c:2147)
	? __might_fault (mm/memory.c:6991)
	? __bpf_trace_rseq_ip_fixup (kernel/rseq.c:425)
	__x64_sys_sendto (net/socket.c:2187 net/socket.c:2183 net/socket.c:2183)
	? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
	do_syscall_64 (arch/x86/entry/syscall_64.c:?)
	? exc_page_fault (arch/x86/mm/fault.c:1536)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

I am wondering if this additional patch is too ugly:

	diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
	index 6e8fb8922ace2..328c7e83f2823 100644
	--- a/drivers/net/netdevsim/netdev.c
	+++ b/drivers/net/netdevsim/netdev.c
	@@ -637,7 +637,8 @@ static void nsim_queue_free(struct nsim_rq *rq)
		struct net_device *dev = rq->napi.dev;

		hrtimer_cancel(&rq->napi_timer);
	-       dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
	+       if (dev)
	+               dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
		skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
		kfree(rq);
	}

