Return-Path: <linux-kselftest+bounces-41976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D96B8AAE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADF216FF4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437D31DDA4;
	Fri, 19 Sep 2025 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZRMKzEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF623BCF3;
	Fri, 19 Sep 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301421; cv=none; b=biojdR7N/STblKyhfyhGb/9CJL5eBNybVfykQTUQ+QEIOoix9CSMom6IDGfbyvT5Se2FgwFFpsT+zwrU5N1asu617NxZNnXqcUohK7/nYP8f33c3K2bdnB2bm5AEwB1AQbosxzK9q5MDfod4eKRDqK6Uzw9kxeTUXixTQcvaxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301421; c=relaxed/simple;
	bh=egBRak+pgEmI39GPWN74tSeQk2eoovRtS1aoXXmXZK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOqRreNDdDG6nX3QUxeA+BdZLKwMVHNOd3rjNRE+0zLlPnEBa8tCFaqXLI9nVesz6Vts2W7alWcM8KnFlu8yG59Rp6/4R9rrqD9ap01/TG4tchO84uGqJeH2CCfp2T/adi941PG/qANqQQLcyT6lsyTnSf4Ntmr4QjGn9/1eWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZRMKzEf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758301420; x=1789837420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=egBRak+pgEmI39GPWN74tSeQk2eoovRtS1aoXXmXZK8=;
  b=ZZRMKzEfZeOk2/u/pkh8rzTSy4/xI9HThvVGEP5k5gJXSud42J59/6mz
   GcGiD0obMeRtJt9yTtONPoMNpxmB3EpBQrRTklcMS/2DOGPSbKxUEDDqC
   ui9Met2w/IWrv8GI7A8aE8XAVhpdhGdMRDKhh7a2fOE1CfLl3op0ibggG
   1ocjYZjt9A7dYxQz6kw0xWyy29rpE7+IAtqVmiAtsN+Ym8RyjYw3GAjhj
   807pSU5YqWcPKYI5REqZS5hU9fAsd/oAND+KzDvp74LfRg+E3sJmTKtHA
   wTajV9DbVqsOj4FdT6wbFdpAFPkCE5uUqQO6P/H3YVyJImtlUCRWfMMmM
   A==;
X-CSE-ConnectionGUID: SvqzQAFyTm69UPZxlyqy4g==
X-CSE-MsgGUID: pp2jIikzTimW8QMGKxdGgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78257336"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78257336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:03:39 -0700
X-CSE-ConnectionGUID: a0BIc21qTYmOjQliRJAt+w==
X-CSE-MsgGUID: KzNJtFETTtmEk7YMJtF0Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175444812"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 10:03:39 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Cc: Simon Horman <horms@kernel.org>,
	Dylan Yudaken <dyudaken@gmail.com>,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	Ricardo Canuelo <ricardo.canuelo@collabora.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v2] selftests/kexec: Ignore selftest binary
Date: Fri, 19 Sep 2025 10:01:39 -0700
Message-ID: <20250919170139.3452889-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dylan Yudaken <dyudaken@gmail.com>

Add a .gitignore for the test case build object.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
The binary creates some noise. The patch to fix that seems to have
fallen through the cracks. Sending another revision with an expanded Cc
list.

v2:
 - Pick up the review tag

v1: https://lore.kernel.org/all/20250623232549.3263273-1-dyudaken@gmail.com/
---
 tools/testing/selftests/kexec/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..5f3d9e089ae8
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_kexec_jump
-- 
2.43.0


