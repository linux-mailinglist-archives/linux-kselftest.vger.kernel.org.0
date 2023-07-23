Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6391A75E07E
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 10:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGWIZS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 04:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWIZR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 04:25:17 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A9E46;
        Sun, 23 Jul 2023 01:25:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 48EEA32003CE;
        Sun, 23 Jul 2023 04:25:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 23 Jul 2023 04:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690100714; x=1690187114; bh=dIPYdFitpP50L
        KtnnhqPZLbAi743uFQ8ZFjL77pDtNg=; b=x5ojDjWGPP5b52vypHfJD9zieinRr
        VXSxGDT/7UvF7hD81HdzESl9x23kwCFWs4gTL0HXet5lLcTQqakuCH6yjr42f1UK
        6m57sifK3luK2DSuo+ZH4Cfz1QymGSqmKe76xI3MgVgeAVzy8JPyBY2YwPlj9mPH
        7UjMh7Euo0LsnfcbvL6IGAuk4lWm1Sv2BJ/79WcuB1YPqMgAIyKr1+IUHg4vtgrL
        95tsh6mAoCtRMcblMICfnXP5+XpU24ZRuUI+I8K67jUmIV3pxdUec8T45F8870OU
        wuZ8qiVZzn16hEE+yeL8cBO4CbNSsh5DGbJBcmnkQPRjXR0LFWKX1aMPQ==
X-ME-Sender: <xms:6uO8ZL1QXcu1UCGWBvtY9TvXPFOGHPSTIgJMccDTw2q0oeZH5iLIJg>
    <xme:6uO8ZKFKdwlCr8oCd5g_iYDWMuQazOH7B9WO5gbc98eJYcbWAuCEqus2wRn3GSQTg
    1iSBGwK41INVok>
X-ME-Received: <xmr:6uO8ZL7Eo5YdZHZkGxXzM10TmgDQ0iLySct2jXnJkk4BgP4mbzt96O6dP-j1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:6uO8ZA3liK6dp5j5ODaIwRmp8l7LFlkvytvenOmjVKsz86DmBzyqiw>
    <xmx:6uO8ZOH4Uvi4IoYIOCq7buaKmZm_E74wmcgnERsN5eqwPElXI9YXMA>
    <xmx:6uO8ZB-6QFUaxFSdL5A8QDlqguoTcv008IzpthmyBwL9qaVareP4CA>
    <xmx:6uO8ZB2_PHn0Mz_1zXeOTvZLWuuHuIuujDBb2lbmUO7DzEfYiAu0Vg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jul 2023 04:25:13 -0400 (EDT)
Date:   Sun, 23 Jul 2023 11:25:10 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZLzj5oYrbHGvCMkq@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 22, 2023 at 02:36:00AM +0200, Mirsad Todorovac wrote:
> Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
> keyboard, for the test times out and leaves incoherent network stack.
> 
> Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: netdev@vger.kernel.org
> ---

The patches are missing your Signed-off-by and a cover letter. Anyway,
please don't send a new version just yet. I'm not sure this is the
correct approach and I'm looking into it.

Thanks
