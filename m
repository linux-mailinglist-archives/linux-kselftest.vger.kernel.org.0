Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB6523E761
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 08:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHGGf5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Aug 2020 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgHGGfv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Aug 2020 02:35:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E9C061575
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Aug 2020 23:35:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so468607pfl.11
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Aug 2020 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sArfDCPX+yKb9TQ1ON2BnB3SsuAFh3sZzLbDb6cibRU=;
        b=WXIRFhFCe4W5I6UgKWDCW3UyMYilZ32XCNH9uee6t/xanqVry8VnS7gryJMsuZBFY/
         yBoQD8rGfleNlkW7yfU+4wlASpGIk6kZbcI7RoTXpUe1/M1ruF8pdmz+KCAV9qOIER1N
         AHutCbPhvDh3rzitWzIXBLnCKJ63fOFuZ5gZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sArfDCPX+yKb9TQ1ON2BnB3SsuAFh3sZzLbDb6cibRU=;
        b=jxDqpmzveU0BhaQ0rhOV3mcnLb2QIpuwep0xMHHMvF5XHNlulwobyGC8g5FAXj+/bK
         iJAEljZuAw6cNHZoDYKs4dVMHllV2R25tnn8+0nb3CUKbsWalZYSyT7fj1t0w71ZjCMx
         pIeB8s+qBHkUXZplvQ8s9Y1QEL6gXfXS1BGI2f7hXMVS85lmK6X5Zc/1+O2cmakx4qpA
         ZMUjDlWukUnMeYqInpx/T9c9fIzUawKPct4reg+yultSSlqQUOJSHFqGFrkxdHFu9KFg
         IaGHzjzWO+UJdAhjtRFXM8o3PLsZj9pP3OqF9BpnMsQH1uGB28HS7XWmcvlZb4Qa0O+l
         zKzg==
X-Gm-Message-State: AOAM532VIS6j2t+SDH1wimQFBgixcxnZMh2RnO+uAeMyrmyz7p3Avawh
        YZVHuQOAN987/TYoPVCAqFekuQ==
X-Google-Smtp-Source: ABdhPJwYh4MTlWGIL+50lpLKghCeomuo6cIkL3bH4TI5zJoOsDhOPDjNUP7PEy8JCuaxkfuLRBFvvA==
X-Received: by 2002:a65:614f:: with SMTP id o15mr10400330pgv.321.1596782150506;
        Thu, 06 Aug 2020 23:35:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o192sm12514425pfg.81.2020.08.06.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 23:35:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] module: Correctly truncate sysfs sections output
Date:   Thu,  6 Aug 2020 23:35:37 -0700
Message-Id: <20200807063539.2620154-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This fixes my sysfs module sections refactoring to take into account
the case where the output buffer is not PAGE_SIZE. :( Thanks to 0day
and trinity for noticing.

I'll let this sit in -next for a few days and then send it to Linus.

-Kees

Kees Cook (2):
  module: Correctly truncate sysfs sections output
  selftests: splice: Check behavior of full and short splices

 kernel/module.c                               | 22 ++++++-
 tools/testing/selftests/splice/.gitignore     |  1 +
 tools/testing/selftests/splice/Makefile       |  4 +-
 tools/testing/selftests/splice/config         |  1 +
 tools/testing/selftests/splice/settings       |  1 +
 .../selftests/splice/short_splice_read.sh     | 56 ++++++++++++++++++
 tools/testing/selftests/splice/splice_read.c  | 57 +++++++++++++++++++
 7 files changed, 137 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/splice/config
 create mode 100644 tools/testing/selftests/splice/settings
 create mode 100755 tools/testing/selftests/splice/short_splice_read.sh
 create mode 100644 tools/testing/selftests/splice/splice_read.c

-- 
2.25.1

