Return-Path: <linux-kselftest+bounces-19516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C6F999C8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 08:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C341F242BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 06:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C641F9431;
	Fri, 11 Oct 2024 06:22:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED902581;
	Fri, 11 Oct 2024 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728627757; cv=none; b=J8jFllRPj4J+GNSHXmeE8tNye1cyordjzywsXpYPdVN329IKS6TGcJxTx2efvX8LkBLb3QtuKTxpEghSg1CHSclofoR1MItBM+ggycsoqyv9lSR5zmIz1L+d/N4YoLQlS19u/zphvdB3wGxb4WLWPcdAr1h1NUEaYvpG7O+2RTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728627757; c=relaxed/simple;
	bh=uS1vketAMn+QuN65fHsUsbaau8xZ+bb+fzaY0ejlOJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XNChDQKEoSn7jXt4TBAYw2TrJ9nUzU9mQS+aWs/GXyoUDQIabry7FJb/CxfrtHBvNZV09hy+5Fk1cFTe6/BLdAXVa7JI6YsDROr+NnSlZgTEwxYVQSywRM8SAS48bgLMJRaRCDg27GTLvAfi5jj8374bL+407UKXX6feydKAbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPxP04bvzz4f3kp8;
	Fri, 11 Oct 2024 14:22:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 769061A06D7;
	Fri, 11 Oct 2024 14:22:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP4 (Coremail) with SMTP id gCh0CgDXDMkfxAhnqG8ZDw--.5449S2;
	Fri, 11 Oct 2024 14:22:24 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	joshua.hahn6@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH -next] selftests/cgroup: Fix compile error in test_cpu.c
Date: Fri, 11 Oct 2024 06:11:53 +0000
Message-Id: <20241011061153.107208-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXDMkfxAhnqG8ZDw--.5449S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kGrykZr18CrWrAF1fZwb_yoW8Gw4Dpa
	1kG34j9F4rKF17J3Z2vrW2gFyI9Fs7JFWjya18Xr9xZF1fJryIqrW7Kayjqry5ua95Z3sx
	Aa4SqF1ag3WDJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

When compiling the cgroup selftests with the following command:

make -C tools/testing/selftests/cgroup/

the compiler complains as below:

test_cpu.c: In function ‘test_cpucg_nice’:
test_cpu.c:284:39: error: incompatible type for argument 2 of ‘hog_cpus_timed’
  284 |                 hog_cpus_timed(cpucg, param);
      |                                       ^~~~~
      |                                       |
      |                                       struct cpu_hog_func_param
test_cpu.c:132:53: note: expected ‘void *’ but argument is of type ‘struct cpu_hog_func_param’
  132 | static int hog_cpus_timed(const char *cgroup, void *arg)
      |                                               ~~~~~~^~~

Fix it by passing the address of param to hog_cpus_timed().

Fixes: 2e82c0d4562a ("cgroup/rstat: Selftests for niced CPU statistics")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 201ce14cb422..a2b50af8e9ee 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -281,7 +281,7 @@ static int test_cpucg_nice(const char *root)
 
 		/* Try to keep niced CPU usage as constrained to hog_cpu as possible */
 		nice(1);
-		hog_cpus_timed(cpucg, param);
+		hog_cpus_timed(cpucg, &param);
 		exit(0);
 	} else {
 		waitpid(pid, &status, 0);
-- 
2.34.1


