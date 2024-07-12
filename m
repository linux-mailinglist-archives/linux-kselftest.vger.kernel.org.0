Return-Path: <linux-kselftest+bounces-13650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FE92F641
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0205B22F1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075B13E3F3;
	Fri, 12 Jul 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DpTqH1Hy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2E13DDB8;
	Fri, 12 Jul 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769473; cv=none; b=Pg0sGH42TXn1E5RqPmqiRQ1Fiodfu8xxkDrgiRbghCodjpk8YV8osHPLFHJs5cszxv5yjjvh9IAW+vURTi8sFzMPHhPAyzldj7W7c+7g1BR5PiL6LvVK6MDS/HOtsAEmBflOxrr1R+2BT9oS/SHu3BO55ukgdICCB4Mh5S5hkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769473; c=relaxed/simple;
	bh=pMIJq6XzjEqCqqiGFtz3aDAVbL3U30hnnFJZLgD2If4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxt184YoucM2Nau1OWc2/NetaIE2XDEFjtSDlEJoD0IsBc4mn1nO4SJUIVBWNnbgM57u63aF1YxRnmbkoZGa5g9KJm4Bhf5VuRf1QxQoYQGmezKGFH4AMefqsycZy8neK9jKOQxhsCfg6v6CBYhGvrI+O3DHPPNGCKjYPTkRv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DpTqH1Hy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720769470;
	bh=pMIJq6XzjEqCqqiGFtz3aDAVbL3U30hnnFJZLgD2If4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpTqH1HyGaaKETYA4WNTHM/EuiASMH+yfpaZTqzzHT0AjKbYyjwbCdQmPou0ydHt1
	 KM4Z5f3usNuOjnd9M6HGOLn0TBaiIC0CU2KGKlGkz6HiKuoGHkcpN6zWqb4tKVpp9N
	 SC++HGTY13p53OJsHiL3r/MteuraxnoHRjlQBUvM5hCqPFG+6UfH4LcUwo4MYVCS8q
	 ta1o5zCws8xKj68G4PqTfpEH45cJO4cMnzilObf5SrnSZFlCRLZqNah7u+kj5yT7KV
	 1z0c7bAtCwj63tnLwf+gAb49TGNXtYPNcCkMlIYaMwmEx8aCJQuHtbz2KeCsUmFw5k
	 PoTT2eFpH/CTA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E641C3782212;
	Fri, 12 Jul 2024 07:31:07 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: x86: vdso_restorer: Return correct exit statuses
Date: Fri, 12 Jul 2024 12:30:43 +0500
Message-Id: <20240712073045.110014-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712073045.110014-1-usama.anjum@collabora.com>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return correct exit status, KSFT_SKIP if the pre-conditions aren't met.
Return KSFT_FAIL if error occurs. Use ksft_finished() which will
compmare the total planned tests with passed tests to return the exit
value.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/vdso_restorer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index 8e173d71291f6..54f33e8cda5cc 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -56,7 +56,7 @@ int main()
 			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso) {
 		printf("[SKIP]\tFailed to find vDSO.  Tests are not expected to work.\n");
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	ksft_set_plan(2);
@@ -69,7 +69,7 @@ int main()
 	printf("[RUN]\tRaise a signal, SA_SIGINFO, sa.restorer == NULL\n");
 
 	if (syscall(SYS_rt_sigaction, SIGUSR1, &sa, NULL, 8) != 0)
-		err(1, "raw rt_sigaction syscall");
+		err(KSFT_FAIL, "raw rt_sigaction syscall");
 
 	raise(SIGUSR1);
 
@@ -80,10 +80,12 @@ int main()
 	sa.flags = 0;
 	sa.handler = handler_without_siginfo;
 	if (syscall(SYS_sigaction, SIGUSR1, &sa, 0) != 0)
-		err(1, "raw sigaction syscall");
+		err(KSFT_FAIL, "raw sigaction syscall");
 	handler_called = 0;
 
 	raise(SIGUSR1);
 
 	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
+
+	ksft_finished();
 }
-- 
2.39.2


