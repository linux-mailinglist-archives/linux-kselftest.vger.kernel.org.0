Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663B75E406
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGWR2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 13:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGWR17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 13:27:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225511B3;
        Sun, 23 Jul 2023 10:27:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1EC4032004AE;
        Sun, 23 Jul 2023 13:27:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 23 Jul 2023 13:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690133274; x=1690219674; bh=9pS/poHVY3gKi
        EOMsPaEtsBloR1fdynWZkvZgdvRBgw=; b=C8rKzsFr2XmR44yoaGMA1zaUV+5/e
        +K4DKSax0LmJnfIPGe3KjT2Zqe+NLze9qyLEkVSA17WbzeG9bRNAOa8L9w07J5Bv
        Egpoe/pltHkmiYjl7QOIYknO24wzxmbyewbikFZlZzG/XNI2vJE10BItijf0Ukzb
        V1Gg2xHrkjZpRiw4SnYDbNbWIeustV4whOqKd/bFGE4AJrbNt4C+x2Mb42OY1Pgh
        SEBM6mFy+Er8FlBjBNrVfZagZ1IYgCKk1aa2mUkCXJLhTKLYnl5zVeeaR0/m9r+q
        Ixx5ZqDwoogER7YyAdp2IMszPz9X4dD5D+Fxb2O4Y2zzfr9++yCEdMZoQ==
X-ME-Sender: <xms:GmO9ZDmv7LyBV8FVTU8rjLNzDsm2GN7lQ-K5tnbeDrkVABFpHFExvA>
    <xme:GmO9ZG3ttVRAlchkVrVMBpNQCnEa2SOGRh7ud3Jt9pWkfQdZkCnaDtFpLX_FKFvPU
    zognaKQDzatVo8>
X-ME-Received: <xmr:GmO9ZJpdouL2b4QnQ5tf-pqyohzWCMRKxDLaAXZXKQuKpV7AUs5wdGbf00Ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeigdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephfffjeeghfejheejveehvefhteevveefgfeuudeuiedvieejiefhgeehleej
    gfeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:GmO9ZLmiFXqV4OhDSySxY9u4F_mUnWbXptlKTqhDqVPmFi2dfJVzsQ>
    <xmx:GmO9ZB1DOBgcnuk-kOLjEixcZRBAk-Wqy42J0N7QKAJlsQXJ0U7WgA>
    <xmx:GmO9ZKs942FvFUaAkfUj3QuX0SV5CR-Xl7WGJOKS6J-3FS5uXK5T5Q>
    <xmx:GmO9ZOms2VV35dkSkmglS2Q32iZW1huD5yJm-7PPAZyukkhfqc7C0A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jul 2023 13:27:53 -0400 (EDT)
Date:   Sun, 23 Jul 2023 20:27:50 +0300
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
Message-ID: <ZL1jFk1z3zDH7dUM@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLzj5oYrbHGvCMkq@shredder>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 23, 2023 at 11:25:16AM +0300, Ido Schimmel wrote:
> On Sat, Jul 22, 2023 at 02:36:00AM +0200, Mirsad Todorovac wrote:
> > Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
> > keyboard, for the test times out and leaves incoherent network stack.
> > 
> > Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
> > Cc: Ido Schimmel <idosch@nvidia.com>
> > Cc: netdev@vger.kernel.org
> > ---
> 
> The patches are missing your Signed-off-by and a cover letter. Anyway,
> please don't send a new version just yet. I'm not sure this is the
> correct approach and I'm looking into it.

Please test with the following four patches on top of net.git:

https://github.com/idosch/linux/commits/submit/sefltests_fix_v1
