Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1FC3119AA
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBFDPQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 22:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhBFCbt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:49 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95166C08EE16
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 16:09:04 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 68so6116311pfe.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=i3/JC2Cwh7xZ8b0cCoTT3RVdoEzv5GBHxf2BMEc4UJ0=;
        b=WUF/00cMWBAIrZtgcIEZ04af1Kbg95o3THqYe6MOel4ajWpgKa2+csrn7FA2Mm/XE1
         nXdbnc9uTMo4xdIWW0kaeQoIu1GAeFPAf9Vby66h95Uc+quS62YNR9tgEySbIHLXc02j
         gSycaS6O7GXT6l2M3b21rLo7BkWlYIBYCplLCXDZqZMgRaQFvv7MEyeE6YxeZHZoaCn2
         KfBr0d9z/BE/JDKEhIdKk8CmC9BsDbCEsdGlV5MAzppB9u2R+S0iR8TcC3VXYEw9b46K
         hAYcdf6U5BlPBK2aTuAn1gKDr9nm+FmURzKQK7K/cWp1RwSd3HpWyCMOCItFqFpYxHpI
         +/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=i3/JC2Cwh7xZ8b0cCoTT3RVdoEzv5GBHxf2BMEc4UJ0=;
        b=hqWa7xznvOkviLJUXqRwsq+cgDQQRj/gLjnt2Qf2tUcMHSYCFNnACDEm55B3resWL8
         S5LiBrr85OL1K5aNLetFAXBWG7QOJ6ELkziv/EM8wxnOQemII59M7k0+v5cuxcZK4bQi
         8PJZfJYtXRXar9kVjq9Y80tVuD8FeMs+38oE2AuUGuSJL4RFS5z6cOfNN6PqvGjD1efB
         2dgfyuwbYFDhADRBKuI3oTW4dz5CFCP/4l/aOD/sn0rlggKWpR1NCtYhCtLFZ6OztzA+
         tWSJDOe5Gh7qZmNeFjOAlBXHQS0PC7j/d0NW8jGvX57PpZfIx7q2tkI/T2dIZR3Q7S4u
         YvRw==
X-Gm-Message-State: AOAM53311bs8VX4i95ihcYVAU1bAA/yeYcBm7djckP4xnWCFWDfA3xzG
        p1YzPC6qJw1DVyu9fpjv7b808vToOZ1MAg==
X-Google-Smtp-Source: ABdhPJz7vSWCdKojknwoknkR/yMe6c/FsLSyxxVddN7wHAsq1UyDAvKCfhn3yF3ek6fdf+/8WntA50DkyYt0Yg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a17:902:778e:b029:de:b475:c430 with SMTP
 id o14-20020a170902778eb02900deb475c430mr6143681pll.53.1612570144115; Fri, 05
 Feb 2021 16:09:04 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:08:51 -0800
Message-Id: <20210206000854.2037923-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 0/3] kunit: support running subsets of test suites from kunit.py
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
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
v2 -> v3:
  Add MODULE_PARM_DESC() for kunit.filter_glob.
v3 -> v4:
  Rebase on top of kunit_tool_test.py and typing fixes for merging.

Daniel Latypov (3):
  kunit: add kunit.filter_glob cmdline option to filter suites
  kunit: tool: add support for filtering suites by glob
  kunit: tool: fix unintentional statefulness in run_kernel()

 lib/kunit/Kconfig                      |  1 +
 lib/kunit/executor.c                   | 93 +++++++++++++++++++++++---
 tools/testing/kunit/kunit.py           | 21 ++++--
 tools/testing/kunit/kunit_kernel.py    |  6 +-
 tools/testing/kunit/kunit_tool_test.py | 15 +++--
 5 files changed, 115 insertions(+), 21 deletions(-)


base-commit: aa919f3b019d0e10e0c035598546b30cca7bcb19
-- 
2.30.0.478.g8a0d178c01-goog

