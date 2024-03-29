Return-Path: <linux-kselftest+bounces-6887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF6892416
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE2F1C223C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469E13AD2A;
	Fri, 29 Mar 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3DNnXr7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89EE13A3FE
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740005; cv=none; b=NC/OFcuApZjCfX8VVHhsH+faANHMRsPzQR6huF60xIQvVeUqYjj3I0J0nkMS1S7CXhs/lxwssf+CRPusGx5A3B2L2UIlWM5xZCd8UAAkKDFg/GpgvVIf66N3gy+SCFljE5Q99vFwgG67moWvC0pFcVhpmjS876eCFBtG2Ijb9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740005; c=relaxed/simple;
	bh=BcjYvByBQLUQ9OPrptNdY42qwu+ggzunOSva7kCPrk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FARNLIpdou488GFz/NWMV5/j8LOx+djQxuW11Y0KjMAmWyL3n83V4uKXk2I7vRgOM0Bqv3PIITTKrRiiTbZ6zNFtfWwGv0uKFhpophbZCsbzqMZOD54cO17YA8Od6SkdAJ0pKusIGIXQKdESaQxcMdAck1/wPmgv/RhWmtl/q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3DNnXr7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc3cfa39so40268977b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740003; x=1712344803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FAb19c85kXjG8+dndUXZwZa/GQ2ubPPIIKCr0AviKI=;
        b=z3DNnXr7cca712s3BtGRnKK51EI1x5SzbTZXiii7Bi9xnk/3++QTUeCGCWuEAFaEhU
         GkaxbLOuvK/E53bXdqO8UGQkhl7MSe2xByTZME5Qa7+pArcsD67DdYpQEI31Kntbpxgf
         Y5BBV1iFojtr1VSpnhnXT/g2heE6yZ/iwvlaTmRv/v+KWn/pEpB+n6dnNLrK5hpkRHYz
         +7sxbgrlVkdMGE3fteOmv8v9rUvnG4XnYN0pNMEYYY2tcEfuoa9JoPZ/fS/gPz0/tANb
         +QJJFmYt8+pElh/xcYdj5YWFdTG6USZN6Kah9LZ2jzFVT0NBzpIS40C2QvlIELMuZkzG
         +Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740003; x=1712344803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FAb19c85kXjG8+dndUXZwZa/GQ2ubPPIIKCr0AviKI=;
        b=pEvhZqTKm7DbN2QIfKzu8cRt27lTyM7CoGi1k5oV4e+mpFXK1UpZNu7gFPMtONE7qd
         FQQu6tr3KoV3x1W+lPXUfeQe73wvfp478XriT1/gd0yrLVe11KY1UGqEV0ij7Eo+jlPc
         8tuifQirmGbHpX3fdptho0shd6Cy3qcelYTKZJjnzRU/XSg4fOPX474N2ObMbLSoNj2G
         WDM6WULt589B7lez2UjfCFbr0/godi03F+bQQ5ux1L2duVyEvXRmZutJtfTk6XEt6niP
         NzvDUYUr5/PlxzesW64S7Epi4IVh2Bdi6Wwtmq33GlqEewqYRdEjH7q3fbfpBnHVLS9k
         M/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWgFd2I9kdnyiYgPVYdgK2HVQWDV/W4cA0pmA9jHV+FuowtW9e++uDt2NBMJVkyvq31Sy3Rdzck4g+LCBVv3LvdYCdpaxttSfkc5pdzv7TU
X-Gm-Message-State: AOJu0Yxb2NEWfluSIN50p4Drru9udJ3PvJ81ZW6pWYAUTExJ5q+/Ok3R
	RSGBNkwsmh5xUq7DofOBfEEGtibhNk9ZRDxENHQRU3JZLUm7yBKoUTnDJ9HgkcOpnwjza34l2g=
	=
X-Google-Smtp-Source: AGHT+IGORRu2axiBp/EZZ3Bg2wSe7V1M05tc8fUgXvO/3fHJ2RgQuUdfelBAFL7UWWGTwpLFBQhVgg96rg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:52d3:0:b0:611:3096:bf60 with SMTP id
 g202-20020a8152d3000000b006113096bf60mr822271ywb.7.1711740002982; Fri, 29 Mar
 2024 12:20:02 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:50 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-6-jrife@google.com>
Subject: [PATCH v1 bpf-next 5/8] selftests/bpf: Factor out load_path and
 defines from test_sock_addr
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

Factor out useful defines and load_path() from the test_sock_addr self
test to use them in sock_addr_kern.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/Makefile          | 34 +++++----
 .../testing/selftests/bpf/sock_addr_helpers.c | 46 +++++++++++
 .../testing/selftests/bpf/sock_addr_helpers.h | 44 +++++++++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 76 +++----------------
 4 files changed, 120 insertions(+), 80 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/sock_addr_helpers.c
 create mode 100644 tools/testing/selftests/bpf/sock_addr_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b5d02ff724957..ccc1c11559a45 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -291,6 +291,7 @@ TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
+SOCK_ADDR_HELPERS := $(OUTPUT)/sock_addr_helpers.o
 TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
 CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
 UNPRIV_HELPERS  := $(OUTPUT)/unpriv_helpers.o
@@ -301,7 +302,7 @@ CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
-$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(SOCK_ADDR_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
@@ -628,21 +629,22 @@ endef
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
-TRUNNER_EXTRA_SOURCES := test_progs.c		\
-			 cgroup_helpers.c	\
-			 trace_helpers.c	\
-			 network_helpers.c	\
-			 testing_helpers.c	\
-			 btf_helpers.c		\
-			 cap_helpers.c		\
-			 unpriv_helpers.c 	\
-			 netlink_helpers.c	\
-			 test_loader.c		\
-			 xsk.c			\
-			 disasm.c		\
-			 json_writer.c 		\
-			 flow_dissector_load.h	\
-			 ip_check_defrag_frags.h
+TRUNNER_EXTRA_SOURCES := test_progs.c		 \
+			 cgroup_helpers.c	 \
+			 trace_helpers.c	 \
+			 network_helpers.c	 \
+			 testing_helpers.c	 \
+			 btf_helpers.c		 \
+			 cap_helpers.c		 \
+			 unpriv_helpers.c 	 \
+			 netlink_helpers.c	 \
+			 test_loader.c		 \
+			 xsk.c			 \
+			 disasm.c		 \
+			 json_writer.c 		 \
+			 flow_dissector_load.h	 \
+			 ip_check_defrag_frags.h \
+			 sock_addr_helpers.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/bpf_test_no_cfi.ko			\
 		       $(OUTPUT)/sock_addr_testmod.ko	\
diff --git a/tools/testing/selftests/bpf/sock_addr_helpers.c b/tools/testing/selftests/bpf/sock_addr_helpers.c
new file mode 100644
index 0000000000000..ff2eb09870f16
--- /dev/null
+++ b/tools/testing/selftests/bpf/sock_addr_helpers.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "cgroup_helpers.h"
+#include "sock_addr_helpers.h"
+#include "testing_helpers.h"
+
+int load_path(const char *path, enum bpf_attach_type attach_type,
+	      bool expect_reject)
+{
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	int err;
+
+	obj = bpf_object__open_file(path, NULL);
+	err = libbpf_get_error(obj);
+	if (err) {
+		log_err(">>> Opening BPF object (%s) error.\n", path);
+		return -1;
+	}
+
+	prog = bpf_object__next_program(obj, NULL);
+	if (!prog)
+		goto err_out;
+
+	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
+	bpf_program__set_expected_attach_type(prog, attach_type);
+	bpf_program__set_flags(prog, testing_prog_flags());
+
+	err = bpf_object__load(obj);
+	if (err) {
+		if (!expect_reject)
+			log_err(">>> Loading program (%s) error.\n", path);
+		goto err_out;
+	}
+
+	return bpf_program__fd(prog);
+err_out:
+	bpf_object__close(obj);
+	return -1;
+}
diff --git a/tools/testing/selftests/bpf/sock_addr_helpers.h b/tools/testing/selftests/bpf/sock_addr_helpers.h
new file mode 100644
index 0000000000000..cb17579075143
--- /dev/null
+++ b/tools/testing/selftests/bpf/sock_addr_helpers.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOCK_ADDR_HELPERS_H
+#define __SOCK_ADDR_HELPERS_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#define CONNECT4_PROG_PATH	"./connect4_prog.bpf.o"
+#define CONNECT6_PROG_PATH	"./connect6_prog.bpf.o"
+#define CONNECTUN_PROG_PATH	"./connect_unix_prog.bpf.o"
+#define SENDMSG4_PROG_PATH	"./sendmsg4_prog.bpf.o"
+#define SENDMSG6_PROG_PATH	"./sendmsg6_prog.bpf.o"
+#define RECVMSG4_PROG_PATH	"./recvmsg4_prog.bpf.o"
+#define RECVMSG6_PROG_PATH	"./recvmsg6_prog.bpf.o"
+#define BIND4_PROG_PATH		"./bind4_prog.bpf.o"
+#define BIND6_PROG_PATH		"./bind6_prog.bpf.o"
+
+#define SERV4_IP		"192.168.1.254"
+#define SERV4_REWRITE_IP	"127.0.0.1"
+#define SRC4_IP			"172.16.0.1"
+#define SRC4_REWRITE_IP		"127.0.0.4"
+#define SERV4_PORT		4040
+#define SERV4_REWRITE_PORT	4444
+
+#define SERV6_IP		"face:b00c:1234:5678::abcd"
+#define SERV6_REWRITE_IP	"::1"
+#define SERV6_V4MAPPED_IP	"::ffff:192.168.0.4"
+#define SRC6_IP			"::1"
+#define SRC6_REWRITE_IP		"::6"
+#define WILDCARD6_IP		"::"
+#define SERV6_PORT		6060
+#define SERV6_REWRITE_PORT	6666
+
+#define SERVUN_ADDRESS         "bpf_cgroup_unix_test"
+#define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
+
+int load_path(const char *path, enum bpf_attach_type attach_type,
+	      bool expected_reject);
+
+#endif
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 80c42583f5977..89c106832f9a4 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -21,37 +21,13 @@
 #include "cgroup_helpers.h"
 #include "testing_helpers.h"
 #include "bpf_util.h"
+#include "sock_addr_helpers.h"
 
 #ifndef ENOTSUPP
 # define ENOTSUPP 524
 #endif
 
 #define CG_PATH	"/foo"
-#define CONNECT4_PROG_PATH	"./connect4_prog.bpf.o"
-#define CONNECT6_PROG_PATH	"./connect6_prog.bpf.o"
-#define SENDMSG4_PROG_PATH	"./sendmsg4_prog.bpf.o"
-#define SENDMSG6_PROG_PATH	"./sendmsg6_prog.bpf.o"
-#define RECVMSG4_PROG_PATH	"./recvmsg4_prog.bpf.o"
-#define RECVMSG6_PROG_PATH	"./recvmsg6_prog.bpf.o"
-#define BIND4_PROG_PATH		"./bind4_prog.bpf.o"
-#define BIND6_PROG_PATH		"./bind6_prog.bpf.o"
-
-#define SERV4_IP		"192.168.1.254"
-#define SERV4_REWRITE_IP	"127.0.0.1"
-#define SRC4_IP			"172.16.0.1"
-#define SRC4_REWRITE_IP		"127.0.0.4"
-#define SERV4_PORT		4040
-#define SERV4_REWRITE_PORT	4444
-
-#define SERV6_IP		"face:b00c:1234:5678::abcd"
-#define SERV6_REWRITE_IP	"::1"
-#define SERV6_V4MAPPED_IP	"::ffff:192.168.0.4"
-#define SRC6_IP			"::1"
-#define SRC6_REWRITE_IP		"::6"
-#define WILDCARD6_IP		"::"
-#define SERV6_PORT		6060
-#define SERV6_REWRITE_PORT	6666
-
 #define INET_NTOP_BUF	40
 
 struct sock_addr_test;
@@ -661,58 +637,30 @@ static int load_insns(const struct sock_addr_test *test,
 	return ret;
 }
 
-static int load_path(const struct sock_addr_test *test, const char *path)
+static int ld_path(const struct sock_addr_test *test, const char *path)
 {
-	struct bpf_object *obj;
-	struct bpf_program *prog;
-	int err;
-
-	obj = bpf_object__open_file(path, NULL);
-	err = libbpf_get_error(obj);
-	if (err) {
-		log_err(">>> Opening BPF object (%s) error.\n", path);
-		return -1;
-	}
-
-	prog = bpf_object__next_program(obj, NULL);
-	if (!prog)
-		goto err_out;
-
-	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
-	bpf_program__set_expected_attach_type(prog, test->expected_attach_type);
-	bpf_program__set_flags(prog, testing_prog_flags());
-
-	err = bpf_object__load(obj);
-	if (err) {
-		if (test->expected_result != LOAD_REJECT)
-			log_err(">>> Loading program (%s) error.\n", path);
-		goto err_out;
-	}
-
-	return bpf_program__fd(prog);
-err_out:
-	bpf_object__close(obj);
-	return -1;
+	return load_path(path, test->expected_attach_type,
+			 test->expected_result == LOAD_REJECT);
 }
 
 static int bind4_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, BIND4_PROG_PATH);
+	return ld_path(test, BIND4_PROG_PATH);
 }
 
 static int bind6_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, BIND6_PROG_PATH);
+	return ld_path(test, BIND6_PROG_PATH);
 }
 
 static int connect4_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, CONNECT4_PROG_PATH);
+	return ld_path(test, CONNECT4_PROG_PATH);
 }
 
 static int connect6_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, CONNECT6_PROG_PATH);
+	return ld_path(test, CONNECT6_PROG_PATH);
 }
 
 static int xmsg_ret_only_prog_load(const struct sock_addr_test *test,
@@ -800,12 +748,12 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 
 static int recvmsg4_rw_c_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, RECVMSG4_PROG_PATH);
+	return ld_path(test, RECVMSG4_PROG_PATH);
 }
 
 static int sendmsg4_rw_c_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, SENDMSG4_PROG_PATH);
+	return ld_path(test, SENDMSG4_PROG_PATH);
 }
 
 static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
@@ -868,7 +816,7 @@ static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test)
 
 static int recvmsg6_rw_c_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, RECVMSG6_PROG_PATH);
+	return ld_path(test, RECVMSG6_PROG_PATH);
 }
 
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test)
@@ -883,7 +831,7 @@ static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test)
 
 static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test)
 {
-	return load_path(test, SENDMSG6_PROG_PATH);
+	return ld_path(test, SENDMSG6_PROG_PATH);
 }
 
 static int cmp_addr(const struct sockaddr_storage *addr1,
-- 
2.44.0.478.gd926399ef9-goog


