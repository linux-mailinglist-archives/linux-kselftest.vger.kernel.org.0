Return-Path: <linux-kselftest+bounces-12521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25275913ACD
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4DF1F218C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E1148FE6;
	Sun, 23 Jun 2024 13:18:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB271E4BE;
	Sun, 23 Jun 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719148720; cv=none; b=RJLFOrUUMv1ZK8dJyksY6IbTs+JEn4RPcN45LJ9K8yil34usiph0+9FYPi+yfHX1qrzgOx6ZrS/O/r0x304CaC0BdxPxmQNtDjnLF8jDA4k5QFasIqNyTePZ3Fit+j5kWc9Et+FBFgWhzRDD3ABDxvaOsAnzcY95IhZ98EKSkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719148720; c=relaxed/simple;
	bh=4FY6G+8SzqtEFWJuLER8XK0Ce7sJVZs656Kaozqut/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfJ2kewJRr6KdfcdPHiIl9za3dw/w4fTRC3s7I3LN+YbprX1K1sIdrwIxh0+Wd8NDM2wK3SUnnj77pnQ1UgCU/4ThmfvA8WSnrFNt8095dqYJCGc+2zTB/yd/f0y223fatddfFBDv4LiRVsL9gO+6l3v2mcCdQb74OW/LbIlwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAAXHuaDIHhmz39UEg--.23115S2;
	Sun, 23 Jun 2024 21:18:05 +0800 (CST)
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
	make24@iscas.ac.cn
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: don't close(-1) in serial_test_fexit_stress()
Date: Sun, 23 Jun 2024 21:17:53 +0800
Message-Id: <20240623131753.2133829-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXHuaDIHhmz39UEg--.23115S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry5tr4fKw1xJF4DZw1UWrg_yoW3KwbE93
	97trn5AF4UZrn8tr48Kan8Crs5Ca1UJr4xuF1DXF13try5Xr45CFWvkFn5X3yrW39Ikay3
	ZFsrZ3s7GF1j9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUby8BUUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Guard close() with extra link_fd[i] >= 0 and fexit_fd[i] >= 0
check to prevent close(-1).

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 596536def43d..94ff1d9fc9e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -50,9 +50,9 @@ void serial_test_fexit_stress(void)
 
 out:
 	for (i = 0; i < bpf_max_tramp_links; i++) {
-		if (link_fd[i])
+		if (link_fd[i] >= 0)
 			close(link_fd[i]);
-		if (fexit_fd[i])
+		if (fexit_fd[i] >= 0)
 			close(fexit_fd[i]);
 	}
 	free(fd);
-- 
2.25.1


