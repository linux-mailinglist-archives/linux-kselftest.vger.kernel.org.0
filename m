Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C273B2F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 10:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjFWIvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjFWIvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 04:51:47 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81371731
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 01:51:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 712C124010C
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 10:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687510302; bh=B1c7aclKQlYnbAu4S2v+VVqp1E6daoHU8MjvPcNrGNA=;
        h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
         Message-ID:From;
        b=g/FFazuPoHXK0hRGWywrWG3suHsNGWkJB0tV+CHSY+gdr7TjUDRy7KN1VoyTCfnq8
         1ypKDAbljvq19ZK6620XsQ1i5hPA3HdwyGEDf3YhJOXQ34v8zCBZfLPMZb6zKOfpVZ
         dSQVS65rds9WP31vcLE6imHgkknbx7ZrCk3gHFhQSXxnGgLpUNmT1zmLom2dVAX1u/
         9INrxqC0tJIMaVAiDcpNoj4XQqBGV5Odt+O9t1TLgwbpnMTi+mhI04yVrHy4ohKSE2
         7UWn8h3J10tUu8s0xUHXYGPzkFD57BOLQfggmKBqXj4gtbL/QcXthHPvBNA4gmXmPL
         p+BcoUxt7Z13g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QnWF755Jkz9rxQ;
        Fri, 23 Jun 2023 10:51:39 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Jun 2023 08:51:39 +0000
From:   Yueh-Shun Li <shamrocklee@posteo.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com,
        pabeni@redhat.com, apw@canonical.com, joe@perches.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
In-Reply-To: <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
Message-ID: <50a88781b9e2a80588438c315167bbec@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Maintainer,

On 23.06.2023 04:50, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 22 Jun 2023 01:26:21 +0000 you wrote:
>> Fix typos about "transmit" missing the first "s"
>> found by searching with keyword "tram" in the first 7
>> patches.
>> 
>> Add related patterns to "scripts/spelling.txt" in the
>> last patch.
>> 
>> [...]

Thanks for merging!

> Here is the summary with links:
>   - [1/8] RDMA/rxe: fix comment typo
>     (no matching commit)
>   - [2/8] i40e, xsk: fix comment typo
>     https://git.kernel.org/netdev/net-next/c/b028813ac973
>   - [3/8] zd1211rw: fix comment typo
>     (no matching commit)
>   - [4/8] scsi: fix comment typo
>     (no matching commit)
>   - [5/8] tcp: fix comment typo
>     https://git.kernel.org/netdev/net-next/c/304b1875ba02
>   - [6/8] net/tls: fix comment typo
>     https://git.kernel.org/netdev/net-next/c/a0e128ef88e4
>   - [7/8] selftests: mptcp: connect: fix comment typo
>     (no matching commit)
>   - [8/8] scripts/spelling.txt: Add "transmit" patterns
>     (no matching commit)
> 
> You are awesome, thank you!

Should I rebase the local branch onto netdev/net-next/main
and send the "no matching commit" patches again?

Best regards,

Shamrock
