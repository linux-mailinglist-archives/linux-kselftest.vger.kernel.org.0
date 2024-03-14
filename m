Return-Path: <linux-kselftest+bounces-6320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F187BA99
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A25D1F21A56
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC366CDC7;
	Thu, 14 Mar 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fl4pEshf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69475D478;
	Thu, 14 Mar 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409222; cv=none; b=HNAy2Q4ODLOVi1fa9Fe9aSMkgLrGhcmrFzLGaDNkFy0J2L+b4XTMX5sEhsENLh9EtQYZbn/1OD2VlbtqSBqXgKJatv0/uzAFoEf+cfaK7ptmxL5igLNFX5B6QVMc3wrlcOuxsLu9m9ri32+FLmRTK4587k1Iatojw3MtOGkMKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409222; c=relaxed/simple;
	bh=Hl7jmLGK4iDneFMK0s8y3NXOTrwEV3hV/7n5zpdoeak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fKMU11OfY/TuHk2uSvUxgeGIfevgM1RPtU97dhYqY+DrOv6ULDTAmZ1EHOnd/tu1Jnzfgdo9CfyW0r9T2A4qO389CdJWVZvXfGABdxqmZB0H2VBX6YQKXJNQaJsnmHJbNe8hKHqXFjfQnROzTea04l9h5YK9pih68LXqZMl2V+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fl4pEshf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710409219;
	bh=Hl7jmLGK4iDneFMK0s8y3NXOTrwEV3hV/7n5zpdoeak=;
	h=From:To:Cc:Subject:Date:From;
	b=Fl4pEshfn7A20AORpI8jlcZZgtt8ypOPJ8u/pHZIuj3dO4UP9RXs3Ryt6663zPgMS
	 Zfn5qk3IOJ/1PPhW24QJsdEj8YWGI5RMevBgXiN2FoRwP2Ny9eV33Q1B7zy5tWjqE4
	 eOmNxyYzDNnJ1tU4D2O7yIQU5nDJnYRZ4EyQOpRp/kSaghgeoKarTQFYF//ut9CC8S
	 AwPUoBV1GBmvbFdskNNJLQFchj3jSnooiSEzVT6ZBXnWaJrM8BbXIARAbEd4wEKmAK
	 PBWR2JSbeKD1urf75RGnIbpS1dEioRdfbbAfC+Zrek+j+DQNcg+62Y6HrRSvY8990p
	 vPn1iZUM2b3vA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D99DD378148F;
	Thu, 14 Mar 2024 09:40:16 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	Joey Gouly <joey.gouly@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mm: restore settings from only parent process
Date: Thu, 14 Mar 2024 14:40:45 +0500
Message-Id: <20240314094045.157149-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atexit() is called from parent process as well as forked processes.
Hence the child restores the settings at exit while the parent is still
executing. Fix this by checking pid of atexit() calling process and only
restore THP number from parent process.

Fixes: c23ea61726d5 ("selftests/mm: protection_keys: save/restore nr_hugepages settings")
Tested-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/protection_keys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index f822ae31af22e..374a308174d2b 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -1745,9 +1745,12 @@ void pkey_setup_shadow(void)
 	shadow_pkey_reg = __read_pkey_reg();
 }
 
+pid_t parent_pid;
+
 void restore_settings_atexit(void)
 {
-	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
+	if (parent_pid == getpid())
+		cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
 }
 
 void save_settings(void)
@@ -1773,6 +1776,7 @@ void save_settings(void)
 		exit(__LINE__);
 	}
 
+	parent_pid = getpid();
 	atexit(restore_settings_atexit);
 	close(fd);
 }
-- 
2.39.2


