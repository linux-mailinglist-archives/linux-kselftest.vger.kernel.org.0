Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111BB4A6829
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiBAWrO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 17:47:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:18697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbiBAWrO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 17:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643755634; x=1675291634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z9uo9M9sOXjOl8KjB5JfXfuHIJVUsR+sO+VCCIh/Dz0=;
  b=mdjzCe01JtpCRtxhJaa6xogOVYnDz+vTsXA6FJkj0xfigRU9dZ2GmH3V
   UauVceZgR503jdFz0FE+yjhV9Je4OGrAbe2SZUb9lIQGK8aSiqmkGtSTc
   291oUzKxPhd8G+qtZVVmUYYmd5LrH8J55O7VKT968aMWJJdLy/eTWwQU/
   RUmdEOrqgPCBNB4SViDm9GG9RTKBw+fqU9aneQD3B7JUj2xabZKByRL62
   AvwFz5OoliIMFiTbvl4l1LR4B6rUQQexCiurkUawMQFLdyTKArXXqN+/H
   +Rl9JAfOIPFp76Bas7Euru89II/QpxsjXW5gTVgO5Tkscsm94Ix7SuCCX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247582279"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247582279"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698584741"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH V2 0/4] selftests/sgx: Early enclave loading error path fixes
Date:   Tue,  1 Feb 2022 14:47:02 -0800
Message-Id: <cover.1643754040.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes since V1:
- V1: https://lore.kernel.org/linux-sgx/cover.1643393473.git.reinette.chatre@intel.com/
- All changes impact the commit messages only, no changes to code.
- Rewrite commit message of 1/4 (Dave).
- Detail in 2/4 commit log what callers will see with this change (Dave).
- Add Acked-by from Dave to 2/4 and 4/4.

Hi Everybody,

Please find included a few fixes that address problems encountered after
venturing into the enclave loading error handling code of the SGX
selftests.

Reinette

Reinette Chatre (4):
  selftests/sgx: Fix NULL-pointer-dereference upon early test failure
  selftests/sgx: Do not attempt enclave build without valid enclave
  selftests/sgx: Ensure enclave data available during debug print
  selftests/sgx: Remove extra newlines in test output

 tools/testing/selftests/sgx/load.c | 9 +++++----
 tools/testing/selftests/sgx/main.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)


base-commit: 2056e2989bf47ad7274ecc5e9dda2add53c112f9
-- 
2.25.1

