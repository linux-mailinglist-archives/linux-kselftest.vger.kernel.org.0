Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2278943E925
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJ1UAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJ1UAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:00:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB7C061570
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 12:58:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso4063360ybs.14
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=L0mp2T+2GGA+M5SSznk5lc9pAGSuDVifknCJAl2jqKU=;
        b=iptt9SQQjxmAT1L7OevdbVi0Lgb0simKZeL4vRD83gQxFdqPbPbajzgIxRKgHe2yxl
         CWmSNUiop3qCv8SfoOBvmBYv3xWbB9tA2jaO14nlbJ8bT6ml2bladDkKfotZvMCEPqhU
         MfvujQwdeHDK4T6QApfwWpj+9+LZ4j7y5u78FLLXaUhQ7MvPr/IPT7zfvTChRaSMbqHl
         k0ZgYoHNLUaifsxk6s5ANmBz6ZIg+0+xWIet0StiX3nfuZQ9eRfOyD8+grLqhFQzhKhY
         U1QE4eMk7B8gZf0mQFmQtLu/Fm247JnHVLVCoNpkb2pq2jEeG1trGTbk/Wfz+xUJ9uto
         VzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=L0mp2T+2GGA+M5SSznk5lc9pAGSuDVifknCJAl2jqKU=;
        b=s5ey3mxLHjRvtrKUFiW1VmemcG5sozjZHI9ccu5xFX/dWf0/fEiL127bD6NTxFl76H
         6MgyLeZZCRzkxW8zv/tH0L8lk48bFCkLAL0aVXnl4p3VX08UmwXmbANpb0f+8Bsavj7d
         uAtvwVaivteYau/RkQebOmi2gXESK/lK7J5W0r1oOOo2eR+LuwU77WQFNsM8nXtpIx+p
         XtPu58bpg8DlcHIvewJZdMp06rdSvt8jMDW7MwOTGyXUUpkQfnxI8w3moZ8w8aA8eoXz
         kmv1lwqR9g59csepeCBiIOYRY4WnkcETGB4i/5pfa+G7XHINoAarKLSRpRWiViz1IZEy
         1xSA==
X-Gm-Message-State: AOAM5318/A8xE00rBudyQ0C6u7D9fubBpORGM1Rvk4nuyks4NvXxQ08C
        kbq/38Xj/1CA0jB/Uk1oZVbPsXF0qG0swd39OA==
X-Google-Smtp-Source: ABdhPJwxtElX6ecFHi1ltNUmp+V0Tfuj8R83nPF76JBqLVsmL6AGXUwNYXsq+yKnnaMa3OsZ/bdIgL97vmjlZFiIWQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:9b57:752f:2f0a:3a13])
 (user=kaleshsingh job=sendgmr) by 2002:a25:cc8:: with SMTP id
 191mr6787174ybm.63.1635451090590; Thu, 28 Oct 2021 12:58:10 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:57:56 -0700
Message-Id: <20211028195805.2684854-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 0/2] tracing/kselftest: histogram trigger expression tests
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds kselftest for histogram trigger expressions and is
dependent on the series at [1] and can be applied on top of those after
dropping the patch 7 in [1].

This version drops the changes to reset_trigger_file().

[1] https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/

Kalesh Singh (2):
  tracing/histogram: Document hist trigger variables (v2)
  tracing/selftests: Add tests for hist trigger expression parsing (v6)

 kernel/trace/trace.c                          | 11 ++++
 .../trigger/trigger-hist-expressions.tc       | 65 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

-- 
2.33.0.1079.g6e70778dc9-goog

