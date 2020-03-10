Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E920180562
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 18:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCJRry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 13:47:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgCJRro (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so11969347wrx.6
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Mar 2020 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2UFve1spLe5PfIsM/t2IP38W27VsK6rPhEgeqi2HIU=;
        b=jSdZCLm8z1rI3LZ3SxCXEel2QDbkIxZzCF2vGUbO68qM+QmWrF1e4E/W60qB/ZbaQJ
         pqbfQkL/gbldlrpgjPDKgcafiJouEnBqev4A2r01VweiblzFHhZ6mabrDEI3EGSyXldQ
         FRvm+2oHvQhWCgzDOy33uxz9eA3dnUD+AclPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2UFve1spLe5PfIsM/t2IP38W27VsK6rPhEgeqi2HIU=;
        b=nnLdRYa9lIjvoDRzRicN0Sf9O/oNIQrcdcKM/aVIl44MVC87xvqPE3TWjQmh1wCV/G
         fiLmYdWSID2l36xlasgun07EBVX91mDj/t7epoU/d5HDflF93+eAL1/oXMADhF7D8XTa
         UPeSt+tQGoRPrarDE7sFNfCyQqstZpFdL1nDd+MudFJVaUmWKxPWaA6xpDpZFGTgtYTG
         7Mf7XfNKBGo2FMxHGnQabqBvBYrK9hOoTg2T8I7iHzQuhq4agei1OcmOCSKu6xkd2dbz
         zzAahPPqytBf3NzbSj5u22C5aQm8f+A5HrnEcyImze/IATliak2PPM6NvqfAqs5w6aeM
         10BA==
X-Gm-Message-State: ANhLgQ3fPnMUnhhULkjcqumg93KJ+Qw8r+Z01c16a2bhBk2fgUtesZ59
        Ioe2mv3FGn4AKSuxlyToC3Bdfg==
X-Google-Smtp-Source: ADFU+vsbjmjA39Km027B6MzqwvSgIzkU/t+2bR4rGkw6W/xaR7jhW8Qj7BPN6PQHA/PHwTS1skZhpA==
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr26516031wrb.349.1583862463547;
        Tue, 10 Mar 2020 10:47:43 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:9494:775c:e7b6:e690])
        by smtp.gmail.com with ESMTPSA id k4sm9118691wrx.27.2020.03.10.10.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:47:40 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] bpf: sockmap, sockhash: test looking up fds
Date:   Tue, 10 Mar 2020 17:47:11 +0000
Message-Id: <20200310174711.7490-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310174711.7490-1-lmb@cloudflare.com>
References: <20200310174711.7490-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sure that looking up an element from the map succeeds,
and that the fd is valid by using it an fcntl call.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 52aa468bdccd..929e1e77ecc6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -453,7 +453,7 @@ static void test_lookup_after_delete(int family, int sotype, int mapfd)
 	xclose(s);
 }
 
-static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
+static void test_lookup_fd(int family, int sotype, int mapfd)
 {
 	u32 key, value32;
 	int err, s;
@@ -466,7 +466,7 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
 			       sizeof(value32), 1, 0);
 	if (mapfd < 0) {
 		FAIL_ERRNO("map_create");
-		goto close;
+		goto close_sock;
 	}
 
 	key = 0;
@@ -475,11 +475,25 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
 
 	errno = 0;
 	err = bpf_map_lookup_elem(mapfd, &key, &value32);
-	if (!err || errno != ENOSPC)
-		FAIL_ERRNO("map_lookup: expected ENOSPC");
+	if (err) {
+		FAIL_ERRNO("map_lookup");
+		goto close_map;
+	}
 
+	if ((int)value32 == s) {
+		FAIL("return value is identical");
+		goto close;
+	}
+
+	err = fcntl(value32, F_GETFD);
+	if (err == -1)
+		FAIL_ERRNO("fcntl");
+
+close:
+	xclose(value32);
+close_map:
 	xclose(mapfd);
-close:
+close_sock:
 	xclose(s);
 }
 
@@ -1456,7 +1470,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		/* lookup */
 		TEST(test_lookup_after_insert),
 		TEST(test_lookup_after_delete),
-		TEST(test_lookup_32_bit_value),
+		TEST(test_lookup_fd),
 		/* update */
 		TEST(test_update_existing),
 		/* races with insert/delete */
-- 
2.20.1

