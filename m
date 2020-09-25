Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F893278482
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgIYJ44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgIYJ4x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BA1C0613D4
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 02:56:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d4so2388836wmd.5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJMfBMIfNn8XZigiEDZpj+D3zsPglzZ72uaJl2xavho=;
        b=UB5xr1xnloptpPJLKn8GZbI19FWf1Y1/SAzT8Q0sXsLm19SCEFxik9P4XbqpKhrqFv
         2cwd8urQSRpI7V1b1yBS1Wz4tduDijkFiJIv9QX5QG2pOvcUw5irHcpbtanXbapPE6RO
         cRJ+CMUId6UFYb+C2cjMz1gUZ7q4vHoxW5GhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJMfBMIfNn8XZigiEDZpj+D3zsPglzZ72uaJl2xavho=;
        b=Xia46NYHsm8wClOn6TAECrBJCF3+O2wqiUuGEz784wiKF+SxogcpnDZ83jxGsn3ock
         HyR1OdXvvupSMtyda0rVTmjgDKARmhPbo4mit9f4bDiIAwJsw48UaVk2GHdNjeoH0UM2
         siKqHxjgrqo/vz8hqTfxDtbDvhDUl+lA42uiudlUTWjLxyZdhpgNkWu/W2G51Fq//2fn
         joCb7tFMW2PQFtE+L/plF8g8Ujx1hbBLU9F2ur1fSXlySG6XOC5XTi9p70gT4gsGRwBS
         JLkAnC5Rf2RW3hFi25g4K3PLrv5LWa++8fFMh3M/yOfT1hwxuU2lFCDY8v1gzPNoOhSq
         hlOQ==
X-Gm-Message-State: AOAM532xGMhoGX6i66Fk8T+ByzfPOCQpJ8923iIgJ1HC06hG5bXMUXl0
        qC67uYeo1lZ16MUndoyJyeSZ2Q==
X-Google-Smtp-Source: ABdhPJxmQ2+ADb0MAVKRl4BVA4dtzyCyU6rvV7Xqxvp4RrwvwzrHtKO2sXR1k/skwwkhGgk0b9RYcA==
X-Received: by 2002:a1c:4943:: with SMTP id w64mr2152011wma.62.1601027811481;
        Fri, 25 Sep 2020 02:56:51 -0700 (PDT)
Received: from antares.lan (e.0.c.6.b.e.c.e.a.c.9.7.c.2.1.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:12c:79ca:eceb:6c0e])
        by smtp.gmail.com with ESMTPSA id l10sm2225084wru.59.2020.09.25.02.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:50 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: selftests: remove shared header from sockmap iter test
Date:   Fri, 25 Sep 2020 10:56:29 +0100
Message-Id: <20200925095630.49207-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925095630.49207-1-lmb@cloudflare.com>
References: <20200925095630.49207-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The shared header to define SOCKMAP_MAX_ENTRIES is a bit overkill.
Dynamically allocate the sock_fd array based on bpf_map__max_entries
instead.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 36 +++++++++----------
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  5 ++-
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 --
 3 files changed, 20 insertions(+), 24 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 67d3301bdf81..e8a4bfb4d9f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -8,8 +8,6 @@
 #include "test_sockmap_invalid_update.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
-#include "progs/bpf_iter_sockmap.h"
-
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
 #define TCP_REPAIR_ON		1
@@ -201,9 +199,9 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	int err, len, src_fd, iter_fd, duration = 0;
 	union bpf_iter_link_info linfo = {0};
-	__s64 sock_fd[SOCKMAP_MAX_ENTRIES];
-	__u32 i, num_sockets, max_elems;
+	__u32 i, num_sockets, num_elems;
 	struct bpf_iter_sockmap *skel;
+	__s64 *sock_fd = NULL;
 	struct bpf_link *link;
 	struct bpf_map *src;
 	char buf[64];
@@ -212,22 +210,23 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
-		sock_fd[i] = -1;
-
-	/* Make sure we have at least one "empty" entry to test iteration of
-	 * an empty slot.
-	 */
-	num_sockets = ARRAY_SIZE(sock_fd) - 1;
-
 	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
 		src = skel->maps.sockmap;
-		max_elems = bpf_map__max_entries(src);
+		num_elems = bpf_map__max_entries(src);
+		num_sockets = num_elems - 1;
 	} else {
 		src = skel->maps.sockhash;
-		max_elems = num_sockets;
+		num_elems = bpf_map__max_entries(src) - 1;
+		num_sockets = num_elems;
 	}
 
+	sock_fd = calloc(num_sockets, sizeof(*sock_fd));
+	if (CHECK(!sock_fd, "calloc(sock_fd)", "failed to allocate\n"))
+		goto out;
+
+	for (i = 0; i < num_sockets; i++)
+		sock_fd[i] = -1;
+
 	src_fd = bpf_map__fd(src);
 
 	for (i = 0; i < num_sockets; i++) {
@@ -258,8 +257,8 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->elems != max_elems, "elems", "got %u expected %u\n",
-		  skel->bss->elems, max_elems))
+	if (CHECK(skel->bss->elems != num_elems, "elems", "got %u expected %u\n",
+		  skel->bss->elems, num_elems))
 		goto close_iter;
 
 	if (CHECK(skel->bss->socks != num_sockets, "socks", "got %u expected %u\n",
@@ -271,10 +270,11 @@ static void test_sockmap_iter(enum bpf_map_type map_type)
 free_link:
 	bpf_link__destroy(link);
 out:
-	for (i = 0; i < num_sockets; i++) {
+	for (i = 0; sock_fd && i < num_sockets; i++)
 		if (sock_fd[i] >= 0)
 			close(sock_fd[i]);
-	}
+	if (sock_fd)
+		free(sock_fd);
 	bpf_iter_sockmap__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
index 0e27f73dd803..1af7555f6057 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Cloudflare */
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
-#include "bpf_iter_sockmap.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
@@ -11,14 +10,14 @@ char _license[] SEC("license") = "GPL";
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__uint(max_entries, 64);
 	__type(key, __u32);
 	__type(value, __u64);
 } sockmap SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKHASH);
-	__uint(max_entries, SOCKMAP_MAX_ENTRIES);
+	__uint(max_entries, 64);
 	__type(key, __u32);
 	__type(value, __u64);
 } sockhash SEC(".maps");
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
deleted file mode 100644
index 35a675d13c0f..000000000000
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#define SOCKMAP_MAX_ENTRIES (64)
-- 
2.25.1

