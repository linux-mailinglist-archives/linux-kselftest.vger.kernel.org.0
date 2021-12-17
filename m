Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA882478438
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 05:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhLQEtZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 23:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhLQEtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 23:49:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0037AC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:49:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso2546481ybg.6
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MteFUh8cRxe5jyTd10pL94LII1hOr9zZG/Dg3ahz8fo=;
        b=nm8t4QE3Qfsj21z6zSMpUq5r90p1RR+5pwHT5Wbnpg5ecI2Tm3UV+IhSrRncovur0n
         t8rDge5hfLE8amv4/b3cxJw+LUIoLZCmSbXouVztGIMD20yAJhXW/OW38unXLftqf/m7
         NjKzFA82WPPQbhRIueHxozyWZzvLC3FdrsOq608GLJX7SKHWgSrMqbKR2PNm1M4L1Aq7
         KtKYHbJNgndfrO8ZeKjpRFZo6mdDUX+SB7Qmtnd2ZsA3HiC/v4iHFKhXZlQ9U8hl77Y7
         KnoQMOGpUF4jj6nMHmWw063hxeA7HV8dgwwd3+8NBGxJ7ypYAT5alXmwv9rQl8DZe0NG
         /xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MteFUh8cRxe5jyTd10pL94LII1hOr9zZG/Dg3ahz8fo=;
        b=4m3Oo2/dJN+SRYvQc8C8SEWhOq0mT3pLypG0pXT62qoKmT70UwLitfz+HMjJx2Cfgt
         IRyWNGPDA6nftaG+hryXa0olKVtZWejnNJx4h8QpjJ56BZAgM1jew8m8oSvKrqVXeCvq
         Sv9npgJYeao+LiM4GXbwLxl0Q8g8I50jVjHy5k5Sm6Mjejf2fyoawAWU0FJa1tGCLfCi
         sjVb/HgdsM9giwMaXZJ/4oSq0BiJlh5DUiHyE1dv3+rd0WeMQkR4RPS86agY5aOGdTXG
         DgzSj6gcGUTVYIZ7KC68Q+5b3eNRUkAX+awwp5q5hWgfZ3rXOCHHr8VD0Mds4rCx/7RC
         ndaQ==
X-Gm-Message-State: AOAM532H6Oo2YreYHfESqDEWWTWKCxaRJNRz97Y2v67LdaZ46HEOVz91
        5qRTQzST3YrhnPDbwSCk3oi46d+z8L9ic2Q=
X-Google-Smtp-Source: ABdhPJzcQ0rJHn9GcYJVIxe/jGTc0AjRz5TMUP/0JruX4J/ainoXCHiw3OCHg5OCQnwkOchOyPWm6y5bixoVVjI=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:2d67:: with SMTP id
 s39mr2197528ybe.140.1639716564212; Thu, 16 Dec 2021 20:49:24 -0800 (PST)
Date:   Fri, 17 Dec 2021 04:49:04 +0000
Message-Id: <20211217044911.798817-1-sharinder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v6 0/7] Documentation: KUnit: Rework KUnit documentation
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, elver@google.com,
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

Changes since v5:
https://lore.kernel.org/linux-kselftest/20211217043716.794289-1-sharinder@google.com/T/
-- Forgot to add the new .svg diagram file to git.

Changes since v4:
https://lore.kernel.org/linux-kselftest/20211216055958.634097-1-sharinder@google.com/T/
-- Replaced kunit_suitememorydiagram.png with kunit_suitememorydiagram.svg


Changes since v3:
https://lore.kernel.org/linux-kselftest/20211210052812.1998578-1-sharinder@google.com/T/#m0a85e6a36f13c66470844d92553d19c19239ebed

--Reworded sentences as per comments
--Replaced Elixir links with kernel.org links or kernel-doc references


Changes since v2:
https://lore.kernel.org/linux-kselftest/20211207054019.1455054-1-sharinder@google.com/T/

--Reworded sentences as per comments
--Expanded the explaination in usage.rst for accessing the current test example
--Standardized on US english in style.rst

Changes since v1:
https://lore.kernel.org/linux-kselftest/20211203042437.740255-1-sharinder@google.com/

--Fixed spelling mistakes
--Restored paragraph about kunit_tool introduction
--Added note about CONFIG_KUNIT_ALL_TESTS (Thanks Tim Bird for review
comments)
-- Miscellaneous changes

Harinder Singh (7):
  Documentation: KUnit: Rewrite main page
  Documentation: KUnit: Rewrite getting started
  Documentation: KUnit: Added KUnit Architecture
  Documentation: kunit: Reorganize documentation related to running
    tests
  Documentation: KUnit: Rework writing page to focus on writing tests
  Documentation: KUnit: Restyle Test Style and Nomenclature page
  Documentation: KUnit: Restyled Frequently Asked Questions

 .../dev-tools/kunit/architecture.rst          | 204 +++++++
 Documentation/dev-tools/kunit/faq.rst         |  73 ++-
 Documentation/dev-tools/kunit/index.rst       | 172 +++---
 .../kunit/kunit_suitememorydiagram.svg        |  81 +++
 Documentation/dev-tools/kunit/run_manual.rst  |  57 ++
 Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++
 Documentation/dev-tools/kunit/start.rst       | 198 +++---
 Documentation/dev-tools/kunit/style.rst       | 105 ++--
 Documentation/dev-tools/kunit/usage.rst       | 578 ++++++++----------
 9 files changed, 1128 insertions(+), 587 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.svg
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst


base-commit: 4c388a8e740d3235a194f330c8ef327deef710f6
-- 
2.34.1.173.g76aa8bc2d0-goog

