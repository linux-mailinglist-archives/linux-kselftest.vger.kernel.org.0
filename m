Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2C786AAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjHXIua (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjHXIuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 04:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEDE7F
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 01:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C358366809
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 08:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDFC433C9;
        Thu, 24 Aug 2023 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692867021;
        bh=jvmeqWtT+a95MPO2TYGl+YZLchPcbm7vpnWoKkHsTr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7XwvjGSkwadPCyOme2Y80LtvEzWAmaGiqzGu9KuHeBfDHJdyfgOY2puZax44q/vO
         nLQ4INGXuMQChKuWM8U1O+MdZwInT3WTZ2b+bcx2CedOb/AtVcjiAcbK1XqxbCF52z
         xAFa4W5Kmqdi6Bcl19qThqdapio0h5MSS/YU/EYYO/WJDaifUbUr0s3LJGGSHxvRmc
         nNAM+E4DMdHW2qHBi9YsHJgb4pJDfwnrKTiQ4ehtdrScEawPPpJk5QSlmoW4cTmD+E
         Idn/8V+GWVx3VmYou3xnDrRha8HYUQ33X34Ksl/R7RIPmgG9ybyv53gcASkKIXzRTK
         snNqLSpYe1peA==
Date:   Thu, 24 Aug 2023 10:50:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] selftests: bonding: delete link1_1 in the
 cleanup path
Message-ID: <20230824085007.GE3523530@kernel.org>
References: <20230823032640.3609934-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823032640.3609934-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 23, 2023 at 11:26:40AM +0800, Zhengchao Shao wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So delete link1_1 in the cleanup path and
> drop any warning message.

Hi Zhengchao Shao,

It seems unfortunate to drop all warning and error messages.
What if the message is about something other than link1_1 not existing?

Would it be practical to check if link1_1 exists,
say by looking in sysfs, before trying to delete it?

> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  .../drivers/net/bonding/bond-arp-interval-causes-panic.sh        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> index 7b2d421f09cf..2b3c678c5205 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
> @@ -11,6 +11,7 @@ finish()
>  {
>  	ip netns delete server || true
>  	ip netns delete client || true
> +	ip link del link1_1 >/dev/null 2>&1
>  }
>  
>  trap finish EXIT
> -- 
> 2.34.1
> 
> 
