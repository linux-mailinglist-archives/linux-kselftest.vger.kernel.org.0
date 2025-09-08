Return-Path: <linux-kselftest+bounces-40915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F089B483EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 08:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72CB16D119
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83721C9E1;
	Mon,  8 Sep 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RIuwxGtp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B820BA42;
	Mon,  8 Sep 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311824; cv=none; b=nQsrCaW8wjfE8ZzLSMOeXNqQd7pxSy8pI14kT9HQq1zLCzNF2xEfFxaidZbx9+DAkL1zcN/XJySiy9lsHubC9wlkG8afbzuWqjE+kZ07e/0Q/L4iqpGXD97KOYFdgGeJhRsTv/3ZsGHBAUxX/H6xWEwoQKKJll0naRgfXsF9SGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311824; c=relaxed/simple;
	bh=IgnxBFQ2ZnuUmZ8Ld9oKivTL8UCPcnZEYnZOWY2PUY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hnUP9vsY9FQjA4PtXo3+fxPPFL3IHP26nAzomlYtBUTIwB2STr8iA2v9hUbTopuXGTfWvIrlu16fTETBGjz4PavzsCb/lWHU43RyBADT5cdLNiN1myiRkctADH4FVp3oFzAF/iFWC1lSufmfkynBd34wslRu3kbcbjOsBa1PvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RIuwxGtp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G1
	RdfIYRkYAJz7zG2EzLoJ6HbpoIeBn2pLcgZL/fpPU=; b=RIuwxGtp8L/lbZ3SDi
	M7mWfs59GTQtQmY81lctgmquCu0zIWCHPs5JX3kW5MxcjSIZRZnfnpd93TucElrV
	M/FDYljcxu478wCl4kFDPgqNuY9FIYZbmPjcbxVS5CL1UXAXKgmH+AuLbrUhFsWr
	OO7xkqlonD2E7qY1PBXP0Dd6k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB3iU_Kcr5oIivXHQ--.14510S2;
	Mon, 08 Sep 2025 14:08:13 +0800 (CST)
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
Subject: [PATCH v3 bpf-next] selftests/bpf: Fix the issue where the error code is 0
Date: Mon,  8 Sep 2025 14:08:10 +0800
Message-Id: <20250908060810.1054341-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3iU_Kcr5oIivXHQ--.14510S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW7WryUKF4UGw1rGF1fCrg_yoW8WF4Upa
	y0gw40kr4rXr15Xa18Ww4UuFW0gws5X34rWwnFya4Yvrn5WryxXr1xtF43uFn8WrZ0vw4a
	yasFgr18Z34UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj_M-UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZRLCeGi+cORAKAAAsn

From: Feng Yang <yangfeng@kylinos.cn>

The error message printed here only uses the previous err value,
which results in it being printed as 0.
When bpf_map__attach_struct_ops encounters an error,
it uses libbpf_err_ptr(err) to set errno = -err and returns NULL.
Therefore, Using -errno can fix this issue.

Fix before:
run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilogue: err=0

Fix after:
run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilogue: err=-9

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v3:
- Use -errno here directly, thanks: Andrii Nakryiko.
- Link to v2: https://lore.kernel.org/all/20250829014125.198653-1-yangfeng59949@163.com/
---
Changes in v2:
- Use libbpf_get_error, thanks: Alexei Starovoitov.
- Link to v1: https://lore.kernel.org/all/20250828081507.1380218-1-yangfeng59949@163.com/
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 78423cf89e01..33d59c093a27 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1083,7 +1083,7 @@ void run_subtest(struct test_loader *tester,
 			link = bpf_map__attach_struct_ops(map);
 			if (!link) {
 				PRINT_FAIL("bpf_map__attach_struct_ops failed for map %s: err=%d\n",
-					   bpf_map__name(map), err);
+					   bpf_map__name(map), -errno);
 				goto tobj_cleanup;
 			}
 			links[links_cnt++] = link;
-- 
2.25.1


