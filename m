Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74173777D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 00:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjFTWbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTWbV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 18:31:21 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D81735;
        Tue, 20 Jun 2023 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=5XZASC4vvRomRFOoRSw3LbUkU0zai0fOoDyVCyjU/XQ=; b=nBjo7QomORnLyjaD+STtU66BMP
        Vlq9oByVsrdForTELr9HsrzFJBtmVwPeq5GWOhykMcQIlRSiqDEYk6G+FBsYc9fMAuDEab/huWam4
        jrEziuc2a0fg+6oPwhV9aEWR98HVfU9EdYQpRzUsqhIJZkf+TroPdCcWl7ilO9rm3qAuqE4sO9iW9
        rxt0WffmkxV5/bBc2zHXmmQPXtLyqMTPNohAQaQDVLqLxoqRYaWac5G5G0/41GRkBEsSetlFYaSqX
        VH+ctewumMfQTiA03BlNITACMcacrl2hmJBockOE2uLjBWTMyzXjfZB4h7UJTHbcYnwzr1tcSg/te
        54ewkoww==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qBjsJ-0003nd-8Z; Wed, 21 Jun 2023 00:30:59 +0200
Received: from [178.197.248.26] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qBjsI-0004xN-7z; Wed, 21 Jun 2023 00:30:58 +0200
Subject: Re: [PATCH bpf,v5 3/4] bpf: fix bpf socket lookup from tc/xdp to
 respect socket VRF bindings
To:     Gilad Sever <gilad9366@gmail.com>, dsahern@kernel.org,
        martin.lau@linux.dev, john.fastabend@gmail.com, ast@kernel.org,
        andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org,
        hawk@kernel.org, joe@wand.net.nz
Cc:     eyal.birger@gmail.com, shmulik.ladkani@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230608114155.39367-1-gilad9366@gmail.com>
 <20230608114155.39367-4-gilad9366@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1a36a60c-ec8f-9927-a932-f4fda0a52af3@iogearbox.net>
Date:   Wed, 21 Jun 2023 00:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230608114155.39367-4-gilad9366@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/23 1:41 PM, Gilad Sever wrote:
> When calling bpf_sk_lookup_tcp(), bpf_sk_lookup_udp() or
> bpf_skc_lookup_tcp() from tc/xdp ingress, VRF socket bindings aren't
> respoected, i.e. unbound sockets are returned, and bound sockets aren't
> found.
> 
> VRF binding is determined by the sdif argument to sk_lookup(), however
> when called from tc the IP SKB control block isn't initialized and thus
> inet{,6}_sdif() always returns 0.
> 
> Fix by calculating sdif for the tc/xdp flows by observing the device's
> l3 enslaved state.
> 
> The cg/sk_skb hooking points which are expected to support
> inet{,6}_sdif() pass sdif=-1 which makes __bpf_skc_lookup() use the
> existing logic.
> 
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
> Signed-off-by: Gilad Sever <gilad9366@gmail.com>

Overall this series looks good to go, just small nits which would be great
to still address.

> ---
> v5: Use reverse xmas tree indentation
> 
> v4: Move dev_sdif() to include/linux/netdevice.h as suggested by Stanislav Fomichev
> 
> v3: Rename bpf_l2_sdif() to dev_sdif() as suggested by Stanislav Fomichev
> ---
>   include/linux/netdevice.h |  9 +++++++
>   net/core/filter.c         | 54 ++++++++++++++++++++++++---------------
>   2 files changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c2f0c6002a84..db1bfca6b8b4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5093,6 +5093,15 @@ static inline bool netif_is_l3_slave(const struct net_device *dev)
>   	return dev->priv_flags & IFF_L3MDEV_SLAVE;
>   }
>   
> +static inline int dev_sdif(const struct net_device *dev)
> +{
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)

Why IS_ENABLED? config NET_L3_MASTER_DEV says bool, so #ifdef CONFIG_NET_L3_MASTER_DEV
should suffice?

> +	if (netif_is_l3_slave(dev))
> +		return dev->ifindex;
> +#endif
> +	return 0;
> +}
> +
>   static inline bool netif_is_bridge_master(const struct net_device *dev)
>   {
>   	return dev->priv_flags & IFF_EBRIDGE;
[...]

>   static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
> @@ -6778,10 +6782,11 @@ BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
>   {
>   	struct net *caller_net = dev_net(skb->dev);
>   	int ifindex = skb->dev->ifindex;
> +	int sdif = dev_sdif(skb->dev);
>   
>   	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
>   					      ifindex, IPPROTO_UDP, netns_id,
> -					      flags);
> +					      flags, sdif);
>   }
>   
>   static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
> @@ -6814,11 +6819,13 @@ BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
>   	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
>   {
>   	struct net *caller_net = dev_net(ctx->rxq->dev);
> -	int ifindex = ctx->rxq->dev->ifindex;
> +	struct net_device *dev = ctx->rxq->dev;

Why not doing this before the struct net *caller_net and also use it there
for the dev_net()? Same in other XDP places. It would be nice to also do the
same for the tc helpers.

> +	int ifindex = dev->ifindex;
> +	int sdif = dev_sdif(dev);
>   
>   	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
>   					      ifindex, IPPROTO_UDP, netns_id,
> -					      flags);
> +					      flags, sdif);
>   }
>   
>   static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
> @@ -6837,11 +6844,13 @@ BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
>   	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
>   {
>   	struct net *caller_net = dev_net(ctx->rxq->dev);
> -	int ifindex = ctx->rxq->dev->ifindex;
> +	struct net_device *dev = ctx->rxq->dev;
> +	int ifindex = dev->ifindex;
> +	int sdif = dev_sdif(dev);
>   
>   	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len, caller_net,
>   					       ifindex, IPPROTO_TCP, netns_id,
> -					       flags);
> +					       flags, sdif);
>   }
>   
>   static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
