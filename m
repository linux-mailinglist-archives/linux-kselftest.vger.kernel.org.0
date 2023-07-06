Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D732A749F98
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjGFOsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjGFOrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:47:46 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAB92132;
        Thu,  6 Jul 2023 07:47:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfH727bTz9xFGg;
        Thu,  6 Jul 2023 22:36:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S10;
        Thu, 06 Jul 2023 15:46:50 +0100 (CET)
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
Subject: [RFC][PATCH 08/10] KEYS: Introduce load_uasym_keyring()
Date:   Thu,  6 Jul 2023 16:42:21 +0200
Message-Id: <20230706144225.1046544-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DtrW5Ww17KFyUGF48JFb_yoWruw1fp3
        y0kryrKr4vywn3G3yfCFyjgr43Cr1vkw4Yg3W3Cw15AF1DXrn8ZrsrKF1UKry5Wry5AryF
        qryIvr4Skw1UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
        v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZF
        pf9x07jIPfQUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V5wABsC
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

Preload user asymmetric keys from 'uasym_keys.bin', placed in certs/ of the
kernel source directory.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/Kconfig               | 11 ++++++++++
 certs/Makefile              |  7 +++++++
 certs/system_certificates.S | 18 ++++++++++++++++
 certs/system_keyring.c      | 41 +++++++++++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 1f109b07087..16bbf0f4bb6 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -138,4 +138,15 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
 	  keyring.  The PKCS#7 signature of the description is set in the key
 	  payload.  Blacklist keys cannot be removed.
 
+config UASYM_PRELOAD_PUBLIC_KEYS
+	bool "Preload user asymmetric keys"
+	depends on SYSTEM_TRUSTED_KEYRING
+	select UASYM_KEYS_SIGS
+	default n
+	help
+	  Load at boot time the user asymmetric keys from a reserved area
+	  (populated with the content of 'certs/uasym_keys.bin' provided at
+	  kernel build time), and add them to the built-in keyring. Invalid
+	  keys are ignored and the loading continues.
+
 endmenu
diff --git a/certs/Makefile b/certs/Makefile
index 799ad7b9e68..2e5be6668a6 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -22,6 +22,13 @@ $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
 
 targets += blacklist_hash_list
 
+ifdef CONFIG_UASYM_PRELOAD_PUBLIC_KEYS
+ifeq ($(shell ls $(srctree)/certs/uasym_keys.bin 2> /dev/null), $(srctree)/certs/uasym_keys.bin)
+AFLAGS_system_certificates.o += -DHAVE_UASYM_KEYRING_BLOB
+$(obj)/system_certificates.o: $(srctree)/certs/uasym_keys.bin
+endif
+endif
+
 quiet_cmd_extract_certs  = CERT    $@
       cmd_extract_certs  = $(obj)/extract-cert "$(extract-cert-in)" $@
 extract-cert-in = $(filter-out $(obj)/extract-cert, $(real-prereqs))
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 003e25d4a17..67b7c5effb6 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -44,3 +44,21 @@ module_cert_size:
 #else
 	.long __module_cert_end - __module_cert_start
 #endif
+
+	.align 8
+	.globl uasym_keys
+uasym_keys:
+__uasym_key_list_start:
+#ifdef HAVE_UASYM_KEYRING_BLOB
+	.incbin "certs/uasym_keys.bin"
+#endif
+__uasym_key_list_end:
+
+	.align 8
+	.globl uasym_keys_size
+uasym_keys_size:
+#ifdef CONFIG_64BIT
+	.quad __uasym_key_list_end - __uasym_key_list_start
+#else
+	.long __uasym_key_list_end - __uasym_key_list_start
+#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index dbee2e5b732..6035bd2f795 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -179,6 +179,31 @@ static __init int system_trusted_keyring_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_UASYM_PRELOAD_PUBLIC_KEYS
+extern __initconst const u8 uasym_keys[];
+extern __initconst const unsigned long uasym_keys_size;
+
+/**
+ * load_uasym_keyring - Load user asymmetric keys from a keyring blob
+ *
+ * Load user asymmetric keys from a keyring blob. Halt the parsing if
+ * a parsing error is encountered. If parsing succeed, ignore invalid keys.
+ *
+ * Return: Zero on success or on failure (ignored).
+ */
+static __init int load_uasym_keyring(void)
+{
+	pr_notice("Loading compiled-in user asymmetric keys\n");
+
+	if (preload_uasym_keys(uasym_keys, uasym_keys_size,
+			       builtin_trusted_keys) < 0)
+		pr_err("Can't load user asymmetric keys\n");
+
+	return 0;
+}
+late_initcall(load_uasym_keyring);
+#endif /* CONFIG_UASYM_PRELOAD_PUBLIC_KEYS */
+
 /*
  * Must be initialised before we try and load the keys into the keyring.
  */
@@ -186,13 +211,25 @@ device_initcall(system_trusted_keyring_init);
 
 __init int load_module_cert(struct key *keyring)
 {
+	int ret;
+
 	if (!IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG))
 		return 0;
 
 	pr_notice("Loading compiled-in module X.509 certificates\n");
 
-	return x509_load_certificate_list(system_certificate_list,
-					  module_cert_size, keyring);
+	ret = x509_load_certificate_list(system_certificate_list,
+					 module_cert_size, keyring);
+#ifdef CONFIG_UASYM_PRELOAD_PUBLIC_KEYS
+	if (!ret) {
+		pr_notice("Loading compiled-in user asymmetric keys\n");
+
+		ret = preload_uasym_keys(uasym_keys, uasym_keys_size, keyring);
+		if (ret < 0)
+			pr_err("Can't load user asymmetric keys\n");
+	}
+#endif
+	return ret;
 }
 
 /*
-- 
2.34.1

