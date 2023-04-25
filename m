Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C497D6EE706
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjDYRje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjDYRjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:39:32 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A40A13FBE;
        Tue, 25 Apr 2023 10:39:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5TWn0Hpdz9xFg7;
        Wed, 26 Apr 2023 01:29:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S8;
        Tue, 25 Apr 2023 18:38:40 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 6/6] KEYS: asymmetric: Add UMD handler
Date:   Tue, 25 Apr 2023 19:35:57 +0200
Message-Id: <20230425173557.724688-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S8
X-Coremail-Antispam: 1UD129KBjvJXoW3XF17Zr1UWFy8Cr1UuFW8tFb_yoW7Zw4fpa
        yF9rWrtFWrtw1Ska4rJr12gw4rAw48Ar4Sgw1Sq3W5uasrXw4kCrWIyF43WFy8JryxJFyr
        tFWkZFyUJrs5JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07jxwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4x8NAACsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the skeleton of the UMD handler, complete enough to talk with
the new key and signature parsers in the kernel.

Commands to parse keys and signatures are not implemented.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .gitignore                                    |  3 +
 crypto/asymmetric_keys/Kconfig                | 10 +++
 crypto/asymmetric_keys/Makefile               | 13 +++
 crypto/asymmetric_keys/umd_key_sig_loader.c   | 32 +++++++
 crypto/asymmetric_keys/umd_key_sig_umh_blob.S |  7 ++
 crypto/asymmetric_keys/umd_key_sig_umh_user.c | 84 +++++++++++++++++++
 6 files changed, 149 insertions(+)
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_loader.c
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_umh_blob.S
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_umh_user.c

diff --git a/.gitignore b/.gitignore
index 7f86e083790..f14e42b7273 100644
--- a/.gitignore
+++ b/.gitignore
@@ -174,3 +174,6 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+# User mode driver for asymmetric keys and signatures
+/crypto/asymmetric_keys/umd_key_sig_umh
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index d312feae88e..4b53667d209 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -107,4 +107,14 @@ config UMD_SIG_PARSER
 	  On success, the parser fills the signature from the UMD handler
 	  response.
 
+config UMD_KEY_SIG_HANDLER
+	tristate "UMD handler for asymmetric keys and signatures"
+	depends on UMD_KEY_PARSER
+	help
+	  This option introduces a UMD handler to parse data received from
+	  the key and signature kernel parsers.
+
+	  It includes just the basic program structure, to be enhanced with
+	  actual parsers.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 060c699fbb2..d870cc04fcf 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -86,3 +86,16 @@ obj-$(CONFIG_UMD_KEY_PARSER) += umd_key_parser.o
 # UMD signature parser
 #
 obj-$(CONFIG_UMD_SIG_PARSER) += umd_sig_parser.o
+
+#
+# UMD handler for asymmetric keys and signatures
+#
+CC=klcc
+userprogs := umd_key_sig_umh
+umd_key_sig_umh-objs := umd_key_sig_umh_user.o
+userldflags += -static
+
+$(obj)/umd_key_sig_umh_blob.o: $(obj)/umd_key_sig_umh
+
+obj-$(CONFIG_UMD_KEY_SIG_HANDLER) += umd_key_sig_user.o
+umd_key_sig_user-objs += umd_key_sig_loader.o umd_key_sig_umh_blob.o
diff --git a/crypto/asymmetric_keys/umd_key_sig_loader.c b/crypto/asymmetric_keys/umd_key_sig_loader.c
new file mode 100644
index 00000000000..b959a42b9fd
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_key_sig_loader.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the loader of the UMD handler.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "umd_key.h"
+
+extern char umd_key_umh_start;
+extern char umd_key_umh_end;
+
+MODULE_LICENSE("GPL");
+
+static int __init umd_key_umh_init(void)
+{
+	return umd_mgmt_load(&key_ops, &umd_key_umh_start, &umd_key_umh_end);
+}
+
+static void __exit umd_key_umh_exit(void)
+{
+	umd_mgmt_unload(&key_ops);
+}
+
+module_init(umd_key_umh_init);
+module_exit(umd_key_umh_exit);
diff --git a/crypto/asymmetric_keys/umd_key_sig_umh_blob.S b/crypto/asymmetric_keys/umd_key_sig_umh_blob.S
new file mode 100644
index 00000000000..954cbe891bd
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_key_sig_umh_blob.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+	.section .init.rodata, "a"
+	.global umd_key_umh_start
+umd_key_umh_start:
+	.incbin "crypto/asymmetric_keys/umd_key_sig_umh"
+	.global umd_key_umh_end
+umd_key_umh_end:
diff --git a/crypto/asymmetric_keys/umd_key_sig_umh_user.c b/crypto/asymmetric_keys/umd_key_sig_umh_user.c
new file mode 100644
index 00000000000..21f53008762
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_key_sig_umh_user.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the UMD handler.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "umd_key_sig_umh.h"
+
+FILE *debug_f;
+
+int main(int argc, char *argv[])
+{
+	struct msg_in *in = NULL;
+	struct msg_out *out = NULL;
+	size_t in_len, out_len;
+	loff_t pos;
+	int ret = 0;
+
+#ifdef debug
+	debug_f = fopen("/dev/kmsg", "a");
+	fprintf(debug_f, "<5>Started %s\n", argv[0]);
+	fflush(debug_f);
+#endif
+	in = malloc(sizeof(*in));
+	if (!in)
+		goto out;
+
+	out = malloc(sizeof(*out));
+	if (!out)
+		goto out;
+
+	while (1) {
+		int n;
+
+		in_len = sizeof(*in);
+		out_len = sizeof(*out);
+
+		memset(in, 0, in_len);
+		memset(out, 0, out_len);
+
+		pos = 0;
+		while (in_len) {
+			n = read(0, (void *)in + pos, in_len);
+			if (n <= 0) {
+				ret = -EIO;
+				goto out;
+			}
+			in_len -= n;
+			pos += n;
+		}
+
+		switch (in->cmd) {
+		default:
+			out->ret = -EOPNOTSUPP;
+			break;
+		}
+
+		pos = 0;
+		while (out_len) {
+			n = write(1, (void *)out + pos, out_len);
+			if (n <= 0) {
+				ret = -EIO;
+				goto out;
+			}
+			out_len -= n;
+			pos += n;
+		}
+	}
+out:
+	free(in);
+	free(out);
+#ifdef debug
+	fclose(debug_f);
+#endif
+	return ret;
+}
-- 
2.25.1

