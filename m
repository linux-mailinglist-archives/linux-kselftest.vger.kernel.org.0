Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07375A008F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiHXRkU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbiHXRkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 13:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209837C741;
        Wed, 24 Aug 2022 10:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8B0EB82619;
        Wed, 24 Aug 2022 17:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 991CFC433D7;
        Wed, 24 Aug 2022 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661362815;
        bh=6SRnsy3I79MO/6iM4jUHX42tTVHn9dq4eiC6x4O06n4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G2Bgg4aRQPmX0/RdgLPueS5jv1K0+GylZ2c+keEqRhjQ3Bu3+re9a0Xjda5cyp+MK
         JtB20mGmZa+guzYmcbwOkbzdCmQZw2OjYsRvsWwieOCOESnfP7QTQIKBEva5e4jPQu
         1ijsodkY/PAChbLNtPx0WpjXkbDCC+5XI9c1N55ue/4rod6y5Lxb1gPU74aXU8XD+U
         5Gr8jYO4+RdoIqw6ukj4z5Fo16zYVk0OJs9UhTIKogtrHJKlc8vzjPdNU0vWC55CJh
         K81GpG+Xt9RNVMG9kwJKd0MREPiziafmkI+WgX/BL5eGG7DjLhB74h4nXcKk5juQ/3
         LWJBHE++yDHUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ABEEC04E59;
        Wed, 24 Aug 2022 17:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] selftests/bpf: fix wrong size passed to
 bpf_setsockopt()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166136281549.32250.1908177028143691167.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 17:40:15 +0000
References: <20220824013907.380448-1-yangyingliang@huawei.com>
In-Reply-To: <20220824013907.380448-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, sdf@google.com, kafai@fb.com, ast@kernel.org,
        andrii@kernel.org, mykolal@fb.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 24 Aug 2022 09:39:07 +0800 you wrote:
> sizeof(new_cc) is not real memory size that new_cc point to, introduce
> new_cc_len to store size then pass it to bpf_setsockopt().
> 
> Fixes: 31123c0360e0 ("selftests/bpf: bpf_setsockopt tests")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  tools/testing/selftests/bpf/progs/setget_sockopt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [-next] selftests/bpf: fix wrong size passed to bpf_setsockopt()
    https://git.kernel.org/bpf/bpf-next/c/6fc2838b148f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


