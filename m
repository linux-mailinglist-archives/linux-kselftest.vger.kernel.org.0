Return-Path: <linux-kselftest+bounces-40251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC096B3B0C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 04:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A24D4659CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1F218AAB;
	Fri, 29 Aug 2025 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kyFZ8A9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A5216E23;
	Fri, 29 Aug 2025 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433587; cv=none; b=ov9zRt+uLOTUaNroM1R/R6r6rX8PrK7Kaa41bU8R2PGVbe15/qGpVzqHi3OT6wpWgOAvfJXZ/0toyVqZNZKihrkF6Fe5YZWRJTjGZuiHuw4ok4hLsCt2fNEW0i3vh5UHnCriqxNUniaHOfhlQPobhPgJD9y6zk469vL7Fscpm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433587; c=relaxed/simple;
	bh=r3NhNNsdcjyn2NydOe6LXmwIej9/2rxK2ZEu0sf6tyw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MIB/PTwOUqm2cHgnuzK9jf2VMgvTQUSZb+AqWXDt4iN7MC07Vgjhj3eq/Zugi0Ztak/vmooPebNfulA7C9pThQFEZo4PsSbqSgvH09rU6wX0KEZiiYg+nPsfzI2qTL620wPKFga8xNbojV/J+DyX58ZKp3ewHkS6nRGFJ3BMnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=kyFZ8A9B; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756433580;
	bh=wk9OTq2gPyfN5UN6D4SANjHxn6IM8+AcpCCFfjf/dF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyFZ8A9BmXiIy9bsJvmh5HYkQWC5qv1di3FttvfZty/mul7SN90/sEE95ZUFiHvgU
	 SWtSOsbUxm4Vg9fYigorFYhVNFCZwY2k5+kXYIy6AVHTgw/c4wC3prPDuwzFbID0j2
	 KXbzFrpLUQsHBrgrkI2MbqMPOybW7LK6KqmVgQl4=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 3380EED3; Fri, 29 Aug 2025 10:12:56 +0800
X-QQ-mid: xmsmtpt1756433576tegh0rgec
Message-ID: <tencent_CBD40091C14056E8298BE3725B65EE156405@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwOYEk1arIQnhW8S2wzUvYwqw4teA2hYMBcKJCU1BHTZe8/jlcg/
	 F5X9lVIzMlnttbVjrBvdpOINvNQ0yEUKGLg5+Syy+AwLMkGV6x9unUa2gm2W4IbLCE+KYajYyBK/
	 iulCmgZwCVP5Xk3eFbTX6ATqetdurobWe3qQrhgnoXUHC0bwjS79rbGNM4iscoRc967yggTw1e+i
	 TenQyXrUQ+d1Ix01YUi8W6BLlIk52mIlAopUSSCnQrq5KGI1IFBUlCY3u7WKkv2LOf6leHleVKdF
	 CBQksbUY4GQBFw4ZFFmq0CbpHyA+0pRuyTcjXS/oH/i0B7rgMIPIWC7ckgmWyCXX52g0FKHVXmUR
	 LtZFFs2Jr3byD8HoMm7dVzE1TueaOuXSCESBPAI5H1BDfFww7JWDn/AUcIWI0onBET3M4gtxmdS0
	 Nuyv9LNDTY3NcWM7dVvdyz5fC7/JPZdVWDEBdtJVPIWPnkpK9+K2zfLZDirhM4JdEjRCwaNky1ui
	 yMYOdWC5kJH9SwUYToJ6KBHtBZXp/cVT/2q070UMQzEulpZgWxcSFvkMeYHZQ3oORB+1eQ3i582o
	 KfnzYS2LAeEMkNJ0E+MypVCuV7Gz0ZN998d8+IIeM9Hj74N16CRD8Gp0WyPgmQCbrlc7EIuU+/Se
	 dgpXLEb0Dwv0AUAliLSJ8HbOM8itMGLuNAyqlDulb+QsZhkku3BOHC2HgBkzHEv7PDMmxWLCDkm2
	 QYytiKy2h9rpJUXSCCxOmPTL8+nxGS4EX4IKAOaezVSaNznDTWlN60vmS/r167wY9wOl1IzUyZZG
	 e3jSsgULRx5SPXa5XC9vW6l081KPUaHehDXSbMTKj7UmZzJXTqEV4LC/WP1JXnldysjVnusqSTwS
	 VAqCU5V+sqaUvJ1xjmMFphRsBy8YIN6v9X6nBN2pPBQ23kQloP5joPI30oVpK/5KrwqfX/rz5nK7
	 PiV3hjt9ee/r7amiYGCiOHA0ZR3LF0Rvb7sx/BXRqCZSThvkFc/GHPxQ2ijjm7c93D/5cdaM0wM1
	 nP6oD8TE6+SHeE7Bcf
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH bpf-next v4 1/2] bpf/helpers: bpf_strnstr: Exact match length
Date: Fri, 29 Aug 2025 10:12:41 +0800
X-OQ-MSGID: <4143fba2781e7fb72aac09fe893629bc2d08e826.1756433400.git.rongtao@cestc.cn>
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

strnstr should not treat the ending '\0' of s2 as a matching character
if the parameter 'len' equal to s2 string length, for example:

    1. bpf_strnstr("openat", "open", 4) = -ENOENT
    2. bpf_strnstr("openat", "open", 5) = 0

This patch makes (1) return 0, indicating a successful match.

Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..bf04881f96ec 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3672,10 +3672,18 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
 			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
 			if (c2 == '\0')
 				return i;
+			/**
+			 * corner case i+j==len to ensure that we matched
+			 * entire s2. for example, param len=3:
+			 *     s1: A B C D E F  -> i==1
+			 *     s2:   B C D      -> j==2
+			 */
+			if (i + j == len)
+				break;
 			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
 			if (c1 == '\0')
 				return -ENOENT;
-- 
2.51.0


