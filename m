Return-Path: <linux-kselftest+bounces-17808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9B9766B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D64B1F23204
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6019E999;
	Thu, 12 Sep 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="e2TRZQr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B913CFA1;
	Thu, 12 Sep 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137146; cv=pass; b=o4YNT3bFcCuRkaRXc9BLuMnAXvCXwBMurztWMx5QUbTchF1UQAQsLCeZxd5KoU/i9C5piF9iiwpbMx0mPxVO3qSpwz9+S33s4V16ufms3BLUCQAx4bdjZHeRaHW60KYS8UvHJzi9L8ZAIblEBGADvOBtFmTeUnE/14K2fFDN1TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137146; c=relaxed/simple;
	bh=wrOvMTsKo89JuQDDhytUyy/Pidvq/U+YW5uDl12sLss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RCuQDoUUweHZn8U40CzOGBdNauRb4wBprbKktkcfrb6DN4UYdSbxjeX9EFzh2gt79l1OSFEp/4tcgdUp8I+hT4XScSiT8Bzg/VHBRgOErX3RHwjI4avfv/2MSIQ0Jo1et06xgLTZnP8BZ+NaC0z2Dpc6UzXugnEMvbjfooAoo2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=e2TRZQr/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726137130; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RlYm7u7SMBhk0LuIugtq4SXm4HYtJXpT8yia0yEFmQxY25tRaMjkzcKqUm30r3PF7RODsaPYJHN7zkDZBZ7O5BFJ5hblHpgygcJ8fWum7wDW58r7KuPPaZgSYwcNg6E3+r2EFB2zP8P1M/NZXUuZM+EhLWe9tdCvvu+K/zlGpf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726137130; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sX6XdYPdKt8M/QjL3pAJvuYwS/g9NNTL3XgnNJSx6Kg=; 
	b=WAoWF42/TJkBpaFtD/hi24fuTN9JChZuUVSLi0Mces/C1Kd9matqhJgqI14ki7UA6kjDq73oMgYMjoJgRZrcipSeKYu0AxA7T6azlkYKr7M/uKujOSqypxxbaFUmecOjJOkjC9IytO22E5/X8Rcy6z5jg70cAPrlFpPyX+zcmYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726137130;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=sX6XdYPdKt8M/QjL3pAJvuYwS/g9NNTL3XgnNJSx6Kg=;
	b=e2TRZQr/DcGBbq0jnbHVUpAfvS4OpabrehWmRqLZIoiyjMWiUDwONDvPj8lk8XqR
	YlOMbaGTlngtFj8HDOS1GYawLSwvaJjLIQ0JzakweOIcbaeAcHcoKiUzrBGj6ErD28q
	VQB9/bEE4FB8xM3Z1zPn9kufsXu6kZUcFot5IUxM=
Received: by mx.zohomail.com with SMTPS id 1726137128941470.6763680002151;
	Thu, 12 Sep 2024 03:32:08 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
Date: Thu, 12 Sep 2024 15:31:50 +0500
Message-Id: <20240912103151.1520254-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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


