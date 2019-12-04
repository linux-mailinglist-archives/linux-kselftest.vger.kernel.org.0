Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE0113653
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfLDUSZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:18:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41874 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUSZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:18:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so731539wrw.8;
        Wed, 04 Dec 2019 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RZERPFUWOa/lGcWiQ5EhbcD6LWlr2/Pa13KS0SVnOxA=;
        b=mZHv7AgAuu+1nD+jQ1+38h8j7Obuk0gTv9MBzCljWz8KYZ9jaQiRDkxGnkemWC7BDf
         Y/gPO1I2lKcvYFoHjgUy5fgtiZEW5VdRWmIdBlTer4+k2ASaxleasscXbm7ai6KT6v19
         GvjJjQAMmZhtf5WkO3zAyfC/JTgptJ2eBsjNCo+hDyNcVS8vpUVVtg3jO+hrptqpoEWw
         snoP3zwrJZXMlQio7lTgbrr+lcBFSnFhazyZ3gDn+ml8DgW4Li/J/OE3eng9WxK9qJ6U
         6Sv7tqf3zS3LoeHoVrv/dYl94KoDfDcg2letRYrvu9sOI9LAjNDJynosk9vepHmbf/FB
         6acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RZERPFUWOa/lGcWiQ5EhbcD6LWlr2/Pa13KS0SVnOxA=;
        b=Nn9tDTEMQmCrcmgzfp+Z+a9MRYutODTgwp1C4mCx2NgxKVyemifgcDtt/Uyfpwt0wa
         BYEHPeBskyDvOVi8qZj6MfSVVMcT+MlcIMa793YYZEUcKAyQq5Dzt+3vsvf7w80d0D74
         As6+4nzxhjhE5f98NnrU1fU9dSTLLJqBazRi6Xs2JKCXMKmcUOP8XMyIAMSyETM9kq1H
         hAJXnQpwanbjvmi4O602Hn2QfDYuxDTgTFG4Hl/e1fIVX1PCxakUrpPqLV0zV5WWSv7h
         xFl8M9SlPVR/CjBn3RwYHavV53O4WXjjvYBWOxpfQW3jPd6HpWly8UkfTHbm6IkkT9On
         ktpA==
X-Gm-Message-State: APjAAAVkfcs0XdWqVjH6VuvVw633ZcMeYlNvBAlyYCWZag6wsMW9I2eQ
        6lMNvFhEvvTmtRHp6c6zbHQ=
X-Google-Smtp-Source: APXvYqwP6lN+FX26HO0D+3bQ6kltC8zufv++XlnDc/HaLnSifJopyycs6Su36vlSHd2v9uimA5JdCw==
X-Received: by 2002:adf:e984:: with SMTP id h4mr5937907wrm.275.1575490702578;
        Wed, 04 Dec 2019 12:18:22 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f2sm7329254wmh.46.2019.12.04.12.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:18:21 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v4 0/5] Fix nits in the kunit
Date:   Thu,  5 Dec 2019 05:17:58 +0900
Message-Id: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains trivial fixes for the kunit documentations and the
wrapper python scripts.

Changes from v3
(https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
 - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to set
   default value of 'build_dir' as '' instead of NULL so that kunit can run
   even though '--build_dir' option is not given.

Changes from v2
(https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
 - Make 'build_dir' if not exists (missed from v3 by mistake)

Changes from v1
(https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
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
 tools/testing/kunit/kunit.py            | 18 +++++++++++-------
 tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
 3 files changed, 21 insertions(+), 20 deletions(-)

-- 
2.7.4

