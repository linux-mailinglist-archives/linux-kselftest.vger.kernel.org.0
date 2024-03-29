Return-Path: <linux-kselftest+bounces-6883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA08E89240A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CD71C21984
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209A1386A8;
	Fri, 29 Mar 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrgfKHO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A0131E5C
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739998; cv=none; b=SwK5IdTMGCecaQ8sF0rZTlp1Y2tYvFTIP+hPZnmtKLqyD1AnCOSeiGrJJPjXBKKbkWP7xejHL7OjbfngsmxC2kkiKYS49ADri0cZRavKIGv07Cf8WkRZRmRPMzCpyX8aBw6nH4/qO/AiDIjkyVLLO21U661sq8sxbcYNg2zF6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739998; c=relaxed/simple;
	bh=ruM1fSImM8HKEje7JvZtgcNqeHH5/+wlG2CCls1QZT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgYLEzMbs/JNhj27XP4bYloYlzo84It+COzDUlydZVKYxxGcK6NeQ1CR1qiPRq2iS+mqvKlzsE0DpV2q7CHoINuH2Te7tNlY02HWm5PjAcYWnK77nbksbwDOiDqEBMNz1LbVdW0624zl5LHZhxDhpy7N6CpMffO/Ae/bstqPXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrgfKHO0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so3902243276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711739996; x=1712344796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=we19mLACjXRZNttAFYVbtTYtEILOCnooUoGzKYB5j+E=;
        b=TrgfKHO0oWcGQKZ2HeG6R0BL9PMw0W65Wx6mPgqm8StiLuchuP5tCX7zTFLdN6kO1U
         gZ/F6KZJ/Qq94UUJ2e8nhXNuqBCLRlh6embBKv5W24dUkHqEHehrjiSbIlLmFANaTW5p
         j5ekeVyQcAq8ktPXHrwmvzqr66N6mZXfGoVBSDNXwnGjiewrV2FetywDspzk7KEMaKNU
         0MqZAWO6QeBiUB/VoRDY1FKzEYCayQQ8J/14PqxokBRbnwITzVn9YwByOuBwTl53BuXg
         RG/Ta36zYLJ4AO/RLzAo37Ck7O2QFDIbsGRHEag0NrhFhVjH35s3IKpJ8DO4qcuiqEAp
         1jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739996; x=1712344796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we19mLACjXRZNttAFYVbtTYtEILOCnooUoGzKYB5j+E=;
        b=urnveZlaHPtNKk3i5R/LlkVoI/8eeeS7lMJGihOyAsSFgt2M1txboKz22RWM12Qcr+
         hKoL4QpaYFe1jIv3XcRIoVjsYVuliRew2yhZnCAdNetFs3B2fKev63WAdX9TpYdfZUd0
         Z55HZyHaZHmtEGBuaTdWfQFKP2d9Cu6Kj7TdkEhi930JCvszEaurZyhxKyzwtI6cWEfF
         0qDGGHl1ZdEFqS775AADgbGFM3w2xbAab17s9ZkjBNRzQ6WtLfZ48jiClIYcQZW4K70X
         OrXUoUV+qFmWGNNKk6pFPLkiaCJJ16LqaoD1t4bSnFk55675kDJ0xPh5HQ5wHHiGk9ss
         VgQw==
X-Forwarded-Encrypted: i=1; AJvYcCVSK8eNEWA11d0tLiddg7IzzWJmNR7dd1Td5r8CyVHjdru2N758ttp3DO+9A7NKvDHOeASRLc8lniaCh2RVLXjzWDzfky2Slxytsa/CCfds
X-Gm-Message-State: AOJu0YxqrY9X7alehyonAjGvu0V74I+a4Z/GzFoaKIGKObWkY0E0Lx1m
	HstIFv4znqkH3OGIAGILVuyTsVpsO59UyvAScYKtqHZQKjRCGh4HYyDWdy609G+w4ybyW2tu0Q=
	=
X-Google-Smtp-Source: AGHT+IGQBKUyRnSY3uGuCn5Yqobb+H58UfZVQoPukhr0QJVO2OFpqedQVhm/FDPsiicigZHl5TFkDhFNSA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:1b8b:b0:dd9:20c1:85b6 with SMTP id
 ei11-20020a0569021b8b00b00dd920c185b6mr1004032ybb.2.1711739996049; Fri, 29
 Mar 2024 12:19:56 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:46 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-2-jrife@google.com>
Subject: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce sock_addr_testmod
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

sock_addr_testmod provides a mechanism for the sock_addr_kern prog_test
to drive socket operations in kernel space. On init, one of the
following socket operations is performed based on the module parameters:
kernel_bind(), kernel_connect(), or sock_sendmsg()/kernel_sendmsg() and
results are exposed through debugfs.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/Makefile          |  11 +-
 .../bpf/sock_addr_testmod/.gitignore          |   6 +
 .../selftests/bpf/sock_addr_testmod/Makefile  |  20 ++
 .../bpf/sock_addr_testmod/sock_addr_testmod.c | 256 ++++++++++++++++++
 4 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/.gitignore
 create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/Makefile
 create mode 100644 tools/testing/selftests/bpf/sock_addr_testmod/sock_addr_testmod.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b9eb40d63436..b5d02ff724957 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -132,7 +132,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko sock_addr_testmod.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -160,6 +160,7 @@ override define CLEAN
 	$(Q)$(RM) -r $(TEST_GEN_FILES)
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
 	$(Q)$(MAKE) -C bpf_testmod clean
+	$(Q)$(MAKE) -C sock_addr_testmod clean
 	$(Q)$(MAKE) docs-clean
 endef
 
@@ -260,6 +261,12 @@ $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_te
 	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
 	$(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
 
+$(OUTPUT)/sock_addr_testmod.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard sock_addr_testmod/Makefile sock_addr_testmod/*.[ch])
+	$(call msg,MOD,,$@)
+	$(Q)$(RM) sock_addr_testmod/sock_addr_testmod.ko # force re-compilation
+	$(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C sock_addr_testmod
+	$(Q)cp sock_addr_testmod/sock_addr_testmod.ko $@
+
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
 CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
@@ -638,6 +645,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 ip_check_defrag_frags.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/bpf_test_no_cfi.ko			\
+		       $(OUTPUT)/sock_addr_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
@@ -767,6 +775,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
 			       bpf_test_no_cfi.ko			\
+				   sock_addr_testmod.ko	\
 			       liburandom_read.so)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/sock_addr_testmod/.gitignore b/tools/testing/selftests/bpf/sock_addr_testmod/.gitignore
new file mode 100644
index 0000000000000..ded5137772813
--- /dev/null
+++ b/tools/testing/selftests/bpf/sock_addr_testmod/.gitignore
@@ -0,0 +1,6 @@
+*.mod
+*.mod.c
+*.o
+.ko
+/Module.symvers
+/modules.order
diff --git a/tools/testing/selftests/bpf/sock_addr_testmod/Makefile b/tools/testing/selftests/bpf/sock_addr_testmod/Makefile
new file mode 100644
index 0000000000000..47c92fb3a7748
--- /dev/null
+++ b/tools/testing/selftests/bpf/sock_addr_testmod/Makefile
@@ -0,0 +1,20 @@
+SOCK_ADDR_TEST_MOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(abspath $(SOCK_ADDR_TEST_MOD_DIR)/../../../../..)
+
+ifeq ($(V),1)
+Q =
+else
+Q = @
+endif
+
+MODULES = sock_addr_testmod.ko
+
+obj-m += sock_addr_testmod.o
+CFLAGS_sock_addr_testmod.o = -I$(src)
+
+all:
+	+$(Q)make -C $(KDIR) M=$(SOCK_ADDR_TEST_MOD_DIR) modules
+
+clean:
+	+$(Q)make -C $(KDIR) M=$(SOCK_ADDR_TEST_MOD_DIR) clean
+
diff --git a/tools/testing/selftests/bpf/sock_addr_testmod/sock_addr_testmod.c b/tools/testing/selftests/bpf/sock_addr_testmod/sock_addr_testmod.c
new file mode 100644
index 0000000000000..de0b2007f0829
--- /dev/null
+++ b/tools/testing/selftests/bpf/sock_addr_testmod/sock_addr_testmod.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+#include <linux/net.h>
+#include <linux/socket.h>
+#include <linux/nsproxy.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/un.h>
+#include <linux/debugfs.h>
+#include <net/sock.h>
+
+#define BIND    0
+#define CONNECT 1
+#define SENDMSG 2
+
+#define CONNECT_TIMEOUT_SEC 1
+
+static char ip[256];
+module_param_string(ip, ip, sizeof(ip), 0644);
+MODULE_PARM_DESC(ip, "IPv4/IPv6/Unix address to use for socket operation");
+static char port[7];
+module_param_string(port, port, sizeof(port), 0644);
+MODULE_PARM_DESC(port, "Port number to use for socket operation");
+static uint af;
+module_param(af, uint, 0644);
+MODULE_PARM_DESC(af, "Address family (AF_INET, AF_INET6, or AF_UNIX)");
+static int type;
+module_param(type, int, 0644);
+MODULE_PARM_DESC(type, "Socket type (SOCK_STREAM or SOCK_DGRAM)");
+static uint op;
+module_param(op, uint, 0644);
+MODULE_PARM_DESC(op, "Socket operation (BIND=0, CONNECT=1, SENDMSG=2)");
+
+static struct debugfs_blob_wrapper sock_name_blob;
+static struct debugfs_blob_wrapper peer_name_blob;
+static struct debugfs_blob_wrapper addr_blob;
+static struct dentry *debugfs_dentry;
+static struct sockaddr_storage sock_name;
+static struct sockaddr_storage peer_name;
+static struct sockaddr_storage addr;
+static bool success;
+
+static struct socket *sock;
+
+static int do_kernel_bind(struct sockaddr *addr, int addrlen)
+{
+	int err;
+
+	err = kernel_bind(sock, (struct sockaddr *)addr, addrlen);
+	if (err) {
+		pr_err("kernel_bind() returned %d\n", err);
+		goto err;
+	}
+
+	err = kernel_getsockname(sock, (struct sockaddr *)&sock_name);
+	if (err < 0) {
+		pr_err("kernel_getsockname() returned %d\n", err);
+		goto err;
+	}
+
+	if (type == SOCK_STREAM) {
+		err = kernel_listen(sock, 128);
+		if (err == -1) {
+			pr_err("kernel_listen() returned %d\n", err);
+			goto err;
+		}
+	}
+
+	err = 0;
+	goto out;
+err:
+	err = -1;
+out:
+	return err;
+}
+
+static int do_kernel_connect(struct sockaddr *addr, int addrlen)
+{
+	int err;
+
+	/* Set timeout for call to kernel_connect() to prevent it from hanging,
+	 * and consider the connection attempt failed if it returns
+	 * -EINPROGRESS.
+	 */
+	sock->sk->sk_sndtimeo = CONNECT_TIMEOUT_SEC * HZ;
+
+	err = kernel_connect(sock, addr, addrlen, 0);
+	if (err) {
+		pr_err("kernel_connect() returned %d\n", err);
+		goto err;
+	}
+
+	err = kernel_getsockname(sock, (struct sockaddr *)&sock_name);
+	if (err < 0) {
+		pr_err("kernel_getsockname() returned %d\n", err);
+		goto err;
+	}
+
+	err = kernel_getpeername(sock, (struct sockaddr *)&peer_name);
+	if (err < 0) {
+		pr_err("kernel_getpeername() returned %d\n", err);
+		goto err;
+	}
+
+	err = 0;
+	goto out;
+err:
+	err = -1;
+out:
+	return err;
+}
+
+static int do_kernel_sendmsg(struct sockaddr *addr, int addrlen)
+{
+	struct msghdr msg = {
+		.msg_name	= addr,
+		.msg_namelen	= addrlen,
+	};
+	struct kvec iov;
+	int err;
+
+	iov.iov_base = "abc";
+	iov.iov_len  = sizeof("abc");
+
+	err = kernel_sendmsg(sock, &msg, &iov, 1, sizeof("abc"));
+	if (err < 0) {
+		pr_err("kernel_sendmsg() returned %d\n", err);
+		goto err;
+	}
+
+	/* Unix socket sockaddr hooks may transform msg_namelen. Make sure it is
+	 * unmodified after the call to kernel_sendmsg().
+	 */
+	if (msg.msg_namelen != addrlen) {
+		pr_err("msg_namelen was modified (original=%d,current=%d)\n", addrlen, msg.msg_namelen);
+		goto err;
+	}
+
+	/* kernel_sendmsg() and sock_sendmsg() are both used throughout the
+	 * kernel. Neither of these functions should modify msg_name, so call
+	 * both just to make sure.
+	 */
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, sizeof("abc"));
+	err = sock_sendmsg(sock, &msg);
+	if (err < 0) {
+		pr_err("sock_sendmsg() returned %d\n", err);
+		goto err;
+	}
+
+	/* Unix socket sockaddr hooks may transform msg_namelen. Make sure it is
+	* unmodified after the call to sock_sendmsg().
+	*/
+	if (msg.msg_namelen != addrlen) {
+		pr_err("msg_namelen was modified (original=%d,current=%d)\n", addrlen, msg.msg_namelen);
+		goto err;
+	}
+
+	err = 0;
+	goto out;
+err:
+	err = -1;
+out:
+	return err;
+}
+
+static int do_sock_op(int op, struct sockaddr *addr, int addrlen)
+{
+	switch (op) {
+	case BIND:
+		return do_kernel_bind(addr, addrlen);
+	case CONNECT:
+		return do_kernel_connect(addr, addrlen);
+	case SENDMSG:
+		return do_kernel_sendmsg(addr, addrlen);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int kernel_sock_addr_testmod_init(void)
+{
+	int addr_len = sizeof(struct sockaddr_storage);
+	int proto;
+	int err;
+
+	debugfs_dentry = debugfs_create_dir("sock_addr_testmod", NULL);
+
+	addr_blob.data = &addr;
+	addr_blob.size = sizeof(addr);
+	sock_name_blob.data = &sock_name;
+	sock_name_blob.size = sizeof(sock_name);
+	peer_name_blob.data = &peer_name;
+	peer_name_blob.size = sizeof(peer_name);
+
+	debugfs_create_blob("addr", 0444, debugfs_dentry, &addr_blob);
+	debugfs_create_blob("sock_name", 0444, debugfs_dentry, &sock_name_blob);
+	debugfs_create_blob("peer_name", 0444, debugfs_dentry, &peer_name_blob);
+	debugfs_create_bool("success", 0444, debugfs_dentry, &success);
+
+	switch (af) {
+	case AF_INET:
+	case AF_INET6:
+		err = inet_pton_with_scope(&init_net, af, ip, port, &addr);
+		if (err) {
+			pr_err("inet_pton_with_scope() returned %d\n", err);
+			goto err;
+		}
+
+		proto = type == SOCK_STREAM ? IPPROTO_TCP : IPPROTO_UDP;
+		break;
+	case AF_UNIX:
+		memset(&addr, 0, sizeof(addr));
+		((struct sockaddr_un *)&addr)->sun_family = AF_UNIX;
+		((struct sockaddr_un *)&addr)->sun_path[0] = 0; // abstract
+		strcpy(((struct sockaddr_un *)&addr)->sun_path + 1, ip);
+		addr_len = offsetof(struct sockaddr_un, sun_path) + 1 +
+			   strlen(ip);
+		proto = PF_UNIX;
+		break;
+	default:
+		pr_err("invalid address family %d\n", af);
+		goto err;
+	}
+
+	err = sock_create_kern(&init_net, af, type, proto, &sock);
+	if (err) {
+		pr_err("sock_create_kern() returned %d\n", err);
+		goto err;
+	}
+
+	if (do_sock_op(op, (struct sockaddr *)&addr, addr_len))
+		goto err;
+
+	success = true;
+	goto out;
+err:
+	success = false;
+out:
+	return 0;
+}
+
+static void kernel_sock_addr_testmod_exit(void)
+{
+	if (sock)
+		sock_release(sock);
+
+	debugfs_remove_recursive(debugfs_dentry);
+}
+
+module_init(kernel_sock_addr_testmod_init);
+module_exit(kernel_sock_addr_testmod_exit);
+
+MODULE_AUTHOR("Jordan Rife");
+MODULE_DESCRIPTION("BPF socket address selftests module");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.44.0.478.gd926399ef9-goog


