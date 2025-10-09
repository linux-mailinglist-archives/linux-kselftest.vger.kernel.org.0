Return-Path: <linux-kselftest+bounces-42912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4EBC71B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 03:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5405A4E2675
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 01:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64CF155C87;
	Thu,  9 Oct 2025 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xXF7khc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837C1531C1;
	Thu,  9 Oct 2025 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973317; cv=none; b=JrrKI1EGul4lqVG3ZfZKpB3EXYQvtKr1UfUdKTX/5dKPnr3TPK7FEz7SG36kCSnhQ91RO2fcThmmu/ckDRcPiDTly1BgGkjOztR6Q00yjgINPnqmn+BOs5hpnV5uTc99U1ciRlqbmO7TjyYi9iPpEhwtg82xmXkwx8aN2LKMq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973317; c=relaxed/simple;
	bh=mbNXEMA7DxaZhOsKJ8CsmzDkFCh9j2UH0J/u4rkRqwM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YR7BI4o/fyivjPRpRg9dhK8oo/0u5LGmMKc1poJ1KOWfq/7hzfeIXwkz1k0D/CdCkZb0XwuYwQufx+E7CGekCy+Zw8eosBjkMvlDeddF6HghhXv/5Bacry/9/IFGfauh0QdeeTOZ/WFFiQwXUF9aT1of0obk5vYaedFzI1yebiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xXF7khc0; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759973004;
	bh=h6RvhS+2x51/jw6Bwg/IXbtI0q6iQSD8vrZWzbYnJ8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xXF7khc0luYPR8sZacIWTyvZUHh7vQOvNul8qRzyn/fA6CflWzJ2YbLgR3dBz8Pvg
	 /nY0uFwebRK+RDPFiyHhERaeI3f8SWTD4xGJklVYECObHvshKQAwDBYqBT/XqaVH7B
	 Hnk9w5uAppcnfxfNC9i+0HSo3nr5UOBojOd3ViPs=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 5D53B82C; Thu, 09 Oct 2025 09:23:21 +0800
X-QQ-mid: xmsmtpt1759973001tkd124fjg
Message-ID: <tencent_B01165355D42A8B8BF5E8D0A21EE1A88090A@qq.com>
X-QQ-XMAILINFO: MEaKDlY90mahtpnTATHSoV8uYKejRLcvkkiWK/PxSPfrhG8BXAUgtQKEWfyyJi
	 xeX18xwy+ZyjgfZd4CrJvfzaVWaddQXsDue//EdXrw8xAfzNZ1fQW1WitiPBCxFOEtrkBJXem5T1
	 wZBITALVcQrpW0Gs5iJqZWZOcGmK7YTmSwqIPOkWu3Q/yjYU8iFsVIsUhMcV2FI2WU7H1m8P8NqX
	 jGaP3Z/PvDji/mIvkjDphagrxC3N+R8jTOHH8eJrmXzhU9pSX/zuv61YJDlZuoEmzG7DYqcdDG6W
	 CQGacNVP6VS+1nY1W35DDW0fZZcfxWWf6aN3V/HaFCo4vz3mlj3TTA7wMwWJmgocqeihNDyzCbiu
	 gBCbwORUP6HBZlb7VFJ0usAT0YCAtrOv57N5lXvLplRSSP/q8uYtKV+qU383iH4m8saFXA9E+yH2
	 +Y/R5sRQtzErjEvdCB2O0MRZuIzap8i0DNzfjPzKcoeNkSpVU6A//yK255Eg1VyLEtIScu9Q7N9S
	 qEBnROVdNnvEcr+YFQ9HcTJfAzT2EMIegUlDCX1KC6IQMa3hf71+NjkMYfPBjJkrQyx2dTymb+CS
	 ZmMiy+UX2yBvEs2hVNn9qFokpo/008v5nvdZKxBSjuDaQce/8QHXhBrVCArspxk8nHVoOmGvLIhp
	 fV7W1GtegXE2emGTb5G+tAu4OdNeWMvHNPwF8KuuRjlo47eJs8njdoX0Q31UZOFaG9ccft+AeeDy
	 0gM1tjVnyYAfdcGTcJeHVJdPQvvkfpew5DJDS+HzmvGCNdy+nbevQlQV7rpKwgmXnH6Bpq45S52C
	 PQoNmh1RFXmTBj45b7nJu85TSQkSeF+SvCEfG6z6Q4fFZiVcTjK2FrzkLi8enOLOhyYy2uXXa5S4
	 tAD7Arc+NmOVl+7HcXsdHWnMDFC+VkjtN/5+c06KvipZEkGeiwJ3dTW1vqyDtYpaFlppT2fVE1aA
	 8LAAmJJ1LPRVP1YZhuWaqMXeO/31uKjMuPxlT9AhKkaYhDn5vCTgW9q7nPkbdS1oUqreuE09YxKV
	 VhH9C1Ke39N9OgvODKQ6q9HDV/V58YpSV91Oiwd3GAGcuNtIEk3gpB1RrPgivVlI7plRj9pA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
Date: Thu,  9 Oct 2025 09:22:25 +0800
X-OQ-MSGID: <6ae9146cf1e0e9be9be4253dd033cf0062d08b20.1759972627.git.rongtao@cestc.cn>
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

bpf_strcasestr() and bpf_strncasestr() functions perform same like
bpf_strstr() and bpf_strnstr() except ignoring the case of the
characters.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 98 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..485f65fbd97f 100644
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
+static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
+			 bool ignore_case)
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
@@ -3744,8 +3737,69 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
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
+__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign,
+			    size_t len)
+{
+	return __bpf_strnstr(s1__ign, s2__ign, len, false);
+}
+
+/**
+ * bpf_strncasestr - Find the first substring in a length-limited string,
+ *                   ignoring the case of the characters
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
+				size_t len)
+{
+	return __bpf_strnstr(s1__ign, s2__ign, len, true);
+}
+
 #ifdef CONFIG_KEYS
 /**
  * bpf_lookup_user_key - lookup a key by its serial
@@ -4367,7 +4421,9 @@ BTF_ID_FLAGS(func, bpf_strnlen);
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



