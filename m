Return-Path: <linux-kselftest+bounces-42762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69CBB8F0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 871483459E5
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB12367DC;
	Sat,  4 Oct 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XqNK5Z7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46B233134;
	Sat,  4 Oct 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759589567; cv=none; b=bauRXpL438I+EPPtTlXlrgSLQ4/t9KiZWNIEGqjv0/rcwiRKpqjnOD22E26wzaoYH/XZDLofEQCJ9Q+oGVkFXlw115d+K6Z5+N7k2go59Xj2ulMaIO+sCMWftuOHPdh0fYBcfTkgZj7RdWENLCOBJx0WkcrKZzp3RQomWrl1MoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759589567; c=relaxed/simple;
	bh=N4b8r33/H2ZqGu0Pco/mZK93Do1k76oPiV2wTGx9jw0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mkUswKnkea2NAobbe4gsot6tXudE5lZYsSLfLEp7LKjkjle7RmlAnw609g6p9qBT0Lm7xhZVgcblcAKtty63PReFV/NMBgjveyjgvK/DcD0mk8xsVy2bIBPeBIsb2hSvlbpMqBfwzQf9D4Kc98JLBpYGsK/Vk+1f03vOGwMayXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XqNK5Z7T; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759589253;
	bh=uSrlu2t6B2rNUKlYlaJtNQbP7b/XV7+wcL1URDcXuws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XqNK5Z7T2e0LX5AUdMZ/bfkXX7PEkgSFauWUU4HYTX4FhgzLFGqctKyVHJo+rUImF
	 ubtbeDrJnThQ/126KyhvfCxEkQBJ2mhdyRs3qHS9jaUE6wBH8HzSgHSfrY+3gDGTS9
	 EGQnZBhe9Pb+koM0ugxIzz56GOvxs0XGaIxe3cpQ=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id BDDB78D3; Sat, 04 Oct 2025 22:47:29 +0800
X-QQ-mid: xmsmtpt1759589249td8ablwjq
Message-ID: <tencent_6D228941AB904DD6E1E58C8ACDEBEC280C06@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NovPrBA0aooRxj3MAj56pW0jeYRiihdE5rrScaMpS8QUEd4poBqA
	 WF8wusj2yl0bW/vG5i7DkVueMgB4SpNZdaW/iRqzKlhpffVL23bIOkGHaPjtzd+5g1Py8ZYTXVWx
	 OTQJ79HY2IPsxFLhfeYJ0ZHnDxNH3iRmlLqNCMC5l9h73gZzjqgDiJwch3XXynp4Dg9P5L0CQoag
	 XY6H8QA5uXQikLXg/8fJNZFYluwI/G7MHOmlvtcoTGoMP1PndUe2V1h7TVzfV4bBqxDJMuZ8e3QO
	 rQ2ie26EJTOWS58jPamdRJWI46r5dydEN0nBfXE020yut9KRoC/lhgToP68WCz96V/JE2NqN6FXA
	 vIax906Zdp+LJWcvHwjPOp9CJMLe0qoSGI+0oK5MqBASql10YDcIBBy55cYAv7GkvhE+riHazgT4
	 hRjyGAnHwiSLxy84mdgjME40InuX3GojfENjfL6kNPLUYeMABQkoSvDc/PpHz4HNCJBaDP3zyY6v
	 m4KFqye79MpL8gKxejRbBGym3SqbitRY01GwK4FfPy4DlKEPMkFuHhAHXNb93ztxkT+PpAFb2KLc
	 uJPOfOx9ZIQqPZZ+58kcXDK+P1s12sSXSln1tkw/rI7hLzSW9BpkwDmHnrUIF91/sOpr0bgw2Y2Z
	 gIgBkfcEuLMdW6QX8qBPxVf9AxP/bLX+6P42v13/CBb9H2H/UE6Y2qplLvOljuKQ0sHh8syw+Bmh
	 0kwpKLFspHXOLLOjeBY/Jkb/OymQZsVBMF6pDwi+m3JFeq82jjJ/AWArMU+0QxT5il9biXTt3aNT
	 +bU2OTLuPXRaNS+2a+/S0n500FxNdOAMzll5VC7KOcWMM98W9OqEhxxOkssl+81AxhMuP65zdWqx
	 RQgmJSjTKWiIv7WTHARi5tvUs4exjecSHeD0UI0RXeqCO4BgVMsRbgDQKAoBQPjgQV3flzsWZkc/
	 crSKJHP0JvLjighVGWMeE/Mchl6A8hPOXhzaqqatSypbZUJk0Y+4f0t5gcBqIcEOKwh+NoWH3VK6
	 06Lb/zSiYpFn6bFJqt/6MB6FOZbANhoqcRn5TfVg==
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
Subject: [PATCH bpf-next v2 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
Date: Sat,  4 Oct 2025 22:47:00 +0800
X-OQ-MSGID: <5326cf159b78215700469278eb90113df7903271.1759588929.git.rongtao@cestc.cn>
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

bpf_strcasestr() and bpf_strncasestr() functions perform same like
bpf_strstr() and bpf_strnstr() except ignoring the case of the
characters.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 96 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..4df902e5f208 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3675,34 +3675,20 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
 	return -EFAULT;
 }
 
-/**
- * bpf_strnstr - Find the first substring in a length-limited string
- * @s1__ign: The string to be searched
- * @s2__ign: The string to search for
- * @len: the maximum number of characters to search
- *
- * Return:
- * * >=0      - Index of the first character of the first occurrence of @s2__ign
- *              within the first @len characters of @s1__ign
- * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__ign
- * * %-EFAULT - Cannot read one of the strings
- * * %-E2BIG  - One of the strings is too large
- * * %-ERANGE - One of the strings is outside of kernel address space
- */
-__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len)
+int __bpf_strnstr(const char *s1, const char *s2, size_t len, bool ignore_case)
 {
 	char c1, c2;
 	int i, j;
 
-	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
-	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
+	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
+	    !copy_from_kernel_nofault_allowed(s2, 1)) {
 		return -ERANGE;
 	}
 
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
 		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
+			__get_kernel_nofault(&c2, s2 + j, char, err_out);
 			if (c2 == '\0')
 				return i;
 			/*
@@ -3712,7 +3698,13 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 			 */
 			if (i + j == len)
 				break;
-			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
+			__get_kernel_nofault(&c1, s1 + j, char, err_out);
+
+			if (ignore_case) {
+				c1 = tolower(c1);
+				c2 = tolower(c2);
+			}
+
 			if (c1 == '\0')
 				return -ENOENT;
 			if (c1 != c2)
@@ -3722,7 +3714,7 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 			return -E2BIG;
 		if (i + j == len)
 			return -ENOENT;
-		s1__ign++;
+		s1++;
 	}
 	return -E2BIG;
 err_out:
@@ -3744,8 +3736,68 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
  */
 __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 {
-	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
+	return __bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX, false);
+}
+
+/**
+ * bpf_strcasestr - Find the first substring in a string, ignoring the case of
+ *                  the characters
+ * @s1__ign: The string to be searched
+ * @s2__ign: The string to search for
+ *
+ * Return:
+ * * >=0      - Index of the first character of the first occurrence of @s2__ign
+ *              within @s1__ign
+ * * %-ENOENT - @s2__ign is not a substring of @s1__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strcasestr(const char *s1__ign, const char *s2__ign)
+{
+	return __bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX, true);
 }
+
+/**
+ * bpf_strnstr - Find the first substring in a length-limited string
+ * @s1__ign: The string to be searched
+ * @s2__ign: The string to search for
+ * @len: the maximum number of characters to search
+ *
+ * Return:
+ * * >=0      - Index of the first character of the first occurrence of @s2__ign
+ *              within the first @len characters of @s1__ign
+ * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len)
+{
+	return __bpf_strnstr(s1__ign, s2__ign, len, false);
+}
+
+/**
+ * bpf_strnstr - Find the first substring in a length-limited string, ignoring
+ *               the case of the characters
+ * @s1__ign: The string to be searched
+ * @s2__ign: The string to search for
+ * @len: the maximum number of characters to search
+ *
+ * Return:
+ * * >=0      - Index of the first character of the first occurrence of @s2__ign
+ *              within the first @len characters of @s1__ign
+ * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
+								size_t len)
+{
+	return __bpf_strnstr(s1__ign, s2__ign, len, true);
+}
+
 #ifdef CONFIG_KEYS
 /**
  * bpf_lookup_user_key - lookup a key by its serial
@@ -4367,7 +4419,9 @@ BTF_ID_FLAGS(func, bpf_strnlen);
 BTF_ID_FLAGS(func, bpf_strspn);
 BTF_ID_FLAGS(func, bpf_strcspn);
 BTF_ID_FLAGS(func, bpf_strstr);
+BTF_ID_FLAGS(func, bpf_strcasestr);
 BTF_ID_FLAGS(func, bpf_strnstr);
+BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-- 
2.51.0


