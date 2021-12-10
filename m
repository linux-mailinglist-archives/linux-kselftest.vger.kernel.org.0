Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A031E46FA55
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhLJFb6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhLJFb6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:31:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B2C061746
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:28:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso14803738ybj.18
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q/yA9sPgnWZ7PZbSTSePDzl+2+LX/jsSZ2aJXrNG7YE=;
        b=TyccKEm3KSuGGOeEFgiVhOkL1pOVjfDQvofDbMlnAnCOJdWaGXViu5kWfpDBQ24B9d
         8Jc0fNwAY2JZXQW4OFuZ8jhOT9IhQjzA58AGav3y1zAVzc7uJij8gkCcE3M1KgWLL/iH
         SZlOEokoqDmgIIUXFsuUGuCpjrCYJDGnT3oMajPp+/rrqP1dhSh1+04mP+wOtr6nMskU
         s0S2IMpf1Btxye0f3YN/cQEBHcahXE98NMUUgXppXRIwL6kWRkDXC+DLx358mTJhlcMk
         YPek4C5P5y2sU4A7uOBQgjn44DVnsXuQC1H/naiu2UtvY/ALgsdiwOwKvLF++27yoq5+
         hjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q/yA9sPgnWZ7PZbSTSePDzl+2+LX/jsSZ2aJXrNG7YE=;
        b=oylQm+9KqyeYS5Oja6hc1CsIiWhRbjuqzGNGVDtQIW82gj5z7+WlNePXSyCmmkuaMM
         RzwshkP7yiqLuolXKsjhL+klKLxvVVotv5QMGdBaSX3ZclWJSmAq/duTX1v4Ej4TWxCq
         kuW+h+MPbbY7ADe7yQl/FASmVQPVK59Iodsf/7PB1FdF6IXqXOaHHcSsfhJuldtwbqnO
         EyPY5pSlauqX3YBYMF/rtGtYXYDly3jV1okCbGMK4vCuKR7d+Hfo6rrPL7FBu23LGy8E
         mLU3i1/63yGJtTcjmfPy7fQ9FPeNMnLALon5WeRQE+peooQ+zBA4F/f9E9AzRuqgW/Rr
         UqzQ==
X-Gm-Message-State: AOAM532P33Ahqa6nxywWXf6xz+u+/afjNz1tmrSWfwV8qsm99CXwYabM
        I1C336N6WP4X2Go/5spuPtL7zkrvvN2MaDI=
X-Google-Smtp-Source: ABdhPJzJHY6T8LWZYV4isxoZfxQaYtrnF/GAQA9UxnQcmeKS8QUcynJHtWWElWdJ+EnPcKpgh/pt1H1Wi+mmlMc=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:38f:: with SMTP id
 137mr12365855ybd.11.1639114102849; Thu, 09 Dec 2021 21:28:22 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:28:05 +0000
Message-Id: <20211210052812.1998578-1-sharinder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 0/7] Documentation: KUnit: Rework KUnit documentation
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The KUnit documentation was not very organized. There was little
information related to KUnit architecture and the importance of unit
testing.

Add some new pages, expand and reorganize the existing documentation.
Reword pages to make information and style more consistent.

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

 .../dev-tools/kunit/architecture.rst          | 206 +++++++
 Documentation/dev-tools/kunit/faq.rst         |  73 ++-
 Documentation/dev-tools/kunit/index.rst       | 172 +++---
 .../kunit/kunit_suitememorydiagram.png        | Bin 0 -> 24174 bytes
 Documentation/dev-tools/kunit/run_manual.rst  |  57 ++
 Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++
 Documentation/dev-tools/kunit/start.rst       | 198 +++---
 Documentation/dev-tools/kunit/style.rst       | 105 ++--
 Documentation/dev-tools/kunit/usage.rst       | 578 ++++++++----------
 9 files changed, 1049 insertions(+), 587 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst


base-commit: 4c388a8e740d3235a194f330c8ef327deef710f6
-- 
2.34.1.173.g76aa8bc2d0-goog

