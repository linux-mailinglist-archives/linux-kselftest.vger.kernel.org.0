Return-Path: <linux-kselftest+bounces-41010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFDB49F3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 04:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708744428FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC624468C;
	Tue,  9 Sep 2025 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a37qJk+G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7DB1A8F97;
	Tue,  9 Sep 2025 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385114; cv=none; b=jcx8rnXvubMLgG8GXEhPYY7NA5SX2TfOSaVtB3uNzPqMdYel3roWr2ieeUQs/huK8fczBlvF9eTvDHmk9MlzVHO5zY3XmfUZv8UCJ9JFS+pgVKzIIPa0GzDylgKtfByK0wR3E+tgTkRgMuamumZD6BqE3EyoK6fJPIdTPLE3MWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385114; c=relaxed/simple;
	bh=voIwO7aB55DFEwbmZ9+P0CiskzmhgCldk/xu8wyh4rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o72KvHscDSy5hThy6EAXkr7p8DthSUYCeC+n7QShHdAY3w3pjAVlFLZ9p63PDXwa84JyWMQQH/Y6FDpH9nAxvcYKIpE59EMZamHiZNOvGg1OKRMMdnypflrpwIHr+EQq1EiTUeqahpbZ4W/MZs3mhSNO7gauWdZnbwFJsnEcU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a37qJk+G; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757385109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WweqMmyOHEemYumtjGpzECw+a4p1s0bPOHN7VW0FAYQ=;
	b=a37qJk+GX00b+p+R4Pc8WBlLLIJbAZwzFVV9VOenmKfhjH/CkZw2JEW0lPE8OVuKlVM/g2
	PVjtltxw5Z1LHp4IdCI1x6TPgxjGh/sxkzQJMj3ymqBcFdf1rZwQtzp0KjG24zPnNr6Q11
	9xCnlrrRkEZX96CrsgDMN4XhIDpCQRM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: jiayuan.chen@linux.dev
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix incorrect array size calculation
Date: Tue,  9 Sep 2025 10:31:12 +0800
Message-ID: <20250909023130.28325-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix it by using ARRAY_SIZE.

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
 

base-commit: 60ef54156148ffaa719845bc5b1fdeafa67763fc
-- 
2.43.0


