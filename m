Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757BB1E649F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbgE1OwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 10:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391255AbgE1OwV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 10:52:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A442075F;
        Thu, 28 May 2020 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590677541;
        bh=FapqSyp7PbMw4eQbsOKi/qDa62bAlW+gr+fJp3y8L4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2fE3cRMsr3X8t8DECNVNHLTF3xvPPb93zMo6cCeB04fcJbopDAQ+Z2OaqHdoKhNtl
         NCqEuAKxcTRTTx1iJXfxA83oMm2osQwXLsp+Zu7atRfaizo+g8UfxlYtZYjd76ryTE
         LbM63KnuZS72SaqvhhWu00hq9HEG2DPhIiHjynmQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: [PATCH 2/4] lib: Make test_sysctl initialized as module
Date:   Thu, 28 May 2020 23:52:16 +0900
Message-Id: <159067753624.229397.13771427935697541820.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159067751438.229397.6746886115540895104.stgit@devnote2>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test_sysctl.c is expected to be used as a module, but since
it does not use module_init(), it never be registered as
a module and not appeared under /sys/module/.
In the result, the selftests/sysctl/sysctl.sh always fails
to find the test module and is skipped.

This makes test_sysctl.c initialized as a module by module_init()
and allow sysctl.sh to find the test module is loaded.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/test_sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 566dad3f4196..ec4d0f03475d 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -149,7 +149,7 @@ static int __init test_sysctl_init(void)
 	}
 	return 0;
 }
-late_initcall(test_sysctl_init);
+module_init(test_sysctl_init);
 
 static void __exit test_sysctl_exit(void)
 {

