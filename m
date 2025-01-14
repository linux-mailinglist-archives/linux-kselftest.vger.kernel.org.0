Return-Path: <linux-kselftest+bounces-24461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F06A10BCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489AF3A1FDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007B1CB9EA;
	Tue, 14 Jan 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnFtEm18";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KnaL0Bqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1601A8F8A;
	Tue, 14 Jan 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870835; cv=none; b=Ufj9lzUQ9rnFWmRhwqB/jP2IF5VizdiXr/hj7ZwQRN2XHcwzrU67DdRY2lhhg/ML+aGWZ3mmCfkJbFV8NvLIeznif1Xi9eWSUBhNY14hXVlP3Dr5BTJ1uQQugEDRjEys9gsKPUq1qJPk8B6OELC0a521hPTtZ2fiZW3OG5Rijfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870835; c=relaxed/simple;
	bh=dH3RzX1kWHmc070i/rqPW6ADGmajD2eJb8ZOtqkz4DI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXbMNm4EoEUPHMaZgm5Wkg4biHnW10fd6o+c3qzxiVJ5FzADcErDVX13mTPdcFSkq3OOqTn82ovPDYhYCQxcX+AbNyQRw0fjAQ9EEiDiXx+EDdPK0GIaAZlXb/iEd4NcYpKrG/fi2w6AXuv29vfCr6K9LT00uNfhGhmfAbdNeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnFtEm18; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KnaL0Bqp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736870831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RpmujbkErM0AyBS/jsicWpVLkLAFbMaYP9rwEqJEd4=;
	b=cnFtEm18MbrSTZZNuEaTkbh1BCcJt6ODsBTtckfbbeBTuMwWvfgoDH3wreQrDdYd1I0hw8
	97ExHGFWJLfiU6XcyeJtpAwoC0Qz1BIovPU4xCrc8zfK7umEq2FCW1b9xv3S92UJChPxeI
	tKtUWD1C7mvfBy86MAPmtENlpMqANSi8EfbAps+ZDGu9SEPH548AoatKNvljt7zOw90zTk
	oTEyluL2uULENRWrH4iVCaTTYUj05nGT4qftjRCQp0nC+/v0mveb4TPDoLF3HpAt3N8xVE
	QXHaHQqJ10QuHj+hBWYkwwD9Srq37GiphfOKHOOYwuSSW0V8RyGLEC17HbnREA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736870831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RpmujbkErM0AyBS/jsicWpVLkLAFbMaYP9rwEqJEd4=;
	b=KnaL0Bqp9VgUi6gfGyMii2Jd+8VSJEQIwpet4OdI32Z/16BYWMCnsNmSsVtWJTtQZh+xOC
	Zg4dYFNssdyZ38Ag==
Date: Tue, 14 Jan 2025 17:06:48 +0100
Subject: [PATCH v4 4/4] selftests/mm: virtual_address_range: Avoid reading
 from VM_IO mappings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-virtual_address_range-tests-v4-4-6fd7269934a5@linutronix.de>
References: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
In-Reply-To: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>, 
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736870827; l=4152;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dH3RzX1kWHmc070i/rqPW6ADGmajD2eJb8ZOtqkz4DI=;
 b=xQ+14+XJAZIgmtLRSLuvQ0RJRXCT1ZR5pG5JrfZEm4tjhZLiKT2rLZ0+9AZVNI24R/g7D4PPN
 oQPBYszSdrkDyMlNo2pPeLn+tt9sG8qIS0glZuGpfXKUlxWf9D0u92u
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The virtual_address_range selftest reads from the start of each mapping
listed in /proc/self/maps.
However not all mappings are valid to be arbitrarily accessed.

For example the vvar data used for virtual clocks on x86 [vvar_vclock]
can only be accessed if 1) the kernel configuration enables virtual
clocks and 2) the hypervisor provided the data for it.
Only the VDSO itself has the necessary information to know this.
Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
the virtual clock data was split out into its own mapping, leading
to EFAULT from read() during the validation.

Check for the VM_IO flag as a proxy.
It is present for the VVAR mappings and MMIO ranges can be dangerous to
access arbitrarily.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Suggested-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/lkml/e97c2a5d-c815-4936-a767-ac42a3220a90@redhat.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
I left out the comment about the requirement for check_vmflag_io() to be
called with the start address of a mapping.
It's the same for the check_huge_*() functions and there it's not
documented either.
Also there is only a single, correct user and any misuse will instantly
result in visible breakage.
---
 tools/testing/selftests/mm/virtual_address_range.c |  4 ++++
 tools/testing/selftests/mm/vm_util.c               | 24 ++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h               |  1 +
 3 files changed, 29 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 386e4e46fa65b98af78dee4bb30144eb2b51f528..b380e102b22f0a44654ab046f257e8c35e8d90e9 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -15,6 +15,7 @@
 #include <sys/time.h>
 #include <fcntl.h>
 
+#include "vm_util.h"
 #include "../kselftest.h"
 
 /*
@@ -159,6 +160,9 @@ static int validate_complete_va_space(void)
 		if (prot[0] != 'r')
 			continue;
 
+		if (check_vmflag_io((void *)start_addr))
+			continue;
+
 		/*
 		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
 		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index a450ab353f8e710a6bfce347bc3a7309920c70f5..8bd2c5e59bc73bdfa617d4b11b448da84e2a3daf 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -400,3 +400,27 @@ unsigned long get_free_hugepages(void)
 	fclose(f);
 	return fhp;
 }
+
+bool check_vmflag_io(void *addr)
+{
+	char buffer[MAX_LINE_LENGTH];
+	const char *flags;
+	size_t flaglen;
+
+	flags = __get_smap_entry(addr, "VmFlags:", buffer, sizeof(buffer));
+	if (!flags)
+		ksft_exit_fail_msg("%s: No VmFlags for %p\n", __func__, addr);
+
+	while (true) {
+		flags += strspn(flags, " ");
+
+		flaglen = strcspn(flags, " ");
+		if (!flaglen)
+			return false;
+
+		if (flaglen == strlen("io") && !memcmp(flags, "io", flaglen))
+			return true;
+
+		flags += flaglen;
+	}
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 2eaed82099255e09ffd38ad9714994397f304685..b60ac68a9dc8893895f49946b258260f7a82218a 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -53,6 +53,7 @@ int uffd_unregister(int uffd, void *addr, uint64_t len);
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 unsigned long get_free_hugepages(void);
+bool check_vmflag_io(void *addr);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size

-- 
2.47.1


