Return-Path: <linux-kselftest+bounces-41052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B8B4FB9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6921B273A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722273314A4;
	Tue,  9 Sep 2025 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KG/sKjTM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C0285C9F
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422060; cv=none; b=IeFuvqNZYmD7PQUmxjIJvVa6+rVgvy5yo+xN8JOjW59MIqPKmXKbDECVtHAhOCboZhjPtt3L5atDuWrkYTQZHm/eoqtnpAGeYBa3K/uTgX3KhILpYX3qVZ2rZAyZfABwBaYR2qWbrnTCESumyMNogsjzmuGtzEdXp2PjbnsXxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422060; c=relaxed/simple;
	bh=C/o3+QkdyajagqcWpvpUtf/kbpe5Cr0u7uLUZDwXD6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p76dFyghCKcETaeS3cwWvm6aEwThaYCPmOpzmEhB2ZRAV5FsmFPKjGTRxUHyqqi9tJtDNyG6LWwQiqCyc8HAtl42PVR53XB1C+8wRp9BU4YqA8SDD8UHrISF+61sBdXXtnsJKkJN/pdOAjO6uJaenCPTS5vH5ceyo4RtCgvytvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KG/sKjTM; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757422056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Civ3v7++W+FLuwnLZNUaxx6xIkTNDQTvDlA6SdwcjAQ=;
	b=KG/sKjTMufw82dzqQfGVZtHmIKPFQHjuko4gDGm2VJ8PiUkf/cdXrcsWVNTTRI0/e158e7
	vA1IZjtT5F2Ib8aSgAXpjckrO5n7N9Cp53SXyOkPTcvGNW3IavPzg4XB68O7GjhVMY0lAs
	jNytsDhuBxLvL89RZdlSy706tA7kG78=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: jiayuan.chen@linux.dev
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Fix incorrect array size calculation
Date: Tue,  9 Sep 2025 20:47:04 +0800
Message-ID: <20250909124721.191555-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The loop in bench_sockmap_prog_destroy() has two issues:

1. Using 'sizeof(ctx.fds)' as the loop bound results in the number of
   bytes, not the number of file descriptors, causing the loop to iterate
   far more times than intended.

2. The condition 'ctx.fds[0] > 0' incorrectly checks only the first fd for
   all iterations, potentially leaving file descriptors unclosed. Change
   it to 'ctx.fds[i] > 0' to check each fd properly.

These fixes ensure correct cleanup of all file descriptors when the
benchmark exits.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/aLqfWuRR9R_KTe5e@stanley.mountain/
---
 tools/testing/selftests/bpf/benchs/bench_sockmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_sockmap.c b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
index 8ebf563a67a2..cfc072aa7fff 100644
--- a/tools/testing/selftests/bpf/benchs/bench_sockmap.c
+++ b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
@@ -10,6 +10,7 @@
 #include <argp.h>
 #include "bench.h"
 #include "bench_sockmap_prog.skel.h"
+#include "bpf_util.h"
 
 #define FILE_SIZE (128 * 1024)
 #define DATA_REPEAT_SIZE 10
@@ -124,8 +125,8 @@ static void bench_sockmap_prog_destroy(void)
 {
 	int i;
 
-	for (i = 0; i < sizeof(ctx.fds); i++) {
-		if (ctx.fds[0] > 0)
+	for (i = 0; i < ARRAY_SIZE(ctx.fds); i++) {
+		if (ctx.fds[i] > 0)
 			close(ctx.fds[i]);
 	}
 
-- 
2.43.0


