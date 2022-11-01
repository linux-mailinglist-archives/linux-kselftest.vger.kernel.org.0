Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BB614C7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKAOXW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKAOXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:23:21 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA121B1FB;
        Tue,  1 Nov 2022 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667312593;
        bh=l57fPtvVIgXTiYLMlFVCC6EXs6IDtJKDnxNvjdOUkcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dG4TA+4Bll7492rMsS8WJaix0eoOwd7HqJaAylQ9majA9lMWH3lAdDOHRgomRnAkx
         p7gkd8+tclRIsPHJiVIpcZWie70dvu8i3VBT42+H8c6GYIR1/No4zU6Zrp2E/t+vGO
         dLTymhQKQvxhQ7X4h5iBGnzbLRC7wWi94CMGk8x8=
Received: from localhost.localdomain ([111.199.189.86])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 5C8A8617; Tue, 01 Nov 2022 22:23:08 +0800
X-QQ-mid: xmsmtpt1667312588tydmkk56a
Message-ID: <tencent_630BF3724BC5EA157B341EB1C7604EE83705@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8nya1MpOLbHO6M3R7kUmTeJKqU8bBsXqWRReOWDSDVWI6V8tWhN
         YGrHWs/ZqniKBScePxRhbqgGs190QduRHvk0+3ORugItPyo+KjTrVkAwfZFRPoHaE8g6aTEOsKu/
         DtH3P2KV1Rvi4Zr3KSKl6Crl6xCDX/qiUJ62/aimuZao6phXPLed2obw86eoOAMtKZZmVRVHBl9s
         GUsWE0XQH2eFlp3KCVkymh5ZzPdiB6BsmwCY3x3g6XDmdhEtSkKrdzGeholKfA5WJx58BE/lSMFz
         h0G5vEkQ2E7ICILcIqvMxk6K8+9cgRp8bGr5JETqN7v7rpa2sphVrCpS6m5u1Lxjl18KeTaRBK9y
         Syt6VMCfnctkcFAOLumCvwKbXj6FbJYkzEFOWzvktbWNbskSG7JSc256E+tGIQVlsmjKjTubmN/Z
         hic6em+Wmub3kqm8Oo0NutB2do6AcJ0PjYDd0Rh3cqc2tqx/Y3BiAs6ISjGvBHPte/ev43eU7CEc
         AKQR56nHD0HgCvOnWgBlYKKNxM3qC2DdB6a/oOloZI8i6WVqfayjLJ/hO8wfdM6UCNOdvNkhhtSc
         WBOMPqRpICZQd/WWJmhzNLRCe9MQsHZSg0/C8UFogHQ2zZNjISA++DtrwGhB8RTLvvRZepfka+GK
         45NQm2uC8syIUepLvCMzZ0jf3DpHEX7U+5uyhzO/dH8Fv7MQKs7k8YlZigI/QJe8BIb2fA0T+al/
         m0WJdbe5m6LEaRZcQgaQlYrnlTkzGZmogl367ToL5MAILCJu4itC7GBh1voxTYzlua4GUrQYDsqI
         Niv4X/6Hys/q5uEXXqgjN6eLTo6qrPisOvdQkVp0zTXN2rd52Yhf48rXuqjdCFaRWbJb0sywfEda
         vuqFjBZDGMdk1E6CyXCz9K+R8GJSyHjRi93e1WoOvUtDyPMxBKfzClOfC90AIl3dlYNG0K1bb6WO
         9hRHCW4gftV8RBiHNIv6KcqXI7XA74KNDpGFaOXhhIiP9a6kgiYio++dncugKNo81BVCFy5pTbqM
         o7M0PjNEQczUTFfkRI
From:   Rong Tao <rtoax@foxmail.com>
To:     daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, david.laight@aculab.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Date:   Tue,  1 Nov 2022 22:23:07 +0800
X-OQ-MSGID: <20221101142307.19414-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <fc8634e8-6efd-9911-cab4-07ad6ba4ad33@iogearbox.net>
References: <fc8634e8-6efd-9911-cab4-07ad6ba4ad33@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

move libbpf_strlcpy() to bpf_util.h, and replace strncpy() with
libbpf_strlcpy(), fix compile warning.

Compile samples/bpf, warning:
$ cd samples/bpf
$ make
...
cgroup_helpers.c: In function ‘__enable_controllers’:
cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
   80 |                 strncpy(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/bpf_util.h       | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.c |  3 ++-
 tools/testing/selftests/bpf/xsk.c            | 20 +-------------------
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index a3352a64c067..bf78212ff6e9 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -20,6 +20,25 @@ static inline unsigned int bpf_num_possible_cpus(void)
 	return possible_cpus;
 }
 
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
 #define __bpf_percpu_val_align	__attribute__((__aligned__(8)))
 
 #define BPF_DECLARE_PERCPU(type, name)				\
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index e914cc45b766..e33b70e509da 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -13,6 +13,7 @@
 #include <ftw.h>
 
 #include "cgroup_helpers.h"
+#include "bpf_util.h"
 
 /*
  * To avoid relying on the system setup, when setup_cgroup_env is called
@@ -77,7 +78,7 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		strncpy(enable, controllers, sizeof(enable));
+		libbpf_strlcpy(enable, controllers, sizeof(enable));
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index 0b3ff49c740d..cf6e9ab37b1b 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -33,6 +33,7 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 #include "xsk.h"
+#include "bpf_util.h"
 
 #ifndef SOL_XDP
  #define SOL_XDP 283
@@ -521,25 +522,6 @@ static int xsk_create_bpf_link(struct xsk_socket *xsk)
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

