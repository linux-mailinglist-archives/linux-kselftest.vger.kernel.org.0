Return-Path: <linux-kselftest+bounces-40666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D6FB41103
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50EE1B254EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FC2EAB61;
	Tue,  2 Sep 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="oLUQ6X3b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D682EA72B;
	Tue,  2 Sep 2025 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857213; cv=none; b=lIvA70VNL/anXV/tub8Jmz0zgeglza5l0Qjbt9eWe0SZppLOZy4fk2qy/u5MGJAA3J1y8stMkBNIJWDk2neB78YKEhLHAvqGh24wLpcRCa9hnUTqjFV15MlUprMhpmXi6c5onh1BHwPUPTIPX+6Ux6coasbAaN7jSzWq71MGG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857213; c=relaxed/simple;
	bh=aldUShrsK2P1VAYuHktKiMurKBf9YkhU7WH+HgIinBI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hBM32DqJKSvIIQ2syHIsTfrgj/qdWUGhpTZhXMjV+l4+VPln1UsZeDdvIqwp4XDfK/f2RcbpCKug4Shaw3rS0sbmKH6KqHEAFDOKm5mrpFjn/q7/9NmqQeg9VlKe1wqB+6B12ge+e6jQqVmE90mCHQkhzb1ppfpGNiHETxMchbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=oLUQ6X3b; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756856907;
	bh=YdjLM4MjfViYc0wnccy7RBUzMk0kmcjZ1mAIcWaBwtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLUQ6X3bSLoz8t/RbCA7PsuSAGuTuyOSPzV61UtDa2hDJlgvLyzEgjdft0l0onKqw
	 oNfLI8Rr0lWSpgO1qiBMGCXlAAWywhKC7YZRdhteeU05fn+OqhjGcjAiEqQBOnt3W6
	 mNSPgTzaiuFMjJJNzxbHxiow4B3L6vFtxNQZCtkM=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id C181CA03; Wed, 03 Sep 2025 07:48:24 +0800
X-QQ-mid: xmsmtpt1756856904t4887zsxo
Message-ID: <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuMmx/RukVSPNjt651NOrVM4wsK7ctvREMS6Y948heKjWmxrfsbc
	 SEzb6qJG811iYQLURS7TuamVhTFWqXK+q5sXqCpWk6i1Qv3aiRvocoWb/pAC7GXZIRPBEPkbvM2J
	 YJr5G5trGvx6yo9EexDlQuWDjkkhTD0yf9EcQ0H6irhCjvqdAZoy6iG21FEWYPtpOwZ6Blf/C9kO
	 u+bPscCb73MZAlqaWDyfqiFecpHzlDIZBelA+0ltQ7sELR3DUNEGcuCF3Q10dtuDq5Nh1Aq1OFtJ
	 jFrOdhwg/hTKFNaxjOqIj4YCIpQmMhiAzbvhcCmg4I38hNgdNGWBhXwkSFtqQ09+rA2J3ThOsgsG
	 zFUkomnyN4SPKO2KU33JGishfTI1XxAqBkOQCpdgufWHdJbMXSnNNQIByEIIkkaKJwt/TZAJ4UbW
	 /ZakbjS6kcWBcy9h6G7mhdDJEVtDwpuaS9d/uHd2xUX9TaKk7mfl/2XpJW7N0mYqQj/0n+78/J46
	 8GmD8jVXbKTpGrDn6GCiDMokoMHiiSprnOoMctUcVYyHRfA24qJEW3FlKwky4jP83Qn/NLqWXt4n
	 fH/q6ZujenLxjCRCzhOb6xzdtrmWsTvqjmz96hV4hIbnFHmD7TSJzttPEbGeoy9FxNM+8ub7BL75
	 TcGd9a6vZKboIkiNmjfzxwc4xjpeLTkd52BM5BNCXZtWoYcCUXSIAPz+hYpQexTRl57aJJ7jrs0o
	 pQGuDj/1CFz2TEtdNzELEGJ7+Ju9pbbwazVdNkYHyMV7Z4RHlhwF82c0LqnhRFseDEwsav+j1Dmo
	 owuUoLWKiAbfIcGM7rnCKaG04yGw4bMBIsdgWBErDW00WF2TSH/XVWdkfVE0L3yd5jNImw0BnmvU
	 cJZjdJrEczjJOoYX13AJ2YvDht8bnY0h2pryiF0Hp7NnsPUgiU31ho0hFk2AuXbvkN3jgEAFwT7Z
	 my2/KPbuIgNYsCMu5M2S4J7B2SSREvXhvJcU1ErnyWQt61hbPDlQzLTMnxsy8YFlbhs5UbfylouF
	 rAcYCVlirBnxnJUQSATURNzPfE3qzaT5Qsr3lqEDLrI14beF7O0pWwDZiNApfsAuJXsTwgTQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: yonghong.song@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	vmalik@redhat.com
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
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
Subject: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasecmp kfunc
Date: Wed,  3 Sep 2025 07:47:10 +0800
X-OQ-MSGID: <8eb8c67d07ec6f95497ae3b361cd60bfd722bbcc.1756856613.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756856613.git.rtoax@foxmail.com>
References: <cover.1756856613.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
the case of the characters.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 68 +++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..588bc7e36436 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3349,45 +3349,72 @@ __bpf_kfunc void __bpf_trap(void)
  * __get_kernel_nofault instead of plain dereference to make them safe.
  */
 
-/**
- * bpf_strcmp - Compare two strings
- * @s1__ign: One string
- * @s2__ign: Another string
- *
- * Return:
- * * %0       - Strings are equal
- * * %-1      - @s1__ign is smaller
- * * %1       - @s2__ign is smaller
- * * %-EFAULT - Cannot read one of the strings
- * * %-E2BIG  - One of strings is too large
- * * %-ERANGE - One of strings is outside of kernel address space
- */
-__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
+static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 {
 	char c1, c2;
 	int i;
 
-	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
-	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
+	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
+	    !copy_from_kernel_nofault_allowed(s2, 1)) {
 		return -ERANGE;
 	}
 
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&c1, s1__ign, char, err_out);
-		__get_kernel_nofault(&c2, s2__ign, char, err_out);
+		__get_kernel_nofault(&c1, s1, char, err_out);
+		__get_kernel_nofault(&c2, s2, char, err_out);
+		if (ignore_case) {
+			c1 = tolower(c1);
+			c2 = tolower(c2);
+		}
 		if (c1 != c2)
 			return c1 < c2 ? -1 : 1;
 		if (c1 == '\0')
 			return 0;
-		s1__ign++;
-		s2__ign++;
+		s1++;
+		s2++;
 	}
 	return -E2BIG;
 err_out:
 	return -EFAULT;
 }
 
+/**
+ * bpf_strcmp - Compare two strings
+ * @s1__ign: One string
+ * @s2__ign: Another string
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1__ign is smaller
+ * * %1       - @s2__ign is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ * * %-ERANGE - One of strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
+{
+	return __bpf_strcasecmp(s1__ign, s2__ign, false);
+}
+
+/**
+ * bpf_strcasecmp - Compare two strings, ignoring the case of the characters
+ * @s1__ign: One string
+ * @s2__ign: Another string
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1__ign is smaller
+ * * %1       - @s2__ign is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ * * %-ERANGE - One of strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
+{
+	return __bpf_strcasecmp(s1__ign, s2__ign, true);
+}
+
 /**
  * bpf_strnchr - Find a character in a length limited string
  * @s__ign: The string to be searched
@@ -3832,6 +3859,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
+BTF_ID_FLAGS(func, bpf_strcasecmp);
 BTF_ID_FLAGS(func, bpf_strchr);
 BTF_ID_FLAGS(func, bpf_strchrnul);
 BTF_ID_FLAGS(func, bpf_strnchr);
-- 
2.51.0


