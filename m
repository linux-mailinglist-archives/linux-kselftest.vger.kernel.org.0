Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17D2AFA68
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgKKVer (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:34:47 -0500
Received: from smtp-190f.mail.infomaniak.ch ([185.125.25.15]:60989 "EHLO
        smtp-190f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgKKVer (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:47 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdKx0gBtzlhGL9;
        Wed, 11 Nov 2020 22:34:45 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdKw4jtzzlh8T5;
        Wed, 11 Nov 2020 22:34:44 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/9] Landlock fixes
Date:   Wed, 11 Nov 2020 22:34:33 +0100
Message-Id: <20201111213442.434639-1-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patch series fixes some issues and makes the Landlock filesystem
access-control more consistent and deterministic when stacking multiple
rulesets.  This is checked by current and new tests.  I also extended
documentation and example to help users.

This series can be applied on top of
https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/log/?h=landlock_lsm

Regards,

Mickaël Salaün (9):
  landlock: Fix memory allocation error handling
  landlock: Cosmetic fixes for filesystem management
  landlock: Enforce deterministic interleaved path rules
  landlock: Always intersect access rights
  landlock: Add extra checks when inserting a rule
  selftests/landlock: Extend layout1.inherit_superset
  landlock: Clean up get_ruleset_from_fd()
  landlock: Add help to enable Landlock as a stacked LSM
  landlock: Extend documentation about limitations

 Documentation/userspace-api/landlock.rst   |  17 +++
 samples/landlock/sandboxer.c               |  21 +++-
 security/landlock/Kconfig                  |   4 +-
 security/landlock/fs.c                     |  67 +++++-----
 security/landlock/object.c                 |   5 +-
 security/landlock/ruleset.c                |  34 ++---
 security/landlock/syscall.c                |  24 ++--
 tools/testing/selftests/landlock/fs_test.c | 140 +++++++++++++++++++--
 8 files changed, 239 insertions(+), 73 deletions(-)


base-commit: 96b3198c4025c11347651700b77e45a686d78553
-- 
2.29.2

