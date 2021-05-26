Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD537390FC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 06:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEZEsd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 00:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhEZEsc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 00:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B70F56143B;
        Wed, 26 May 2021 04:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622004421;
        bh=1uFv2VyJz6esoDem7stUbj9D1cON4Q48LBPPv+L2n/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qc0Fpd31890mwNY6MeQPSqYksY9UxWzK4quYJlpcieunEVxcvSjrqJqIocktNbg7V
         a5kEf+35hGqArZEy4sREstwopNjpkVVZB0rLcVfTCXSTm9sAlZuL9N5cA6QQNZpahf
         Mjvtdq3LExISjWQ+2wZ8AY2b1kRNlTEw1FDIPs6TXM0zkhFU/jM+MrwfOFy13atfmA
         3RBiYmfp7Os5kPnFtwlPjguSX/aXoQEQvlN5VI4u0d9h55D8fuYV4vmcRubcOBnxx5
         1f1NzsUyDyp3c2twVic0z3M+Sr0A/cfECZyRIVKejtXQJQSBWImRfOHabzgfESKfpd
         pVMUZAF2forqw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] selftests/sgx: Dump enclave memory map
Date:   Wed, 26 May 2021 07:46:49 +0300
Message-Id: <20210526044649.988789-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526044649.988789-1-jarkko@kernel.org>
References: <20210526044649.988789-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Often, it's useful to check whether /proc/self/maps looks sane when
dealing with memory mapped objects, especially when they are JIT'ish
dynamically constructed objects. Therefore, dump "/dev/sgx_enclave"
matching lines from the memory map in FIXTURE_SETUP().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 0a2f20326c66..27e43870a9a1 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -117,6 +117,8 @@ FIXTURE_SETUP(enclave)
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
 	struct encl_segment *seg;
+	char maps_line[256];
+	FILE *maps_file;
 	unsigned int i;
 	void *addr;
 
@@ -167,6 +169,18 @@ FIXTURE_SETUP(enclave)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
+	maps_file = fopen("/proc/self/maps", "r");
+	if (maps_file != NULL)  {
+		while (fgets(maps_line, sizeof(maps_line), maps_file) != NULL) {
+			maps_line[strlen(maps_line) - 1] = '\0';
+
+			if (strstr(maps_line, "/dev/sgx_enclave"))
+				TH_LOG("%s", maps_line);
+		}
+
+		fclose(maps_file);
+	}
+
 err:
 	if (!sgx_enter_enclave_sym)
 		encl_delete(&self->encl);
-- 
2.31.1

