Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564D0D004F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfJHSAK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 14:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfJHSAK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 14:00:10 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570557609;
        bh=HwzVqlpqTlUCC0/ZTEjrzR58/tMSplLoD1BQABsruxQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ciRhypSKlarR/snUNq1fn+bjKOyy6Qr+d0GDLdrdE5uAg1QWw+JToScxakmArZ8ZQ
         5iGB4817VhPoUhjYOAAZPQM7+VLV2YFLpwCz2b/6D1zYpOldnA/h3p888HtPMo5Gx2
         5lObbEG/w0RapP5hN6aoh19HXpMeU+JgRye/3mtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
References: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.4-rc3
X-PR-Tracked-Commit-Id: ce3a677802121e038d2f062e90f96f84e7351da0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f54e66ae770fe559fb21383f95d739ac74c03ea8
Message-Id: <157055760984.21274.18416681419306362425.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Oct 2019 18:00:09 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Mon, 7 Oct 2019 15:02:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f54e66ae770fe559fb21383f95d739ac74c03ea8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
