Return-Path: <linux-kselftest+bounces-32218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFADAA7982
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 20:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598D14C67BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2A26B2D3;
	Fri,  2 May 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cAN2uzHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6826B0A5;
	Fri,  2 May 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211487; cv=none; b=ki5zS9oEl7VGvmfCHGVky8Z5x7LNYnxRBvnpKjRgPU8oqxbSIqH8PiDP5NtN/KcuGkhQiz0or6Lyb8D8WkNy+Qc031Wz2ufrGw1Q5JMcOGcfzg6jxVQ0Mt/oIP4ZqYHX2ciIC9epodG+7Xr4sZ/4tqUXaafiHIoKO6MonOSlNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211487; c=relaxed/simple;
	bh=GHtkcdoMipqroo96Z8uijMYVHzBUYw4q+ie4QEzeaX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo05sjWZYObYEoo9t0fZvYRvlJrb0UI6ZUeDuH+o3wLcXv4EdWWgDn/aWLeCmi3b4QencnNtiu/72XgKrjzZj+pwniydPHLcfIVY+VW6jEa8IS9e2gvZ4V4x9OVp0kdgnrZGEGqRTTYECCXFnlrUeY7P0anXGsaGft/y63XTNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cAN2uzHP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8236B2111579;
	Fri,  2 May 2025 11:44:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8236B2111579
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746211485;
	bh=NVHQjdfft+hrHrxn7DVxnFoxKReeTcOZP4lnIwYQJdw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cAN2uzHP4EGxS6F+7VOXl7nPl/14iaE5Roa54xPpP3Zsa9hlA7TaJTrGC3WdThMfP
	 GW+pcLRnOkMC1m0vRV6epf/zskmD/bi5CJ2TFrwdrajGFdDscWgfjpSBachobJWbZo
	 bW45CKL4S+AqmttPc1FoE+L3+7BTdTrHloRgasTY=
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
	xiyou.wangcong@gmail.com,
	Tyler Hicks <code@tyhicks.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH v3 4/4] selftests/hornet: Add a selftest for the Hornet LSM
Date: Fri,  2 May 2025 11:44:10 -0700
Message-ID: <20250502184421.1424368-5-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This selftest contains a testcase that utilizes light skeleton eBPF
loaders. One version of the light skeleton is signed with the
autogenerated module signing key, another is not. A test driver
attempts to load the programs. With Hornet enabled, the signed version
should successfully be loaded, and the unsigned version should fail.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/hornet/Makefile       |  58 +++
 tools/testing/selftests/hornet/fail_loader.sh |   3 +
 tools/testing/selftests/hornet/frozen_skel.h  | 393 ++++++++++++++++++
 tools/testing/selftests/hornet/loader.c       |  22 +
 tools/testing/selftests/hornet/trivial.bpf.c  |  33 ++
 6 files changed, 510 insertions(+)
 create mode 100644 tools/testing/selftests/hornet/Makefile
 create mode 100755 tools/testing/selftests/hornet/fail_loader.sh
 create mode 100644 tools/testing/selftests/hornet/frozen_skel.h
 create mode 100644 tools/testing/selftests/hornet/loader.c
 create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c77c8c8e3d9b..14f5d8ede199 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -42,6 +42,7 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += hid
+TARGETS += hornet
 TARGETS += intel_pstate
 TARGETS += iommu
 TARGETS += ipc
diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/selftests/hornet/Makefile
new file mode 100644
index 000000000000..cd6902918564
--- /dev/null
+++ b/tools/testing/selftests/hornet/Makefile
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+CLANG ?= clang
+CFLAGS := -g -O2 -Wall
+BPFTOOL ?= bpftool
+SCRIPTSDIR := $(abspath ../../../../scripts/hornet)
+TOOLSDIR := $(abspath ../../..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+APIDIR := $(TOOLSINCDIR)/uapi
+CERTDIR := $(abspath ../../../../certs)
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+
+TEST_GEN_PROGS_EXTENDED := loader
+TEST_GEN_PROGS := signed_loader
+TEST_PROGS := fail_loader.sh
+TEST_GEN_FILES := vmlinux.h loader.h trivial.bin trivial.bpf.o
+$(TEST_GEN_PROGS): LDLIBS += -lbpf
+$(TEST_GEN_PROGS): $(TEST_GEN_FILES)
+
+include ../lib.mk
+
+BPF_CFLAGS := -target bpf \
+	-D__TARGET_ARCH_$(ARCH) \
+	-I/usr/include/$(shell uname -m)-linux-gnu \
+	$(KHDR_INCLUDES)
+
+vmlinux.h:
+	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
+
+trivial.bpf.o: trivial.bpf.c vmlinux.h
+	$(CLANG) $(CFLAGS) $(BPF_CFLAGS) -c $< -o $@
+
+loader.h: trivial.bpf.o
+	$(BPFTOOL) gen skeleton -L $< name trivial > $@
+
+trivial.bin: loader.h
+	$(SCRIPTSDIR)/extract-skel.sh $< $@
+
+loader: loader.c loader.h
+	$(CC) $(CFLAGS) -I$(LIBDIR) -I$(APIDIR) $< -o $@ -lbpf
+
+$(OUTPUT)/sign-ebpf: ../../../../scripts/hornet/sign-ebpf.c
+	$(call msg,SIGN-EBPF,,$@)
+	$(Q)$(CC) $(shell $(PKG_CONFIG) --cflags libcrypto 2> /dev/null) \
+		  $< -o $@ \
+		  $(shell $(PKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+
+signed_loader: trivial.bin loader $(OUTPUT)/sign-ebpf
+	$(OUTPUT)/sign-ebpf sha256 $(CERTDIR)/signing_key.pem  $(CERTDIR)/signing_key.x509 \
+		trivial.bin loader signed_loader
+	chmod u+x $@
+
+EXTRA_CLEAN = $(OUTPUT)/sign-ebpf
diff --git a/tools/testing/selftests/hornet/fail_loader.sh b/tools/testing/selftests/hornet/fail_loader.sh
new file mode 100755
index 000000000000..99314369f5de
--- /dev/null
+++ b/tools/testing/selftests/hornet/fail_loader.sh
@@ -0,0 +1,3 @@
+#!/bin/bash
+
+./loader && exit 1; exit 0
diff --git a/tools/testing/selftests/hornet/frozen_skel.h b/tools/testing/selftests/hornet/frozen_skel.h
new file mode 100644
index 000000000000..2e31a52f41c2
--- /dev/null
+++ b/tools/testing/selftests/hornet/frozen_skel.h
@@ -0,0 +1,393 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2021 Facebook */
+#ifndef __SKEL_INTERNAL_H
+#define __SKEL_INTERNAL_H
+
+#ifdef __KERNEL__
+#include <linux/fdtable.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/slab.h>
+#include <linux/bpf.h>
+#else
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+#include <bpf/bpf.h>
+#endif
+
+#ifndef __NR_bpf
+# if defined(__mips__) && defined(_ABIO32)
+#  define __NR_bpf 4355
+# elif defined(__mips__) && defined(_ABIN32)
+#  define __NR_bpf 6319
+# elif defined(__mips__) && defined(_ABI64)
+#  define __NR_bpf 5315
+# endif
+#endif
+
+/* This file is a base header for auto-generated *.lskel.h files.
+ * Its contents will change and may become part of auto-generation in the future.
+ *
+ * The layout of bpf_[map|prog]_desc and bpf_loader_ctx is feature dependent
+ * and will change from one version of libbpf to another and features
+ * requested during loader program generation.
+ */
+struct bpf_map_desc {
+	/* output of the loader prog */
+	int map_fd;
+	/* input for the loader prog */
+	__u32 max_entries;
+	__aligned_u64 initial_value;
+};
+struct bpf_prog_desc {
+	int prog_fd;
+};
+
+enum {
+	BPF_SKEL_KERNEL = (1ULL << 0),
+};
+
+struct bpf_loader_ctx {
+	__u32 sz;
+	__u32 flags;
+	__u32 log_level;
+	__u32 log_size;
+	__u64 log_buf;
+};
+
+struct bpf_load_and_run_opts {
+	struct bpf_loader_ctx *ctx;
+	const void *data;
+	const void *insns;
+	__u32 data_sz;
+	__u32 insns_sz;
+	const char *errstr;
+};
+
+long kern_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
+
+static inline int skel_sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
+			  unsigned int size)
+{
+#ifdef __KERNEL__
+	return kern_sys_bpf(cmd, attr, size);
+#else
+	return syscall(__NR_bpf, cmd, attr, size);
+#endif
+}
+
+#ifdef __KERNEL__
+static inline int close(int fd)
+{
+	return close_fd(fd);
+}
+
+static inline void *skel_alloc(size_t size)
+{
+	struct bpf_loader_ctx *ctx = kzalloc(size, GFP_KERNEL);
+
+	if (!ctx)
+		return NULL;
+	ctx->flags |= BPF_SKEL_KERNEL;
+	return ctx;
+}
+
+static inline void skel_free(const void *p)
+{
+	kfree(p);
+}
+
+/* skel->bss/rodata maps are populated the following way:
+ *
+ * For kernel use:
+ * skel_prep_map_data() allocates kernel memory that kernel module can directly access.
+ * Generated lskel stores the pointer in skel->rodata and in skel->maps.rodata.initial_value.
+ * The loader program will perform probe_read_kernel() from maps.rodata.initial_value.
+ * skel_finalize_map_data() sets skel->rodata to point to actual value in a bpf map and
+ * does maps.rodata.initial_value = ~0ULL to signal skel_free_map_data() that kvfree
+ * is not necessary.
+ *
+ * For user space:
+ * skel_prep_map_data() mmaps anon memory into skel->rodata that can be accessed directly.
+ * Generated lskel stores the pointer in skel->rodata and in skel->maps.rodata.initial_value.
+ * The loader program will perform copy_from_user() from maps.rodata.initial_value.
+ * skel_finalize_map_data() remaps bpf array map value from the kernel memory into
+ * skel->rodata address.
+ *
+ * The "bpftool gen skeleton -L" command generates lskel.h that is suitable for
+ * both kernel and user space. The generated loader program does
+ * either bpf_probe_read_kernel() or bpf_copy_from_user() from initial_value
+ * depending on bpf_loader_ctx->flags.
+ */
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	if (addr != ~0ULL)
+		kvfree(p);
+	/* When addr == ~0ULL the 'p' points to
+	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
+	 */
+}
+
+static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+{
+	void *addr;
+
+	addr = kvmalloc(val_sz, GFP_KERNEL);
+	if (!addr)
+		return NULL;
+	memcpy(addr, val, val_sz);
+	return addr;
+}
+
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+{
+	struct bpf_map *map;
+	void *addr = NULL;
+
+	kvfree((void *) (long) *init_val);
+	*init_val = ~0ULL;
+
+	/* At this point bpf_load_and_run() finished without error and
+	 * 'fd' is a valid bpf map FD. All sanity checks below should succeed.
+	 */
+	map = bpf_map_get(fd);
+	if (IS_ERR(map))
+		return NULL;
+	if (map->map_type != BPF_MAP_TYPE_ARRAY)
+		goto out;
+	addr = ((struct bpf_array *)map)->value;
+	/* the addr stays valid, since FD is not closed */
+out:
+	bpf_map_put(map);
+	return addr;
+}
+
+#else
+
+static inline void *skel_alloc(size_t size)
+{
+	return calloc(1, size);
+}
+
+static inline void skel_free(void *p)
+{
+	free(p);
+}
+
+static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+{
+	munmap(p, sz);
+}
+
+static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+{
+	void *addr;
+
+	addr = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (addr == (void *) -1)
+		return NULL;
+	memcpy(addr, val, val_sz);
+	return addr;
+}
+
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+{
+	void *addr;
+
+	addr = mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
+	if (addr == (void *) -1)
+		return NULL;
+	return addr;
+}
+#endif
+
+static inline int skel_closenz(int fd)
+{
+	if (fd > 0)
+		return close(fd);
+	return -EINVAL;
+}
+
+#ifndef offsetofend
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof((((TYPE *)0)->MEMBER)))
+#endif
+
+static inline int skel_map_create(enum bpf_map_type map_type,
+				  const char *map_name,
+				  __u32 key_size,
+				  __u32 value_size,
+				  __u32 max_entries)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+
+	attr.map_type = map_type;
+	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
+	attr.key_size = key_size;
+	attr.value_size = value_size;
+	attr.max_entries = max_entries;
+
+	return skel_sys_bpf(BPF_MAP_CREATE, &attr, attr_sz);
+}
+
+static inline int skel_map_update_elem(int fd, const void *key,
+				       const void *value, __u64 flags)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, flags);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+	attr.key = (long) key;
+	attr.value = (long) value;
+	attr.flags = flags;
+
+	return skel_sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
+}
+
+static inline int skel_map_delete_elem(int fd, const void *key)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, flags);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+	attr.key = (long)key;
+
+	return skel_sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
+}
+
+static inline int skel_map_freeze(int fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, map_fd);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+
+	return skel_sys_bpf(BPF_MAP_FREEZE, &attr, attr_sz);
+}
+
+static inline int skel_map_get_fd_by_id(__u32 id)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, flags);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_id = id;
+
+	return skel_sys_bpf(BPF_MAP_GET_FD_BY_ID, &attr, attr_sz);
+}
+
+static inline int skel_raw_tracepoint_open(const char *name, int prog_fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint.prog_fd);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.raw_tracepoint.name = (long) name;
+	attr.raw_tracepoint.prog_fd = prog_fd;
+
+	return skel_sys_bpf(BPF_RAW_TRACEPOINT_OPEN, &attr, attr_sz);
+}
+
+static inline int skel_link_create(int prog_fd, int target_fd,
+				   enum bpf_attach_type attach_type)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, link_create.iter_info_len);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.link_create.prog_fd = prog_fd;
+	attr.link_create.target_fd = target_fd;
+	attr.link_create.attach_type = attach_type;
+
+	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
+}
+
+#ifdef __KERNEL__
+#define set_err
+#else
+#define set_err err = -errno
+#endif
+
+static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
+{
+	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, fd_array);
+	const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
+	int map_fd = -1, prog_fd = -1, key = 0, err;
+	union bpf_attr attr;
+
+	err = map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
+	if (map_fd < 0) {
+		opts->errstr = "failed to create loader map";
+		set_err;
+		goto out;
+	}
+
+	err = skel_map_update_elem(map_fd, &key, opts->data, 0);
+	if (err < 0) {
+		opts->errstr = "failed to update loader map";
+		set_err;
+		goto out;
+	}
+
+	err = skel_map_freeze(map_fd);
+	if (err < 0) {
+		opts->errstr = "failed to freeze map";
+		set_err;
+		goto out;
+	}
+
+	memset(&attr, 0, prog_load_attr_sz);
+	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+	attr.insns = (long) opts->insns;
+	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
+	attr.license = (long) "Dual BSD/GPL";
+	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
+	attr.fd_array = (long) &map_fd;
+	attr.log_level = opts->ctx->log_level;
+	attr.log_size = opts->ctx->log_size;
+	attr.log_buf = opts->ctx->log_buf;
+	attr.prog_flags = BPF_F_SLEEPABLE;
+	err = prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, prog_load_attr_sz);
+	if (prog_fd < 0) {
+		opts->errstr = "failed to load loader prog";
+		set_err;
+		goto out;
+	}
+
+	memset(&attr, 0, test_run_attr_sz);
+	attr.test.prog_fd = prog_fd;
+	attr.test.ctx_in = (long) opts->ctx;
+	attr.test.ctx_size_in = opts->ctx->sz;
+	err = skel_sys_bpf(BPF_PROG_RUN, &attr, test_run_attr_sz);
+	if (err < 0 || (int)attr.test.retval < 0) {
+		if (err < 0) {
+			opts->errstr = "failed to execute loader prog";
+			set_err;
+		} else {
+			opts->errstr = "error returned by loader prog";
+			err = (int)attr.test.retval;
+#ifndef __KERNEL__
+			errno = -err;
+#endif
+		}
+		goto out;
+	}
+	err = 0;
+out:
+	if (map_fd >= 0)
+		close(map_fd);
+	if (prog_fd >= 0)
+		close(prog_fd);
+	return err;
+}
+
+#endif
diff --git a/tools/testing/selftests/hornet/loader.c b/tools/testing/selftests/hornet/loader.c
new file mode 100644
index 000000000000..548b50a0c1fe
--- /dev/null
+++ b/tools/testing/selftests/hornet/loader.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stddef.h>
+#include <sys/resource.h>
+#include <bpf/libbpf.h>
+#include <errno.h>
+#include "frozen_skel.h"
+#include  "loader.h"
+
+int main(int argc, char **argv)
+{
+	struct trivial *skel;
+
+	skel = trivial__open_and_load();
+	if (!skel)
+		return -1;
+
+	trivial__destroy(skel);
+	return 0;
+}
diff --git a/tools/testing/selftests/hornet/trivial.bpf.c b/tools/testing/selftests/hornet/trivial.bpf.c
new file mode 100644
index 000000000000..d38c5b53ff93
--- /dev/null
+++ b/tools/testing/selftests/hornet/trivial.bpf.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+int monitored_pid = 0;
+
+SEC("tracepoint/syscalls/sys_enter_unlinkat")
+int handle_enter_unlink(struct trace_event_raw_sys_enter *ctx)
+{
+	char filename[128] = { 0 };
+	struct task_struct *task;
+	unsigned long start_time = 0;
+	int pid = bpf_get_current_pid_tgid() >> 32;
+	char *pathname_ptr = (char *) BPF_CORE_READ(ctx, args[1]);
+
+	bpf_probe_read_str(filename, sizeof(filename), pathname_ptr);
+	task = (struct task_struct *)bpf_get_current_task();
+	start_time = BPF_CORE_READ(task, start_time);
+
+	bpf_printk("BPF triggered unlinkat by PID: %d, start_time %ld. pathname = %s",
+		   pid, start_time, filename);
+
+	if (monitored_pid == pid)
+		bpf_printk("target pid found");
+
+	return 0;
+}
-- 
2.48.1


