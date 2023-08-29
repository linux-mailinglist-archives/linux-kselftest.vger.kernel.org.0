Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536C78C714
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjH2OOy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjH2OOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 10:14:33 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB89C0;
        Tue, 29 Aug 2023 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693318464;
        bh=RtjBYgIviUjS9C1TK2Z1hKj3b3Rw6xRVY+S/S5GMEFY=;
        h=From:To:Cc:Subject:Date;
        b=NuwSsCwMMMbZobEDN0AGkhyRFXRAsMRZfX+nHG2m4or97hY/8feaBW9YwI5hxMk+/
         DAL1sEt9xjnLm2c3j395cgeRZgU8AgtFj9aw0wDt01Luqwb7ZGEhIm0wuRDsaTmv6T
         hN4Wj7Z4hzT96BtelmQCWAPan2KPHe2L7MIMLECY=
Received: from rtoax.lan ([120.245.114.113])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 391AB476; Tue, 29 Aug 2023 22:14:17 +0800
X-QQ-mid: xmsmtpt1693318457tu7l7uh1k
Message-ID: <tencent_254B7015EED7A5D112C45E033DA1822CF107@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6i501fQFuXPhvPs3kVmn04UQM2V47MgrrFSp0IPjzFlzdxopTzs
         TH2niLFsJgjYhviAuTttbIGiPsxn2ooGI6u+JClbCANSNlfxmIgPXn/y/YafF9LpFVfGYC5jrfO8
         6jXpVZbQenhRAm5pOxCzL0VLpb9CisEdw8JUAZwKGBHn3OAFacAQtblEyxbyyg/wdxKugd7b0kVX
         37yjo6018OHyEVjWApG93gSv7SQFppBYN+QHs3dmnZKI4cXeDVPUfKg1wAQHboJPgbbf44UM29UO
         MIZsbwDQeLLBXO2qA8i1iUDehZkh5W1/R06RZlluiP6V0dkojz9Mjq11cXoVBwuHlsgADfzruwG1
         /su/qwYNqmKCgw/iNTpNIk2jrEaUiIEuGzGBaPNFgr5CMvjW/81/1xMKbeaXAj3AxXwYQbnbWwj4
         EJMvrRf9r+BmQh6gYVqqAJGhxZzrAeFhFo2kZW6Gh65NIwLFd2INJruMPpeXqROf/1C0fOZPSxmh
         l84EvNMN9QJZ7QQuvQIYSgxt+IoZHXnUXwGfiHss3PL7M67rUYLyokMRg8wiT9GfqHGkmFHx3bHq
         Nj/VEAKuWeR9kYqryYO8cOT7SJnaHJ0Bdvj0BL1uegI9R+6gg6BYevj7mpYiPOpfJ3sGouu6Wh/F
         OKRK4T2qSvX2y15xKwFzZbBrJcEQ0s1NJZhqlEX6FWWAEAlBeE8qv3HOveISVhPzn58ZvAPN8beh
         P2PxsQ6Kp+7EkumbTfO2V/zK262IWPSWL6xT6TEMK/oRKd7bCc2/JAiDFad0xa9BDkpGsvdWfhHu
         2uteQMYHPRejVEvCUUmopS0Nruck60arfAHfIjOSh0DwVP9f/6Y+GZEB1nQPNWsghozoS7m1twIy
         c5PQfGQV9YuClBAwJC0cPQfqJDxJ4D2yZueNJRnPQHE7+bRrdGcQ5lvRZqficxQ4FapgOoJZUha8
         6gYenToXRAhB4WR6rB+I5euTxJaMzVB6mfmvq5LdA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>,
        Manu Bretelle <chantr4@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Ross Zwisler <zwisler@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH bpf-next v9] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Tue, 29 Aug 2023 22:14:01 +0800
X-OQ-MSGID: <20230829141416.11340-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
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
v9: Add load_kallsyms_local,ksym_search_local,ksym_get_addr_local functions.
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
 .../selftests/bpf/prog_tests/bpf_cookie.c     |   9 +-
 .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  10 +-
 .../bpf/prog_tests/kprobe_multi_test.c        |  15 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  19 ++-
 tools/testing/selftests/bpf/trace_helpers.c   | 142 +++++++++++++-----
 tools/testing/selftests/bpf/trace_helpers.h   |   8 +
 8 files changed, 159 insertions(+), 57 deletions(-)

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
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 1454cebc262b..4ed47dc75669 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -104,8 +104,10 @@ static void kprobe_multi_link_api_subtest(void)
 	LIBBPF_OPTS(bpf_link_create_opts, opts);
 	unsigned long long addrs[8];
 	__u64 cookies[8];
+	struct ksyms *ksyms;
 
-	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_local"))
 		goto cleanup;
 
 	skel = kprobe_multi__open_and_load();
@@ -116,8 +118,8 @@ static void kprobe_multi_link_api_subtest(void)
 	skel->bss->test_cookie = true;
 
 #define GET_ADDR(__sym, __addr) ({				\
-	__addr = ksym_get_addr(__sym);				\
-	if (!ASSERT_NEQ(__addr, 0, "ksym_get_addr " #__sym))	\
+	__addr = ksym_get_addr_local(ksyms, __sym);		\
+	if (!ASSERT_NEQ(__addr, 0, "ksym_get_addr_local " #__sym))	\
 		goto cleanup;					\
 })
 
@@ -171,6 +173,7 @@ static void kprobe_multi_link_api_subtest(void)
 cleanup:
 	close(link1_fd);
 	close(link2_fd);
+	free_kallsyms_local(ksyms);
 	kprobe_multi__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 9d768e083714..154aaa08761f 100644
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
+	ksyms = load_kallsyms_refresh_local(NULL);
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_refresh_local"))
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
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 858e0575f502..a317a6d04458 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -9,6 +9,7 @@
 #define MAX_STACK_RAWTP	100
 
 static int duration = 0;
+static struct ksyms *ksyms;
 
 struct get_stack_trace_t {
 	int pid;
@@ -48,7 +49,7 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 			found = num_stack > 0;
 		} else {
 			for (i = 0; i < num_stack; i++) {
-				ks = ksym_search(raw_data[i]);
+				ks = ksym_search_local(ksyms, raw_data[i]);
 				if (ks && (strcmp(ks->name, nonjit_func) == 0)) {
 					found = true;
 					break;
@@ -65,7 +66,7 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 			good_kern_stack = num_stack > 0;
 		} else {
 			for (i = 0; i < num_stack; i++) {
-				ks = ksym_search(e.kern_stack[i]);
+				ks = ksym_search_local(ksyms, e.kern_stack[i]);
 				if (ks && (strcmp(ks->name, nonjit_func) == 0)) {
 					good_kern_stack = true;
 					break;
@@ -112,8 +113,8 @@ void test_get_stack_raw_tp(void)
 	if (CHECK(!map, "bpf_find_map", "not found\n"))
 		goto close_prog;
 
-	err = load_kallsyms();
-	if (CHECK(err < 0, "load_kallsyms", "err %d errno %d\n", err, errno))
+	ksyms = load_kallsyms_local();
+	if (CHECK(!ksyms, "load_kallsyms_local", "err %d errno %d\n", err, errno))
 		goto close_prog;
 
 	CPU_ZERO(&cpu_set);
@@ -146,4 +147,5 @@ void test_get_stack_raw_tp(void)
 	bpf_link__destroy(link);
 	perf_buffer__free(pb);
 	bpf_object__close(obj);
+	free_kallsyms_local(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 179fe300534f..8683536ce217 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -6,6 +6,8 @@
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
+static struct ksyms *ksyms;
+
 static void kprobe_multi_test_run(struct kprobe_multi *skel, bool test_return)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -89,7 +91,7 @@ static void test_link_api(struct bpf_link_create_opts *opts)
 }
 
 #define GET_ADDR(__sym, __addr) ({					\
-	__addr = ksym_get_addr(__sym);					\
+	__addr = ksym_get_addr_local(ksyms, __sym);			\
 	if (!ASSERT_NEQ(__addr, 0, "kallsyms load failed for " #__sym))	\
 		return;							\
 })
@@ -222,10 +224,10 @@ static void test_attach_api_fails(void)
 	};
 	__u64 cookies[2];
 
-	addrs[0] = ksym_get_addr("bpf_fentry_test1");
-	addrs[1] = ksym_get_addr("bpf_fentry_test2");
+	addrs[0] = ksym_get_addr_local(ksyms, "bpf_fentry_test1");
+	addrs[1] = ksym_get_addr_local(ksyms, "bpf_fentry_test2");
 
-	if (!ASSERT_FALSE(!addrs[0] || !addrs[1], "ksym_get_addr"))
+	if (!ASSERT_FALSE(!addrs[0] || !addrs[1], "ksym_get_addr_local"))
 		goto cleanup;
 
 	skel = kprobe_multi__open_and_load();
@@ -463,7 +465,8 @@ void serial_test_kprobe_multi_bench_attach(void)
 
 void test_kprobe_multi_test(void)
 {
-	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_local"))
 		return;
 
 	if (test__start_subtest("skel_api"))
@@ -480,4 +483,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+
+	free_kallsyms_local(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
index 1fbe7e4ac00a..ee3e28d76a78 100644
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
@@ -79,11 +81,14 @@ static void test_testmod_attach_api_syms(void)
 
 void serial_test_kprobe_multi_testmod_test(void)
 {
-	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+	ksyms = load_kallsyms_refresh_local(ksyms);
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_refresh_local"))
 		return;
 
 	if (test__start_subtest("testmod_attach_api_syms"))
 		test_testmod_attach_api_syms();
 	if (test__start_subtest("testmod_attach_api_addrs"))
 		test_testmod_attach_api_addrs();
+
+	free_kallsyms_local(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..398c4fa5d1dc 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,104 +14,176 @@
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
+struct ksyms *load_kallsyms_refresh_local(struct ksyms *ksyms)
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
+int load_kallsyms_refresh(void)
+{
+	ksyms = load_kallsyms_refresh_local(NULL);
+	return ksyms ? 0 : 1;
+}
+
+struct ksyms *load_kallsyms_local(void)
+{
+	return load_kallsyms_refresh_local(NULL);
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
+	ksyms = load_kallsyms_local();
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
index 876f3e711df6..4441a239316d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -11,6 +11,7 @@ struct ksym {
 	long addr;
 	char *name;
 };
+struct ksyms;
 
 int load_kallsyms(void);
 int load_kallsyms_refresh(void);
@@ -18,6 +19,13 @@ int load_kallsyms_refresh(void);
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
 
+struct ksyms *load_kallsyms_local(void);
+struct ksyms *load_kallsyms_refresh_local(struct ksyms *ksyms);
+void free_kallsyms_local(struct ksyms *ksyms);
+
+struct ksym *ksym_search_local(struct ksyms *ksyms, long key);
+long ksym_get_addr_local(struct ksyms *ksyms, const char *name);
+
 /* open kallsyms and find addresses on the fly, faster than load + search. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
 
-- 
2.41.0

