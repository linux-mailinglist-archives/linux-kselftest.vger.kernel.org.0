Return-Path: <linux-kselftest+bounces-24365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACDA0B802
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD513A93AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE92451FC;
	Mon, 13 Jan 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOd1+oYb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4WUy0BVW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BA24B28;
	Mon, 13 Jan 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774236; cv=none; b=QRBCsWntBbw5J85d52BzBPGlg9v6MvbjrJe76L7D2BPwY0Ojw7omPLjK/ktGIbZz498BNLeBiu3YovVI8At4jC+AwrY6+msf9P9+5n/Hx4lVrh6m3YJtw6K16bRi6DKJ8D753APCVlJtTexWNE/ijED2Y0BuTAfItW8zujetTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774236; c=relaxed/simple;
	bh=4PwI9Ccn5M7eMxfUmG8BWAwz4GRkkm02QUveGYfCnxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBrgbRluhDp77Eh1sJ/5UQs1OYgGIzrEFZGnQLeWjPJjhwqk53CEu2imBMGkbEWUBvTGloVyirrQvOaS0n1FzcvcZblEyoW4f3dwH7mFU6b83BV6vsHzskYr5cvE1V3LQ7aTg0+ITJRbw1FSt/rG5OCH33S8gPFZOp7E9c6iTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOd1+oYb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4WUy0BVW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736774233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqkR3Vf3Utpm6qqhuJmf9/1TcUxTIh5FO0zgNY2iBlQ=;
	b=tOd1+oYbaw93xI5qiPtbOLngwYfXVaCDgpIb0F1rOhjs9p2VWQsgJU8vJnllZX7z5BAL/S
	lNcAVwjI7RNiLWH69IWcGQGISkmh0cJeeFdJohCBn9Ev0akqMBoTZsEtKugqXkaIUQIMbA
	Y0JLN/xKfRZLpa+XIz6yt+0rv8gmuwgXoIDcv2bwgljVfOM5lxDsD35nCnCXzHdqay88Bw
	wsMrnqYQGPhArtr8ejOSDsRhii0cx8/jEyFDE06fZo8gIcL8oH8dZtffl41RDRAHPI8xbE
	RsP1TvFYfLiGegojESCE2ZOvE+xxuo8PhYvnxcvx/D61mjmfyrrYjPiCVD4Ayw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736774233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqkR3Vf3Utpm6qqhuJmf9/1TcUxTIh5FO0zgNY2iBlQ=;
	b=4WUy0BVWvBSBOdixeQzZNV2YvPplN6D1GIvqp47n45grd+/sld7MFBsaL5fjWk6wiukVtK
	PJw7pr58sz4JilAQ==
Date: Mon, 13 Jan 2025 14:15:38 +0100
Subject: [PATCH v3 4/4] selftests/mm: virtual_address_range: Avoid reading
 from VM_IO mappings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-virtual_address_range-tests-v3-4-f4a8e6b7feed@linutronix.de>
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
In-Reply-To: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <oliver.sang@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736774229; l=3934;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4PwI9Ccn5M7eMxfUmG8BWAwz4GRkkm02QUveGYfCnxc=;
 b=xbBux7r8n6o18h59gp/9UfYQ+pHgD0rP3QBiHdmTwKMk9vdZ/SHtmSYtgzFGZcQ52GrBGiPKZ
 YYGMIiM1TpWA/PGh6exbFX6/gcaT+cXJ6QBX0kjNQWFo+32arGd47fF
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

Revert "selftests/mm: virtual_address_range: Avoid reading VVAR mappings"

This reverts commit 05cc5d292ac4238684b59922aecf59c932edefa0.
---
 tools/testing/selftests/mm/virtual_address_range.c |  4 ++++
 tools/testing/selftests/mm/vm_util.c               | 21 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h               |  1 +
 3 files changed, 26 insertions(+)

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
index 8468a19d6acca10c7e9228c03a935cdeb2402b5d..161fe03b07af78244efc669a36155ad603fa6f7d 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -400,3 +400,24 @@ unsigned long get_free_hugepages(void)
 	fclose(f);
 	return fhp;
 }
+
+bool check_vmflag_io(void *addr)
+{
+	char *saveptr, *flag, *strtok_arg;
+	char buffer[MAX_LINE_LENGTH];
+
+	strtok_arg = __get_smap_entry(addr, "VmFlags:", buffer, sizeof(buffer));
+	if (!strtok_arg)
+		ksft_exit_fail_msg("%s: No VmFlags for %p\n", __func__, addr);
+
+	while (true) {
+		flag = strtok_r(strtok_arg, " ", &saveptr);
+		if (!flag)
+			break;
+		if (strcmp(flag, "io") == 0)
+			return true;
+		strtok_arg = NULL;
+	}
+
+	return false;
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


