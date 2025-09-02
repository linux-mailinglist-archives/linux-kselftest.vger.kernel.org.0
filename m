Return-Path: <linux-kselftest+bounces-40542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783AB3FAC7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D0D3A4F0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717C2EAB81;
	Tue,  2 Sep 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ydplr6KJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD227FD40;
	Tue,  2 Sep 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805856; cv=none; b=UuSFW4ZvJ1FLoBYbS4ynMOFhj2J074+NoESGb4WhAKLLsqEsrkons6TF9gCepeuBNNPeIzc2sfYvjxOzsJWeJxC+phtUb5FShw+A099TWi4gfmOlTDJzBtWA71wMbzTIyd199f+AQOGScdJ11W/Vnh30acRQFJ5Rldo5ic0eK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805856; c=relaxed/simple;
	bh=AnhWbFtadzDp+KVelZzMiEybBw+Cb3GyCRfsjMIZs84=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qv4z2jATiZ0nCTAoyjLiENMdVUKgZyrdzjHVtWeNkj1WDA/gK3ULoJnVLb0sTH5QfkOOWqV+bpocC/TS/sZM6NnDxRmUY6skPBBdac1UAIAvjlDqO92k2DO15eqsjQxmQKC+DhNWpwF5lRTItqD8aTHozVCWRrpO2xa+BuCXWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ydplr6KJ; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756805844;
	bh=bCivpz+VqiYG4IHGqHshtomf2YaYzPPHc5KMtAgauvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ydplr6KJPSr/Mq12+O66TousMFNNCf0f0LYpvhQd+V5wPLxUeyT8yITJi/i0PdQ/D
	 TyVHG6wrjDREONc4wpC2nKtg81byFV9amV8iFAo8H8psBXEfwujan/lMFzo/OsWMd6
	 ETYBz44AnC4Ah4qqVNADRe6GzuZtdJz2EqnV+YCU=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 4E221C18; Tue, 02 Sep 2025 17:19:34 +0800
X-QQ-mid: xmsmtpt1756804774tavdqsaey
Message-ID: <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuGjBNB9O1B8NwOUeqXuYKkCBNNmBpv809JwDDN4Oj0bGjtbAKLW
	 aQAmwHvBZ5motSgKCFOWzQWRhD+MwS9SAim0HZkzsIvV7S0YUs9yWU/dW2gGXztTohO+zwlwTi5R
	 mMkQ8wf2wTjWgzMSV/vy02Cz+kF1SC6ImhwiB6hbpZo/4QKzesKdBcOK/yfUoNvuTBMhxdmvgeAS
	 0ay/Q6ftlCtlyUdtJu9cZf3VOXaYATzBsePaTv3s8jUHLLJjfVAoThgLH1amV+d9T6Mk8SOVOmyz
	 vX0dSMo6YIrkvQURWOsh3r6ZvGLi8aLunv+n0PoE/6J7FkfBeAtBXvdWlXM9mJrw0FHkrOc2WaZQ
	 8xjo97XwtlPcCQKcnCDjDLXw3fWGEzboiF8iGTSXV3uAzhWITuuqve9TQURrvkn09jDtMiI7COs0
	 OItpkD/VVc7qjoArUsINNQuNblGMEGCdYnteS9sLwXpCfFSouhefNVCpIML7hmmuG7vztyA90Zo7
	 XJ4/dV8EfQ0O8RXee0S2JvE8xxeS/kTVsP4woJwSTrkYTQAB9HGRhLvT1vDxr6KBtDix1VV0RyFG
	 BfCVp4OYCZFGp+0Wc1Tv5kM9iNJZcc7lF55hpom1zaUeO8M38AeG2pcd+QtzFB5kmCNXh1wB0fWM
	 S6G5qiwbSkVojCgEdeLPv2+Bv496jT0TJZ5IG/D3R7oMZUldRaPRL38N/6Ul2kb6E1wqRKoU3c2R
	 hltLsdfJAsfUSBkieO9mxf0PJm/RU4czBeLIE4mAx0lV3YZlCP8WPYTN5kEcnn6Tm80Q/2fIaUxn
	 sPD8xbdfNEXJFvDpuKoFaI9ezoFR/2lDw84zAPXK4SRVjj97VVaLB3VmpJipYA9aj0PEfO738w8d
	 /N54F6OIUuSeFKmw8XZJRXAokdJtREdEQNYocKSkAtLo1NviWg58vemssosTHWHGCTvb30YBd2Lc
	 Wl70sDPUfSbIXlN0UKVptQlxgUkG3uteLSrCzQTCtObNusKfTwn4TpjYU7u+4nmBGohUGpROHRZB
	 wt/Aw+k81E6d6O+hAPYpXk0Jyg+v20ZSvWJGGWl4LTJTqviBVcgmQmDQDcPb7Vq5KudBXSWE3GEa
	 Tmd5qY6InMTro04MVUauOTmwDOZ/c0O6LUbZma
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasecmp kfunc
Date: Tue,  2 Sep 2025 17:19:03 +0800
X-OQ-MSGID: <3dde314ef1772aa3ab9775bd3ca50518b5ba4cc3.1756804522.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756804522.git.rtoax@foxmail.com>
References: <cover.1756804522.git.rtoax@foxmail.com>
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


