Return-Path: <linux-kselftest+bounces-24594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367EA12AA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4813A48B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39231D5ACD;
	Wed, 15 Jan 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JSWe5sVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA124A7D3;
	Wed, 15 Jan 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964864; cv=none; b=d3c4BVeZcZ8k3sRaAMaSfD1O2r2EpiW2EWF1CClbPN5lryKrmF/Xw7imjsk5mwqYOUoJoaXTgUsAr4R934ummy6a4vbavpFsZVqZRlYEVYSdE/YMBEKp7MtwNBQQhVSXem63NT1VZWNZ054q5Idh3qvmYcWRNWuJvRjNK6hnuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964864; c=relaxed/simple;
	bh=gCyW+qFefQLCZCdyZmgttG6Uv6bmyarn6x6WAQfoxvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrRi17FbBW0fZyBXoPi9Y12hCdtqYfT20tWpapVobahrcbODCLRjl1iH4HX4XXe6HkT7VDfYVrvvs2OJ0Q0ZIQmlg9y/UwOU2UIKWGMpxYWRyA+6s1A4ScqLvqS3zZfnIvjNLfo90G56UGtF8oBJHNHnbMR8a3o5NmFaUzsK69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=JSWe5sVY; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2589; q=dns/txt; s=iport;
  t=1736964863; x=1738174463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcR7ArXYthKmMKSfoAEeX8zvPOHz40yremfyEvSSaxI=;
  b=JSWe5sVYMiDIO8P66syXh2mQCWHpSiRrG9yhqGCC8+7Y39AbQ99eDIsU
   9chrboUGiYJQTAac1XwVECX+olzRgCFzc7gjTnyl1GGrkRNPyBJPehKq0
   xQbuqsfXeSIQwNMi1i1aZKVkA8uIypMX9+iOUmHE25bIKCoNvLZRZtPcf
   g=;
X-CSE-ConnectionGUID: HcwUuyqbT8Wy5YZaiEPbZQ==
X-CSE-MsgGUID: JY/pPRsZRa2LSRxU67Eghw==
X-IPAS-Result: =?us-ascii?q?A0AUAADl+Ydnj5D/Ja1aHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?AYBAQsBg0BZQ0iNUacOgSUDVg8BAQEPOQsEAQGFBwKKcwImNQgOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwUUAQEBAQEBOQVJhXsNhlsCAQMyA?=
 =?us-ascii?q?UYQUSsrBxKDAQGCZAMRs2WCLIEB3jOBZwaBSAGFaodfcIR3JxuBSUSBFYNog?=
 =?us-ascii?q?mECAgGCKoV3BIN3g26LFJNwSIEhA1ksAVUTDQoLBwWBOTgDIgsLDAsUHBUCF?=
 =?us-ascii?q?R4PBhAEbUQ3gkZpSTcCDQI1gh4kWIIrhFyER4RTgkdUgkeCFHqBF4Q9QAMLG?=
 =?us-ascii?q?A1IESw3Bg4bBj5uB5s2ATyDcXsUK4ERgT0spQqhA4QlgWOKNZUuGjOqUy6HZ?=
 =?us-ascii?q?JBqIo1ilkOEZoFpATeBWzMaCBsVgyJSGQ+OOh+IVrtBJTI8AgcLAQEDCZFxA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:pZTH86/vI430WSYXdgxCDrUDBn6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WRKWTyAb6uOazTyfNp0aN6/909Xv5HXnIVkGVQ/qSlEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qpyyHjEAX9gWMsaztJs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kWNpIl5/duC10ey
 u1FGQIEbz27jdCPlefTpulE3qzPLeHxN48Z/3UlxjbDALN+HtbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0En1lQ/UPrSmM+qgXn5fzRcpXqepLE85C7YywkZPL3FbIOEJITaH5kJ9qqej
 kD3uHzBOAooDtXF7QG/4k/y2cLAnTyuDer+E5Xjq6Y12wfMroAJMzUNWVWTr/68i0W+VswZL
 kF80jUvqaw/8UaDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkAfTiNIaPQludUwSDhs0
 UWG9/vtBDpyoPiWRGib+7O8szy/I24WIHUEaCtCShEKi/HnoYcunlfMVdtnHrK4lcHdBz792
 XaJoTI4irFVitQEv4298EzLjiyEuJfEVEg26x/RU2bj6Rl2DLNJfKSy4lTdqPIFJ4GDQxzZ4
 z4PmtOV66YFCpTleDGxrPslPLq22uuUKTfg0WF+QqgT/jWAw3SRRNUFiN1hH3tBPsEBcD7vR
 UbcvwJN+ZNeVEdGi4cpOOpd7Ox0lsDd+cTZaxzCUjZZjnFMmO67EMNGOBL4M4PFyRREfUQD1
 XGzKprE4ZEyUvsP8dZOb71BuYLHPwhnrY8pebj1zg68zZ2Vb2OPRLEOPTOmN79isvPU/1yNq
 IwDaqNmLimztsWgOkE7FqZOfDg3wYQTX8meRzF/L7Tae1Q6SAnN9deOmu18JOSJYJi5Zs+To
 yniARUHoLYOrXbGMg6NImtyc6/iWI03rHQwe0QR0aWAhRAejXKUxP5HLfMfJOB/nMQ6lK4cZ
 6deIa2oXK8QIgkrDhxBNvERWqQ+L0zz3Wpj/kONPFACQnKXb1aToIe4J1G+pHVm4+jenZJWn
 oBMHzjzGfIrLzmOxu6NAB5z5ztdZUQgpd8=
IronPort-HdrOrdr: A9a23:6rnl6a1u1faI8JOl/tQ8AQqjBLUkLtp133Aq2lEZdPWaSKOlfq
 eV7ZMmPHDP6Qr5NEtMpTnEAtjjfZq+z+8Q3WBuB9eftWDd0QPCRr2Kr7GSpgEIcBeRygcy78
 tdmtBFeb7N5ZwQt7eC3OF+eOxQpuW6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3AbaRCMGnOxQ2sAga8zK3dLeKK+X7XOV3W00rNMla?=
 =?us-ascii?q?yNTZWWeCke1aR1ZtuofM7zg=3D=3D?=
X-Talos-MUID: 9a23:peoIZAu67CKIZh5rns2npgAlLP9S+JaUARopqq8WhpfbGCNwJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,207,1732579200"; 
   d="scan'208";a="419608244"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Jan 2025 18:13:14 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTP id C67341800021F;
	Wed, 15 Jan 2025 18:13:14 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id A15FB20F2004; Wed, 15 Jan 2025 10:13:14 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: shuah@kernel.org,
	kuba@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	John Daley <johndale@cisco.com>
Subject: [PATCH net-next 1/1] selftests: drv-net-hw: inject pp_alloc_fail errors in the right place
Date: Wed, 15 Jan 2025 10:13:12 -0800
Message-Id: <20250115181312.3544-2-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250115181312.3544-1-johndale@cisco.com>
References: <20250115181312.3544-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-07.cisco.com

The tool pp_alloc_fail.py tested error recovery by injecting errors
into the function page_pool_alloc_pages(). The page pool allocation
function page_pool_dev_alloc() does not end up calling
page_pool_alloc_pages(). page_pool_alloc_netmems() seems to be the
function that is called by all of the page pool alloc functions in
the API, so move error injection to that function instead.

Signed-off-by: John Daley <johndale@cisco.com>
---
 net/core/page_pool.c                                    | 2 +-
 tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9733206d6406..a3de752c5178 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -595,13 +595,13 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_netmems);
+ALLOW_ERROR_INJECTION(page_pool_alloc_netmems, NULL);
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 {
 	return netmem_to_page(page_pool_alloc_netmems(pool, gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
-ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
 
 /* Calculate distance between two u32 values, valid if distance is below 2^(31)
  *  https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution
diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
index 05b6fbb3fcdd..ad192fef3117 100755
--- a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
+++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
@@ -21,9 +21,9 @@ def _enable_pp_allocation_fail():
     if not os.path.exists("/sys/kernel/debug/fail_function"):
         raise KsftSkipEx("Kernel built without function error injection (or DebugFS)")
 
-    if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
+    if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_netmems"):
         with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
-            fp.write("page_pool_alloc_pages\n")
+            fp.write("page_pool_alloc_netmems\n")
 
     _write_fail_config({
         "verbose": 0,
@@ -37,7 +37,7 @@ def _disable_pp_allocation_fail():
     if not os.path.exists("/sys/kernel/debug/fail_function"):
         return
 
-    if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_pages"):
+    if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_netmems"):
         with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
             fp.write("\n")
 
-- 
2.44.0


