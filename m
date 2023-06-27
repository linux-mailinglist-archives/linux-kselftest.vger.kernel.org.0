Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81499740379
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjF0Sfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 14:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjF0Sf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 14:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A68430EC;
        Tue, 27 Jun 2023 11:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADD9B61227;
        Tue, 27 Jun 2023 18:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20839C433CC;
        Tue, 27 Jun 2023 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687890789;
        bh=DSB+TJ0bPX66jmUglCTyLCxyLnj/NdkAs2w6aWn30QA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=enhWtum4ga3GNKbs2sapTRRXXf85LqgcaaLk8q0dM/TSnuoGEXGaQhoz25Dqja1O5
         4kVr8E5zL9rvuu+3JUCwW6AQBYccQ5X6EMVMQijk3VpKHQur0btEwTyXcRkRhIVQZC
         o7HdnrktDWGqM9ul0Ujid85JeYnCVRTzBFFC8YcpUBJkUuaRdEN5aOkTbVqShVHOGk
         q+dxcEnGWG/V38axumR/Z6lKr5ne2U0bA9MzAV6GaXukwwwnPWCwjTZnVR3DQ29Z33
         b8y4y8Q4kBsiXTR1T0r2cjjgYMAAzaBC1103mLjoNdjx1eLC1u8DPi5CqB50qGDrYL
         cqy2zHAjUCWYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F391CE5380A;
        Tue, 27 Jun 2023 18:33:08 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org>
References: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.5-rc1
X-PR-Tracked-Commit-Id: 8cd0d8633e2de4e6dd9ddae7980432e726220fdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dedbf31ac8a57eaa29b6e4f9745dadffa83dd947
Message-Id: <168789078899.29279.13086067531930928173.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 18:33:08 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 09:42:33 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dedbf31ac8a57eaa29b6e4f9745dadffa83dd947

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
