Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B43763D0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGZQ5Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjGZQ5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 12:57:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2602122;
        Wed, 26 Jul 2023 09:57:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ED1365C0182;
        Wed, 26 Jul 2023 12:57:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 12:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690390633; x=1690477033; bh=DiwshFBV23Jyp
        T7gUYeM15HG6FDoGp+F2reuYrPjovI=; b=Tj+E0Y1oyEvTr6sa6tcNpLjn0RSpq
        TWpHpg7CsY8bpEzKlc8zcmy+K4010tWCLuAaf+dLmfEmMuUgC7LAbVF7svzsNU2L
        vb4Cad8Y6HggdARs8oiiKSDvlPTTDdDWkRs43pUg8DC9LoudfGAtyEQQuCxKVzcD
        mb77lGA1hS1WKTfALAjXGLyvaa9zXEFrwtle4XtK42hUUI/NDZ1NmCef9xJOKHJB
        UrLy7rVzftG0atBDvNn1LxImUoXKcPBhoE1PSI8zZuUaaC+rTQWa5wX7hFVOquJF
        jYN9ZtGLx7ldvOOdA+AvJm3nbgbVM4kHeHDGRGseRJloNQOI3oxq3gjww==
X-ME-Sender: <xms:aVDBZLGCouiblUoEcuIemPBleAfkysQ6qz29AzQbYF9jfpPcYPS10w>
    <xme:aVDBZIXHvk_cC98C8g4xggEJq5feoIgEKVyS-h5Id86u8KWSmLfiWNSHXydYqkW98
    dl-ZYuIVon8aKQ>
X-ME-Received: <xmr:aVDBZNLJeJcFUJ_fhAHjiEOM8b85zrdQeCaaog6uDA-0KnAJgWoC6cR9xh5rUYP5goSbockKF-D_72RX8lOThShz7uhkFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepiedtkedufeejveeiueeviefgjeejveelueeujeehiedufeffveevudfhhedv
    gfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhgruhhntghhphgrugdrnhgvth
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiugho
    shgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:aVDBZJEGPHKNjCiJS8rnoz1VLT5-0a0L4CcvFL-PAMv4kF2HvPWTKg>
    <xmx:aVDBZBXWZJlBtLlLO60FgTYk-IW6IRoYWhRamBTLMuWqNwg_lu3NHg>
    <xmx:aVDBZEOhiPq8m5iLfpPfZVEX9taGjMxpgt3Ulf5kmdnWkhx5m_4RqA>
    <xmx:aVDBZAE9rfefagAhaJI-qtHkolARHAhfP7NrkK-kLi9HVRIGUzt53A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 12:57:12 -0400 (EDT)
Date:   Wed, 26 Jul 2023 19:57:09 +0300
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
Message-ID: <ZMFQZSI7InrLDG4m@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEQGIOQXv6so30x@shredder>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 03:22:54PM +0300, Ido Schimmel wrote:
> Regarding the MDB tests and tc_flower_l2_miss.sh, I suspect you might
> have some daemon in user space that sends IGMP queries and therefore
> messes with the tests. Please run the following commands in a separate
> terminal before running tc_flower_l2_miss.sh:

Ignore that. I think it's a problem I already fixed in the past:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8bcfb4ae4d970b9a9724ddfbac26c387934e0e94

Ubuntu still uses an old version of libnet:
https://launchpad.net/ubuntu/+source/libnet

Pushed the fixes for tc_flower_l2_miss.sh, bridge_mdb.sh and
bridge_mdb_max.sh to the same branch.
