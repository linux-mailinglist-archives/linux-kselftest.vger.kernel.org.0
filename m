Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A886796EBB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 04:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbjIGCAM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbjIGCAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 22:00:10 -0400
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650B122
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 19:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1694052002;
        bh=bm2P1FNegU3YBIrX+oE7s1cjZAwEmrmXkwm5a3BIV1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VgEhUeH6xRRl7hXLwJDeCtwzJkpKeaeXhVIzmPH0tBYUfeQtn2CPhxWtzCWXsXgkw
         mcpLFnb6iIbxId6IgnqD14qgo7rdMVStsXCHsUxX5saU3KkxtN5xWgf2L6AImfM731
         LBbwd5XQFK8Sy0uM3yzeUwMKOwsyVNdJTDO+aKlA=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id EEB27808; Thu, 07 Sep 2023 09:59:43 +0800
X-QQ-mid: xmsmtpt1694051988t51aykohw
Message-ID: <tencent_C9BDA68F9221F21BE4081566A55D66A9700A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieF7MQkCc+tFD3oephBoEAAucHliscRtxGTP0lGYupGaYPcpKxwP
         xPMSvXrbmeWUVE1m/8dN5rovqorIqeqFmJCklddwKmN5v2fdKd96VIp+2u4OBnbo8T71OH+kKnWe
         q76agA1zFWEfpaUaGVz/laiamst8wd/MJCaKeboPi32pbFkLZIdZ76zqf0/uute08OPNXTAiH6oO
         MP1wMn56I5DfCwWCZhDGO6vsTARvKEhggiZvjDXWtqJf3Xwp96aEANpLFP25q6QBicyahMI7wJmT
         3PPr2CK0rohhQZiFxRnDyqRNyvf75qXnaykxcka+B7BsApu725O0PLSRmdpqF3uhW32LuCPJ3v2P
         BfBWzfRp18yQmd0+2sjWbn00SN1ki90wDgPgXf4FEtfgw8yVx9/2GDwOr00KPORThYDOPUYe/YeY
         gBLPOxfsuR8Rigb0YkGBy8iVxJBUoxnDOpqxH2VVM40rlTEeDDj3qO3l1e816WPX1xgjDN9dHe+a
         gX3L/C5d6ItnVq3aUiNCL3AhuTTEUzEmZyOi+/qgSmg6i9p5WCK7FogS3mZTLKAhgdBCOopi+9HW
         UM0bmqDTEAD2xxUuHq6tMb4brWPEOd7h3Lyf8Uyk8oXJ2ahr5S8jtzcYoS683qKRnovlqlkbc29X
         C2NrHNSLQGbVvjya26LFEsQ68mEYy1ATBz/B14C2ue25SXNvHu6l+r8zyz+K7/cYc/qiH2EuNL9S
         pMbnbb3VICnZ3BIv3fdZzqcCHAbzm7PR4OAyeYzIjtTFGz5/prh85oxMoV02P+FIGR5ba86VnimP
         ZnJtbK9ZvBrybafXzq/aiXrZsRTD+2mOWXR4fhP+4kYBD7OUhF1jUqUPSgwd7BCbv9+CzITO7/Uy
         74hDgHusfa7cknoXijt37PCjLZ5iUMUgVbZQ3Vq4b4ws0cWlFHqip027QUK4f/+RBPsN/BaOpF4q
         WClXu+I1iwDZYbSUyPbIeKBFV/cg6/5oct8As7R85FzFCDJHmhwmmrVkTQV5csfc8/eOtHlsA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net
Cc:     Rong Tao <rongtao@cestc.cn>, Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH bpf-next v12 1/2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Thu,  7 Sep 2023 09:59:13 +0800
X-OQ-MSGID: <16ad98151ad5690d0d47c6d59dc77b97571cba2d.1694051654.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694051654.git.rongtao@cestc.cn>
References: <cover.1694051654.git.rongtao@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
problem caused by the limitation of the number of kallsyms. At the same
time, add APIs:

    load_kallsyms_local()
    ksym_search_local()
    ksym_get_addr_local()
    free_kallsyms_local()

There are used to solve the problem of selftests/bpf updating kallsyms
after attach new symbols during testmod testing.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v12: Remove ksyms argument from load_kallsyms_local()
v11: https://lore.kernel.org/lkml/tencent_F9CAE827E2BA8193D06796FBE58ECAD16B06@qq.com/
     Remove useless load_kallsyms_refresh() and modify code some format
v10: https://lore.kernel.org/lkml/tencent_0A73B402B1D440480838ABF7124CE5EA5505@qq.com/
    Keep the original load_kallsyms().
v9: https://lore.kernel.org/lkml/tencent_254B7015EED7A5D112C45E033DA1822CF107@qq.com/
    Add load_kallsyms_local,ksym_search_local,ksym_get_addr_local functions.
v8: https://lore.kernel.org/lkml/tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com/
    Resolves inter-thread contention for ksyms global variables.
v7: https://lore.kernel.org/lkml/tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com/
    Fix __must_check macro.
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
 samples/bpf/Makefile                          |   4 +
 .../selftests/bpf/prog_tests/fill_link_info.c |   2 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  20 ++-
 tools/testing/selftests/bpf/trace_helpers.c   | 130 +++++++++++++-----
 tools/testing/selftests/bpf/trace_helpers.h   |   8 +-
 5 files changed, 118 insertions(+), 46 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4ccf4236031c..6c707ebcebb9 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -175,6 +175,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
 TPROGS_CFLAGS += -I$(srctree)/tools/include
 TPROGS_CFLAGS += -I$(srctree)/tools/perf
+TPROGS_CFLAGS += -I$(srctree)/tools/lib
 TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
 
 ifdef SYSROOT
@@ -314,6 +315,9 @@ XDP_SAMPLE_CFLAGS += -Wall -O2 \
 
 $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
+# Override includes for trace_helpers.o because __must_check won't be defined
+# in our include path.
+$(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 -include $(BPF_SAMPLES_PATH)/Makefile.target
 
diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 9d768e083714..97142a4db374 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -308,7 +308,7 @@ void test_fill_link_info(void)
 		return;
 
 	/* load kallsyms to compare the addr */
-	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
 		goto cleanup;
 
 	kprobe_addr = ksym_get_addr(KPROBE_FUNC);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
index 1fbe7e4ac00a..9d03528f05db 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
@@ -4,6 +4,8 @@
 #include "trace_helpers.h"
 #include "bpf/libbpf_internal.h"
 
+static struct ksyms *ksyms;
+
 static void kprobe_multi_testmod_check(struct kprobe_multi *skel)
 {
 	ASSERT_EQ(skel->bss->kprobe_testmod_test1_result, 1, "kprobe_test1_result");
@@ -50,12 +52,12 @@ static void test_testmod_attach_api_addrs(void)
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
 	unsigned long long addrs[3];
 
-	addrs[0] = ksym_get_addr("bpf_testmod_fentry_test1");
-	ASSERT_NEQ(addrs[0], 0, "ksym_get_addr");
-	addrs[1] = ksym_get_addr("bpf_testmod_fentry_test2");
-	ASSERT_NEQ(addrs[1], 0, "ksym_get_addr");
-	addrs[2] = ksym_get_addr("bpf_testmod_fentry_test3");
-	ASSERT_NEQ(addrs[2], 0, "ksym_get_addr");
+	addrs[0] = ksym_get_addr_local(ksyms, "bpf_testmod_fentry_test1");
+	ASSERT_NEQ(addrs[0], 0, "ksym_get_addr_local");
+	addrs[1] = ksym_get_addr_local(ksyms, "bpf_testmod_fentry_test2");
+	ASSERT_NEQ(addrs[1], 0, "ksym_get_addr_local");
+	addrs[2] = ksym_get_addr_local(ksyms, "bpf_testmod_fentry_test3");
+	ASSERT_NEQ(addrs[2], 0, "ksym_get_addr_local");
 
 	opts.addrs = (const unsigned long *) addrs;
 	opts.cnt = ARRAY_SIZE(addrs);
@@ -79,11 +81,15 @@ static void test_testmod_attach_api_syms(void)
 
 void serial_test_kprobe_multi_testmod_test(void)
 {
-	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
 		return;
 
 	if (test__start_subtest("testmod_attach_api_syms"))
 		test_testmod_attach_api_syms();
+
 	if (test__start_subtest("testmod_attach_api_addrs"))
 		test_testmod_attach_api_addrs();
+
+	free_kallsyms_local(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..dc4efaf538ae 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,104 +14,162 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
+#include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
-static int sym_cnt;
+struct ksyms {
+	struct ksym *syms;
+	size_t sym_cap;
+	size_t sym_cnt;
+};
+
+static struct ksyms *ksyms;
+
+static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
+			     unsigned long addr)
+{
+	void *tmp;
+
+	tmp = strdup(name);
+	if (!tmp)
+		return -ENOMEM;
+	ksyms->syms[ksyms->sym_cnt].addr = addr;
+	ksyms->syms[ksyms->sym_cnt].name = tmp;
+	ksyms->sym_cnt++;
+	return 0;
+}
+
+void free_kallsyms_local(struct ksyms *ksyms)
+{
+	unsigned int i;
+
+	if (!ksyms)
+		return;
+
+	if (!ksyms->syms) {
+		free(ksyms);
+		return;
+	}
+
+	for (i = 0; i < ksyms->sym_cnt; i++)
+		free(ksyms->syms[i].name);
+	free(ksyms->syms);
+	free(ksyms);
+}
 
 static int ksym_cmp(const void *p1, const void *p2)
 {
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
 }
 
-int load_kallsyms_refresh(void)
+struct ksyms *load_kallsyms_local(void)
 {
 	FILE *f;
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
-
-	sym_cnt = 0;
+	int ret;
+	struct ksyms *ksyms;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
-		return -ENOENT;
+		return NULL;
+
+	ksyms = calloc(1, sizeof(struct ksyms));
+	if (!ksyms) {
+		fclose(f);
+		return NULL;
+	}
 
 	while (fgets(buf, sizeof(buf), f)) {
 		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) != 3)
 			break;
 		if (!addr)
 			continue;
-		if (i >= MAX_SYMS)
-			return -EFBIG;
 
-		syms[i].addr = (long) addr;
-		syms[i].name = strdup(func);
-		i++;
+		ret = libbpf_ensure_mem((void **) &ksyms->syms, &ksyms->sym_cap,
+					sizeof(struct ksym), ksyms->sym_cnt + 1);
+		if (ret)
+			goto error;
+		ret = ksyms__add_symbol(ksyms, func, (unsigned long)addr);
+		if (ret)
+			goto error;
 	}
 	fclose(f);
-	sym_cnt = i;
-	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
-	return 0;
+	qsort(ksyms->syms, ksyms->sym_cnt, sizeof(struct ksym), ksym_cmp);
+	return ksyms;
+
+error:
+	fclose(f);
+	free_kallsyms_local(ksyms);
+	return NULL;
 }
 
 int load_kallsyms(void)
 {
-	/*
-	 * This is called/used from multiplace places,
-	 * load symbols just once.
-	 */
-	if (sym_cnt)
-		return 0;
-	return load_kallsyms_refresh();
+	if (!ksyms)
+		ksyms = load_kallsyms_local();
+	return ksyms ? 0 : 1;
 }
 
-struct ksym *ksym_search(long key)
+struct ksym *ksym_search_local(struct ksyms *ksyms, long key)
 {
-	int start = 0, end = sym_cnt;
+	int start = 0, end = ksyms->sym_cnt;
 	int result;
 
 	/* kallsyms not loaded. return NULL */
-	if (sym_cnt <= 0)
+	if (ksyms->sym_cnt <= 0)
 		return NULL;
 
 	while (start < end) {
 		size_t mid = start + (end - start) / 2;
 
-		result = key - syms[mid].addr;
+		result = key - ksyms->syms[mid].addr;
 		if (result < 0)
 			end = mid;
 		else if (result > 0)
 			start = mid + 1;
 		else
-			return &syms[mid];
+			return &ksyms->syms[mid];
 	}
 
-	if (start >= 1 && syms[start - 1].addr < key &&
-	    key < syms[start].addr)
+	if (start >= 1 && ksyms->syms[start - 1].addr < key &&
+	    key < ksyms->syms[start].addr)
 		/* valid ksym */
-		return &syms[start - 1];
+		return &ksyms->syms[start - 1];
 
 	/* out of range. return _stext */
-	return &syms[0];
+	return &ksyms->syms[0];
 }
 
-long ksym_get_addr(const char *name)
+struct ksym *ksym_search(long key)
+{
+	if (!ksyms)
+		return NULL;
+	return ksym_search_local(ksyms, key);
+}
+
+long ksym_get_addr_local(struct ksyms *ksyms, const char *name)
 {
 	int i;
 
-	for (i = 0; i < sym_cnt; i++) {
-		if (strcmp(syms[i].name, name) == 0)
-			return syms[i].addr;
+	for (i = 0; i < ksyms->sym_cnt; i++) {
+		if (strcmp(ksyms->syms[i].name, name) == 0)
+			return ksyms->syms[i].addr;
 	}
 
 	return 0;
 }
 
+long ksym_get_addr(const char *name)
+{
+	if (!ksyms)
+		return 0;
+	return ksym_get_addr_local(ksyms, name);
+}
+
 /* open kallsyms and read symbol addresses on the fly. Without caching all symbols,
  * this is faster than load + find.
  */
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 876f3e711df6..04fd1da7079d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -11,13 +11,17 @@ struct ksym {
 	long addr;
 	char *name;
 };
+struct ksyms;
 
 int load_kallsyms(void);
-int load_kallsyms_refresh(void);
-
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
 
+struct ksyms *load_kallsyms_local(void);
+struct ksym *ksym_search_local(struct ksyms *ksyms, long key);
+long ksym_get_addr_local(struct ksyms *ksyms, const char *name);
+void free_kallsyms_local(struct ksyms *ksyms);
+
 /* open kallsyms and find addresses on the fly, faster than load + search. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
 
-- 
2.41.0

