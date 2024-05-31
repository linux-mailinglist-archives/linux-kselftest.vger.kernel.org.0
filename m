Return-Path: <linux-kselftest+bounces-10985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC138D5C16
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3929AB21D32
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948C7442D;
	Fri, 31 May 2024 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dddvndc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E367407A;
	Fri, 31 May 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142009; cv=none; b=Ihj5tFPq1QQXtylC/I2+p/nhAUrg6t9a6u/rBJDbIaSexJKv/XZRW1g9orKaRpIgHbqQAuaFEOKfFOJqnkS7rkesU9ZGUms//LjqZcIaDMEsgyBEQaXWt2/42CHJ11JWjZyM5AY3EyW7G3C7qKcCRHaVvaOVi++b30ci3UnTKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142009; c=relaxed/simple;
	bh=7CijetDgxD1GT8zKvhQLOXr2EnHHBCuCMTvKypbMiB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZHDe+k8cJ/Sgol8U0PE7nFgrC6YMlQuFRxAoCGlL5GM6kHVI7mqFywRbj5AD+H8JZA3ZXHSV5HlKj74Nn3Rbp/OAdJnig+VJG6c0jJqw+GU9zh30vNi1zQKYe8gOORZmBp6sTbl5IU57SMzf5PixZTh61ZrGKkigrfGMe545AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dddvndc4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717142009; x=1748678009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7CijetDgxD1GT8zKvhQLOXr2EnHHBCuCMTvKypbMiB4=;
  b=Dddvndc4Wnl/q32D+P24siRzNAGngc80wpZzy+PtEtN8CNJ3C5pVcGRC
   DaAUxplU34dp0hxKp0KQ1aOgg7/ILTLg1vbmJ2jMHSPm/y1hHjiNxiezo
   AGKm1A005bv7eFi+gN5rAVUojJA2/RdWoNAFsjMEMqQocUKkWN2+r5aTM
   a74+O8Dpzv9xK3HYddMPx5et0fZnIFO1KvOjbXQcwchSmIFPeUX+5TFww
   TrccUlP/Ow9RscILr9IHzI1PA4Nvz8L4sas0UfRNbihlK60B9vKWjpGB2
   lCGvzTIfWzapXLFDOXFTG3o9CyAm02YgMGhnWQUU243gLtatuWErtxjTM
   g==;
X-CSE-ConnectionGUID: ZbXyFgyqRZa/MMzwD7e57g==
X-CSE-MsgGUID: VtSh4Yo2QT6LZl3r5B24Cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24336923"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24336923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:53:28 -0700
X-CSE-ConnectionGUID: UpsRV1XlTRCHImZ1Mrgkxg==
X-CSE-MsgGUID: 2wu+58MfT2+iXIV/xFBfAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36081083"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmviesa008.fm.intel.com with ESMTP; 31 May 2024 00:53:25 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v2 0/4] add tests to verify IFS (In Field Scan) driver functionality
Date: Fri, 31 May 2024 15:53:46 +0800
Message-ID: <cover.1717137348.git.pengfei.xu@intel.com>
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
 .../platform/x86/intel/ifs/test_ifs.sh        | 494 ++++++++++++++++++
 4 files changed, 502 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
 create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh

---
Changes:
v1 to v2:
  - Rebase to v6.10 cycle kernel and resolve some code conflicts
  - Improved checking of IFS ARRAY_BIST support by leveraging sysfs entry
    methods (suggested by Ashok)

-- 
2.43.0


