Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75A5B2A69
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIHXe2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiIHXeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0411EA7B;
        Thu,  8 Sep 2022 16:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0222B822C0;
        Thu,  8 Sep 2022 23:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FAAC433C1;
        Thu,  8 Sep 2022 23:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662679908;
        bh=U/5tQNvjcfybPHJFh1Z/32quT5JSxEEFgfvgkY+MSWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDEdQtHou+iogq/Roo0Vt9iODcShCBEHoKiYHQLnNMdRhen2BjxPfpgazUaw1+/R9
         EQ6km1Bl2aMFVQpeH47Bf2PA431PrldZvBIag0d963am+0x6sKBkLegJITwNv6OJ8s
         Zf8N8xfDV01a9p6NFr42bxPNQQ4d6EXSxDhScE8vu5jb7nnFeJF4jopHEDujVHRNJK
         RYhtTzUuAdpHe3Yr9HESTTBBez9a7mlHvxvg5QfWN8BiRwJstIb6bWHbrDK+dwTj2v
         Uo3PLvfE0RF82KCdt2zuSlxB36ihJ84fO+FsLKXnuSmniASbCywsPSZfdrRvtA0nYH
         JI1O9CF6bkc9A==
Date:   Fri, 9 Sep 2022 02:31:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] selftests/sgx: Retry the ioctl()'s returned with
 EAGAIN
Message-ID: <Yxp7Xck0/qaGMbH6@kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-2-jarkko@kernel.org>
 <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
 <Yxp4iIKjOQflQC2i@kernel.org>
 <Yxp4syXLQez+BTbw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxp4syXLQez+BTbw@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 09, 2022 at 02:20:22AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 09, 2022 at 02:19:40AM +0300, Jarkko Sakkinen wrote:
> >                 EXPECT_LT(get_time() - start_time(), IOCTL_RETRY_TIMEOUT);
>                                                    ~~
>                                                    typo
> 
> BR, Jarkko

Also, the timeout can probably be like one second.

BR, Jarkko
