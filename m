Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1B1274F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfLTFOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38739 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLTFOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so7869679wmc.3;
        Thu, 19 Dec 2019 21:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=23AeX3mMe7i3Lf0MSn5OA/aWIo23lefkqQqpPD1lp80=;
        b=Yh4ou2ujR2YE+/LvW+VTjTc6VqL4uD7bFBh2kU4KHRUSeMHW5vBCpM9Cc7Ng+ll3XY
         7P2M/MboalHnV/2r/s+wdFDzKE0NFlbEL1n/84EWEjtMSh0ot8zPAmPToN8YYtmhH3b3
         PT5GbsiAEAgFpvKRU/zKO91wBoAbWxapQrurgwYXQp3hbMHIkH0Bf8/MBizRmvwvDNyn
         VimbX5/8IwxNaSyTX2uIAhc7FtfJXvdNymzj3SdKAobKfosM5r1O4Zt9mlmrW6/5iOMT
         vzDBcF3hUY1l9XzfU8JioutnNDlRCRvCq3Pi0JfjDTHN01RItjer6AnaJTrzY+8gveJV
         lhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=23AeX3mMe7i3Lf0MSn5OA/aWIo23lefkqQqpPD1lp80=;
        b=Tf40wJ7rkybJ8vuC63L3pj0Oy2XjqQ+IJZU9oc/yuVVSMW1t+NxRP5aFOU2QOB8cds
         Zz4fgT80MF/7sM7r9jCoTZOXXIhY5p8P9Lxh3q2fc0dtQzqNp9clP6AeWSmplvcQiSxY
         /+hBFPcF25xjSdF/R+pyUaH3MOdhJPU+z+d1I3rK4hC+nWZtKjSb8s9k+FdyL4iQUYiP
         8MpgDGbY+YBANhq7YE+ihpG6hpH9YgAy8Z6JqPQJx5n/2krHZrINMWEoiKbiUsSdwbM9
         bHpFCT06V5YFgqxyF9i2mg2hrj9tOWU4hlaXFWY8dxMHxF7SFqaL4kbU0mYIlywclN/c
         W4eQ==
X-Gm-Message-State: APjAAAX1ssG2QzaKzzPO4/6zPt1eVogv4B8GjsTBJhDLlVmofW0uImG9
        O8rTqkGPYPj9I7t6i8e9Jdk=
X-Google-Smtp-Source: APXvYqwNvwKc7iPXiJfL0xzFh2vKamTudLe9kX5kmPUf/w99aICME8MGbgP4W7/gGwu1Ry1dDGlCBg==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr14610576wml.55.1576818857593;
        Thu, 19 Dec 2019 21:14:17 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:17 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 0/6] Fix nits in the kunit
Date:   Fri, 20 Dec 2019 05:14:02 +0000
Message-Id: <20191220051408.3591-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset contains trivial fixes for the kunit documentations and
the wrapper python scripts.


Baseline
--------

This patchset is based on 'kselftest/fixes' branch of
linux-kselftest[1].  A complete tree is available at my repo:
https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6


Version History
---------------

Changes from v6
(https://lore.kernel.org/linux-doc/20191212022711.10062-1-sjpark@amazon.de/):
 - Rebased on latest kselftest/fixes
 - Add 'From: SeongJae Park <sjpark@amazon.de>'

Changes from v5
(https://lore.kernel.org/linux-kselftest/20191205093440.21824-1-sjpark@amazon.com):
 - Rebased on kselftest/fixes
 - Add 'Reviewed-by' and 'Tested-by' from Brendan Higgins

Changes from v4
(https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
 - Rebased on Heidi Fahim's patch[2]
 - Fix failing kunit_tool_test test
 - Add 'build_dir' option test in 'kunit_tool_test.py'

Changes from v3
(https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
 - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to
   set default value of 'build_dir' as '' instead of NULL so that kunit
   can run even though '--build_dir' option is not given.

Changes from v2
(https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
 - Make 'build_dir' if not exists (missed from v3 by mistake)

Changes from v1
(https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
 - Remove "docs/kunit/start: Skip wrapper run command" (A similar
   approach is ongoing)
 - Make 'build_dir' if not exists

SeongJae Park (6):
  docs/kunit/start: Use in-tree 'kunit_defconfig'
  kunit: Remove duplicated defconfig creation
  kunit: Create default config in '--build_dir'
  kunit: Place 'test.log' under the 'build_dir'
  kunit: Rename 'kunitconfig' to '.kunitconfig'
  kunit/kunit_tool_test: Test '--build_dir' option run

 Documentation/dev-tools/kunit/start.rst | 13 +++++--------
 tools/testing/kunit/kunit.py            | 18 +++++++++++-------
 tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
 tools/testing/kunit/kunit_tool_test.py  | 10 +++++++++-
 4 files changed, 30 insertions(+), 21 deletions(-)

-- 
2.17.1

