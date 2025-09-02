Return-Path: <linux-kselftest+bounces-40631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA16BB40B7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E92203F08
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B3309DC6;
	Tue,  2 Sep 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="APL2fXEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5B2E2846;
	Tue,  2 Sep 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832576; cv=none; b=pXKDJHMIJrB9+J18Vvw8+4vYGAOIK9WUrc7zu9CTXL/QJBLpnjxQCL01+ZJ6W0kk2pJvAWB+kXQRgQ8pIEVQzb08DhzU580GchZ+sf+iTRzV2mOuqfClU++b17g1rBT8pz95BL3u2+HUMzjc56zKPDSvLayPIxQQw+XZJrUtobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832576; c=relaxed/simple;
	bh=/lPcINznypLsIR+LicOLSRXHwcVbhsz8Cxkle4+8hLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=am+CB2MG128tUaavcLEj+EMCpE6pH9V5C4vNsh5YIf0rh+aLh7Ns428+Pl3iorpnWlyJ0HQPbo2fprEzs3q8nl1tpiAIVqq/nUa4/7QYykeqxCzTAAewR9WkfaFPuSRXuf0bLDweWcdJP6GDnK16Esu7G2fGxQvpiDOG8kwv6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=APL2fXEJ; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832575; x=1788368575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XPeyg5ReUvA2UikBQ6V/HxX84Yk81qnsGCyL1gycA0E=;
  b=APL2fXEJ7OD3pH8v8jKekb5Yb3I+PHa2TXjIG/9+1Cz9aCVDaQop0LSO
   FRie7YLJSu52elf+WgR257Fkibim4agCVfNsPW1rvTwmR8Pa5zQsTO9Eh
   jlcBdfRqec6wBPijBKzYwvrQSeNj33pTXyEQt3/IBXKl5LTYCqjIyDQN+
   m9J87eM8/vkHvrSN3GMptbX5IUuCbBfMO7l8nfG6Uy3RP8pOLxOowpGdq
   07IQ5p2BjIjnnejL0HhlPPPSaElEsDfwSPr38OekUC/Qxiog8y6fRUttP
   oCSOvCbiUdnPcP1pGYUiaShFiEe00NuOmn2ITVkvtxRqEzekHcfEL6saA
   g==;
X-CSE-ConnectionGUID: 3Lv04L/iTOWmiBce61yBbA==
X-CSE-MsgGUID: oTvyL7cNTQa0mDo5NOcdpw==
X-IronPort-AV: E=Sophos;i="6.16,229,1744070400"; 
   d="scan'208";a="2234174"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:02:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8561]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.48:2525] with esmtp (Farcaster)
 id d7657a8d-c934-493d-a8ca-e1a001f7e449; Tue, 2 Sep 2025 17:02:53 +0000 (UTC)
X-Farcaster-Flow-ID: d7657a8d-c934-493d-a8ca-e1a001f7e449
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:02:50 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:02:48 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, "Will
 Drewry" <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, Christian Brauner
	<brauner@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 2/7] selftests: harness: Include pidfd.h to get syscall definitions from tools/
Date: Tue, 2 Sep 2025 17:01:39 +0000
Message-ID: <20250902170147.55583-3-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The kselftest harness uses pidfd_open() for test timeout handling but
may not have access to the syscall definitions in non-glibc
environments. Include pidfd.h to ensure the syscall numbers are
available.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kselftest_harness.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db..1dd3e5a1b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -69,6 +69,7 @@
 #include <unistd.h>
 
 #include "kselftest.h"
+#include "pidfd/pidfd.h"
 
 #define TEST_TIMEOUT_DEFAULT 30
 
-- 
2.47.3


