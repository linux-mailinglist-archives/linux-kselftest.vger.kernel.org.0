Return-Path: <linux-kselftest+bounces-42802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D043DBC0149
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F75018974AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF21F8ACA;
	Tue,  7 Oct 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="O3C7vstI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF934BA3C;
	Tue,  7 Oct 2025 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806893; cv=none; b=JT2nUQUUMPM7G9S0XQvigwLzqEkWoM39MZsq2zbmAFRw8WZkJepSNnlJlE/eDCJUela8N56tpCrKxTgHft7UnwsPHj7bDfPm0fsIpfV2CkSxmzRWttDUcz9OKpTPnN8cBNwCcmAUAB5j6Jai9bijaiAKdsfEk8MguxO2EVseQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806893; c=relaxed/simple;
	bh=vEH+1puoPl8mYeTHPHAu6znRUHW6Zubs6K+kU9p783A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YMdVvwKznUIHtw/g2yczvmxDPn2SWDJEhLVJ3uJv8ZLT8PcPOdnSAl88bqHNKeZqDM1u/+srdUZCPAOVxKjKN2+LNmCZyVjZoprEscNya/bkNIG2PEOGDoYaiblM2A79+bMeT34iCe6DrhBHAI+QsFSENiwFTYxxHtbSYp8aGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=O3C7vstI; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759806878;
	bh=fEz4fk7jBSbmE1HYpn3tjFnZHoLb7r0ZS14ykGQI/28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3C7vstI9XhtEqrbBqoFcxpAhLxfMUDxK8E3sPecyRncOb2QmAUuAETQJOTB2IgJI
	 M7086rcpmD4dFW0H0dbO6315bdsJhAdGkPKAudnxpLfCzLuCfxZGDWxnNjFCWKzgkm
	 N+bHIN+fyOoRhf15T1XEVmFftBhjufMSPMiVWq4A=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 532E0C6; Tue, 07 Oct 2025 11:01:19 +0800
X-QQ-mid: xmsmtpt1759806079tuf0a8ecd
Message-ID: <tencent_0F19C408C167655C0AAA5CBCBE8DC621FA0A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5xbBHGaRejfdFgUeZwVzdRQwECtPESsC3D/9QBKvN13yGOVXHle
	 2nXNVQwEqV75L0X48axpkelV8Ha8ftM/Msyyns+8d/Bg2vfgCWnZZey90J9EuFhZdFMNCUT03d7E
	 iakCZYj/1+pSR25zMIssv8mAp+S14n7O3wQCsmCf/I3SD2lHbg3WZNvBmIvBTs38KEp+QmhlIO5S
	 Jozk0JMhZ4yoxMWQjxhlAqWs4gJIk0beiWXFXl3bdNYv2zfFBweq2m/1i14XZcRvtpqRqc4Jb25+
	 wc+3nbAtIAJI1NrWFukWYGjL/WyjSqw3MWSh2vU8OzEDKhafuR8TJSRUorauGlOosZnbg0mIJjRQ
	 2FhxF7m7sah6YdFc1HDuxa7yKexfPsNdVUEt91TbelcHoOjucL9Q/kxfeGZHSvJtWacaoxGD64wV
	 wtMJA9lmyXSomyfRqr0/k6+F+xngX0+D9mKAyXvLqZd8wNNKy8rBLkTg7iv058y+VGmn5uaLI9y7
	 k/ze3Tm/LaljgIUve+Ii38AFfkIw2FyOh+uqIG7J4/CKC7NKRiRjaMgV6xHl+4CleSp+Hn850O7E
	 I4re1ACAST1Lt+vZxCyOxzLglx0BOmuUlSyPPSnMIiTI9TxT6IJPeTonRRcJOKD4iE2oHaTVU35i
	 NPoDD7a0AKxZXifuzWDRF9v93d1aet62cXKG6zvz4EwSW7Tf8XhuYF1d1kWljXQaczx+jzrjfWQ9
	 F3ADzCEmUvm4toYDMfO5l+uyBt8Pc3R3YzJFItxu8Jw/ICWn9FwR0oGDxXWJQxggnsTcEjZu+wkQ
	 +DNP7PZh0gDafqQdPRi7Rc/zZjEnUd/kYQkU7f1LVksvjAo2i8Y3/k3ubJGRCsR+5I1Mo9QhwciF
	 RLnRLKwqJ1oPDh7+0kafMIKasztgxTxJpFWIqyAjuMMPZAbTIUEnW9YRYYOrusoWdbU8lPigh4gB
	 h+U0gsexfWgxVpy6bXfd8Qq3MXbQz9eNYp8UkZbBPu89yGnvS6k4powLB8F3LAFMzRSjFa0MHca0
	 refIRcVlFOnSpgFubJArC0OcaJEI34qJVcgDp1NH1IpufnvQvj2hr2IK8rK8s=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs
Date: Tue,  7 Oct 2025 11:00:41 +0800
X-OQ-MSGID: <cc36f824ae961824e80ff9a9284483aa1db674d1.1759804822.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759804822.git.rongtao@cestc.cn>
References: <cover.1759804822.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add tests for new kfuncs bpf_strcasestr() and bpf_strncasestr().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .../testing/selftests/bpf/prog_tests/string_kfuncs.c |  2 ++
 .../selftests/bpf/progs/string_kfuncs_failure1.c     | 12 ++++++++++++
 .../selftests/bpf/progs/string_kfuncs_failure2.c     |  2 ++
 .../selftests/bpf/progs/string_kfuncs_success.c      | 10 ++++++++++
 4 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 4d66fad3c8bd..0f3bf594e7a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -20,7 +20,9 @@ static const char * const test_cases[] = {
 	"strcspn_str",
 	"strcspn_reject",
 	"strstr",
+	"strcasestr",
 	"strnstr",
+	"strncasestr",
 };
 
 void run_too_long_tests(void)
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index 99d72c68f76a..826e6b6aff7e 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -45,8 +45,12 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null1(void *ctx) { return
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null2(void *ctx) { return bpf_strcspn("hello", NULL); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null1(void *ctx) { return bpf_strstr(NULL, "hello"); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null2(void *ctx) { return bpf_strstr("hello", NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasestr_null1(void *ctx) { return bpf_strcasestr(NULL, "hello"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasestr_null2(void *ctx) { return bpf_strcasestr("hello", NULL); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return bpf_strnstr(NULL, "hello", 1); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
 
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
@@ -65,8 +69,12 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcspn_user_ptr1(void *ctx) { re
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcspn_user_ptr2(void *ctx) { return bpf_strcspn("hello", user_ptr); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strstr_user_ptr1(void *ctx) { return bpf_strstr(user_ptr, "hello"); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strstr_user_ptr2(void *ctx) { return bpf_strstr("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasestr_user_ptr1(void *ctx) { return bpf_strcasestr(user_ptr, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasestr_user_ptr2(void *ctx) { return bpf_strcasestr("hello", user_ptr); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { return bpf_strnstr(user_ptr, "hello", 1); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
 
 #endif /* __TARGET_ARCH_s390 */
 
@@ -87,7 +95,11 @@ SEC("syscall") __retval(-EFAULT) int test_strcspn_pagefault1(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strcspn_pagefault2(void *ctx) { return bpf_strcspn("hello", invalid_kern_ptr); }
 SEC("syscall") __retval(-EFAULT) int test_strstr_pagefault1(void *ctx) { return bpf_strstr(invalid_kern_ptr, "hello"); }
 SEC("syscall") __retval(-EFAULT) int test_strstr_pagefault2(void *ctx) { return bpf_strstr("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strcasestr_pagefault1(void *ctx) { return bpf_strcasestr(invalid_kern_ptr, "hello"); }
+SEC("syscall") __retval(-EFAULT) int test_strcasestr_pagefault2(void *ctx) { return bpf_strcasestr("hello", invalid_kern_ptr); }
 SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return bpf_strnstr(invalid_kern_ptr, "hello", 1); }
 SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
+SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
+SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index e41cc5601994..05e1da1f250f 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -19,6 +19,8 @@ SEC("syscall") int test_strspn_accept_too_long(void *ctx) { return bpf_strspn("b
 SEC("syscall") int test_strcspn_str_too_long(void *ctx) { return bpf_strcspn(long_str, "b"); }
 SEC("syscall") int test_strcspn_reject_too_long(void *ctx) { return bpf_strcspn("b", long_str); }
 SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str, "hello"); }
+SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
 SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
+SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index 2e3498e37b9c..a8513964516b 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -33,8 +33,11 @@ __test(11) int test_strnlen(void *ctx) { return bpf_strnlen(str, 12); }
 __test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
 __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
 __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
+__test(6) int test_strcasestr_found(void *ctx) { return bpf_strcasestr(str, "woRLD"); }
 __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
+__test(-ENOENT) int test_strcasestr_notfound(void *ctx) { return bpf_strcasestr(str, "hi"); }
 __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
+__test(0) int test_strcasestr_empty(void *ctx) { return bpf_strcasestr(str, ""); }
 __test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", "", 0); }
 __test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "hello", 5); }
 __test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "hello", 6); }
@@ -42,5 +45,12 @@ __test(-ENOENT) int test_strnstr_notfound1(void *ctx) { return bpf_strnstr(str,
 __test(-ENOENT) int test_strnstr_notfound2(void *ctx) { return bpf_strnstr(str, "hello", 4); }
 __test(-ENOENT) int test_strnstr_notfound3(void *ctx) { return bpf_strnstr("", "a", 0); }
 __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
+__test(0) int test_strncasestr_found1(void *ctx) { return bpf_strncasestr("", "", 0); }
+__test(0) int test_strncasestr_found2(void *ctx) { return bpf_strncasestr(str, "heLLO", 5); }
+__test(0) int test_strncasestr_found3(void *ctx) { return bpf_strncasestr(str, "heLLO", 6); }
+__test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncasestr(str, "hi", 10); }
+__test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
+__test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
+__test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
 
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


