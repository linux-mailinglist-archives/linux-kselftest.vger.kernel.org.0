Return-Path: <linux-kselftest+bounces-7361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7C89B1B0
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463471F21EB8
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB086AF4;
	Sun,  7 Apr 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daBV+8YH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9398662A;
	Sun,  7 Apr 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495587; cv=none; b=ipN6V1CstPp+/BD/jIxYzoqFGqe53IscSi60Os6jSpRX8tPwmsBF1MZKbNGVPempgZkk+84W0r9e/antH6Il1jqwPcwTICeD426exHcgMD1aMrsOQS7o3D4N14Ooaz1aExrGOBLEvhJHycK8MWZ7Tdf6h77yAscLHidpw/uarJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495587; c=relaxed/simple;
	bh=9CJNlSm7UdFGd3F3/J22Rexp6lW1kYdcgxWT5Q7WTEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZ1zLOf2QVQ5PsI4AHzwxsVRSLghuT1wYw6tOjkwiqIW/mBoX8Abw8az6WHCTE232Mu5pMhZqgbU3xe2bOegDPGbJ9CGBqgsIo7vVF4tq3LO5ofTq+6OmwAU236EBWDZidAnh7UGEt25lJtywuCn3jmqRGsFAbgsikKvthoazT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daBV+8YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA633C433C7;
	Sun,  7 Apr 2024 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495587;
	bh=9CJNlSm7UdFGd3F3/J22Rexp6lW1kYdcgxWT5Q7WTEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daBV+8YHCVPAb/i5ufo92Xboixqi09Q2Axd1nZOmQBk3KMUBPu6qTpUw4aFdoN/jh
	 WLA9qje0faRaKDhjZgMwEhQot5ypQhL2dRGjnjHqfkewfbCgiN/pBkRSnpyrytPhr4
	 lOA/mu/F9vdNiSkf8aFwUMjQ6uESqhOUhO5NuMDdTxLiumgnIrMcYepkgeu7wGbdnv
	 aqq8FBQgqk5IBQYP+CO7OrJvbR/mjff5wIUT+yzlhiP2mPDf67HqoIBucZElvuJVJF
	 SIvsrzoqzc556ZMGMCcWTDgX8OauMLKAcOE1rNUAS4apHJixq7C0QxV/GmTBvOcdTA
	 3jA+C1+Y5bJcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/22] bpf: Check bloom filter map value size
Date: Sun,  7 Apr 2024 09:12:19 -0400
Message-ID: <20240407131231.1051652-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Andrei Matei <andreimatei1@gmail.com>

[ Upstream commit a8d89feba7e54e691ca7c4efc2a6264fa83f3687 ]

This patch adds a missing check to bloom filter creating, rejecting
values above KMALLOC_MAX_SIZE. This brings the bloom map in line with
many other map types.

The lack of this protection can cause kernel crashes for value sizes
that overflow int's. Such a crash was caught by syzkaller. The next
patch adds more guard-rails at a lower level.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240327024245.318299-2-andreimatei1@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bloom_filter.c                           | 13 +++++++++++++
 .../selftests/bpf/prog_tests/bloom_filter_map.c     |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index addf3dd57b59b..35e1ddca74d21 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -80,6 +80,18 @@ static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return -EOPNOTSUPP;
 }
 
+/* Called from syscall */
+static int bloom_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->value_size > KMALLOC_MAX_SIZE)
+		/* if value_size is bigger, the user space won't be able to
+		 * access the elements.
+		 */
+		return -E2BIG;
+
+	return 0;
+}
+
 static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 {
 	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
@@ -191,6 +203,7 @@ static u64 bloom_map_mem_usage(const struct bpf_map *map)
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bloom_map_alloc_check,
 	.map_alloc = bloom_map_alloc,
 	.map_free = bloom_map_free,
 	.map_get_next_key = bloom_map_get_next_key,
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index d2d9e965eba59..f79815b7e951b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 
 #include <sys/syscall.h>
+#include <limits.h>
 #include <test_progs.h>
 #include "bloom_filter_map.skel.h"
 
@@ -21,6 +22,11 @@ static void test_fail_cases(void)
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value size 0"))
 		close(fd);
 
+	/* Invalid value size: too big */
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, INT32_MAX, 100, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value too large"))
+		close(fd);
+
 	/* Invalid max entries size */
 	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 0, NULL);
 	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid max entries size"))
-- 
2.43.0


