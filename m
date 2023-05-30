Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE471664A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjE3PLB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjE3PK7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 11:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8CF1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 08:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46DD763249
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 15:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74832C433D2;
        Tue, 30 May 2023 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685459451;
        bh=ZIClHKzhAJgMOmlMYYXoKf29s5q4go+EIM79BhbdN18=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B4uwLPQLBceMh9XSxi9MMSDJK/Q7r6DX+mlV8Bd/NX5TRicIjR5eBUoaay3ceAIJl
         0iXulsWzeS2Ga8+S1q8n8sYZ7akpizs5j8hHPvajnrR/kfHUjZhEbau2YKUWsQGclw
         bpCoFhrsU2fjipYFCVQDfj7QFMaEoRZj/helCXwvMPusnHlPQlSbP3bEVw0MgojYon
         jp1yPpqlEHCmSIL8cEj1vxRtxbfkyhKsOvSqOexs7e0Qa4Rrb1wRLhd28SAfK7Irca
         ppzZ7aTczan6zylc52bKVAl+vqKEeKenj2JAnOQVmigKW/xOfA/NUeC5GUkq9YEJe5
         R+q9yZyGMLJmA==
Message-ID: <797fd63a-38d5-c69e-3540-4eb6383f7abf@kernel.org>
Date:   Tue, 30 May 2023 09:10:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next 4/4] selftests: net: Add test cases for nexthop
 groups with invalid neighbors
Content-Language: en-US
To:     Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>
References: <20230529201914.69828-1-bpoirier@nvidia.com>
 <20230529201914.69828-5-bpoirier@nvidia.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230529201914.69828-5-bpoirier@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/29/23 2:19 PM, Benjamin Poirier wrote:
> Add test cases for hash threshold (multipath) nexthop groups with invalid
> neighbors. Check that a nexthop with invalid neighbor is not selected when
> there is another nexthop with a valid neighbor. Check that there is no
> crash when there is no nexthop with a valid neighbor.
> 
> The first test fails before the previous commit in this series.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_nexthops.sh | 129 ++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



