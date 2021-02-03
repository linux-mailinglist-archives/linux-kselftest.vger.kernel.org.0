Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C490130E7B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 00:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhBCXmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 18:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbhBCXmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 18:42:04 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C223C0613D6
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 15:41:24 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t13so861287plg.12
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=oHeR63Z70RmJTg5fFSLB2/8dgbWutAkfv569ssbNMXI=;
        b=JYPUMPkqABAnb5/flE82Sn6uvfOXjCLZTpcUa6yZZrhDq5iYl6ShdaJcK3XmpiD1JD
         5MRQhz1XM+afe6tGFkKg6wnsMIGnLnGdObZzTO9551umR8SRxiAT/25cuDjBSFGn6weR
         rI9ffgcozjThBlP5HIGMtIPS8lVen1lvP2Sd+ntnvQEEqlNp379IMr1jwtnttTeLvk1t
         V5GfmFj8WL2EgfLnoCRmHzWAzUrrf5M46DV7IkReb6t3POXfNvW+rzs1w9QRg0A5/JoQ
         qgwoMk+0CdKpxUmJAq1eM4uHmllV7UQxUOfko4J6Nvq9+oVL3nQSS6ducTfwNLdJO2+J
         7O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=oHeR63Z70RmJTg5fFSLB2/8dgbWutAkfv569ssbNMXI=;
        b=RW+8Vy9h3+wIbc/9J7IWJLcybPnNYUuxbX3FaRjS+66stXW+cucVUos1WXpa0nRJ6C
         aZgrFN7UMLQk9b7V6EWJJ3EN4AQpKoWIWJbfV80Y8czHIOKo39TrycAdp+7VBorIi8QK
         392YwE657Ok6xKoephxFOmn9gihZES8Vs1AWjQyqXzRrp2neK44JVAfw58fIcMDNn0KL
         //vIBWgavMRMBq/bVuloUSNZMlQzoUNYlrdguxF9cuw5WASlQIVhFj351bhGXU2FzTUp
         bs3m+8X2U4Psq8Woq3dB9ByRhmACLdZPuBP/GMi9chyaHRfAY8TSoNvYCNczJEOe4qge
         /a4g==
X-Gm-Message-State: AOAM532KcmC2WaJ498fE08RVNdMS0e4iqa6qSavrjkVNCInO9EXuntLE
        4q4+hIoDt38g04C2e8cHeCcGAHCQ/Koekw==
X-Google-Smtp-Source: ABdhPJxiTiWA1uh8AnL+mr3jabdh6XqrJho714zWuMgZyOhxQZavXF8ldV7RwMIh2728yoDJ3/VqsGrS4yAr8Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a63:703:: with SMTP id
 3mr6023570pgh.272.1612395683077; Wed, 03 Feb 2021 15:41:23 -0800 (PST)
Date:   Wed,  3 Feb 2021 15:41:13 -0800
Message-Id: <20210203234116.839819-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 0/3] kunit: support running subsets of test suites from
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When using `kunit.py run` to run tests, users must populate a
`kunitconfig` file to select the options the tests are hidden behind and
all their dependencies.

The patch [1] to allow specifying a path to kunitconfig promises to make
this nicer as we can have checked in files corresponding to different
sets of tests.

But it's still annoying 
1) when trying to run a subet of tests
2) when you want to run tests that don't have such a pre-existing
kunitconfig and selecting all the necessary options is tricky.

This patch series aims to alleviate both:
1) `kunit.py run 'my-suite-*'`
I.e. use my current kunitconfig, but just run suites that match this glob
2) `kunit.py run --alltests 'my-suite-*'`
I.e. use allyesconfig so I don't have to worry about writing a
kunitconfig at all (this is a bit overkill, but it works!)

See the first commit message for more details and discussion about
future work.

This patch series also includes a bugfix for a latent bug that can't be
triggered right now but has worse consequences as a result of the
changes needed to plumb in this suite name glob.

[1] https://lore.kernel.org/linux-kselftest/20210201205514.3943096-1-dlatypov@google.com/

Daniel Latypov (3):
  kunit: add kunit.filter_glob cmdline option to filter suites
  kunit: tool: add support for filtering suites by glob
  kunit: tool: fix unintentional statefulness in run_kernel()

 lib/kunit/Kconfig                   |  1 +
 lib/kunit/executor.c                | 85 ++++++++++++++++++++++++++---
 tools/testing/kunit/kunit.py        | 21 +++++--
 tools/testing/kunit/kunit_kernel.py |  6 +-
 4 files changed, 99 insertions(+), 14 deletions(-)


base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
-- 
2.30.0.365.g02bc693789-goog

