Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D796B4A682C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbiBAWrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 17:47:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:18697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239234AbiBAWrP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 17:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643755635; x=1675291635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/F6t4XF1rLjtax0FgbPIUt0hroNb41U+qzHg4S5R28=;
  b=K2zzJvHqAuBSt07G2xGXhMtxX1jWQfa58LL2JQyYaBYEbJddr2bqUu6A
   C0yNPp4NheYM73SaZgj90qAt2zyxWBnFGi7hrMo/IX3K80vJfUFCt7zL1
   hOHQW4GlzASnx987a4yzYzPJ84iwytNGTfib8tTs7Anih1w1txhsY0rbX
   ZWyz8UQ5woLoMfhZkihGauGGBpCHkeWvnK/wirCCxQK/iBdTNV2q++9Vb
   qlUKE/3UuqijL+I3BmnhA8ODjHDjKPdbrSCvn2MJOB0O/di7faJ4+P+Fj
   KvWps2YJ6H8Bets+/VoWeXfL079grjwd52uVw5nzhCpbsTIujcjc++rKY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247582281"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247582281"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698584743"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH V2 2/4] selftests/sgx: Do not attempt enclave build without valid enclave
Date:   Tue,  1 Feb 2022 14:47:04 -0800
Message-Id: <4e4ea6d70c286c209964bec1e8d29ac8e692748b.1643754040.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643754040.git.reinette.chatre@intel.com>
References: <cover.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is not possible to build an enclave if it was not possible to load
the binary from which it should be constructed. Do not attempt
to make further progress but instead return with failure. A
"return false" from setup_test_encl() is expected to trip an
ASSERT_TRUE() and abort the rest of the test.

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add Acked-by from Dave.
- Detail in commit log what callers will see with this change (Dave).

 tools/testing/selftests/sgx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 370c4995f7c4..a7cd2c3e6f7e 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
 		TH_LOG("Failed to load the test enclave.\n");
+		return false;
 	}
 
 	if (!encl_measure(encl))
-- 
2.25.1

