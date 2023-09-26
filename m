Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B97AEBA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjIZLnM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZLnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 07:43:12 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D1DE;
        Tue, 26 Sep 2023 04:43:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B004B3200930;
        Tue, 26 Sep 2023 07:43:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Sep 2023 07:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695728583; x=1695814983; bh=rAbItrXU3DjBe
        WT6zjvCvCs+hZImWYb77PlbQjt+Gtk=; b=GoXutLAlWTYBq2WBbmt9rkR/5Ww66
        o8C17Gcf06+SBEzqQfA3ajzVDLeipwbokWndu6Rwg4GPzMr+nMG28FAOHL/JKpoV
        yjuh6TrHDn7OWEsItqBYSQU3ZzjfmB+aifDxy9Sfw3aBGB+ye58hIYuKlIkZILFi
        BFI0Hb+AJhowyZB8peVw5pmsu9tsR63yr3xQEpkbighP+KIVuhASXp/VyL6B+FH/
        PYe54U/Dyyt0dZu6NsOo3sZ4SXmsQ/NRgUzFprRosDDbEW5HSPmMIRZi/uaBJYdP
        Wrv2MhvhYAhWz3xDevbdmi9glU07EUJ1J66cLZYYkh0ritk8PZCqV9+vQ==
X-ME-Sender: <xms:xsMSZRP876q_BHVbbi-YNj1T9XOhylRXDJjHTIAUEQeXURn8ASz9pg>
    <xme:xsMSZT-CIYij4BwVmZUps6kyFyUB7LY58CabWbqKlRhnZbrXVsoQ6iBZ8c6ijwXvA
    ky5GSaQfI1nvdU>
X-ME-Received: <xmr:xsMSZQRnvbwEfdTULcKCvoMt6bGrwEiMajp48z_pv9L2hGVa0uQXJejxIPduZkiVLbxMtNGBTMryrOpP3_6sYk8cRsf_Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:xsMSZdvgxTuLwdLisWHUolZ3Q_fVXaOa-Iv_MJvViPHfDqCsyysvEQ>
    <xmx:xsMSZZdDbauG14716H_adsIGMSGk19f1MN9QqTO7sUrt3f9KS7JfcQ>
    <xmx:xsMSZZ0NWuqq7INlywIQ_YCcESf2DmaORKTsrXSEBrB1uSiZUr28MA>
    <xmx:x8MSZZ8Sr0UIqXFwQD96dVXBwB7O3j1Ht-MG1I4v26vrqi1JxfP-6Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 07:43:02 -0400 (EDT)
Date:   Tue, 26 Sep 2023 14:42:59 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Nikolay Aleksandrov <razor@blackwall.org>
Cc:     Johannes Nixdorf <jnixdorf-oss@avm.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/6] net: bridge: Add a configurable default
 FDB learning limit
Message-ID: <ZRLDw45mpeU6tBaK@shredder>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
 <cc14cd4a-f3bb-3d6f-5b38-ec73cad32570@blackwall.org>
 <ZQv5aNbgqxCuOKyr@u-jnixdorf.ads.avm.de>
 <50814314-55a3-6cff-2e9e-2abf93fa5f1b@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50814314-55a3-6cff-2e9e-2abf93fa5f1b@blackwall.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 01:19:44PM +0300, Nikolay Aleksandrov wrote:
> I'm not strongly against, just IMO it is unnecessary. I won't block the set
> because of this, but it would be nice to get input from others as
> well. If you can recompile your kernel to set a limit, it should be easier
> to change your app to set the same limit via netlink, but I'm not familiar
> with your use case.

I agree with keeping it out. We don't have it for similar knobs (e.g.,
MDB limits) and it would create a precedence for other bridge options
instead of simply using netlink and improving user space applications.
