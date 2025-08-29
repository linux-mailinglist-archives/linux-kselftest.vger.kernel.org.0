Return-Path: <linux-kselftest+bounces-40319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5005CB3C0E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724941CC13D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D47334380;
	Fri, 29 Aug 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NbwESN74"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77673314B2;
	Fri, 29 Aug 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485447; cv=none; b=MgTQmE7WueELhbaK9dS/OVRwPhyuRkjxnXPacylCcRT0KnCmXWhJdIIwJNConoI4dZUjz3304l+QdSg9s0eqf+Xmbga0921pB4ovPD4/beice2pSINDB0ZipA1tvcx8aaXzLbUqWisVznreMHcjQDRFPuspYQBu+PM/Ja8SqkjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485447; c=relaxed/simple;
	bh=4wHktY6DHFdY+xD+GhsS4sye87rreTsHQxjhi0ccS6o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AkKhXm4jfFsYDD8EdFpltsGiAex0slK5FaVcUvgkE2R8dww5pVDBGwT2ihQ9H/BqwZepkBDZ0MhMkzhn49FKYz4uDHswI8LBmdKSDO9MIbQ+YGmI3hDs2JMyvetULqGCrGeXVIAWO6sWYjTLgL3UqQGJsQA3AFB/5jfxpmfjZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NbwESN74; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756485128;
	bh=9lMPK7bv9Da2muJbu9bcqZpUbnmhe13u74sy+205Rzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbwESN74ZttzvcJbRUksRuP+AUYuwjhqyUHdM2OoUAPUofDYbsvvFQJ687oiQ4tuB
	 pgDrl4dGJbwKj9Q3XRb4ALdWfZhRjbaIqFmsLebscyc2P7xfs4G71VDbArVbisJmQF
	 ph7TaoTk7S3nDTfTe7NPpk5IcinCckT3EukowPv4=
Received: from f41.lan ([240e:305:1bb6:7c10:7285:c2ff:fe86:1af4])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8051DCDF; Sat, 30 Aug 2025 00:32:05 +0800
X-QQ-mid: xmsmtpt1756485125t1yvonhzn
Message-ID: <tencent_17DC57B9D16BC443837021BEACE84B7C1507@qq.com>
X-QQ-XMAILINFO: No4GWyI4cWt6QF3uU9xq/26w4QzudC5a/i73zD7JO46WLb9S1IThh+HUE8sW24
	 joze17gTyF2Rs+nE0GSR9jHHZzJvFbkPQ838MZ1RDvmHFvU2lG0Zx0WwihjorxyFbVzpr4oSqvgu
	 zIr+jZzF7LUDpz2RK16bOcDJ6xxWR4RPJtuQNqhAYfMczQyjwT/rGaOIwnl33o/ELfvVT4rwPvOc
	 tCCv3J3Ma0aJ+b766Y9ydyKeE1QGcKqZy4vL6PdrpcVFTJjyitMsiGNjgW+3tJZ5tVs/x3TowLrS
	 Qk9vcoMRiZv4J/YaDX57VddXmj3PSP1SBXRew4La3aryCe6UewrJJmqHTGvhxba/JNg1/AUJZUpR
	 nq2F4FA2GUwi/J9aMFgrNZZjd3m9anSlf/K8dqbwkWujrB7L6eRfakSowhMRzX6XRIE9DCknoHOq
	 kv57tBrLREH2KbcJwEtVmEgAkt7BqeJLeYZ+AKMk5IoCO87wHy3f9hweUMuCqxTYTEVWYdhPdikd
	 qGcrW9Eyp0r9GrIbkS7TJAFpNL3TBK22NXLHCxxLgzzoIZy56xB5NeXD1zFHS8oJaBL3g6EyibSI
	 owGFFaWME4KTTBt3GQED4RBg/2sqPDJW3ZFxW4eD18gtArv7UNZUlPISrtFyHy0Qx7+VVvxWLytz
	 Sf8gQRr7lmv4Uo7fPNGUXoDbdlUR26GVVsr9vubqVN96O40d6LE4lFJ2HNt1BWadcYay3U02f3K1
	 239SaMs6biy5SYCE+W8w8Qvbp274oUzf2/6rW7GDxPXkkLW4Az0wiZQrh0+cNkGmdd5a7Aoqu+0t
	 2wqVtTBgQcEq/TgCmBj1t1gULgvDB72XT2yR0X1OQKnu05BqmZR5fBnwOz7UJ646ZT8aT9o56tdp
	 hcDKlYFPwRVsCT8EeKfD5FZ6Oj0D+yKUFCYHQd7BPo/ysUrSw8lC1n60s8Qv13A+h6dWd0ZgxJzf
	 kg08v7uRNPNc5lVmMKFGxf4F5JML3OSpZNkfhOTYh9Qa9oxSMHFaeWNm9dK+bJpzragMl3eOSzQF
	 sKU4hg3MvadHSctZoSGLSr3FjRUkCLGjHcz3xLUQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Subject: [PATCH bpf-next v5 1/2] bpf/helpers: bpf_strnstr: Exact match length
Date: Sat, 30 Aug 2025 00:31:58 +0800
X-OQ-MSGID: <929930bd35ed81b8962df55d93bb446a5df5f370.1756484762.git.rongtao@cestc.cn>
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

strnstr should not treat the ending '\0' of s2 as a matching character
if the parameter 'len' equal to s2 string length, for example:

    1. bpf_strnstr("openat", "open", 4) = -ENOENT
    2. bpf_strnstr("openat", "open", 5) = 0

This patch makes (1) return 0, fix just the `len == strlen(s2)` case.

And fix a more general case when s2 is a suffix of the first len
characters of s1.

Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..91ad124844ae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3672,10 +3672,17 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
 			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
 			if (c2 == '\0')
 				return i;
+			/**
+			 * We allow reading an extra byte from s2 (note the
+			 * `i + j <= len` above) to cover the case when s2 is
+			 * a suffix of the first len chars of s1.
+			 */
+			if (i + j == len)
+				break;
 			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
 			if (c1 == '\0')
 				return -ENOENT;
-- 
2.51.0


