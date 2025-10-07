Return-Path: <linux-kselftest+bounces-42800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D27BC00F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B56E18996A2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69AD1F3BAE;
	Tue,  7 Oct 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="n8CQNbuF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C7DDD2;
	Tue,  7 Oct 2025 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806539; cv=none; b=u66mMbuVhE6xeMOthe7SB0yaqWqv+jC3lOQwzJg9f6ghR/eo8ODgyv2q31Crfo+XkXxVqhGqdBqW0XGTkGYmuEZ7ceCmC68QEdKGInsRIU89qJM75qhjhdsawiJNLd1t7vVvSHTARuANqGJhEr1pMfAv0yUwFrBkjipgACK96eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806539; c=relaxed/simple;
	bh=LzTdkO20OQbm7ASkTIUa/renyxKHSHatNHfCSbMLMag=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wre39dvNnpAwJVoS+RH4z7i0kNv/hMSFkw11rTLEPbD9oh+TVSdxmRQ3+XBvLWz7YBBtpTUcOY+Vj/8jJXcuUTEK6aMfZHaBv2yLMNnNS5mFZnwQd+QUzLFu56BltMOuhPWMKiXLbTIORknBp8mYh7OhP+bAknKR43JDCWQaxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=n8CQNbuF; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759806533;
	bh=+oApfJbni6ipPdrzrrml0EZFAVDhvMqNsc4P1Eox0vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8CQNbuFswcLZHEoyRWNRiouO0m04c94uFZ2+Lg3ao7SYiQWZxXUsJhzROemr4U3V
	 pub6yJqNnC4olU7DnPm5QsNcjJamcxJZXsAwULPCLBrwaqnMl0sEFXWQl07e2Cz+Fn
	 ri5GfNtw/oJnKYUkmrmpvXuD5sSGTxV5PxkfpNuc=
Received: from rtoax ([183.198.135.10])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 1E9D889; Tue, 07 Oct 2025 11:00:30 +0800
X-QQ-mid: xmsmtpt1759806030tdw1ec0mz
Message-ID: <tencent_6E59062E4249590597452A06AFCDA3098808@qq.com>
X-QQ-XMAILINFO: ODdZrkDuTlAgvEvZMuo5bj7mNXmx5z0J4eQVHp5H1HWXcOOUzv8I4FoF5KrKLM
	 CBXsU6gZN6fGEs9/G53ZdLWbIpnOnyg5ts34D8lFaGU9fQKENp4oV3xG8gG23PxGx8mQhTLt2vpH
	 V5yOo4NKMP1a2rTH09VQSjK3FYgKNKYf2wOWnSsnm/hEJaw6HOyoW5A7FiNYVfOYbc6HYx3Cft5X
	 1ikllEjLq5qzFHdSCX6y6ejlOpUdOM9hBSBz90XOJ6nWQ7iuvD+wr8TXhZKwrXem3wBd7XTryRpz
	 zP6ep8MOndU9baXfRdM+SWFL6gh8XefKgTOFCrtPq7Hez+ZQfVoFDOa/CZSUe92dAf/xUqml+igW
	 upBhUGYp+QvDiz+BAyUp7dhwDcyDBnJb/TObuRPYmfS7Y2DI6hYO5e9+/T3D5DY/Pnd4M4Wnyg0p
	 WtVmTHMtfxxe2muLcbwq+A1sCFcmSL/8QReNV6M+QaSwt5TwWoX5fYe49b4nmGuYcYsNy5mZzVmq
	 ynG8/5k/BF1uIduoJOzdj27XAi8vNq2l5lFLt//8+pv0XoaSel1BUrU8zKiClExEsgjs3buPOJwu
	 c/LSWcxU0y0jXAUyqac0JSy7sgbqHsVvBb/aNLayngTJduzbqtRqk2hxUvLPBf0KbusdgRRVMaoU
	 3rxw/Q/wEyL6xi2hOn/h4PVtNJNx0Nt8fo7uFmw0eSFIk7PrpbJVmq244hPSsL+oUhV1ugA/Ch91
	 myetD/VNz42JStiBrk91dUytqhEWxBC9TF73Wjyc0dJEJCspluCsDOOT7u1cd2GjNK1xyCI+GvT2
	 5xLZmr5mviP5grLzO5KcSSsTgWXl69biNbYjEKsvWzBNf0AlHA2pHV0zdurOp6j6o58iq4VfCOvj
	 tXx4Pg4RclY8HqihrNjVJHHfQjE0PEeQNDqaAgEuZ8eqcRV06k5otRxmpIsR0qtOJqc+XJJ579mT
	 c2LdpcpcTv3EExgeK1tZKrlDnhBTt3md3DYjXakK/zI2RTf8IW34sxl+zVJHBBwRitocA1ooqHI0
	 krs5ZJSPc0QQURkKtH
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
Date: Tue,  7 Oct 2025 11:00:03 +0800
X-OQ-MSGID: <a25e6b9996713d55b57acfa0207d8faa2d2114df.1759804822.git.rongtao@cestc.cn>
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

bpf_strcasestr() and bpf_strncasestr() functions perform same like
bpf_strstr() and bpf_strnstr() except ignoring the case of the
characters.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 97 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..db319aa61c3f 100644
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
@@ -3744,8 +3737,68 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
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
@@ -4367,7 +4420,9 @@ BTF_ID_FLAGS(func, bpf_strnlen);
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


