Return-Path: <linux-kselftest+bounces-40303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF450B3BDD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D041CC3934
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120EA322532;
	Fri, 29 Aug 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="G8BDKPZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF7321F29;
	Fri, 29 Aug 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477802; cv=none; b=gNu+3mAboadHyD9ZVo2oxs0/OP577YgP8bCtt0ICHmVh3dGXfCTFEv4CnZtkQ2S2L/Dyx4vWx5VFD9ILCXzUbdskL4SNJY4JoPaacSz2CaTLQYSoTU9XfunTmVn53Mv176DWfgq52qsWzDGOFrJcBdnmV9PXLsM5BIOdyfJVLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477802; c=relaxed/simple;
	bh=hIa5NZU+ptvi1P/zFOZ5CtZWga0YAxQCOdDW4ZvuWO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZSXBuidVrGBKoU0FavPIcnIOYmX0Ecxj3Rbr6kdu+gxBHPDszJ+aS/zPWU1Vkt6oIAOW/GBGpLqzGiOlsWbbln+yMxCXM6vJ4eOnObKhZliwom3wJR6CBuptMHLAVdQHDiE5SkR4iA5r+axZIU2JOFe3ywdsSiqY94u5zzu4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=G8BDKPZG; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477800; x=1788013800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3YpejAOHmJFdr8XoS0TAI0Co6Y45l6RAHR2x4MxMh/I=;
  b=G8BDKPZGvlWaZQVoipod7n4Sn94VXe40C40Egj0lF24PM5iELVJBaZTy
   T/0ZD1qJA1fp5l/yUVedyoglaORlHH1xBByzcQRKucC4LOJlspBnbyFD4
   6npEjB0z6bUJHMDEcOu43bXTyZpwGXkRH74JedzBkrCn8Pexp2UX/bG0/
   625ai9uJk2XZ7BIMmgkFx3SiYlJN/WL8D94mjJlJWbnxQNMntqQkT3kAK
   cBiJRzfBfNp4KC9uqnyVTyJHAIuO3F1NYhpgYWHGGQMOYNh/N7Nfy8anj
   vzcBNwGaQsv3xciBEI/QDQxADLJ8l5ea5l/CmSBGDlL7s1SH3sgcO23NR
   w==;
X-CSE-ConnectionGUID: mq27f3lJQ8WLYYMX6qKNVA==
X-CSE-MsgGUID: bgOTxQIKQvu1exEDLV/O/A==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1928860"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:29:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:44908]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id 0269af9e-eb85-4812-8c6a-36db19f62e05; Fri, 29 Aug 2025 14:29:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0269af9e-eb85-4812-8c6a-36db19f62e05
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:29:57 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:29:56 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 8/9] selftests: Fix stdbuf compatibility in mixed libc environments
Date: Fri, 29 Aug 2025 14:25:52 +0000
Message-ID: <20250829142556.72577-9-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829142556.72577-1-aqibaf@amazon.com>
References: <20250829142556.72577-1-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
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


