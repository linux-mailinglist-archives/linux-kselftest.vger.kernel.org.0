Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52324528CF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiEPS2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344789AbiEPS2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35C3F3DDD3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652725687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=KGdQi8TuzBmFRXod035kvuaDB/iI4QyLpnvfOS0c72g=;
        b=MgrjE54s/1rU2Q0Cidf4rRetRFdk9S2gcieYk1j4qfr8aNPojOyfUBnGhLWxXZNnbBBDRY
        77WduZHcDqcJYxINo7bt62EouaNpjnZzqqX0P2rzZnsIkbZHi5fW3raQvabvjZ8+2JYjnl
        F23DTde+68lkDTj/UIaeJ0Mb3pgYa6Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-G2KT6AgpPKGayOWKZwieZg-1; Mon, 16 May 2022 14:28:01 -0400
X-MC-Unique: G2KT6AgpPKGayOWKZwieZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1D83395AFE4;
        Mon, 16 May 2022 18:28:00 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 022005521E2;
        Mon, 16 May 2022 18:27:56 +0000 (UTC)
Date:   Mon, 16 May 2022 20:27:54 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 4/4] bpf_trace: pass array of u64 values in
 kprobe_multi.addrs
Message-ID: <20220516182754.GA30211@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the interface as defined, it is impossible to pass 64-bit kernel
addresses from a 32-bit userspace process in BPF_LINK_TYPE_KPROBE_MULTI,
which severly limits the useability of the interface, change the ABI
to accept an array of u64 values instead of (kernel? user?) longs.
Interestingly, the rest of the libbpf infrastructure uses 64-bit values
for kallsyms addresses already, so this patch also eliminates
the sym_addr cast in tools/lib/bpf/libbpf.c:resolve_kprobe_multi_cb().

Fixes: 0dcac272540613d4 ("bpf: Add multi kprobe link")
Fixes: 5117c26e877352bc ("libbpf: Add bpf_link_create support for multi kprobes")
Fixes: ddc6b04989eb0993 ("libbpf: Add bpf_program__attach_kprobe_multi_opts function")
Fixes: f7a11eeccb111854 ("selftests/bpf: Add kprobe_multi attach test")
Fixes: 9271a0c7ae7a9147 ("selftests/bpf: Add attach test for bpf_program__attach_kprobe_multi_opts")
Fixes: 2c6401c966ae1fbe ("selftests/bpf: Add kprobe_multi bpf_cookie test")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/trace/bpf_trace.c                           | 25 ++++++++++++++++++----
 tools/lib/bpf/bpf.h                                |  2 +-
 tools/lib/bpf/libbpf.c                             |  8 +++----
 tools/lib/bpf/libbpf.h                             |  2 +-
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  2 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  2 +-
 6 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5b0cf54..86a5544 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2414,7 +2414,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	void __user *ucookies;
 	unsigned long *addrs;
 	u32 flags, cnt, size, cookies_size;
-	void __user *uaddrs;
+	u64 __user *uaddrs;
 	u64 *cookies = NULL;
 	void __user *usyms;
 	int err;
@@ -2447,9 +2447,26 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		return -ENOMEM;
 
 	if (uaddrs) {
-		if (copy_from_user(addrs, uaddrs, size)) {
-			err = -EFAULT;
-			goto error;
+		if (sizeof(*addrs) == sizeof(*uaddrs)) {
+			if (copy_from_user(addrs, uaddrs, size)) {
+				err = -EFAULT;
+				goto error;
+			}
+		} else {
+			u32 i;
+			u64 addr;
+
+			for (i = 0; i < cnt; i++) {
+				if (get_user(addr, uaddrs + i)) {
+					err = -EFAULT;
+					goto error;
+				}
+				if (addr > ULONG_MAX) {
+					err = -EINVAL;
+					goto error;
+				}
+				addrs[i] = addr;
+			}
 		}
 	} else {
 		err = kprobe_multi_resolve_syms(usyms, cnt, addrs);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f4b4afb..f677602 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -417,7 +417,7 @@ struct bpf_link_create_opts {
 			__u32 flags;
 			__u32 cnt;
 			const char **syms;
-			const unsigned long *addrs;
+			const __u64 *addrs;
 			const __u64 *cookies;
 		} kprobe_multi;
 	};
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 809fe20..03a14a6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10279,7 +10279,7 @@ static bool glob_match(const char *str, const char *pat)
 
 struct kprobe_multi_resolve {
 	const char *pattern;
-	unsigned long *addrs;
+	__u64 *addrs;
 	size_t cap;
 	size_t cnt;
 };
@@ -10294,12 +10294,12 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
 	if (!glob_match(sym_name, res->pattern))
 		return 0;
 
-	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
+	err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(__u64),
 				res->cnt + 1);
 	if (err)
 		return err;
 
-	res->addrs[res->cnt++] = (unsigned long) sym_addr;
+	res->addrs[res->cnt++] = sym_addr;
 	return 0;
 }
 
@@ -10314,7 +10314,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	};
 	struct bpf_link *link = NULL;
 	char errmsg[STRERR_BUFSIZE];
-	const unsigned long *addrs;
+	const __u64 *addrs;
 	int err, link_fd, prog_fd;
 	const __u64 *cookies;
 	const char **syms;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 05dde85..ec1cb61 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -431,7 +431,7 @@ struct bpf_kprobe_multi_opts {
 	/* array of function symbols to attach */
 	const char **syms;
 	/* array of function addresses to attach */
-	const unsigned long *addrs;
+	const __u64 *addrs;
 	/* array of user-provided values fetchable through bpf_get_attach_cookie */
 	const __u64 *cookies;
 	/* number of elements in syms/addrs/cookies arrays */
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 923a613..5aa482a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -137,7 +137,7 @@ static void kprobe_multi_link_api_subtest(void)
 	cookies[6] = 7;
 	cookies[7] = 8;
 
-	opts.kprobe_multi.addrs = (const unsigned long *) &addrs;
+	opts.kprobe_multi.addrs = (const __u64 *) &addrs;
 	opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
 	opts.kprobe_multi.cookies = (const __u64 *) &cookies;
 	prog_fd = bpf_program__fd(skel->progs.test_kprobe);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index b9876b5..b58e2b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -105,7 +105,7 @@ static void test_link_api_addrs(void)
 	GET_ADDR("bpf_fentry_test7", addrs[6]);
 	GET_ADDR("bpf_fentry_test8", addrs[7]);
 
-	opts.kprobe_multi.addrs = (const unsigned long*) addrs;
+	opts.kprobe_multi.addrs = (const __u64 *) addrs;
 	opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
 	test_link_api(&opts);
 }
-- 
2.1.4

