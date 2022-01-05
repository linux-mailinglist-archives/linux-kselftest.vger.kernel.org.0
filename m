Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8303E485724
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbiAERVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 12:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiAERVC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 12:21:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD3C061201
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Jan 2022 09:21:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s15so49392plg.12
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jan 2022 09:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xzldlHLX0WLbmbgJQSeuVLDmx33+BJsUhVBrHrI/HwQ=;
        b=NDKewqkZ4E87rhkXniYiKF9hNJ+Sl9e9LrHJpvlWG+B2F9b/K/eONMcW8ipJ+tI+gy
         eZgZGkdaV+VevIV8fj55XKcy1wt2HU3mbouQgzvqfNIZ/4znv4cWiLjFAUgsO1Iu/gO/
         FiaJSlwdSu2iTULAdm9poe3x+eZ28HAC6znkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xzldlHLX0WLbmbgJQSeuVLDmx33+BJsUhVBrHrI/HwQ=;
        b=TFokECvkJOLOf2/BciRygOh6iELO9ApWkerr117lGpdDMyYpYCj2VRbbSlbOkNogFj
         0VtHJhZhfbXZ0hIc6i8Mg4BpUrTefWw9U28Uj067mIGSICcAKVuxrmu0rRVdkpMIJeSi
         QK/+z85tuNKUKEVIVRhgyRC3NYw+UWrIJFBpalz9HMlHIKBEH0PgyFGKs8AK/q9G+QiG
         ZDcGm/wMQHhvMpPp1RI2fAPnemBW0Z6fcXJJlDv8uV5YFbxQSEe0GUUNXJEsqt0/IDEn
         32Re76JZtBMgRlg73ZnovJWR+vkDAzhHCjBpaGvUHujB5PWbyyFnkB4/Klj8EBIDhHII
         kIPQ==
X-Gm-Message-State: AOAM531NnqzyNWQUTrhMEp4g++gttRFyBDeCJsWpu4utvb1WmZQew0xA
        NZl5HrooPTITXZyFvvUQ90Sf6A==
X-Google-Smtp-Source: ABdhPJwDQ5Z6I7V0z/hRQp4KKAtm+dG+xHrGnS0RON2vZfGnhC12VVJtwoCqQbcCfyl2a9ptsZQtXw==
X-Received: by 2002:a17:902:8544:b0:142:66e7:afbb with SMTP id d4-20020a170902854400b0014266e7afbbmr54658947plo.62.1641403260829;
        Wed, 05 Jan 2022 09:21:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm3217358pjj.3.2022.01.05.09.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:21:00 -0800 (PST)
Date:   Wed, 5 Jan 2022 09:20:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp updates for v5.17-rc1
Message-ID: <202201050919.9DF1B7D60@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Linus,

Please pull these seccomp selftest updates for v5.17-rc1. The core
seccomp code hasn't changed for this cycle, but the selftests were
improved while helping to debug the recent signal handling refactoring
work Eric did.

Thanks!

-Kees

The following changes since commit d9bbdbf324cda23aa44873f505be77ed4b61d79c:

  x86: deduplicate the spectre_v2_user documentation (2021-10-04 12:12:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.17-rc1

for you to fetch changes up to 1e6d69c7b9cd7735bbf4c6754ccbb9cce8bd8ff4:

  selftests/seccomp: Report event mismatches more clearly (2021-11-03 12:02:07 -0700)

----------------------------------------------------------------
seccomp updates for v5.17-rc1

- Improve seccomp selftests in support of signal handler refactoring (Kees Cook)

----------------------------------------------------------------
Kees Cook (2):
      selftests/seccomp: Stop USER_NOTIF test if kcmp() fails
      selftests/seccomp: Report event mismatches more clearly

 tools/testing/selftests/seccomp/seccomp_bpf.c | 56 ++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

-- 
Kees Cook
