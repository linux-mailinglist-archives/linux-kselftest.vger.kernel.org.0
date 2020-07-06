Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C75216001
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGFURa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgGFUR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE31C08C5E0
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 13:17:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so15762407plo.7
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vf4k4Ca2nC/UfmU2LxKOu9rGFn+24YTVR8SOW5pJDec=;
        b=mJU+sunK9zmAyi94aCrQaVMEcNI9fn4lmtE75ZhOryFRcI5/2/Y3okHuI5wzVQTZ0F
         SbtV5x1CJaMOcfiR79RFgYVBA8loddfYiYJUib7+F+erFyU6Xrgp+o/GLSxwl1owwifi
         Oh6VXWDp5quFpNnUiennE/lwBZqWhCr3rnQnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vf4k4Ca2nC/UfmU2LxKOu9rGFn+24YTVR8SOW5pJDec=;
        b=unLekzmqdeTo+p4S/II2cE8mhIVt/lPgVasmSCX/VP/Yz0PZ2wvRKcds4S/OkltK4R
         otXjgQWB3+qQmXLeCE5E1/viI3pTvwFcHlJcN6gbguWOFzQpO5D9tlJshmLm9R5jNHNr
         /1hVOoKGcAWqHOV6W3pluH1jo83pQ5eIPmwGaQMAu0SSvbCjnBPr6Yqs+CHfKzmCI4D5
         2mTkywnSnuCz7ypSo8I2U+ueiE0AhjWewOneDcbx8dIZTYSQqFON/bOqyg3Q8KhgKQE5
         RZsrwz0Ka/iHmzElFwqJTAiO13Wkp/pWSMT5Zun2wj7Mi0vmDCoVU/3hUfK3M2K1vWN7
         EzdA==
X-Gm-Message-State: AOAM530BzcExVtfG7sJ9Iz9F1uTIfNITOOBTVxm2Ol7WMWmI5i0k7qve
        CbN0j1qVPIMbWWG5eSbj22YWRQ==
X-Google-Smtp-Source: ABdhPJzOvQDeykz31VBtkhS2Id0OhcoG/jXjb7a9fQnSucy63QTtpHAuZEVpfeWypZ6tk3Q+EfIw3w==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr42813271plo.270.1594066648526;
        Mon, 06 Jul 2020 13:17:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm291257pjb.34.2020.07.06.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/7] Add seccomp notifier ioctl that enables adding fds
Date:   Mon,  6 Jul 2020 13:17:13 -0700
Message-Id: <20200706201720.3482959-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

v6:
- fix missing fput()
- API name change: s/fd_install_received/receive_fd/
v5: https://lore.kernel.org/lkml/20200617220327.3731559-1-keescook@chromium.org/

This continues the thread-merge between [1] and [2]. tl;dr: add a way for
a seccomp user_notif process manager to inject files into the managed
process in order to handle emulation of various fd-returning syscalls
across security boundaries. Containers folks and Chrome are in need
of the feature, and investigating this solution uncovered (and fixed)
implementation issues with existing file sending routines.

I intend to carry this in the for-next/seccomp tree, unless someone
has objections. :) Please review and test!

-Kees

[1] https://lore.kernel.org/lkml/20200603011044.7972-1-sargun@sargun.me/
[2] https://lore.kernel.org/lkml/20200610045214.1175600-1-keescook@chromium.org/


Kees Cook (5):
  net/scm: Regularize compat handling of scm_detach_fds()
  fs: Move __scm_install_fd() to __receive_fd()
  fs: Add receive_fd() wrapper for __receive_fd()
  pidfd: Replace open-coded partial receive_fd()
  fs: Expand __receive_fd() to accept existing fd

Sargun Dhillon (2):
  seccomp: Introduce addfd ioctl to seccomp user notifier
  selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD

 fs/file.c                                     |  67 +++++
 include/linux/file.h                          |  19 ++
 include/linux/net.h                           |   9 +
 include/uapi/linux/seccomp.h                  |  22 ++
 kernel/pid.c                                  |  13 +-
 kernel/seccomp.c                              | 172 ++++++++++++-
 net/compat.c                                  |  55 ++---
 net/core/scm.c                                |  50 +---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 229 ++++++++++++++++++
 9 files changed, 554 insertions(+), 82 deletions(-)

-- 
2.25.1

