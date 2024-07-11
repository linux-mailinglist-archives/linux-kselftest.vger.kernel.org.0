Return-Path: <linux-kselftest+bounces-13549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C464892E0F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D91F21046
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B6148830;
	Thu, 11 Jul 2024 07:35:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E584DFF;
	Thu, 11 Jul 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683311; cv=none; b=Q4q8vecwUrnrT4iRaPpxIlECrk8ZowQGUTstl3ibS99oXo2hzKgpUe7XdvsANPLkKl82V7wrpD7Gtvnbg/bBFotqvnSldSFp8fgAtelN/kFwrme9CfVyqR+Kw5kJg0iH3tb2ZxXwgb07KJ0AscozodUHVKgqmIJznpaDv1FdrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683311; c=relaxed/simple;
	bh=A32NKfZuOtU4yS4/ogbhcy9GY77BvCCMpJQQ6CdWgQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nDE2vSIUZOQbmN9gE3pyBKqSETQQ7MsGTCui79iER7/1W4Sp4nXTJI3PPjMRaLV56DSGmoJLvT5sKpqJFEnLwmc0tyPYXYZZuebEdC9291cPF2o3CfNs7wrlXIp8Wag8+3cXhBX6olEA5vMSf0PfQZAYbdH8LjUWx5B59z4yzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACHjeUOi49mMu60Ag--.57582S2;
	Thu, 11 Jul 2024 15:34:45 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	rdna@fb.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] selftests/bpf:fix a resource leak in main()
Date: Thu, 11 Jul 2024 15:34:36 +0800
Message-Id: <20240711073436.2258240-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHjeUOi49mMu60Ag--.57582S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW7Xr1DCw1rKF1UGFWfKrg_yoWfuwbEkw
	47Jrn7JFZ8ZF18Jr42gw1FkrWrCa1YgryxJFWDJa43JrWUXrWDJF4qkFZ8Ja4rWa98Xasr
	tFyDurySyw47CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1YiiDUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The requested resources should be closed before return in main(), otherwise
resource leak will occur. Add a check of cgfd before close().

Fixes: 5ecd8c22739b ("selftests/bpf: Selftest for bpf_skb_ancestor_cgroup_id")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/testing/selftests/bpf/test_skb_cgroup_id_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
index ed518d075d1d..f84faddd72e6 100644
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
@@ -176,7 +176,8 @@ int main(int argc, char **argv)
 err:
 	err = -1;
 out:
-	close(cgfd);
+	if (cgfd >= 0)
+		close(cgfd);
 	cleanup_cgroup_environment();
 	printf("[%s]\n", err ? "FAIL" : "PASS");
 	return err;
-- 
2.25.1


