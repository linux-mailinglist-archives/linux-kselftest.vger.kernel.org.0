Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D42CC23E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgLBQ1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 11:27:44 -0500
Received: from smtp-42ac.mail.infomaniak.ch ([84.16.66.172]:44887 "EHLO
        smtp-42ac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbgLBQ1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 11:27:43 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CmPW50M3SzlhVkF;
        Wed,  2 Dec 2020 17:26:57 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CmPW43v5pzlh8TK;
        Wed,  2 Dec 2020 17:26:56 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH] selftests/seccomp: Update kernel config
Date:   Wed,  2 Dec 2020 17:26:43 +0100
Message-Id: <20201202162643.249276-1-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

seccomp_bpf.c uses unshare(CLONE_NEWPID), which requires CONFIG_PID_NS
to be set.

Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Acked-by: Tycho Andersen <tycho@tycho.pizza>
---

Previous version:
https://lore.kernel.org/lkml/20201030121819.764395-1-mic@digikod.net/

Changes since v1:
* Add Acked-by: Tycho Andersen <tycho@tycho.pizza>
* Synchronize From and Signed-off-by emails.
---
 tools/testing/selftests/seccomp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/seccomp/config b/tools/testing/selftests/seccomp/config
index 64c19d8eba79..ad431a5178fb 100644
--- a/tools/testing/selftests/seccomp/config
+++ b/tools/testing/selftests/seccomp/config
@@ -1,3 +1,4 @@
+CONFIG_PID_NS=y
 CONFIG_SECCOMP=y
 CONFIG_SECCOMP_FILTER=y
 CONFIG_USER_NS=y

base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
2.29.2

