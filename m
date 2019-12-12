Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9111C32D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfLLC1W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37790 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLLC1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:21 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so362647pjb.4;
        Wed, 11 Dec 2019 18:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2xT8zDPE6zMDfzcqTYocW2E/yyuYcro8Y6mORkbEHPY=;
        b=Ci9iwp5AhHYL2KmyOPs/YB+DdMYeQpyHMw04QlWrxG+s0xMv9OjgyK/HJeohAso6W4
         fwI8vQAZZCpcH+6f17dMQ6cC0tPBud4rQAJ5y5EayO+xMjKBgBIbf0LsmW7l/wZ6faXA
         YsWRR4O3JALjKmE6hIz1pGEGNMI+IFo2pMYzGUeGuAOD/bmSCVvAMqKHLs8Vj5nYjlEd
         j3lJL7gyFz7FZ+6AnBYqAW9RyWSGrev2leZh5bV3UuMXUWWimEJhjXQvgwzCXC+rkMcm
         FVRz4v/3lJlSFXtXwlWsgVJEQp6zxlfljS2ALt/hEFCVFwlHpkXFn9HtTpClQApmQFZG
         xXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2xT8zDPE6zMDfzcqTYocW2E/yyuYcro8Y6mORkbEHPY=;
        b=b8gSoigtWtx56at/MZvliOTgvf3pM0jtbP9vtIjBjvsLd818pTFe1CohGb1aqpRxOA
         Qe8rsBbEi62LBwsgj3kw+F5OoQj7lehrV9ECPwrXEuOJXc+g3RhPD0fGGGjHWFhHNbXH
         YMPqcqkxMYwyA+rhmhgdiXuAN3GilNEJTVlpI+envOMVQohLQHJcQWIehmqGFU3DkLIv
         uRjSN4l+SPg6pzXC3InLRRw9rNWfHPIpLQmNEHfUECBzC1DwJkbQ8PuvxroItZ7Wgb9p
         j00v/DIHZzVAhn5kG1gPTymMX+5vZEhWC3ULIRGmdhh2Wt/qt2Z2JBGRs3aBkkzoIZAo
         kGlQ==
X-Gm-Message-State: APjAAAVuWfGANIro+458YjOicq6xsLtqBM4uxoMWqHRSDhqjwzvew9GC
        hrlo9Jf47gdcxEIj9owXNOo=
X-Google-Smtp-Source: APXvYqx7AON0Xia1JMAVNsBILDOMvCmEgBuWVRLFhIQB8hhrZQSveqa7Y6j4tJhhiumySQdtqbCI4g==
X-Received: by 2002:a17:902:12c:: with SMTP id 41mr6799563plb.160.1576117641083;
        Wed, 11 Dec 2019 18:27:21 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:20 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 0/6] Fix nits in the kunit
Date:   Thu, 12 Dec 2019 02:27:05 +0000
Message-Id: <20191212022711.10062-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains trivial fixes for the kunit documentations and
the wrapper python scripts.


Baseline
--------

This patchset is based on 'kselftest/fixes' branch of
linux-kselftest[1].  A complete tree is available at my repo:
https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6


Version History
---------------

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

