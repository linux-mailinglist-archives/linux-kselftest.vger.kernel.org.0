Return-Path: <linux-kselftest+bounces-30819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2229A893B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B7B1882AA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37169275860;
	Tue, 15 Apr 2025 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VRn/5uPt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FD274642;
	Tue, 15 Apr 2025 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744697712; cv=none; b=GdFv9G1aVCG9ZMC/HEwvPHuGrE9kfUk0UMNv8A4QarfrEZHhoYF6+bcBfWe1C8cbfcAECJyDCBY8U132VxPHxzPf5M8h3kHeMEo3yjnN7qd2Md4079f19tX7SGB1d6HDZyYLHnLJp92iLG+UssgH7yISkFFBpg9rSydNgkII11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744697712; c=relaxed/simple;
	bh=Jj+9El0gv9RJRnKdz5Z6J1EoU0iho4atfdClLS8c21Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQguCoT0RX56tIyivAoNKmif4lCZ2vyeXB8kroKfv+rQYqcPyRnKom3PgEH3gbFlXMglqVCi6BUxnEZqmdFRnfe5ghQRMIYUuF6CsQyzOaxNNoEOSK4OYNUbumSLXIAaVGGqjkAkNT80Q8CYHWUzYMMFn8eC2IsNfSB7xg+N2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VRn/5uPt; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744697705; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+2LZ3sbql60OCXVn+A8aGl6V+b4sdyQtm8MhWSm6Pv8=;
	b=VRn/5uPtZZRO+nAIim3MOiE2c6fI6LxqKx5+d+/nT8bdwM/eHVY2HgHQs3miQA6bDOvNUVoe/YQKFSpD9beg8RLoWIIgji0FE9Zhzfrpsl/XIarvT2drm5kvkFIrZ5OS6Hq2x61As5IMFZeAym4WuykK5igXxMWdL5bbDILmjik=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WX3bW8J_1744697699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Apr 2025 14:15:05 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] selftest/bpf/benchs: Remove duplicate sys/types.h header
Date: Tue, 15 Apr 2025 14:14:59 +0800
Message-Id: <20250415061459.11644-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/testing/selftests/bpf/benchs/bench_sockmap.c: sys/types.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=20436
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/bpf/benchs/bench_sockmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_sockmap.c b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
index 54f4e7c03cd2..8ebf563a67a2 100644
--- a/tools/testing/selftests/bpf/benchs/bench_sockmap.c
+++ b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
@@ -3,7 +3,6 @@
 #include <error.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/types.h>
 #include <netinet/in.h>
 #include <sys/sendfile.h>
 #include <arpa/inet.h>
-- 
2.32.0.3.g01195cf9f


