Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9588A1F7067
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKWkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 18:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWkd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F59AC08C5C2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so2903446plr.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjAEn4nKeDwCOI4NoTVgqxZ+RNZ5sAp1L4xhdYv5QUg=;
        b=Ex7sKimHh5q8529081uTPjIXy3tydeTnpuedEdA0ahtsKvI4OrC/MBJYUr2NQTgF91
         R6lEAUuDLP5qln0c2ux+a/i909gvDVZLaqJjvH5t1AWf+EtnO43HmbfxIVxYu/OesNWE
         Dr0opOI6Ljqx7BhT8Doxs3JjHnluY7X7e8oWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjAEn4nKeDwCOI4NoTVgqxZ+RNZ5sAp1L4xhdYv5QUg=;
        b=rvAohnPUeiFkWvj0LuQllFwlw/9Ftunu3t3Ukt/AYqL2vA9Zdzx6hWXwp4HhjDz2Ue
         9bdENayn3hQSn04zNJhX93T3QKDEy5qUu6+mp+m98Qcl8l1PgbDy9rlQYv4uT0GpS2T7
         /oIg8k9A/VDZvbrsY327Btcjnle/2RwbTg/tEgCVd9yR2+ba5uULHatnzyrjYYUCZpBa
         Tol7Zbtr5KN8YPXHnhgvlBpTuSL/g9cskhe7ovzbC5Yyvsbd1lq6T0xNIvaBWCddUd3V
         r2/NsBPRlbh9c0k1uUgOoa8i9ynvWi6ouRapTun9QfxgoW6qGLbQPtxt7J/SOIdgoX/b
         FTYg==
X-Gm-Message-State: AOAM531qS3vpt+38XrroqBE6PbkanPPXbggkf0+d3eSKb9WsKYsRbiyz
        sSnw8tK/fO0KZqxQ8ojQat0pFg==
X-Google-Smtp-Source: ABdhPJwX6Ph4qJI+LNzuibWoNdaSL97FGQGesFlYXUstdH+MslUyCsYkGxySybShSkQ1BB0NGFC9WQ==
X-Received: by 2002:a17:90a:acf:: with SMTP id r15mr10419026pje.171.1591915232843;
        Thu, 11 Jun 2020 15:40:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm3488846pjp.37.2020.06.11.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] selftests/harness: Switch to TAP output
Date:   Thu, 11 Jun 2020 15:40:21 -0700
Message-Id: <20200611224028.3275174-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I finally got around to converting the kselftest_harness.h API to actually
use the kselftest.h API so all the tools using it can actually report
TAP correctly. As part of this, there are a bunch of related cleanups,
API updates, and additions.

Thanks!

-Kees

Kees Cook (7):
  selftests/clone3: Reorder reporting output
  selftests: Remove unneeded selftest API headers
  selftests/binderfs: Fix harness API usage
  selftests: Add header documentation and helpers
  selftests/harness: Switch to TAP output
  selftests/harness: Fully track XFAIL reports
  selftests/harness: Display signed values correctly

 tools/testing/selftests/clone3/clone3.c       |   2 +-
 .../selftests/clone3/clone3_clear_sighand.c   |   3 +-
 .../testing/selftests/clone3/clone3_set_tid.c |   2 +-
 .../filesystems/binderfs/binderfs_test.c      | 284 +++++++++---------
 tools/testing/selftests/kselftest.h           |  78 ++++-
 tools/testing/selftests/kselftest_harness.h   | 142 ++++++---
 .../pid_namespace/regression_enomem.c         |   1 -
 .../selftests/pidfd/pidfd_getfd_test.c        |   1 -
 .../selftests/pidfd/pidfd_setns_test.c        |   1 -
 .../selftests/uevent/uevent_filtering.c       |   1 -
 10 files changed, 330 insertions(+), 185 deletions(-)

-- 
2.25.1

