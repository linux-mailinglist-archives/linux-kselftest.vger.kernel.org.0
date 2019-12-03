Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CE10F9A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCITQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:19:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43370 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLCITQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:19:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so2424937wra.10;
        Tue, 03 Dec 2019 00:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kzB1OOAN73r9jazBgk7VDDlYJoM5akmDKyZXmPa1LfM=;
        b=YngqJA4Ur8bjbh7ZkWIr9jCDnTAGV8cpxVF4V4TQRh0dVtapSSpf6AfvRyptWgQyG/
         45lgDkgV+8IV63hmTIV9pUKDlFD4A/1GoKdLYzfxDO8VMn4xrZrrSSNVGX/9ROpt2vQX
         6GZMiZ2QzspWxCeymonkeVdahwTiEHmQZlAv7yhQ/D+BucS9vHgNQJDOJ/P37KXvksif
         39OV8Y+rnKVrTjQJry4mQOTCFQ1ZlNfWxljbghRb1SM7pxWtYsgZN7r8IGqp3hITwDSU
         OU3pxVE1F6lrT3P68dQ21weoftKzj8Ke1/My/d7qn2SrItsWv8qcyHneI9B/nKjaYcS2
         fPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kzB1OOAN73r9jazBgk7VDDlYJoM5akmDKyZXmPa1LfM=;
        b=kAOz79v8E5pAfeAqZ4xZ/FT0lCdICR/VBpG40dW/RsZjErNOFbm1KKWV+adpaf5Qo5
         8tmYwK3x94WaO9oJs74CQtpXrPwbDXOnayfog2xYfm3DYmQ1jssKCJBxh3ip5QumQg54
         wTWKfcxkBPHS3eMTYoiEHEHm/Q4qFeDaZUcMdGE7evBqEzisXgnvJFjM1j1ZLGI0/tTk
         xIpg9jy/9lyaOuwAOhzymoXUPiXS+cAP+ZrScKbfxls+4nGmLsY+0CVXH7G8N71ZG5Jw
         vf/5Lb7nyIsz7z3IwzsNnCSxMmF/ofdhBYitbXIu006AZjVgSOfHlcnxay58mWLEigGl
         COpA==
X-Gm-Message-State: APjAAAVxitTXbV417DX4xn3zwo90To0sOJMxqwbRrOMYAryaOxVz9fb0
        QW0QTMoCkYWP+xlidk0LbhQ=
X-Google-Smtp-Source: APXvYqwWwavbbzKQunBTS00pOLVHCqVc4H9imfuH+KhO+/E4PnM3Qckm4eqMD1yNEQOgF3vgTLrVpw==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr3722980wrm.248.1575361153533;
        Tue, 03 Dec 2019 00:19:13 -0800 (PST)
Received: from localhost.localdomain (p50991abe.dip0.t-ipconnect.de. [80.153.26.190])
        by smtp.gmail.com with ESMTPSA id 188sm2048197wmz.13.2019.12.03.00.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 00:19:12 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjpark@amazon.de,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH v2 0/5] Fix nits in the kunit
Date:   Tue,  3 Dec 2019 17:18:56 +0900
Message-Id: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains trivial fixes for the kunit documentations and the
wrapper python scripts.


Changes from v1 (https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com/):
 - Remove "docs/kunit/start: Skip wrapper run command" (A similar approach is
   ongoing)
 - Make 'build_dir' if not exists

SeongJae Park (5):
  docs/kunit/start: Use in-tree 'kunit_defconfig'
  kunit: Remove duplicated defconfig creation
  kunit: Create default config in '--build_dir'
  kunit: Place 'test.log' under the 'build_dir'
  kunit: Rename 'kunitconfig' to '.kunitconfig'

 Documentation/dev-tools/kunit/start.rst | 13 +++++--------
 tools/testing/kunit/kunit.py            | 14 ++++++++------
 tools/testing/kunit/kunit_kernel.py     |  8 ++++----
 3 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.7.4

