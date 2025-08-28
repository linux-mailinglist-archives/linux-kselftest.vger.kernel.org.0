Return-Path: <linux-kselftest+bounces-40136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338BB39208
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 04:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E082D1C24FDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A572281520;
	Thu, 28 Aug 2025 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KwtwZNgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C16277036;
	Thu, 28 Aug 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349928; cv=none; b=oP/JjBEJ49caXAWk2bf4CqsZVSS5pJ89L1GhjPEGY70PRNGdDhHlTeVGKmzFpwiga0uaiAvkpt9WJ9aTIVvqcK+so9UrODE01gYm4j1nW8+pUfkHO1PvoA+ufkBKpXaCWjzcXrWuD6NxYGKPp4IlcvJjFLabfZIgAxY/6JWhHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349928; c=relaxed/simple;
	bh=9MlaewShrzwNP5cMPLBFY2qQOGWyYpp79Q4CAVUza28=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=X1z8F44HpTreXVRguFdF0ES/0HSh47bhlajMt9GMFL2fjPOhVmNkQuS6XKIv8tF0S0h2iUJeSJnvNBSwp4Jb5+mPbnUdUk7Yeoa261pmCT9Hq64qELKQMJ58rqaEGdDPNWxSwTGY2/XqiUjiUagr97SNF1CLOyNyN+i/TtrEKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KwtwZNgz; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756349617;
	bh=qD7BGCwe3Vj4PWN7gaUtbqxYjKU5h/fA619lif8uTXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KwtwZNgzcaF5Zxzb5vzCdl5pQyvLnSNmA1usWFZWBb5mdma6flLH32hzPz0ze60m5
	 z4OWvhEJ/MqsGsw1SJPXZytu1wHzKTv5Iuoo/tQQQWfQo77s2LEZm9644QNjj6LMqX
	 6f1SY9GSDF+rLoUsTy3I4dvxtuzMKKQKkQROMR4A=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id D5E218EC; Thu, 28 Aug 2025 10:53:30 +0800
X-QQ-mid: xmsmtpt1756349610tsimvv81o
Message-ID: <tencent_DF4DA83EEBFB9246E5E3357BB40911CCA005@qq.com>
X-QQ-XMAILINFO: MRb64KOzELYunc+ptYJ5Xg5rHPjjOlJVdWadpg+EZmUNNsWzuK8Ia1lYURXZ8O
	 fI3rkxQNjSl9NJGmnpcPAPTLtSEtV9bLyp+lobNjHJmfRKqKBLky2r7yVxHhp/trrRjezlfnINNV
	 L/Re3JsnuzrtGpTQu8Qa00msL9/2kuL76dH0vDHM+SvpzDNFI3aH3U9YAM5dYhr7zYVhssq31cKs
	 VcPVyxbaj3cjrKL8cSsfkPDM0myuzfudTa83FBfUJSnQsBmK0nbBbLqQLm6pz5Y4sMmcB1rMXJGU
	 I1K9sQ0SOxeMR64TM20TQ9VjWDkqZ7F8NCHWAW4KUT4mwBgMls7ypD1Bf2dwwlhlloebAxeqXGpV
	 7IzDdaRglNjs4nlrVE5+0IW3YIQZphTjmVb0FLa8XoZqgUocWUeO/zpVEu9o5Q5l5MUeskTucrl0
	 4a6+Tj2LpH90WGth9RKl6/Oj+95TC7mEVgZv7lQHXUwkVe+P56lJhA84kj/d3oUB/x5lM748mR2R
	 TGeozq+cZBWZ7B9mQSGVSLZ3+25p0/ozfmnydscxdbU5GTH5o2KdtNm1MVun+5UZFn8GB8rvjc4D
	 RTiXUNoWr00C+7rPgPm+wbMt5nLvtNQSrZzpMc11dQNITTIhT804MZXhl6wSvN6TR9iTplVH8LTZ
	 g5+CSJkYWyezg6J9t8GLlvpHAA4tSJzqAyg64+CbRnXZxxdG9MGrDM8aJXEWqkv5TXb/nnPYak97
	 /fkpNps91sMEOwJ8ztcSe7eNpcQRyLt7hSV3nasoSjkqQexgFlFgYVdN5ZXWQeXVGEFI/53tm5FF
	 ZrEhCiElRefm4eK3OFNvsE8F82jpiuXFYjiC5JSbrYMce1ydsjw716jRj2tflltRDmjG0uv/ttbM
	 A0OUr7PTN0hIsWT4X0YxS0DyJbk13q8C8IqPYH/v7t012aGdigdRslQtZs/9zNb8Arcxt5rTFOBP
	 qI3hdpQAKiWnB+nZutCHnI0eGz4siSB70OgVHTomywiHAYx0qHXJzOyQkni4/5wsBsVse+FTPdsx
	 S5Pce6MdVCs3keMuDzUYbPJEWrAyp+avy7liQ4/QufurC756S7iW6ptlx/Rlg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
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
	Viktor Malik <vmalik@redhat.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [bpf-next v2 1/2] bpf/helpers: bpf_strnstr: Exact match length
Date: Thu, 28 Aug 2025 10:53:13 +0800
X-OQ-MSGID: <e37d08a0e813eed1bc82777e11f3335a0c7672e7.1756348926.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756348926.git.rongtao@cestc.cn>
References: <cover.1756348926.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

strnstr should not treat the ending '\0' of s2 as a matching character,
otherwise the parameter 'len' will be meaningless, for example:

    1. bpf_strnstr("openat", "open", 4) = -ENOENT
    2. bpf_strnstr("openat", "open", 5) = 0

This patch makes (1) return 0, indicating a successful match.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..ced7132980fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3672,10 +3672,12 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
 			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
 			if (c2 == '\0')
 				return i;
+			if (i + j == len)
+				break;
 			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
 			if (c1 == '\0')
 				return -ENOENT;
-- 
2.51.0


