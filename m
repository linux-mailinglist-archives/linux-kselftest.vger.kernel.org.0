Return-Path: <linux-kselftest+bounces-7363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCAE89B1DC
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5617928153D
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D171130486;
	Sun,  7 Apr 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgngkJMr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F212FF9C;
	Sun,  7 Apr 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495617; cv=none; b=KD2XgNGj7H4Y4784/6pgr1vnOHHQvIrWrnPSwpliCfVoQ79VuIcrPre4oyesywQmpWtqtxCP5fBV1qNPB9FgIHMGibOwY1OlowdFelEWvUx9ZYD40jmM/Y913KdFSC+VvlwUtSf/JEcX/So4tyzwxutFa/2m3qpYFA7Vn3AfTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495617; c=relaxed/simple;
	bh=c8XQeQwtEltbFX6HkBYB9bg5rHyG3/SpOdtdE31OSls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdKV7rqup8XEZY9DwAiG5Pf7UkuSmF3YmZWHHCDGQ9o3YTdu7PTfwA+Mad0gTxKxhtQjQdfvdre0gAQlP90KuSMvWlybnxYii8T2s5QLPQ55N8Gf0fgbXqpafpHlJDQmCz1Rw0OSzsZsjY35/NSA2t4/iWRV+DCLLpfwjxbR7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgngkJMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0E7C433F1;
	Sun,  7 Apr 2024 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495617;
	bh=c8XQeQwtEltbFX6HkBYB9bg5rHyG3/SpOdtdE31OSls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgngkJMrLMz3SCoa0HajWFAbNyv6O8uOr3bYSQMxs4it+J68qDyvLBLZ4rgEKMSjZ
	 wyVZJB9d3ZTBQTlM3EYFUG6hN55fJxJVohCESczt3kfEED1C8oMYvHAJqlK9PQBr84
	 Jf5ZTgHAfqt9y02DrbZDOeByDKM8FgrNyIeey96erk1z73QVqieAiJ/nU56TedVBqw
	 xrNtHN08riQGjIJwye6I3ki4bMWtaARZKCTyZ80kTetojoVyzq73y2qC1/TIkBo+Q1
	 p1p24jK/yM2SPAmOmvPwZ0Wn0d5+jzFuF4mkpRnjfeXK0JODsAo8w2dCA0IiZVYaId
	 m2+EE8lxuiLWw==
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
Subject: [PATCH AUTOSEL 6.1 12/13] bpf: Check bloom filter map value size
Date: Sun,  7 Apr 2024 09:13:11 -0400
Message-ID: <20240407131316.1052393-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
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
index 48ee750849f25..78e810f49c445 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -88,6 +88,18 @@ static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key
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
@@ -196,6 +208,7 @@ static int bloom_map_check_btf(const struct bpf_map *map,
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


