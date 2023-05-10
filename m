Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F46FE4A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjEJTz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 15:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEJTz4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 15:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831B44A8;
        Wed, 10 May 2023 12:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99FAF63FE0;
        Wed, 10 May 2023 19:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A230C433EF;
        Wed, 10 May 2023 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683748555;
        bh=RYWlkEMmtKFcnSA1V7d0hw2msjiuCUgItNg8KSF4cFo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Atwqa+YzIQfnswYmmBW4QgMpJubIDT7+rloomC7xWS6GNM+c3oGS0NWzMVdCF1sb/
         BbI9qqoJ5DlKvfDSybwo3Phg8AMVi10krhWhwnQE0So/E6UhozBL4bJ1aryvfHy2he
         /XxzmOgKaHpCxepDnJ8gsYU74QtoOgBm4cGdRNqGzd2G+rAKZ4TG9kA5eWz2QgCd4K
         3G9Kax56/pBiaBIPZqbsUENzp1dRdoOSQZUhjvZIPpnsBgjCBst+yQHzoFuf1yC478
         DRvW9tD7IBFXnv8dNiIM7/oLy+wyJDF7TLEQXSDUtjHi9e6hh/dzbyhN0cu0/mHtJU
         6xGtxjwMxGvgw==
Message-ID: <03652ea0-09fc-6185-e71e-5ad603811609@kernel.org>
Date:   Wed, 10 May 2023 13:55:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [net 1/2] selftests: seg6: disable DAD on IPv6 router cfg for
 srv6_end_dt4_l3vpn_test
Content-Language: en-US
To:     Andrea Mayer <andrea.mayer@uniroma2.it>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>
References: <20230510111638.12408-1-andrea.mayer@uniroma2.it>
 <20230510111638.12408-2-andrea.mayer@uniroma2.it>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230510111638.12408-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/23 5:16 AM, Andrea Mayer wrote:
> The srv6_end_dt4_l3vpn_test instantiates a virtual network consisting of
> several routers (rt-1, rt-2) and hosts.
> When the IPv6 addresses of rt-{1,2} routers are configured, the Deduplicate
> Address Detection (DAD) kicks in when enabled in the Linux distros running
> the selftests. DAD is used to check whether an IPv6 address is already
> assigned in a network. Such a mechanism consists of sending an ICMPv6 Echo
> Request and waiting for a reply.
> As the DAD process could take too long to complete, it may cause the
> failing of some tests carried out by the srv6_end_dt4_l3vpn_test script.
> 
> To make the srv6_end_dt4_l3vpn_test more robust, we disable DAD on routers
> since we configure the virtual network manually and do not need any address
> deduplication mechanism at all.
> 
> Fixes: 2195444e09b4 ("selftests: add selftest for the SRv6 End.DT4 behavior")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


