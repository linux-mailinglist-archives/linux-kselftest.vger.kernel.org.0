Return-Path: <linux-kselftest+bounces-3922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AD8451CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 08:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92AC2920D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 07:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD91586C8;
	Thu,  1 Feb 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SUx6mtOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DF158D81;
	Thu,  1 Feb 2024 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771600; cv=none; b=V3MvlLEO2stXkGajbedTFsBZV96UQs1310UMEmNg61QnJ9NCryqh14LRFUhgMBLgen8EV3lTG06kooJZ3+t9SKnixycqYrgb/5jKt2qH9IIvzyery400bvVQ21GJwfLt1K1imV5A0jQ4KGLHIkwxiCQ4u6ocUoOu6i4wc3pbbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771600; c=relaxed/simple;
	bh=+R4/cooCCuK4cnjbDE/i4pYhhrE258IRPNaowXzJuKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7/14YCdP9rUgoWV+/MZKr4sFw9kbd/ABTZUROFH2gUrCGBHsoP474+LfRUFuZJumSfFFq+3uNEUd7hhFOsCRwg/rVo3D6p6axzTSjwTfSqNHoZX0yBV61AtQNZQtOwmV/ZSTWCOudI4tqMt80hB8MVbG4t3xjIniLYYRk/sFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SUx6mtOi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706771597;
	bh=+R4/cooCCuK4cnjbDE/i4pYhhrE258IRPNaowXzJuKE=;
	h=From:To:Cc:Subject:Date:From;
	b=SUx6mtOi1Ji3hXD7sh/pC66Zg0d4uBN5I1A2UrMSGM+dTPItXm0p1+jzNuQ0pVRZB
	 IyPECVM1kXGi7FfVGN/ba2lh22wez2Ft1ck0eT5A8pjdndBOEoyBsNWxstZUOamLDi
	 XEPESDMo6Zk8GcsbtRXR3mxUIhcD3yNBI6tDU5j6Iz9vYVmMJ8H1V2TkvKNaeSMlMM
	 MYMJ+Z6UxKpOP8v753fmj9nJg19tNEeJAvO3AjXtQ5hOjhu02VFa4x64rwHKrzDENS
	 jf8zvdfOs0528ao91LXCW1ciTFF42O+fC4PlMovHXnsleKcdNI6tUII2UPniqDUU83
	 h5UmyAI/nl2pw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A5714378208B;
	Thu,  1 Feb 2024 07:13:14 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: on-fault-limit: run test without root privileges otherwise skip
Date: Thu,  1 Feb 2024 12:13:06 +0500
Message-ID: <20240201071307.592317-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmap() respects rlimit only for normal users. This test should be
run as normal user, without root privileges.

Fixes: b6221771d468 ("selftests/mm: run_vmtests: remove sudo and conform to tap")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/on-fault-limit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
index 0ea98ffab3589..431c1277d83a1 100644
--- a/tools/testing/selftests/mm/on-fault-limit.c
+++ b/tools/testing/selftests/mm/on-fault-limit.c
@@ -21,7 +21,7 @@ static void test_limit(void)
 	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
 		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
 
-	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
+	ksft_test_result(map == MAP_FAILED, "The map failed respecting mlock limits\n");
 
 	if (map != MAP_FAILED)
 		munmap(map, 2 * lims.rlim_max);
@@ -33,8 +33,8 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	if (getuid())
-		ksft_test_result_skip("Require root privileges to run\n");
+	if (!getuid())
+		ksft_test_result_skip("The test must be run from a normal user\n");
 	else
 		test_limit();
 
-- 
2.42.0


