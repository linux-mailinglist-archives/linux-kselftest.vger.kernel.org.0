Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02D66FF53C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbjEKOzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjEKOzg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:55:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794C124BB;
        Thu, 11 May 2023 07:54:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A94DA5C0040;
        Thu, 11 May 2023 10:53:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 May 2023 10:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683816824; x=1683903224; bh=1F3ippDhrsx3M
        VtWBGNFUQJfNyeHVvQtpmBRtivpaEI=; b=ebTY8aY2Nl8V7VpGYMdLFP/KZayC0
        jIc6F89XxXRANdxHazsmp65k3fNwYaPoejqA91D4PejeRJSqifE4ZoPo+zgK77oi
        0WnqRFHzXHKIXhJ3ExZWtEVWXd2Iuo7wIvwdvFpF/bB0DQpoe0ws8gr2hRhXiuE0
        +6iJ8QCiQsSRdLgJVqryJ6zWTY6xbtUorPvNpLlB/GgHF/j51i7jeer2T2Zqn9iO
        3xmj9dsEBd/JCbzg1hswZ/C6KbWlexYxto4a2YZ5FkwqYUjxqnXkbcw5PIF/vNmG
        ML7f+jvAPH1wyY2dgbC9lF2ZP1KQ5QIhW6/HSOaGz7/PebEgDKgq3qPxw==
X-ME-Sender: <xms:eAFdZOM3CfAFuLf_ZsGA23k03jTXEQdA0pQJLFw7Ei1YBU7dqLcH8g>
    <xme:eAFdZM_ZXCP3Pf2HdfQEiN7NpMTA5VGngOfhO0q1X2P9FaUsGk-WHbomctgeH02GC
    hDL-FVknWXDj4s>
X-ME-Received: <xmr:eAFdZFQPbb4ZYghXezTHbZhpLaf-aDqpCaJdLjxBPp3MUNDcAa727q-_cG-0B9Yfe2WU0JDj8-ljXM_MxJHUDPBIy-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:eAFdZOtqiE483RbST2vEqBm7KtD4pSzNwUWs-G1WK5rpDsIGnhsiWg>
    <xmx:eAFdZGdsDJc8MLUol0z2WCuFPhRnNM3jQbmEYw-bYus-z9Lu1X3ABg>
    <xmx:eAFdZC1OiTstfHLbqD0D2mvLMLE_eLkf0JRIsEKw8llJVG3IMpb_hQ>
    <xmx:eAFdZM3SZwFOeWvSxSZSkNiBuYnQEWih-mkweK5aHKpcNb2SqkO4jw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 10:53:43 -0400 (EDT)
Date:   Thu, 11 May 2023 17:53:39 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] vxlan: Add nolocalbypass option to vxlan.
Message-ID: <ZF0Bcz4SCOLX33O3@shredder>
References: <20230511032210.9146-1-vladimir@nikishkin.pw>
 <87a5yb8rkg.fsf@laptop.lockywolf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5yb8rkg.fsf@laptop.lockywolf.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 11:38:33AM +0800, Vladimir Nikishkin wrote:
> Do I need to re-submit the patch to ifconfig separately, or the old one
> was good enough?

You will need to re-submit the iproute2 patches after the kernel patches
are accepted
