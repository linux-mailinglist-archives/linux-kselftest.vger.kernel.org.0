Return-Path: <linux-kselftest+bounces-9104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9158B68C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5291F25014
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2D111A2;
	Tue, 30 Apr 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcVOrbeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08910A1F;
	Tue, 30 Apr 2024 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447889; cv=none; b=d0Ct3/NvIjMxlrPDIiwLlpIHxLtekh98ap7sSa3udcMkaseUzNmSgwhZp6DWlUd8CDEBMrqD5jfYVHmxnJ1IwTa9AOkgiwwgq9ExWH+n7Ol70YAZiN74GvIQNKTscPjSbC9Ks0MSTdnW6MEa0o4gvgSxlW3LW9yUMlxSb90sA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447889; c=relaxed/simple;
	bh=eNnYRiuhtVZM8QDw49inSXEkNXOx5BqLKDgscQ9Oi7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQpjs830NHxxtFkNN+Wjt9ZM3yxeFNTLiznNqDUy7cqKDYP5ZuPlE0BmHBeFK8rdzHBYc+ulhba9Z3hdfMu96a+lxgLllLefz3ZozgHb3u3WsEfHh/DYfLO7Y2DLucrWdkHK8zjUzikzN8WXXGYOH+To/y+JaamrvfTMge3+FA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcVOrbeP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714447887; x=1745983887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eNnYRiuhtVZM8QDw49inSXEkNXOx5BqLKDgscQ9Oi7U=;
  b=OcVOrbePxuj2/WmvLV7hhtTUEp6yLrCSM5XWf89xBUgOx34vYNfqTsqs
   oQJ58ua6p110i9cob2usqzY/NiT0sNFshjMPHqc9h7zK+XZYhG4xsvItJ
   3Q8N8nqrCWqUlaCjkOpkt5EmZrJzou40BSCS2S2YdkJ7MS9W4mUh54pNG
   mcfO9q3eJodfsrtZ/nX7HrHuwqgtGTYcgAEQa+HhytT5TUKnGT3/F2j8p
   E67NlRzvnfAvmLOan9fgzOD+6klqGLnDe/+MJjLLtI2PqKG4VqIs05AEk
   7opRVeNPaEQCVj231HbThlL467ga03Jc3Fe/2cVSn/yKktDQpqku0Upli
   Q==;
X-CSE-ConnectionGUID: i7POnghaQ96PjJbnEmDa6w==
X-CSE-MsgGUID: Eij6y3EeR1eYlfddCbSbJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21284171"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21284171"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:31:27 -0700
X-CSE-ConnectionGUID: hG69Z67ERTCElIZxMutaWw==
X-CSE-MsgGUID: Lu541emXSguSjuQPU+d4kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26819994"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 20:31:24 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v1 0/4] add tests to verify IFS (In Field Scan) driver functionality
Date: Tue, 30 Apr 2024 11:31:44 +0800
Message-ID: <cover.1714447026.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To verify IFS (In Field Scan [1]) driver functionality, add the following 6
test cases:
  1. Verify that IFS sysfs entries are created after loading the IFS module
  2. Check if loading an invalid IFS test image fails and loading a valid
     one succeeds
  3. Perform IFS scan test on each CPU using all the available image files
  4. Perform IFS scan with first test image file on a random CPU for 3
     rounds
  5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
  6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds

These are not exhaustive, but some minimal test runs to check various
parts of the driver. Some negative tests are also included.

[1] https://docs.kernel.org/arch/x86/ifs.html

Pengfei Xu (4):
  selftests: ifs: verify test interfaces are created by the driver
  selftests: ifs: verify test image loading functionality
  selftests: ifs: verify IFS scan test functionality
  selftests: ifs: verify IFS ARRAY BIST functionality

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
 .../platform/x86/intel/ifs/test_ifs.sh        | 496 ++++++++++++++++++
 4 files changed, 504 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
 create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh

-- 
2.43.0


