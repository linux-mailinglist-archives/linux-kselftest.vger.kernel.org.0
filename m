Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655E77BDAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjHNQKx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHNQKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 12:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDEA115
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 09:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6983B63C9A
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 16:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F32C433CA;
        Mon, 14 Aug 2023 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692029421;
        bh=zni9T56LYbVj+/ygAvFBZMYd9kZJ1T1YQExPsHa2WYE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Scj5OUKR46J1CUhrSuAV1J7IT7h7O2E0iLHIE6RQEiy75PabbhzMni/kxGbsoQiar
         ydF+uDTNoOTVwKOYtxa1J0k2mXYQR9SLpDmSpbzrs6Akh3POnQ0ccudnOMLQykPnDm
         MZGmIIcplnmDlf1E4zCP7Wox5CNmX3nf/BdkehmMLDy0nM8kPOK8MR4dw6jhh12bK/
         LgBWYtg7tVRkNdBg0rPuo8L5JvdSEyXRrN5sD+LMuIxgJ84pJQq2o81VfMKBQfJatl
         BYuTOw60ldCU8EY1vZ0dNGtiu0TS6Pc4KqCG2LTxCEIrYA2WK2SSWap36CnVMjno0+
         G+bKmuY42zWGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94AEDC395C5;
        Mon, 14 Aug 2023 16:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next] selftests/bpf: fix repeat option when kfunc_call verify
 fail
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169202942160.12578.16793476914030238239.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 16:10:21 +0000
References: <20230814031434.3077944-1-zouyipeng@huawei.com>
In-Reply-To: <20230814031434.3077944-1-zouyipeng@huawei.com>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, benjamin.tissoires@redhat.com,
        void@manifault.com, memxor@gmail.com, iii@linux.ibm.com,
        colin.i.king@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 14 Aug 2023 11:14:34 +0800 you wrote:
> There is no way to set topts.repeat=1 when tc_test going to verify fail.
> 
> Maybe it's clerical error, fix it directly.
> 
> Fixes: fb66223a244f ("selftests/bpf: add test for accessing ctx from syscall program type")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> Reviewed-by: Li Zetao <lizetao1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix repeat option when kfunc_call verify fail
    https://git.kernel.org/bpf/bpf-next/c/811915db674f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


