Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A810D749F5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjGFOqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjGFOp4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:45:56 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381A1BD4;
        Thu,  6 Jul 2023 07:45:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QxfC16LGhz9xFm0;
        Thu,  6 Jul 2023 22:33:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S4;
        Thu, 06 Jul 2023 15:45:02 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, song@kernel.org, jolsa@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 02/10] crypto: Export signature encoding information
Date:   Thu,  6 Jul 2023 16:42:15 +0200
Message-Id: <20230706144225.1046544-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kJFWkXrykGr1DZFWfGrg_yoW5Kr47pa
        n8KrWfGrWrJFyxCr93uw4xKryrt3ykuFyYkanruF18AryxCr18XrsFyryDCF1kJrs7CFW8
        WFWvg3Wqgwn8GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r
        4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
        Xa7IU0I385UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V4wAAsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Export the signature encoding identifiers, so that user space can reference
them when passing data to the kernel.

Define and export the sig_enc_name array, so that kernel subsystems can get
the string associated to the signature encoding identifier.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/Kconfig                    |  3 +++
 crypto/Makefile                   |  1 +
 crypto/sig_enc_info.c             | 16 ++++++++++++++++
 include/crypto/sig_enc_info.h     | 15 +++++++++++++++
 include/uapi/linux/sig_enc_info.h | 18 ++++++++++++++++++
 5 files changed, 53 insertions(+)
 create mode 100644 crypto/sig_enc_info.c
 create mode 100644 include/crypto/sig_enc_info.h
 create mode 100644 include/uapi/linux/sig_enc_info.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 2558025461b..ef6f1e4c5b4 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1423,6 +1423,9 @@ config CRYPTO_HASH_INFO
 config CRYPTO_PUB_KEY_INFO
 	bool
 
+config CRYPTO_SIG_ENC_INFO
+	bool
+
 if !KMSAN # avoid false positives from assembly
 if ARM
 source "arch/arm/crypto/Kconfig"
diff --git a/crypto/Makefile b/crypto/Makefile
index fcdb5918e58..6d84fadfeda 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -207,6 +207,7 @@ obj-$(CONFIG_ASYNC_CORE) += async_tx/
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += asymmetric_keys/
 obj-$(CONFIG_CRYPTO_HASH_INFO) += hash_info.o
 obj-$(CONFIG_CRYPTO_PUB_KEY_INFO) += pub_key_info.o
+obj-$(CONFIG_CRYPTO_SIG_ENC_INFO) += sig_enc_info.o
 crypto_simd-y := simd.o
 obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
 
diff --git a/crypto/sig_enc_info.c b/crypto/sig_enc_info.c
new file mode 100644
index 00000000000..649cf98385f
--- /dev/null
+++ b/crypto/sig_enc_info.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Sig enc info: Signature encoding information
+ */
+
+#include <linux/export.h>
+#include <crypto/sig_enc_info.h>
+
+const char *const sig_enc_name[SIG_ENC__LAST] = {
+	[SIG_ENC_PKCS1] = "pkcs1",
+	[SIG_ENC_X962] = "x962",
+	[SIG_ENC_RAW] = "raw",
+};
+EXPORT_SYMBOL_GPL(sig_enc_name);
diff --git a/include/crypto/sig_enc_info.h b/include/crypto/sig_enc_info.h
new file mode 100644
index 00000000000..6e28890a0e4
--- /dev/null
+++ b/include/crypto/sig_enc_info.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Sig enc info: Signature encoding information
+ */
+
+#ifndef _CRYPTO_SIG_ENC_INFO_H
+#define _CRYPTO_SIG_ENC_INFO_H
+
+#include <uapi/linux/sig_enc_info.h>
+
+extern const char *const sig_enc_name[SIG_ENC__LAST];
+
+#endif /* _CRYPTO_SIG_ENC_INFO_H */
diff --git a/include/uapi/linux/sig_enc_info.h b/include/uapi/linux/sig_enc_info.h
new file mode 100644
index 00000000000..0a2ac028bef
--- /dev/null
+++ b/include/uapi/linux/sig_enc_info.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Sig enc info: Signature encoding information
+ */
+
+#ifndef _UAPI_LINUX_SIG_ENC_INFO_H
+#define _UAPI_LINUX_SIG_ENC_INFO_H
+
+enum sig_enc_info {
+	SIG_ENC_PKCS1,
+	SIG_ENC_X962,
+	SIG_ENC_RAW,
+	SIG_ENC__LAST,
+};
+
+#endif /* _UAPI_LINUX_SIG_ENC_INFO_H */
-- 
2.34.1

