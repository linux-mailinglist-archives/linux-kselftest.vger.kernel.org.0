Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B85A34A9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 07:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiH0FKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 01:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiH0FKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 01:10:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CAC6B59;
        Fri, 26 Aug 2022 22:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0892CCE262C;
        Sat, 27 Aug 2022 05:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 999B4C433D7;
        Sat, 27 Aug 2022 05:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661577017;
        bh=qxbc6ItJY4JOx9zX20fdcui4zbehBsaR5L57jp+YIQ4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qulo3zfIPbNJzrgOWaOeTz8dRox53mahNpCITXOlfpag56tOHRmLQmpHSelooVuSh
         2VUYIt3J4AJju1on5ysahOxBACFBUApPxop26dBF0VwnySMeQVlOCRUjsM8F+8SxZy
         iSaCDnxcIhxoKpW7TwfDXkv2qvjWgQDEFhgG06ED/g62Oiop0WTHUUTen+T4eFNW6y
         n7+48bzAZlgAEqdR9AGfcE20kN2iKAMLUrMZZ6qTyn74qnNuJwKOevAShrTRJjKJHM
         /QchGYWWi37qjmU7P03C4eaUkMlBKav0EaoMlTG4dPsGP/rsTCPoJKyyP8juga0MlF
         K6gjiKEwe/2mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB55E2A040;
        Sat, 27 Aug 2022 05:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: declare subprog_noise as static in
 tailcall_bpf2bpf4
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166157701750.27504.17586503142900793998.git-patchwork-notify@kernel.org>
Date:   Sat, 27 Aug 2022 05:10:17 +0000
References: <20220826035141.737919-1-james.hilliard1@gmail.com>
In-Reply-To: <20220826035141.737919-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 25 Aug 2022 21:51:39 -0600 you wrote:
> Due to bpf_map_lookup_elem being declared static we need to also
> declare subprog_noise as static.
> 
> Fixes the following error:
> progs/tailcall_bpf2bpf4.c:26:9: error: 'bpf_map_lookup_elem' is static but used in inline function 'subprog_noise' which is not static [-Werror]
>    26 |         bpf_map_lookup_elem(&nop_table, &key);
>       |         ^~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - selftests/bpf: declare subprog_noise as static in tailcall_bpf2bpf4
    https://git.kernel.org/bpf/bpf-next/c/b05d64efbb21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


