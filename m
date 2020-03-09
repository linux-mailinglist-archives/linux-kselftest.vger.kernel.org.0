Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8479F17DE5F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCILN2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 07:13:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51663 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgCILN1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so9369620wme.1
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Mar 2020 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55uiRdkoDOcfMjXmIBGgTWxBo6cVNLF5HZAhtJG09Qo=;
        b=T+MwXpSFCv8TtcIPXQOLo/ehqfzZc7V3HmI3ofOMLNy0Wvp2yVNoVGlIOm7TqCTvs5
         bK42YMWKtOubC3AOKn6Bx5AGQbBLsBmiv/wGfuJZy4kpUrxBnB5x+kkOi0CyUwdFV6Rk
         gbLPPXao982phGCjjwki8P8gejzjPYvkJdD58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55uiRdkoDOcfMjXmIBGgTWxBo6cVNLF5HZAhtJG09Qo=;
        b=fyx6Obt1ZLug8Biv8uWFj+hNnlKPhQ/V6bzBDmdz8dXL8MVorJDo++sVjpC0ZNXHwH
         uxyKPy+A4IiaOO2JubU9P7+7PBEqzBdMe4vK0TEXdgkYMxL/+g+ByUy0FviVkI36jajf
         Q1fjH8BfcPjS9gb5JqmtvGqkTFqEMEoEItQQ5ODIi8AgJsfiAJd8A8q3ISnHbnrR4Y20
         2DvvRkpri3FkSpy3ftdqMvJGD2jG47OTMSLtdyDWCRm4cgqyJqQPuIzpeC27kVa3XSwm
         0H36jGWe8pw9MpMdMkWmsyHR753tghcmf2pj27abpAMXlYsSVRNJlDlCNWPk2yT4bQbh
         k9jQ==
X-Gm-Message-State: ANhLgQ196R8PamCZP9BcKxdvfk7wUFjS0WJlbCUloPMX20LyFGm1Wk0g
        AV/j6U3y3JAH34/z83BzEg8rCA==
X-Google-Smtp-Source: ADFU+vsDspKmQnLy+9e4MN05+pJwgVV2LPfO50xaFIII9Ko+m3/F4t1jo9WJCpDMbx2wN4/3FGxKFA==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr19429922wmj.176.1583752404907;
        Mon, 09 Mar 2020 04:13:24 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:24 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 09/12] selftests: bpf: don't listen() on UDP sockets
Date:   Mon,  9 Mar 2020 11:12:40 +0000
Message-Id: <20200309111243.6982-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most tests for TCP sockmap can be adapted to UDP sockmap if the
listen call is skipped. Rename listen_loopback, etc. to socket_loopback
and skip listen() for SOCK_DGRAM.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 47 ++++++++++---------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index b1b2acea0638..4ba41dd26d6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -230,7 +230,7 @@ static int enable_reuseport(int s, int progfd)
 	return 0;
 }
 
-static int listen_loopback_reuseport(int family, int sotype, int progfd)
+static int socket_loopback_reuseport(int family, int sotype, int progfd)
 {
 	struct sockaddr_storage addr;
 	socklen_t len;
@@ -249,6 +249,9 @@ static int listen_loopback_reuseport(int family, int sotype, int progfd)
 	if (err)
 		goto close;
 
+	if (sotype == SOCK_DGRAM)
+		return s;
+
 	err = xlisten(s, SOMAXCONN);
 	if (err)
 		goto close;
@@ -259,9 +262,9 @@ static int listen_loopback_reuseport(int family, int sotype, int progfd)
 	return -1;
 }
 
-static int listen_loopback(int family, int sotype)
+static int socket_loopback(int family, int sotype)
 {
-	return listen_loopback_reuseport(family, sotype, -1);
+	return socket_loopback_reuseport(family, sotype, -1);
 }
 
 static void test_insert_invalid(int family, int sotype, int mapfd)
@@ -333,7 +336,7 @@ static void test_insert_listening(int family, int sotype, int mapfd)
 	u32 key;
 	int s;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -349,7 +352,7 @@ static void test_delete_after_insert(int family, int sotype, int mapfd)
 	u32 key;
 	int s;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -366,7 +369,7 @@ static void test_delete_after_close(int family, int sotype, int mapfd)
 	u64 value;
 	u32 key;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -390,7 +393,7 @@ static void test_lookup_after_insert(int family, int sotype, int mapfd)
 	u32 key;
 	int s;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -417,7 +420,7 @@ static void test_lookup_after_delete(int family, int sotype, int mapfd)
 	u64 value;
 	u32 key;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -439,7 +442,7 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
 	u32 key, value32;
 	int err, s;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -470,11 +473,11 @@ static void test_update_listening(int family, int sotype, int mapfd)
 	u64 value;
 	u32 key;
 
-	s1 = listen_loopback(family, sotype);
+	s1 = socket_loopback(family, sotype);
 	if (s1 < 0)
 		return;
 
-	s2 = listen_loopback(family, sotype);
+	s2 = socket_loopback(family, sotype);
 	if (s2 < 0)
 		goto close_s1;
 
@@ -500,7 +503,7 @@ static void test_destroy_orphan_child(int family, int sotype, int mapfd)
 	u64 value;
 	u32 key;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -534,7 +537,7 @@ static void test_clone_after_delete(int family, int sotype, int mapfd)
 	u64 value;
 	u32 key;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return;
 
@@ -570,7 +573,7 @@ static void test_accept_after_delete(int family, int sotype, int mapfd)
 	socklen_t len;
 	u64 value;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s == -1)
 		return;
 
@@ -624,7 +627,7 @@ static void test_accept_before_delete(int family, int sotype, int mapfd)
 	socklen_t len;
 	u64 value;
 
-	s = listen_loopback(family, sotype);
+	s = socket_loopback(family, sotype);
 	if (s == -1)
 		return;
 
@@ -735,7 +738,7 @@ static void test_syn_recv_insert_delete(int family, int sotype, int mapfd)
 	int err, s;
 	u64 value;
 
-	s = listen_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
 	if (s < 0)
 		return;
 
@@ -877,7 +880,7 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	s = listen_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
 	if (s < 0)
 		return;
 
@@ -1009,7 +1012,7 @@ static void redir_to_listening(int family, int sotype, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	s = listen_loopback(family, sotype | SOCK_NONBLOCK);
+	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
 	if (s < 0)
 		return;
 
@@ -1120,7 +1123,7 @@ static void test_reuseport_select_listening(int family, int sotype,
 
 	zero_verdict_count(verd_map);
 
-	s = listen_loopback_reuseport(family, sotype, reuseport_prog);
+	s = socket_loopback_reuseport(family, sotype, reuseport_prog);
 	if (s < 0)
 		return;
 
@@ -1174,7 +1177,7 @@ static void test_reuseport_select_connected(int family, int sotype,
 
 	zero_verdict_count(verd_map);
 
-	s = listen_loopback_reuseport(family, sotype, reuseport_prog);
+	s = socket_loopback_reuseport(family, sotype, reuseport_prog);
 	if (s < 0)
 		return;
 
@@ -1249,11 +1252,11 @@ static void test_reuseport_mixed_groups(int family, int sotype, int sock_map,
 	zero_verdict_count(verd_map);
 
 	/* Create two listeners, each in its own reuseport group */
-	s1 = listen_loopback_reuseport(family, sotype, reuseport_prog);
+	s1 = socket_loopback_reuseport(family, sotype, reuseport_prog);
 	if (s1 < 0)
 		return;
 
-	s2 = listen_loopback_reuseport(family, sotype, reuseport_prog);
+	s2 = socket_loopback_reuseport(family, sotype, reuseport_prog);
 	if (s2 < 0)
 		goto close_srv1;
 
-- 
2.20.1

