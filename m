Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F386246B279
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 06:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhLGFoF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 00:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbhLGFoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 00:44:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E3C061354
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 21:40:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so24157022ybe.8
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iv3XPkeNjzTuXlX7KV6sXtdefvb8MaEt+ItGcqhTHtw=;
        b=YvxDNLksB5J+1uPwEJLzRNjjTl8Tu1TqP9C6Zik9TGjnx6du9ewlFJktMT7ryUX/im
         xatUdH95b5/FJ5LZTbuZ8DC7AMb5s9ElAKwXsBFiGIdPKmEVZN64gvX/DFRSznnPxecS
         p6C/pzlrsz73YWNmNKSht7yZ+0oT0j6F1iuDEJVLRSRkPjLDLxArke6Gy/kfDKXHR4Xc
         xVICYQxlNq7V1+/4q8i3433BM/7yJkZZoTe/PYDhfDmNer+gbc1Rmm7Zq9FO8Ie7TmjW
         USpDXbPXZkkcUWH6bgFtagYds+sGgIAECDdfRHhQQHxcQdjeXVqCNIH1oDZXunlboAip
         YmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iv3XPkeNjzTuXlX7KV6sXtdefvb8MaEt+ItGcqhTHtw=;
        b=RitM/vBQDN+sGkbKSZb+RtBxCmCI43E3Xm0nIAHs45d7yXf9eNDRmXSZ3wZGfchIUY
         5uzZIFug9HNgSDC4SYOhkxwYY7PXrmZ0Vgyqo/1KoFcAvdolYmdOiy4GA6ZLm2055cO5
         N7pAXZDLt7ygZtvtW3TIXttapByh/3XbuJlMMPK5OvYPRlCbPNiEctDz1XUGEpuohYT0
         LXke5iiKEPfB1Ia+35T0IsZK7dZIfBWIR+3rl4o1obaWCR/TwC01KkWi6RHKrjNNBtBx
         gSZh8K0bg2PNJ6H0Ce9tKL9FlmsEKnPoQSOJCO5yPp5qwjy3If4XU5R7YB0LkaE78xhK
         8teA==
X-Gm-Message-State: AOAM531T8/1s0hY1cK2m+tdbiIBqd6EMfwiOfV0CWeRKHt8Pd6766Tv+
        8s+ncoSC4s66zSYO6HUQsiaU/S1JxR2NUlg=
X-Google-Smtp-Source: ABdhPJyr2DmKjI06HJ74o6yAt1Y10x+Urym7uuqDfp2tB4pSp3HUX17yra0M4OVpibkcLEC060eRnPr7q/O1cO4=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a05:6902:1025:: with SMTP id
 x5mr48941341ybt.156.1638855632635; Mon, 06 Dec 2021 21:40:32 -0800 (PST)
Date:   Tue,  7 Dec 2021 05:40:12 +0000
Message-Id: <20211207054019.1455054-1-sharinder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 0/7] Documentation: KUnit: Rework KUnit documentation
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
 Documentation/dev-tools/kunit/style.rst       | 101 ++--
 Documentation/dev-tools/kunit/usage.rst       | 570 ++++++++----------
 9 files changed, 1039 insertions(+), 585 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/architecture.rst
 create mode 100644 Documentation/dev-tools/kunit/kunit_suitememorydiagram.png
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst


base-commit: 4c388a8e740d3235a194f330c8ef327deef710f6
-- 
2.34.1.400.ga245620fadb-goog

