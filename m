Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3820673C5FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 03:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFXBqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 21:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFXBqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 21:46:13 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3526B0;
        Fri, 23 Jun 2023 18:46:11 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5704ddda6dfso11999597b3.1;
        Fri, 23 Jun 2023 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687571170; x=1690163170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI3ViRHo3Yv4jEPI09SSBt1l2dF3ocaSTpieNBPph3s=;
        b=rDXvdtKHu7H9c+wyYhOUro9qcwHRJ0DXkVoOOZi/Ky4RYti8SLtDyl+Xuws7BPhT2s
         1NVQW2sY1fGsDS3p8xnB83bhvG0slEhSTCvTJNQPDZ1e5G01se1M25sdkTIsrsg2cU/I
         Fwpu5vFycKg49ucXV9+WBgWxKlouDVqyvygvO0JIb/7zI8XEHhe6tOMYeXfXWwjZXEUv
         PDQJCJSHNBVuYrThNMp4Opmf/jkwjdPRu5NhX1jdof11bCDtGu00nHKppB7WdOlmji4Q
         FMxWzJsp/9Hpc6nl31Plp27o902kLrWmr9UGOee4OhGofTy7XrD8lqZTSOBel4idGc7q
         JozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571170; x=1690163170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI3ViRHo3Yv4jEPI09SSBt1l2dF3ocaSTpieNBPph3s=;
        b=BaMWgUEOQDi9C3sMfhTnS6aL6LRXBINiQGMSv6HJuN4aeBIsNGOM2953GHlIK/jaSZ
         9x/Sl2tKbmcOIqYdSFRie1yT454BcoCbGc2TipXjvcrwpR1ygp/wVjn6I9Uw4FQYn39J
         rlGBCNrobcc1VlDPZGTTQOFjtuLJHG+ck9Nm5MPVKlnkxvZKvw2bmS95kEjyQTaAK0EG
         F4DuFmjsF8VJ+KW7dazM1UC3grkjnDmxPObUK5/eVlc7rCRITVHtgFBdFEdug3kGjxpZ
         zKmEx2qZj0oPuOj6uMhAG4ZLr5Q5hdW2vj3CcEqZejQXekOQrBB90gr7KhU5pB7od0fS
         L/rw==
X-Gm-Message-State: AC+VfDz4Pkt0Z0wzZRoWYDLo0fRU+rZjKEFH/K78k6itJMgAAA6ZRh1V
        JqbnbhB4IOb20Wd3n8Ww19/kjZpVfkqlPQ==
X-Google-Smtp-Source: ACHHUZ7/3z3ez2xDES1iPf8kIkdW4HrYrtj2gOkpbLpa9U2WTM3+SSB7rAxqGWYEEpgKAA6oQq5KmQ==
X-Received: by 2002:a81:8605:0:b0:56d:24c:8896 with SMTP id w5-20020a818605000000b0056d024c8896mr26088008ywf.7.1687571169484;
        Fri, 23 Jun 2023 18:46:09 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d5fe:ab6b:8508:3503])
        by smtp.gmail.com with ESMTPSA id b126-20020a816784000000b005731f3c8989sm107916ywc.62.2023.06.23.18.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 18:46:09 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com, netdev@vger.kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Verify that the cgroup_skb filters receive expected packets.
Date:   Fri, 23 Jun 2023 18:46:00 -0700
Message-Id: <20230624014600.576756-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230624014600.576756-1-kuifeng@meta.com>
References: <20230624014600.576756-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test case includes four scenarios:
1. Connect to the server from outside the cgroup and close the connection
   from outside the cgroup.
2. Connect to the server from outside the cgroup and close the connection
   from inside the cgroup.
3. Connect to the server from inside the cgroup and close the connection
   from outside the cgroup.
4. Connect to the server from inside the cgroup and close the connection
   from inside the cgroup.

The test case is to verify that cgroup_skb/{egress, ingress} filters
receive expected packets including SYN, SYN/ACK, ACK, FIN, and FIN/ACK.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 402 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 382 +++++++++++++++++
 5 files changed, 832 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 9e95b37a7dff..2caee8423ee0 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -277,6 +277,18 @@ int join_cgroup(const char *relative_path)
 	return join_cgroup_from_top(cgroup_path);
 }
 
+/**
+ * join_root_cgroup() - Join the root cgroup
+ *
+ * This function joins the root cgroup.
+ *
+ * On success, it returns 0, otherwise on failure it returns 1.
+ */
+int join_root_cgroup(void)
+{
+	return join_cgroup_from_top(CGROUP_MOUNT_PATH);
+}
+
 /**
  * join_parent_cgroup() - Join a cgroup in the parent process workdir
  * @relative_path: The cgroup path, relative to parent process workdir, to join
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index f099a166c94d..5c2cb9c8b546 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -22,6 +22,7 @@ void remove_cgroup(const char *relative_path);
 unsigned long long get_cgroup_id(const char *relative_path);
 
 int join_cgroup(const char *relative_path);
+int join_root_cgroup(void);
 int join_parent_cgroup(const char *relative_path);
 
 int setup_cgroup_environment(void);
diff --git a/tools/testing/selftests/bpf/cgroup_tcp_skb.h b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
new file mode 100644
index 000000000000..7f6b24f102fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+/* Define states of a socket to tracking messages sending to and from the
+ * socket.
+ *
+ * These states are based on rfc9293 with some modifications to support
+ * tracking of messages sent out from a socket. For example, when a SYN is
+ * received, a new socket is transiting to the SYN_RECV state defined in
+ * rfc9293. But, we put it in SYN_RECV_SENDING_SYN_ACK state and when
+ * SYN-ACK is sent out, it moves to SYN_RECV state. With this modification,
+ * we can track the message sent out from a socket.
+ */
+
+#ifndef __CGROUP_TCP_SKB_H__
+#define __CGROUP_TCP_SKB_H__
+
+enum {
+	INIT,
+	CLOSED,
+	SYN_SENT,
+	SYN_RECV_SENDING_SYN_ACK,
+	SYN_RECV,
+	ESTABLISHED,
+	FIN_WAIT1,
+	FIN_WAIT2,
+	CLOSE_WAIT_SENDING_ACK,
+	CLOSE_WAIT,
+	CLOSING,
+	LAST_ACK,
+	TIME_WAIT_SENDING_ACK,
+	TIME_WAIT,
+};
+
+#endif /* __CGROUP_TCP_SKB_H__ */
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
new file mode 100644
index 000000000000..95bab61a1e57
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Facebook */
+#include <test_progs.h>
+#include <linux/in6.h>
+#include <sys/socket.h>
+#include <sched.h>
+#include <unistd.h>
+#include "cgroup_helpers.h"
+#include "testing_helpers.h"
+#include "cgroup_tcp_skb.skel.h"
+#include "cgroup_tcp_skb.h"
+
+#define CGROUP_TCP_SKB_PATH "/test_cgroup_tcp_skb"
+
+static int install_filters(int cgroup_fd,
+			   struct bpf_link **egress_link,
+			   struct bpf_link **ingress_link,
+			   struct bpf_program *egress_prog,
+			   struct bpf_program *ingress_prog,
+			   struct cgroup_tcp_skb *skel)
+{
+	/* Prepare filters */
+	skel->bss->g_sock_state = 0;
+	skel->bss->g_unexpected = 0;
+	*egress_link =
+		bpf_program__attach_cgroup(egress_prog,
+					   cgroup_fd);
+	if (!ASSERT_OK_PTR(egress_link, "egress_link"))
+		return -1;
+	*ingress_link =
+		bpf_program__attach_cgroup(ingress_prog,
+					   cgroup_fd);
+	if (!ASSERT_OK_PTR(ingress_link, "ingress_link"))
+		return -1;
+
+	return 0;
+}
+
+static void uninstall_filters(struct bpf_link **egress_link,
+			      struct bpf_link **ingress_link)
+{
+	bpf_link__destroy(*egress_link);
+	*egress_link = NULL;
+	bpf_link__destroy(*ingress_link);
+	*ingress_link = NULL;
+}
+
+static int create_client_sock_v6(void)
+{
+	int fd;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return -1;
+	}
+
+	return fd;
+}
+
+static int create_server_sock_v6(void)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family = AF_INET6,
+		.sin6_port = htons(0),
+		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
+	};
+	int fd, err;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		return -1;
+	}
+
+	err = bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		perror("bind");
+		return -1;
+	}
+
+	err = listen(fd, 1);
+	if (err < 0) {
+		perror("listen");
+		return -1;
+	}
+
+	return fd;
+}
+
+static int get_sock_port_v6(int fd)
+{
+	struct sockaddr_in6 addr;
+	socklen_t len;
+	int err;
+
+	len = sizeof(addr);
+	err = getsockname(fd, (struct sockaddr *)&addr, &len);
+	if (err < 0) {
+		perror("getsockname");
+		return -1;
+	}
+
+	return ntohs(addr.sin6_port);
+}
+
+static int connect_client_server_v6(int client_fd, int listen_fd)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
+	};
+	int err;
+
+	addr.sin6_port = htons(get_sock_port_v6(listen_fd));
+	if (addr.sin6_port < 0)
+		return -1;
+
+	err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (err < 0) {
+		perror("connect");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Connect to the server in a cgroup from the outside of the cgroup. */
+static int talk_to_cgroup(int *client_fd, int *listen_fd, int *service_fd,
+			  struct cgroup_tcp_skb *skel)
+{
+	int err, cp;
+	char buf[5];
+
+	/* Create client & server socket */
+	err = join_root_cgroup();
+	if (!ASSERT_OK(err, "join_root_cgroup"))
+		return -1;
+	*client_fd = create_client_sock_v6();
+	if (!ASSERT_GE(*client_fd, 0, "client_fd"))
+		return -1;
+	err = join_cgroup(CGROUP_TCP_SKB_PATH);
+	if (!ASSERT_OK(err, "join_cgroup"))
+		return -1;
+	*listen_fd = create_server_sock_v6();
+	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
+		return -1;
+	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
+
+	/* Connect client to server */
+	err = connect_client_server_v6(*client_fd, *listen_fd);
+	if (!ASSERT_OK(err, "connect_client_server_v6"))
+		return -1;
+	*service_fd = accept(*listen_fd, NULL, NULL);
+	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
+		return -1;
+	err = join_root_cgroup();
+	if (!ASSERT_OK(err, "join_root_cgroup"))
+		return -1;
+	cp = write(*client_fd, "hello", 5);
+	if (!ASSERT_EQ(cp, 5, "write"))
+		return -1;
+	cp = read(*service_fd, buf, 5);
+	if (!ASSERT_EQ(cp, 5, "read"))
+		return -1;
+
+	return 0;
+}
+
+/* Connect to the server out of a cgroup from inside the cgroup. */
+static int talk_to_outside(int *client_fd, int *listen_fd, int *service_fd,
+			   struct cgroup_tcp_skb *skel)
+
+{
+	int err, cp;
+	char buf[5];
+
+	/* Create client & server socket */
+	err = join_root_cgroup();
+	if (!ASSERT_OK(err, "join_root_cgroup"))
+		return -1;
+	*listen_fd = create_server_sock_v6();
+	if (!ASSERT_GE(*listen_fd, 0, "listen_fd"))
+		return -1;
+	err = join_cgroup(CGROUP_TCP_SKB_PATH);
+	if (!ASSERT_OK(err, "join_cgroup"))
+		return -1;
+	*client_fd = create_client_sock_v6();
+	if (!ASSERT_GE(*client_fd, 0, "client_fd"))
+		return -1;
+	err = join_root_cgroup();
+	if (!ASSERT_OK(err, "join_root_cgroup"))
+		return -1;
+	skel->bss->g_sock_port = get_sock_port_v6(*listen_fd);
+
+	/* Connect client to server */
+	err = connect_client_server_v6(*client_fd, *listen_fd);
+	if (!ASSERT_OK(err, "connect_client_server_v6"))
+		return -1;
+	*service_fd = accept(*listen_fd, NULL, NULL);
+	if (!ASSERT_GE(*service_fd, 0, "service_fd"))
+		return -1;
+	cp = write(*client_fd, "hello", 5);
+	if (!ASSERT_EQ(cp, 5, "write"))
+		return -1;
+	cp = read(*service_fd, buf, 5);
+	if (!ASSERT_EQ(cp, 5, "read"))
+		return -1;
+
+	return 0;
+}
+
+static int close_connection(int *closing_fd, int *peer_fd, int *listen_fd,
+			    struct cgroup_tcp_skb *skel)
+{
+	__u32 saved_packet_count = 0;
+	int err;
+	int i;
+
+	/* Wait for ACKs to be sent */
+	saved_packet_count = skel->bss->g_packet_count;
+	usleep(100000);		/* 0.1s */
+	for (i = 0;
+	     skel->bss->g_packet_count != saved_packet_count && i < 10;
+	     i++) {
+		saved_packet_count = skel->bss->g_packet_count;
+		usleep(100000);	/* 0.1s */
+	}
+	if (!ASSERT_EQ(skel->bss->g_packet_count, saved_packet_count,
+		       "packet_count"))
+		return -1;
+
+	skel->bss->g_packet_count = 0;
+	saved_packet_count = 0;
+
+	/* Half shutdown to make sure the closing socket having a chance to
+	 * receive a FIN from the peer.
+	 */
+	err = shutdown(*closing_fd, SHUT_WR);
+	if (!ASSERT_OK(err, "shutdown closing_fd"))
+		return -1;
+
+	/* Wait for FIN and the ACK of the FIN to be observed */
+	for (i = 0;
+	     skel->bss->g_packet_count < saved_packet_count + 2 && i < 10;
+	     i++)
+		usleep(100000);	/* 0.1s */
+	if (!ASSERT_GE(skel->bss->g_packet_count, saved_packet_count + 2,
+		       "packet_count"))
+		return -1;
+
+	saved_packet_count = skel->bss->g_packet_count;
+
+	/* Fully shutdown the connection */
+	err = close(*peer_fd);
+	if (!ASSERT_OK(err, "close peer_fd"))
+		return -1;
+	*peer_fd = -1;
+
+	/* Wait for FIN and the ACK of the FIN to be observed */
+	for (i = 0;
+	     skel->bss->g_packet_count < saved_packet_count + 2 && i < 10;
+	     i++)
+		usleep(100000);	/* 0.1s */
+	if (!ASSERT_GE(skel->bss->g_packet_count, saved_packet_count + 2,
+		       "packet_count"))
+		return -1;
+
+	err = close(*closing_fd);
+	if (!ASSERT_OK(err, "close closing_fd"))
+		return -1;
+	*closing_fd = -1;
+
+	close(*listen_fd);
+	*listen_fd = -1;
+
+	return 0;
+}
+
+/* This test case includes four scenarios:
+ * 1. Connect to the server from outside the cgroup and close the connection
+ *    from outside the cgroup.
+ * 2. Connect to the server from outside the cgroup and close the connection
+ *    from inside the cgroup.
+ * 3. Connect to the server from inside the cgroup and close the connection
+ *    from outside the cgroup.
+ * 4. Connect to the server from inside the cgroup and close the connection
+ *    from inside the cgroup.
+ *
+ * The test case is to verify that cgroup_skb/{egress,ingress} filters
+ * receive expected packets including SYN, SYN/ACK, ACK, FIN, and FIN/ACK.
+ */
+void test_cgroup_tcp_skb(void)
+{
+	struct bpf_link *ingress_link = NULL;
+	struct bpf_link *egress_link = NULL;
+	int client_fd = -1, listen_fd = -1;
+	struct cgroup_tcp_skb *skel;
+	int service_fd = -1;
+	int cgroup_fd = -1;
+	int err;
+
+	skel = cgroup_tcp_skb__open_and_load();
+	if (!ASSERT_OK(!skel, "skel_open_load"))
+		return;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto cleanup;
+
+	cgroup_fd = create_and_get_cgroup(CGROUP_TCP_SKB_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
+		goto cleanup;
+
+	/* Scenario 1 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.server_egress,
+			      skel->progs.server_ingress,
+			      skel);
+	if (!ASSERT_OK(err, "install_filters"))
+		goto cleanup;
+
+	err = talk_to_cgroup(&client_fd, &listen_fd, &service_fd, skel);
+	if (!ASSERT_OK(err, "talk_to_cgroup"))
+		goto cleanup;
+
+	err = close_connection(&client_fd, &service_fd, &listen_fd, skel);
+	if (!ASSERT_OK(err, "close_connection"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, CLOSED, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+	/* Scenario 2 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.server_egress_srv,
+			      skel->progs.server_ingress_srv,
+			      skel);
+
+	err = talk_to_cgroup(&client_fd, &listen_fd, &service_fd, skel);
+	if (!ASSERT_OK(err, "talk_to_cgroup"))
+		goto cleanup;
+
+	err = close_connection(&service_fd, &client_fd, &listen_fd, skel);
+	if (!ASSERT_OK(err, "close_connection"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, TIME_WAIT, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+	/* Scenario 3 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.client_egress_srv,
+			      skel->progs.client_ingress_srv,
+			      skel);
+
+	err = talk_to_outside(&client_fd, &listen_fd, &service_fd, skel);
+	if (!ASSERT_OK(err, "talk_to_outside"))
+		goto cleanup;
+
+	err = close_connection(&service_fd, &client_fd, &listen_fd, skel);
+	if (!ASSERT_OK(err, "close_connection"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, CLOSED, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+	/* Scenario 4 */
+	err = install_filters(cgroup_fd, &egress_link, &ingress_link,
+			      skel->progs.client_egress,
+			      skel->progs.client_ingress,
+			      skel);
+
+	err = talk_to_outside(&client_fd, &listen_fd, &service_fd, skel);
+	if (!ASSERT_OK(err, "talk_to_outside"))
+		goto cleanup;
+
+	err = close_connection(&client_fd, &service_fd, &listen_fd, skel);
+	if (!ASSERT_OK(err, "close_connection"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->g_unexpected, 0, "g_unexpected");
+	ASSERT_EQ(skel->bss->g_sock_state, TIME_WAIT, "g_sock_state");
+
+	uninstall_filters(&egress_link, &ingress_link);
+
+cleanup:
+	close(client_fd);
+	close(listen_fd);
+	close(service_fd);
+	close(cgroup_fd);
+	bpf_link__destroy(egress_link);
+	bpf_link__destroy(ingress_link);
+	cleanup_cgroup_environment();
+	cgroup_tcp_skb__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c b/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
new file mode 100644
index 000000000000..1e2e73f3b749
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include "cgroup_tcp_skb.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u16 g_sock_port = 0;
+__u32 g_sock_state = 0;
+int g_unexpected = 0;
+__u32 g_packet_count = 0;
+
+int needed_tcp_pkt(struct __sk_buff *skb, struct tcphdr *tcph)
+{
+	struct ipv6hdr ip6h;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return 0;
+	if (bpf_skb_load_bytes(skb, 0, &ip6h, sizeof(ip6h)))
+		return 0;
+
+	if (ip6h.nexthdr != IPPROTO_TCP)
+		return 0;
+
+	if (bpf_skb_load_bytes(skb, sizeof(ip6h), tcph, sizeof(*tcph)))
+		return 0;
+
+	if (tcph->source != bpf_htons(g_sock_port) &&
+	    tcph->dest != bpf_htons(g_sock_port))
+		return 0;
+
+	return 1;
+}
+
+/* Run accept() on a socket in the cgroup to receive a new connection. */
+static int egress_accept(struct tcphdr *tcph)
+{
+	if (g_sock_state ==  SYN_RECV_SENDING_SYN_ACK) {
+		if (tcph->fin || !tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = SYN_RECV;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int ingress_accept(struct tcphdr *tcph)
+{
+	switch (g_sock_state) {
+	case INIT:
+		if (!tcph->syn || tcph->fin || tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = SYN_RECV_SENDING_SYN_ACK;
+		break;
+	case SYN_RECV:
+		if (tcph->fin || tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = ESTABLISHED;
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+/* Run connect() on a socket in the cgroup to start a new connection. */
+static int egress_connect(struct tcphdr *tcph)
+{
+	if (g_sock_state == INIT) {
+		if (!tcph->syn || tcph->fin || tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = SYN_SENT;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int ingress_connect(struct tcphdr *tcph)
+{
+	if (g_sock_state == SYN_SENT) {
+		if (tcph->fin || !tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = ESTABLISHED;
+		return 1;
+	}
+
+	return 0;
+}
+
+/* The connection is closed by the peer outside the cgroup. */
+static int egress_close_remote(struct tcphdr *tcph)
+{
+	switch (g_sock_state) {
+	case ESTABLISHED:
+		break;
+	case CLOSE_WAIT_SENDING_ACK:
+		if (tcph->fin || tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = CLOSE_WAIT;
+		break;
+	case CLOSE_WAIT:
+		if (!tcph->fin)
+			g_unexpected++;
+		else
+			g_sock_state = LAST_ACK;
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+static int ingress_close_remote(struct tcphdr *tcph)
+{
+	switch (g_sock_state) {
+	case ESTABLISHED:
+		if (tcph->fin)
+			g_sock_state = CLOSE_WAIT_SENDING_ACK;
+		break;
+	case LAST_ACK:
+		if (tcph->fin || tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = CLOSED;
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+/* The connection is closed by the endpoint inside the cgroup. */
+static int egress_close_local(struct tcphdr *tcph)
+{
+	switch (g_sock_state) {
+	case ESTABLISHED:
+		if (tcph->fin)
+			g_sock_state = FIN_WAIT1;
+		break;
+	case TIME_WAIT_SENDING_ACK:
+		if (tcph->fin || tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = TIME_WAIT;
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+static int ingress_close_local(struct tcphdr *tcph)
+{
+	switch (g_sock_state) {
+	case ESTABLISHED:
+		break;
+	case FIN_WAIT1:
+		if (tcph->fin || tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = FIN_WAIT2;
+		break;
+	case FIN_WAIT2:
+		if (!tcph->fin || tcph->syn || !tcph->ack)
+			g_unexpected++;
+		else
+			g_sock_state = TIME_WAIT_SENDING_ACK;
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
+/* Check the types of outgoing packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/egress")
+int server_egress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Egress of the server socket. */
+	if (egress_accept(&tcph) || egress_close_remote(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of incoming packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/ingress")
+int server_ingress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Ingress of the server socket. */
+	if (ingress_accept(&tcph) || ingress_close_remote(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of outgoing packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/egress")
+int server_egress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Egress of the server socket. */
+	if (egress_accept(&tcph) || egress_close_local(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of incoming packets of a server socket to make sure they
+ * are consistent with the state of the server socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/ingress")
+int server_ingress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Ingress of the server socket. */
+	if (ingress_accept(&tcph) || ingress_close_local(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of outgoing packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/egress")
+int client_egress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Egress of the server socket. */
+	if (egress_connect(&tcph) || egress_close_remote(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of incoming packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the server side.
+ */
+SEC("cgroup_skb/ingress")
+int client_ingress_srv(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Ingress of the server socket. */
+	if (ingress_connect(&tcph) || ingress_close_remote(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of outgoing packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/egress")
+int client_egress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Egress of the server socket. */
+	if (egress_connect(&tcph) || egress_close_local(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
+
+/* Check the types of incoming packets of a client socket to make sure they
+ * are consistent with the state of the client socket.
+ *
+ * The connection is closed by the client side.
+ */
+SEC("cgroup_skb/ingress")
+int client_ingress(struct __sk_buff *skb)
+{
+	struct tcphdr tcph;
+
+	if (!needed_tcp_pkt(skb, &tcph))
+		return 1;
+
+	g_packet_count++;
+
+	/* Ingress of the server socket. */
+	if (ingress_connect(&tcph) || ingress_close_local(&tcph))
+		return 1;
+
+	g_unexpected++;
+	return 1;
+}
-- 
2.34.1

