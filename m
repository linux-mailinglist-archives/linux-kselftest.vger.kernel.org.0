Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F26E4A74
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502363AbfJYLup (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Oct 2019 07:50:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:43728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfJYLup (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Oct 2019 07:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 886C1B49A;
        Fri, 25 Oct 2019 11:50:43 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] selftests/livepatch: Disable the timeout
Date:   Fri, 25 Oct 2019 13:50:41 +0200
Message-Id: <20191025115041.23186-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
timeout per test") introduced a timeout per test. Livepatch tests could
run longer than 45 seconds, especially on slower machines. They do not
hang and they detect if something goes awry with internal accounting.

Better than looking for an arbitrary value, just disable the timeout for
livepatch selftests.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/testing/selftests/livepatch/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/livepatch/settings

diff --git a/tools/testing/selftests/livepatch/settings b/tools/testing/selftests/livepatch/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/livepatch/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.23.0

