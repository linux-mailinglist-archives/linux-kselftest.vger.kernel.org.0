Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9E4A000D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbiA1SYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 13:24:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:26182 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235646AbiA1SYY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 13:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643394264; x=1674930264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9R+QpM+RrNxzn+MKgSfGWS4ATwl6dwfeXykwHwBvBE=;
  b=Ki/vZXI2Ry37btoEnYNs0MIiCx6nODjkDNrb32+CQ345aSTl2ObY1b4g
   XHWisHRmGZPM9X0EGRHo8DpJ7kkYYGbgNZCUXPKAgiCQs4jbi/Hw5Fg4I
   axUdTrsYi/Hq+aue7JOh1RILHrAVGcvhgaFZGRuFkgUkELma8ZdK9AL3g
   WTCIk4DEo1A39GIlUWtCtjtxHyPcaTHzcTxSDh8jqm41O+dgq1zS5CGbM
   lBA+wVJqYZaUMBwuQUTA3jkTnp5qJur+sI5IOEbcCqiMg/+xx/93Lj9y8
   j+PQD3OS84BgVmY6bRCTUI57/9bZI9+Ios4w9iKW0WiFHk6jkHqlUeg76
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244773367"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244773367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="581930430"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH 2/4] selftests/sgx: Do not attempt enclave build without valid enclave
Date:   Fri, 28 Jan 2022 10:23:57 -0800
Message-Id: <f2b46fd652450d9361577e63a8d4b0b85190c4a2.1643393473.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643393473.git.reinette.chatre@intel.com>
References: <cover.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is not possible to build an enclave if it was not possible to load
the binary from which it should be constructed. Do not attempt
to make further progress but instead return with failure.

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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

