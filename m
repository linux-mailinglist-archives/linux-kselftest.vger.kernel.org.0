Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43C5214A89
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jul 2020 08:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgGEGMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Jul 2020 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgGEGMi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Jul 2020 02:12:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A5FC08C5DE
        for <linux-kselftest@vger.kernel.org>; Sat,  4 Jul 2020 23:12:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so441846plr.2
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7QQXwEm4dnmq+jlTbXbOEq302bTMUVfN5lq4IjhYc8=;
        b=XyO2RmkEGRaFfFZkIuTkygla4ZXv0c89QtCF7yaqlKX3Gr5EOroGlW72oG3IyXMG92
         BEK5FUNsUTcLlnU41uBg2FuxDaX5Bq0y0zjTFTZnAAqHSX2RpiF8SjE1qjAu2zG+G2rH
         a8rEmOxPZky9FBjyj5nqDoD79Riqo9Nvbu6ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7QQXwEm4dnmq+jlTbXbOEq302bTMUVfN5lq4IjhYc8=;
        b=UAYtQ37JQpdB81M5r8i2JELuLZ0Zjlnu/aEZ2gELv1LVPTiL9cePEn0Os1DJAjBid3
         hWSn6M6HEGyqcYrm5gxQ3XxF0o/0SbztT1zsRrh+MJYBGeZsmXb/4oiCKY1ezNjQGPiP
         VXNp7slt1pdvjcgA/ZMsgkp/64SOVB2zyh1uAB20eQsTRo7XmnGktZBM0BgZrIDAGL3v
         o7BY+H5Vc9dXIbEgCmMtdvBJmYs0tc3PFcCbO1NctSPKBvTGxAa0rsVHDExP6zMR4eaL
         WV621dtDVr3+qcPS7HPpKK5OidtJNxnn2uYcRCxXRZUSKBvnpmRTe1S3bIgkSwUnScn+
         /wZA==
X-Gm-Message-State: AOAM531OVRP4387GSE7LoHq4RoLNZn9mCl5jm9IKN7YjZ62y2Ovqi2ca
        ycC/pPWf6K8XXGEUPviYgYB6Aw==
X-Google-Smtp-Source: ABdhPJygzPaieVb3XQ6+2JIScvsgING0EAgONcSvvoMj/Xyn1uQ6SLPo+DogPpeL8b3+2sdKe8YpEA==
X-Received: by 2002:a17:90b:3842:: with SMTP id nl2mr44572479pjb.111.1593929558010;
        Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9sm15525789pfr.103.2020.07.04.23.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:12:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp 0/3] Check ENOSYS under tracing
Date:   Sat,  4 Jul 2020 23:12:29 -0700
Message-Id: <20200705061232.4151319-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This expands the seccomp selftest to poke a architectural behavior corner
that Keno Fischer noticed[1]. In the process, I took the opportunity
to do the kselftest harness variant refactoring I'd been meaning to do,
which made adding this test much nicer.

I'd prefer this went via the seccomp tree, as it builds on top of the
other recent seccomp feature addition tests. Testing and reviews are
welcome! :)

Thanks,

-Kees

[1] https://lore.kernel.org/lkml/CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com

Kees Cook (3):
  selftests/harness: Clean up kern-doc for fixtures
  selftests/seccomp: Refactor to use fixture variants
  selftests/seccomp: Check ENOSYS under tracing

 tools/testing/selftests/kselftest_harness.h   |  15 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 217 ++++++------------
 2 files changed, 72 insertions(+), 160 deletions(-)

-- 
2.25.1

