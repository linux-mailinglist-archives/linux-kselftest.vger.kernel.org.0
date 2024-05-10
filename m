Return-Path: <linux-kselftest+bounces-10040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7CA8C2A46
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCB11C2233F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C634642A;
	Fri, 10 May 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1pP/TPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CD48787
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367792; cv=none; b=JCSdsXFMl62T/dQvLneaPbi6cej18TGRoJZWbx22Tw/wZPJt2ZyA/3f1xGcoF2Qn2EfAmmd7r1z4FyAfS+rDjtOO9vBMGWFOEIPseuaGl8izpkWxQU6aFvt3W/kJ/A5gsiZ4mb7GAs5/fAn/pdiZ5f3x795bp1ltcTHJv0jSm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367792; c=relaxed/simple;
	bh=tpcuX1lsX+7m7+4UGzGs//nK3dpdTMA83w+9IE/GC2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMd4geFmdWVrK1cfi3zuUOQ+74Ki3IHfYZp1+Rv8XhP48XLthfs/YkrEvP3v9z9BK6a3Smmu3es+V/VgLaC+mnIKaqCI0MljhPbjemf+rM8V+6hrEOKjFtD35tV6GJ3VrpHK1VGDc0c7w88YXwn+qEQzh19Yq7/pmo7CRCvQojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1pP/TPx; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7e1c3c98401so31288039f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367790; x=1715972590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUKODdBPNP/+fMBcCuGO4XbHWmxiUDNXspGEKF7iwTE=;
        b=X1pP/TPxYOAzf7bI1eApCNoRtUfa8xc3nuUvbAktyzdiBDsGlvP/Eoty/vpLZgI9Qe
         CtRzjirAcOcfKsnYVsP8Uahu/qLgvYhpKwyv2fGL6IOk0+MnMVdjpk1a3chS4PfU+kUl
         Bu9kR+DQMFu3PyXI/QPL33l/7V6tDghpXUBtY1StPETPKpA9RoEU/yZFnshZYiL4Ogac
         rACH2pYqtMvPKS8PBki7bEHuX7RsV2pQV6QwxglqQQrQ6AX+AT5ulzTi2PK/V0ay0hB4
         kAXbZP6Htil+uGGjgYnn40+E9XnHTtvGG/HkPV9FQglywcCEvBG7T4MqSuojWOt6I95t
         TmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367790; x=1715972590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUKODdBPNP/+fMBcCuGO4XbHWmxiUDNXspGEKF7iwTE=;
        b=nyPcaGtsio4aVX/Lf9JS8lTw8peZnw2KadD85101Z2MGOSBkOaJKkUttS2kaWOH170
         bCjlK4rPQ7Q3F4UBJpcRAdwNUOV+/uV0fSlG99NGcqz+htq+cJU7V4nQCjt1njk1Pcdy
         Y0NOgAYMXYt+IsxHyJgGwnxEgUy9CYg+N7m/B8ShfbDI8I15ZUD16fqbgEf0NAKBl53B
         PH8sUA62sgdweWGgIpOYwx4kGeb4xOUvbv/Jv1+2Hcezhk1xwL5AHNzFKomnXZ6pgT2B
         AbgXG5ls1+GiNhG90Qwix3tol4Ii0CcerwMSqRTmwgYZvAFYHRp8fQAKvbZij/V/TEFE
         02EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5k8DrMkAstgGFf++oLue2FKireKFX/eoKEqoZH9fhOh2Ja0Ab2As5BF8tdPbxe0adbFgxIP3F5jFKqA41d9GgR5cXVFgVnt1X1YhseAN7
X-Gm-Message-State: AOJu0YzZykMuMqGevsrmXgCF8bwv+Ob33vZu52v/BiGGezAe4bfYJbM+
	RBsylWaBSe59VYLgdB+MHbtyUguOszyB7GhhKv4POg+XqB20Vkj4Zd08697D7MPW4Nu7MdGp3g=
	=
X-Google-Smtp-Source: AGHT+IHa924EBVpwCqsttRMEFgomQJ7Wb+/4cpTH1sPijl8MmbDZCVkPHAu3g2hnteBDeKp5gITKamFzeQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6602:608c:b0:7de:3f44:a6fe with SMTP id
 ca18e2360f4ac-7e1b519cfb4mr10981839f.1.1715367790048; Fri, 10 May 2024
 12:03:10 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:30 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-14-jrife@google.com>
Subject: [PATCH v1 bpf-next 13/17] selftests/bpf: Retire test_sock_addr.(c|sh)
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fully remove test_sock_addr.c and test_sock_addr.sh, as test coverage
has been fully moved to prog_tests/sock_addr.c.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/test_sock_addr.c  | 574 ------------------
 tools/testing/selftests/bpf/test_sock_addr.sh |  58 --
 4 files changed, 1 insertion(+), 636 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
 delete mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index f1aebabfb0176..5025401323afb 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -17,7 +17,6 @@ test_dev_cgroup
 test_verifier_log
 feature
 test_sock
-test_sock_addr
 urandom_read
 test_sockmap
 test_lirc_mode2_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 135023a357b3b..ed381b0197fe4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -115,7 +115,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect_multi.sh \
 	test_xdp_meta.sh \
 	test_xdp_veth.sh \
-	test_sock_addr.sh \
 	test_tunnel.sh \
 	test_lwt_seg6local.sh \
 	test_lirc_mode2.sh \
@@ -140,7 +139,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 	test_xdp_vlan.sh test_bpftool.py
 
 # Compile but not part of 'make run_tests'
-TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
+TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
@@ -296,7 +295,6 @@ NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
-$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(NETWORK_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
deleted file mode 100644
index a2b587273331c..0000000000000
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ /dev/null
@@ -1,574 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include <arpa/inet.h>
-#include <netinet/in.h>
-#include <sys/types.h>
-#include <sys/select.h>
-#include <sys/socket.h>
-
-#include <linux/filter.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "cgroup_helpers.h"
-#include "network_helpers.h"
-#include "testing_helpers.h"
-#include "bpf_util.h"
-
-#ifndef ENOTSUPP
-# define ENOTSUPP 524
-#endif
-
-#define CG_PATH	"/foo"
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
-#define INET_NTOP_BUF	40
-
-struct sock_addr_test;
-
-typedef int (*load_fn)(const struct sock_addr_test *test);
-typedef int (*info_fn)(int, struct sockaddr *, socklen_t *);
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
-struct sock_addr_test {
-	const char *descr;
-	/* BPF prog properties */
-	load_fn loadfn;
-	enum bpf_attach_type expected_attach_type;
-	enum bpf_attach_type attach_type;
-	/* Socket properties */
-	int domain;
-	int type;
-	/* IP:port pairs for BPF prog to override */
-	const char *requested_ip;
-	unsigned short requested_port;
-	const char *expected_ip;
-	unsigned short expected_port;
-	const char *expected_src_ip;
-	/* Expected test result */
-	enum {
-		LOAD_REJECT,
-		ATTACH_REJECT,
-		ATTACH_OKAY,
-		SYSCALL_EPERM,
-		SYSCALL_ENOTSUPP,
-		SUCCESS,
-	} expected_result;
-};
-
-static struct sock_addr_test tests[] = {
-};
-
-static int cmp_addr(const struct sockaddr_storage *addr1,
-		    const struct sockaddr_storage *addr2, int cmp_port)
-{
-	const struct sockaddr_in *four1, *four2;
-	const struct sockaddr_in6 *six1, *six2;
-
-	if (addr1->ss_family != addr2->ss_family)
-		return -1;
-
-	if (addr1->ss_family == AF_INET) {
-		four1 = (const struct sockaddr_in *)addr1;
-		four2 = (const struct sockaddr_in *)addr2;
-		return !((four1->sin_port == four2->sin_port || !cmp_port) &&
-			 four1->sin_addr.s_addr == four2->sin_addr.s_addr);
-	} else if (addr1->ss_family == AF_INET6) {
-		six1 = (const struct sockaddr_in6 *)addr1;
-		six2 = (const struct sockaddr_in6 *)addr2;
-		return !((six1->sin6_port == six2->sin6_port || !cmp_port) &&
-			 !memcmp(&six1->sin6_addr, &six2->sin6_addr,
-				 sizeof(struct in6_addr)));
-	}
-
-	return -1;
-}
-
-static int cmp_sock_addr(info_fn fn, int sock1,
-			 const struct sockaddr_storage *addr2, int cmp_port)
-{
-	struct sockaddr_storage addr1;
-	socklen_t len1 = sizeof(addr1);
-
-	memset(&addr1, 0, len1);
-	if (fn(sock1, (struct sockaddr *)&addr1, (socklen_t *)&len1) != 0)
-		return -1;
-
-	return cmp_addr(&addr1, addr2, cmp_port);
-}
-
-static int cmp_local_ip(int sock1, const struct sockaddr_storage *addr2)
-{
-	return cmp_sock_addr(getsockname, sock1, addr2, /*cmp_port*/ 0);
-}
-
-static int cmp_local_addr(int sock1, const struct sockaddr_storage *addr2)
-{
-	return cmp_sock_addr(getsockname, sock1, addr2, /*cmp_port*/ 1);
-}
-
-static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
-{
-	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
-}
-
-int init_pktinfo(int domain, struct cmsghdr *cmsg)
-{
-	struct in6_pktinfo *pktinfo6;
-	struct in_pktinfo *pktinfo4;
-
-	if (domain == AF_INET) {
-		cmsg->cmsg_level = SOL_IP;
-		cmsg->cmsg_type = IP_PKTINFO;
-		cmsg->cmsg_len = CMSG_LEN(sizeof(struct in_pktinfo));
-		pktinfo4 = (struct in_pktinfo *)CMSG_DATA(cmsg);
-		memset(pktinfo4, 0, sizeof(struct in_pktinfo));
-		if (inet_pton(domain, SRC4_IP,
-			      (void *)&pktinfo4->ipi_spec_dst) != 1)
-			return -1;
-	} else if (domain == AF_INET6) {
-		cmsg->cmsg_level = SOL_IPV6;
-		cmsg->cmsg_type = IPV6_PKTINFO;
-		cmsg->cmsg_len = CMSG_LEN(sizeof(struct in6_pktinfo));
-		pktinfo6 = (struct in6_pktinfo *)CMSG_DATA(cmsg);
-		memset(pktinfo6, 0, sizeof(struct in6_pktinfo));
-		if (inet_pton(domain, SRC6_IP,
-			      (void *)&pktinfo6->ipi6_addr) != 1)
-			return -1;
-	} else {
-		return -1;
-	}
-
-	return 0;
-}
-
-static int sendmsg_to_server(int type, const struct sockaddr_storage *addr,
-			     socklen_t addr_len, int set_cmsg, int flags,
-			     int *syscall_err)
-{
-	union {
-		char buf[CMSG_SPACE(sizeof(struct in6_pktinfo))];
-		struct cmsghdr align;
-	} control6;
-	union {
-		char buf[CMSG_SPACE(sizeof(struct in_pktinfo))];
-		struct cmsghdr align;
-	} control4;
-	struct msghdr hdr;
-	struct iovec iov;
-	char data = 'a';
-	int domain;
-	int fd = -1;
-
-	domain = addr->ss_family;
-
-	if (domain != AF_INET && domain != AF_INET6) {
-		log_err("Unsupported address family");
-		goto err;
-	}
-
-	fd = socket(domain, type, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto err;
-	}
-
-	memset(&iov, 0, sizeof(iov));
-	iov.iov_base = &data;
-	iov.iov_len = sizeof(data);
-
-	memset(&hdr, 0, sizeof(hdr));
-	hdr.msg_name = (void *)addr;
-	hdr.msg_namelen = addr_len;
-	hdr.msg_iov = &iov;
-	hdr.msg_iovlen = 1;
-
-	if (set_cmsg) {
-		if (domain == AF_INET) {
-			hdr.msg_control = &control4;
-			hdr.msg_controllen = sizeof(control4.buf);
-		} else if (domain == AF_INET6) {
-			hdr.msg_control = &control6;
-			hdr.msg_controllen = sizeof(control6.buf);
-		}
-		if (init_pktinfo(domain, CMSG_FIRSTHDR(&hdr))) {
-			log_err("Fail to init pktinfo");
-			goto err;
-		}
-	}
-
-	if (sendmsg(fd, &hdr, flags) != sizeof(data)) {
-		log_err("Fail to send message to server");
-		*syscall_err = errno;
-		goto err;
-	}
-
-	goto out;
-err:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
-static int fastconnect_to_server(const struct sockaddr_storage *addr,
-				 socklen_t addr_len)
-{
-	int sendmsg_err;
-
-	return sendmsg_to_server(SOCK_STREAM, addr, addr_len, /*set_cmsg*/0,
-				 MSG_FASTOPEN, &sendmsg_err);
-}
-
-static int recvmsg_from_client(int sockfd, struct sockaddr_storage *src_addr)
-{
-	struct timeval tv;
-	struct msghdr hdr;
-	struct iovec iov;
-	char data[64];
-	fd_set rfds;
-
-	FD_ZERO(&rfds);
-	FD_SET(sockfd, &rfds);
-
-	tv.tv_sec = 2;
-	tv.tv_usec = 0;
-
-	if (select(sockfd + 1, &rfds, NULL, NULL, &tv) <= 0 ||
-	    !FD_ISSET(sockfd, &rfds))
-		return -1;
-
-	memset(&iov, 0, sizeof(iov));
-	iov.iov_base = data;
-	iov.iov_len = sizeof(data);
-
-	memset(&hdr, 0, sizeof(hdr));
-	hdr.msg_name = src_addr;
-	hdr.msg_namelen = sizeof(struct sockaddr_storage);
-	hdr.msg_iov = &iov;
-	hdr.msg_iovlen = 1;
-
-	return recvmsg(sockfd, &hdr, 0);
-}
-
-static int init_addrs(const struct sock_addr_test *test,
-		      struct sockaddr_storage *requested_addr,
-		      struct sockaddr_storage *expected_addr,
-		      struct sockaddr_storage *expected_src_addr)
-{
-	if (make_sockaddr(test->domain, test->expected_ip, test->expected_port,
-			  expected_addr, NULL) == -1)
-		goto err;
-
-	if (make_sockaddr(test->domain, test->requested_ip, test->requested_port,
-			  requested_addr, NULL) == -1)
-		goto err;
-
-	if (test->expected_src_ip &&
-	    make_sockaddr(test->domain, test->expected_src_ip, 0,
-			  expected_src_addr, NULL) == -1)
-		goto err;
-
-	return 0;
-err:
-	return -1;
-}
-
-static int run_bind_test_case(const struct sock_addr_test *test)
-{
-	socklen_t addr_len = sizeof(struct sockaddr_storage);
-	struct sockaddr_storage requested_addr;
-	struct sockaddr_storage expected_addr;
-	int clientfd = -1;
-	int servfd = -1;
-	int err = 0;
-
-	if (init_addrs(test, &requested_addr, &expected_addr, NULL))
-		goto err;
-
-	servfd = start_server_addr(test->type, &requested_addr, addr_len, NULL);
-	if (servfd == -1)
-		goto err;
-
-	if (cmp_local_addr(servfd, &expected_addr))
-		goto err;
-
-	/* Try to connect to server just in case */
-	clientfd = connect_to_addr(test->type, &expected_addr, addr_len, NULL);
-	if (clientfd == -1)
-		goto err;
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(clientfd);
-	close(servfd);
-	return err;
-}
-
-static int run_connect_test_case(const struct sock_addr_test *test)
-{
-	socklen_t addr_len = sizeof(struct sockaddr_storage);
-	struct sockaddr_storage expected_src_addr;
-	struct sockaddr_storage requested_addr;
-	struct sockaddr_storage expected_addr;
-	int clientfd = -1;
-	int servfd = -1;
-	int err = 0;
-
-	if (init_addrs(test, &requested_addr, &expected_addr,
-		       &expected_src_addr))
-		goto err;
-
-	/* Prepare server to connect to */
-	servfd = start_server_addr(test->type, &expected_addr, addr_len, NULL);
-	if (servfd == -1)
-		goto err;
-
-	clientfd = connect_to_addr(test->type, &requested_addr, addr_len, NULL);
-	if (clientfd == -1)
-		goto err;
-
-	/* Make sure src and dst addrs were overridden properly */
-	if (cmp_peer_addr(clientfd, &expected_addr))
-		goto err;
-
-	if (cmp_local_ip(clientfd, &expected_src_addr))
-		goto err;
-
-	if (test->type == SOCK_STREAM) {
-		/* Test TCP Fast Open scenario */
-		clientfd = fastconnect_to_server(&requested_addr, addr_len);
-		if (clientfd == -1)
-			goto err;
-
-		/* Make sure src and dst addrs were overridden properly */
-		if (cmp_peer_addr(clientfd, &expected_addr))
-			goto err;
-
-		if (cmp_local_ip(clientfd, &expected_src_addr))
-			goto err;
-	}
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(clientfd);
-	close(servfd);
-	return err;
-}
-
-static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
-{
-	socklen_t addr_len = sizeof(struct sockaddr_storage);
-	struct sockaddr_storage expected_addr;
-	struct sockaddr_storage server_addr;
-	struct sockaddr_storage sendmsg_addr;
-	struct sockaddr_storage recvmsg_addr;
-	int clientfd = -1;
-	int servfd = -1;
-	int set_cmsg;
-	int err = 0;
-
-	if (test->type != SOCK_DGRAM)
-		goto err;
-
-	if (init_addrs(test, &sendmsg_addr, &server_addr, &expected_addr))
-		goto err;
-
-	/* Prepare server to sendmsg to */
-	servfd = start_server_addr(test->type, &server_addr, addr_len, NULL);
-	if (servfd == -1)
-		goto err;
-
-	for (set_cmsg = 0; set_cmsg <= max_cmsg; ++set_cmsg) {
-		if (clientfd >= 0)
-			close(clientfd);
-
-		clientfd = sendmsg_to_server(test->type, &sendmsg_addr,
-					     addr_len, set_cmsg, /*flags*/0,
-					     &err);
-		if (err)
-			goto out;
-		else if (clientfd == -1)
-			goto err;
-
-		/* Try to receive message on server instead of using
-		 * getpeername(2) on client socket, to check that client's
-		 * destination address was rewritten properly, since
-		 * getpeername(2) doesn't work with unconnected datagram
-		 * sockets.
-		 *
-		 * Get source address from recvmsg(2) as well to make sure
-		 * source was rewritten properly: getsockname(2) can't be used
-		 * since socket is unconnected and source defined for one
-		 * specific packet may differ from the one used by default and
-		 * returned by getsockname(2).
-		 */
-		if (recvmsg_from_client(servfd, &recvmsg_addr) == -1)
-			goto err;
-
-		if (cmp_addr(&recvmsg_addr, &expected_addr, /*cmp_port*/0))
-			goto err;
-	}
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(clientfd);
-	close(servfd);
-	return err;
-}
-
-static int run_test_case(int cgfd, const struct sock_addr_test *test)
-{
-	int progfd = -1;
-	int err = 0;
-
-	printf("Test case: %s .. ", test->descr);
-
-	progfd = test->loadfn(test);
-	if (test->expected_result == LOAD_REJECT && progfd < 0)
-		goto out;
-	else if (test->expected_result == LOAD_REJECT || progfd < 0)
-		goto err;
-
-	err = bpf_prog_attach(progfd, cgfd, test->attach_type,
-			      BPF_F_ALLOW_OVERRIDE);
-	if (test->expected_result == ATTACH_REJECT && err) {
-		err = 0; /* error was expected, reset it */
-		goto out;
-	} else if (test->expected_result == ATTACH_REJECT || err) {
-		goto err;
-	} else if (test->expected_result == ATTACH_OKAY) {
-		err = 0;
-		goto out;
-	}
-
-	switch (test->attach_type) {
-	case BPF_CGROUP_INET4_BIND:
-	case BPF_CGROUP_INET6_BIND:
-		err = run_bind_test_case(test);
-		break;
-	case BPF_CGROUP_INET4_CONNECT:
-	case BPF_CGROUP_INET6_CONNECT:
-		err = run_connect_test_case(test);
-		break;
-	case BPF_CGROUP_UDP4_SENDMSG:
-	case BPF_CGROUP_UDP6_SENDMSG:
-		err = run_xmsg_test_case(test, 1);
-		break;
-	case BPF_CGROUP_UDP4_RECVMSG:
-	case BPF_CGROUP_UDP6_RECVMSG:
-		err = run_xmsg_test_case(test, 0);
-		break;
-	default:
-		goto err;
-	}
-
-	if (test->expected_result == SYSCALL_EPERM && err == EPERM) {
-		err = 0; /* error was expected, reset it */
-		goto out;
-	}
-
-	if (test->expected_result == SYSCALL_ENOTSUPP && err == ENOTSUPP) {
-		err = 0; /* error was expected, reset it */
-		goto out;
-	}
-
-	if (err || test->expected_result != SUCCESS)
-		goto err;
-
-	goto out;
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
-	if (argc < 2) {
-		fprintf(stderr,
-			"%s has to be run via %s.sh. Skip direct run.\n",
-			argv[0], argv[0]);
-		exit(err);
-	}
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
diff --git a/tools/testing/selftests/bpf/test_sock_addr.sh b/tools/testing/selftests/bpf/test_sock_addr.sh
deleted file mode 100755
index 3b9fdb8094aa2..0000000000000
--- a/tools/testing/selftests/bpf/test_sock_addr.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/bin/sh
-
-set -eu
-
-ping_once()
-{
-	type ping${1} >/dev/null 2>&1 && PING="ping${1}" || PING="ping -${1}"
-	$PING -q -c 1 -W 1 ${2%%/*} >/dev/null 2>&1
-}
-
-wait_for_ip()
-{
-	local _i
-	echo -n "Wait for testing IPv4/IPv6 to become available "
-	for _i in $(seq ${MAX_PING_TRIES}); do
-		echo -n "."
-		if ping_once 4 ${TEST_IPv4} && ping_once 6 ${TEST_IPv6}; then
-			echo " OK"
-			return
-		fi
-	done
-	echo 1>&2 "ERROR: Timeout waiting for test IP to become available."
-	exit 1
-}
-
-setup()
-{
-	# Create testing interfaces not to interfere with current environment.
-	ip link add dev ${TEST_IF} type veth peer name ${TEST_IF_PEER}
-	ip link set ${TEST_IF} up
-	ip link set ${TEST_IF_PEER} up
-
-	ip -4 addr add ${TEST_IPv4} dev ${TEST_IF}
-	ip -6 addr add ${TEST_IPv6} dev ${TEST_IF}
-	wait_for_ip
-}
-
-cleanup()
-{
-	ip link del ${TEST_IF} 2>/dev/null || :
-	ip link del ${TEST_IF_PEER} 2>/dev/null || :
-}
-
-main()
-{
-	trap cleanup EXIT 2 3 6 15
-	setup
-	./test_sock_addr setup_done
-}
-
-BASENAME=$(basename $0 .sh)
-TEST_IF="${BASENAME}1"
-TEST_IF_PEER="${BASENAME}2"
-TEST_IPv4="127.0.0.4/8"
-TEST_IPv6="::6/128"
-MAX_PING_TRIES=5
-
-main
-- 
2.45.0.118.g7fe29c98d7-goog


