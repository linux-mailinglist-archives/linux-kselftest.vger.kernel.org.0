Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E334531CA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiEWTcC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 15:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiEWTbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 15:31:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771651A35AD
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 12:15:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so13932064plr.9
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cjRWuQZ93kuxRw6yGmaFXUYJuxX5iPSMUJJ9xKa/vYo=;
        b=JVK82Ctnwdwz61WxUTfwDOYI3ZVFigTNJQ8LlEDBLTt3cACXrmOKg/qoijzXyli87x
         9T4uBrM2lRmzwV1gec1ZMSjGViC1ioL6nlMnXMuEyPvbcpQ3S+7iHsFIXS1GCsuXMKMK
         +K93KzpF3ygjm1GQFC1xq7pCJxv+KKVCzJaSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cjRWuQZ93kuxRw6yGmaFXUYJuxX5iPSMUJJ9xKa/vYo=;
        b=X2QPGjz5YhGlGkR7/3E6018gQoP3CckXAc2MEEgpwA5DPXQgtSMygfxC13cNK2qycI
         ufzTY7BzPuWOv0B2VOCo8a66PxX7aC0zWZ/XhWSkMIen26Ad0Jq6/gMXb302BsMHj/qL
         H5q0SYChmriGeGaza4d62uuZ17QI3f43zr6BWcpe/PtVPbjSLBaI2kITKs5aPZA8JOD6
         F1iUQtJnRy1x35w+X8muxO+aub15/xPBNGmMSwU02qlU8EwJafDVF0hmqxr4Cn2hs61w
         VMXKuehQBpucoZvltSZQj8KRiUXP7J9y7UFNr/r7xAMQWIJPXydMGxgfD8yLbO4SqDLp
         8K8w==
X-Gm-Message-State: AOAM532JB4HO4yGKZfAuh6uLvwk4CWBdRQ1lICAlqhNlrmF32Yt2+Mb+
        I0AVOdcWt5E4F1smwjtaCdG71g==
X-Google-Smtp-Source: ABdhPJxzOIkdif6JjqjzG4OZ0myjpLUV6IyYJXeSyqcSbsVInXtmky5R6N/yKD6TWbhHqlyDcFWirw==
X-Received: by 2002:a17:902:e989:b0:15f:1545:326d with SMTP id f9-20020a170902e98900b0015f1545326dmr24252520plb.119.1653333302974;
        Mon, 23 May 2022 12:15:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090a928600b001df82551cf2sm39174pjo.44.2022.05.23.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:15:02 -0700 (PDT)
Date:   Mon, 23 May 2022 12:15:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        David Yang <davidcomponentone@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Yang Guang <yang.guang5@zte.com.cn>
Subject: [GIT PULL] seccomp updates for v5.19-rc1
Message-ID: <202205231214.ED9D18F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v5.19-rc1.

Thanks!

-Kees

The following changes since commit 2bfed7d2ffa5d86c462d3e2067f2832eaf8c04c7:

  selftests/seccomp: Don't call read() on TTY from background pgrp (2022-04-29 11:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.19-rc1

for you to fetch changes up to 5e91d2a4146946ea0abc984ca957f12b70632901:

  selftests/seccomp: Fix spelling mistake "Coud" -> "Could" (2022-05-04 13:31:21 -0700)

----------------------------------------------------------------
seccomp updates for v5.19-rc1

- Rework USER_NOTIF notification ordering and kill logic (Sargun Dhillon)

- Improved PTRACE_O_SUSPEND_SECCOMP selftest (Jann Horn)

- Gracefully handle failed unshare() in selftests (Yang Guang)

- Spelling fix (Colin Ian King)

----------------------------------------------------------------
Colin Ian King (1):
      selftests/seccomp: Fix spelling mistake "Coud" -> "Could"

Jann Horn (1):
      selftests/seccomp: Test PTRACE_O_SUSPEND_SECCOMP without CAP_SYS_ADMIN

Sargun Dhillon (5):
      seccomp: Use FIFO semantics to order notifications
      selftests/seccomp: Ensure that notifications come in FIFO order
      seccomp: Add wait_killable semantic to seccomp user notifier
      selftests/seccomp: Refactor get_proc_stat to split out file reading code
      selftests/seccomp: Add test for wait killable notifier

Yang Guang (1):
      selftests/seccomp: Add SKIP for failed unshare()

 Documentation/userspace-api/seccomp_filter.rst |  10 +
 include/linux/seccomp.h                        |   3 +-
 include/uapi/linux/seccomp.h                   |   2 +
 kernel/seccomp.c                               |  44 ++-
 tools/testing/selftests/seccomp/Makefile       |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c  | 427 ++++++++++++++++++++++++-
 6 files changed, 482 insertions(+), 5 deletions(-)

-- 
Kees Cook
