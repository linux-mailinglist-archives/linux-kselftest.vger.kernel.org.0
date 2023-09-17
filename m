Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2927A364D
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjIQPhF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjIQPgg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:36 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1211F;
        Sun, 17 Sep 2023 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694964988;
        bh=1NF2q2upNDj9/vMoCeQiX+AUEvsHPwNOqql4WRWM0Oo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PDYejELIHl1QbGAiIMk2tjDMYzW5D/26ieLRdJoDq4IaTyoVPh1QrNKnygwKUNiyQ
         Jyq+SfmCXjK1lWJGagf0A1MIMPRtCVraCZ4msErQL5i0VSvBxSvi3l0V196nHbXq8R
         /DTqZOqSbTaMg3kxexEOJoRNXkEGRbzQK9KDv0pA=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 17 Sep 2023 17:36:18 +0200
Subject: [PATCH v2 3/4] tools/nolibc: don't define new syscall number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230917-nolibc-syscall-nr-v2-3-03863d509b9a@weissschuh.net>
References: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
In-Reply-To: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694964977; l=1312;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1NF2q2upNDj9/vMoCeQiX+AUEvsHPwNOqql4WRWM0Oo=;
 b=HyWIKvOvEBDaT6rG3/p9D3aiZMZ5Ewl218rM+RUJeFdyJLTOV1Ab2odZNX32VYVmiMtWLk1w/
 htVnUFszqpVBrAyuiLAygf5fExGiweKx2+F3qUtWHRT8SHuTrjU4bcw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All symbols created by nolibc are also visible to user code.
Syscall constants are expected to come from the kernel headers and
should not be made up by nolibc.

Refactor the logic to avoid defining syscall numbers.
Also the new code is easier to understand.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8389820e1928..f05144e46b67 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -938,11 +938,10 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
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
 	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif

-- 
2.42.0

