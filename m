Return-Path: <linux-kselftest+bounces-42605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99697BAA9FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 23:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEAE16EF4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3940257431;
	Mon, 29 Sep 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyaZ7L+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358724678E
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180449; cv=none; b=YeyhLJ4pdUUalNCnoRrMQPgkFfpHowePcVy6KzuNbggM2GS7rvPImFjvngc8pgFEX/meAKhihfa8lSD9aFZ85EX25HO7p8oX8kjFGIF0yzEUG417sQKq8F259r/A/b95EcYpQrB6FKkQ8HDQKy1ox2BEghiSXvTUU8Rgy2fIgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180449; c=relaxed/simple;
	bh=Ynh5t1oq+BGC5ayEleKfAh77OocncN7vunfZBZxFxdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWikBdiZfk6BxRwM1RqCSnOqA2ce4TcPYnuTpVsEwPfx/KjqsrliSEBfwcChqGiHAhYoKBYZQOWYrfGWf+YWwZhFCFVuvMBcmINwhzKrGNY4Gwxxg2Uq1XhfQB2NPgVG1dfBm9j4x21mRI5vq8OwsRcWpj0AuTtbDKRVXTbElcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyaZ7L+D; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e074dso47583985ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759180447; x=1759785247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPMfvOFUo6Dm7WbBf/aklHipttbPQuSYzlg3rBgSq2c=;
        b=LyaZ7L+D176EL9Dua5/7Z2elCRae9ogEebkyI+b3WveGWfF/UIdIOLDA56JlblBh5f
         zyq+g+L+rXgR1PADVuzvh5aYKxN+NLOk5Zq+23+O1AZqoHjhqRjm4xVKbT1N2LY3HDHW
         Vol5xvefJY+j8w2csno0LhOv2+XIVld2GwZPBw0fmXRAkKwHt8nSHtxFEFHaJPWv6wZ4
         IpII/zvREvtUGYCYr+wvoA0npa+/41tzXJgQult+KIhIdiRrdqYLzrbnDSGO+rIDsJWC
         kPqGtl6yIv5POCtHY3IkqBeJZLl6b+14ivwKSRbLSdZD2UIZTC0xQlmZ1Nyk3LQNL/hM
         Abzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180447; x=1759785247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPMfvOFUo6Dm7WbBf/aklHipttbPQuSYzlg3rBgSq2c=;
        b=D+YGCBkMjz00XXUUK64VsbSaCMLlK7Npsi80Y+8E/qNJVzobOlOqu/2pGpa9Z+TyMC
         q0xFSEC0QVPBzG6NwrAfRL2iXU6T1Mak3vX1BzO1ejkFwGzAhp3Y77RvAnq2Hb9t8BDG
         y7j56mImcVKZi7VUP9piyV4nTQUQITjYCvmh7ZP8+WIlqfu3SWo2xsviumKARR2XMO7+
         DrS0yCJv/OvUkdUEHOK3Wf+7T6IxzWmFm54vX6sPjBA2j2kyqbNNGWe4oTDdY6SKBmvQ
         kYhgAMOw2eUre27WSy7Jh40N8OEBi1NvyIqQM6LF/1hstmyWWo0s3ZCs5GXWvM4kO5FE
         uKwA==
X-Forwarded-Encrypted: i=1; AJvYcCVLrIT8Dfs7Ma+JnDkGBzQHNJ1QJs6bP2GgByOJFrDNOEOuXslyB3T7PQDZjqBZ4dxe5hl33Es8J/6I2ELstLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqZr9z0PxuRO69pfJBs8d10k67A4NbvJZ0oBNfF1OnQKxwSYt
	v9bK9KHN2OXRlIEsrPpY/tPP/nRqtjWv9epncp6ginTk8E5KBwBqQ2at
X-Gm-Gg: ASbGncv5Jf5HA/VKIUw8F3Z7LybGl8UjlYshuSvSTiIAMD9A1jTq2xmA89GgBwzOzTv
	f2/lqkgQ+8hLlJF5nHLSlwmkRBdBd3Uf7pFSnurDSZ4DmPlfRigqxkk3zRKc0KShxfLz7R7aVIY
	b7IcfuDjyw0jr4Yv3MmRKI5NfoLC+tQBDBnCSH5+Q9wN4e17xYNLtLQ5C+XwKp331F0cirk1BEk
	tBAPypDfweBjiN7GYKVcX/QNBcdNIZoG4MJiulJ3OrSzaA7XhSH0q0YPPNeLwYATSKlZpgVbUN6
	PhIq8BOgNS1FLJ7tDENTjqHpoNz+rzbKGyXydXa/r3Mku7Fl7aVScry2m8o/0sylhRKsmEnvlI0
	PLgao1H8bqmmnAczPSgfuySZCB0Vd
X-Google-Smtp-Source: AGHT+IG0ZHDqFJrZOvYs432O3Vs3qhLTPiCHHRZ6amJmNF+g4TGNvnUA39X9wjADrt/48NlD7oC1jQ==
X-Received: by 2002:a17:903:90d:b0:268:baa6:94ba with SMTP id d9443c01a7336-27ed4ab65b8mr155433085ad.53.1759180446950;
        Mon, 29 Sep 2025 14:14:06 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:e91f:2d6d:e8a8:f2d7:94ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69b12cdsm137943045ad.115.2025.09.29.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:14:06 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: antonio@openvpn.net,
	sd@queasysnail.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com,
	kernelxing@tencent.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH net v3] selftest:net: Fix uninit return values
Date: Tue, 30 Sep 2025 02:42:42 +0530
Message-ID: <20250929211241.55701-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix functions that return undefined values. These issues were caught by
running clang using LLVM=1 option; and are as follows:
--
ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1587 |         if (!sock) {
      |             ^~~~~
ovpn-cli.c:1635:9: note: uninitialized use occurs here
 1635 |         return ret;
      |                ^~~
ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
 1587 |         if (!sock) {
      |         ^~~~~~~~~~~~
 1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1589 |                 goto err_free;
      |                 ~~~~~~~~~~~~~~
 1590 |         }
      |         ~
ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
 1584 |         int mcid, ret;
      |                      ^
      |                       = 0
ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
 2107 |         case CMD_INVALID:
      |              ^~~~~~~~~~~
ovpn-cli.c:2111:9: note: uninitialized use occurs here
 2111 |         return ret;
      |                ^~~
ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
 1939 |         int n, ret;
      |                   ^
      |
--
Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
ovpn module")

v3:
	- Use prefix net.
	- Remove so_txtime fix as default case calls error().
	- Changelog before sign-off.
	- Three dashes after sign-off

v2:
	- Use subsystem name "net".
	- Add fixes tags.
	- Remove txtimestamp fix as default case calls error.
	- Assign constant error string instead of NULL.

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 9201f2905f2c..20d00378f34a 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1581,7 +1581,7 @@ static int ovpn_listen_mcast(void)
 {
 	struct nl_sock *sock;
 	struct nl_cb *cb;
-	int mcid, ret;
+	int mcid, ret = -1;
 
 	sock = nl_socket_alloc();
 	if (!sock) {
@@ -1936,7 +1936,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
 	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
 	char raddr[128], rport[10];
-	int n, ret;
+	int n, ret = -1;
 	FILE *fp;
 
 	switch (ovpn->cmd) {
-- 
2.47.3


