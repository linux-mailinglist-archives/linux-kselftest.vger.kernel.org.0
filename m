Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2315A699
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgBLKif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 05:38:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52406 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLKie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 05:38:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j1pPZ-0005KI-QO; Wed, 12 Feb 2020 10:38:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/resctrl: fix spelling mistake "Errror" -> "Error"
Date:   Wed, 12 Feb 2020 10:38:29 +0000
Message-Id: <20200212103829.41424-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in error messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 84d2a8b9657a..79c611c99a3d 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -181,7 +181,7 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
 
 	if (ret) {
-		printf("\n Errror in fill cache read/write...\n");
+		printf("\n Error in fill cache read/write...\n");
 		return -1;
 	}
 
@@ -205,7 +205,7 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
 	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
 			 resctrl_val);
 	if (ret) {
-		printf("\n Errror in fill cache\n");
+		printf("\n Error in fill cache\n");
 		return -1;
 	}
 
-- 
2.25.0

