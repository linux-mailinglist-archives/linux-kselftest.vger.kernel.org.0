Return-Path: <linux-kselftest+bounces-40525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E1B3F7B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81493A8530
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDC25A328;
	Tue,  2 Sep 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bfLPC0DQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DA32F76D;
	Tue,  2 Sep 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800471; cv=none; b=gTw4kX01QmX7BgB1WM2v5t4KlKm45T3lPQyiPZ6QiBOXnvPzGTStmyAfxrwMqfaM4DrkJZ6FoaMMfLGlM3t9JfBseiqMVsxcn86Y/yzCOepKBOY5B4zenqnklP2FvjVQG7RIMcaCL0EQDEi0oqTOPjLhFjyjBo7sa7uflNby5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800471; c=relaxed/simple;
	bh=Ohhov6v/OLsvpbXkKsZD5ewTCOATp1DHaDs4YVVvz0I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S2+ll4NwC1B0OX3bb1pIg2zHTQfsTkaMGCpbbXLttleY3yVSJxDlNQrpYLKShX58a/USB9AiM0h/Y7xJfRgoJplQGhBkmmWKAL8IbnB02zpaLb4mnGVYP23PxZ8R+Oto99FfDxx75mSGuKm76GbF8UVzQAKhqhOP0gk9zJ+Ucww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bfLPC0DQ; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756800164;
	bh=DHv/3pCqg7IfUg+7m4SMm6A8GvVbbb7UAh5j6MLnr9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfLPC0DQA3oILeUvZF5RZU3H2EGU2Isj8O7zZ7aTcApzkuhunPnxAF8pfqkP1Cs6P
	 z8jn5XaP2VpBSiNEziXsH+R8E3Lzj/7n7EPmaX5Xf7cpbVtUr3DwmvypMGte4UCALH
	 AG7syDJQM8eQPyUgIsxasPrBJkq4TPBAtZ4WS9a8=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id E18998A0; Tue, 02 Sep 2025 15:56:24 +0800
X-QQ-mid: xmsmtpt1756799784ty09pciml
Message-ID: <tencent_00107416F7259ACAC62BF8681F22B5C19D06@qq.com>
X-QQ-XMAILINFO: MyHh0PQai9FpC612lp1m7WJ7ZM8lXFcyDpB3lCONa2W3q0mA1qpSV8xEfCprzY
	 g0kOu4k3xm6PY/AsFHepnxkOQzYTXTtMQzHdg12YEnhmyHtUzouI7QgTQMQvkO9SWL7uNei0GXD7
	 0e2AL5qfPLtmMCREcP3/ZhSmGRT/SlmbH5n0pkt72it1aAAoQAZI9HargHFBPdyUzubzEUTtpVyZ
	 uVtIJZ/AD9Ps9kvy6TArMzBNAr5FSnD/zSBrOrQNzFNbDnt8wqopt184TcnPYEy6RuXLV1eKhpUc
	 ZkBaH2GeYeivqOHQU5sj5VhuLPr6Bg4k8OsK1vzAfOFX15j35SwbouA/iDConpXP9Kfxv7XPHZZJ
	 sh3Gq4xo2E3gqMnTh6jK2WUkFcLkMtKFXnWPsN5XhGqrbx9ESddJGplWKGtZtcDs5AX48MEjzQps
	 RwWka2tunNcjQFqPVFYtsHxX0xZmdFTlp58wdLm14yxOhTen+DTuOORj12OxSKY02KYyYKSi8P6q
	 ayWxdHcXS0XWVsfXw6Qz0cEQAfu/Z9zvYEJDSkMnsZVnVRwMvazzzOwAsCJuPRt4IUg5ev7BbT+G
	 H/Va/LFe/W3Qz2W5FvebgBosQ5DFYHq+g26r8XaIrvtN9dxIBfZ9i2vuLTRZvrfM5xm9pem7slBL
	 LBGH8yi/Q2gvZ3RfWMzJeyV1VEF4PO5lrh5iyo5cCK+Rvix4nVbnCepqp9EfBLLz0amKZZtMj/he
	 ivhLEY9aN7+jeDAQzN0210a6uC64/z1uZnLMAS7LyYJBx9G4urI+zrMFNw+COyWHgob0dA4zjjTh
	 S1qPHiGW4V2LxYtFTjkf3PNu/qXNhzjdJrcQH7r9XJFCBM9Z3OWqbAN9NhptYOrgoPSJY6kypUHm
	 Uxt85IjP3sxjttlPBEAxdgL4qjMar90Gm9bRFa7vdXESHFd13jSgaOU6T39Y1tRXHsOPReTxW35a
	 sCi8lPsu7R4jtwFaPKXo4CI6tfI5D533X/CnNpsMDKHg0vBMqb3dGeHhX0UyXynDG1JEU8Y/jEV1
	 9BjRUF2OWpNYmf3pNL3rPA1yZgquNJgK0iXBWhzy292nJhm5X85YOXYB9O2t1czy9T/ITc4JZoxI
	 5qD2zakf2ybJ9kVIE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
Date: Tue,  2 Sep 2025 15:55:50 +0800
X-OQ-MSGID: <1ae45b38862a4afcc3b8c1bb50476258b76747a9.1756798860.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756798860.git.rtoax@foxmail.com>
References: <cover.1756798860.git.rtoax@foxmail.com>
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
 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
 3 files changed, 12 insertions(+)

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


