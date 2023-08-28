Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3110978B435
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjH1PQb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjH1PQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 11:16:25 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECBAFC;
        Mon, 28 Aug 2023 08:16:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 280B25C00C5;
        Mon, 28 Aug 2023 11:16:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Aug 2023 11:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693235780; x=1693322180; bh=izccesX1vfQwV
        GzCTI5YaDS3c9nr+xW6WfChf1mUIfw=; b=Ka5poLSMA14cEaOBl0EChO8g6+JDM
        o6HwF5z7dvfAWg/GTS4ExtAQK7h1ZfxfgtarcqoIhU84QbULVlIhqoHKLbLqAAny
        ID1iEh36AGm5N9YzXN23q6rPUsUhTQyfXRBaCv+tpHNqQQuqg/PBDYZPsHZ1vlcH
        48C4Y3pbfVRzr9Fo8UQrYoujhFCgr2LNJkEc637fPXJjUJxvamDumYb+u3O+GYbS
        oJCc1+wfYQH1BD9aeQ35kT6O4umMxWrngKd5WWnaYFvLK/pbk1AFdY+7qNGU8HVj
        /m/+JBJnK4M+YuH1mQHRL/i05MQnVOtE11ROcr02edaSCemEhaLevD31w==
X-ME-Sender: <xms:Q7rsZFy2F8OQ6qv0akLpQpb1ghce4vHVN9k4Omae5YcymezTygjfPA>
    <xme:Q7rsZFRptYscaDITz3k7CXdegYeXNQ3HxXgzjFYQRsnP8G-xoxHWIQfnNknylSFQG
    iOox-qZPkDIEUo>
X-ME-Received: <xmr:Q7rsZPWor2GV65xwcW2rGF6Ug-LM4YPCUF06WGwoaIg4Zyi4nc-kgvVANy7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:RLrsZHh6VuaN4QOWOu4zZUyuU8xn8GtFz0CgIKZ14vSKM1rnTodciA>
    <xmx:RLrsZHC5vfcIeos6lM4Niob7qfchKrsu9YADl0gvrM2beBW22DtHcQ>
    <xmx:RLrsZAIxiYRxxjzFCcm_HYhZe7KHj7ugaTXJcEZ-hobBgTo_Rt_Hsw>
    <xmx:RLrsZL24ntPLbTj-YJZl3BA0fCibbkowQ5jNJMzHsA2CiJcR9Oh30Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 11:16:19 -0400 (EDT)
Date:   Mon, 28 Aug 2023 18:16:17 +0300
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
Subject: Re: [PATCH net v3 2/3] ipv6: ignore dst hint for multipath routes
Message-ID: <ZOy6QfalXBa6AvOT@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-3-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828113221.20123-3-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 01:32:20PM +0200, Sriram Yagnaraman wrote:
> Route hints when the nexthop is part of a multipath group causes packets
> in the same receive batch to be sent to the same nexthop irrespective of
> the multipath hash of the packet. So, do not extract route hint for
> packets whose destination is part of a multipath group.
> 
> A new SKB flag IP6SKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in fib6_select_path() and use it in
> ip6_can_use_hint() to check for the existence of the flag.
> 
> Fixes: 197dbf24e360 ("ipv6: introduce and uses route look hints for list input.")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
