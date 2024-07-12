Return-Path: <linux-kselftest+bounces-13638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02492F3DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F1B1F22A81
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66E5256;
	Fri, 12 Jul 2024 01:59:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A6524C;
	Fri, 12 Jul 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720749555; cv=none; b=p2c6nspNiADWtl2WA/QG8WmWtJCCbQV/piTJe85+4KbLxC4EbrPtRzSwUThG1sTVXoCeV2Azd6CR+uiM340ClFJ13ZiqEZBRc/bTdSzThb2c3PIS/mgpv89Uss2LHVyqwvBF8cxBxUhgE9xlMdzSFgSBiGjYHYL4ZhA2MhLyqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720749555; c=relaxed/simple;
	bh=JtpI4NwjWgIkoEKZFJoiukOQ1YfwMkxr68FJ1EAWtYw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DwstAkx4U1rcV3JFNHp5uzbASIR46VuWqHjuSdfiqDypMgVTHjPRecHgPT+TPfpMxaU0OjufLAA3/D2cZdBkowYpAR1qk/4HaOrxy8oB5uiaZIl85s3uJ6zdTp5Av+SteqbkcF+KDrWJMs9irfy5ZyCpRTBJuzOz+MiOkxm6nsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266908de91fd-6f200;
	Fri, 12 Jul 2024 09:59:06 +0800 (CST)
X-RM-TRANSID:2ee266908de91fd-6f200
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866908de874e-36053;
	Fri, 12 Jul 2024 09:59:06 +0800 (CST)
X-RM-TRANSID:2ee866908de874e-36053
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jolsa@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND bpf-next v2] selftests/bpf:fix a resource leak
Date: Thu, 11 Jul 2024 18:59:04 -0700
Message-Id: <20240712015904.2885-1-zhujun2@cmss.chinamobile.com>
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




