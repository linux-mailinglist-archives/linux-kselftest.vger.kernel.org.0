Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277022437E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 00:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfETWhx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 18:37:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46792 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfETWhx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 18:37:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so7445433pgb.13
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JwCBVuGEbgWZTqerMXg97XLBl/8qglZ8XiyYccghHL8=;
        b=ndbmROM0gWoBFRY6ntjBqzGYKgi4c4/inbqPg03WTRrETAZwmCWw4xYKOp7lcdjgo2
         vg3ZNZ1Xd6nOQrg2wsprHLJxnIz2m6e3sQKHd4KGwrCn4FMMeUSgEXVw74nBkWP0vUAI
         5MsC2KKa4JH2enUcbPL3DhMIk0WU+u6YeP1pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JwCBVuGEbgWZTqerMXg97XLBl/8qglZ8XiyYccghHL8=;
        b=bImpHm9xJjmH2VGcofpZXgqe5OOY0w/SKiFWuRkVgMOzzKfhkPAaePbtzkbTcB+uQP
         F2Nx36nTq2uG4T2stelVeRGs8G97l6vYtU/mqYrErYP9TIwC1ABrtNVk2Wj65fIwZkBS
         gYQSuj9RSSoUZnnzHTFBZXTKhaNjmNzxtLJfGcIMnDJM+4gMuXI9OKfPG7o7LBb92FvG
         EkcdphXnWREK+t6oSQknTu9PH9XT/M5Ajir8Umms6TIX7RSgekcPEYY+BKg1c4JcVZps
         ExmjR1JTvnIan062U4AlXH4Adr3Z/bVzCG3awFUopQhooY0Wyr6zzbsTqgBduGwKXxY+
         lz1w==
X-Gm-Message-State: APjAAAVUu/qC/IqSssLShcTBZ2HgcK3jqzGoGmvQfDMK4VpU6Lg+MzlI
        sv4YSUf5yBb+MmC11niU9hhKng==
X-Google-Smtp-Source: APXvYqyvQEHfo5lR19KUBwD0DIKvpTDd4rE/uMHHHTYCtQgrA0XcbaDbNo5f5MKaVPYKMf/LIcjTYQ==
X-Received: by 2002:a65:6648:: with SMTP id z8mr28891425pgv.303.1558391872790;
        Mon, 20 May 2019 15:37:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x66sm7707026pfx.139.2019.05.20.15.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 15:37:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5.2-rc2 0/2] selftests: Remove forced unbuffering for test running
Date:   Mon, 20 May 2019 15:37:47 -0700
Message-Id: <20190520223749.13476-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This should fix test regressions seen when running under unbuffered
output. Additionally, fixes are added for the missing flushed output
in the timers test which become obvious without unbuffered output.

-Kees

Kees Cook (2):
  selftests: Remove forced unbuffering for test running
  selftests/timers: Add missing fflush(stdout) calls

 tools/testing/selftests/kselftest/runner.sh     | 12 +-----------
 tools/testing/selftests/timers/adjtick.c        |  1 +
 tools/testing/selftests/timers/leapcrash.c      |  1 +
 tools/testing/selftests/timers/mqueue-lat.c     |  1 +
 tools/testing/selftests/timers/nanosleep.c      |  1 +
 tools/testing/selftests/timers/nsleep-lat.c     |  1 +
 tools/testing/selftests/timers/raw_skew.c       |  1 +
 tools/testing/selftests/timers/set-tai.c        |  1 +
 tools/testing/selftests/timers/set-tz.c         |  2 ++
 tools/testing/selftests/timers/threadtest.c     |  1 +
 tools/testing/selftests/timers/valid-adjtimex.c |  2 ++
 11 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.17.1

