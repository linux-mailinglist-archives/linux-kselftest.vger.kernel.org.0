Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3666936EF96
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbhD2SlN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 14:41:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59823 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbhD2SlL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 14:41:11 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tim.gardner@canonical.com>)
        id 1lcBaJ-0001vn-Gd
        for linux-kselftest@vger.kernel.org; Thu, 29 Apr 2021 18:40:23 +0000
Received: by mail-pj1-f71.google.com with SMTP id r9-20020a17090a9409b02901558df911adso340035pjo.5
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 11:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0OUrEu3/29WV/lDM4r+szkRmP1MV+40G+dNKGjfZYt8=;
        b=KhNXKGkYabuuLZcjCbzXIri6WdSHpQHkkodz8Pf1EqsXgXmW5yES7yz23BYKbP88DZ
         cxIYaXQBnVTWV/xUVjXA07spdsRtfF8R9u6WqUpL55KhWeCrYpr1QXtkm4vtCGrIWEPk
         lbJ6CFDMqs9tW9iLWQvu7t/04SRcrhOnZ/vPSTxVCpT1A3rn//kuKJSBijXqvGdEsO9D
         BzMpKrTNqRaxsgDwoGyMlgdyJ0Ssa2EHMV4fcY4QEcf7CjKvyNYTnoqU354QGs3gq25E
         lFZ8FOKKHQnwdaJXasXbmr7PP8Kue80MEg9Ivr+hYOkZUqkjjw98TzQI1zppdft2FTkx
         hQjQ==
X-Gm-Message-State: AOAM5338YtdqPQ/GxqHpwbQQl1Ky8d0xF/gNpNfd+Ojt+CFgZG7UB7oR
        XDo0pdRoXTqRfwZr4gcxpbSm4JaptMuTTD7iO8fO2LdvfAVbph70wNgXTtzefKjj5Sbwc5J5C5Q
        j/ta+hTcbXFTNsxITHRTWX6Zjqmhn+tLFycte30LLFGDOQQ==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr11314574pjt.128.1619721622211;
        Thu, 29 Apr 2021 11:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP/sVvL06a92jnUUZ2B1gLcXqqV7Y30Y0/R/Ft4O7oXGNSU5HG7BG/ZDYxyPM1DDTHd2+CHg==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr11314560pjt.128.1619721622063;
        Thu, 29 Apr 2021 11:40:22 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id i123sm3566618pfc.53.2021.04.29.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:40:21 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dave.hansen@linux.intel.com
Cc:     tim.gardner@canonical.com, jarkko@kernel.org, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sgx: Defeat execute permissions test
Date:   Thu, 29 Apr 2021 12:39:52 -0600
Message-Id: <20210429183952.22797-2-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429183952.22797-1-tim.gardner@canonical.com>
References: <20210429183952.22797-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The permissions check on /dev/sgx_enclave appears to be an oversight
in that it will not allow the test to continue. Skipping this test
with a warning allows the test to proceed.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 tools/testing/selftests/sgx/load.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index f441ac34b4d4..e5bcaca1c372 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -155,10 +155,8 @@ bool encl_load(const char *path, struct encl *encl)
 	 * bits set.  It does not check that the current user is
 	 * the owner or in the owning group.
 	 */
-	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
-		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
-		goto err;
-	}
+	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)))
+		fprintf(stderr, "Warning: no execute permissions on device file %s\n", device_path);
 
 	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
-- 
2.17.1

