Return-Path: <linux-kselftest+bounces-30149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB4A7C5DE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 23:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C53BC91D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB601A9B32;
	Fri,  4 Apr 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qawZBD+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80F19DF4F;
	Fri,  4 Apr 2025 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803756; cv=none; b=Nv1NkICv81/3UB4Qu94sYiMvB41WXoVNsm6b+VgSgU0O1xRR+YxvJGcCU7SregHPD3vOGEUB32oBFz/uwIZ3W2RHveF+DNII9CVD6L+VhaIjdUYujhiQqFeymVIwa0u9/1bOL5tYj4NULJgxNuHQvCTNfCyIqHAuCiMOvAFfyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803756; c=relaxed/simple;
	bh=l6Ts1MkccQt08JJZSrHtbjQD1xGM55Qd2f4J8OjYFzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjbgzOlnumuAI4Ui3o24XCkR7MZu7z28Z4l4LN+aEwufSWBHlGRisQw4bSJkZZElhUWL4+OyeIat/5DZjYy2yZrGniZ148AeUiLGo7TQ/moPW4UnL2zdtb4hzpKFnPjgj0YEvr9TAKuxTioMBjIJ+lgc3/R0pLV9ju7k3PDdhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qawZBD+U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7AD702027DF4;
	Fri,  4 Apr 2025 14:55:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AD702027DF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743803754;
	bh=5hs4EhFsQFhQK9cL7VDWbNcHFmxC0uIGEoZyF9fSBmA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qawZBD+UPDfLjcWCRCrhOrXByE5/eIKRibl04pAdzA5jB7pphrS8KkYQciocouMFb
	 2bstyt6XiZgLkkfsQsv9eAeeo9MqjGnnfTqW6eoyFHjHdpadU8OjGGMZdNC2g3DTuJ
	 ShJQWyAbcwqQc1EHxNUOIKlxteWKj9E6AESUbtQ0=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH v2 security-next 1/4] security: Hornet LSM
Date: Fri,  4 Apr 2025 14:54:50 -0700
Message-ID: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the Hornet Linux Security Module which provides signature
verification of eBPF programs. This allows users to continue to
maintain an invariant that all code running inside of the kernel has
been signed.

The primary target for signature verification is light-skeleton based
eBPF programs which was introduced here:
https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/

eBPF programs, before loading, undergo a complex set of operations
which transform pseudo-values within the immediate operands of
instructions into concrete values based on the running
system. Typically, this is done by libbpf in
userspace. Light-skeletons were introduced in order to support
preloading of bpf programs and user-mode-drivers by removing the
dependency on libbpf and userspace-based operations.

Userpace modifications, which may change every time a program gets
loaded or runs on a slightly different kernel, break known signature
verification algorithms. A method is needed for passing unadulterated
binary buffers into the kernel in-order to use existing signature
verification algorithms. Light-skeleton loaders with their support of
only in-kernel relocations fit that constraint.

Hornet employs a signature verification scheme similar to that of
kernel modules. A signature is appended to the end of an
executable file. During an invocation of the BPF_PROG_LOAD subcommand,
a signature is extracted from the current task's executable file. That
signature is used to verify the integrity of the bpf instructions and
maps which were passed into the kernel. Additionally, Hornet
implicitly trusts any programs which were loaded from inside kernel
rather than userspace, which allows BPF_PRELOAD programs along with
outputs for BPF_SYSCALL programs to run.

The validation check consists of checking a PKCS#7 formatted signature
against a data buffer containing the raw instructions of an eBPF
program, followed by the initial values of any maps used by the
program. Maps are frozen before signature verification checking to
stop TOCTOU attacks.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/Hornet.rst |  55 ++++++
 Documentation/admin-guide/LSM/index.rst  |   1 +
 MAINTAINERS                              |   9 +
 crypto/asymmetric_keys/pkcs7_verify.c    |  10 +
 include/linux/kernel_read_file.h         |   1 +
 include/linux/verification.h             |   1 +
 include/uapi/linux/lsm.h                 |   1 +
 security/Kconfig                         |   3 +-
 security/Makefile                        |   1 +
 security/hornet/Kconfig                  |  11 ++
 security/hornet/Makefile                 |   4 +
 security/hornet/hornet_lsm.c             | 239 +++++++++++++++++++++++
 12 files changed, 335 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet_lsm.c

diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
new file mode 100644
index 000000000000..e0d2926c4041
--- /dev/null
+++ b/Documentation/admin-guide/LSM/Hornet.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Hornet
+======
+
+Hornet is a Linux Security Module that provides signature verification
+for eBPF programs. This is selectable at build-time with
+``CONFIG_SECURITY_HORNET``.
+
+Overview
+========
+
+Hornet provides signature verification for eBPF programs by utilizing
+the existing PKCS#7 infrastructure that's used for module signature
+verification. Hornet works by creating a buffer containing the eBPF
+program instructions along with its associated maps and checking a
+signature against that buffer. The signature is appended to the end of
+the lskel executable file and is extracted at runtime via
+get_task_exe_file. Hornet works by hooking into the
+security_bpf_prog_load hook. Load invocations that originate from the
+kernel (bpf preload, results of bpf_syscall programs, etc.) are
+allowed to run unconditionally. Calls that originate from userspace
+require signature verification. If signature verification fails, the
+program will fail to load.  Maps are frozen before the signature check
+to prevent TOCTOU exploits where a sufficiently privileged user could
+rewrite map data between the calls to BPF_PROG_LOAD and BPF_PROG_RUN.
+
+Instruction/Map Ordering
+========================
+
+Hornet supports both sparse-array based maps via map discovery along
+with the newly added fd_array_cnt API for continuous map arrays. The
+buffer used for signature verification is assumed to be the
+instructions followed by all maps used, ordered by their index in
+fd_array.
+
+Tooling
+=======
+
+Some tooling is provided to aid with the development of signed eBPF
+lskels.
+
+extract-skel.sh
+---------------
+
+This shell script extracts the instructions and map data used by the
+light skeleton from the autogenerated header file created by bpftool.
+
+sign-ebpf
+---------
+
+sign-ebpf works similarly to the sign-file script with one key
+difference: it takes a separate input binary used for signature
+verification and will append the signature to a different output file.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index ce63be6d64ad..0ecb5016ce1f 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -48,3 +48,4 @@ subdirectories.
    Yama
    SafeSetID
    ipe
+   Hornet
diff --git a/MAINTAINERS b/MAINTAINERS
index 3864d473f52f..a2355059cdf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10588,6 +10588,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 F:	drivers/iio/pressure/mprls0025pa*
 
+HORNET SECURITY MODULE
+M:	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+T:	git https://github.com/blaiseboscaccy/hornet.git
+F:	Documentation/admin-guide/LSM/Hornet.rst
+F:	scripts/hornet/
+F:	security/hornet/
+
 HP BIOSCFG DRIVER
 M:	Jorge Lopez <jorge.lopez2@hp.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f0d4ff3c20a8..1a5fbb361218 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -428,6 +428,16 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 		}
 		/* Authattr presence checked in parser */
 		break;
+	case VERIFYING_EBPF_SIGNATURE:
+		if (pkcs7->data_type != OID_data) {
+			pr_warn("Invalid ebpf sig (not pkcs7-data)\n");
+			return -EKEYREJECTED;
+		}
+		if (pkcs7->have_authattrs) {
+			pr_warn("Invalid ebpf sig (has authattrs)\n");
+			return -EKEYREJECTED;
+		}
+		break;
 	case VERIFYING_UNSPECIFIED_SIGNATURE:
 		if (pkcs7->data_type != OID_data) {
 			pr_warn("Invalid unspecified sig (not pkcs7-data)\n");
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..7ed9337be542 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(EBPF, ebpf)				\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/include/linux/verification.h b/include/linux/verification.h
index 4f3022d081c3..812be8ad5f74 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -35,6 +35,7 @@ enum key_being_used_for {
 	VERIFYING_KEXEC_PE_SIGNATURE,
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
+	VERIFYING_EBPF_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..2ff9bcdd551e 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_HORNET		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index f10dbf15c294..0030f0224c7a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 source "security/ipe/Kconfig"
+source "security/hornet/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -273,7 +274,7 @@ config LSM
 	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
 	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,hornet,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..e24bccd951f8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_SECURITY_HORNET)		+= hornet/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
new file mode 100644
index 000000000000..19406aa237ac
--- /dev/null
+++ b/security/hornet/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_HORNET
+	bool "Hornet support"
+	depends on SECURITY
+	default n
+	help
+	  This selects Hornet.
+	  Further information can be found in
+	  Documentation/admin-guide/LSM/Hornet.rst.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/hornet/Makefile b/security/hornet/Makefile
new file mode 100644
index 000000000000..79f4657b215f
--- /dev/null
+++ b/security/hornet/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_HORNET) := hornet.o
+
+hornet-y := hornet_lsm.o
diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
new file mode 100644
index 000000000000..d9e36764f968
--- /dev/null
+++ b/security/hornet/hornet_lsm.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hornet Linux Security Module
+ *
+ * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+ *
+ * Copyright (C) 2025 Microsoft Corporation
+ */
+
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+#include <linux/bpf.h>
+#include <linux/verification.h>
+#include <crypto/public_key.h>
+#include <linux/module_signature.h>
+#include <crypto/pkcs7.h>
+#include <linux/bpf_verifier.h>
+#include <linux/sort.h>
+
+#define EBPF_SIG_STRING "~eBPF signature appended~\n"
+
+struct hornet_maps {
+	u32 used_idx[MAX_USED_MAPS];
+	u32 used_map_cnt;
+	bpfptr_t fd_array;
+};
+
+static int cmp_idx(const void *a, const void *b)
+{
+	return *(const u32 *)a - *(const u32 *)b;
+}
+
+static int add_used_map(struct hornet_maps *maps, int idx)
+{
+	int i;
+
+	for (i = 0; i < maps->used_map_cnt; i++)
+		if (maps->used_idx[i] == idx)
+			return i;
+
+	if (maps->used_map_cnt >= MAX_USED_MAPS)
+		return -E2BIG;
+
+	maps->used_idx[maps->used_map_cnt] = idx;
+	return maps->used_map_cnt++;
+}
+
+static int hornet_find_maps(struct bpf_prog *prog, struct hornet_maps *maps)
+{
+	struct bpf_insn *insn = prog->insnsi;
+	int insn_cnt = prog->len;
+	int i;
+	int err;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
+			switch (insn[0].src_reg) {
+			case BPF_PSEUDO_MAP_IDX_VALUE:
+			case BPF_PSEUDO_MAP_IDX:
+				err = add_used_map(maps, insn[0].imm);
+				if (err < 0)
+					return err;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+	/* Sort the spare-array indices. This should match the map ordering used during
+	 * signature generation
+	 */
+	sort(maps->used_idx, maps->used_map_cnt, sizeof(*maps->used_idx),
+	     cmp_idx, NULL);
+
+	return 0;
+}
+
+static int hornet_populate_fd_array(struct hornet_maps *maps, u32 fd_array_cnt)
+{
+	int i;
+
+	if (fd_array_cnt > MAX_USED_MAPS)
+		return -E2BIG;
+
+	for (i = 0; i < fd_array_cnt; i++)
+		maps->used_idx[i] = i;
+
+	maps->used_map_cnt = fd_array_cnt;
+	return 0;
+}
+
+/* kern_sys_bpf is declared as an EXPORT_SYMBOL in kernel/bpf/syscall.c, however no definition is
+ * provided in any bpf header files. If/when this function has a proper definition provided
+ * somewhere this declaration should be removed
+ */
+int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+
+static int hornet_verify_lskel(struct bpf_prog *prog, struct hornet_maps *maps,
+			       void *sig, size_t sig_len)
+{
+	int fd;
+	u32 i;
+	void *buf;
+	void *new;
+	size_t buf_sz;
+	struct bpf_map *map;
+	int err = 0;
+	int key = 0;
+	union bpf_attr attr = {0};
+
+	buf = kmalloc_array(prog->len, sizeof(struct bpf_insn), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	buf_sz = prog->len * sizeof(struct bpf_insn);
+	memcpy(buf, prog->insnsi, buf_sz);
+
+	for (i = 0; i < maps->used_map_cnt; i++) {
+		err = copy_from_bpfptr_offset(&fd, maps->fd_array,
+					      maps->used_idx[i] * sizeof(fd),
+					      sizeof(fd));
+		if (err < 0)
+			continue;
+		if (fd < 1)
+			continue;
+
+		map = bpf_map_get(fd);
+		if (IS_ERR(map))
+			continue;
+
+		/* don't allow userspace to change map data used for signature verification */
+		if (!map->frozen) {
+			attr.map_fd = fd;
+			err = kern_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
+			if (err < 0)
+				goto out;
+		}
+
+		new = krealloc(buf, buf_sz + map->value_size, GFP_KERNEL);
+		if (!new) {
+			err = -ENOMEM;
+			goto out;
+		}
+		buf = new;
+		new = map->ops->map_lookup_elem(map, &key);
+		if (!new) {
+			err = -ENOENT;
+			goto out;
+		}
+		memcpy(buf + buf_sz, new, map->value_size);
+		buf_sz += map->value_size;
+	}
+
+	err = verify_pkcs7_signature(buf, buf_sz, sig, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_EBPF_SIGNATURE,
+				     NULL, NULL);
+out:
+	kfree(buf);
+	return err;
+}
+
+static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr *attr,
+			       struct hornet_maps *maps)
+{
+	struct file *file = get_task_exe_file(current);
+	const unsigned long markerlen = sizeof(EBPF_SIG_STRING) - 1;
+	void *buf = NULL;
+	size_t sz = 0, sig_len, prog_len, buf_sz;
+	int err = 0;
+	struct module_signature sig;
+
+	buf_sz = kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
+	fput(file);
+	if (!buf_sz)
+		return -1;
+
+	prog_len = buf_sz;
+
+	if (prog_len > markerlen &&
+	    memcmp(buf + prog_len - markerlen, EBPF_SIG_STRING, markerlen) == 0)
+		prog_len -= markerlen;
+
+	memcpy(&sig, buf + (prog_len - sizeof(sig)), sizeof(sig));
+	sig_len = be32_to_cpu(sig.sig_len);
+	prog_len -= sig_len + sizeof(sig);
+
+	err = mod_check_sig(&sig, prog->len * sizeof(struct bpf_insn), "ebpf");
+	if (err)
+		return err;
+	return hornet_verify_lskel(prog, maps, buf + prog_len, sig_len);
+}
+
+static int hornet_check_signature(struct bpf_prog *prog, union bpf_attr *attr,
+				  struct bpf_token *token)
+{
+	struct hornet_maps maps = {0};
+	int err;
+
+	/* support both sparse arrays and explicit continuous arrays of map fds */
+	if (attr->fd_array_cnt)
+		err = hornet_populate_fd_array(&maps, attr->fd_array_cnt);
+	else
+		err = hornet_find_maps(prog, &maps);
+
+	if (err < 0)
+		return err;
+
+	maps.fd_array = make_bpfptr(attr->fd_array, false);
+	return hornet_check_binary(prog, attr, &maps);
+}
+
+static int hornet_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+				struct bpf_token *token, bool is_kernel)
+{
+	if (is_kernel)
+		return 0;
+	return hornet_check_signature(prog, attr, token);
+}
+
+static struct security_hook_list hornet_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
+};
+
+static const struct lsm_id hornet_lsmid = {
+	.name = "hornet",
+	.id = LSM_ID_HORNET,
+};
+
+static int __init hornet_init(void)
+{
+	pr_info("Hornet: eBPF signature verification enabled\n");
+	security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &hornet_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(hornet) = {
+	.name = "hornet",
+	.init = hornet_init,
+};
-- 
2.48.1


