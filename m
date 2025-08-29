Return-Path: <linux-kselftest+bounces-40252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BAB3B0D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 04:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF587C2F08
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 02:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2280C1991B6;
	Fri, 29 Aug 2025 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="U/CInmZL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCA28695;
	Fri, 29 Aug 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433912; cv=none; b=giITnPWZ0s6GKlUjyF5RDMr4+JPGZfWdKYBn8X1l44Vfr3B0upTHJ5wQCWY0F9R0KJfou1SHzN8aK/+bZYkHIXs0EtZeOiRaOLntAP/VAyM3MyOUaD6Q/6psv2XZoWWpKzrgMnaK28TGnjO50gSolfLMhFa26k5EWyYieAXTeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433912; c=relaxed/simple;
	bh=3FypETjJEczaIGmMijvEDc/xAfE0ZqcMYaZH4REDzt0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=r4GRGPOegjKi9U9dhNrumgBJT2Iu+lNZyY1ifWy9DQc5FcOctDGo32oYDsI7bSUWTzEoBKC90VCrlxbbyI7JTYBzgcnrJ1b1oTNjWdJeE7UntAXWQmTrGDtMAvZZM6vjVyTMAhQQvpFNYsCP8peFEiHk7wEYSfZXEeUD16uj8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=U/CInmZL; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756433604;
	bh=rJtuwGlT+WPV2Vvq0c50CumyH88uEPIOv2YTXhzReaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/CInmZLQI3JccJ9cj9Rz+EsaqZKS+Dtm27HFEwY0MpxOMVTshin16aoXIi5X4K+3
	 P7RWnqYxeGxmxTJifURQ9y4AlU/HwzBE28AZjHYYvHnR76g9eS/PrupwjqzAywgXRV
	 76b8u9AYb3zf8U0T6j3kMWxy/Xz5+chVnLyMOhZ8=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 35393492; Fri, 29 Aug 2025 10:13:19 +0800
X-QQ-mid: xmsmtpt1756433599tz7lcuhs2
Message-ID: <tencent_C87CBC028E7A203219A80B3567555C22AA0A@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnJ+MY7+rhFJyHnalwM8DgbBOJb3RTQGmehqofKjUI8mHZt7ofju
	 wdsD0pp1b6G+yLN/TZYp5EZFWzp2moVueaQsXUgJc6WQMhg+fxK5uqBxZTnK1vbgVUBXm4f2BSfG
	 yNfXayx1pBQ1rbkMIg2wD7swwA3zkY7iT/WQQ/3Eh3R3t7pquMybsbGr1my5jpchXfyz1bchNwv1
	 VRt3zEDeUZv8Y3CsG0UiOU/NT725zoHf//cTSA7NcXIG5RrNVyfzmWqI+Ox1rkszjG03g6Nw2NRE
	 scN60Vw3DXNrON+ZrYKFuJVXt8gA9dsnqkhz7wca4XBDDpO72FkusRUXF7YYLH0fmHwwwa/H1fE3
	 NNr16k1RJ/G0kOnQ2+IZt1w2iJ5wL74N/mATqqsUWvr0XJWgxlNfXIoVOgdIpm8XJ7VDxBdsj5Ct
	 uFigujs7Ee73UFwxpmUlPtPF6G4za/b9KppCbUK7lnJLW4rt33Dpz8QhrYBrap2up0GqqZbJpQIa
	 lwCJvOmI0NWiIzmfQCbipK+gCgfTp8np6QVcYdql8KqCBgfoS7iU1u5+QHFSlvLycRlUHX0MZ63u
	 rXLfWkucZ1IXzj+vymtEQDq7iuU8OQV+wAmzSWhuvOmnAieuGLcP0Cf+XoWGwj8/iJaPuxr0GGUO
	 vB3254ZvrSwn7ZIqXvtAPKa93nGJ0KIoRH+pbqEYY+ETdIb5OAtyHKqioAOpc++fN+cCHkYvUo9B
	 jEUc3RMU7n4vO7yjOhson/jqIpvpEIuQARHR7yBB8KdA0cZXHOPBpliAWIdh+EY/2hDLpn2ycABW
	 9oAaieQobx1Gm9oJCK0xhD2S3XFYlr1sXbcpx+6wl3LHzP6jGW6zVVpUDRGoslHFXCE/WJVzJW/L
	 /VCBJRQp446Dt7wm3MaY/c9UcgvO97ENn9imKSY8lhTILrJwLxUoeqzO/utVY9q88wW3a19Ee3kH
	 o/uC/qsyy8Q60e5PdEbEuqsCAL6x8ZJH0R8O5WH285VlQucxkovW3BlSjET6tX8IWQJeDQYmLujF
	 xDqrnK0w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	vmalik@redhat.com
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add tests for bpf_strnstr
Date: Fri, 29 Aug 2025 10:13:04 +0800
X-OQ-MSGID: <7f5f99975eb5ffd611cdc69ac5e9738bb4e91248.1756433400.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756433400.git.rongtao@cestc.cn>
References: <cover.1756433400.git.rongtao@cestc.cn>
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


