Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16C380617
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhENJXN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 May 2021 05:23:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3688 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhENJXM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 May 2021 05:23:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhNJP6t6dz1BLWN;
        Fri, 14 May 2021 17:19:17 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 17:21:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <ckennelly@google.com>, <akpm@linux-foundation.org>
Subject: [PATCH -next] tools/testing/selftests/exec: fix link error
Date:   Fri, 14 May 2021 17:24:22 +0800
Message-ID: <20210514092422.2367367-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the link error by adding '-static':

gcc -Wall  -Wl,-z,max-page-size=0x1000 -pie load_address.c -o /home/yang/linux/tools/testing/selftests/exec/load_address_4096
/usr/bin/ld: /tmp/ccopEGun.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which may bind externally can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: /tmp/ccopEGun.o(.text+0x158): unresolvable R_AARCH64_ADR_PREL_PG_HI21 relocation against symbol `stderr@@GLIBC_2.17'
/usr/bin/ld: final link failed: bad value
collect2: error: ld returned 1 exit status
make: *** [Makefile:25: tools/testing/selftests/exec/load_address_4096] Error 1

Fixes: 206e22f01941 ("tools/testing/selftests: add self-test for verifying load alignment")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 tools/testing/selftests/exec/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index cf69b2fcce59..dd61118df66e 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -28,8 +28,8 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 $(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
 $(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
 $(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
-- 
2.25.1

