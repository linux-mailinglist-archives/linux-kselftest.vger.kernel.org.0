Return-Path: <linux-kselftest+bounces-3999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD34846B88
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523611C25168
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42B65BA5;
	Fri,  2 Feb 2024 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Me6pgBMe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E960DF4;
	Fri,  2 Feb 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864838; cv=none; b=qeShg8sQb9b+L4utho8yUxYaKOrGMYb9yf325dOTTzU8CoPJlZoGxCtBB7PpJrdsOxpV+sFuXXjuAZa+DncerY4SirfQtjA26iSx74DEbqUmmPgry35aAVtaV+8d2U4mHa29zN4NZeBZpH3jlZ/ECG5kiqXCaOx4m5jUXnmCED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864838; c=relaxed/simple;
	bh=9n+bxoffzFzRxugdTlBIiUi8qOo9YOUTTBTv4D1ra04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CObEs5SV/Xej/qjd+lqJcTiBsWGgSQYfjh0XpXRRloNgjr31j6le0xh82z8NZgziiFSVErkKRxdNk7Azq51zYRLzxfnXClUMUefjOci0O4Fp+ak9URX9SCD33g9YZMwWRKZWXfH1WVby5I7IdVxKjujVz9t/J9tN/lFlMn6F2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Me6pgBMe; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706864828; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UXNrR1zI5WqRxkxoq440HbXJgM3mez+A/tGzovy1VjU=;
	b=Me6pgBMePPLBtznQZiZyfnZPzdbd0uJ8EaI/cuaK8bqjEIsfVFqyRtj76AglIUwzN1k070PYeqddPMqm0rrX5pVU7qYEbslh4nczRXxuc/D3FEj1MjMIaqtIHrYHZDwjwoYToQbzwH/8bG/XryiBTHYKup8pD1TzIf/SRloLVEI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W.waoAc_1706864813;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W.waoAc_1706864813)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 17:07:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] selftests/bpf: Use ARRAY_SIZE for array length
Date: Fri,  2 Feb 2024 17:06:52 +0800
Message-Id: <20240202090652.11294-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./tools/testing/selftests/bpf/progs/syscall.c:122:26-27: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8170
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/bpf/progs/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 3d3cafdebe72..297a34f224c3 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -119,7 +119,7 @@ int load_prog(struct args *ctx)
 	static __u64 value = 34;
 	static union bpf_attr prog_load_attr = {
 		.prog_type = BPF_PROG_TYPE_XDP,
-		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
+		.insn_cnt = ARRAY_SIZE(insns)
 	};
 	int ret;
 
-- 
2.20.1.7.g153144c


