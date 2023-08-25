Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA92788505
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbjHYKhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbjHYKgh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 06:36:37 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B221E67;
        Fri, 25 Aug 2023 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692959792;
        bh=jJE5iplrxe3WtNxu9KkY2HFqumt/zV40jik2obAAn/E=;
        h=From:To:Cc:Subject:Date;
        b=sWb16gr4tjgfcRCQhn1mggQcvSk6JIGWNY2vPDIGR3jtbJxYIMiEGbvYFY2l+u6XD
         GkVnk0kBvGx3ozIh+zQReRnHsOlxcT/y4jh5hgkZvJmPyDBZgH+2vXu87/9nvntn48
         sAx62bg6LfH34PPR93VUWp8KB6w3f7xKWu7cfVTg=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 91B3D264; Fri, 25 Aug 2023 18:36:27 +0800
X-QQ-mid: xmsmtpt1692959787t4x138bb6
Message-ID: <tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujNxOiev4OpcuHBreT3JFAVC51ReBNkmRJO/pMsUvD9e42ZK6duK
         J5mWGrlDFmruuSx0dyetd5fZbBcTz2Wo3HE9jyg+U6w6QfiE+ULGTzAizqRUOB0nE8SeEREgkTaL
         kMPJouYzIqRxzsjO/lz8MAZHo95heh8Kd0SZ/cVkl27pbztlxaIeNqH5ZI/15Xu1fcJSY4J5jFqY
         QxCf9vBUGFgx+9vnoafhMaBBxMYrU23geM4jTo+P61DTQtO1wfoWmn+/+81UhLxvzSiFLXYzycb5
         Odu4WkCw5DHboreAFErFrvXBsUQ8IIpAQy1nWpugABZCtETbr4iy8daGTAK+JUALigvl82M+eNKV
         DctbHOO23b8zmEVpDZRtYPEvBxwZTg5TUW2iGpOF4BKIBRWTyTdz25optZBqJU/ijAMQKWudA3aB
         lQzIy3isK6xtAKE/MSkipHQ2HovkArayI02icyVvFhJ9euffgfaNd0bBYQ6XCsXEmPO0N+Uwdzuo
         bcDIaS5i06jfDQsafvubaesRiYfW++KdtWVXAR2C0pJIljjSpvvUYagyFTpkRkG221L7XnSovdvT
         tI19Ki61H7oJRdJdBa0Z9UkRaTZjWNx5+obtrcMtP8B31WPDQ8UostZUzgpmgTwbepxXnymgOAhA
         vEVFx2axtWP4wmASOEuExsCSxlIKsonU7KNGplqLszRDWbesaal0nA0NwHUqeRXw3LGC8PE33/ka
         +GjG/CVQB1bg6Cb+1ILXHYY7FBcyyeVnyLkLRz5gVChju/cIbYpTPN5hmtPhsDfiXrdciR+DyhGq
         zdJJndq8LXRbaUsXISW9zS4ayLzhLrYqq6MoWuiAz/q3idVTYqFS7D2t1DZgY9mV4bDinonugRvO
         mUhzL8lNIs8jyozPOxNhV25C+vpSEnyg0Cqk+bDVP+DecQO25UUpuV8kCByZqAGPB72W/M+HY8iM
         7a7o0xaz32hG4lv+FPuv4aUL3Zhn93ahPsEVyHsrFs/9WmyYjcSDIfeP/gwTJh
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
        sdf@google.com
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v7] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Fri, 25 Aug 2023 18:36:24 +0800
X-OQ-MSGID: <20230825103624.31766-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Static ksyms often have problems because the number of symbols exceeds the
MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
the problem somewhat, but it's not the perfect way.

This commit uses dynamic memory allocation, which completely solves the
problem caused by the limitation of the number of kallsyms.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v7: Fix __must_check macro.
v6: https://lore.kernel.org/lkml/tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com/
    Apply libbpf_ensure_mem()
v5: https://lore.kernel.org/lkml/tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com/
    Release the allocated memory once the load_kallsyms_refresh() upon error
    given it's dynamically allocated.
v4: https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com/
    Make sure most cases we don't need the realloc() path to begin with,
    and check strdup() return value.
v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/
    Do not use structs and judge ksyms__add_symbol function return value.
v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
    Do the usual len/capacity scheme here to amortize the cost of realloc, and
    don't free symbols.
v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
---
 samples/bpf/Makefile                        |  2 +
 tools/testing/selftests/bpf/trace_helpers.c | 58 ++++++++++++++++-----
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4ccf4236031c..0cd45c42af2f 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -175,6 +175,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 TPROGS_CFLAGS += -I$(srctree)/tools/perf
+TPROGS_CFLAGS += -I$(srctree)/tools/lib
 TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
 
 ifdef SYSROOT
@@ -314,6 +315,7 @@ XDP_SAMPLE_CFLAGS += -Wall -O2 \
 
 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
+$(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 -include $(BPF_SAMPLES_PATH)/Makefile.target
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..d62ab3b77153 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,13 +14,44 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
+#include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
-static int sym_cnt;
+static struct ksym *syms;
+static size_t sym_cap;
+static size_t sym_cnt;
+
+static int ksyms__add_symbol(const char *name, unsigned long addr)
+{
+	void *tmp;
+
+	tmp = strdup(name);
+	if (!tmp)
+		return -ENOMEM;
+	syms[sym_cnt].addr = addr;
+	syms[sym_cnt].name = tmp;
+
+	sym_cnt++;
+
+	return 0;
+}
+
+static void ksyms__free(void)
+{
+	unsigned int i;
+
+	if (!syms)
+		return;
+
+	for (i = 0; i < sym_cnt; i++)
+		free(syms[i].name);
+	free(syms);
+	syms = NULL;
+	sym_cnt = 0;
+	sym_cap = 0;
+}
 
 static int ksym_cmp(const void *p1, const void *p2)
 {
@@ -33,9 +64,7 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
-
-	sym_cnt = 0;
+	int ret;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,17 +75,22 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
-		if (i >= MAX_SYMS)
-			return -EFBIG;
 
-		syms[i].addr = (long) addr;
-		syms[i].name = strdup(func);
-		i++;
+		ret = libbpf_ensure_mem((void **) &syms, &sym_cap,
+					sizeof(struct ksym), sym_cnt + 1);
+		if (ret)
+			goto error;
+		ret = ksyms__add_symbol(func, (unsigned long)addr);
+		if (ret)
+			goto error;
 	}
 	fclose(f);
-	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
+
+error:
+	ksyms__free();
+	return ret;
 }
 
 int load_kallsyms(void)
-- 
2.39.3

