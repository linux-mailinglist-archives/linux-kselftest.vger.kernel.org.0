Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040CA78A010
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjH0Pp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjH0Ppu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 11:45:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC2ED;
        Sun, 27 Aug 2023 08:45:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BB3AB3200413;
        Sun, 27 Aug 2023 11:45:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 27 Aug 2023 11:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693151143; x=1693237543; bh=JprlLIqEJWaRb
        bi++2K0fgr0aIwsjL2WLjUkdt7UMVY=; b=fF+ce6qLQEP5ohnZiY6XGK71zIuDd
        fx9JGhEUu+xcUSTxBHMsuaEMOu5AXbHZqVzXnOtB6x4GOtZdIsTI7cu9JtmeMeCx
        tNIeXWBnIyCWrtC3xwh+u0S+htKjMYzEI8VyeloymvnUTueW1wnSNdfHBm/8rhH+
        qGFlFVZarg1+hbgB8jvkijrOtWkNAQ18MGa/ML1HZCEAXSB3/iel4PBAYISAWqgm
        NFRNfNaMHyYyi1C374ez3clGgb/YL2mwD3izrzmRaIrFl/JqRIIaDsh658RwALfD
        KcM6y6zWlc1lQx3ulyYAa5maaCCZpwvfbEnAky1iTaX2n2Ku0KZLbyRYA==
X-ME-Sender: <xms:p2_rZF1d32fJ6vaYYzALtRLxHJrkx2jWY39SmPUbFyUJI02-ggZN5Q>
    <xme:p2_rZMFqrudxZ3Bx7Bss9pvWgfh6DVPj1yjs6-EODPID2igsiYLE_w5OAmRGKPr3W
    LcD44XTbxm6eYs>
X-ME-Received: <xmr:p2_rZF4yeRg21SfoZ9yYGzkk5DxJx_Cf95jRpgsCA_2w0jTHytxQQFH_TWrz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:p2_rZC1SZoZW0QNJtBELsik3okBXbJCHDIooSI5RSSJBQlsGxlxS6A>
    <xmx:p2_rZIEvJStKXevZ-avEbwrDSadS_9a3FfFuVKZkkZqWvKO2t2tW-w>
    <xmx:p2_rZD-8VfH1yACZgAGpSeGNM33ojktmxenLzzVRPy_Yf9cw3OK0oQ>
    <xmx:p2_rZGZucXPs_Oj3ClrrYeseb53giYE_eKvIkQPxPK0_bPfU_eqTTg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 11:45:42 -0400 (EDT)
Date:   Sun, 27 Aug 2023 18:45:38 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v2 2/3] ipv6: ignore dst hint for multipath routes
Message-ID: <ZOtvor13INKwpwbc@shredder>
References: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
 <20230825090830.18635-3-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825090830.18635-3-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 25, 2023 at 11:08:29AM +0200, Sriram Yagnaraman wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 56a55585eb79..4631e03c84b4 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -424,6 +424,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  	if (match->nh && have_oif_match && res->nh)
>  		return;
>  
> +	IP6CB(skb)->flags |= IP6SKB_MULTIPATH;

skb can be NULL here in case this is called as part of route query from
user space, so we need:

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 4631e03c84b4..a02328c93a53 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -424,7 +424,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
        if (match->nh && have_oif_match && res->nh)
                return;
 
-       IP6CB(skb)->flags |= IP6SKB_MULTIPATH;
+       if (skb)
+               IP6CB(skb)->flags |= IP6SKB_MULTIPATH;
 
        /* We might have already computed the hash for ICMPv6 errors. In such
         * case it will always be non-zero. Otherwise now is the time to do it.
