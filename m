Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76C716570
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjE3O7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjE3O7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 10:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6611A
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 07:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52517631D5
        for <linux-kselftest@vger.kernel.org>; Tue, 30 May 2023 14:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77879C43446;
        Tue, 30 May 2023 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685458717;
        bh=cBQ4dqX01OLJXHFuDNypBedsmL6W577e01tqCkXAfqQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IqAQ41l4mPu0KJDKfLySQILKWq/N3cMx9QbtI17A5/x15p0r+axju5xlNHwpYXM8B
         MYU8LKYT6crjsVnXvId72z6qh0dj4qy8cTkwsnChRutOt/Y70SNsKn7WZD8DQYTez3
         Rmy4GQd2nmAhn+CXwpZ9stMTUCUnfnIAdQeVl41L4j7fi1+oma9LpWk0e+RZgRTg1I
         EtQjJYPDqALB4ixeL5II5DM5NXhcHe11qUbzY8sPertDH3AD4bjxs/7vSfWXhi7Olp
         sPyVXSjvXgIvmj1BxdQk1PQ0/FfN9KWqaD1Pqp5l1PT023ZQMbyBCRDPHWIXsLpCEJ
         PB1zXEcEOZa3g==
Message-ID: <cd20364d-8b7d-bbc6-a962-185632cc6782@kernel.org>
Date:   Tue, 30 May 2023 08:58:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next 2/4] nexthop: Factor out neighbor validity check
Content-Language: en-US
To:     Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>
References: <20230529201914.69828-1-bpoirier@nvidia.com>
 <20230529201914.69828-3-bpoirier@nvidia.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230529201914.69828-3-bpoirier@nvidia.com>
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
> For legacy nexthops, there is fib_good_nh() to check the neighbor validity.
> In order to make the nexthop object code more similar to the legacy nexthop
> code, factor out the nexthop object neighbor validity check into its own
> function.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


