Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45778B431
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjH1PQA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjH1PPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 11:15:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893CAE0;
        Mon, 28 Aug 2023 08:15:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 016295C02DB;
        Mon, 28 Aug 2023 11:15:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Aug 2023 11:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693235740; x=1693322140; bh=dk0sUeihoiRFU
        0WpuwREI6ssYjEijVUMy2C2p5Lb4Wk=; b=ibTG1vNDSBFy09zlazkJK1NQIaGNr
        G5HNYsFH7PDapOxXT4Uf1OXmQ5+uqKfC9MQXVfTOluX7avtt/KiM7vQIdP7XR1Zu
        S9AdNMWJAMmbHqb73M/9VgjnRWetp/pa6YIlv9ApaaFZQp1kgIWpLZ8BNgslPI+Z
        vymdd6GZSc5jsaVdpQY5nXfTIalT3eWho7xmoYizxiEDcj8d3+YSlE2WaL9a4ePX
        8u6FF4MllTjMtqOrQsde17AAawHiLg6BY7ymtclRpwhjqS6UcUrpPH4QC9WCIak+
        Tqbcgm2v+WPf66hFQnPZCVfGfVB+gGMzm17ecn9teecX9Imzzcup+TQhw==
X-ME-Sender: <xms:HLrsZNkfore9e5bJLf7KI1Y0Wv_ykZvhYlCg6pc1_0iF72zp6sx_YQ>
    <xme:HLrsZI2hpqqIHPj1Nef_bNCRJs0b9ohCKNeu6YOTH8iBfplZc1uC8F3iCxFFvRsbf
    DWvZ9ZOESHNhPA>
X-ME-Received: <xmr:HLrsZDrPc4lHqQAT3q1Oij06ALYYQX26nKOcG8nDX9i9U-M1JomctoJStdtu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:HLrsZNnD2CzvWPPxfkwYXiM4mnbRHCT4v8SmpmqE3wxUBifwZykmNw>
    <xmx:HLrsZL0dkM5LNq3VLIrum_z-Cpyr6HoOMTFDQQAoi2TqQ-5XnmrKkg>
    <xmx:HLrsZMsTNz8HcuZv1A2TM8leyZLxt9196QD_ojq0k26CRyk6HAnWrA>
    <xmx:HLrsZEL6_KtN7Nh1uBhn_m_AMBK2rIu40DCBFk5vXt_QJ2ecR_UoyA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 11:15:39 -0400 (EDT)
Date:   Mon, 28 Aug 2023 18:15:37 +0300
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
Subject: Re: [PATCH net v3 1/3] ipv4: ignore dst hint for multipath routes
Message-ID: <ZOy6GQh2JbwZ8ycI@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-2-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828113221.20123-2-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 28, 2023 at 01:32:19PM +0200, Sriram Yagnaraman wrote:
> Route hints when the nexthop is part of a multipath group causes packets
> in the same receive batch to be sent to the same nexthop irrespective of
> the multipath hash of the packet. So, do not extract route hint for
> packets whose destination is part of a multipath group.
> 
> A new SKB flag IPSKB_MULTIPATH is introduced for this purpose, set the
> flag when route is looked up in ip_mkroute_input() and use it in
> ip_extract_route_hint() to check for the existence of the flag.
> 
> Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
