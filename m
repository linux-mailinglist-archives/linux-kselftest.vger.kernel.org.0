Return-Path: <linux-kselftest+bounces-42763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3BBB8F13
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 16:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 417373469D3
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895CD239E91;
	Sat,  4 Oct 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="X573vd63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C8239086;
	Sat,  4 Oct 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759589638; cv=none; b=oJnIuZi/kFaSqQFEH8xvh9cqgfA1lv8SnGc7HxvHdthX62+2jhJn8CtF7qEs9iW2Z1mnZ59bM96v7cKfw6jRCLL/b7wQ74VWj/ju/Z9sAqyKjyDTpn6cpum43JRTbh6Y+79FxLaRrwBU6gr4x84sd1D2jWW0M7dvYlKqRshHP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759589638; c=relaxed/simple;
	bh=6kn+nU+PafXFIduRZ0FaDYAgo202PRXthXbHPcJQS0I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ETZtzvLxLBYNJlAyVWMbUOUsxHPKEeei/6XZrXlKRvKwA4cG5qSrxt6n+SOLoTvnd4AqY0E11t34kvX5+KNWf+40vDUoZ5qYvxmRo8vhZV88VnH3ZT5J+gjg8dYrZYhOU/z6uQ6vRuupSONyMgdmOxLg6xCNUQWsHHXYOo8g9TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=X573vd63; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759589332;
	bh=S5qgSqvdPGq8AAyNkeh4wjo7KE36ZX/xh7qPaL8eiaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X573vd63qNJZEz8WiVnNjtH+CuHf8RT5hudpPCDsFoTxRx4LkbMt3EEnS9iUL7s5E
	 0zQ1Yojy5h0oeH/ZYrtIKrkKc4nkv/F2c0BR2pyTB6lkOLKJoniSpwiylHNI8SFTMf
	 Tu8VI7bXQBHoL5XTTvv0bB+hLaI/CzIfkvQIykag=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id C303BCAC; Sat, 04 Oct 2025 22:48:48 +0800
X-QQ-mid: xmsmtpt1759589328t6ob1wjy2
Message-ID: <tencent_FC91DA604BE83F2BE3524865EA956DB41A05@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+hhIlk8JsCaXmrVplC/bmVpo6yP+6dZQZcLPvfT5tdlkoxM/h/J
	 b9z1OdINaecMOYJYhBhW2qFtUVCj8Tyln/uHUKJd/UJhprAJ3Z7BlPdOC5dxs7DP2YmyfKgjwJel
	 zVEnhz196S7281COB8mirTY/J/LICnNbQxg8uPtRPAdCXS9koS7hiPZ7mSjgLk0jLetKdPNkWMez
	 m/joNqw5dPe9emHa0+JP9pU44/J3aPb7lQYWegT2N0cuGB/IohK/Z6EdCg16MaJbWiQDOoSKi4do
	 99qdR8o9A60EFegIHL58Sis1o/ZzvuC4+xhzn3oN/ciJBnmGIHD4MqhJSmZKhPb8mYXJghWQ2FRK
	 V3RrooFfTm/VmggSbpvbST0jm32XqHl0oIlAWMmrs/njfpZw9LSxo9az03GtPyw0ggNRhYYo2NBv
	 /GdXyZwornkKFb6G8hvKGkf4gCQJZLH0sjQ1opVPNcMu+1RODobVb0jk0B8D6DoJIBb8EgpE75Y8
	 LiSSgUaD+q7DRaP5pEVNleIvOEP+K5gTy4mhAoZ2+moOSDPzsfy7tek0LI06kjyapUDrxrgksxq7
	 RqLd9Zz6vaQ9XwLxdC7Jwzr+kPmqfpGfELmiViO05vbPK8jfVtOi4Yc5l1vIUvO0vK87dUFv1dFY
	 mojmcBwLN8oNzyHwXDj48GLtmpyajOgI4v6cqaH0U1YPe2mRYxHXYsXOBzs53+kFLeCwwa7D7/zL
	 t86KaaKI5bfgswZuJV1LglD9H9r+BMUnUru6Mxuqn+1sOjvBJ1ZUanqDhjNY+kU8MmtiYPTRuMrq
	 u4TAEErCmTEo7ro+nopln4gPAThUTJsl9XpLP28j5tYAlN6cWszW+5KL/6i/VDDIXxClfRd8V9YD
	 Ug6WXmnhC6lLZYtn0sCU2igc7ncRcgs9IF3mkAv6KKF5ZULpccnJk/FOMzJ6atL8FYwx8dsRq29m
	 m1tj33HK8pq+bJsrw5jqGEnVkI+Cli67yOI/9putleW3rmdtMsxDLW1+IbeXL8IYrm2q1yPjVcty
	 I581AiC87xgEBBCx2otyTEhxNNyUJIVjX0RsjV8JOSdOf8TxBPYQ3bJ64V5Y/h/d99HcimBKG63x
	 MN9vVF
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs
Date: Sat,  4 Oct 2025 22:47:37 +0800
X-OQ-MSGID: <9b4ce3f47032e70e9ad8bb884afe9524e3ae4f03.1759588929.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759588929.git.rongtao@cestc.cn>
References: <cover.1759588929.git.rongtao@cestc.cn>
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
 .../selftests/bpf/prog_tests/string_kfuncs.c        |  2 ++
 .../selftests/bpf/progs/string_kfuncs_failure1.c    | 12 ++++++++++++
 .../selftests/bpf/progs/string_kfuncs_failure2.c    |  2 ++
 .../selftests/bpf/progs/string_kfuncs_success.c     | 13 +++++++++++++
 4 files changed, 29 insertions(+)

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
index 2e3498e37b9c..d21330b4cc3b 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -33,8 +33,12 @@ __test(11) int test_strnlen(void *ctx) { return bpf_strnlen(str, 12); }
 __test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
 __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
 __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
+__test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasestr(str, "world"); }
+__test(6) int test_strcasestr_found2(void *ctx) { return bpf_strcasestr(str, "WORLD"); }
 __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
+__test(-ENOENT) int test_strcasestr_notfound(void *ctx) { return bpf_strcasestr(str, "hi"); }
 __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
+__test(0) int test_strcasestr_empty(void *ctx) { return bpf_strcasestr(str, ""); }
 __test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", "", 0); }
 __test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "hello", 5); }
 __test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "hello", 6); }
@@ -42,5 +46,14 @@ __test(-ENOENT) int test_strnstr_notfound1(void *ctx) { return bpf_strnstr(str,
 __test(-ENOENT) int test_strnstr_notfound2(void *ctx) { return bpf_strnstr(str, "hello", 4); }
 __test(-ENOENT) int test_strnstr_notfound3(void *ctx) { return bpf_strnstr("", "a", 0); }
 __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
+__test(0) int test_strncasestr_found1(void *ctx) { return bpf_strncasestr("", "", 0); }
+__test(0) int test_strncasestr_found2(void *ctx) { return bpf_strncasestr(str, "hello", 5); }
+__test(0) int test_strncasestr_found3(void *ctx) { return bpf_strncasestr(str, "hello", 6); }
+__test(0) int test_strncasestr_found4(void *ctx) { return bpf_strncasestr(str, "HELLO", 5); }
+__test(0) int test_strncasestr_found5(void *ctx) { return bpf_strncasestr(str, "HELLO", 6); }
+__test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncasestr(str, "hi", 10); }
+__test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
+__test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
+__test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
 
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


