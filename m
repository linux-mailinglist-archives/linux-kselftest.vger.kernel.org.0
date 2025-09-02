Return-Path: <linux-kselftest+bounces-40522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2542B3F76B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABD43A928F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DA2E8B6E;
	Tue,  2 Sep 2025 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZINgGH3v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B52E7BA5;
	Tue,  2 Sep 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800048; cv=none; b=XRgwaUbQtMxXDaxYX6++9804KExMs5nmgoRvA63MfK/dgaiZycBwt+/xIoB7TRY9pRz8ROGl8IpA8KTTdX5aCWgXLCCcsFr2iUl6dwshgLHzAK+xb5Myx2mnEiApahhnel97qhI2eTPi6WheD/fcv5rraVW7uLd1gamkBFTmEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800048; c=relaxed/simple;
	bh=AnhWbFtadzDp+KVelZzMiEybBw+Cb3GyCRfsjMIZs84=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QcC8NMkO8Ngi7B/t8/4md7Tkm1weVXD0/U8jdEda/9NwIryZXjah+oZ/XWx71MIzfg/CFwxa6HidU6vzxj0xbUyQGKVfqL4s2vztDkc1EiFvw/+oGRZEJqVTMjimw/zs3jkq6z04Gh0UGpC8pLdX7ICQoKeSY0kHHs+04Qwz6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZINgGH3v; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756799740;
	bh=bCivpz+VqiYG4IHGqHshtomf2YaYzPPHc5KMtAgauvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZINgGH3vNLM7Cx+bBrnF3czAx9A61lOmYJ6daQlkkpCbbU441/5MWXrAlorNmZ4/P
	 c48bKJ3WOLR88t0v0dBN/Xj5r2ZbID+FILYGn39/e8vjjl0MvmifswPHnXOT/7nW1L
	 pi6P/IBd2rd8/xyj6/fl8d5RDqn1ns/Z/k0yyy6E=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id DE41E213; Tue, 02 Sep 2025 15:55:36 +0800
X-QQ-mid: xmsmtpt1756799736t6uu9cmny
Message-ID: <tencent_8646158457D4511C447C833B21B3ACF6CB07@qq.com>
X-QQ-XMAILINFO: N1JCMsqefaec/r8WWd6R0Q7caa5mpnhiJLlha23cEFJhuG0/Oe+O0/8X1Eb392
	 GGa7MB74IJk7VNUYzGLAXF/lVYur74FmXMRjfm+cUE/0ID+gKzayfO2StoDiQEepP1VKmfR0xjaJ
	 x7OfrgkLu2d/vjsct8/19cAGKboJB0eCanRoMDj3xR1vHCGF2lEu6xDa8GUWj/NyOtegeS6sg5bs
	 u1WjLYRa3WOL8UmQdo7MkI4nzc4bWel6FiZfZhp5ymax+1Mlh9EoqJIT7iii+tkm+OafgZyf/QwX
	 PylIj7ld23T72yIBFTDXN0bY2dLuim/BSzOKMIiTSpbzMh6dL7XuB4324VLKwviUp7+L1aXqI4i6
	 uvQUs0XzuvOE21Tj9isnSvcBStYqCi72dC0fjO/D/AeUEXQ2StqQ5Vmex+g9AGGIJ6AGlmmxeljI
	 sf63euQDNljMQp9dzs81z4222Pa6FfYr5s7uHEledJ89CO6CfDg0hasVYZYQGMLaeKz1oxaZsM0J
	 Q8e1YGQ7QDKJpxuftZiZwZx0W+Wn0pqaN3eLC/HSNhUyok+9fNdzp7uhXi32QpYcvy/jsQRWtlq1
	 aATIa5ipU04kJxyleUSAp9m+FyKeV2OPOz12WKYnILtMDu92d2gBeWur9lRrWBGtZQrAVe+n2/zI
	 Upl7dvCm33+E9Rw4Xxi0NFuo+Uces+oVLBV66SE6zvyI1nkEVSkUQIWmCn5u17jmkQgb511JgCB0
	 UjUUM3U37szNPtcWDv5DvFExqnsMi4Ondh50cJX7mzU4tPZ3mYV3DDQDsKICuAa4pl1+h6GT+drY
	 G9AXJ8aDYDz0M7H4l0Xy6tpSz5R5RRVPeKPF+aGhVLIMKOfjHzEXhH6853yNQ6OdCsMluBg6xOxs
	 uFdTOTO/6ezvYYhtXZifjP89HdxY9ZOW9XAqbYd34UpvUbAZxUbrUiLlzuewkRnhKHHcqBHdaIvV
	 qdd+qZWLKQZjIZHemxb5pkY6StJlsnrRIG0ie7F9SFtHj5oQlUX9KIDs4rchbBf36+2oqwIom8EL
	 2rn3D/K6ouu8e5o2OktrqtnTS6q9QP3Iqp8LSoJ2FXdIBps7/RPvH6kDLL778=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Subject: [PATCH bpf-next v2 1/2] bpf: add bpf_strcasecmp kfunc
Date: Tue,  2 Sep 2025 15:55:09 +0800
X-OQ-MSGID: <3dde314ef1772aa3ab9775bd3ca50518b5ba4cc3.1756798860.git.rtoax@foxmail.com>
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

bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
the case of the characters.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 68 +++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..238fd992c786 100644
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
+int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
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


