Return-Path: <linux-kselftest+bounces-18204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CB97E5AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 07:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF7D1C20A3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC0184;
	Mon, 23 Sep 2024 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="H1cBJTb7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEEEAF6;
	Mon, 23 Sep 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727069943; cv=pass; b=Nuk3SV7Ut+jCNAMlMfWThKs35kaHFgsELy2LzRIELdKczI7CkWIXyP/LFMlfMZsp7vjTDlWUAIpE8K+U2Xj+is22JaiGrN2fXJ+E6/RZf3qXwE6Jywvc5UQRA5v1QewH8SbFZtqSyYcO4jks5/cWzW3bWrLfA95gCBkmm3ZvVhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727069943; c=relaxed/simple;
	bh=FJ2ttu3ymdbUtGl8rWp/seAINoEH0qpMdehsWGCuTjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avC4cIpIXIW6IFoMx132SzGFRu1QTYB3m49I9Uta5GS6KEippHM12jlDRlcxuwXEJA98LHlnwu/7xwGa1CWZP9CkitO58veoy58Qr+da8xe+yHKi15DaJ/jcJa74wNSlnhowPKyNRewzkHv5/pTYETPklapSfq3WAr8Tw1cTQFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=H1cBJTb7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727069929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z/8Bb/arnKe09EnTuqR2Yvj/va37Jm96E7h5HfhDvnFHWLeWUX3aEyA3bmv7XuAtmu+yTAUvBdbHBEk4bKirUgFA2ppPieA7wNn51MiyZ6W7w/gBHfsGoKV6OLBDVVOYvUYrjDdsHODik6gkcE5jxyp8Bsgv9drL+AZS3qw0s7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727069929; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PmmGSXySg6IlnsTDXpl7Bn2vkcG7CZ7INIi8sf8r2Gc=; 
	b=KLqIQfOyyngHtcEMhpmhYAJJ1fE+MY7LL3HVJFgtEcjH1n1FGOcIRtN2J9LJtj1PeLVWmJf/4gRrCytNrlguJYhpcn3mp7N+qiZh4k6YzznjYQEOGWJoL2dqia+QpEXeZOe0ioe+IVGA7rFRV31B7tov560HfTi3PaYrvXEeukM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727069929;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=PmmGSXySg6IlnsTDXpl7Bn2vkcG7CZ7INIi8sf8r2Gc=;
	b=H1cBJTb7AKHnE3gCNfJHz2jCquRTwqs2VdCWE+0d1tVoP7h7X7t+r4/BwlirNSyY
	1jEXzCmMGz0JujOQsPFHLcKljj8bBccKaCcb6kqBn8yGk13+vfThbIvCiiGZb889Qax
	oc5lPe+sspNpd2RjZFsHcw6HssV5IE9n+phvD4ds=
Received: by mx.zohomail.com with SMTPS id 1727069928216470.38431144075696;
	Sun, 22 Sep 2024 22:38:48 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kselftests: mm: Fix wrong __NR_userfaultfd value
Date: Mon, 23 Sep 2024 10:38:36 +0500
Message-Id: <20240923053836.3270393-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

grep -rnIF "#define __NR_userfaultfd"
tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
__NR_userfaultfd 374
arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
__NR_userfaultfd 323
arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
__NR_userfaultfd (__X32_SYSCALL_BIT + 323)
arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
__NR_userfaultfd (__NR_SYSCALL_BASE + 388)
arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
__NR_userfaultfd (__NR_SYSCALL_BASE + 388)
include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282

The number is dependent on the architecture. The above data shows that:
x86	374
x86_64	323

The value of __NR_userfaultfd was changed to 282 when
asm-generic/unistd.h was included. It makes the test to fail every time
as the correct number of this syscall on x86_64 is 323. Fix the header
to asm/unistd.h.

Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index fc90af2a97b80..bcc73b4e805c6 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <math.h>
-#include <asm-generic/unistd.h>
+#include <asm/unistd.h>
 #include <pthread.h>
 #include <sys/resource.h>
 #include <assert.h>
-- 
2.39.2


