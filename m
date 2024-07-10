Return-Path: <linux-kselftest+bounces-13431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3D692C82B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 03:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E681F241C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 01:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F97848E;
	Wed, 10 Jul 2024 01:59:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75363D5;
	Wed, 10 Jul 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576773; cv=none; b=uIBLRk16LztM5R6RvwmJDKRB/jQO9UvI28Hs0ZS4nXU3ChgCm2BRU6JFqsKWYE9cwchTy6CeCH2vIoOzrp/PraydNmwKS6Zu69H1IV9yylWq6TGAepGTibxTJZvh+LNC8t7USNjpbN4/wZZY7TgV9Ak2U6SsG1/S1SIc9rNdcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576773; c=relaxed/simple;
	bh=JtpI4NwjWgIkoEKZFJoiukOQ1YfwMkxr68FJ1EAWtYw=;
	h=From:To:Subject:Date:Message-Id; b=CDZxIAaRmzS37gtijV/E9SkWQsCtNqrh8ucVLGdcPUFNPAJk3incSGCaS+2a6HV7vFeG3zc8PmKyQrDXv8tgA4fD8Yhl7PC4A7XA6xcy0Ex3e8t2cGq6hSiTXyINlyJ0mhg4s+VbY6eumyfmiOwrqtjerQ7zxxVz4c6p+lGNEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5668deaf3860-27861;
	Wed, 10 Jul 2024 09:59:16 +0800 (CST)
X-RM-TRANSID:2ee5668deaf3860-27861
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4668deaf2589-d404d;
	Wed, 10 Jul 2024 09:59:16 +0800 (CST)
X-RM-TRANSID:2ee4668deaf2589-d404d
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jolsa@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
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
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH bpf-next v2] selftests/bpf:fix a resource leak
Date: Tue,  9 Jul 2024 18:59:13 -0700
Message-Id: <20240710015913.2554-1-zhujun2@cmss.chinamobile.com>
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
Changes in v2:
 - check for cg_fd >= 0 and have just one out label

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




