Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF68467111
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 05:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhLCE2b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 23:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhLCE2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 23:28:31 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC2C061758
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 20:25:07 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 100-20020aed30ed000000b002a6b3dc6465so2178238qtf.13
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 20:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ne2dqMkdFvy4E+NAkIacDazTUN8yXwTV2LgTzro6FOI=;
        b=G2LlrFU2DEAQbtw8R879sNlk5TAD+0OVUY6deI32Iv2EThoILBjM5EO+1SYd+guZlf
         pIJHRWD5fnQu0BOIIC83L03NhFruLQGBn4wAlc0+o/GGAkGKLtEqccvN/t6VfHSeA1KO
         oj+BtiHFxM7x9+OcctYLogy4i/y0SRedC+Qyh+AKzF5OCKYnhvUWJLUAsnENXvi8D95s
         XbSLV2Z5hAsaEnwEiP2rvnz0qBzqH3Aoh179LhAcwicVKcbl0Gy60CnaOCgaXL21djNQ
         324vKb52KSiZMzAo5C1Uec3hGWrtF8J6fwRxYbYuMxdQXIgSusjecFNNKsbrlNKOiC89
         rxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ne2dqMkdFvy4E+NAkIacDazTUN8yXwTV2LgTzro6FOI=;
        b=s+rRtFH7LNGO4vNdZiE2ycqIFOPOpFywRfkc2lYJ8d1EclWHtIxrMi4S0kYFuMagX4
         YMVX5r2QwIDfDZ04W8dieS39q6nqDEHaIicagnzEr0/Qg/Umzct4Rrz7SH/gwvPJmjfT
         l6uX9Q/vOy4b1y5LqK82lof2N8Mhk5/y7mdk4kGpxRvdK39zextV+MPEz2Mn+rAqrOri
         TIr5OVGsexV3K2a0yauLARTV1g4oWJlyZ/nREivIlm8yfc0GF+sv7jPGLuGCg1jOpcXj
         1RYwMBN7kPPT56CrX3nBWvW9NK803mFtQqTQHD3ON5fOQoj6wnLHMTgaizk6yoBQIaQ9
         kJvQ==
X-Gm-Message-State: AOAM531SfxkSmOLEzTbu0OqDz9munjQKJJ2SHcElxL0NyYXgbZefUodM
        guTn4OltuVPq4v0qene/rMELjpWkzwUeQZ4=
X-Google-Smtp-Source: ABdhPJz9uCYOR/oSZ9jq8y7ImcLzhUV0q8LKDi8EoA/8m7IZQxfq27/vC7099ShHPemo/AQSIHgrVSTtx8eWwTA=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a05:622a:288:: with SMTP id
 z8mr18368282qtw.526.1638505506934; Thu, 02 Dec 2021 20:25:06 -0800 (PST)
Date:   Fri,  3 Dec 2021 04:24:30 +0000
Message-Id: <20211203042437.740255-1-sharinder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH v1 0/7] Documentation: KUnit: Rework KUnit documentation
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The KUnit documentation was not very organized. There was little
information related to KUnit architecture and the importance of unit
testing.

Add some new pages, expand and reorganize the existing documentation.
Reword pages to make information and style more consistent.

Harinder Singh (7):
  Documentation: KUnit: Rewrite main page
  Documentation: KUnit: Rewrite getting started
  Documentation: KUnit: Added KUnit Architecture
  Documentation: kunit: Reorganize documentation related to running
    tests
  Documentation: KUnit: Rework writing page to focus on writing tests
  Documentation: KUnit: Restyle Test Style and Nomenclature page
  Documentation: KUnit: Restyled Frequently Asked Questions

 .../dev-tools/kunit/architecture.rst          | 206 +++++++
 Documentation/dev-tools/kunit/faq.rst         |  73 ++-
 Documentation/dev-tools/kunit/index.rst       | 165 ++---
 .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
 Documentation/dev-tools/kunit/run_manual.rst  |  57 ++
 Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++
 Documentation/dev-tools/kunit/start.rst       | 195 +++---
 Documentation/dev-tools/kunit/style.rst       | 101 ++--
 Documentation/dev-tools/kunit/usage.rst       | 570 ++++++++----------
 9 files changed, 1028 insertions(+), 586 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst


base-commit: 4c388a8e740d3235a194f330c8ef327deef710f6
-- 
2.34.0.384.gca35af8252-goog

