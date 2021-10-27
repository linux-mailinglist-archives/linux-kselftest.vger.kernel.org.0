Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDE43D35F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 22:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhJ0VCC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhJ0VCC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 17:02:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3EC061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 13:59:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q7-20020a25b007000000b005c1d1377abdso3343545ybf.23
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=i1CL+Ioq0o886sLLAiCIG0Fc9RRyFVltQRWnMjV6y8U=;
        b=EMSvLNRDpftfH5JdNeLd3rxDIB6eYTYN0UkBQMDOkWTUyWH4Z+MDxfQ3xI61I0T2Dv
         bz63mQxbFkFanne2shWprid3ZbvMA4VJMne64k9/eQ8cCbgMgKluDoUZffJx7nnxRmoz
         xRk2C8Xk4jbkogprOPimPmwSM4Bxiahbia5YysRfIpkpXpLYqcNInHKi0Iol0N/GPwiw
         fx3e+GBYErpFNHmPCVzBhDtqNRruh2mTBU14QRO+VfFKBXkmugBLnNWSlKF9mfgGGipH
         pG6Ouq7xK1Xbs16TkBngOK+WgaHPxiXl5Z+RN3d1Xkndnwc+5pbi9pb0jF31bnzv1fMb
         dqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=i1CL+Ioq0o886sLLAiCIG0Fc9RRyFVltQRWnMjV6y8U=;
        b=DN4pnTwJjjvAl0YamoFzQKy7ntYM7S7OmDtwxPZrEfhAHrbF/IiokjMhdWGU6mJ5rU
         TR7CIpuH983BUSSh5inER+p2pzZIQUpOET6HSgp1E4HQNWwLqUP0XJQVIczj1CjYtfsY
         /4lUUGfJJsX/rVrXothX2ZD8V4FmmcyYH5+WhosC7gD3j0QN/XXbqrljpjLyTlW7haOL
         9rPQ4IVrlxbvz0cNMLOsV8K9iCj5nyYtL2Gqh+9/KU1FwmiPe50JpGeYrJqg6Dgjk9CN
         kr+XqGu45zx4XTxFNvwtqZ98eFvMawEu870I7RHa7JGuML6/LunH+c3+kGcjfqPD250P
         WkJA==
X-Gm-Message-State: AOAM5338ITQeSGihyRSLQhKFIJK8PdRVBKYioECjaIzPKpPrrb/ZoD3G
        VLoUTmFyVa3kb/kD143O7jwwl5YoWYIEqRD3pQ==
X-Google-Smtp-Source: ABdhPJwBC52wfNL4wmDjPn///BK+bDkGTFnz35zmd4+qf4ffyk174mkRaniD1CEXJLOJteKJ/49KchIfl2T+InubyQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac51:b6be:9b51:3a7c])
 (user=kaleshsingh job=sendgmr) by 2002:a25:2f48:: with SMTP id
 v69mr12930688ybv.487.1635368375434; Wed, 27 Oct 2021 13:59:35 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:59:07 -0700
Message-Id: <20211027205919.1648553-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 0/3] tracing/kselftest: histogram trigger expression tests
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

This series adds kselftest for histogram trigger expresions and is
dependent on the series at [1] and can be applied on top of those after
dropping the patch 7 in [1].

[1] https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/

Kalesh Singh (3):
  tracing/histogram: Document hist trigger variables
  tracing/kselftests: Remove triggers with references before their
    definitions
  tracing/selftests: Add tests for hist trigger expression parsing (v5)

 kernel/trace/trace.c                          | 11 +++
 .../testing/selftests/ftrace/test.d/functions |  9 +++
 .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

-- 
2.33.0.1079.g6e70778dc9-goog

