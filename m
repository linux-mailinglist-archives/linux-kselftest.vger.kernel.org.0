Return-Path: <linux-kselftest+bounces-31029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68694A91138
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F221169F28
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64B1DE8B5;
	Thu, 17 Apr 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z14ren/J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4C1DE4C8
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853599; cv=none; b=AXUZoCnQu0hpRYhC5drw4Eyvva9kmho2T7V0394GeNS7MzhSMO0xQEg8qbNRCV9e+bxjAamrGdvp1eubAvaIdiworSGBXZDh9GYn2Nj1jVpGTFi75gnFU1wObxYihcu0BMGvngG/gVJJeUBPPSoIkSuZKFmV+Kynm3Nfcxt8d4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853599; c=relaxed/simple;
	bh=7/43IpTzeRiEM6Px6bilPKt+XjpfXGEavwRwx/SGMHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7tQTzzjYKweHjPURSt2LrJ2xR4QBmzxaGEW0Ei2UTb4W53ExNQVC3eZ5gGBFEeiE2NJbGOXSstYMLrbFdDwV1Sgeg4I8jVL5VBJdxjUAg0kGp3Wl1ZM8ywqXwmUKVnxqBgMKUOugJB4OdZfw8M7DaoWetGWA8q4gBMBzV16k/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z14ren/J; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bb647eb23so177889b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853597; x=1745458397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06V3AHEiTyRxQXWcUBqLLERPc2tH+snQC0VRRM2/tsY=;
        b=Z14ren/JMi4GWFhzOQNe0vyUdMCPw6kGzhVeVtems/5lF7WmdmNIbQeCP93QqYBdFW
         +9dpZKdQm4SEo3YsyocQpjhvRm0x7OgDDyHMDb4LO/pyusZPkRxTP6un8mCJW+GnQkKl
         uNl/OC0YeogNPsYjR35mujRmrEpw1Th0JOeEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853597; x=1745458397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06V3AHEiTyRxQXWcUBqLLERPc2tH+snQC0VRRM2/tsY=;
        b=H07S9d8Jfq9k0qWUpZ0VRjkXL6IeU0Ap/QZW1XDsO6xoTRPeI/BScDmOTw30/Wykzp
         3GPNkTHDqM3vib9WEDEd33Hm6tI7cvM2NUUpZ5cHBeik83mzmPuB7M4VihvsHGd60eqk
         j/lT9PVcM6g5D8mBRcZUVYgLl9CHLyV7HfcZR56QI3mG3c6Zb3pyt/bHe6zMZbkDKNmc
         qivuTjUPQ/ssFt6imOmwNcUpVjD47Kt3WnCEYMWgM/H87HxYiLBLISy2mJ1lVL086Sa4
         hcgHttpm2Ctn3ymmt3cKsek66SaYZ7DunjWtUfLfa/dMXovnmMOm4fQjrik3Inq3VtqO
         WLSg==
X-Forwarded-Encrypted: i=1; AJvYcCVJXa3RJFnuoDZQ+5N3J6OXlKFDvOF2JMb2tZ8BWicITJWARTU7kY+BP48VoMKPhY4TDiPUBSz/pQB1iHgcx7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYz3l2plFBXfZKKLKPvCexzmfuLNJVwijKXpTZF7edVbuJZoSZ
	xEB/03RhDFu3x2kx89gGlE/PnBPC5wEZqbxuA3/ImUeplpTggA7nno+nYO7v79+E6YoN2QJsacP
	j
X-Gm-Gg: ASbGncvUGNh925kpKb5WNTHLtssrcW9N0xFtjU26p/H4S7rVP+wdGDDVxqXwzkpOgFE
	GFo3l9+WLyJG2FreOM6w+1Csl1w25cc+V53+hG9grSZYfTz47Nq14l1cSg5Wy+pZDkzIQ9RNFGd
	hZaJatOZjHlf73iqrmoTmW0SRBDWkY77figOcIvG6hOp68n2LtigDfttD6Pfe26QSLu4raFz+6i
	2MX53hwY9KGhNjt3EaS6jZSx7zxV+5cre53hVX8wOTcJJHYwo8NsRh7vRwPjvR7wdHQurCxudyz
	Fgu9jKFfaqR5N3MPxvIT357H/SMoEbGQ5BHv35QNtC9aCd0q
X-Google-Smtp-Source: AGHT+IFwch9vZHyhnlVsQfTQrueevfR77nz+jh/2oHSkFCsSh+vQ8ZBfNCPWGD7K+cO6E4Q2GoQ9ww==
X-Received: by 2002:a17:90b:5211:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-3086417cbacmr5223592a91.32.1744853596874;
        Wed, 16 Apr 2025 18:33:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:16 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is non-zero
Date: Thu, 17 Apr 2025 01:32:42 +0000
Message-ID: <20250417013301.39228-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417013301.39228-1-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that the SO_INCOMING_NAPI_ID of a network file descriptor is
non-zero. This ensures that either the core networking stack or, in some
cases like netdevsim, the driver correctly sets the NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index ec746f374e85..71bd7d651233 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 xdp_helper
+napi_id_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0c95bd944d56..47247c2ef948 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,9 +6,13 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
-TEST_GEN_FILES := xdp_helper
+TEST_GEN_FILES := \
+	napi_id_helper \
+	xdp_helper \
+# end of TEST_GEN_FILES
 
 TEST_PROGS := \
+	napi_id.py \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
new file mode 100755
index 000000000000..aee6f90be49b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port, NetNSEnter
+
+def test_napi_id(cfg) -> None:
+    port = rand_port()
+    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'
+
+    with bkg(listen_cmd, ksft_wait=3) as server:
+        with NetNSEnter('net', '/proc/self/ns/'):
+          cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
+
+    ksft_eq(0, server.ret)
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_napi_id], args=(cfg,))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
new file mode 100644
index 000000000000..7e8e7d373b61
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <sys/socket.h>
+
+#include "ksft.h"
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in address;
+	unsigned int napi_id;
+	unsigned int port;
+	socklen_t optlen;
+	char buf[1024];
+	int opt = 1;
+	int server;
+	int client;
+	int ret;
+
+	server = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (server < 0) {
+		perror("socket creation failed");
+		if (errno == EAFNOSUPPORT)
+			return -1;
+		return 1;
+	}
+
+	port = atoi(argv[2]);
+
+	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
+		perror("setsockopt");
+		return 1;
+	}
+
+	address.sin_family = AF_INET;
+	inet_pton(AF_INET, argv[1], &address.sin_addr);
+	address.sin_port = htons(port);
+
+	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
+		perror("bind failed");
+		return 1;
+	}
+
+	if (listen(server, 1) < 0) {
+		perror("listen");
+		return 1;
+	}
+
+	ksft_ready();
+
+	client = accept(server, NULL, 0);
+	if (client < 0) {
+		perror("accept");
+		return 1;
+	}
+
+	optlen = sizeof(napi_id);
+	ret = getsockopt(client, SOL_SOCKET, SO_INCOMING_NAPI_ID, &napi_id,
+			 &optlen);
+	if (ret != 0) {
+		perror("getsockopt");
+		return 1;
+	}
+
+	read(client, buf, 1024);
+
+	ksft_wait();
+
+	if (napi_id == 0) {
+		fprintf(stderr, "napi ID is 0\n");
+		return 1;
+	}
+
+	close(client);
+	close(server);
+
+	return 0;
+}
-- 
2.43.0


