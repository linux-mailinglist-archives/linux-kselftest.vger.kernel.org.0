Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA57CE782
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjJRTO3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjJRTO1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 15:14:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A57109
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:14:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0A3C433C8;
        Wed, 18 Oct 2023 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697656465;
        bh=ey2GKZ006LXRzxCMSwHSeWZL7CH0Hr9cB5YCPXl3VXg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=asOOEPbQwFYIC8jx1HRf2cqsEethzzyQPVKXN3W7Fs1T7zrtzy1vIBcpocGamRzu1
         RxN0eDW9jda1UiLATlMLCcr21mbPKdF1IbzyrzG7/W1p7SjrZZe2LNXD7jvwqPjFHC
         OosfIgm1ZV0aBKmPDVvpdfm8TzsNS9T2Bg4GOK+tf2m/dYPaHxCVtk4bqCfCHdtSIf
         EWbk3Ks6kURi49aZdxMIcFfrIbhbYyMzvJr81bRj/lLHGaapcB9Wx9pjfv2GoTiRAQ
         TviMjk2x/vT9SPsjwsIYog0TCkXYtTX4JU6Vwm4BfyZdWxoBI93tg07SW0OkIsYfy0
         d48MNiT/i6/TQ==
Message-ID: <a802bb07-b7d3-4c8b-b0ff-77da021e63fa@kernel.org>
Date:   Wed, 18 Oct 2023 13:14:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/2] add loongarch and riscv support for kprobe
 args test
Content-Language: en-US
To:     Yu Liao <liaoyu15@huawei.com>, skhan@linuxfoundation.org
Cc:     liwei391@huawei.com, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        mhiramat@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231018020858.1304218-1-liaoyu15@huawei.com>
From:   Shuah <shuah@kernel.org>
In-Reply-To: <20231018020858.1304218-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/23 20:08, Yu Liao wrote:
> Yu Liao (2):
>    selftests/ftrace: add loongarch support for kprobe args char tests
>    selftests/ftrace: Add riscv support for kprobe arg tests
> 
>   .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
>   .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
>   .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
>   3 files changed, 13 insertions(+)
> 

Applied these two patches to linux-kselftest next for Linux 6.7-rc1.

thanks,
-- Shuah
