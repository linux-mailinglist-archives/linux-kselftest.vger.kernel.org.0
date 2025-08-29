Return-Path: <linux-kselftest+bounces-40248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFFB3B08D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 03:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0E617EBA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154B1D5146;
	Fri, 29 Aug 2025 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m/9q9vzv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74421A23B1;
	Fri, 29 Aug 2025 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431725; cv=none; b=YziX6RFvbU6LBbYEGMjGinNZfhgdKzcB6HtckHZEICD9FhcBzKWZDp3WkXJPNjtycCiv2dXGyawydEfw4U3FYSHih1Af9q7xgIY3VCqxujVQ1D83/Y1aC9conRRIDSHyTMegw2ktozH148zKtt1GO5XwYKfzgW1YlT2Hc1YJJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431725; c=relaxed/simple;
	bh=nVEcU2CtQRVhw3xToJfM7g9BJlq7bGKMEjErO0KLGf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8ebQxyIZ+xtUzSAFHchXT4Ias/6edPGaEq5Q7nTn/h2v15StxHVAd9z0QuqMHZ6YUyQuWa0ytFNTbG/VtdP4q5TrXaehi11a2c3xlhxWI/mZghxoh1pOinzNJ9MFWsj5Xds/EG5T+ewQTNtjBmhTtsTpMpL+BiDa/eV+LK5bhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m/9q9vzv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Uh
	lgy4Ywf0NSBeLK8rCRboihXyWCo7Qcuxp4QSGjAfI=; b=m/9q9vzvYX7acbGhvo
	vT8hWzSt0Cv5Ml2jjyXFgUqth8DUfsvUT3yqI7xKmvLaeQroTI83jV2gOa6bzUlv
	1PZQBvtnIK5h71EssQt5tODCOD+iYNap2aNiyK2Nq0od1QTubE1EsxIuDNZsgcMp
	g1otSp7+Mgs2e7bcsu/BKsg6Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAX5GJFBbFowQQwFA--.17685S2;
	Fri, 29 Aug 2025 09:41:27 +0800 (CST)
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
Subject: [PATCH v2 bpf-next] selftests/bpf: Fix the issue where the error code is 0
Date: Fri, 29 Aug 2025 09:41:25 +0800
Message-Id: <20250829014125.198653-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX5GJFBbFowQQwFA--.17685S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW7WrykAF1xXF4DCw4xtFb_yoW8Xr1fpa
	y0gw40kr1Fqr45Xa18Xa1Uur4FgF4vq3yrWwnrKayYvr1kWryxXr1xKFy3uFn8WrWY93ya
	yasFqFy8u34UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbKsbUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiYwG3eGiwemSS8gABsK

From: Feng Yang <yangfeng@kylinos.cn>

The error message printed here only uses the previous err value,
which results in it being printed as 0.
Fix this issue by using libbpf_get_error to retrieve the error.

Fix before:
run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilogue: err=0

Fix after:
run_subtest:FAIL:1019 bpf_map__attach_struct_ops failed for map pro_epilogue: err=-9

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- Use libbpf_get_error, thanks: Alexei Starovoitov.
- Link to v1: https://lore.kernel.org/all/20250828081507.1380218-1-yangfeng59949@163.com/
---
 tools/testing/selftests/bpf/test_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 78423cf89e01..b8e102eb0908 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1082,8 +1082,8 @@ void run_subtest(struct test_loader *tester,
 			}
 			link = bpf_map__attach_struct_ops(map);
 			if (!link) {
-				PRINT_FAIL("bpf_map__attach_struct_ops failed for map %s: err=%d\n",
-					   bpf_map__name(map), err);
+				PRINT_FAIL("bpf_map__attach_struct_ops failed for map %s: err=%ld\n",
+					   bpf_map__name(map), libbpf_get_error(link));
 				goto tobj_cleanup;
 			}
 			links[links_cnt++] = link;
-- 
2.25.1


