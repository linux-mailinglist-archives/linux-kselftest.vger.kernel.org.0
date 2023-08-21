Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF267823D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 08:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjHUGpj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHUGpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 02:45:39 -0400
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19ABAC;
        Sun, 20 Aug 2023 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692600333;
        bh=paBRn6eelvFWTUlP54KQNmNcr2N3P9kR/VQ6xAidyfw=;
        h=From:To:Cc:Subject:Date;
        b=ZRJCfEfF61JikHlYO+SZWxbMSwg0XnFQ7NpiDb0/B0S46wJoj/DBr72pMB+I2Ov1o
         18mSi2pUftX5P1xWAhKNSjL03zx4pP/sgpzEXttK4ptsNLyxcf04jip7CImvmqPo2L
         XUECILS8wpPIbzAab7mAODzvIiAa78Maq3O1brwk=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id B5CA7E83; Mon, 21 Aug 2023 14:45:28 +0800
X-QQ-mid: xmsmtpt1692600328t1kcyelb7
Message-ID: <tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoD+8K/Ve4A6z/kl50vAYdg+04s0OTjfBjVrQSKL41J5MzOfJcF5
         U5sJHiMlEElBzhQvNgs1q2wVyQDR/8CxcwAY1akClh0Go83WBI+fqrjzG7x9h6m0LoIMrQYUuuf0
         uIilB21GWvlFlTWlaCSg7K7CMJlwDCkHb1KeXiI2hxnJNQWPDV8p/KgFDgHG8tagEG/a/CF7ZXMS
         6t5wYgy4WWpexsP/bx8rJC2FximvEe4/Z+tF9za8+07CFTU0U1n6UL2xFLzGUXAA57lbT2Qj2rDn
         PJQzxsfx8eEulb2Slc1NcoBL1UQ7kDKBs4tec53V1kevu4nbjwipkb3WKPm1lmAcbWuYtcthL3op
         S7BtBTAanH35F+Hnda5wzordEEKavLAC525QtEAKzlShI0xbZXlz0CPFaSSBApAIy98lnNVTa6A5
         Qcc7dInBzWUMW/qxw2hUoh9xQPaUlOBFFS76QWvpUIQheBtbjO0c27/JXbNQ2FS2PScJMKnySrbg
         HRnUB6jLuiKWaHlHRNWrzJjockHG2DB50d0owX9JA21tjEvxJ1KaZQw8XJ2MCk/DWaxXlg47snQP
         Y4M01MmEFk2yDhYb7dKF8xkk10p13b804UmoWJkoVQ4RBBNZXVbbirXdhyDVEA7ziAfEibeJIlIM
         zd/UE7MWFfKg9T2sT7ASbHNnx9Wr9zD7DiFy2aEja68ek9FTSFdEe9oQC4gR8ud1VtuiA6qlblIR
         0i5pJFyQ5qjok2ux7k1wpgLzebJI8VvjFxILYt7IcGIcmD/gk+yDNqhQ7gmIdsF7KXO1ue52zasU
         VMjciDi+H3RT2jGnGtsyJfjzpZ7+JabWYN/BW7cOYB3mAwVFsRqngLFhFoZwmsDsQTA1tq1xxQOa
         ZJoik8wihI16eEPQrPrdyL9D6s5PRQX15yXHmP5kkf3c+CCSIZjAoi/KnzDgIlwhFmQdNGEcy8tz
         Bg7i6l9byUYJFqJ1Ik+mm6Zyn9ot6BEp82KjOY6baFdrRskQ3kZW95Yo3ylYg2av3yOGhBjjqCao
         LyMDQt0w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii@kernel.org, daniel@iogearbox.net, sdf@google.com,
        yonghong.song@linux.dev
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v6] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Mon, 21 Aug 2023 14:45:20 +0800
X-OQ-MSGID: <20230821064520.156321-1-rtoax@foxmail.com>
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
v6: Apply libbpf_ensure_mem()
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
 samples/bpf/Makefile                        |  1 +
 tools/testing/selftests/bpf/trace_helpers.c | 59 +++++++++++++++++----
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 595b98d825ce..a49d0f759f5a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -199,6 +199,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 TPROGS_CFLAGS += -I$(srctree)/tools/perf
+TPROGS_CFLAGS += -I$(srctree)/tools/lib
 TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
 
 ifdef SYSROOT
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..316a7874a12b 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,14 +14,48 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
+#ifndef __must_check
+#define __must_check
+#endif
+#include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
+static struct ksym *syms;
+static size_t sym_cap;
 static int sym_cnt;
 
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
+
 static int ksym_cmp(const void *p1, const void *p2)
 {
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
@@ -33,9 +67,7 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
-
-	sym_cnt = 0;
+	int ret;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,17 +78,22 @@ int load_kallsyms_refresh(void)
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

