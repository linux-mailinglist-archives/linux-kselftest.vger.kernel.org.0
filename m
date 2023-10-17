Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7717CC180
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJQLGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 07:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjJQLGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 07:06:45 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E1EA;
        Tue, 17 Oct 2023 04:06:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 03B355C0312;
        Tue, 17 Oct 2023 07:06:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 07:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697540803; x=1697627203; bh=C2g91EpF8bnTE
        31MfUeHv6PZqy/bsGdqol8WloDU6eA=; b=KZY8H3h/tBfdYVyxwK6V9SBOE4PmN
        pDfZ7iPTqILvMnmOAYaS6vTd50ShLLE681pmAYgcwKBB7IPbjp8Gj7UIGso5KuDc
        AtQibc8s6ESRmgLDWC6ahvcl9DnDaC64XFR3EqRikoEMsOFKZ/sY3KnyTE2J6EQD
        zNU7thKlnVWnUH75QTzwExR70jw0ZxYEgNg7ZHh1FCc6LfEHecRAz9jDswzIyZCt
        POKzNeguHFE4pbUSbUSF0I93PDJHf0BiqNiMPm2WfiucrUWD8k1KSW5nlXnUvvea
        75ozhkM7xUHDBD0e7urS9GtsVUCaKuLbXDFGpPWPRzYU9MxX+krQ3F15w==
X-ME-Sender: <xms:wmouZfdKN6FlycrVMbLu_O3bAZO4JaCW9UGSH7MAxov0_FDizFkogw>
    <xme:wmouZVPxjud5no2ROux1M8Oa3Z7kPcrY3xyaAj3hKhss-Z-AcEJQ4UHmz_OVYWywA
    LQVjVjfJJZ6OqE>
X-ME-Received: <xmr:wmouZYiqkW5hQB-L-UKe23fSsEGnaHWj_wn-DhnuPm9xmWO1yE4yHJVRoVOBVMZE3jYatfpEGRPrbngcJ6FENFXVylU68g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:wmouZQ84f13oKCo8CfDRKQ1toUj02h8k-v6_ToZMDlqwxGGgoVq9cA>
    <xmx:wmouZbscoAdvYzIM6kJavE29JJVxS0gmrGmGVTDOwK9BrfdUdCgabg>
    <xmx:wmouZfHZRkAvHgxqcs2gEh-_T6k9WTgE0GmHAIfmLEPrMF5ep934mQ>
    <xmx:w2ouZTNdZiRrsC36NE4pgZiww-z1v_4e9u-1IdHYMD_kNZmOld0snQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 07:06:42 -0400 (EDT)
Date:   Tue, 17 Oct 2023 14:06:39 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] net: bridge: Set strict_start_type for
 br_policy
Message-ID: <ZS5qv6WEv5J1tYTU@shredder>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 03:27:23PM +0200, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
