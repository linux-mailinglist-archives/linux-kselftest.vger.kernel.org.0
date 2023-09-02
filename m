Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF879050D
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 06:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbjIBEpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 00:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345669AbjIBEpV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 00:45:21 -0400
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE67CC
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Sep 2023 21:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693629915;
        bh=wOe7c+2nZWH3wTrLJU0gRDjYnChL8PPmVBbhj5PcaRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J7ZlPn96PeZX31kIrdi7GTXzU2JHSSLYop6TXGN42ilWDpzPRZKYkYS9yBuKszciI
         1iG3wfWJzx3f+MXgPril3Mq1/inaN9Qd+wSm88z/4wDwM/rzadjFPIAP7t9Vw/vewW
         N+V5APGNaMVe9Lqm0DnXJ2vLsyG1pmiwkFYtmkWk=
Received: from rtoax.lan ([120.245.114.63])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id A4223C8B; Sat, 02 Sep 2023 12:41:02 +0800
X-QQ-mid: xmsmtpt1693629666tp5gz2zde
Message-ID: <tencent_3A470910D50DC0859EB22C2EA7547A5FB109@qq.com>
X-QQ-XMAILINFO: MGSlRwRrdVfI5AYhsHwSylVqpokh9nHWugmwHPM2oF/xI9hgN4K/JEgjY7Tmj3
         xsZbygLVf+iDFmCPTixPAmwknlLl97bd96YfcXAJxIMsiBxbvjVB61UB1/B7Efjtt6Hu+ZTv5JbT
         VOldTexJq+AanIamEmMkzRiaEK7IjYL/Zo8KGmQ60B6Q8asMeUjovJfClfMRoG3Ll670z6sUO7JM
         TYQn+BgYKAVquwWIYj+ygUGCOqRy+hXG+Y0z7NlvFuE2NIzrMfLi6KnlMghh2SIdl7K4z4Zj3ogK
         k3st1ZxlOcfJ4vzgh7GdQPAFx9VvRTEQjhUuIp50snxHkzt9hfN+czdBQWDPDsYNTsfJLW5YEdJF
         8bYRVv9UHNRMf51NHhLvmDeiv7zxWzbomlcnK5pP0ancWWBvfpdOFU4BPeytrWGoTess6g9VCZGq
         ddv6umGoG160jczUyeYGkzBkQQDnr6LA4d+jTGyHSfAXV1ImWwPZ7EDy59cK0ha+YklOVMUnBYZm
         AYO8tSBIpxRpx5ovAZp7xu1gwHKLWI2jSX7VcjipHkN4YqC3vpVb7j+KPti2frzP9lDC6f4E3HZb
         /ILYs0k7JyzQcfLdF+crr7fTW6z48FU6K5hcfsK51E6jnMNCbQ2U9YCcc+p5tUpG3vyUYZy9JsJR
         cpAbz+ojq3cKNZ0lxwOjYhRWuYC35eyDhBmhNwKIH0SGe6i7nt46l+h4V+GaQty6sLskaEyP9pRa
         A1w93TolsmUw6ZWBQCblE8c7sVrdGI6qYmj7GJ0l41PxLuxB22IAeqShzlKezydI6qoS6Fdpk/89
         W+D9gItGF7Z2LqoI+YgDWpaDgYnZv95qA8peRgbNvR5CPkhGWrcyFNfUNebeXkHcEj2pNhGLKaI4
         eX7+TTe8Ky3kM3cmXJoc4PXa/faaiE8CzIgI0L/rhwA44rKGkDXye3/EBvPio/2EjJpqcs43GyWh
         RICizg/BDYwObnqnQXx3mOKyiBD3Un4bHSFaOoPnC9BRQRl4E/cXldTWViR2VF
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Subject: [PATCH bpf-next v10 1/2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Sat,  2 Sep 2023 12:40:18 +0800
X-OQ-MSGID: <20230902044040.137804-2-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902044040.137804-1-rtoax@foxmail.com>
References: <20230902044040.137804-1-rtoax@foxmail.com>
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
problem caused by the limitation of the number of kallsyms. At the same
time, add APIs:

    load_kallsyms_local()
    ksym_search_local()
    ksym_get_addr_local()

There are used to solve the problem of selftests/bpf updating kallsyms
after attach new symbols during testmod testing.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v10: Keep the original load_kallsyms().
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
 .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  24 ++-
 tools/testing/selftests/bpf/trace_helpers.c   | 137 +++++++++++++-----
 tools/testing/selftests/bpf/trace_helpers.h   |  10 +-
 5 files changed, 137 insertions(+), 47 deletions(-)

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
index 9d768e083714..13e618317c8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -302,16 +302,18 @@ void test_fill_link_info(void)
 {
 	struct test_fill_link_info *skel;
 	int i;
+	struct ksyms *ksyms;
 
 	skel = test_fill_link_info__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
 	/* load kallsyms to compare the addr */
-	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
 		goto cleanup;
 
-	kprobe_addr = ksym_get_addr(KPROBE_FUNC);
+	kprobe_addr = ksym_get_addr_local(ksyms, KPROBE_FUNC);
 	if (test__start_subtest("kprobe_link_info"))
 		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false);
 	if (test__start_subtest("kretprobe_link_info"))
@@ -329,7 +331,7 @@ void test_fill_link_info(void)
 
 	qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cmp_r);
 	for (i = 0; i < KMULTI_CNT; i++)
-		kmulti_addrs[i] = ksym_get_addr(kmulti_syms[i]);
+		kmulti_addrs[i] = ksym_get_addr_local(ksyms, kmulti_syms[i]);
 	if (test__start_subtest("kprobe_multi_link_info"))
 		test_kprobe_multi_fill_link_info(skel, false, false);
 	if (test__start_subtest("kretprobe_multi_link_info"))
@@ -339,4 +341,5 @@ void test_fill_link_info(void)
 
 cleanup:
 	test_fill_link_info__destroy(skel);
+	free_kallsyms_local(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
index 1fbe7e4ac00a..532b05ae2da4 100644
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
@@ -79,11 +81,19 @@ static void test_testmod_attach_api_syms(void)
 
 void serial_test_kprobe_multi_testmod_test(void)
 {
-	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
 		return;
 
 	if (test__start_subtest("testmod_attach_api_syms"))
 		test_testmod_attach_api_syms();
+
+	ksyms = load_kallsyms_refresh(ksyms);
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_refresh"))
+		return;
+
 	if (test__start_subtest("testmod_attach_api_addrs"))
 		test_testmod_attach_api_addrs();
+
+	free_kallsyms_local(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..d64c4ef336e1 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,104 +14,171 @@
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
+							 unsigned long addr)
+{
+	void *tmp;
+
+	tmp = strdup(name);
+	if (!tmp)
+		return -ENOMEM;
+	ksyms->syms[ksyms->sym_cnt].addr = addr;
+	ksyms->syms[ksyms->sym_cnt].name = tmp;
+
+	ksyms->sym_cnt++;
+
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
+struct ksyms *load_kallsyms_refresh(struct ksyms *ksyms)
 {
 	FILE *f;
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
+	int ret;
 
-	sym_cnt = 0;
+	/* flush kallsyms, free the previously allocated dynamic memory */
+	free_kallsyms_local(ksyms);
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
-		return -ENOENT;
+		return NULL;
+
+	ksyms = calloc(1, sizeof(struct ksyms));
+	if (!ksyms)
+		return NULL;
 
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
+	free_kallsyms_local(ksyms);
+	return NULL;
+}
+
+struct ksyms *load_kallsyms_local(void)
+{
+	return load_kallsyms_refresh(NULL);
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
 
+	if (!ksyms)
+		return NULL;
+
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
index 876f3e711df6..1449a107240c 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -11,13 +11,19 @@ struct ksym {
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
+
+struct ksyms *load_kallsyms_refresh(struct ksyms *ksyms);
+void free_kallsyms_local(struct ksyms *ksyms);
+
 /* open kallsyms and find addresses on the fly, faster than load + search. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
 
-- 
2.41.0

