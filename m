Return-Path: <linux-kselftest+bounces-12838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9E919DC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 05:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829611C21532
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 03:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD955D51E;
	Thu, 27 Jun 2024 03:19:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB636B;
	Thu, 27 Jun 2024 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719458361; cv=none; b=g2yUSqFpKOsUnQxnBFprq6UPRFwfaEqzTIlXmnNX5uMY7xJ2gXbEKqQ/Z0FgzpnQJiDdW7hyhpMXU2/oO1j0Ri8K2DQFWUfHTUtvTcU4O68VRHKBvm6/1ehvgFRSEu13tzS74YhoI2o/gpq+A5R3rBe8DxuDIekSl8ZygviDGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719458361; c=relaxed/simple;
	bh=cnkAzcIZvkMlLGVV8yOjwB08ZcNbpwrUhyBoHM5oZjA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MX7bd/FWAbUrfCBOJMzkSpErNnhFGCIKIp5gLjR884quB2B22jt48dNl14EbJigOk5m3EpnpsuMF73qy//8y+pyaSWfQwxgpzb1cHx0qZ2UaviXJCjSW/IVfj6Nh5kcl50y/yunXZ3owGxCX+xDUfuhtUhA0e4ZrsrNY+mYr8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7667cda2a18d-889fd;
	Thu, 27 Jun 2024 11:19:09 +0800 (CST)
X-RM-TRANSID:2ee7667cda2a18d-889fd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6667cda2aa01-bfa92;
	Thu, 27 Jun 2024 11:19:09 +0800 (CST)
X-RM-TRANSID:2ee6667cda2aa01-bfa92
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: daniel@iogearbox.net,
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
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] selftests/bpf:Delete extra blank Lines
Date: Wed, 26 Jun 2024 20:19:05 -0700
Message-Id: <20240627031905.7133-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Delete extra blank lines inside of test_selftest()

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 92752f5eeded..a34e95040994 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1970,7 +1970,6 @@ static void test_selftests_ktls(int cg_fd, struct sockmap_options *opt)
 
 static int test_selftest(int cg_fd, struct sockmap_options *opt)
 {
-
 	test_selftests_sockmap(cg_fd, opt);
 	test_selftests_sockhash(cg_fd, opt);
 	test_selftests_ktls(cg_fd, opt);
-- 
2.17.1




