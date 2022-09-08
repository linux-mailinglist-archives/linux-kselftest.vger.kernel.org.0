Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A355B2A13
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIHXU3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIHXU2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511379A9E7;
        Thu,  8 Sep 2022 16:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF22661DBB;
        Thu,  8 Sep 2022 23:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A3DC433C1;
        Thu,  8 Sep 2022 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662679226;
        bh=Xk/00DpBqpbqYNO4p/02dYVj8OXERxi6BbI9O7PWTeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYoYe49lVYH5xz62mtmFLFrXYiEn8hn55mslwR/IN8e1T8XUyRyepBokA0l42PKla
         KXABS6b78WaotmjupMDUbxN+4BmoZQlzdSaHPB5SF4AVJ6Vnp0RF12nf4O8+V3Tgii
         EM46w0FT10RBZJ7Ik3A6zdQYB9sN/pbFamjqLjqU8Y4lclEzXJrqWDvfMZzdwGPcYi
         y6N21a7Rl0aYv6KE1PSK19JNWcOhExgR4dR7TW/SjiaxHu2jeKgejjIMZf+mTm53T5
         Kqh74rJRWVud9n2N1lOUd/j1Z9hXwg1MHm8srSk0qMJg1zhLyrUDUn02MVsVPDgTCU
         rlb6iZs1x+/VQ==
Date:   Fri, 9 Sep 2022 02:20:19 +0300
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
Message-ID: <Yxp4syXLQez+BTbw@kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-2-jarkko@kernel.org>
 <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
 <Yxp4iIKjOQflQC2i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxp4iIKjOQflQC2i@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 09, 2022 at 02:19:40AM +0300, Jarkko Sakkinen wrote:
>                 EXPECT_LT(get_time() - start_time(), IOCTL_RETRY_TIMEOUT);
                                                   ~~
                                                   typo

BR, Jarkko
