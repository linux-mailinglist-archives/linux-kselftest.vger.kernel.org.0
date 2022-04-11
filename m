Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77C4FC0BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiDKPeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiDKPcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 11:32:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA482B1B2;
        Mon, 11 Apr 2022 08:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02597B80EEB;
        Mon, 11 Apr 2022 15:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9160CC385A9;
        Mon, 11 Apr 2022 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649691014;
        bh=NAF+V0tg8EX7ZyO0a26HoOt1FzaVPobRI691+BuaOHg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jPicT58obIDgn9keF9QoEnJN2rqJVyleTyXboZnmLr/en5goo6fNBCZ8OzFBZDf8q
         O7QZwRZQcuVcQdJIAmMTd6+umgyGICcYDv++xJCGFU4qMQMVbvvk4I73+cGJlkW02p
         nzkS6ROTroISIRG0pI2SyVI2fw2yXIsynjS4RshFwuPkV+PDYI7+jBBbtaM9j2FK4c
         WYzx/UCqXC7OEUkkDTZ1UFWTidsi9cDaTo9/diLyUgGMUo3vFVZzTQvxvun8Tc5X56
         n18VqB/r5Op7n0PFL5GzT0LbuLBQxK62zPF0ypbsOb3FzkiohkhhIotLAhqQaM9d0a
         vc4NoHiKZs+pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57BDEE7399B;
        Mon, 11 Apr 2022 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] drop duplicate max/min definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164969101435.5829.13061515583824165618.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 15:30:14 +0000
References: <cover.1649462033.git.geliang.tang@suse.com>
In-Reply-To: <cover.1649462033.git.geliang.tang@suse.com>
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  9 Apr 2022 07:58:16 +0800 you wrote:
> Two small cleanups for selftests, drop duplicate max/min definitions.
> 
> v3:
>  - move '#include <sys/param.h>' into test_progs.h.
> 
> v2:
>  - do more cleanups as Daniel suggested.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] selftests: bpf: drop duplicate max/min definitions
    https://git.kernel.org/bpf/bpf-next/c/f4fd706f7383
  - [v3,2/2] selftests: mqueue: drop duplicate min definition
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


