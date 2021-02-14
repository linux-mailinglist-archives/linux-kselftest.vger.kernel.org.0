Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD131B175
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Feb 2021 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBNRLk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Feb 2021 12:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBNRLj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Feb 2021 12:11:39 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A7C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Feb 2021 09:10:58 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Ddtzg0qsSzQlYT;
        Sun, 14 Feb 2021 18:10:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1613322653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GxbQ9HJO1VA3LunZTpKKynkctAU7mWQYF4dgVt0R2g4=;
        b=cytgZU/zpWW8ELR0fkW7HYs0xsPLIJ+gS628TlfeIjm1U+Sgha7zjpE2nzf+gHVLuDjjfZ
        hRaVPIPN33KQCSso41Qksjmhni1a3kXkxgZzL0qkBuzFNWNEqW/DDnwyHhP3HVyL4Uv8HP
        TFyhRRc//nio36KVmjpuVYy8QH2LPbo/Lnb7uxt5Em8zKqzGUb8msfHuQ54z5QOROPrQgY
        PnKTyTCcCaaFJI5AWPJT+pNHAQ6oDKdV1vrSYawog/Ch+IV5QOYP0CdxKE1Vr/IKYxy8OH
        zbJC53XntMvRJK6Hi60/ZpR8HsD5/aGeEDqmyWmJnxLv0FJZ3JUHtDKvbKs6Hg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id DzTylZPN8-OW; Sun, 14 Feb 2021 18:10:48 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     shuah@kernel.org
Cc:     richardcochran@gmail.com, davem@davemloft.net, olteanv@gmail.com,
        vincent.cheng.xh@renesas.com, christian.riesch@omicron.at,
        linux-kselftest@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] testptp: Fix compile with musl libc
Date:   Sun, 14 Feb 2021 18:09:40 +0100
Message-Id: <20210214170940.32358-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 0.27 / 15.00 / 15.00
X-Rspamd-Queue-Id: CC65B1847
X-Rspamd-UID: a45853
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Musl libc does not define the glibc specific macro __GLIBC_PREREQ(), but
it has the clock_adjtime() function. Assume that a libc implementation
which does not define __GLIBC_PREREQ at all still implements
clock_adjtime().

This fixes a build problem with musl libc because the __GLIBC_PREREQ()
macro is missing.

Fixes: 42e1358e103d ("ptp: In the testptp utility, use clock_adjtime from glibc when available")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 tools/testing/selftests/ptp/testptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index f7911aaeb007..ecffe2c78543 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -38,6 +38,7 @@
 #define NSEC_PER_SEC 1000000000LL
 
 /* clock_adjtime is not available in GLIBC < 2.14 */
+#ifdef __GLIBC_PREREQ
 #if !__GLIBC_PREREQ(2, 14)
 #include <sys/syscall.h>
 static int clock_adjtime(clockid_t id, struct timex *tx)
@@ -45,6 +46,7 @@ static int clock_adjtime(clockid_t id, struct timex *tx)
 	return syscall(__NR_clock_adjtime, id, tx);
 }
 #endif
+#endif /* __GLIBC_PREREQ */
 
 static void show_flag_test(int rq_index, unsigned int flags, int err)
 {
-- 
2.20.1

