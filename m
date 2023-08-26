Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A085789786
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Aug 2023 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHZOrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Aug 2023 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjHZOqv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Aug 2023 10:46:51 -0400
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5A2109;
        Sat, 26 Aug 2023 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693061203;
        bh=xnHpiq8AFDGCVYfkHbs/Z9zUdHRRnZb4zEQi/gJNeu4=;
        h=From:To:Cc:Subject:Date;
        b=wM+kV5IFVEp69yQ/gnH5sVUNWhXks5WaMZND3wI0FGgeOCyuxWSOH3zqApaWpkeIg
         gQDC7Hmj7XI8L457pvwtqfIDJlRmqz8KUgnTB01oFOh5yo9ZD08kqqQNOCJ3TeXnDI
         oYkkLwi631tz+3LZSY2aipXS+L4ItesNsKmelEgI=
Received: from rtoax.. ([124.126.138.8])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id BA53F055; Sat, 26 Aug 2023 22:46:37 +0800
X-QQ-mid: xmsmtpt1693061197t71abj81p
Message-ID: <tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneykn3oQkxZ+VCTbCK9O5ulX049OkRcggJ3ZatQrjUU/ndpb1KvS
         rr/VgX7Pge4gFQh+d9ALGwe9mXx0q7myx7HlUj62TulgE65JgaoNAlj6EvcS3+NlMYbtet//wwji
         9Iy+uZDyumCx7goRB/x1DKObRn4v/b7sl7dkiD7GUTUSTv+YPBIJEQblO2g0p4OOv62oy29t+yG9
         H9bklEDiwPP3zOYnHYjF57fDxcNfNxetDJXe9iTeV8FgbGYRGcJjtSiZQLigNO1FC8tq774H0B4J
         3y75ZPDha75qm//A1qwKFhxmEM9/mZqERDnUyn70dUaxN+zemX3KKF6WRTcHL4xXHkFo8nkj6EWi
         tElEnZjZV3YaxRSvUq4eoUPMBRc8BSlplMhlM+KbrKh2ZenA7doz0pkBIAgKFW6F89BTai+zk9x9
         1yPvzQuK22LXfiKowvJFNETlOPoJ7gk+TrCNJrfkHWVZmKrpCjM5NKMK0xINRQnvaYD8k9WN+Qed
         ZFHnqg2cO9M/vnBJ/KhEM4JWDPys1cycM1sdXskBuSYobntN1qX+7pKr1Y8pST84TZfYZ98ovHqk
         VLfAVouHcFEPFdSkth5DqShsDap8QtkIzT9AHf53CjD1I2Uzin7uFYWqVlFgS/F5Zd+M1XSUGpBq
         a2R1AtGtNrLUNVmBzLxnsXjuglQ320lcIIR7+kL1qI+fcct/DMABBjarmbjK4WjWP8XlH2VYQ7nL
         1R13pHr1lHqwE8T8uFZ7Wz/bsIt3RF3cc0WRMbDNY4V9bVVQ8LOumihxap7yNGx6bjmd97EsoLGF
         RaZkajlPfVqf6eX8ORpnhVggcybl/Kt6zHNdw6iUnLwrE/BFU3HgEcxJZoQbo2VEszef9QBKAHG+
         7lj0Q+aJr3HCBV5P/vvhw0DE4QKYl7sRFp9qcUoXdtVZ6yJMVgkwpAkWXvGsQ4VlnuOf+VFXx58d
         TOMlkfxB5BKT2H6Ro5DlIJZPCNchRjSkgKK78oVte/74KGNb5o2g==
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
Subject: [PATCH bpf-next v8] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Sat, 26 Aug 2023 22:46:19 +0800
X-OQ-MSGID: <20230826144635.116335-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
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
problem caused by the limitation of the number of kallsyms.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v8: Resolves inter-thread contention for ksyms global variables.
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
 samples/bpf/offwaketime_user.c                |   7 +-
 samples/bpf/sampleip_user.c                   |   9 +-
 samples/bpf/spintest_user.c                   |   7 +-
 samples/bpf/task_fd_query_user.c              |  13 +-
 samples/bpf/trace_event_user.c                |   7 +-
 .../selftests/bpf/prog_tests/bpf_cookie.c     |   7 +-
 .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
 .../bpf/prog_tests/get_stack_raw_tp.c         |  10 +-
 .../bpf/prog_tests/kprobe_multi_test.c        |  13 +-
 .../prog_tests/kprobe_multi_testmod_test.c    |  13 +-
 tools/testing/selftests/bpf/trace_helpers.c   | 116 ++++++++++++------
 tools/testing/selftests/bpf/trace_helpers.h   |  10 +-
 13 files changed, 154 insertions(+), 71 deletions(-)

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
 
diff --git a/samples/bpf/offwaketime_user.c b/samples/bpf/offwaketime_user.c
index 5557b5393642..53c1a6b4ec44 100644
--- a/samples/bpf/offwaketime_user.c
+++ b/samples/bpf/offwaketime_user.c
@@ -16,6 +16,7 @@
 
 /* counts, stackmap */
 static int map_fd[2];
+struct ksyms *ksyms;
 
 static void print_ksym(__u64 addr)
 {
@@ -23,7 +24,7 @@ static void print_ksym(__u64 addr)
 
 	if (!addr)
 		return;
-	sym = ksym_search(addr);
+	sym = ksym_search(ksyms, addr);
 	if (!sym) {
 		printf("ksym not found. Is kallsyms loaded?\n");
 		return;
@@ -100,7 +101,8 @@ int main(int argc, char **argv)
 	int delay = 1, i = 0;
 	char filename[256];
 
-	if (load_kallsyms()) {
+	ksyms = load_kallsyms();
+	if (!ksyms) {
 		printf("failed to process /proc/kallsyms\n");
 		return 2;
 	}
@@ -149,5 +151,6 @@ int main(int argc, char **argv)
 		bpf_link__destroy(links[i]);
 
 	bpf_object__close(obj);
+	free_kallsyms(ksyms);
 	return 0;
 }
diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
index 9283f47844fb..aec3d557aa6b 100644
--- a/samples/bpf/sampleip_user.c
+++ b/samples/bpf/sampleip_user.c
@@ -25,6 +25,7 @@
 static int map_fd;
 static int nr_cpus;
 static long _text_addr;
+struct ksyms *ksyms;
 
 static void usage(void)
 {
@@ -109,7 +110,7 @@ static void print_ip_map(int fd)
 	qsort(counts, max, sizeof(struct ipcount), count_cmp);
 	for (i = 0; i < max; i++) {
 		if (counts[i].ip > _text_addr) {
-			sym = ksym_search(counts[i].ip);
+			sym = ksym_search(ksyms, counts[i].ip);
 			if (!sym) {
 				printf("ksym not found. Is kallsyms loaded?\n");
 				continue;
@@ -164,13 +165,14 @@ int main(int argc, char **argv)
 	}
 
 	/* initialize kernel symbol translation */
-	if (load_kallsyms()) {
+	ksyms = load_kallsyms();
+	if (!ksyms) {
 		fprintf(stderr, "ERROR: loading /proc/kallsyms\n");
 		return 2;
 	}
 
 	/* used to determine whether the address is kernel space */
-	_text_addr = ksym_get_addr("_text");
+	_text_addr = ksym_get_addr(ksyms, "_text");
 	if (!_text_addr) {
 		fprintf(stderr, "ERROR: no '_text' in /proc/kallsyms\n");
 		return 3;
@@ -230,5 +232,6 @@ int main(int argc, char **argv)
 
 	free(links);
 	bpf_object__close(obj);
+	free_kallsyms(ksyms);
 	return error;
 }
diff --git a/samples/bpf/spintest_user.c b/samples/bpf/spintest_user.c
index 55971edb1088..db6a3c6d5329 100644
--- a/samples/bpf/spintest_user.c
+++ b/samples/bpf/spintest_user.c
@@ -16,8 +16,10 @@ int main(int ac, char **argv)
 	int map_fd, i, j = 0;
 	char filename[256];
 	struct ksym *sym;
+	struct ksyms *ksyms;
 
-	if (load_kallsyms()) {
+	ksyms = load_kallsyms();
+	if (!ksyms) {
 		printf("failed to process /proc/kallsyms\n");
 		return 2;
 	}
@@ -58,7 +60,7 @@ int main(int ac, char **argv)
 		while (bpf_map_get_next_key(map_fd, &key, &next_key) == 0) {
 			bpf_map_lookup_elem(map_fd, &next_key, &value);
 			assert(next_key == value);
-			sym = ksym_search(value);
+			sym = ksym_search(ksyms, value);
 			key = next_key;
 			if (!sym) {
 				printf("ksym not found. Is kallsyms loaded?\n");
@@ -80,5 +82,6 @@ int main(int ac, char **argv)
 		bpf_link__destroy(links[j]);
 
 	bpf_object__close(obj);
+	free_kallsyms(ksyms);
 	return 0;
 }
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index 1e61f2180470..6e7710a4a96f 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -315,8 +315,10 @@ int main(int argc, char **argv)
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	int i = 0, err = -1;
+	struct ksyms *ksyms;
 
-	if (load_kallsyms()) {
+	ksyms = load_kallsyms();
+	if (!ksyms) {
 		printf("failed to process /proc/kallsyms\n");
 		return err;
 	}
@@ -368,22 +370,22 @@ int main(int argc, char **argv)
 					     BPF_FD_TYPE_KRETPROBE,
 					     buf, sizeof(buf)));
 	CHECK_AND_RET(test_nondebug_fs_probe("kprobe", NULL, 0x0,
-					     ksym_get_addr("bpf_check"), false,
+					     ksym_get_addr(ksyms, "bpf_check"), false,
 					     BPF_FD_TYPE_KPROBE,
 					     BPF_FD_TYPE_KRETPROBE,
 					     buf, sizeof(buf)));
 	CHECK_AND_RET(test_nondebug_fs_probe("kprobe", NULL, 0x0,
-					     ksym_get_addr("bpf_check"), false,
+					     ksym_get_addr(ksyms, "bpf_check"), false,
 					     BPF_FD_TYPE_KPROBE,
 					     BPF_FD_TYPE_KRETPROBE,
 					     NULL, 0));
 	CHECK_AND_RET(test_nondebug_fs_probe("kprobe", NULL, 0x0,
-					     ksym_get_addr("bpf_check"), true,
+					     ksym_get_addr(ksyms, "bpf_check"), true,
 					     BPF_FD_TYPE_KPROBE,
 					     BPF_FD_TYPE_KRETPROBE,
 					     buf, sizeof(buf)));
 	CHECK_AND_RET(test_nondebug_fs_probe("kprobe", NULL, 0x0,
-					     ksym_get_addr("bpf_check"), true,
+					     ksym_get_addr(ksyms, "bpf_check"), true,
 					     BPF_FD_TYPE_KPROBE,
 					     BPF_FD_TYPE_KRETPROBE,
 					     0, 0));
@@ -419,5 +421,6 @@ int main(int argc, char **argv)
 		bpf_link__destroy(links[i]);
 
 	bpf_object__close(obj);
+	free_kallsyms(ksyms);
 	return err;
 }
diff --git a/samples/bpf/trace_event_user.c b/samples/bpf/trace_event_user.c
index 9664749bf618..b4822166182f 100644
--- a/samples/bpf/trace_event_user.c
+++ b/samples/bpf/trace_event_user.c
@@ -23,6 +23,7 @@ static int pid;
 static int map_fd[2];
 struct bpf_program *prog;
 static bool sys_read_seen, sys_write_seen;
+struct ksyms *ksyms;
 
 static void print_ksym(__u64 addr)
 {
@@ -30,7 +31,7 @@ static void print_ksym(__u64 addr)
 
 	if (!addr)
 		return;
-	sym = ksym_search(addr);
+	sym = ksym_search(ksyms, addr);
 	if (!sym) {
 		printf("ksym not found. Is kallsyms loaded?\n");
 		return;
@@ -303,7 +304,8 @@ int main(int argc, char **argv)
 	signal(SIGINT, err_exit);
 	signal(SIGTERM, err_exit);
 
-	if (load_kallsyms()) {
+	ksyms = load_kallsyms();
+	if (!ksyms) {
 		printf("failed to process /proc/kallsyms\n");
 		goto cleanup;
 	}
@@ -348,5 +350,6 @@ int main(int argc, char **argv)
 
 cleanup:
 	bpf_object__close(obj);
+	free_kallsyms(ksyms);
 	err_exit(error);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 1454cebc262b..26bf1f33b8d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -104,8 +104,10 @@ static void kprobe_multi_link_api_subtest(void)
 	LIBBPF_OPTS(bpf_link_create_opts, opts);
 	unsigned long long addrs[8];
 	__u64 cookies[8];
+	struct ksyms *ksyms;
 
-	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+	ksyms = load_kallsyms();
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms"))
 		goto cleanup;
 
 	skel = kprobe_multi__open_and_load();
@@ -116,7 +118,7 @@ static void kprobe_multi_link_api_subtest(void)
 	skel->bss->test_cookie = true;
 
 #define GET_ADDR(__sym, __addr) ({				\
-	__addr = ksym_get_addr(__sym);				\
+	__addr = ksym_get_addr(ksyms, __sym);				\
 	if (!ASSERT_NEQ(__addr, 0, "ksym_get_addr " #__sym))	\
 		goto cleanup;					\
 })
@@ -171,6 +173,7 @@ static void kprobe_multi_link_api_subtest(void)
 cleanup:
 	close(link1_fd);
 	close(link2_fd);
+	free_kallsyms(ksyms);
 	kprobe_multi__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 9d768e083714..a134eda17446 100644
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
+	ksyms = load_kallsyms_refresh(NULL);
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_refresh"))
 		goto cleanup;
 
-	kprobe_addr = ksym_get_addr(KPROBE_FUNC);
+	kprobe_addr = ksym_get_addr(ksyms, KPROBE_FUNC);
 	if (test__start_subtest("kprobe_link_info"))
 		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false);
 	if (test__start_subtest("kretprobe_link_info"))
@@ -329,7 +331,7 @@ void test_fill_link_info(void)
 
 	qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cmp_r);
 	for (i = 0; i < KMULTI_CNT; i++)
-		kmulti_addrs[i] = ksym_get_addr(kmulti_syms[i]);
+		kmulti_addrs[i] = ksym_get_addr(ksyms, kmulti_syms[i]);
 	if (test__start_subtest("kprobe_multi_link_info"))
 		test_kprobe_multi_fill_link_info(skel, false, false);
 	if (test__start_subtest("kretprobe_multi_link_info"))
@@ -339,4 +341,5 @@ void test_fill_link_info(void)
 
 cleanup:
 	test_fill_link_info__destroy(skel);
+	free_kallsyms(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 858e0575f502..7a5e7741da14 100644
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
+				ks = ksym_search(ksyms, raw_data[i]);
 				if (ks && (strcmp(ks->name, nonjit_func) == 0)) {
 					found = true;
 					break;
@@ -65,7 +66,7 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 			good_kern_stack = num_stack > 0;
 		} else {
 			for (i = 0; i < num_stack; i++) {
-				ks = ksym_search(e.kern_stack[i]);
+				ks = ksym_search(ksyms, e.kern_stack[i]);
 				if (ks && (strcmp(ks->name, nonjit_func) == 0)) {
 					good_kern_stack = true;
 					break;
@@ -112,8 +113,8 @@ void test_get_stack_raw_tp(void)
 	if (CHECK(!map, "bpf_find_map", "not found\n"))
 		goto close_prog;
 
-	err = load_kallsyms();
-	if (CHECK(err < 0, "load_kallsyms", "err %d errno %d\n", err, errno))
+	ksyms = load_kallsyms();
+	if (CHECK(!ksyms, "load_kallsyms", "err %d errno %d\n", err, errno))
 		goto close_prog;
 
 	CPU_ZERO(&cpu_set);
@@ -146,4 +147,5 @@ void test_get_stack_raw_tp(void)
 	bpf_link__destroy(link);
 	perf_buffer__free(pb);
 	bpf_object__close(obj);
+	free_kallsyms(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 179fe300534f..e902ea50de57 100644
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
+	__addr = ksym_get_addr(ksyms, __sym);					\
 	if (!ASSERT_NEQ(__addr, 0, "kallsyms load failed for " #__sym))	\
 		return;							\
 })
@@ -222,8 +224,8 @@ static void test_attach_api_fails(void)
 	};
 	__u64 cookies[2];
 
-	addrs[0] = ksym_get_addr("bpf_fentry_test1");
-	addrs[1] = ksym_get_addr("bpf_fentry_test2");
+	addrs[0] = ksym_get_addr(ksyms, "bpf_fentry_test1");
+	addrs[1] = ksym_get_addr(ksyms, "bpf_fentry_test2");
 
 	if (!ASSERT_FALSE(!addrs[0] || !addrs[1], "ksym_get_addr"))
 		goto cleanup;
@@ -463,7 +465,8 @@ void serial_test_kprobe_multi_bench_attach(void)
 
 void test_kprobe_multi_test(void)
 {
-	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+	ksyms = load_kallsyms();
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms"))
 		return;
 
 	if (test__start_subtest("skel_api"))
@@ -480,4 +483,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+
+	free_kallsyms(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
index 1fbe7e4ac00a..69de53db63fd 100644
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
@@ -50,11 +52,11 @@ static void test_testmod_attach_api_addrs(void)
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
 	unsigned long long addrs[3];
 
-	addrs[0] = ksym_get_addr("bpf_testmod_fentry_test1");
+	addrs[0] = ksym_get_addr(ksyms, "bpf_testmod_fentry_test1");
 	ASSERT_NEQ(addrs[0], 0, "ksym_get_addr");
-	addrs[1] = ksym_get_addr("bpf_testmod_fentry_test2");
+	addrs[1] = ksym_get_addr(ksyms, "bpf_testmod_fentry_test2");
 	ASSERT_NEQ(addrs[1], 0, "ksym_get_addr");
-	addrs[2] = ksym_get_addr("bpf_testmod_fentry_test3");
+	addrs[2] = ksym_get_addr(ksyms, "bpf_testmod_fentry_test3");
 	ASSERT_NEQ(addrs[2], 0, "ksym_get_addr");
 
 	opts.addrs = (const unsigned long *) addrs;
@@ -79,11 +81,14 @@ static void test_testmod_attach_api_syms(void)
 
 void serial_test_kprobe_multi_testmod_test(void)
 {
-	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
+	ksyms = load_kallsyms_refresh(NULL);
+	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_refresh"))
 		return;
 
 	if (test__start_subtest("testmod_attach_api_syms"))
 		test_testmod_attach_api_syms();
 	if (test__start_subtest("testmod_attach_api_addrs"))
 		test_testmod_attach_api_addrs();
+
+	free_kallsyms(ksyms);
 }
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..048522d2ac6e 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -14,99 +14,143 @@
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
+void free_kallsyms(struct ksyms *ksyms)
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
+	free_kallsyms(ksyms);
 
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
+	free_kallsyms(ksyms);
+	return NULL;
 }
 
-int load_kallsyms(void)
+struct ksyms *load_kallsyms(void)
 {
-	/*
-	 * This is called/used from multiplace places,
-	 * load symbols just once.
-	 */
-	if (sym_cnt)
-		return 0;
-	return load_kallsyms_refresh();
+	return load_kallsyms_refresh(NULL);
 }
 
-struct ksym *ksym_search(long key)
+struct ksym *ksym_search(struct ksyms *ksyms, long key)
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
+long ksym_get_addr(struct ksyms *ksyms, const char *name)
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
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 876f3e711df6..6be64f44dd76 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -11,12 +11,14 @@ struct ksym {
 	long addr;
 	char *name;
 };
+struct ksyms;
 
-int load_kallsyms(void);
-int load_kallsyms_refresh(void);
+struct ksyms *load_kallsyms(void);
+struct ksyms *load_kallsyms_refresh(struct ksyms *ksyms);
+void free_kallsyms(struct ksyms *ksyms);
 
-struct ksym *ksym_search(long key);
-long ksym_get_addr(const char *name);
+struct ksym *ksym_search(struct ksyms *ksyms, long key);
+long ksym_get_addr(struct ksyms *ksyms, const char *name);
 
 /* open kallsyms and find addresses on the fly, faster than load + search. */
 int kallsyms_find(const char *sym, unsigned long long *addr);
-- 
2.41.0

