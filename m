Return-Path: <linux-kselftest+bounces-40155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E85B396A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841D93B8A54
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F92E040F;
	Thu, 28 Aug 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I3Ew/0dV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC5C27146E;
	Thu, 28 Aug 2025 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368958; cv=none; b=Vuxzb9ZlnxcTBIH7g3gj9mqFwtu4bfFCWTZMAjct4fYPkg+ufejvIqqeegjJQ/sQK2zrqLoJPSFrOlFxz+jpUV7q1PXMDtdrEgEv1jpM7psdFwjIIb6hMudZZSEaqDkcDmsfK4EiZCr7s5225cun7Q5cKOvIuUt2V9bN9jZNNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368958; c=relaxed/simple;
	bh=iww3BoikQK/TKxPAwWj0XgPz8nHnacH9Xa2ReLCRlyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URhXfi/NkDXnQ4lgEoCqKLRjA7Y4J1sc8fsPnmPbIL6Cz4gZLIFSGLBUDyWgzoXqgq6Zsk/XFb6Ep66YeAwHoS/hy3mevMpdDFiKstLQeBz2k8lDOjYa6d/TJQG8GIFQ7ftiIs3I7UQaCXBmJtrI3pjS4K8oDROEnfONL8Ak0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I3Ew/0dV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7q
	PRyyd+a2kmu0JBoOy17OReoQfUlI+/Ks6s1wzM9kI=; b=I3Ew/0dVFwrzBp4tbv
	NbbHIFvmvalJM0Q10XXYdXop6f00lqYkp47ukQaDp54ll+FSQ7nGms0IBVMa+rxn
	vH7oIhX4mrYLXXmUM/+tfZ+wjEuRgMmhdixbTCaSOaCKxUqqpW4M9jU6Y+ZdaOm7
	D4gXmjUe9hvkky3pJGE5F0nr0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBH9SgLELBo_0uDAw--.3263S2;
	Thu, 28 Aug 2025 16:15:08 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix the issue where the error code is 0
Date: Thu, 28 Aug 2025 16:15:07 +0800
Message-Id: <20250828081507.1380218-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBH9SgLELBo_0uDAw--.3263S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW7WryUKF4UGrW3tw1UZFb_yoW8GF4DpF
	40gw4jkrs0qF45Xa18Xw4UuF40gr1vv345Gw1DGa4Yvrn5WryxXr1xKFy3uFn8GrWFv3ya
	yasFgryru34UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUpnQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipRq3eGivvL97sQABs-

From: Feng Yang <yangfeng@kylinos.cn>

The error message printed here only uses the previous err value,
which results in it being printed as 0.
When bpf_map__attach_struct_ops encounters an error,
it uses libbpf_err_ptr(err) to set errno = -err and returns NULL.
Therefore, strerror(errno) can be used to fix this issue.

Fix before:
run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilogue: err=0

Fix after:
run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilogue: Bad file descriptor

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index f361c8aa1daf..686a7d7f87b1 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1008,8 +1008,8 @@ void run_subtest(struct test_loader *tester,
 			}
 			link = bpf_map__attach_struct_ops(map);
 			if (!link) {
-				PRINT_FAIL("bpf_map__attach_struct_ops failed for map %s: err=%d\n",
-					   bpf_map__name(map), err);
+				PRINT_FAIL("bpf_map__attach_struct_ops failed for map %s: %s\n",
+					   bpf_map__name(map), strerror(errno));
 				goto tobj_cleanup;
 			}
 			links[links_cnt++] = link;
-- 
2.27.0


