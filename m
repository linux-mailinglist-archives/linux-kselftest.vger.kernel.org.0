Return-Path: <linux-kselftest+bounces-42913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0248BC71BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 03:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB95A189DD4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 01:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A59156677;
	Thu,  9 Oct 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="V9l1/KRT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB271531C1;
	Thu,  9 Oct 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973365; cv=none; b=RGi4XEjklnmenDm5CJyYmMvjNJZpE8i5LcBEKtgYbCFJAO5dW1inOKaqdcAvKQmVdI+NFVjlAJOvzhw9yw88e3NfQvHVaeUbY9EZhgTTGmCUIiaaC+fJV5kisCEF1/24hVjxqJ7pn40qGSuHQXNl6NV1OOHdG6+tFhFk5C7FY3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973365; c=relaxed/simple;
	bh=vEH+1puoPl8mYeTHPHAu6znRUHW6Zubs6K+kU9p783A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IHBeLoAwjK7k4alT7wknjFon0zJJRv+1BvvcNWaPsnqnUFY7Yl/sHvaRfGRH677rKYiev4F1SQtCNU7OlwzR1ZNNkWRcN/EQC+r9y9Fww0XuCHi2J2BYCukYK9J1J/K1w4DV4eNS6Her4uTrevDDBup/I8TRmdW4V/RZQkJny+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=V9l1/KRT; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759973048;
	bh=fEz4fk7jBSbmE1HYpn3tjFnZHoLb7r0ZS14ykGQI/28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9l1/KRTBVa5t/9fHEQQl2Khx6qPGSjH1oc7gofQDgHyLOeAdnDrmcDwRodnsYdL4
	 AENt52vsRfZchDQTzisQHmXCXDIX2Kcr+vMKMcPzyLLMYizhwzwIPBauWJRXYP2kEU
	 L7Zkrmf6S8kDK4eemgNDlJ57l5yeJZAqI0+7mf3M=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 604B5019; Thu, 09 Oct 2025 09:24:04 +0800
X-QQ-mid: xmsmtpt1759973044toil1wnn2
Message-ID: <tencent_4F1A340A8966155C52AA9CBDB68FD221FE0A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GagF51JIOmPZ1el/BSfc7CwYaj0zfrc59eELPeA/egyVwn/xq02
	 uj5CSVJ/Oa+IU92LCt7Qm8SpF8I9lIg4bTM0to+JB4dXNA+D74EPBGT9OeOIhpCTweGxqnntykoV
	 gYVWRz1WtNHERnI6IRcHze8yWErapTV7eRHzN6rvgylQ+e/Pwy05eipnX3ED65Uhn73qh+IByEVn
	 +yGv6sp+Qouk8NJbDrftIK3eMRbS1dPp2LmN/QLOrM0lAjx8O481S6Rg2unCt0u3upWHRnugMD9a
	 0JyNlioWn6nKsseyeovRZg6NXoXDKTeuJQjg3HIyBTi4bdCsQ5RUzkclbUlvSySGQp0z63KqkYaM
	 /UROb47Q62BxFHp9+axexgwiiqj2mcTgu+roLOTQfa3HfQ3bRNr79xrZfhATP00TVRAGMqAht8/e
	 C62XHfbADS0KgUBbrCEixEWeG3iIlPS3JF9x7ON6Xx9OKajMyQuTVdgRuiku79bIK/RfdJwUxXoi
	 iooKrjOBsaW4rosTwZ30X37VZ1fGtr5448TBIVF3X+79oK6r/MSYiIXNU1U3ufK1ydiQbvza8v5/
	 Q7TuK9eqMRKeecLwUXOOKUeVzOMmouNoQN68n6HYDKJFMm2s165HoSU7tH2qkELkSZfETS/JIChS
	 3qMXQxkFIkmbwrD9Cl+rL28ZUk1gZRhyo4aBKQWUEovgKw0SV7Zz6gv9dE2stCTHXSA8uCERZTRw
	 8L9lpPX7Q0mBMmdztAu8FTiMk4ZpvW26lLpp2HorRmLCTffZaHRi3F8JTKadU/w/x+WmmcGpSOca
	 8e/F32cXMU5Y0UrqFqCwJwSygROqa9QX7vqpOi0HIDzkUeyKiswNiLXP9cDsVOHWDgvUHR/3t/cX
	 6BzzrwnViwjx3uLJYQ2DGzf+QGZblTvbnohdlMB6gf9iHm1eSFh5y+xYp4acJZE61bnXfa3vptub
	 F01597YBTx8Ujt7WWnvNizswgQgkxsH8FEQEvA8r1daALArkE2i/sWL0WCvn5mjOtC8TvIZiexJ9
	 azedL54nQoeRZvyUHeadzsgPYbQUE=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs
Date: Thu,  9 Oct 2025 09:23:32 +0800
X-OQ-MSGID: <5d868df566d0f2b48f2a4f54cd2245895af8391d.1759972627.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759972627.git.rongtao@cestc.cn>
References: <cover.1759972627.git.rongtao@cestc.cn>
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


