Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329E641204
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 01:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiLCAaS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 19:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLCAaR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 19:30:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1ECEF8BA;
        Fri,  2 Dec 2022 16:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8056D6244C;
        Sat,  3 Dec 2022 00:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CECFDC433B5;
        Sat,  3 Dec 2022 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670027415;
        bh=ZXVmMePkvpHJsIJDejrE8iTiyBEvakKNE5IpvElaWKs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FRdA+C65UcFDCpsRw4UqXPa1XJdFqB/KpkKn7yKWTeUQLg3dCH1k8oRFQLyeCmk0W
         PBWvDMC6MXoTrzLPawZPGi16CO7M+1iMCj9IqaGhcLIKnKLKwA/Hp1oqYBubfW2pb+
         1sYtERPWwXl6kuJT3riJaqnPEC/hiqOjobHgdvFwr5t/ioG+Oih85/iLmPx+pHbnjK
         +W1vr6lA//owOONVEFGNhvNvf/6OtywVye/ETK5J/Elu4v9xsqhvTpJAt3wNpbeO2F
         d0i8g03uu1GBewmnDHPVHS8Z43svQdsuZ+l/46omNY3DdI7mwVA4lyTaceFBp09fqH
         BXQ5tL/d+XPXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B407BC395EC;
        Sat,  3 Dec 2022 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: add GCC compatible builtins to bpf_legacy.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167002741573.2136.10563307574147228383.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Dec 2022 00:30:15 +0000
References: <20221201190939.3230513-1-james.hilliard1@gmail.com>
In-Reply-To: <20221201190939.3230513-1-james.hilliard1@gmail.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, jose.marchesi@oracle.com,
        david.faust@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, shuah@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Thu,  1 Dec 2022 12:09:39 -0700 you wrote:
> The bpf_legacy.h header uses llvm specific load functions, add
> GCC compatible variants as well to fix tests using these functions
> under GCC.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: David Faust <david.faust@oracle.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: add GCC compatible builtins to bpf_legacy.h
    https://git.kernel.org/bpf/bpf-next/c/f16a7aa5c2be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


