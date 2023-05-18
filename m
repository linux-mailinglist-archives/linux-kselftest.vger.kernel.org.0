Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1B707CFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjERJfP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjERJfN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 05:35:13 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD82122;
        Thu, 18 May 2023 02:35:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C5D7C5C012D;
        Thu, 18 May 2023 05:35:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 May 2023 05:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684402507; x=1684488907; bh=H7JP953ZXv0Er
        azaPfrMU+R3DhoV1fHQeOVPDe5FCYw=; b=P5TgoivPV8S4EzdAV0mha0OgC236k
        xPRFfxUS1dAUTMcA9gE2zxbWisXvzSFG08rvMSLNk17tZtjCJhORIK9NOVK5muES
        0kf47OL0xmboiujFNFnu8VESiAJaEgnU1n3f8C3uLuUST2TAAH1ZeyqeNpg4oI0g
        4wjN2YmituVuff5nOg46+xDiJduniwkqkzF0ZWDOM1LhDZG7f838gYg14Zfg9fy2
        c01X6m4yNUzN5Vs9gEkaFwgWxMVy7voLHCYcIw4YRsEsfM+c2nw3/YvCm0FooFlU
        x8oOXy720fABifF5e1I4vH85OKtVfYX6dOt/nV7yZSICpEIGfaqeuj2sw==
X-ME-Sender: <xms:S_FlZEo0FVlIGMf15bnDuLNQjciogncaMNNxSXshKLzNjrrgVldtFQ>
    <xme:S_FlZKrbL6Nf_NQ_3-0EeJesvlLsCXjqEOB3IfS6YuEJkN-q98WYqn56QDYaHpovH
    3kpKCk56ctzf70>
X-ME-Received: <xmr:S_FlZJOb016zgQwyeYCZCWpTvmYDHg7jac_hUZBlIuB7iKe2EbMlWI84rs0jP_hGBDskLyQwskDeWcjQJ1DCEB5WhfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgf
    duieefudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:S_FlZL67RqgnD1QPz0hCB5_1nhzzz1I4hPHSrkRcutTdDHlWui3MeQ>
    <xmx:S_FlZD5oNkZIygROXb69o06HHLUVkLcMLWlAOBdjWAgHjywDcupuZQ>
    <xmx:S_FlZLiy4CR9J25SynHxcv9uxhCMW6e_QB4K4A8EGYodkYvlYEl6Pg>
    <xmx:S_FlZGakTwoLKR7SFdAhC6DEniR41K84dbU3ckp9N6GmqQyZZfdtZA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 05:35:06 -0400 (EDT)
Date:   Thu, 18 May 2023 12:35:03 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, roxana.nicolescu@canonical.com,
        shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCHv3 net] selftests: fib_tests: mute cleanup error message
Message-ID: <ZGXxR+nc7xBLtGwP@shredder>
References: <20230518043759.28477-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518043759.28477-1-po-hsu.lin@canonical.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 18, 2023 at 12:37:59PM +0800, Po-Hsu Lin wrote:
> In the end of the test, there will be an error message induced by the
> `ip netns del ns1` command in cleanup()
> 
>   Tests passed: 201
>   Tests failed:   0
>   Cannot remove namespace file "/run/netns/ns1": No such file or directory
> 
> This can even be reproduced with just `./fib_tests.sh -h` as we're
> calling cleanup() on exit.
> 
> Redirect the error message to /dev/null to mute it.
> 
> V2: Update commit message and fixes tag.
> V3: resubmit due to missing netdev ML in V2
> 
> Fixes: b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
