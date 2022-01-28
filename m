Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E974A000C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 19:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiA1SYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 13:24:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:26182 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235646AbiA1SYX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 13:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643394263; x=1674930263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GRu+94sn9MVPYckG80m2FcGawispI6xlNHU6naUUb7Y=;
  b=bQljtpWn/bH/fe3UB0KBIOWmvDwFAIJVXeIahngcsNR4AFfbJzEYBc16
   Uum85hacjsUeUhZSUrAB7vDmjJrqYf2GgWhHCq6niE7E2Z5ahd1riBgol
   c11MptGvvsFuMY7MBupWxWCrg+avbJA9zRRbtmyaOA91T/z6fBRihFgDY
   KxsidCUevQX8FEBltod9hgHLbmOCR9kSBGWWaZP7VLNfwh6SYJ5zVCV+j
   MaQOwYABhPe2C11xZMsVXAhGV0N8ape89HxjRjNeffzZ9cct8y32Wau/p
   ggKtnlFrVgryashF8VhvWqJV4w0QoLmLfhHlm9Go1lKRxyFHscepCTYnf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244773365"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244773365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="581930427"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH 0/4] selftests/sgx: Early enclave loading error path fixes
Date:   Fri, 28 Jan 2022 10:23:55 -0800
Message-Id: <cover.1643393473.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Everybody,

Please find included a few fixes that address problems encountered after
venturing into the enclave loading error handling code of the SGX
selftests.

Reinette

Reinette Chatre (4):
  selftests/sgx: Fix segfault upon early test failure
  selftests/sgx: Do not attempt enclave build without valid enclave
  selftests/sgx: Ensure enclave data available during debug print
  selftests/sgx: Remove extra newlines in test output

 tools/testing/selftests/sgx/load.c | 9 +++++----
 tools/testing/selftests/sgx/main.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

