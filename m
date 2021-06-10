Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677C93A2709
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFJIcb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 04:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhFJIc3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 04:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C68A6613F5;
        Thu, 10 Jun 2021 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623313833;
        bh=DL/k3s8vUW6PwKHS5SFkQoOjuaQwVeGOqUP3a+TVVvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3dG/lI7pRMGURzmskBoqL5Ihpq1Hys8EJVXft6sffjdZa3WUL34DXcn/0Q24A7al
         DUZL8V3Fl9sq24kfgIBOb2Hx5twGDR5AkuYcYfHpT8AQbgXLn4EgGaFUjwTPotvbIh
         WGUVUzpc54e6qCh7iUb2dTzldLexc7cJQo9VlnkYY0E+siQkANJmLuANTS+XrByqde
         LILOPhjl53HAXujmfQKc4hYAtGTud9DtnN9AUjRirB+vEvOuiK5l0Xd0y+u8u/BL+p
         ercdfmvik/vX+f4zdUFsWVRj/wXU4y25B6x7W1veMbbEUquRdioV+OeVySsGWem+wO
         jWFVgichzZvJA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/5] selftests/sgx: Dump enclave memory map
Date:   Thu, 10 Jun 2021 11:30:19 +0300
Message-Id: <20210610083021.392269-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610083021.392269-1-jarkko@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
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
index 6da19b6bf287..14030f8b85ff 100644
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

