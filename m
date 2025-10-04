Return-Path: <linux-kselftest+bounces-42756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DBBB8E15
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3608189F466
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B91E98E6;
	Sat,  4 Oct 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nb+AGhdm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D73AC3B;
	Sat,  4 Oct 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759585037; cv=none; b=CWZrbfn3xRbcbeg/XgwtBdS3oR07t34Or4Esmsym0xuOAA5t8CZa2TJ/GDt220ywxeCHLyasL9BAn//RmgI/zKob5+/rEv6w+35ICfVKfvrOlVEJSoksKy5cS0qwEUwXDCIwml5ERDOLyAR2lwjfUtlMt1oQcNJ8M0ZLcsQVUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759585037; c=relaxed/simple;
	bh=NotgVR459wjKygAY/54924e4TuyyAZOzlvSM7r+iHdA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PFUlYp1hUow1pmqImRoB/EjEwQTFj6kinHcV7GZz0TM+TP/xnabpTdarvX4eBCrzhc42wFeNulnMHD4w1/5tVTfFkpCMbpat0wAgMFDwPdgBw8GatztJimuDuzgKR/XaOxe7AeRcXtFxA57u5uv3aa9VYfwhagbKG8qS05AuLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nb+AGhdm; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759584724;
	bh=VyAzH33bZ5jubqf+b0JIaBWiE38yckPD6skJn5YjsGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nb+AGhdmfaQ9tWjAn1C8dKFtPXrKzT18iukHQ8ovmG9DKqrj9HoeHeJGisrUD0xxM
	 wWf5psKOeTKinBDS1cDUCumYAU3NkYUAnJ/mzXuvkXQ7xeOVHlfOzhJ0KDpIGVrUnS
	 p/EaJQokCCErW07ZP6+gyk6Ke3rBgeIyCMjUjUHg=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 80014CE9; Sat, 04 Oct 2025 21:32:00 +0800
X-QQ-mid: xmsmtpt1759584720tx4xq1y1w
Message-ID: <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zxgeAYGgb5BJSu14uvbFnZTopi9tPDfJAbe7Po+fq0T0Ca2/UHd
	 NzRgYo31WRfFsZdYsdwQiq6eucFrWPvFvExU8MUwS4sKiyQOD0Z/nnuKpMrJQqvyALaDEwWDcrBe
	 CTjFOXc8tkqKRh5IXHnJ8zMF6HE1QzIy0yLz3DR8DVdr7ff60ro0/J8R0SdNX0BvSIAhphd/BYeJ
	 s2KpIFEC5dYm1cbT9FoziOJ35PXnvRxZDLV2pF1OoxLruOGAiOhNaYmF0HDFdJBWIbIyCzvPwOXF
	 pLR6y3HoX4TpKJAPDo7++C1m+7kHMR13L34RRthrXedMg5TmM03pn10Kjdii75e0m7hD5PJnOAl3
	 s3qmKgqZlQi6iPDTSuKN8f1iu+2uKKh+cdME9ckbDWAKFwHsy+NArDDdlhyuxKGXrSpykj8xvnsL
	 9ILqVhyR9A6cX/G2+ygirpuM0ak2fJvOKuA60hpTghPkfnZOr3ELuAQ11hb7MylhF5Vlx4ZkBF6K
	 zslaWUSCknGsb9EHMNOUuhJS96i46xhHiGjR7Xy275psqbGNdVF+WTeCupRxdoC3/Gll393I/MMB
	 J7fydFcJG2As6s0stGieGxakxrwQzIwTUxoHM1eMUXmALwveidARvlkp0Au/GxXByO9VtiXYhzpx
	 jRqZNIDqwLwJHJTJ/ytjhnXiJ8ztTx5IXKTAVZrZptGJJ/vGq8KLUWYV4AayxaLzR2+1mkXYqRwv
	 L2CvvwsV+n7cG1GsnM1AgN1jf5ipG/pkrKDQHyJfGvRSEaZZ5AjrZUEH20SzKt2qvWmQKmC4qOWO
	 em75ayEu95PoqPCHe0DmxPEr+EDQWYomjnUsDVUycUwMfY0GCC3hClaw5NhhFsWKoiSfL04dunzZ
	 u4l+fq84gI5EunbIbKw4JkxqnPt3leSp4cS8vtYvSNr5pS7uMmtTqJ9WJT74jodXC5BgJMs6WDAl
	 i4XAuFbO9N5kLDuH5ZSb4kFdeZahE3ladbmwsB5BKFqDwY8XsTV/SHRSZ8X8zg6AbOd9DI2XYGJi
	 grw4p6Pw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH bpf-next 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
Date: Sat,  4 Oct 2025 21:31:22 +0800
X-OQ-MSGID: <57ef864bdcde4ebd00aad672fab7f24abe8e50d7.1759584052.git.rongtao@cestc.cn>
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

bpf_strcasestr() and bpf_strncasestr() functions perform same like
bpf_strstr() and bpf_strnstr() except ignoring the case of the
characters.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 96 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..c4a0070d1c71 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3675,34 +3675,21 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
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
+__bpf_kfunc int __bpf_strnstr(const char *s1, const char *s2, size_t len,
+							  bool ignore_case)
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
@@ -3712,7 +3699,13 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
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
@@ -3722,7 +3715,7 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 			return -E2BIG;
 		if (i + j == len)
 			return -ENOENT;
-		s1__ign++;
+		s1++;
 	}
 	return -E2BIG;
 err_out:
@@ -3744,8 +3737,67 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
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


