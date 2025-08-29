Return-Path: <linux-kselftest+bounces-40320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFAB3C0ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B2E3BE27A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B043314A7;
	Fri, 29 Aug 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ex1BE6mV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAE32C30B;
	Fri, 29 Aug 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485532; cv=none; b=ZxZmGTKerj5Ne2RNGnnpehdGJElGrmZZkLyeVKlzRv7QU6cHbR/lakNPSUb8BYYWOM3kQNuzMNtpknplBoyF40bpn2TIj7u8/dqvHIZAnwtA4yNO3qJpNTRVlHfZ2ihz66mNTMlJbd/mo0P9HALa8WYnzpI1ScrhrjpQU7YcZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485532; c=relaxed/simple;
	bh=3FypETjJEczaIGmMijvEDc/xAfE0ZqcMYaZH4REDzt0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RfyeaZ1cSai4YJNqFcGgJP07epCwG6bloVc2lkqbL8qekhlGEqdEg5MFFENqFaFodTjMYNWJHJteDeZhIOvIyKcYikvUugHLW2H+ICLfE47Luw3wTWR6uLVJFtoETmyS2iE7dVstM7IbJT6t32TU22aPQymbGHeUNf8BIFOm9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ex1BE6mV; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756485522;
	bh=rJtuwGlT+WPV2Vvq0c50CumyH88uEPIOv2YTXhzReaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ex1BE6mVteOEROu+w99GcNKfNoj9HjNtm5kejmOkeAwJv2tsmeNU++nPbXOtQcYGL
	 HMdCp083lUjaFqzDJqxrM8+kPfisK4MKKtAcd7872XFEHdsKJecR63RmTZJawSqdk+
	 GnUiG3zcuAd3NLVmdfK3Dj16MtSs+xeeyLC+f4V4=
Received: from f41.lan ([240e:305:1bb6:7c10:7285:c2ff:fe86:1af4])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 8132B652; Sat, 30 Aug 2025 00:32:19 +0800
X-QQ-mid: xmsmtpt1756485139tsqlraqb4
Message-ID: <tencent_2ED218F8082565C95D86A804BDDA8DBA200A@qq.com>
X-QQ-XMAILINFO: Nz6nvCBXF1ZFc1n9RbBfo0e7u7VtNKcl2N2A2MhqZsw203jPcjyGpMP5iZRq7x
	 GY7a/AYfx161v8hmKvRURPLELjkR5W80aMu/5MxabOor30hGkqWitmmR9K4pT0zBmpiPNm8dNqSO
	 WEgs6TXXsxNq3c6nn5p1BfxxRXZiJez55rlDJ2McCmKK25zjlqoDjHjR51FcORLJUuumIekEYCO3
	 5oA5Q1XcH0MM7Jd0BCF0et6pnYX8ggIUsilVevFuwWWBrftMU6U9ZEPsh1P77sizz4X3FjFKFj5X
	 aZFA07fCzx+gXMiD2zeU7FH3AZbcEvZSzkcGNCGMCfUmTT8TXNT3xyeWmyPNLmDbJsVsr+vPEJxY
	 8onL4oKZo4YQzc4AQ62Sokwckg4pFV15CTf2UJ96J3yg4XiaxOqafoEDOk2Oj5+IwGoUL9W7f9NV
	 EWBLzsEmfOE4sqmQ2eakZAREPjiIIwtstUK16xvtfP98lLtSZ91zTcihM/IAXVuzgXPHzm3tdJxT
	 mKb5pxV7YLIFja5vsCEIKfYOOudSmgFr6UQBFxJGIDpCo6iuQarg9EqVTTwIc4C0H9gkmm8UlC+9
	 po9l4fLPP7eKPo75sDO1cHUr/csPhVjVZgjXODwE2JGykzQNxjAkAPpojyakMQdu2wbnQkgErpoR
	 G4/rBohsR/6GTK7th05th+/+SxyTVzRzD/imoCb6GAArlXrZxAUgSDbQzxwI2doo7zx07EBuX8qe
	 g2Fbr14GnGbpNOJUv8Ie5oDjv1uq9yitu45kzLVYpUGbP5HU06l4FQScRG+qN/yfvLisbddLjJSr
	 kmK+hZ20Ue1guOJielcC/9rWlIIM6CqpF6F0pctOjs7N5HcH8JuSAbpGCjqTaNVv0NOB8/NpVWJu
	 8Zz+mwRyNfp2sxdEufQYGaEXnrPuw1JHzX7SFE+VhoPnMgDn8HZxoYhDOO+BaVBMoz4M/ce0nRlK
	 nBd24qN0QRe3aDTLq9sFNQlAon6IDU96orqAxK1uTy6xkkxotWDn9uOjH8K49WCqPShfoAnHbNa5
	 esT7xf6fcY+fDIZhw4jlb6REdFXgwSQEil1zHnVb7pQIN49tIfh4FSSgztKhx+8BqWFDnGLQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>,
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
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests for bpf_strnstr
Date: Sat, 30 Aug 2025 00:32:13 +0800
X-OQ-MSGID: <e13d6916f7184a04a167d2d94db5bb10fc15537e.1756484762.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756484762.git.rongtao@cestc.cn>
References: <cover.1756484762.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add tests for bpf_strnstr():

    bpf_strnstr("", "", 0) = 0
    bpf_strnstr("hello world", "hello", 5) = 0
    bpf_strnstr(str, "hello", 4) = -ENOENT
    bpf_strnstr("", "a", 0) = -ENOENT

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index 46697f381878..a47690174e0e 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -30,8 +30,12 @@ __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
 __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
 __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
 __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
-__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 6); }
-__test(-ENOENT) int test_strnstr_notfound(void *ctx) { return bpf_strnstr(str, "hi", 10); }
+__test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", "", 0); }
+__test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "hello", 5); }
+__test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "hello", 6); }
+__test(-ENOENT) int test_strnstr_notfound1(void *ctx) { return bpf_strnstr(str, "hi", 10); }
+__test(-ENOENT) int test_strnstr_notfound2(void *ctx) { return bpf_strnstr(str, "hello", 4); }
+__test(-ENOENT) int test_strnstr_notfound3(void *ctx) { return bpf_strnstr("", "a", 0); }
 __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
 
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


