Return-Path: <linux-kselftest+bounces-12982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6248391D5FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 04:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763F52816D0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B181B657;
	Mon,  1 Jul 2024 02:13:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9110F1;
	Mon,  1 Jul 2024 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800032; cv=none; b=X1SJ/9oAqZzxxpOFaa9Ir7sLP5hiusIsum05Xgv3189lATcotVLfg0DHPITbZlin4f9XOcr362rvwdoGbPcqD6l8tjy8VKhJtyA73TKxtyCImyTGEEXn7U08qCDGNQ+dM8e+l01IjC/+cLUc5WEdh5nlRFnFu+D8/TWOTQc75pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800032; c=relaxed/simple;
	bh=xX4Ak7E42QQc9wwOJPl3DEy10f6SvXhNxNVxxv/+pwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AlwlswcyeiMWg0ZSdNKpslYDTsMbv+bvvWOmzUkogr1FxRx5rdbaOnn9Evd1Rz73iF2vE/7FRTRtaelA5Yvkkarjcv2H7ZOeb2y5aCciRS7nwdCncPXWKeRr+3YiZkHfGmlUW11tToJACl9W28RQ4yK+1XGc4LKLUzE405VrziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3668210d135d-a7b66;
	Mon, 01 Jul 2024 10:13:38 +0800 (CST)
X-RM-TRANSID:2ee3668210d135d-a7b66
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1668210d0cd3-58186;
	Mon, 01 Jul 2024 10:13:37 +0800 (CST)
X-RM-TRANSID:2ee1668210d0cd3-58186
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/bpf:fix a resource leak
Date: Sun, 30 Jun 2024 19:13:31 -0700
Message-Id: <20240701021331.3057-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <847bcc7c-e54e-648a-be47-59e0a6d0853e@iogearbox.net>
References: <847bcc7c-e54e-648a-be47-59e0a6d0853e@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The requested resources should be closed before return
in main(), otherwise resource leak will occur

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index a34e95040994..d51af986d9d8 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
 
 	if (!cg_fd) {
 		cg_fd = cgroup_setup_and_join(CG_PATH);
-		if (cg_fd < 0)
-			return cg_fd;
+		if (cg_fd < 0) {
+			err = cg_fd;
+			goto out1;
+		}
 		cg_created = 1;
 	}
 
@@ -2092,7 +2094,7 @@ int main(int argc, char **argv)
 	if (err) {
 		fprintf(stderr, "populate program: (%s) %s\n",
 			bpf_file, strerror(errno));
-		return 1;
+		goto out;
 	}
 	running = 1;
 
@@ -2105,13 +2107,14 @@ int main(int argc, char **argv)
 
 	err = run_options(&options, cg_fd, test);
 out:
+	close(cg_fd);
+	if (cg_created)
+		cleanup_cgroup_environment();
+out1:
 	if (options.whitelist)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
-	close(cg_fd);
-	if (cg_created)
-		cleanup_cgroup_environment();
 	return err;
 }
 
-- 
2.17.1




