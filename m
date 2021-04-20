Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF353661DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhDTWHA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 18:07:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhDTWHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 18:07:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYyVm-0008Ui-9U; Tue, 20 Apr 2021 22:06:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: add missing void in MREMAP_DONTUNMAP selftest function prototypes
Date:   Tue, 20 Apr 2021 23:06:26 +0100
Message-Id: <20210420220626.391888-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few function prototypes that are missing a void parameter,
fix this by adding it in.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/vm/mremap_dontunmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/mremap_dontunmap.c b/tools/testing/selftests/vm/mremap_dontunmap.c
index f01dc4a85b0b..78baaf0e85d9 100644
--- a/tools/testing/selftests/vm/mremap_dontunmap.c
+++ b/tools/testing/selftests/vm/mremap_dontunmap.c
@@ -42,7 +42,7 @@ static void dump_maps(void)
 
 // Try a simple operation for to "test" for kernel support this prevents
 // reporting tests as failed when it's run on an older kernel.
-static int kernel_support_for_mremap_dontunmap()
+static int kernel_support_for_mremap_dontunmap(void)
 {
 	int ret = 0;
 	unsigned long num_pages = 1;
@@ -95,7 +95,7 @@ static int check_region_contains_byte(void *addr, unsigned long size, char byte)
 
 // this test validates that MREMAP_DONTUNMAP moves the pagetables while leaving
 // the source mapping mapped.
-static void mremap_dontunmap_simple()
+static void mremap_dontunmap_simple(void)
 {
 	unsigned long num_pages = 5;
 
@@ -128,7 +128,7 @@ static void mremap_dontunmap_simple()
 }
 
 // This test validates that MREMAP_DONTUNMAP on a shared mapping works as expected.
-static void mremap_dontunmap_simple_shmem()
+static void mremap_dontunmap_simple_shmem(void)
 {
 	unsigned long num_pages = 5;
 
@@ -181,7 +181,7 @@ static void mremap_dontunmap_simple_shmem()
 // This test validates MREMAP_DONTUNMAP will move page tables to a specific
 // destination using MREMAP_FIXED, also while validating that the source
 // remains intact.
-static void mremap_dontunmap_simple_fixed()
+static void mremap_dontunmap_simple_fixed(void)
 {
 	unsigned long num_pages = 5;
 
@@ -226,7 +226,7 @@ static void mremap_dontunmap_simple_fixed()
 
 // This test validates that we can MREMAP_DONTUNMAP for a portion of an
 // existing mapping.
-static void mremap_dontunmap_partial_mapping()
+static void mremap_dontunmap_partial_mapping(void)
 {
 	/*
 	 *  source mapping:
-- 
2.30.2

