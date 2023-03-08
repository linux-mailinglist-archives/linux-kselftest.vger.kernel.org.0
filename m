Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2C6B11E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 20:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCHTU0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 14:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCHTUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 14:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269CC9C2F;
        Wed,  8 Mar 2023 11:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA0E0B81DE6;
        Wed,  8 Mar 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 869B7C433EF;
        Wed,  8 Mar 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678303218;
        bh=+zgG63gOGty+6DPE1KRHrM6c85j9C/aiwsPfAcdlrbc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=USnIuT/BUjXgdUugydx6zUt3/gRCRzkzRt6ZbOiuPsjdruUaq2oYk/YLYYngWtfTM
         rnFOmO7ZcMc0raBpMQ7kqUmZN4AdIRh2vZRsoDzI3nStYnAc5RNrpjyHXbd3SfilDt
         W15ZRCNyzFSiz05iklHeq0YLI0qhSVDN6OQmMBrtsTMPblBrsLqEWFZ+ECqEouAl/V
         TSzjDmTFC1U6T9KtiCO0KTnE8XKUREMYKn0f/ZHbSPfZ6LVkfzbmng/nHAhLs6kAWx
         MwrezL3bxnW/zRNBra/rC13Ml8WEItkHLPco2L+XL/jWLvCwJgbeXthIbcQv0GRUKt
         57r0dF4AHN8MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66C5BE61B6F;
        Wed,  8 Mar 2023 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix IMA test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167830321841.2736.12501173221675335509.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Mar 2023 19:20:18 +0000
References: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, mattbobrowski@google.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com
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
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  8 Mar 2023 11:37:13 +0100 you wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLECTED
> flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
> digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash()
> still returned also non-fresh digests.
> 
> [...]

Here is the summary with links:
  - bpf: Fix IMA test
    https://git.kernel.org/bpf/bpf-next/c/12fabae03ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


