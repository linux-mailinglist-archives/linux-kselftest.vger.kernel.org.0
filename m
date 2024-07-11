Return-Path: <linux-kselftest+bounces-13551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E27292E147
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1866B20D2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04019150994;
	Thu, 11 Jul 2024 07:51:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F114F10E;
	Thu, 11 Jul 2024 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684291; cv=none; b=AqsVEoY8hMUylf1H7Rho1IXaCHvFXH6tHnTwgmDhrl8xy9twyCQFTSAWwVjk3foTgEdt7E62mG3MBSJmcaXq1kDesmBcLd4jY0nHR8KRWT2oYNlAogabP2nFy7gXmocF0/ST6jLytAMh9Me6xYhIbllPxRGPC90FL9rAWjmJ4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684291; c=relaxed/simple;
	bh=53MKuDGTwUgmbb0SMrHdRUCOZUCQKDPJSryFy8ZHFUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XzXL6fw7BWnPxQy6Ypg/0jaPqaHroUf2TyR58LplCitIhzPrY/UvARcb435wnKdZZsNB7lpHb2iBZyo2jDWMMX6NgJRlHJdUAhSl/P6qMh+l7KM+OosvedxqkOguMyj0dFft9k5iJ2Byovl1tjBX3GUq2/5pRW3pOxQ+Aq7WX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAB3f7fojo9mam21Ag--.60832S2;
	Thu, 11 Jul 2024 15:51:11 +0800 (CST)
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
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] bpf, selftests: fix a resource leak in main()
Date: Thu, 11 Jul 2024 15:51:03 +0800
Message-Id: <20240711075103.2300305-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3f7fojo9mam21Ag--.60832S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur18Cw1Dury5Jry7uFyxAFb_yoWkJrcE9a
	12qr97trW8uFyYyw4qqws5Cr48Cw45GrW8X3s8X3y3GF1UXrZ8JFZrCr4DAa4Y9a98CFW7
	tFZxCryfKw4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUX6pPUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The requested resources should be closed before return in main(), otherwise
resource leak will occur. Add a check of cgroup_fd and close().

Fixes: 4939b2847d26 ("bpf, selftests: Use single cgroup helpers for both test_sockmap/progs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 tools/testing/selftests/bpf/test_cgroup_storage.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index 0861ea60dcdd..4265f1348b6b 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -79,6 +79,8 @@ int main(int argc, char **argv)
 	}
 
 	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (cgroup_fd < 0)
+		goto out;
 
 	/* Attach the bpf program */
 	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
@@ -170,5 +172,7 @@ int main(int argc, char **argv)
 	free(percpu_value);
 
 out:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
 	return error;
 }
-- 
2.25.1


