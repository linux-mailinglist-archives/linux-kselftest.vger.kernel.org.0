Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6E30F9CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhBDRdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 12:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbhBDRbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 12:31:48 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57827C06121C
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 09:30:56 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i2so2604087plt.14
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=toZMlO8L4mNt/+T1e20QDyw4KGTzjt3zo2Fm4Ybrzl0=;
        b=lFdpJJgP004d3TZEN4lxygIPoEXHnYFjDHiUOuAJto0JAFMLB1RsVQiiZDwNZeDue2
         Cc47k6LyBn+zjjYLfHwqcNxnCZKeqBFbEtTbg9+HZpSsYFlz7VV5+hrQa3O5Og7YQUkd
         cak/rHTHyTctqQkMDNYyUDtrBARvERBvrCitbK05p3YpJD03RU4nhwwaZTThTmcd0iZi
         JOKRBRH9d2gcuxvBlYM0DzrT05GOYWEWZx7nIkulKrBKn59cN8lrMO1VWS9o0E0lSYat
         j6IbtzbSUUTN9ZWyl/001YSzjW4G06lmqpIvOjPm8byrrmyJp1ByF/wi2hk4l8mJbxJi
         LRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=toZMlO8L4mNt/+T1e20QDyw4KGTzjt3zo2Fm4Ybrzl0=;
        b=F3KKrFK6yYEkS4xrMNLcL8aEe2aQqdC9DwK10S6ZvZoLXBkXQmt8UDYoRdZ4+9U5QO
         Vbc+IuPbZTLqYnTSYIObqIzIGW2arAiCBrojEEBZwDPPQqx41cvohZQcysw16KnjLZOh
         +AVM28jtI7//MsMcwRI/5JOIJysCB8IMRGPVhJt5FdSwMXyJr7qgix+sVCETNRddHfxG
         JrVpBUI7/Hd/0UueRcl6oiGEUn5a0VpNia8IcPRq4mrLorUNk3myxQxxml8ZS8tVWaj0
         9X7WrMqkRs1EfrfvmKupW5J6K7fp285u9GYo3clp3vWMhGuo2UVKTBkj5sHK22n6Mnqg
         pLjg==
X-Gm-Message-State: AOAM532QMlrTd0r95tdqI+AsHHnpn9eE+Coi3HkQUQqQD9ZU7sEUyooy
        LMVXj70vKj5IoFcNVhyn65GSm+obRSSxRA==
X-Google-Smtp-Source: ABdhPJzQd64wYLCcP0U72Y1a9WakSWfAC+zRbyPKqXayyOUUVugjawZGIt2pZUUBmVo/hjapvX/iP5ulcwvF6Q==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:7503:: with SMTP id
 q3mr32450pjk.79.1612459855804; Thu, 04 Feb 2021 09:30:55 -0800 (PST)
Date:   Thu,  4 Feb 2021 09:30:42 -0800
Message-Id: <20210204173045.1138504-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 0/3]  kunit: support running subsets of test suites from kunit.py
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
kunitconfig at all.

See the first commit message for more details and discussion about
future work.

This patch series also includes a bugfix for a latent bug that can't be
triggered right now but has worse consequences as a result of the
changes needed to plumb in this suite name glob.

[1] https://lore.kernel.org/linux-kselftest/20210201205514.3943096-1-dlatypov@google.com/

---
v1 -> v2:
  Fix free of `suites` subarray in suite_set.
  Found by Dan Carpenter and kernel test robot.

Daniel Latypov (3):
  kunit: add kunit.filter_glob cmdline option to filter suites
  kunit: tool: add support for filtering suites by glob
  kunit: tool: fix unintentional statefulness in run_kernel()

 lib/kunit/Kconfig                   |  1 +
 lib/kunit/executor.c                | 91 ++++++++++++++++++++++++++---
 tools/testing/kunit/kunit.py        | 21 +++++--
 tools/testing/kunit/kunit_kernel.py |  6 +-
 4 files changed, 104 insertions(+), 15 deletions(-)


base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
-- 
2.30.0.365.g02bc693789-goog

