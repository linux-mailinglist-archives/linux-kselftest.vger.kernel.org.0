Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E10C50458E
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiDPVXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Apr 2022 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiDPVX3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Apr 2022 17:23:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED99A24581
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Apr 2022 14:20:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k14so12323570pga.0
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Apr 2022 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Dq+xhlV8ArSu2UejpBmVOFKT+aSiPfM12i4eY7jeTgA=;
        b=d32BG1VG4X9CPx5WhgzJSzeTD2F6LQhNi0rWBOwy7HLoA0+v9S7a2GiQorZiR0Nqup
         pAPxPDM0YT3XUANBr0jbD5k53O9Iazp7A5/lQQjwv1Qe3uSTX07Ka9C5zbW/kbwut3hG
         WDXgE8qEP9IbHdQCDGw6yviNyZL1xORCxeWg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Dq+xhlV8ArSu2UejpBmVOFKT+aSiPfM12i4eY7jeTgA=;
        b=t+vklYUW5I5cBWwXoB99qtwR24L3fRRRJ/ic2fc+WaStVitLChDNF3kCI0ILgxqsMo
         bF1NhYh9C+147rfFktOqOvyWOakzu/66Do8k1vuGLOT7qkmC6vxKfm2L0XMsUF5iClyt
         6iSGUS+gYQfszEYXe6AAyhR368Gu9wrPWS+u8U7C0xRYfgLQREgEYQ3RVAlM3oMQn5/q
         wGmCRj/UzYNomKgeZYeqSQ6OkE/KTNfTvrEExcf3YeHxYsT/V81gjl7yL2UmVld6udW3
         PNLJBNSaEDGiQaRvhubYYFFCstOTAog8qHkskhl1Sx/T5XT8d4ZV7tC5a4cJqh2LE0Mx
         6Q2w==
X-Gm-Message-State: AOAM531+sq7hNWf8jFyH1wxjc2ff/A8pIx/T5eIz8wYJmgNhXmbDSfF6
        2zj2wLKbq5THDobqC0A8bp7zQAKCplJUtg==
X-Google-Smtp-Source: ABdhPJxVJM6WbMiw/foVB0PGcvedJTuFvntFSCxHLudMacOuSNlqmlsbcef9x62hi1J6i53zd7ypeA==
X-Received: by 2002:a63:7e4b:0:b0:3a5:6636:5b94 with SMTP id o11-20020a637e4b000000b003a566365b94mr3273096pgn.173.1650144055451;
        Sat, 16 Apr 2022 14:20:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ay13-20020a056a00300d00b0050a5af3fbc7sm1731994pfb.220.2022.04.16.14.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 14:20:55 -0700 (PDT)
Date:   Sat, 16 Apr 2022 14:20:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL drivers/misc] lkdtm updates for next
Message-ID: <202204161420.168B8DDBE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

Please pull these lkdtm updates for -next.

Thanks!

-Kees

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

for you to fetch changes up to 2e53b877dc1258d4ac3de98f496bb88ec3bf5e25:

  lkdtm: Add CFI_BACKWARD to test ROP mitigations (2022-04-16 13:57:23 -0700)

----------------------------------------------------------------
lkdtm updates for next

Christophe Leroy (1):
      lkdtm/bugs: Don't expect thread termination without CONFIG_UBSAN_TRAP

Jiasheng Jiang (1):
      lkdtm/bugs: Check for the NULL pointer after calling kmalloc

Kees Cook (4):
      lkdtm/heap: Note conditions for SLAB_LINEAR_OVERFLOW
      lkdtm/usercopy: Expand size of "out of frame" object
      lkdtm: Move crashtype definitions into each category
      lkdtm: Add CFI_BACKWARD to test ROP mitigations

----------------------------------------------------------------

 drivers/misc/lkdtm/bugs.c               |  96 +++++++++++++++------
 drivers/misc/lkdtm/cfi.c                | 145 +++++++++++++++++++++++++++++++-
 drivers/misc/lkdtm/core.c               | 138 +++++++-----------------------
 drivers/misc/lkdtm/fortify.c            |  17 +++-
 drivers/misc/lkdtm/heap.c               |  47 ++++++++---
 drivers/misc/lkdtm/lkdtm.h              | 142 ++++++++-----------------------
 drivers/misc/lkdtm/perms.c              |  47 ++++++++---
 drivers/misc/lkdtm/powerpc.c            |  11 ++-
 drivers/misc/lkdtm/refcount.c           |  65 +++++++++-----
 drivers/misc/lkdtm/stackleak.c          |  11 ++-
 drivers/misc/lkdtm/usercopy.c           |  49 ++++++++---
 tools/testing/selftests/lkdtm/config    |   2 +
 tools/testing/selftests/lkdtm/tests.txt |   1 +
 13 files changed, 471 insertions(+), 300 deletions(-)

-- 
Kees Cook
