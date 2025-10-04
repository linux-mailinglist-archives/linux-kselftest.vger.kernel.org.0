Return-Path: <linux-kselftest+bounces-42758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF52BB8E27
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FA53C0255
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4D24C068;
	Sat,  4 Oct 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aYoTb3Fw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA90218AD1;
	Sat,  4 Oct 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759585116; cv=none; b=HP9TDBGWpnqLo2Qu3pMzKtkdF/73TtrUL0LEfHZZTgV8UgKBFnQ1YcbkVLCB3H+QQsjRJS/tZdyyzDDrh+/YGaIqvPUBZ4z4oPgjF/xY9RDzQ0lVJS6IY87eaM55MRIU2dB1yfBpsPTouG8xELbwdG9/nIXdVKmb6DlcFlhsySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759585116; c=relaxed/simple;
	bh=6kn+nU+PafXFIduRZ0FaDYAgo202PRXthXbHPcJQS0I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m5iWtrWf3RXfe8eKW3c8mEP95uBJHn7Fzd9kwFASDx8W75PRDnFoQklrdqSSr8IbsrjU/jWoJ2BK6r1AepJZj7P9CsSx/yjRn/IJwJn2D9wZFXG/nMs+KVKxo6tFl+0IXjU03W1HNCJlzxBDM3LLyFbMFcGlnlU6NYGfG/h+/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aYoTb3Fw; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759584804;
	bh=S5qgSqvdPGq8AAyNkeh4wjo7KE36ZX/xh7qPaL8eiaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aYoTb3Fwvf1IswMQ7udal0ukF+mGW7yMj46Z9hRoMR6we+cHKNUcJKlw85EmLuNq2
	 3gh+RcO1IiDehnlMXbkM0O24/1XSCNE9RZvfXqFvpbv4IwMKJjJcsr4fsQ8zgnlEIs
	 A/3gZGbmRCpaSILgTwtQt9xxdAVG7+o9ZcSzaalI=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8538E4A9; Sat, 04 Oct 2025 21:33:19 +0800
X-QQ-mid: xmsmtpt1759584799tzm2egw6u
Message-ID: <tencent_BE8344A180AC844B3F95CFD7CDD10BC47D07@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2rZOVE1GiSa2Ofw7ovUDvLjQk6UmpOJ+IFCfXq3skJljIY/H5dG
	 /zOSn1ncOBSBYOmUh36UJoxLObnEb3gH+2G08gzloNlYVMQtGu955lB4FLUEoJIgPK72YwecsI5L
	 qvuNYLvZbBVg9jwzHnBR/+4IBCtoVL/ssxMM3q+VHCDPemmbIZDaWznnmQ/4k+b/T1pBceFsp2mR
	 4uPhqqQZ25Rfq+1juGkqPIOocKY9P8w/apPA4LTf+WpbkV/VfbvtmohasZpl+aGj27t2WneqNHTg
	 haxspxgfBdjN648nW69EnqygOigdwleTx51vBttAeygsJj51m43AQVbPRncqRL0HVDP4N3saJnlZ
	 LOsBnkJvThJUUDslGDVAw+JjEglYO29JaxxfERR4phqLeNhkOQA/ZvpNB3zgPYk5O4qGK5119Arl
	 H04bfJ8iqKLro9siQ1djz3m8i6uTUfBHR9B/+dmr4nkPalJcZ4WPmPiMhfVOZ9VDvaXYN5iNR2F9
	 xDTF6QS/8x3hrtG62bMpZB1ALZ3b4Xz0iYuNwZ8Rf+zeTcRW8ZeepeY0BPf+6TEfm3F/elG1iU0h
	 SmVpG5PVPo2x6rUrrb+Vxd6nsN3xAPCdA5iWDXPqzERLnrNMW8EBuHbBWBSATZrX0qx2Ksnalydt
	 uEvFrZpy4MtzBf/+0VYvYK1Gy1+Zu0pWCf/0sDByrfq3z2hTkNQWqJR7D7vPOCeYHN1zimF73MXQ
	 oAaMO601tAvTH8vg9mmAzpyYO47HVNOprXnG5xNnw8yF/uYD8Q1EclY3vyUR8SLR7FDNvL289H/V
	 1nM4udYQpFwsFz/a3AtSv2Kx1r10cJo5CltTlYbWbZ49l+CkbRnbdX0ICNAxmNWdFOX8B9Yn+o+y
	 2j7cKMEPIsC+9WutJsJaSCwozJWKFsFTNR3iCCAYi3LSw2KeaNprbeKllMWr76t/pr33EWuAb8km
	 my9nXBfEUL0gmQPTwuV6cWASNr4KWHkACEk8UmuIR9OQzUD+/9OBCM34xIPrmcg7DaRsfxf1trVZ
	 GiE9/LAQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_strcasestr,bpf_strncasestr kfuncs
Date: Sat,  4 Oct 2025 21:32:10 +0800
X-OQ-MSGID: <f29b1747e785004f43368f56d482bd23f1a4a3a1.1759584052.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759584052.git.rongtao@cestc.cn>
References: <cover.1759584052.git.rongtao@cestc.cn>
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


