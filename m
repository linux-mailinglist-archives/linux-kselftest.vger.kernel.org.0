Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73B825E59C
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Sep 2020 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIEFbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Sep 2020 01:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgIEFbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Sep 2020 01:31:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40DDC061244
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Sep 2020 22:31:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EB22629B19B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH] selftests: Add missing gitignore entries
Date:   Sat,  5 Sep 2020 01:31:39 -0400
Message-Id: <20200905053139.3769803-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Prevent them from polluting git status after building selftests.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 tools/testing/selftests/firmware/.gitignore  | 2 ++
 tools/testing/selftests/netfilter/.gitignore | 2 ++
 tools/testing/selftests/ptrace/.gitignore    | 1 +
 3 files changed, 5 insertions(+)
 create mode 100644 tools/testing/selftests/firmware/.gitignore
 create mode 100644 tools/testing/selftests/netfilter/.gitignore

diff --git a/tools/testing/selftests/firmware/.gitignore b/tools/testing/selftests/firmware/.gitignore
new file mode 100644
index 000000000000..62abc92a94c4
--- /dev/null
+++ b/tools/testing/selftests/firmware/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fw_namespace
diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/selftests/netfilter/.gitignore
new file mode 100644
index 000000000000..8448f74adfec
--- /dev/null
+++ b/tools/testing/selftests/netfilter/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+nf-queue
diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 7bebf9534a86..792318aaa30c 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
 peeksiginfo
+vmaccess
-- 
2.28.0

