Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD8705FB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 08:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjEQGAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 02:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQGAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 02:00:45 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156D126A1;
        Tue, 16 May 2023 23:00:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C43D85C01C7;
        Wed, 17 May 2023 02:00:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 May 2023 02:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684303240; x=1684389640; bh=b+5PKyknPkYcK
        IktJykWfMQ2ZNruWkKZ/Da362HiLq4=; b=Jtvf/z12zJDb6on6nsKKmmBiKQYCU
        nNU9ppaj1CPOFF4USYlfmYG2VIyCjx9n9SPkDAsyvWdf3GuoZYlFd4ySoCdz5lSB
        aICT6PEKjh6dXBl+bneqo8pSd8ZRdp2f9x32vDzznGfMWRpLC3b9HhacFHIP9JRZ
        3md7AXmLUmFK1O5HQ+D6f9kGAeTLOHNIojTwWhX02X1jlnJDrNDLL4JOgzop27tw
        gJDSldHJdaQrbsM7D4bThzx42CHUeZmQk8Wupqy9FNXNqrGntcm0wroJ50g8basa
        TSrIn2cmHALT1tmeC3DDCWepN3PvgEeUXHwLk3oDCrrxBOeBHPcqjVNmQ==
X-ME-Sender: <xms:iG1kZH0Tnbe-77abz2dcGS08XOkF1iAQ_HE_DzPkk6gnd2oer3MAVw>
    <xme:iG1kZGG2lfIcuD4Mufj7JG37MUrej7Dyd4wZ0n_0vpYBO7CBoYunITJzoP999vLan
    VonVD5AqylvuHg>
X-ME-Received: <xmr:iG1kZH4lZgJVly8P1GOnoyW44UtDlk2vwqUhYaSVzyn7PstjCD0XYGywaGKPV_ux_7gME_fq98cwUFqbFX4b36j8M4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeitddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegte
    eiieeguefgudffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:iG1kZM2WOORpdKZxsXNPo9pfToo8xX2JNm4ctTnAs3I6sM2DxWd0YA>
    <xmx:iG1kZKEn1AoBp0yjNFts8kaiUUioIhJIfAShWugx_siDtJ540XscSw>
    <xmx:iG1kZN8hQt-ycQo4TwNFPdr4WPS5RWjC6DfVf7VXChki9YcERGPJ5g>
    <xmx:iG1kZN2azbljODst3GA4GACfvpbSRXSop0xNU-6sQeJk3USPMH5CPA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 02:00:39 -0400 (EDT)
Date:   Wed, 17 May 2023 09:00:37 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, dsahern@gmail.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Subject: Re: [PATCH] selftests: fib_tests: mute cleanup error message
Message-ID: <ZGRthdt5u88zs6xy@shredder>
References: <20230517041119.202072-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517041119.202072-1-po-hsu.lin@canonical.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 12:11:19PM +0800, Po-Hsu Lin wrote:
> In the end of the test, there will be an error message induced by the
> `ip netns del ns1` command in cleanup()
> 
>   Tests passed: 201
>   Tests failed:   0
>   Cannot remove namespace file "/run/netns/ns1": No such file or directory
> 
> Redirect the error message to /dev/null to mute it.
> 
> Fixes: a0e11da78f48 ("fib_tests: Add tests for metrics on routes")

I don't think this tag is correct. More likely that this is caused by
commit b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit").

You can even reproduce it with '-h':

# ./fib_tests.sh -h
usage: fib_tests.sh OPTS
[...]
Cannot remove namespace file "/var/run/netns/ns1": No such file or directory

Reverting the commit I mentioned makes it go away.

Also, please use "PATCH net" prefix:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-dr
