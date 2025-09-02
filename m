Return-Path: <linux-kselftest+bounces-40504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D25B3F564
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A83203FA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663D2E36E3;
	Tue,  2 Sep 2025 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tkzdtSHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02682E3373;
	Tue,  2 Sep 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794247; cv=none; b=QcpT2BcWmW9G9eFtY79WnZyxDV0dMBVOhY+VBZoJd05EE8Jfc6Zt8NFoT5zTQ5O1+38k6CvZnGVykdkGINdAP0ALmiIkaLKHTqj8gmSzYX02kOZ4tFUVXyQOn4IWADZ9c1Wy5lmVWNgETdh9i+ov1DH6KtoEakhTiFMbAdP+sxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794247; c=relaxed/simple;
	bh=LVB94l7OIqO0HP/kAtDPp8pMZNK+I+FVVI6efuDsYHA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=THEehUh72RluneL+ZSvJKBoW5dbmV8cqlw6hBUEsb3DGzkRV/ggY88SNrF0r94WmxhW91tmqMawdSND5fnoDrQH9XfNPS1Fbm0pKEt2BFlSm/SmcaZBBlUQFlYUstWePMUo3GMWDX5AnB+6nrE2XU69KYn6YVMPqTKynhUubowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tkzdtSHF; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756793941;
	bh=GI0eUTf/hMdcFnYu4tIUQhlf6BEb4nTzRS3IPbwEns4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tkzdtSHFrpfsG82Z9QibZ5JBdmeFgCyrjGlHWEV3nFkaY0eNa6y625gQzg97Cl6A+
	 01rwzYKdI8h3I67ptkMw43kNcQbLfR2mW/SjPzH+8pCoFjLFDCrXQvH41u624YWkPr
	 S+gyuaOCtgiIHolT5S9oClYQyuckAunVRgU4kRt0=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 4B9200C5; Tue, 02 Sep 2025 14:18:57 +0800
X-QQ-mid: xmsmtpt1756793937t9zzjdmof
Message-ID: <tencent_4142FE591497F42A5FAF5EA36A8861068708@qq.com>
X-QQ-XMAILINFO: Nwl7PuG5jlSkoyEuDKoEHKe/JOaSucJxIXrvzTSn3T2JafyMErWHfroOgk8ykX
	 TSzbqiYvemk3nLO7nDgk6pAlHV3BJreRjmGVieJC/x7uFAw7qZodQdo6iSOFhoGpb1/z+bhmoo5c
	 E148nDhTTIVFEpFtTVsnseRYmEbxnL29RHNTmZqm0tDopO2Jbed9EzxjVKNPVHeHhMXc4sd0d+lr
	 61Uc4PpwAUJl8xrwjpdR0kJHe1UryTBkeuEwgL15ueb9p3epHxYXJa/UxxM/6YzyQ+87t2qYyBzg
	 rXoM3yt6AxaDxWs8FqdwfvqpKIypWQWkdf57yMeizW3aovkZfyzlLD6SN480uj3yof7KecY2h31Z
	 XFNcyIconvUKhy4pUx5HaOhCmeEKR5B8HNdhk5cB1SMAID/9EziGH/y8bLcrgLOK9psafRzGFm0J
	 uEmo7XqDkbb4g49LqacB7wuHUp1SiPO1q6MWWBnkjbyY9T1vMEm6JTUmsX3gBOAkcaWs370ziE63
	 2an6f4yi1hlPYruSr5EgCXhEaHw7ufHiPbg/j3vDDAnstXgA1V2O8SLjWZhyQG8no0nZ67E4iio/
	 J1YwYoivNRgZOxYI2pctkHHPirMNmbsYv4H78wyt/AAOY8yYuXuu25BvwaB2nkOHYCUr0zMjqPEx
	 JfUCkUhZB4AGoH2eVCr9/tlZyN+6pDv6HMZ2r6CZnSNcwAddnxtKu4sLXluyAq5seLUc9JIHQSf8
	 Btp84paL0P4EpqpaDZPud0q8FfRGCrj7iFAcdcNeNPeWK9PPiXcLJM6sNYVgqJevulMuIAO6R4dG
	 J/gGnQCuGv6s/3c+sdHlkrf1/w1DTtv/1jz8pivKruV60TF4dXWs6HpPfxXVpgBRY8XubvqJAJhm
	 L+5HAdnjus8Qm8daOVljlueKa3zzmS8wpNatpQ3AcOo3Lfs3Gf3yLGgc+ZOiMEETyUA3IEUvn6g3
	 tTIMPUs5W95dEI9EKvK6KVwvLepyPq/iFtwM378/F3UguckWJVShUd0a2gvZpfJ4AXREmYZxw5Yx
	 yRmRRN3GCK8hL6C7oIuXaWBVnCxk7j3PSRf2l3yQ==
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
Date: Tue,  2 Sep 2025 14:18:34 +0800
X-OQ-MSGID: <7b7ace1a1b57c21e4ab92b1828397e7d0dd84200.1756793624.git.rongtao@cestc.cn>
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

Add testsuites for kfunc bpf_strcasecmp.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index 53af438bd998..99d72c68f76a 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -31,6 +31,8 @@ char *invalid_kern_ptr = (char *)-1;
 /* Passing NULL to string kfuncs (treated as a userspace ptr) */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
@@ -49,6 +51,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return
 /* Passing userspace ptr to string kfuncs */
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
@@ -69,6 +73,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { re
 /* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
 SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
 SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
+SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
 SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index 46697f381878..67830456637b 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -12,6 +12,11 @@ char str[] = "hello world";
 /* Functional tests */
 __test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
 __test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
+__test(0) int test_strcasecmp_eq1(void *ctx) { return bpf_strcasecmp(str, "hello world"); }
+__test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO WORLD"); }
+__test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
+__test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
+__test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
 __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
 __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
 __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
-- 
2.51.0


