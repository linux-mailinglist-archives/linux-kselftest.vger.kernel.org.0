Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B587A0A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbjINQCQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 12:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbjINQCB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 12:02:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39953272A;
        Thu, 14 Sep 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694707293;
        bh=Cu53Z9oyo5nGu95h1+MArmP5k33gYn4AQCWOgwsV/Ac=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nJXJ1xXHesT1KczhMwLWfm4v2NTSTPtV6KAFS2C4/pVvhrkdw5iJnNuZPfzcNH81X
         EtTjjm+ZcV9Z7OFkbIZxH8hQi/WlF1z44FUARs5NxJ4SAmGq+cjERWC0zZPVi655jx
         B+V7D+nxIi6ovzre3715c/cC7TfgIxPeombwOIp4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 14 Sep 2023 18:01:19 +0200
Subject: [PATCH 3/4] tools/nolibc: don't define new syscall number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230914-nolibc-syscall-nr-v1-3-e50df410da11@weissschuh.net>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
In-Reply-To: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707292; l=1227;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Cu53Z9oyo5nGu95h1+MArmP5k33gYn4AQCWOgwsV/Ac=;
 b=gJVRysrB+1Fm++kEZkA6QvwJaFYmt27QWy1msKjd+eJjR2FaQgck9iIwYB4bxpA6by3xzT2p2
 PzfnrKof6pvBVVTgIWWtMX9cfqisWMmTH2n3Am9bIT64PWNQbOqeho2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All symbols created by nolibc are also visible to user code.
Syscall constants are expected to come from the kernel headers and
should not be made up by nolibc.

Refactor the logic to avoid defining syscall numbers.
Also the new code is easier to understand.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index bc56310c6bdf..d96f2aa7d987 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -954,11 +954,10 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#elif defined(__NR__newselect) || defined(__NR_select)
-#ifndef __NR__newselect
-#define __NR__newselect __NR_select
-#endif
+#elif defined(__NR__newselect)
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_select)
+	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
 #else
 	(void)nfds;
 	(void)rfds;

-- 
2.42.0

