Return-Path: <linux-kselftest+bounces-38424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7FFB1D0C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 03:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCC018923B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCA1C2437;
	Thu,  7 Aug 2025 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K9Jq0zlY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA281B4F1F;
	Thu,  7 Aug 2025 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531678; cv=none; b=SwTmsuHOgfcdAT/d+qgCsdqKE+FTGbIfWzyucYVSBAGD6GNOWioC7gNfotmcvXYtx8csKVaXLAaNuHacR8Tv0rP/j2M2Z18DuNk39WsukHvbsO4ZKUytL3+s0Wv1GC+/9Bh/u9IKRnRg8piTmgr97clEzRlSp0pUQo2hTClRjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531678; c=relaxed/simple;
	bh=8zC61z4U9KElmgz30gZnNvjJ3tnPPtWqljpucyYSXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGFsqsjGhrlOv9N7xf/8bHt1dXCA3h5Wm2NBo4pHmDuuYwKdTwsApZpdbGF1wuT13dJWD3Qdy+yoS03xaPCKwDkR0MaHJAxNZhgKUpwNqsw3/u5PmWAZnEk0AcBJOezcYGUlCEDeqmlVNM9sTdfMEB9r43tklxpHbesxS3JF1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K9Jq0zlY; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754531667; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CIZ7WXF5g1l9+Jlu+gqBRIGXy+7NQPiv2Cz5OL0cXzs=;
	b=K9Jq0zlYuAHu28flBlk8tVPovJ1g0NvG8TMUisdbUHDquGePHyPp03h2QhMzW/cVNqOH256z/Mb13UiBEkqmTF9qqx53NSNg+iLxriQrVvut0zbAvNC4E5BCKqp8KH7O4dXFCkftgBmyL925mcClfxXjmYghWGQUOesI33ndiow=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WlCEkul_1754531656 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 09:54:26 +0800
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
Subject: [PATCH -next] selftests/bpf: Fix warning comparing pointer to 0
Date: Thu,  7 Aug 2025 09:54:15 +0800
Message-ID: <20250807015415.2406263-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid pointer type value compared with 0 to make code clear.

./tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c:221:10-11: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=23403
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 4f94c971ae86..6b725725b2bf 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -218,7 +218,7 @@ int null_check(void *ctx)
 	int *p;
 
 	p = bpf_rdonly_cast(0, 0);
-	if (p == 0)
+	if (!p)
 		/* make this a function call to avoid compiler
 		 * moving r0 assignment before check.
 		 */
-- 
2.43.5


