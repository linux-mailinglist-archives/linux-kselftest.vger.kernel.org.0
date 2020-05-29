Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB4A1E8873
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 22:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgE2UEG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgE2UD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 16:03:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2DC08C5CA
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a4so375200pfo.4
        for <linux-kselftest@vger.kernel.org>; Fri, 29 May 2020 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jc9W1lwloD2dKjs9tH5GF5HCcPhR+AQW3rE24ig1wNo=;
        b=e1eTWdUfj0/uemCZrZndDP84V6F6lpImOpHhDUyzllRqWZlnKM6KITsLSam+a0R/bv
         PoMO4JXmtX5ZMB9fmem1FG9RAtKBlLDbpHqrYncYIJYyEwBjuW+oJ6SrHW3Pv5OpoR/R
         OoIyqaaLzHdjAuD1n5MLYvZmuqZghAa+a2OnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jc9W1lwloD2dKjs9tH5GF5HCcPhR+AQW3rE24ig1wNo=;
        b=ep4GDh+ZKhmLLBIcrPyesIx73udBWIwBDdPtngWlKtBe6opbYYmQ3NSGREsbjfui3x
         sHMFVQIpQIyfSDDXvAy/h41fGyb0iLj8LrpmX2ksyxCDbzX2mEUfWXe2wxt7ShlghAhE
         z9r9Py1Fq6acC3Yoeixdl1B0FBGfgj1nfGDxl/za1gN2D0YWdTzXBhTLf6tVNep+Un/u
         U3f55oMYck5zQ4C3VkpeeO9NOyoOrh05fAnOkFmp6v0EvVKvMX8Q+z5oU87aniVsApeb
         pWDC3zSKRWRYv+GOdaacahM+grEbdTzVzaSbgRxod0Q7KD2tT6etpScVBJhMe4rghXs+
         EsPw==
X-Gm-Message-State: AOAM533p7DtXceN8+aOZbGqaGUekeokhZuhfFD28f8LVasuU94He3VMV
        EcgS4ljw4vSomO/yh9LJAe+D7Q==
X-Google-Smtp-Source: ABdhPJwP7z6gIJI+dnYxn8KJ2aoaoXPzR+vI9pyJIkXlzmzjD/z7ey7U1doHvuvot75KEkzxR06v1g==
X-Received: by 2002:a62:178b:: with SMTP id 133mr9871040pfx.238.1590782637803;
        Fri, 29 May 2020 13:03:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q28sm8137946pfg.180.2020.05.29.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Date:   Fri, 29 May 2020 13:03:43 -0700
Message-Id: <20200529200347.2464284-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

Can you please apply these patches to your drivers/misc tree for LKDTM?
It's mostly a collection of fixes and improvements and tweaks to the
selftest integration.

Thanks!

-Kees

Kees Cook (4):
  lkdtm: Avoid more compiler optimizations for bad writes
  lkdtm/heap: Avoid edge and middle of slabs
  selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
  lkdtm: Make arch-specific tests always available

 drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
 drivers/misc/lkdtm/heap.c               |  9 ++---
 drivers/misc/lkdtm/lkdtm.h              |  2 --
 drivers/misc/lkdtm/perms.c              | 22 ++++++++----
 drivers/misc/lkdtm/usercopy.c           |  7 ++--
 tools/testing/selftests/lkdtm/run.sh    |  6 ++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 56 insertions(+), 36 deletions(-)

-- 
2.25.1

