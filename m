Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44478A8F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjH1Jas (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjH1Jac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 05:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5C9E
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 02:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE103635A2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0E9C433C8;
        Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693215029;
        bh=bYNjX9N2ukSGxl1mpAuKF+SDMRngqt4GM3shizKtvfg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZQavHvyCrr5mmh2YacjqvK2OWlTPaa7LwQ/edi6nbXDXVM35z1Vtsk58EKBOBaaPu
         OZSIP2RxuO1MflPiCSRSydUN0N1HV1Xlqt71SJPDZpkgEUd+wsKw91Qp/seWv6xyUw
         pgEPVUVMBs/P8HkCeTxd2uHX8A/qHuIoyZ6bOBZdRaE7A2gaKMPKByxROcoU7FkGE1
         z2HhYPrkMnE8ZnvTfvN4FiSGpY2R/Z0A0An2KaFRmkU21fss1gsmDoUxQNZbcvPDoG
         vDH32hy8re6UmYHo+Qac6U4OIymVb2JAYbSEe/uuqoO+FH8QKnWTOXSZEHsIJtHd8s
         4zDSFjyfGAiLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C3B7C3959E;
        Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3] selftests: bonding: create directly devices in
 the target namespaces
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169321502911.13199.3114963814895556928.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 09:30:29 +0000
References: <20230826022330.3474899-1-shaozhengchao@huawei.com>
In-Reply-To: <20230826022330.3474899-1-shaozhengchao@huawei.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 26 Aug 2023 10:23:30 +0800 you wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So it will be safer creating directly the
> devices in the target namespaces.
> 
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: bonding: create directly devices in the target namespaces
    https://git.kernel.org/bpf/bpf-next/c/bf68583624c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


