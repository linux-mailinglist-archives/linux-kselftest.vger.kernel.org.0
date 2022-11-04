Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C610E618DA0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 02:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKDB2N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKDB2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 21:28:06 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBAC23396;
        Thu,  3 Nov 2022 18:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667525281;
        bh=97NTQrGjhU6NxW3LqmcxEye1WtDELGVVc3QpdO5C//o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=v1FxifU306S8S8Al31LWzWHZMKyyXCwi13rfsB6dl1JLnNX+Pl5SAKzohHX6TET2U
         lZET6/vS4AzNjJsTclyfA/lc1xWiDof2V8m2ABEMhUIH97xTz67/bJ15bZk4Ijxu/f
         BUXKuf1iz5L8N6OAhNUImyWL4kR5ML0cIyHi7fRY=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 6F83B809; Fri, 04 Nov 2022 09:27:56 +0800
X-QQ-mid: xmsmtpt1667525276t86v0w579
Message-ID: <tencent_469D8AF32BD56816A29981BED06E96D22506@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9CuKnjIQclbzLKdKQoECHB/HARwfNKMRd1slsqwmunFhqL46bBi
         Kjk1ejNtv+INL6fZOO7emYHBshwONKKXj9zr/u4gUQJtiYrlG6cRFcCH6kZtpzp8oR897CbzxNAf
         si3v7PwUyKPZR3TTTA/9Cav/0W9DwlzZVX9tgYDSctJy7xRsaEIed0lrMYiQKaqt8bdykduYvre9
         D+jeweGGKv1CT7qMQPh6/IeL7lZB+MMD9oJFE9P/PvIqbHS0MuqFiF4oPegTHWgOb0aST+e5lrKd
         6V1rZbcGIKSxaNO4Bvp8rCq5ETlhIsBTwzc2Xqtwh6bOvH4YLEvwCIXNXn/dU/UGH1nddplnLS5K
         5DexdWjet36EwMRA8XfE5HAXoGO2dY6xTkgZEv8X5aQitUOb9zBbYTjpjJmlqUhoBqwLOcEzUUco
         whUaRxrAftgscP3PV8zxejCkQ+M2ZMtF+UocUma3++/9arhU6iLhetF4QWLPbBZ3on3bXHvzfG7X
         WSO3Qy1mdoUy1mSrQhPkbv+zfcPr1D7H4WLpJFlq22UzMnPnBVI1H2gYPsKRsG3Ux3z3cnSv9dwk
         NQh1ZOLJSd8E1zSD3ziPCpXcnhbgb6jcKwAyv8RhKsxHNCL7aWYNEO11cR549imsaJLpkyhwqtv4
         ITFQfsapBz4jjJsvXO2jU72HK2lpNeScqx9OMglSNBwmYB7biCKiJZd3A2lAk4nhv8yGshxngOy7
         d4zHMZ0MH6fUQwjcRUsKQBlBAIHfZ25uZQ5fWTSVeoxJtLcBU1vbUNJX+j7Hx+RJmQCVj/5ykP2R
         27hrAp0c8yqGnMCK2rLIeXrPewDtD4QHEZPUwaJNpi2b/J5SQ6u4ZYPj4lDY1rx4FENxefbeFnsz
         Jq3mzaHN3dJWbNhfHOatXT9wt56GbWvuDn4UoDMFivHfY6ie0/wzGZrjgFlZ2KRtoHa34Z0+3ZTm
         zt/8QDIVimZti6JQWKyC7qd5ljCat+1UZgoniPVRyafEu01Vrnpw==
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, david.laight@aculab.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] selftests/bpf: cgroup_helpers.c: Fix strncpy() fortify warning
Date:   Fri,  4 Nov 2022 09:27:54 +0800
X-OQ-MSGID: <20221104012754.651653-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzYAcGgM93r5YfF2ZQWjAnc4k=aN5C3in-bZ-6n+Jrn1vw@mail.gmail.com>
References: <CAEf4BzYAcGgM93r5YfF2ZQWjAnc4k=aN5C3in-bZ-6n+Jrn1vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Copy libbpf_strlcpy() from libbpf_internal.h to bpf_util.h, and rename it
to bpf_strlcpy(), then replace selftests strncpy()/libbpf_strlcpy() with
bpf_strlcpy(), fix compile warning.

The libbpf_internal.h header cannot be used directly here, because
references to cgroup_helpers.c in samples/bpf will generate compilation
errors. We also can't add libbpf_strlcpy() directly to bpf_util.h,
because the definition of libbpf_strlcpy() in libbpf_internal.h is
duplicated. In order not to modify the libbpf code, add a new function
bpf_strlcpy() to selftests bpf_util.h.

How to reproduce this compilation warning:

$ make -C samples/bpf
cgroup_helpers.c: In function ‘__enable_controllers’:
cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
   80 |                 strncpy(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/bpf_util.h       | 19 ++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.c |  3 ++-
 tools/testing/selftests/bpf/xsk.c            | 26 +++-----------------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
index a3352a64c067..10587a29b967 100644
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
+static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
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
index e914cc45b766..dd1aa5afcf5a 100644
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
+		bpf_strlcpy(enable, controllers, sizeof(enable));
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index 0b3ff49c740d..39d349509ba4 100644
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
@@ -552,7 +534,7 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 		return -errno;
 
 	ifr.ifr_data = (void *)&channels;
-	libbpf_strlcpy(ifr.ifr_name, ctx->ifname, IFNAMSIZ);
+	bpf_strlcpy(ifr.ifr_name, ctx->ifname, IFNAMSIZ);
 	err = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (err && errno != EOPNOTSUPP) {
 		ret = -errno;
@@ -771,7 +753,7 @@ static int xsk_create_xsk_struct(int ifindex, struct xsk_socket *xsk)
 	}
 
 	ctx->ifindex = ifindex;
-	libbpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
+	bpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
 
 	xsk->ctx = ctx;
 	xsk->ctx->has_bpf_link = xsk_probe_bpf_link();
@@ -958,7 +940,7 @@ static struct xsk_ctx *xsk_create_ctx(struct xsk_socket *xsk,
 	ctx->refcount = 1;
 	ctx->umem = umem;
 	ctx->queue_id = queue_id;
-	libbpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
+	bpf_strlcpy(ctx->ifname, ifname, IFNAMSIZ);
 
 	ctx->fill = fill;
 	ctx->comp = comp;
-- 
2.31.1


