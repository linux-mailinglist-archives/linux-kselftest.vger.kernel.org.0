Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1A457748
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhKSTtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 14:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236232AbhKSTtT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 14:49:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2CD4961A58;
        Fri, 19 Nov 2021 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637351177;
        bh=4ZRhkhKQzjMc0Aq2r6UVZumAqiBxVZvS+ST/nhZP81Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jkfI7pMiXM+i3scSJZFYVlA7BQLyQ8LJlGVhU2EeddX/fSbLFz+ohfiwCVSMRb+X/
         rUckzn0gIl7TyS5XYo0K4EO88ENNXDfdlYUPIE6Oc347Wmd86v8dR5PQlykvwanyxD
         YQqqLXRe+mvNPSQ478wAMWF9l233yPL6IGBXRWArmQYeAO7EFRMlNhSp8pOxBDckKo
         13bc41FtACOz2Y88xBNB8fG6OsC6OoRAHuqsk0xXD6MT8+/ZWHWjbPUtNEJlyERrbX
         G+yKXEsvk+ouxmT0fxf7xkInVnCD59U1CGgsqb+6fN0cgMPL2mfWw+dKgIf6Xl9hTH
         ahTu0vHOyVbNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2528460977;
        Fri, 19 Nov 2021 19:46:17 +0000 (UTC)
Subject: Re: [GIT PULL] SA_IMMUTABLE fixes for v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r1bcnoea.fsf_-_@email.froward.int.ebiederm.org>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
        <202111171049.3F9C5F1@keescook>
        <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
        <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
        <87k0h6334w.fsf@email.froward.int.ebiederm.org>
        <202111171341.41053845C3@keescook>
        <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
        <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
        <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
        <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
        <202111171728.D85A4E2571@keescook>
        <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
        <CAP045Ap=1U07er7Y2XO9wmiRtKLoKL4u8zek48ROU668=G9D3A@mail.gmail.com> <87r1bcnoea.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r1bcnoea.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git SA_IMMUTABLE-fixes-for-v5.16-rc2
X-PR-Tracked-Commit-Id: fcb116bc43c8c37c052530ead79872f8b2615711
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7af959b5d5c8497b423e802e2b0ad847cb29b3d3
Message-Id: <163735117714.2946.16511312928809475443.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Nov 2021 19:46:17 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        Kyle Huey <me@kylehuey.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The pull request you sent on Fri, 19 Nov 2021 09:41:49 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git SA_IMMUTABLE-fixes-for-v5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7af959b5d5c8497b423e802e2b0ad847cb29b3d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
