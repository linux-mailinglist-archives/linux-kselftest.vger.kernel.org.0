Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43761632E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKBM7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 08:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKBM7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 08:59:23 -0400
X-Greylist: delayed 99233 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 05:59:21 PDT
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0A2871B;
        Wed,  2 Nov 2022 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667393957;
        bh=stZjbsbh1QGjqNPL6prVTAW1AvJUHAcq+yDf+xactvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yL05dZrfLeMUOj4gruBroqn84DUNXdSpZrTVtTCmHEj3MF9sogTme39DKRqY4zPtR
         fEBHXAXIi+wupYplwnv7E/AUQ7F46RtOz81YnTtqkX/lUSnDRfbGSeVd5zqpVP4zTy
         AElWs3DeGaJFayhCyd1LHofHC/J2f8U4C+4Ekpbg=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id ECC23E84; Wed, 02 Nov 2022 20:59:12 +0800
X-QQ-mid: xmsmtpt1667393952tgoyzzrog
Message-ID: <tencent_B91CA31B889B06CF4292592F97892A53AF08@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6T7UaXCU2GP2B98Bn/6Oj0GGHqbSaMeFY4dM6yCDCzIYZga8oGS
         Do/Q7K59QjCbX9HFc/nC+5m6Ydadnko/0vF1fOKB9+gAd+c73JctMJsTx+lFPmiC1tKEorfsa+YI
         AWg4rzXMWHIcxDtFXMH16ke60IY/DlzAXO3UCrSiWlcfEz5gD+yLoYua6NA7Sn64F75J+RJEf++v
         oBZHNv/KH8RmQ4zRmJlSYN9f6nuMo0BG4ASGMYUZia92+p+k24WJAnbRsg/79bjyeGgR4oUPkhdj
         nppcnjdrBO9Crx1t+A/zJeoKRQYsGK606zj+z4nQuy81EGdSk/mvzhjd9ciNGeSxlKOjzJrCOwd/
         rrF0e54jkkMqGySf6mHe52JDUZ0b3FmxE+zY/vuFB/1Us0eTd2+2F7Ynm5t7yMoKoD4ZSTuAX3N4
         D4VkqTGYv0hxVTyId2oCiH4xvsCsimUCZXybfwHQVyZQj/vY1HGNtr7Wbe7x/eFb76v4Xn7V9Ezw
         peXOo9iTu1ua7ncWeTKTCCx0gh94rgZF2+v5tSGMeupRuOVbdZ5uS6ve6SupgRxoZTLUNYprA4au
         2x60gGkynfyrUaLmjuSpRs/K+GsifhfBSD/StaokSCXyIcyU30QEvyAGHMSBrA1b7Mf1BRYr621D
         tg+Mur6B7sR68dYRzw5ji/053oRTmtuglBL3F6iQ1cEaTppSzXfi1VHYD49HEW2K9Y39zk+E6SZO
         yaXOm58TasqRwN/1WzkYsk4CfugD6DsLblEzS+Y1tYJEQPkz0EndR6ULQU54NGkTUX3X+T5upzKj
         i7PMrOTBYvgWrp9v6bHJJhs928ZQQSyxhs3/UBQIBcPiTnACQtvqBzWQDjYPSW+J6dshWPIzHUdb
         58WvZAb6Hecx1/6tvkxGivRBILXFWbURwINbXgFJBJyJWaNXH6zAiR9PuA+57H/8/+d94jC8UuGF
         uBCHepGNO9/hQyo/a7Cb+YQq0I5ZUYs6E81k9smxkutwGT2+2eott+ctUxAgPhTdJiN2baJiHRVN
         gTz8luaA==
From:   Rong Tao <rtoax@foxmail.com>
To:     daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, david.laight@aculab.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] selftests/bpf: cgroup_helpers.c: Fix strncpy() fortify warning
Date:   Wed,  2 Nov 2022 20:59:10 +0800
X-OQ-MSGID: <20221102125910.465060-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <fe0e300f-a857-dc42-f9f8-c524be6b212f@iogearbox.net>
References: <fe0e300f-a857-dc42-f9f8-c524be6b212f@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Move libbpf_strlcpy() to libbpf_common.h, and replace strncpy() with
libbpf_strlcpy(), fix compile warning.

We can't use libbpf_internal.h directly, because it introduces a lot of
header dependency issues. So move libbpf_strlcpy() into libbpf_common.h,
and if you need to use the libbpf_strlcpy() function, you need to include
the header file libbpf.h

How to reproduce this compilation warning:

$ make -C samples/bpf
cgroup_helpers.c: In function ‘__enable_controllers’:
cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
   80 |                 strncpy(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/lib/bpf/libbpf_common.h                | 19 +++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h              | 19 -------------------
 tools/testing/selftests/bpf/cgroup_helpers.c |  3 ++-
 tools/testing/selftests/bpf/xsk.c            | 19 -------------------
 4 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 9a7937f339df..9d5132e0bec9 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -70,4 +70,23 @@
 		};							    \
 	})
 
+/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
+ * is zero-terminated string no matter what (unless sz == 0, in which case
+ * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
+ * in what is returned. Given this is internal helper, it's trivial to extend
+ * this, when necessary. Use this instead of strncpy inside libbpf source code.
+ */
+static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
+{
+	size_t i;
+
+	if (sz == 0)
+		return;
+
+	sz--;
+	for (i = 0; i < sz && src[i]; i++)
+		dst[i] = src[i];
+	dst[i] = '\0';
+}
+
 #endif /* __LIBBPF_LIBBPF_COMMON_H */
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..902110ffb7a6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -191,25 +191,6 @@ static inline void *libbpf_reallocarray(void *ptr, size_t nmemb, size_t size)
 	return realloc(ptr, total);
 }
 
-/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
- * is zero-terminated string no matter what (unless sz == 0, in which case
- * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
- * in what is returned. Given this is internal helper, it's trivial to extend
- * this, when necessary. Use this instead of strncpy inside libbpf source code.
- */
-static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
-{
-	size_t i;
-
-	if (sz == 0)
-		return;
-
-	sz--;
-	for (i = 0; i < sz && src[i]; i++)
-		dst[i] = src[i];
-	dst[i] = '\0';
-}
-
 __u32 get_kernel_version(void);
 
 struct btf;
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e914cc45b766..e3bfe2b13018 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <ftw.h>
+#include <bpf/libbpf.h>
 
 #include "cgroup_helpers.h"
 
@@ -77,7 +78,7 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		strncpy(enable, controllers, sizeof(enable));
+		libbpf_strlcpy(enable, controllers, sizeof(enable));
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index 0b3ff49c740d..4b6890e2a0a9 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -521,25 +521,6 @@ static int xsk_create_bpf_link(struct xsk_socket *xsk)
 	return 0;
 }
 
-/* Copy up to sz - 1 bytes from zero-terminated src string and ensure that dst
- * is zero-terminated string no matter what (unless sz == 0, in which case
- * it's a no-op). It's conceptually close to FreeBSD's strlcpy(), but differs
- * in what is returned. Given this is internal helper, it's trivial to extend
- * this, when necessary. Use this instead of strncpy inside libbpf source code.
- */
-static inline void libbpf_strlcpy(char *dst, const char *src, size_t sz)
-{
-        size_t i;
-
-        if (sz == 0)
-                return;
-
-        sz--;
-        for (i = 0; i < sz && src[i]; i++)
-                dst[i] = src[i];
-        dst[i] = '\0';
-}
-
 static int xsk_get_max_queues(struct xsk_socket *xsk)
 {
 	struct ethtool_channels channels = { .cmd = ETHTOOL_GCHANNELS };
-- 
2.31.1

