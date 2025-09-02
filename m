Return-Path: <linux-kselftest+bounces-40541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8995B3FA72
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9C516DFCC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3298F2EAB85;
	Tue,  2 Sep 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hU7bABSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40542EAB8E;
	Tue,  2 Sep 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805503; cv=none; b=E45AwNv8huZTQrxUNzN+mdz6Nec57E+z/H1o3o1ufYc2FufdcpqF2HtL73hYoKwxPWIRNHLe7LIR5TEHxAJufdDYxFUGapUGzFZTd+BisJyRj0jGP2Rs8keTkEqiPRy91uIxWz7AWwxFGBXmHwrFJjNg+YE5TUcBq9APYoK2sMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805503; c=relaxed/simple;
	bh=GOf9LZLLQ2q5Q93T28kTqYJJclpPeEMzOpGWjHU5iZQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ibMdY6esRSK8iWvrkhiiPW5CS+8WnsUfg0Emaqk0dVriOVdpjoVyaWueZqNMQ4CiR0jgNCPd/Zu0hp/meXWZFNJvhOJTXLU33t6v3tRhucmieA7Ot91zOxVMlx8hnE4H431V+Al7KuKqmP2H5DavajNavBaLaS2+YxF5jMnCoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hU7bABSc; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756805191;
	bh=eui+lHKYd2DznXFc/Y0MXUOvULuqsgiVsJKZMCgi9rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hU7bABSc7+/QQ2rxSU97xEtrMWnbQcLZVJREPHqupChIGW+LLF1mtEHJflAQbrQYk
	 y9LNNrBmkQZQeB1hl1nMlWVWHqfjhbReNguozH4jrKuuGw+YbZTWSD54kymXbo/Zpj
	 uYh4uG7G+GyGufoHSeKcyac4X6UllnjEGbroQJUE=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 50C8FE0E; Tue, 02 Sep 2025 17:20:12 +0800
X-QQ-mid: xmsmtpt1756804812t4vpc5sbh
Message-ID: <tencent_E5658E4AE56BCC283822998183906BD6DB06@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8kVCGz9LrTL59vWm0yUYAFrQtG9BRj2++Im/IqWvt2piIh44ZoD
	 DEJJ4hbWkaxUNVTWDqEkcW60kLoE5aoCeGpKFmHNSf5EldlmpHPPX8HfT+B08P3chhjyvfVfYwaw
	 WSWS/mWzo2e3QHygp91eOtz75dLB3draJ2Xrg977f1k5UeHnPz7qiP286gHnS96j03cX7fCOeaKp
	 KgR1XofmmJNImu2E8pw8FwVbkEh/A4DX0w/4c8oqXz+FkeQLEnPicTfTPuzgmbqm4wL/x8OSOnc0
	 xP1kSBXCZh/NN7RVQ/6L+ipCuBxoOt1xss98dRppATp8LFrhgT+XFgyWsqw+Tj1YAA6mu8UhHkV+
	 Q+pcRCNnOaAt/GmKpDQ0q2wXOQMUYKZpBFI5xKN4I79Zj6iQtwL6a4Oar4lNsxUAlQDkNaMIak5o
	 ROxZW7r2kAIIJynRQa95nytB7IebrwlKFGpSJKqpV4LkYqw06lJVNw40iMy+2xdVH8qbFQQgcun8
	 J1fHxhpDPTjJHUCDh8ye4+liC/nidEiKgAtTE9kvHzQ9f4tzx1S9Wc9rUC4uu+yJ2tKvR4n+rgwz
	 Ahk84mfka+Vv5gkSpfcFb6JcP+XoWyC4o4ASIXPlvEV+V8mmj9hIQYs1uYtwm9WFcWvC8MdyYqvj
	 bnC+a+8rULXSTG+E0cNrD/I+qT0NEUcnLbRMOV//PO2gaJNKGY8cAACoBDDV6BDFLHLSzMooLrcQ
	 zlw+o4RcVlGkPirQtXAz9Yvjj4jh4j4pTJYauUpO8ifwRpZx7aaVTXEnOzCeEo4ax+Es1HQxvfMU
	 TssX2llKMcg/W+KcNF19leSblQ0Ax6QmvxUJgFTkr3Oz1K0wjhRw2v4b0UJYM0Qu1CZH5Rm/cIHG
	 DQaXmqcttcjLeorCZSuFB8ux4NXhAId7LtpXW0/W5X+clPGAGcICDouweqmaAryIpdkhKW3ZWAmF
	 gnPyCgzroG4uiOAY+SE9XZ4e6QPbz20SZ97z7kHpdBafYol+NUEOP0cHvMePJbFIBEa7R2zQY4W5
	 qlE3X2Z0iurEkHubDYzD40+3DlVCGQyIcnY0XURy5fVdFGAHAj
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	vmalik@redhat.com
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
Date: Tue,  2 Sep 2025 17:19:43 +0800
X-OQ-MSGID: <45966bb3bd7ef70220ef40894f61740977801422.1756804522.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756804522.git.rtoax@foxmail.com>
References: <cover.1756804522.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add testsuites for kfunc bpf_strcasecmp.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c     | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
 4 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 35af8044d059..4d66fad3c8bd 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -8,6 +8,7 @@
 
 static const char * const test_cases[] = {
 	"strcmp",
+	"strcasecmp",
 	"strchr",
 	"strchrnul",
 	"strnchr",
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index 53af438bd998..99d72c68f76a 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -31,6 +31,8 @@ char *invalid_kern_ptr = (char *)-1;
 /* Passing NULL to string kfuncs (treated as a userspace ptr) */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
@@ -49,6 +51,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
@@ -69,6 +73,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { re
 /* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
 SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
 SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
+SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
 SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 89fb4669b0e9..e41cc5601994 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -7,6 +7,7 @@
 char long_str[XATTR_SIZE_MAX + 1];
 
 SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
+SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
 SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
 SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
 SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index 46697f381878..67830456637b 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -12,6 +12,11 @@ char str[] = "hello world";
 /* Functional tests */
 __test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
 __test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
+__test(0) int test_strcasecmp_eq1(void *ctx) { return bpf_strcasecmp(str, "hello world"); }
+__test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO WORLD"); }
+__test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
+__test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
+__test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
 __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
 __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
 __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
-- 
2.51.0


