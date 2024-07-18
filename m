Return-Path: <linux-kselftest+bounces-13875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A130F934C9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326A5B20AAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E006136671;
	Thu, 18 Jul 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Id2Pgqiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5378C92;
	Thu, 18 Jul 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302355; cv=none; b=eLkENNRcl+IQW+EcBT5BdiwHVeaAGzla49c3+0zrwio/85uQYcKnMu7c7cr2qjMmaf7ZPa6IQlM2ZR6oSELUvOPDBalYqTUiqhoWQUsMdnDbPW2vHYC7FaOmGDa3a8lZE7s8zXXz6KqseCdPIShvv+q0fttvxVp1IE9jtwxOCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302355; c=relaxed/simple;
	bh=5rDspRGTIih6AnC50uyQS92w2qkdgxHJqgPEL0b9VYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sEyEvyYmxf93gPnUq2A6i1n1ToutSBEdP5EpkwBZ9OiLAzthh4TPblPq/2GAPjMy1kJG9oBoFHT4pMne0VJrfI9NzBY7KT3CSqEB6qKQckJHv2tjJphKwouuCCgYL4CLyRPXGY5A260q1hGd98sxCjnBAeI+Lbecdccgk+m60xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Id2Pgqiu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721302350;
	bh=5rDspRGTIih6AnC50uyQS92w2qkdgxHJqgPEL0b9VYM=;
	h=From:To:Cc:Subject:Date:From;
	b=Id2PgqiueiJ86LVZcwtqC2Pq/+mr+VICNGUVvFiX1K7s7YjYd4D5MdqlX/UOIYKks
	 fz977gVvHXyok1uzgy9YsWmMXchgxFsIsd5c2m9odgUCFWUfsHAAB8XKbsABMXdkAv
	 7yXu3I2UjGjp3lP2Qs4Xx1KaGpqDLvnFsJ1Z/HyHRXY+R6baFKXLU8TLLPGDc5cMvE
	 xlnEog1C84Kuch+RWCzF9AxpZrmLVVec9Cys80cU5Z8o3xPsuTVa6ZW3eCBB7ssVhm
	 NZzEuUic4eaVBaYhJqJKIGmvqjqKQqAY4Y+5o4eejunfPojRygEc4YnaOT6cmAZh6D
	 cQEKGnpUg729A==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6428B378202D;
	Thu, 18 Jul 2024 11:32:27 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 0/4] selftest: x86: improve tests
Date: Thu, 18 Jul 2024 16:32:18 +0500
Message-Id: <20240718113222.867116-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Correct the description of patches with what improvements they are
  bringing and why they are required

Changes since v2:
- Update descriptions of patches and add output before/after

Muhammad Usama Anjum (4):
  selftests: x86: check_initial_reg_state: remove manual counting and
    increase maintainability
  selftests: x86: corrupt_xstate_header: remove manual counting and
    increase maintainability
  selftests: x86: fsgsbase_restore: remove manual counting and increase
    maintainability
  selftests: x86: entry_from_vm86: remove manual counting and increase
    maintainability

 .../selftests/x86/check_initial_reg_state.c   |  24 ++--
 .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
 tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
 .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
 4 files changed, 139 insertions(+), 141 deletions(-)

-- 
2.39.2


