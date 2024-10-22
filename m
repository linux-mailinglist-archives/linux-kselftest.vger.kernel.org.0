Return-Path: <linux-kselftest+bounces-20406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A89AB215
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6BF1C226FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1061A3A8F;
	Tue, 22 Oct 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpyjaaM9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647B1A76B7
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610966; cv=none; b=q4FlBGfXf4GyL3klIiVOlicFyMs/h72Vp5l7iVi4cNVL70GnOPmUmrYrAlKh3cmpy7Nv7HimqOWWMz7D4ohUTY1kcO16DKUJ9CwUxU942a0bZLszqzkHq5xm4rZ0p52Sixqm1i5tFVPIILv1I12UOxV/bnZaOp+lHeVYTyQa72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610966; c=relaxed/simple;
	bh=IQywR3lFRN7aNWtJYEJ/wyQtPB6YrH7M0/VCMAkwKBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQhLKqBC8u2Mgskg6f4HkiMS7zhQkaRMSeyCnYJsvJYTOpfSfd/a7sGMBI2OdupTQnraGbBdohNoT8SL1Pn1DR6dFm0Qg7I3wBo4EqFitZ9eJ6eNbLirWvn9txoOOrhczFtyjum0KGeCR5P64ICYroIzwdQnKzsk6twbQ5nf/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpyjaaM9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d1fe1dd173so4549141a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610964; x=1730215764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WY7mu2317PQTgnlqdNIzln+fHh6bcofJh5E/NHzXWh4=;
        b=rpyjaaM9pFwVzzNPbLn1SxBjNxC8l6yIzwvxxJpkfXWFgZ1T1t9QxqQPpiTdSNtuZ2
         a3Wm0kW4GbTccNCEdh9xM9FyarWBsV/BT/gvZ2AMyPaQjquee1K6nzxE5eKs2+O+nTp9
         jL40Vt/zY9fNsofnRbeeb0VPn/fxWWh6CPpSlgAOq13loGzZ7/KxAlUAG17BuaNul8Z5
         h1He6aTZzzaQfX1PWa2Mp6J7ta3Et9o76gaC2zDzr0a4bBU8qHs8OiJy7JcYroLoRGGn
         epgIPYJe1RWNRwR2oXUj6N4hqMVfEmTLtcYMKWENCOTdlV2CnrAXxJW222hX6yVC/xjG
         JHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610964; x=1730215764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY7mu2317PQTgnlqdNIzln+fHh6bcofJh5E/NHzXWh4=;
        b=H7x4F5F1uyjgruPNZ215EzesR2K3ZNG1S7z7oclLSp34JkB4hRXB+VeSHLEeQ4ErL2
         3YlTgy2VdqE3F/7cEp39YfDdPPBL3GUGX59EudGKx+LK8zbi8rO7esh1b+28RAqo94AK
         CdY29NytfTe5n7fqubdmVh8FheXA4k7PjWwEmLB48qScn1HszB4MSg4pBn1E8LEwdePs
         Zu6GetNv240Xmw4VXohqc8gwoZOwuug2cFUE88GQ5DghNyYpZsv0+w46g9bqThm9umKF
         tSoYNyKFfPoCBu6TnD+vBsbUJoxcHG7IX7v1ZxJ4pbxBBBrJokfB2Em4+cg2C2meBRNZ
         E/tg==
X-Forwarded-Encrypted: i=1; AJvYcCW5d64Nl/yPndb+ots0fpph1hWu/czQoFqwkZcsJ3qO/MWC8HDyn5XZgrHTW4t2U/2UMIihIYJtgRa3TMx1FV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OG+2QtvAP4Do7R7jTvIpLk0nbt7dUtJ4dMFVcRiBgNSwjE5O
	PUtPfPzZS4JCM50KAYohZTwi7WyhWvgb/wBr5dyG41/g4JwZWOKFVwA9aMbrNgb1bQXh1JkkTw=
	=
X-Google-Smtp-Source: AGHT+IGmqJUoy3IsGyBoSWo21FWveS3/PadC+8tnN+PS9h2l4Sjcs37cnTCg5SzYaOr2Pm9SmpOwWl/Lzw==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a63:3858:0:b0:7ea:6ca8:bec5 with SMTP id
 41be03b00d2f7-7eacc893602mr16989a12.7.1729610964128; Tue, 22 Oct 2024
 08:29:24 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:04 +0000
In-Reply-To: <20241022152913.574836-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022152913.574836-1-jrife@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-5-jrife@google.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Retire test_sock.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Completely remove test_sock.c and associated config.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/.gitignore  |   1 -
 tools/testing/selftests/bpf/Makefile    |   3 +-
 tools/testing/selftests/bpf/test_sock.c | 231 ------------------------
 3 files changed, 1 insertion(+), 234 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/test_sock.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e6533b3400de..d45c9a9b304d 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -16,7 +16,6 @@ fixdep
 /test_progs-cpuv4
 test_verifier_log
 feature
-test_sock
 urandom_read
 test_sockmap
 test_lirc_mode2_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 28a76baa854d..c4fc9a3291a8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -84,7 +84,7 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_sock test_sockmap \
+	test_sockmap \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
 TEST_INST_SUBDIRS := no_alu32
@@ -335,7 +335,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
-$(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
deleted file mode 100644
index f97850f1d84a..000000000000
--- a/tools/testing/selftests/bpf/test_sock.c
+++ /dev/null
@@ -1,231 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-
-#include <stdio.h>
-#include <unistd.h>
-
-#include <arpa/inet.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-
-#include <linux/filter.h>
-
-#include <bpf/bpf.h>
-
-#include "cgroup_helpers.h"
-#include <bpf/bpf_endian.h>
-#include "bpf_util.h"
-
-#define CG_PATH		"/foo"
-#define MAX_INSNS	512
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-static bool verbose = false;
-
-struct sock_test {
-	const char *descr;
-	/* BPF prog properties */
-	struct bpf_insn	insns[MAX_INSNS];
-	enum bpf_attach_type expected_attach_type;
-	enum bpf_attach_type attach_type;
-	/* Socket properties */
-	int domain;
-	int type;
-	/* Endpoint to bind() to */
-	const char *ip;
-	unsigned short port;
-	unsigned short port_retry;
-	/* Expected test result */
-	enum {
-		LOAD_REJECT,
-		ATTACH_REJECT,
-		BIND_REJECT,
-		SUCCESS,
-		RETRY_SUCCESS,
-		RETRY_REJECT
-	} result;
-};
-
-static struct sock_test tests[] = {
-};
-
-static size_t probe_prog_length(const struct bpf_insn *fp)
-{
-	size_t len;
-
-	for (len = MAX_INSNS - 1; len > 0; --len)
-		if (fp[len].code != 0 || fp[len].imm != 0)
-			break;
-	return len + 1;
-}
-
-static int load_sock_prog(const struct bpf_insn *prog,
-			  enum bpf_attach_type attach_type)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	int ret, insn_cnt;
-
-	insn_cnt = probe_prog_length(prog);
-
-	opts.expected_attach_type = attach_type;
-	opts.log_buf = bpf_log_buf;
-	opts.log_size = BPF_LOG_BUF_SIZE;
-	opts.log_level = 2;
-
-	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", prog, insn_cnt, &opts);
-	if (verbose && ret < 0)
-		fprintf(stderr, "%s\n", bpf_log_buf);
-
-	return ret;
-}
-
-static int attach_sock_prog(int cgfd, int progfd,
-			    enum bpf_attach_type attach_type)
-{
-	return bpf_prog_attach(progfd, cgfd, attach_type, BPF_F_ALLOW_OVERRIDE);
-}
-
-static int bind_sock(int domain, int type, const char *ip,
-		     unsigned short port, unsigned short port_retry)
-{
-	struct sockaddr_storage addr;
-	struct sockaddr_in6 *addr6;
-	struct sockaddr_in *addr4;
-	int sockfd = -1;
-	socklen_t len;
-	int res = SUCCESS;
-
-	sockfd = socket(domain, type, 0);
-	if (sockfd < 0)
-		goto err;
-
-	memset(&addr, 0, sizeof(addr));
-
-	if (domain == AF_INET) {
-		len = sizeof(struct sockaddr_in);
-		addr4 = (struct sockaddr_in *)&addr;
-		addr4->sin_family = domain;
-		addr4->sin_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr4->sin_addr) != 1)
-			goto err;
-	} else if (domain == AF_INET6) {
-		len = sizeof(struct sockaddr_in6);
-		addr6 = (struct sockaddr_in6 *)&addr;
-		addr6->sin6_family = domain;
-		addr6->sin6_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr6->sin6_addr) != 1)
-			goto err;
-	} else {
-		goto err;
-	}
-
-	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
-		/* sys_bind() may fail for different reasons, errno has to be
-		 * checked to confirm that BPF program rejected it.
-		 */
-		if (errno != EPERM)
-			goto err;
-		if (port_retry)
-			goto retry;
-		res = BIND_REJECT;
-		goto out;
-	}
-
-	goto out;
-retry:
-	if (domain == AF_INET)
-		addr4->sin_port = htons(port_retry);
-	else
-		addr6->sin6_port = htons(port_retry);
-	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
-		if (errno != EPERM)
-			goto err;
-		res = RETRY_REJECT;
-	} else {
-		res = RETRY_SUCCESS;
-	}
-	goto out;
-err:
-	res = -1;
-out:
-	close(sockfd);
-	return res;
-}
-
-static int run_test_case(int cgfd, const struct sock_test *test)
-{
-	int progfd = -1;
-	int err = 0;
-	int res;
-
-	printf("Test case: %s .. ", test->descr);
-	progfd = load_sock_prog(test->insns, test->expected_attach_type);
-	if (progfd < 0) {
-		if (test->result == LOAD_REJECT)
-			goto out;
-		else
-			goto err;
-	}
-
-	if (attach_sock_prog(cgfd, progfd, test->attach_type) < 0) {
-		if (test->result == ATTACH_REJECT)
-			goto out;
-		else
-			goto err;
-	}
-
-	res = bind_sock(test->domain, test->type, test->ip, test->port,
-			test->port_retry);
-	if (res > 0 && test->result == res)
-		goto out;
-
-err:
-	err = -1;
-out:
-	/* Detaching w/o checking return code: best effort attempt. */
-	if (progfd != -1)
-		bpf_prog_detach(cgfd, test->attach_type);
-	close(progfd);
-	printf("[%s]\n", err ? "FAIL" : "PASS");
-	return err;
-}
-
-static int run_tests(int cgfd)
-{
-	int passes = 0;
-	int fails = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
-		if (run_test_case(cgfd, &tests[i]))
-			++fails;
-		else
-			++passes;
-	}
-	printf("Summary: %d PASSED, %d FAILED\n", passes, fails);
-	return fails ? -1 : 0;
-}
-
-int main(int argc, char **argv)
-{
-	int cgfd = -1;
-	int err = 0;
-
-	cgfd = cgroup_setup_and_join(CG_PATH);
-	if (cgfd < 0)
-		goto err;
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	if (run_tests(cgfd))
-		goto err;
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(cgfd);
-	cleanup_cgroup_environment();
-	return err;
-}
-- 
2.47.0.105.g07ac214952-goog


