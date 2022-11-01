Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2C614A87
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 13:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKAMVQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKAMVP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 08:21:15 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D815A28;
        Tue,  1 Nov 2022 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667305270;
        bh=75pCasUsHqBk31UsD2MHbUsUh53DCMpvOo4pIhDwXDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SxERwk2yicWLXruWR9UYPY62g4Sgsgofq1A/R1GPlOb98JGnKBLBLMt5vxUImCXUy
         DSb/35c4485XgN8jjipYBNVJQb17vlcR/6FnOxDUUvtAEz56eSrZornYvmDAajBxZ1
         E3KkeCZXmDwBe1fVk+gcVjy6R5rhCU7KqanoXung=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 5458DCCE; Tue, 01 Nov 2022 20:21:05 +0800
X-QQ-mid: xmsmtpt1667305265tr27vlhfu
Message-ID: <tencent_ED443B037FA1D72CB4CB38958E57F2D12007@qq.com>
X-QQ-XMAILINFO: NUmvkRAbRxZgsBl3jbK6+SAphFPsVPLkCwSPPdEguHkkovswAQWlXf+b79DpDm
         6DnVWkC0Rrs/3iGq+CdtRWNhELQ4K/z4/1tbOy9DITMM2irKuYWSQ2Ehu8JOGeAsjAry5ojwr03A
         xKckEd02j5C2IisSzbBDR/xudTReQWARwQl7cbHf0C29A8H5TT3/LUkM7NDtWtK+iE2CMGoSizuf
         LVZNnUvNmIKmlimfexBxWoHEOaFrmgs0Wa56maLBc1Fi4foOdmhPF/mSLrsewRfDKoXxAVRL66+0
         SgDPVTPdh7WzZefSLLBzkxpmIFRB4thWEgrPZIG/U9R0wNBq3l11Y630AH7JqGY0CXebf5BCtCV8
         kzYf/Q+tv9dmIeHybF4Az0ySCvWTw6tiFSjkBy80YviD4mP5tMRUKveTijK+rNOiIugg6HHJwkDL
         9hygDW7aXv1q/idJBFgm9EPKywl9kaEbig5bCV9hp/D25rbfo3Vb3cdfqViL3TVU3+3KAeMQqooa
         ECOTN5HVpG22Pnx8THkfu/ZCA6bV5FrkNUnmNtrSHV4M0nfxc5YiYqc+dd0tjyIqOUwTlIG93hqw
         JPWlCAS4H96fzVIU+KPTCAxAFcfvaAtozStmfcwA3myJZ0bPqz5w3vS3esvbKeHWNAT56CGtT4Gy
         X6Wm/D8XDL2mDZs5zqY/GWFojbh5i3OE/TP9iSbpBIqd6ozbtNR1Xumnh5xebhasa3HZUhwg+pkF
         7fHaeBjN+w1mbGncsbk5ZotBQlj5Eaf13xZ65bQDJm/4kEg5an7gbxrWoMMjaxv9czEJJld5rmOh
         THSNU2xU//oDrbggjlIQJsYGUGNA4vIpBgT/hnkGCt7TKOi52x1G8ZNIxsmsAq42Oq8i+AmQ1gVu
         KcpN8kCNEi6fyGZXvHxLQ5mrKZ6TsGLeyjxXl/402aaM74NUOM+2lNV5NoexA1vQaqz6Phwf2+/z
         eXhFwLiRC5HAW73k5TEoJxnFYktB7u5swbWW/S7mzMtbBtupMx4QUHVzX/mak8J+5gGxjWVnzn5w
         /fhfHtqw==
From:   Rong Tao <rtoax@foxmail.com>
To:     david.laight@aculab.com
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Date:   Tue,  1 Nov 2022 20:21:04 +0800
X-OQ-MSGID: <20221101122104.54265-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <70ddf02157bc418cbc38230c87a7b228@AcuMS.aculab.com>
References: <70ddf02157bc418cbc38230c87a7b228@AcuMS.aculab.com>
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
 tools/testing/selftests/bpf/xsk.c            | 19 -------------------
 3 files changed, 21 insertions(+), 20 deletions(-)

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


