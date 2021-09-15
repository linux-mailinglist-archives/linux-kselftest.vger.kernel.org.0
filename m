Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2170040CA2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhIOQeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:34:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3825 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhIOQeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:09 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m0r2mrNz67h7V;
        Thu, 16 Sep 2021 00:30:36 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:32:47 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/9] diglim: Loader
Date:   Wed, 15 Sep 2021 18:31:38 +0200
Message-ID: <20210915163145.1046505-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915163145.1046505-1-roberto.sassu@huawei.com>
References: <20210915163145.1046505-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Digest lists should be loaded as soon as possible, before files are
accessed, so that services like IMA can perform their queries.

Implement two methods for loading digest lists at kernel initialization
time. Take a directory from CONFIG_DIGLIM_DIGEST_LISTS_DIR and execute
digest_list_read() for each file in that directory. Afterwards, execute a
digest list uploader at CONFIG_DIGLIM_UPLOADER_PATH with the following
syntax:

<CONFIG_DIGLIM_UPLOADER_PATH> add <CONFIG_DIGLIM_DIGEST_LISTS_DIR>

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../security/diglim/implementation.rst        | 16 ++++
 MAINTAINERS                                   |  1 +
 security/integrity/diglim/Kconfig             | 14 +++
 security/integrity/diglim/Makefile            |  2 +-
 security/integrity/diglim/loader.c            | 92 +++++++++++++++++++
 security/integrity/iint.c                     |  1 +
 security/integrity/integrity.h                |  8 ++
 7 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/diglim/loader.c

diff --git a/Documentation/security/diglim/implementation.rst b/Documentation/security/diglim/implementation.rst
index f7b48c093f39..0290b42b014b 100644
--- a/Documentation/security/diglim/implementation.rst
+++ b/Documentation/security/diglim/implementation.rst
@@ -226,3 +226,19 @@ This section introduces the interfaces in
 ``<securityfs>/integrity/diglim`` necessary to interact with DIGLIM.
 
 .. kernel-doc:: security/integrity/diglim/fs.c
+
+
+Loader
+------
+
+Digest lists should be loaded as soon as possible, before files are
+accessed, so that services like IMA can perform their queries.
+
+The kernel loader implements two methods for loading digest lists at kernel
+initialization time. The first method takes a directory from
+CONFIG_DIGLIM_DIGEST_LISTS_DIR and executes digest_list_read() for each
+file in that directory. The second method, invoked sequentially after the
+first, executes a digest list uploader at CONFIG_DIGLIM_UPLOADER_PATH with
+the following syntax:
+
+<CONFIG_DIGLIM_UPLOADER_PATH> add <CONFIG_DIGLIM_DIGEST_LISTS_DIR>
diff --git a/MAINTAINERS b/MAINTAINERS
index 033c70014568..0ffceb271803 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5518,6 +5518,7 @@ F:	include/uapi/linux/diglim.h
 F:	security/integrity/diglim/diglim.h
 F:	security/integrity/diglim/fs.c
 F:	security/integrity/diglim/ima.c
+F:	security/integrity/diglim/loader.c
 F:	security/integrity/diglim/methods.c
 F:	security/integrity/diglim/parser.c
 F:	tools/testing/selftests/diglim/
diff --git a/security/integrity/diglim/Kconfig b/security/integrity/diglim/Kconfig
index 436a76a14337..6c76a0fefe42 100644
--- a/security/integrity/diglim/Kconfig
+++ b/security/integrity/diglim/Kconfig
@@ -9,3 +9,17 @@ config DIGLIM
 	help
 	  DIGLIM provides reference values for file content and metadata,
 	  that can be used for measurement and appraisal with IMA.
+
+config DIGLIM_DIGEST_LISTS_DIR
+	string "Path of the directory containing digest lists"
+	depends on DIGLIM
+	default "/etc/digest_lists"
+	help
+	  This option defines the path of the directory containing digest lists.
+
+config DIGLIM_UPLOADER_PATH
+	string "Path of the user space digest list uploader"
+	depends on DIGLIM
+	default "/usr/libexec/diglim/upload_digest_lists"
+	help
+	  This option defines the path of the user space digest list uploader.
diff --git a/security/integrity/diglim/Makefile b/security/integrity/diglim/Makefile
index 5cb1a8bfa0fc..ae79a3317ec8 100644
--- a/security/integrity/diglim/Makefile
+++ b/security/integrity/diglim/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_DIGLIM) += diglim.o
 
-diglim-y := methods.o parser.o ima.o fs.o
+diglim-y := methods.o parser.o ima.o fs.o loader.o
diff --git a/security/integrity/diglim/loader.c b/security/integrity/diglim/loader.c
new file mode 100644
index 000000000000..e95d3716c153
--- /dev/null
+++ b/security/integrity/diglim/loader.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Functions to load digest lists.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/namei.h>
+#include <linux/ima.h>
+
+#include "diglim.h"
+
+struct readdir_callback {
+	struct dir_context ctx;
+	struct path *path;
+};
+
+static bool digest_list_supported_by_kernel(const char *filename)
+{
+	char *type_start, *format_start, *format_end;
+
+	type_start = strchr(filename, '-');
+	if (!type_start++)
+		return false;
+
+	format_start = strchr(type_start, '-');
+	if (!format_start++)
+		return false;
+
+	format_end = strchr(format_start, '-');
+	if (!format_end)
+		return false;
+
+	if (format_end - format_start != strlen("compact") ||
+	    strncmp(format_start, "compact", format_end - format_start))
+		return false;
+
+	return true;
+}
+
+static int __init digest_list_load(struct dir_context *__ctx, const char *name,
+				   int namelen, loff_t offset, u64 ino,
+				   unsigned int d_type)
+{
+	struct readdir_callback *ctx = container_of(__ctx, typeof(*ctx), ctx);
+	int ret;
+
+	if (!strcmp(name, ".") || !strcmp(name, ".."))
+		return 0;
+
+	if (!digest_list_supported_by_kernel(name))
+		return 0;
+
+	ret = digest_list_read(ctx->path, (char *)name, DIGEST_LIST_ADD);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void digest_list_exec_parser(void)
+{
+	char *argv[4] = {NULL}, *envp[1] = {NULL};
+
+	argv[0] = (char *)CONFIG_DIGLIM_UPLOADER_PATH;
+	argv[1] = "add";
+	argv[2] = CONFIG_DIGLIM_DIGEST_LISTS_DIR;
+
+	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
+}
+
+void __init digest_lists_load(void)
+{
+	struct file *file;
+	struct readdir_callback buf = {
+		.ctx.actor = digest_list_load,
+	};
+
+	file = filp_open(CONFIG_DIGLIM_DIGEST_LISTS_DIR, O_RDONLY, 0);
+	if (IS_ERR(file))
+		return;
+
+	buf.path = &file->f_path;
+	iterate_dir(file, &buf.ctx);
+	fput(file);
+
+	digest_list_exec_parser();
+}
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..3799311cc0c3 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -211,6 +211,7 @@ void __init integrity_load_keys(void)
 
 	if (!IS_ENABLED(CONFIG_IMA_LOAD_X509))
 		evm_load_x509();
+	digest_lists_load();
 }
 
 static int __init integrity_fs_init(void)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index de5dde382f11..2ab85f286d17 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -288,4 +288,12 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_DIGLIM
+void __init digest_lists_load(void);
+#else
+static inline void __init digest_lists_load(void)
+{
+}
+#endif
 #endif /*__INTEGRITY_H*/
-- 
2.25.1

