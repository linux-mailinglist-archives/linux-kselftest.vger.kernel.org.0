Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507BE3917EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhEZMw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 08:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhEZMtX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 08:49:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CE2A6124B;
        Wed, 26 May 2021 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622033272;
        bh=lA46JFIklDyHfspUH9KCw638iPxeE3A9j2MvKEpQ4TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO9dG0UtvSZ0YEEikfdhppE7GS0HAV557ijPQLLDA5siJEjHggbvHRWdtC9ZIxJDy
         Sav+AFhZvI7UccN1eLy7R4yFQrUStKXIl+H3VEmpkRBvyV6Mn6ODtS3QutPUjrnG5c
         U/nNcMrN34raH9Ff/oF6gp7eHeDbx5zFnOimx6ipYxQKNFHILpmOFDHBz28/LfsNGI
         vgYVk2Ahy78Q0AUwjZC6tXl/qA+6RhDvfAY4hrU3aPlx7UWOv7ou8JyKuzuBX6nl9P
         o+uLEl6KnYuDaY++tkYzg6msRdDlZ4B1smXF9EDgxQsEzqMzZegGSnQIYUoWjbgbtM
         tQJ239Gp+hX5g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] selftests/sgx: Dump enclave memory map
Date:   Wed, 26 May 2021 15:47:39 +0300
Message-Id: <20210526124740.16783-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526124740.16783-1-jarkko@kernel.org>
References: <20210526124740.16783-1-jarkko@kernel.org>
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
index 8694772c8fd9..d658882b5dd2 100644
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

