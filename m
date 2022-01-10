Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7BF48A0E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbiAJUWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 15:22:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43486 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbiAJUWf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 15:22:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AC061411;
        Mon, 10 Jan 2022 20:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9720C36B03;
        Mon, 10 Jan 2022 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641846155;
        bh=dcodDdtqZ4yql0qkUxPPAie84Q+aoOQgpU8HrY3KYZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jfPfKk0Zv0m4JFHXhzyJ9V0sB7s2Eu3homgS0AD/bBsPnfub4v5TDNBTfQz0dT6Lx
         OorhwiqjrFRSsg1yglyHTbkFx4xAOq0gVJXeg517nkJRN9kXqKtlk7LnR9faWEUtHb
         3c3MfBC0FKLfEloYaqEVHiudD8xBxdKTwLngR90l2GVcLcGFxvtuSZaNsW5kbSEEuU
         vNqgfFhVFvXQ6ZAqCBnWQ92D1Xyzgrd0U4juiKav5gNtT8OHt7uH8Xw22oE4qunDBs
         l/PSbdVwHMB4W9M9ikO+cn7I5xdyk2Xj6jvvHr96gcbAxNM5AGEaywnJ1AzCdWzzGu
         gw5R09VcNnZjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D838CF6078B;
        Mon, 10 Jan 2022 20:22:34 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ccdfab91-3c7a-546e-8e44-9fbd5117ec6b@linuxfoundation.org>
References: <ccdfab91-3c7a-546e-8e44-9fbd5117ec6b@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <ccdfab91-3c7a-546e-8e44-9fbd5117ec6b@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.17-rc1
X-PR-Tracked-Commit-Id: e89908201e2509354c40158b517945bf3d645812
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4369b3cec2134a6b8ff59b0ed5cca2f816d6e388
Message-Id: <164184615488.11936.7038672309749123729.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 20:22:34 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 7 Jan 2022 17:08:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4369b3cec2134a6b8ff59b0ed5cca2f816d6e388

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
