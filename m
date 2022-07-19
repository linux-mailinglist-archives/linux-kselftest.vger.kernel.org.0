Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520757A5C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiGSRuV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiGSRuU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA7DEED;
        Tue, 19 Jul 2022 10:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A76C4B81C6D;
        Tue, 19 Jul 2022 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3782FC341CB;
        Tue, 19 Jul 2022 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658253015;
        bh=CsBUUSUY2k0tJQ7QMwrEaKhGV30EKp8Ch1G8yux4MVo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bU5dXIO4zWfRIlile8se53wlDZlgl0JkgDsjbLOdZ8//41fiK5cte/SCf0Nne+bMF
         BUDleGozmd/CS8XNJn/tZAEv8mesNmzyCTOg8prZ0DIDxqqfFdmIvF+F/ZYNDk4Pwx
         zZ6vAIxhFPHon72SMKF/QrHb7Ps7psbbWxUG0/jqvRjnARHu2Xx5ASgV2MpDXPE5Sm
         NsMdoES7mQiyyGng7qtpT9FaZV3My/EYaEZunS+mwtv0pp8kR95Kf/TtiTJJUvY8Ww
         0IptFF4kOFnZRf1S/yfLxeCYaJ0z1sMD7uYmrGSQMqsPtoLph7AoRPDEBCChjwWTz4
         THekbVJmNJIXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CED8E451BA;
        Tue, 19 Jul 2022 17:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: fix a test for snprintf() overflow
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165825301511.17492.5558494324495598478.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Jul 2022 17:50:15 +0000
References: <YtZ+aD/tZMkgOUw+@kili>
In-Reply-To: <YtZ+aD/tZMkgOUw+@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     andrii@kernel.org, kafai@fb.com, daniel@iogearbox.net,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
        hengqi.chen@gmail.com, quentin@isovalent.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Jul 2022 12:50:32 +0300 you wrote:
> The snprintf() function returns the number of bytes which *would*
> have been copied if there were space.  In other words, it can be
> > sizeof(pin_path).
> 
> Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: fix a test for snprintf() overflow
    https://git.kernel.org/bpf/bpf-next/c/c5d22f4cfe8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


