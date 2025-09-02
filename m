Return-Path: <linux-kselftest+bounces-40505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB6B3F569
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D004189F106
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984792E36F8;
	Tue,  2 Sep 2025 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bDESYUSL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674320766E;
	Tue,  2 Sep 2025 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794286; cv=none; b=kBwNUKGU2RgIkqKQEdKJH/8cXv53ok/KKC262AghQhIVRp+tBdt9jmlS2ucOct82fKSknfukr6S9dc1ObO9uXX3n6eWipfu7xOkJ8QBYwf3jJfQqvPi4YZ18oYqmtUUXh//ZbeFvXYp2SIo/6/QoquVCoMR/feQD19bo3IRzya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794286; c=relaxed/simple;
	bh=pBbfXBaCjVTdvFIyj0xyIkrOIgzJkc6xwtHuCXjJCcc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LHb3/RnfSbgZ4KkcxOacTa/I7tOMw91nl2BIgCk+sO0D8TZgPvz4I0SW815/H0R1nJnMOsi2hVpPRnB8Zc5iZwgTpaFWpId1zhkShvQRVTJoCFTTImsgGm1d/k1+k8WMAiMSyt5DBoeGADx52i2z8N0g+0Pfu/WDfWx69cAVSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bDESYUSL; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756794279;
	bh=uB6NR5T09rE01HsYu8s5M59Wksdw4bQnffBeuOV1ES4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDESYUSLu+2TuktM0ZsRcRYV1jif773XQ7kne3EGYj7yEx7WYX4MbCEB6HlBibVxL
	 E6UpYX8TyaYwcVPBrL/OZbqJIHp13wlRF8VgAC4Gf8d8x6kEW6faWLgB9Cf8jAYsj+
	 I89xji8Rus3BzosTH6i8e9ZQR9jZE0I+9fkeZsfc=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 49A9E668; Tue, 02 Sep 2025 14:18:26 +0800
X-QQ-mid: xmsmtpt1756793906tl4rl611y
Message-ID: <tencent_5AE811A28781BE106AD6CDE59F4ADD2BFA06@qq.com>
X-QQ-XMAILINFO: MJf32pulH481+n/Cr6Lp1C4yYQG3St95t0GfTZFzAndZSE06OUtN65j3wTYkZL
	 c5461PizXJ+K07bdzjuReRwPmxs1Gw5mcb/PBObj8xchqdP7S/x3Wfgz58FSCEpSdn8QLHS8YVI+
	 LwqEfi8UNmTC0A9zJ14ls47zAuSwHCELueXBXPhcV+hRx9jQZCmL8b463tNuqjnm8ACvMCPTQFzt
	 Xa3QysDnf/hBUiFyK973IQfPFfv9RHiIKh+xuuj+SjRFbZUcqM8BLt0Aj44QLPUCOj84UgveQ80q
	 Q70DWMPK5QTBHY2bUm2WkD7T6Iu0rHnsOk5rlkfm43Fi4CH5zNgXr4SnsrHqIRN2AgpdsjGqRjJX
	 wWpPlXHBxK1IlbBYf5vVJ5cwTGdZywx/jqI2m2tiUsWC/+WO3nLv9BC/eaWFv7SRG/M7DJnJ9pMa
	 t2RVpZXDdmFaDTWCBHQ6+/EDut3xPw1aICuUmmu6j8I5pdkKNZzvWAwjRy+1BZZfPVhsVFnO+8kQ
	 fPKBXlQzlrBXm8B7WAW9xhiBlSffz3J3QyKTVxdn4Hr6oDs1sBU/p+cZeywnqHbM0oULTM7IylEa
	 7HIehKYni3EB/pls5cZ3UsFg9Xy++1fPMCcueVdxjyW5zf6smP1xN4UKFkUN380IIW6ZoYMN3svS
	 GAX3Ji6+me+2tq4uxsrtXCjW1jIayLL7/0p1nS9jl947GUIMahKGnSmb7oqeo8NYNxslpBxs0BdU
	 wCLLdBAS/+Ron7Ew2uh/1xJB8XjQ29D33aEGsMnKe3WENEFJPdLqRlhz8/NwdBzT+Hfu8+zO3X0x
	 PhFoGTwL30UostP7aqNNe+DXqHj1nJy37jFtlmrTJhU2Kfc1b6vGVIryzXj7qXdW7+SmfZlhbsA6
	 fLmYlqUhbdeHLxCTqr/c1kb5gwdJtkE4UVMS0JiyZEMwTY8SIygQPbL38QCaT2RpEQB5ZRs0M+ZX
	 gl7QONE7xjhJ9cx0k/0HTA/xPrFZOMTeQ8QxAU00W97x3VTRKO+IaztxM3wDW14by+fHp+rC5tsC
	 vglZkKjyfNjHeX334YNWuUbhrXfBjptTXZYSYZ4g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Subject: [PATCH bpf-next 1/2] bpf: add bpf_strcasecmp kfunc
Date: Tue,  2 Sep 2025 14:17:57 +0800
X-OQ-MSGID: <3fe33cfa3f596358f9b2e83b6ed6263f63350d1a.1756793624.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756793624.git.rongtao@cestc.cn>
References: <cover.1756793624.git.rongtao@cestc.cn>
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
 kernel/bpf/helpers.c | 56 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..e807a708e5fc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3349,20 +3349,7 @@ __bpf_kfunc void __bpf_trap(void)
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
+int __bpf_strcasecmp(const char *s1__ign, const char *s2__ign, bool ignore_case)
 {
 	char c1, c2;
 	int i;
@@ -3376,6 +3363,10 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
 		__get_kernel_nofault(&c1, s1__ign, char, err_out);
 		__get_kernel_nofault(&c2, s2__ign, char, err_out);
+		if (ignore_case) {
+			c1 = tolower(c1);
+			c2 = tolower(c2);
+		}
 		if (c1 != c2)
 			return c1 < c2 ? -1 : 1;
 		if (c1 == '\0')
@@ -3388,6 +3379,42 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
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


