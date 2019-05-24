Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6422A17C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2019 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfEXXPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 19:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfEXXPR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 19:15:17 -0400
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558739717;
        bh=dWSz4+g/jY1UJuyGYvqzv8BJfXUPGCTRSEnGNcRqVno=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OsVjy1wIvxZPIkLdtlN7AAWOliex+v42Gzb2YFPdBI1EwVIgdq5/YuSeBTXdMyfKD
         /OdN8GxGq5dV0q9BfkCjbMzgFED1OgpSfGfJK4sQlWB1FbjY1BPyQFBW/cD4mBXCAU
         QC8CZkUJm289NVmOfmBbmNLHOKcOc5EuEI8qDwgU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
References: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc2
X-PR-Tracked-Commit-Id: fe48319243a626c860fd666ca032daacc2ba84a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f8b40e3dbcd7dbeabe6be8f157376ef0b890e06
Message-Id: <155873971735.4676.15830422826307745956.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 23:15:17 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tong Bo <bo.tong@intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 15:19:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f8b40e3dbcd7dbeabe6be8f157376ef0b890e06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
