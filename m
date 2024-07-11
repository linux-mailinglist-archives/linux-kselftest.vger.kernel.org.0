Return-Path: <linux-kselftest+bounces-13547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385C92E0B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 09:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EC281886
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698B1311B6;
	Thu, 11 Jul 2024 07:19:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E3770E6;
	Thu, 11 Jul 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682373; cv=none; b=muLSIUMq+9tisp3Bc0ba+KMgDaDNucC7HH82qyeBqKTCLn/fGf5G+be6zAwg18MTIA4fqBtAMiei1Tiz3LJyWatmY/sJwLBTEvRHf2yt3DwHs1evKxvD5ntw7VbQddb7+YvYKBOlueH0oCyNnNMc5KHBgHydfDd+o4UNQJ2egoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682373; c=relaxed/simple;
	bh=KukPRvr/LxjYP/tcQHpDand86g6HlPduzoyVkg9JCq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sh70D3D5z0rKa2rWS68bgFAazRVW5X+0h46N3+qNCI+PhqtoOOlLC8P5e7nuQUopTTNSw72ZDIV5fdGn5kZZcYPORl6lTYAt4nM4pKPRYcgfuRvMtVm1J4WnuVxRmQRK9eZdOOB1goGKh53ecjWGVujmHeystwqswBzvTVkRCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnreVkh49mo3m0Ag--.56423S2;
	Thu, 11 Jul 2024 15:19:07 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
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
	rdna@fb.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] selftests/bpf:fix a resource leak in main()
Date: Thu, 11 Jul 2024 15:18:59 +0800
Message-Id: <20240711071859.2218494-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnreVkh49mo3m0Ag--.56423S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1fKrykuryrGw43AF13urg_yoW3urcEkw
	4Utr92kFWkAF18Aw4j93WrCrZ5C3W5WrWxJrs8Jay3JFWUXFs8Ga1q9rs8Aa4rua9xWay2
	yF4kWrySkw4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUrBMNUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The requested resources should be closed before return in main(), otherwise
resource leak will occur. Add a check of cg_fd before close().

Fixes: 1f5fa9ab6e2e ("selftests/bpf: Test BPF_CGROUP_SYSCTL")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/testing/selftests/bpf/test_sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index bcdbd27f22f0..242246ba8d1e 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -1627,7 +1627,8 @@ int main(int argc, char **argv)
 err:
 	err = -1;
 out:
-	close(cgfd);
+	if (cgfd >= 0)
+		close(cgfd);
 	cleanup_cgroup_environment();
 	return err;
 }
-- 
2.25.1


