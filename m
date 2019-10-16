Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1055CD8F99
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfJPLdU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 07:33:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:35590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbfJPLdU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 07:33:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5662BB188;
        Wed, 16 Oct 2019 11:33:18 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v3 0/3] ftrace: Introduce PERMANENT ftrace_ops flag
Date:   Wed, 16 Oct 2019 13:33:12 +0200
Message-Id: <20191016113316.13415-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Livepatch uses ftrace for redirection to new patched functions. It means
that if ftrace is disabled, all live patched functions are disabled as
well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
It is not a problem per se, because only administrator can set sysctl
values, but it still may be surprising.

Introduce PERMANENT ftrace_ops flag to amend this. If the
FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
disabled by disabling ftrace_enabled. Equally, a callback with the flag
set cannot be registered if ftrace_enabled is disabled.

v2->v3:
- ftrace_enabled explicitly set to true
- selftest from Joe Lawrence (I just split it to two patches)
- typo fix

v1->v2:
- different logic, proposed by Joe Lawrence

Joe Lawrence (2):
  selftests/livepatch: Make dynamic debug setup and restore generic
  selftests/livepatch: Test interaction with ftrace_enabled

Miroslav Benes (1):
  ftrace: Introduce PERMANENT ftrace_ops flag

 Documentation/trace/ftrace-uses.rst           |  8 +++
 Documentation/trace/ftrace.rst                |  4 +-
 include/linux/ftrace.h                        |  3 +
 kernel/livepatch/patch.c                      |  3 +-
 kernel/trace/ftrace.c                         | 23 ++++++-
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/functions.sh  | 34 +++++++---
 .../selftests/livepatch/test-callbacks.sh     |  2 +-
 .../selftests/livepatch/test-ftrace.sh        | 65 +++++++++++++++++++
 .../selftests/livepatch/test-livepatch.sh     |  2 +-
 .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
 11 files changed, 132 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-ftrace.sh

-- 
2.23.0

