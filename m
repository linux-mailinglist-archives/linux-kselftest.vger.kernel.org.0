Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC07DECB4
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 07:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjKBGA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjKBGA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 02:00:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A312E;
        Wed,  1 Nov 2023 23:00:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 902FEC116AE;
        Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904825;
        bh=TT6oGmKBvrWb94S/vP7d37OfMVFkbdfOksx84tXkYIk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b6XE/ZHBMLjtASbMMN8/6ByBnKKdvtKquvR6CelIrF5eOPLQ8DMZAOljjerNhqK//
         SutgZS76sJlX+YETNSZXTJTqy8c3q2u3lb17gARz9MFjCsGwwqwmH/Rg+hVnE3k2uf
         BIyhuXDqs/yAfTMz46fKjaTrmdAg1ORe1IJmNNKRfzYjKqUtK3nTLAmQcgUj4K8vyr
         9i9B2Px7LEdG4kVIAu2smrPUR+glDlm5BjBdpgL/5sJj4EWiIhriRTMpFSjTkmnxMc
         gTvY/j+3BPwSaeLlhATqdyOBH8/X+GKt0yjy2UfkBw8fXDy5Pj18C3ruQYFsshW5/x
         poDJL7QpB4Nfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A7F3C43168;
        Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Convert CHECK macros to
 ASSERT_* macros in bpf_iter
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169890482549.9002.3230353368904918414.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 06:00:25 +0000
References: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB3PR10MB6835E9C8DFCA226DD6FEF914E8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     bpf@vger.kernel.org, yonghong.song@linux.dev, sinquersw@gmail.com,
        ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, iii@linux.ibm.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuifeng@meta.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mykolal@fb.com, sdf@google.com, shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 28 Oct 2023 10:54:13 +0530 you wrote:
> As it was pointed out by Yonghong Song [1], in the bpf selftests the use
> of the ASSERT_* series of macros is preferred over the CHECK macro.
> This patch replaces all CHECK calls in bpf_iter with the appropriate
> ASSERT_* macros.
> 
> [1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter
    https://git.kernel.org/bpf/bpf-next/c/ed47cb27586d
  - [bpf-next,v3,2/2] selftests/bpf: Add malloc failure checks in bpf_iter
    https://git.kernel.org/bpf/bpf-next/c/cb3c6a58be50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


