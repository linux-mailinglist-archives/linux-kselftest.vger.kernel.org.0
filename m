Return-Path: <linux-kselftest+bounces-40635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F08B40B8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB673B8DA7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8B337686;
	Tue,  2 Sep 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TGOm3OvV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37592DE1E3;
	Tue,  2 Sep 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832697; cv=none; b=LGDizI5tbtyKKhQAlKgmUBi4D8v6PL9jAPauols3SzH9xFbWZJW4ATZe579Yo55AsbdvFP9ZgTytyxXymHzRvVw/3XwcxVrJj7JYlWlBnC9lAtF1Mn8teTMSG26V+/YGcQ3Gryu0uAt1MML+Noo8pASEP2KCxZLk1meKNf6/lao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832697; c=relaxed/simple;
	bh=hIa5NZU+ptvi1P/zFOZ5CtZWga0YAxQCOdDW4ZvuWO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRcgoy6dTYfNqHx1h0Zj6zuc26tMoaTiIlb4Fc19CT11bVBSHG69r2PoeFuOcdRlYEVa3buDFC3xK/XFPrZ1wPp7wNNHqWArRrgrHM04OuHN7Rjxh+2ZSBnEZKeJ2mmO+n4CjHrxPck24ks6QAgxWxHdvVhbvCZ+GYDBTCZRvmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TGOm3OvV; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832695; x=1788368695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YpejAOHmJFdr8XoS0TAI0Co6Y45l6RAHR2x4MxMh/I=;
  b=TGOm3OvV5LUmFvDDnJUOft3aq5u69jgkjMRaffeIRTgFZ0GH709yNrBH
   Shf9B5VFC2zrQCCXS0TIRkMUt5vDDezVjVjcdYI21Wu0u2+rPB+AsdUf4
   7P7q2G2Nj0cVvL1zSAF5xws1MIYEdyz0UriaD8U4Lkj73vYwMPn0NdmIv
   BbfXM4jEK9oduI0Fwrvr5qay9DB6flr3BR0JjMxlZ/NUOeyCG2jaVpj99
   S+FrKjsztbgFuEUvf4SntllO2Q1H+FyYjl8AbJ8IPYf1kSPnpQbZa1X5J
   8BhGqf2LrI2TiVuE29DG7rKqNmE9J5DjiMsM5ZyDpP/Q4Zk0IiIjcgB5p
   w==;
X-CSE-ConnectionGUID: Wm/VFL6HTsqTcrh2RwgdDA==
X-CSE-MsgGUID: WADrx+muS0iYVnVMj6Q0iw==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2223440"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:04:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:40839]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id 8df697c8-0fcb-4285-bcae-7ff823771482; Tue, 2 Sep 2025 17:04:53 +0000 (UTC)
X-Farcaster-Flow-ID: 8df697c8-0fcb-4285-bcae-7ff823771482
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:04:52 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:04:51 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 6/7] selftests: Fix stdbuf compatibility in mixed libc environments
Date: Tue, 2 Sep 2025 17:01:43 +0000
Message-ID: <20250902170147.55583-7-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The original stdbuf use only checked if /usr/bin/stdbuf exists in the
host's system but failed to verify compatibility between stdbuf and the
target test binary.

The issue occurs when:
- Host system has glibc-based stdbuf from coreutils
- Selftest binaries are compiled with a non-glibc toolchain (cross
  compilation)

The fix adds a runtime compatibility test against the target test binary
before enabling stdbuf, enabling cross-compiled selftests to run
successfully.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 2c3c58e65..8d4e33bd5 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -107,7 +107,7 @@ run_one()
 		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
-		if [ -x /usr/bin/stdbuf ]; then
+		if [ -x /usr/bin/stdbuf ] && [ -x "$TEST" ] && /usr/bin/stdbuf --output=L ldd "$TEST" >/dev/null 2>&1; then
 			stdbuf="/usr/bin/stdbuf --output=L "
 		fi
 		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
-- 
2.47.3


