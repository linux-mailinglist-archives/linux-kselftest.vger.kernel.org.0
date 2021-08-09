Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976FF3E42B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhHIJcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhHIJcJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:32:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E7106108B;
        Mon,  9 Aug 2021 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501509;
        bh=bnm02H3dfphxSdFEbJmZUOHQV7VRt4GzZNY+MRzq9O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj70906euClnuonyFaGvLBUdm6CdaLsJ5zcCugSjNfAnpZnzjBvluCwKfi2t37asP
         L9kgp7hQVOc9OIX/WxQhjoPkDSn4UTn3DS5rj4iRa2ONHMqUqSxuhlg55mhUeB3xiM
         M4ArHeN1gq2OGeVdSWNszyNaCIXzAX6/bQjdf6ck1EU+wgYjfGSHb3FS9TNUAL63ya
         T2eb4/YT4IgVOoqqHWQ1svZ2LCcMakt3rwZrE8S2I4FCg+1O4XJxuGxtxuyuopxei8
         uEkWUNmogjwWvOmCW9hZ1LtPxeHfLFJnvUb41L1wQ2EHpxdE52dNNAombpXt1RHgfd
         2jxUAZsSKjpnQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] selftests/sgx: Dump segments and /proc/self/maps only on failure
Date:   Mon,  9 Aug 2021 12:31:24 +0300
Message-Id: <20210809093127.76264-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809093127.76264-1-jarkko@kernel.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logging is always a compromise between clarity and detail. The main use
case for dumping VMA's is when FIXTURE_SETUP() fails, and is less important
for enclaves that do initialize correctly. Therefore, print the segments
and /proc/self/maps only in the error case.

Finally, if a single test ever creates multiple enclaves, the amount of
log lines would become enormous.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 6858a35fed20..deab02f2f3ce 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -127,12 +127,6 @@ FIXTURE_SETUP(enclave)
 		ksft_exit_skip("cannot load enclaves\n");
 	}
 
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		seg = &self->encl.segment_tbl[i];
-
-		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
-	}
-
 	if (!encl_measure(&self->encl))
 		goto err;
 
@@ -169,6 +163,17 @@ FIXTURE_SETUP(enclave)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
+	return;
+
+err:
+	encl_delete(&self->encl);
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		seg = &self->encl.segment_tbl[i];
+
+		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
+	}
+
 	maps_file = fopen("/proc/self/maps", "r");
 	if (maps_file != NULL)  {
 		while (fgets(maps_line, sizeof(maps_line), maps_file) != NULL) {
@@ -181,11 +186,7 @@ FIXTURE_SETUP(enclave)
 		fclose(maps_file);
 	}
 
-err:
-	if (!sgx_enter_enclave_sym)
-		encl_delete(&self->encl);
-
-	ASSERT_NE(sgx_enter_enclave_sym, NULL);
+	ASSERT_TRUE(false);
 }
 
 FIXTURE_TEARDOWN(enclave)
-- 
2.32.0

