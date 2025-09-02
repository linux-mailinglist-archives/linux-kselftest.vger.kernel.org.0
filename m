Return-Path: <linux-kselftest+bounces-40633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3688B40B83
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDBE4E71BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670E30F542;
	Tue,  2 Sep 2025 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bs4V7bDJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F662DE1E3;
	Tue,  2 Sep 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832631; cv=none; b=tb3Vmu+15jGx6QKoGtQYyANSeVuHLXN/gJZjNfD69jWLfvcVdoTPdcnKVE5ZfuBJ23C9O5O7YRnwO7k5GWisyBfTZ7OBhoBTp95EqoCoG0UN4azzWoTqF7C87ZqtDg593sc2Bo4U8/kvRtKol0QJLLsFjiS1QvjKXDRNc41q50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832631; c=relaxed/simple;
	bh=5xYildeBtV7+wKmq5h/GNncZ59x6c36yXdu5MireVXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsljVMcI/U4qLLyGe7Di97shdl3ASLQxGWsijb9jlAOLie3P++W06lOofJIM5L8gOe7/L+ALKsuaxBsWUwuGjyyKiBM4g8YckzXEUcNn0m22ki3Ma0IrDn+ehy5KSHrT6wD9m+e3TenRNBDCjCm/gjim0c5IB3aY+zvZJtpWLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bs4V7bDJ; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832630; x=1788368630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5flslzb4sgnNMOnM+YuL8Hxh+/X8C4hiTYYv7c42G1Q=;
  b=Bs4V7bDJufL/xK1p8PmxppMf5djWCEzZ+5NYGPG0CjErY2043an5hcaA
   XcuK7CMcPmo32l1YYGwXcdmNtHbUnj8+ieEtx4hPXF7PAYcVFC2scXl+E
   ecxIZdFcYftb+LeXbZN9d3b0TdFbBnvrvLeEXUt631h9HiPRaFAeEZOla
   /CICNHrI7Y/fE/LhsFqW2I4ADBlqXuKkcZn7KhNVE6CFvABE15WVmx2t1
   2bY8LdQeNlq90xYpSGLPeaXIcAZxbizOTwn3X/diG2w/wYcyyuXdXW1fT
   N+T1EW5IXgWhSXoS415BQ5LXZ1Kb9gkMpoR6XlfApvKL3ate87zvlYZKl
   g==;
X-CSE-ConnectionGUID: HEmmOvOURGiGFeqw7N/Jzw==
X-CSE-MsgGUID: kx5pj1avQlC6oZw7G8ScZw==
X-IronPort-AV: E=Sophos;i="6.16,202,1744070400"; 
   d="scan'208";a="2232791"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:03:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:50833]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.92:2525] with esmtp (Farcaster)
 id e3aa4250-a948-4106-93f6-960edee2c2b0; Tue, 2 Sep 2025 17:03:47 +0000 (UTC)
X-Farcaster-Flow-ID: e3aa4250-a948-4106-93f6-960edee2c2b0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:03:47 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:03:46 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 4/7] KVM: selftests: Add backtrace fallback
Date: Tue, 2 Sep 2025 17:01:41 +0000
Message-ID: <20250902170147.55583-5-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250902170147.55583-1-aqibaf@amazon.com>
References: <20250902170147.55583-1-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The backtrace() function is a GNU extension available in glibc but may
not be present in non-glibc libraries. KVM selftests use backtrace() for
error reporting and debugging.

Add conditional inclusion of execinfo.h only for glibc builds and
provide a weak stub implementation of backtrace() that returns 0 (stack
trace empty) for non-glibc systems.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kvm/lib/assert.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658..c9778dc6c 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -6,11 +6,19 @@
  */
 #include "test_util.h"
 
-#include <execinfo.h>
 #include <sys/syscall.h>
 
+#ifdef __GLIBC__
+#include <execinfo.h> /* backtrace */
+#endif
+
 #include "kselftest.h"
 
+int __attribute__((weak)) backtrace(void **buffer, int size)
+{
+	return 0;
+}
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
-- 
2.47.3


