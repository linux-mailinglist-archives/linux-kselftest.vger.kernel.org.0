Return-Path: <linux-kselftest+bounces-28555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFDA5844C
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD081890225
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE91DF246;
	Sun,  9 Mar 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OZQlUvo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0C1DED68
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Mar 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527007; cv=none; b=d+D2SGJu0W5Bk86HGN0poIg9MbqA/J76xwrrAePV3duEHTC1G2Zwruq+OOz4uo/2lv+aCt2ATCA4FJwCxEo7T+hUFP5//HpGX8Jxph61V9pfwcwj9OOwu/dNdfyeLKICpeArFoD7BiI3LAo/MAU544YLm+rOwGjChz7yCvlu4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527007; c=relaxed/simple;
	bh=fnMK/Ta7Z6dW4Bo0ev4kpeSTLsBbk/uNRa2jnNMBxsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0H//bMMW+vLBstt6ys/2GohqhQ6xBGNdHB2bVv92qS8noEfnGjvpelvDiy9fobBzYPqpQYes81NgkqWP6ZLtIV5QAMCSdYb6UOS9sZmbYhTgY+0r/dz5xFp2vXROe3Alte//ilsAo3EBcuq+j2scSH//94HeoTbTuMF6ql724o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OZQlUvo7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01D6140889
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Mar 2025 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526993;
	bh=+WlniEeO1sxFM6/UgRu+OkcVvl4eFAZ3k4+mcLNjIi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=OZQlUvo7W9pEBAnx2cL/G9HXaRrqPbPzicdTYfhWuHBrnEKx/TltzYWXSjrjwVyLO
	 7KUrDxzXACZ0JnXQt9b1HXRYSQrMFJX+3IlSQkgedgRfpAGLNUiWl5CIOo7Rg9C2+8
	 723tMKW4ZFajsorGBrs0+vZ4SjWRFIln9IBp4mabjUB++v7Z8kpypz9Ll0q7qsCEZs
	 hW5m6qhsoNNrie2NvavW5CTtaFpS1y8lZ21gVs3Nqonh52yWHOUp9vDn0Z8N2ZPe3A
	 sDuhy3th1j81AS6/45WL9wk9Uv8f8IxdEFN8KpLnGSlhYzM4pUj5Fl7gy3WP6P2sPH
	 8qzK/U3zkBhWw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab39f65dc10so433926666b.1
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 06:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526986; x=1742131786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WlniEeO1sxFM6/UgRu+OkcVvl4eFAZ3k4+mcLNjIi4=;
        b=gxpFcI18D/vUpSim/a8XCX+oEvatkAz9k10q695l+DA7ePGM3uWngNTYd2VMJGnQyl
         G195YR6JqsxWdxPuFdAPg3P3JgLQKh66MnCU1Fvv4H3b6F6mo2EZwi/iae2zYqvWt5SP
         rNqFVy9mU0iCYf8hORUNlebR1ksHQxa/dOerRAAnbQj3DouabqiC/kLNfZ1reK7kzNon
         Xt+wxOkyP1RoUkNUoj11hYwiE6aW4ck+d4AGFXq/spRVcEfugIHR9wUQFnqIxcegzG8q
         FDhKsr3Kfnwjb8aMND9tBnU2JAcqY+Y8eoBwf8wPWX7pWYa8BsonNLk/agxmxBrKmesJ
         LNrg==
X-Forwarded-Encrypted: i=1; AJvYcCVTMIH0ZoKe+K2w5zWyu7quJANQRf3oijEaq13R6gIIzv+wrkDxDPtpfuNcpI3H9Q6m7WrAtS314Jc0RhbxEQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SDw0NPNcQu35KjIsxULukr0a53JpI8YHw/Fmc5DuJrnI56/u
	NwwD10wuns3HVKc9Wgfw6qRldUfkIb1Hc24cUOgRatBq6LuYMf6WUuUVP3Jn+sLZVAFdYckPbJ7
	QPQdfoi2g3vtH/J369iusqAJGeBHAoSX5uv56LCAFplfUOTonHWUjunG/uAOTK22UWOnY6I7Fuy
	qf3Qcq5w==
X-Gm-Gg: ASbGncvZlpH/UtGXSPiui42Vf4XGlFqvvl7JXCtFrkUG8lbc0Sf8iGk68uB77Wwt4gs
	0/fZMOney0aDt86LNVMSQgj2xWyZd/Eo0KxpPieHbDCoPaX9KI/3Sk8Cy0xDiq+15L5ygHwTQZ5
	r8j3YSLHqcLHbRNjw4Dp5SGEPWx+puN5k5BoadFfPRIpk8CIRliz/G9alprJM60H8e4HqlucdCG
	OIgKQfonQxgw0ZCNsw0U5UwLXJQ+qM4mAnWHyWiRyoBte8PrczlknNzDRK2SUcWgwcb0BmMfNw1
	1jR6IR2W8ZZQcbryCbe/M48j/WRJ47ErANNY67BeimAmGPACJQ2QFUEHr3DMWxBypgfdRWuUiS7
	DDEkiAfglPdF3z/Irmw==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr1204985266b.5.1741526985910;
        Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFa95jUlBdWGTjYgXwcr9ZUQLkTVCYf0hxOKWN8Duf76vORogdoI0XKHA/oyP746iZKMUFGA==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr1204982566b.5.1741526985467;
        Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:45 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 4/4] tools/testing/selftests/cgroup: add test for SO_PEERCGROUPID
Date: Sun,  9 Mar 2025 14:28:15 +0100
Message-ID: <20250309132821.103046-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_so_peercgroupid.c   | 308 ++++++++++++++++++
 2 files changed, 310 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_so_peercgroupid.c

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 1b897152bab6..a932ff068081 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
 TEST_GEN_PROGS += test_pids
+TEST_GEN_PROGS += test_so_peercgroupid
 TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
@@ -31,4 +32,5 @@ $(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_kmem: cgroup_util.c
 $(OUTPUT)/test_memcontrol: cgroup_util.c
 $(OUTPUT)/test_pids: cgroup_util.c
+$(OUTPUT)/test_so_peercgroupid: cgroup_util.c
 $(OUTPUT)/test_zswap: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_so_peercgroupid.c b/tools/testing/selftests/cgroup/test_so_peercgroupid.c
new file mode 100644
index 000000000000..2bf1f00a45c7
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_so_peercgroupid.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+#define _GNU_SOURCE
+#include <error.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <linux/socket.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/un.h>
+#include <sys/signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "../kselftest_harness.h"
+#include "cgroup_util.h"
+
+#define clean_errno() (errno == 0 ? "None" : strerror(errno))
+#define log_err(MSG, ...)                                                   \
+	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", __FILE__, __LINE__, \
+		clean_errno(), ##__VA_ARGS__)
+
+#ifndef SO_PEERCGROUPID
+#define SO_PEERCGROUPID 83
+#endif
+
+static void child_die()
+{
+	exit(1);
+}
+
+struct sock_addr {
+	char sock_name[32];
+	struct sockaddr_un listen_addr;
+	socklen_t addrlen;
+};
+
+FIXTURE(so_peercgroupid)
+{
+	int server;
+	pid_t client_pid;
+	int sync_sk[2];
+	struct sock_addr server_addr;
+	struct sock_addr *client_addr;
+	char cgroup_root[PATH_MAX];
+	char *test_cgroup1;
+	char *test_cgroup2;
+};
+
+FIXTURE_VARIANT(so_peercgroupid)
+{
+	int type;
+	bool abstract;
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, stream_pathname)
+{
+	.type = SOCK_STREAM,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, stream_abstract)
+{
+	.type = SOCK_STREAM,
+	.abstract = 1,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, seqpacket_pathname)
+{
+	.type = SOCK_SEQPACKET,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, seqpacket_abstract)
+{
+	.type = SOCK_SEQPACKET,
+	.abstract = 1,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, dgram_pathname)
+{
+	.type = SOCK_DGRAM,
+	.abstract = 0,
+};
+
+FIXTURE_VARIANT_ADD(so_peercgroupid, dgram_abstract)
+{
+	.type = SOCK_DGRAM,
+	.abstract = 1,
+};
+
+FIXTURE_SETUP(so_peercgroupid)
+{
+	self->client_addr = mmap(NULL, sizeof(*self->client_addr), PROT_READ | PROT_WRITE,
+				 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(MAP_FAILED, self->client_addr);
+
+	self->cgroup_root[0] = '\0';
+}
+
+FIXTURE_TEARDOWN(so_peercgroupid)
+{
+	close(self->server);
+
+	kill(self->client_pid, SIGKILL);
+	waitpid(self->client_pid, NULL, 0);
+
+	if (!variant->abstract) {
+		unlink(self->server_addr.sock_name);
+		unlink(self->client_addr->sock_name);
+	}
+
+	if (strlen(self->cgroup_root) > 0) {
+		cg_enter_current(self->cgroup_root);
+
+		if (self->test_cgroup1)
+			cg_destroy(self->test_cgroup1);
+		free(self->test_cgroup1);
+
+		if (self->test_cgroup2)
+			cg_destroy(self->test_cgroup2);
+		free(self->test_cgroup2);
+	}
+}
+
+static void fill_sockaddr(struct sock_addr *addr, bool abstract)
+{
+	char *sun_path_buf = (char *)&addr->listen_addr.sun_path;
+
+	addr->listen_addr.sun_family = AF_UNIX;
+	addr->addrlen = offsetof(struct sockaddr_un, sun_path);
+	snprintf(addr->sock_name, sizeof(addr->sock_name), "so_peercgroupid_%d", getpid());
+	addr->addrlen += strlen(addr->sock_name);
+	if (abstract) {
+		*sun_path_buf = '\0';
+		addr->addrlen++;
+		sun_path_buf++;
+	} else {
+		unlink(addr->sock_name);
+	}
+	memcpy(sun_path_buf, addr->sock_name, strlen(addr->sock_name));
+}
+
+static void client(FIXTURE_DATA(so_peercgroupid) *self,
+		   const FIXTURE_VARIANT(so_peercgroupid) *variant)
+{
+	int cfd, err;
+	socklen_t len;
+	uint64_t peer_cgroup_id = 0, test_cgroup1_id = 0, test_cgroup2_id = 0;
+	char state;
+
+	cfd = socket(AF_UNIX, variant->type, 0);
+	if (cfd < 0) {
+		log_err("socket");
+		child_die();
+	}
+
+	if (variant->type == SOCK_DGRAM) {
+		fill_sockaddr(self->client_addr, variant->abstract);
+
+		if (bind(cfd, (struct sockaddr *)&self->client_addr->listen_addr, self->client_addr->addrlen)) {
+			log_err("bind");
+			child_die();
+		}
+	}
+
+	/* negative testcase: no peer for socket yet */
+	len = sizeof(peer_cgroup_id);
+	err = getsockopt(cfd, SOL_SOCKET, SO_PEERCGROUPID, &peer_cgroup_id, &len);
+	if (!err || (errno != ENODATA)) {
+		log_err("getsockopt must fail with errno == ENODATA when socket has no peer");
+		child_die();
+	}
+
+	if (connect(cfd, (struct sockaddr *)&self->server_addr.listen_addr,
+		    self->server_addr.addrlen) != 0) {
+		log_err("connect");
+		child_die();
+	}
+
+	state = 'R';
+	write(self->sync_sk[1], &state, sizeof(state));
+
+	read(self->sync_sk[1], &test_cgroup1_id, sizeof(uint64_t));
+	read(self->sync_sk[1], &test_cgroup2_id, sizeof(uint64_t));
+
+	len = sizeof(peer_cgroup_id);
+	if (getsockopt(cfd, SOL_SOCKET, SO_PEERCGROUPID, &peer_cgroup_id, &len)) {
+		log_err("Failed to get SO_PEERCGROUPID");
+		child_die();
+	}
+
+	/*
+	 * There is a difference between connection-oriented sockets
+	 * and connectionless ones from the perspective of SO_PEERCGROUPID.
+	 *
+	 * sk->sk_cgrp_data is getting filled when we allocate struct sock (see call to cgroup_sk_alloc()).
+	 * For DGRAM socket, self->server socket is our peer and by the time when we allocate it,
+	 * parent process sits in a test_cgroup1. Then it changes cgroup to test_cgroup2, but it does not
+	 * affect anything.
+	 * For STREAM/SEQPACKET socket, self->server is not our peer, but that one we get from accept()
+	 * syscall. And by the time when we call accept(), parent process sits in test_cgroup2.
+	 *
+	 * Let's ensure that it works like that and if it get changed then we should detect it
+	 * as it's a clear UAPI change.
+	 */
+	if (variant->type == SOCK_DGRAM) {
+		/* cgroup id from SO_PEERCGROUPID should be equal to the test_cgroup1_id */
+		if (peer_cgroup_id != test_cgroup1_id) {
+			log_err("peer_cgroup_id != test_cgroup1_id: %" PRId64 " != %" PRId64, peer_cgroup_id, test_cgroup1_id);
+			child_die();
+		}
+	} else {
+		/* cgroup id from SO_PEERCGROUPID should be equal to the test_cgroup2_id */
+		if (peer_cgroup_id != test_cgroup2_id) {
+			log_err("peer_cgroup_id != test_cgroup2_id: %" PRId64 " != %" PRId64, peer_cgroup_id, test_cgroup2_id);
+			child_die();
+		}
+	}
+}
+
+TEST_F(so_peercgroupid, test)
+{
+	uint64_t test_cgroup1_id, test_cgroup2_id;
+	int err;
+	int pfd;
+	char state;
+	int child_status = 0;
+
+	if (cg_find_unified_root(self->cgroup_root, sizeof(self->cgroup_root), NULL))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	self->test_cgroup1 = cg_name(self->cgroup_root, "so_peercgroupid_cg1");
+	ASSERT_NE(NULL, self->test_cgroup1);
+
+	self->test_cgroup2 = cg_name(self->cgroup_root, "so_peercgroupid_cg2");
+	ASSERT_NE(NULL, self->test_cgroup2);
+
+	err = cg_create(self->test_cgroup1);
+	ASSERT_EQ(0, err);
+
+	err = cg_create(self->test_cgroup2);
+	ASSERT_EQ(0, err);
+
+	test_cgroup1_id = cg_get_id(self->test_cgroup1);
+	ASSERT_LT(0, test_cgroup1_id);
+
+	test_cgroup2_id = cg_get_id(self->test_cgroup2);
+	ASSERT_LT(0, test_cgroup2_id);
+
+	/* enter test_cgroup1 before allocating a socket */
+	err = cg_enter_current(self->test_cgroup1);
+	ASSERT_EQ(0, err);
+
+	self->server = socket(AF_UNIX, variant->type, 0);
+	ASSERT_NE(-1, self->server);
+
+	/* enter test_cgroup2 after allocating a socket */
+	err = cg_enter_current(self->test_cgroup2);
+	ASSERT_EQ(0, err);
+
+	fill_sockaddr(&self->server_addr, variant->abstract);
+
+	err = bind(self->server, (struct sockaddr *)&self->server_addr.listen_addr, self->server_addr.addrlen);
+	ASSERT_EQ(0, err);
+
+	if (variant->type != SOCK_DGRAM) {
+		err = listen(self->server, 1);
+		ASSERT_EQ(0, err);
+	}
+
+	err = socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, self->sync_sk);
+	EXPECT_EQ(err, 0);
+
+	self->client_pid = fork();
+	ASSERT_NE(-1, self->client_pid);
+	if (self->client_pid == 0) {
+		close(self->server);
+		close(self->sync_sk[0]);
+		client(self, variant);
+		exit(0);
+	}
+	close(self->sync_sk[1]);
+
+	if (variant->type != SOCK_DGRAM) {
+		pfd = accept(self->server, NULL, NULL);
+		ASSERT_NE(-1, pfd);
+	} else {
+		pfd = self->server;
+	}
+
+	/* wait until the child arrives at checkpoint */
+	read(self->sync_sk[0], &state, sizeof(state));
+	ASSERT_EQ(state, 'R');
+
+	write(self->sync_sk[0], &test_cgroup1_id, sizeof(uint64_t));
+	write(self->sync_sk[0], &test_cgroup2_id, sizeof(uint64_t));
+
+	close(pfd);
+	waitpid(self->client_pid, &child_status, 0);
+	ASSERT_EQ(0, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


