Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6BB7B8E38
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 22:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjJDUkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjJDUkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 16:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FB1B8;
        Wed,  4 Oct 2023 13:40:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34070C433C7;
        Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696452028;
        bh=9yZh2beLb9G2aKpM6U7zBwPSD2FoKcYtlW6kX68GteU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GpfoRLTt6lNmVwofbWMhFGJxZ82HcDCnBclDn3BiHTGVC2EMtiOR6DfEUsPdCfzUw
         cfVlMOixBU8LEKwB8yg1gvR/3BWMeE5zwvyBhv02z3h9DlMLEBJe2OjOYcOL56Stsy
         8F3eOcxrVdyiiDdD1vx18RRAF8tKPyefmV3OleIjCDkjvavNSNE3w2VucDIe4rGxS4
         Mj46nrbflO6qS+K9Sz04L5NIQI5CIEHQWAoa5znvmoQxlj829ML08rd/VS3JTWGKMN
         M3Y6zdnYdHeLFrZmTA4YgYm8cW5GHfjxhpCnHA5JM5m6OAUAOHM3GU3JHu6AyxUeVD
         fY9z58Em1TiIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 158A0C595D2;
        Wed,  4 Oct 2023 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftest/bpf,
 riscv: Improved cross-building support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169645202808.14504.11589049001858545591.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 20:40:28 +0000
References: <20231004122721.54525-1-bjorn@kernel.org>
In-Reply-To: <20231004122721.54525-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        mykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        bjorn@rivosinc.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  4 Oct 2023 14:27:18 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Yet another "more cross-building support for RISC-V" series.
> 
> An example how to invoke a gen_tar build:
> 
>   | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- CC=riscv64-linux-gnu-gcc \
>   |    HOSTCC=gcc O=/workspace/kbuild FORMAT= \
>   |    SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" -j $(($(nproc)-1)) \
>   |    -C tools/testing/selftests gen_tar
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Add cross-build support for urandom_read et al
    https://git.kernel.org/bpf/bpf-next/c/97a79e502e25
  - [bpf-next,2/3] selftests/bpf: Enable lld usage for RISC-V
    https://git.kernel.org/bpf/bpf-next/c/72fae6319962
  - [bpf-next,3/3] selftests/bpf: Add uprobe_multi to gen_tar target
    https://git.kernel.org/bpf/bpf-next/c/e096ab9d9f45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


