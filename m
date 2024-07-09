Return-Path: <linux-kselftest+bounces-13359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E6392B439
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A58B22818
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253AB15574E;
	Tue,  9 Jul 2024 09:42:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFA61553AB;
	Tue,  9 Jul 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518128; cv=none; b=WrmDhmh3VOYnFhzdjEwWb3TApZwevY5L4eE6Q0BcPdIuW7wkKPG8dorRPv4J3ZWYvilz/FEtySPMVK1BMFW1UP5o5omjGQtlgFPBLEOFXc70yvBSKTKWaHhT9yRrhL7QGDoG6jKl81yQjMe84ZTwnfAorRwLcR8NH1D30nVZ8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518128; c=relaxed/simple;
	bh=bJpV92jD3cHVno9zaJ1U4+EJAewTdl9SOzWYprQ1xos=;
	h=From:To:Subject:Date:Message-Id; b=LlPY8r77yxo3Ch3zg7L1dUP+KkJsPMvLEezcIhzB2BA+Y00MEXfbwd8EKyNI38Pq8Bwm0QHnIHSRWQnUVSv9y4/xcEeilxsyY6Q0RPtLIv/RUVt924VjDHlJAPhxCzAO9QkVTfeoXMvMIvgjmMsqm4wbVLpPLHnJBPMwG4iHEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2668d0522f64-58f67;
	Tue, 09 Jul 2024 17:38:45 +0800 (CST)
X-RM-TRANSID:2ee2668d0522f64-58f67
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6668d0523288-b3700;
	Tue, 09 Jul 2024 17:38:45 +0800 (CST)
X-RM-TRANSID:2ee6668d0523288-b3700
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.or,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/bpf:fix a resource leak
Date: Tue,  9 Jul 2024 02:38:42 -0700
Message-Id: <20240709093842.3407-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The requested resources should be closed before return
in main(), otherwise resource leak will occur

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
v1 -> v2: check for cg_fd >= 0 and have just one out label

 tools/testing/selftests/bpf/test_sockmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index a34e95040994..285a9a714666 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
 
 	if (!cg_fd) {
 		cg_fd = cgroup_setup_and_join(CG_PATH);
-		if (cg_fd < 0)
-			return cg_fd;
+		if (cg_fd < 0) {
+			err = cg_fd;
+			goto out;
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
 
@@ -2109,7 +2111,8 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
-	close(cg_fd);
+	if (cg_fd >= 0)
+		close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
 	return err;
-- 
2.17.1




