Return-Path: <linux-kselftest+bounces-48422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0BCFF001
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA18A3001FF0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEAF34DB70;
	Wed,  7 Jan 2026 16:49:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B71D9663;
	Wed,  7 Jan 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804547; cv=none; b=jjvOmRMb2BWArfdWfQZu8S+uJEL/AP/g9D2w6d+137OXWFDTH7eEiF6eM35xux1v1c7D4PUEdyu/dfAdW/iJ4ASWJEc8d0PWnTXQxWCXmKel00VuBuYH4GNMck9/vjpdMHj3b8Sbyl74+9jEOooGBnAPp7xjZk1bt7aglAej4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804547; c=relaxed/simple;
	bh=cBc+ufD4FRgKpFnCsOOWFlNaSm3j1ngJiKwdJHI4Mbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsc+1nRs5iSYiVBRlmxvbQNOZtvIp5vqoTXS24dWilnoHCLwku01PdEP866xD99VmJC6j2yQWXbbspqtX3txBF0NnzmWqkt1HbUue4JAgebfpGXqkKLQlFgNvwD8M6vQT8h66yMVUBMjfCu3qc2/dNBL8jJCA/hGkig/DclbMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10BF6165C;
	Wed,  7 Jan 2026 08:48:49 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DF0F3F5A1;
	Wed,  7 Jan 2026 08:48:54 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/8] selftests/mm: pass down full CC and CFLAGS to check_config.sh
Date: Wed,  7 Jan 2026 16:48:37 +0000
Message-ID: <20260107164842.3289559-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107164842.3289559-1-kevin.brodsky@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_config.sh checks that liburing is available by running the
compiler provided as its first argument. This makes two assumptions:

1. CC consists of only one word
2. No extra flag is required

Unfortunately, there are many situations where these assumptions
don't hold. For instance:

- When using Clang, CC consists of multiple words
- When cross-compiling, extra flags may be required to allow the
  compiler to find headers

Remove these assumptions by passing down CC and CFLAGS as-is from
the Makefile, so that the same command line is used as when actually
building the tests.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/Makefile        | 2 +-
 tools/testing/selftests/mm/check_config.sh | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 4e5c8a330a0c..de4afc34e3b1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -230,7 +230,7 @@ $(OUTPUT)/migration: LDLIBS += -lnuma
 $(OUTPUT)/rmap: LDLIBS += -lnuma
 
 local_config.mk local_config.h: check_config.sh
-	/bin/sh ./check_config.sh $(CC)
+	CC="$(CC)" CFLAGS="$(CFLAGS)" ./check_config.sh
 
 EXTRA_CLEAN += local_config.mk local_config.h
 
diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
index 3954f4746161..b84c82bbf875 100755
--- a/tools/testing/selftests/mm/check_config.sh
+++ b/tools/testing/selftests/mm/check_config.sh
@@ -16,8 +16,7 @@ echo "#include <sys/types.h>"        > $tmpfile_c
 echo "#include <liburing.h>"        >> $tmpfile_c
 echo "int func(void) { return 0; }" >> $tmpfile_c
 
-CC=${1:?"Usage: $0 <compiler> # example compiler: gcc"}
-$CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
+$CC $CFLAGS -c $tmpfile_c -o $tmpfile_o
 
 if [ -f $tmpfile_o ]; then
     echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
-- 
2.51.2


