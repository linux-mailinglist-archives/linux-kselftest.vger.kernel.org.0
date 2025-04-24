Return-Path: <linux-kselftest+bounces-31477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC4A99CFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67A7462FB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B6149DF0;
	Thu, 24 Apr 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CZVwc8F1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30392145A05
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454502; cv=none; b=F9QulMTfr5CPuK0pT5f2hxSLW7w+08aTvyAWnQj1WSBzDHAicJihtv/cScqEonV2xtGSOTPD90C4RgxHVkGm8mdB107CXXhE02CYp2VX77uccOyGu0+jzytuoRO1dKBnOjeNAqeClYpmL60N013q6dBwdseoEDa2ITPVkajoV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454502; c=relaxed/simple;
	bh=XfejFVfUeNjlcemQvV2FfBGjQHl1uJWERTzwSMmvtPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hshpL1zNdvjXJhOlvMIKstn8/g2kgmiw/L2ywsbhXkE2aXW1KUvCC/QtFPRJyuJibtectZ3prp5uys/V2rArjiPXJNBwc7NueMOf9nSjeRE43hjz094+5hMzyBJDrVqdtmeql34E7DAbqMW54y3HGdz2fslSi9gfYFQ2riFMle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CZVwc8F1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff64550991so377558a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745454500; x=1746059300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fONRRd0VBHmSB/DlTOXXKEWrq2Lhm3txVCS1ybmwFg0=;
        b=CZVwc8F11k7fY5c1ugrngaTYmJym5j4Dcu5OdVucrMo2750HaMBRAzJlzaahoxeF24
         qObiytR+EFDvHzQ/mQn4YBNW1HiPo8u7X12p786Mk9RDWGUriQroOaViSmEGQVAL6itK
         WMNcX5ycXz4pS2dZ+crZncqfLudYrE8R5n55A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454500; x=1746059300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fONRRd0VBHmSB/DlTOXXKEWrq2Lhm3txVCS1ybmwFg0=;
        b=wKM2eHjBZdYn3NytPcf1PXUbNWpOb9tqm/hGnYgZbTslRKnQMqChWG6WH5yL7SxpF/
         n6IH3drwDmJI9YDtIlxTBhz3ooUmkO0MjOlNjyM3P3qNx+DXliBgIRKROb1rVgSBgt7q
         aUStwxGYKcOdeQv/DJziJfhGBGxnclNLg9i8/BjGD7oEMV54403zLmcBLjad9yoKCq0J
         7wPBJWDRYcUhK0kxFxP3tWhayVPKU7lFc9m3FbIk+IVmbHEXO+FLtVMyCcJAP2XD6uF5
         RG+NNCu1VLGfXKUUdqGVYn4JoQ+RDLLpndtekBbP5C+r5R/lc8Dy8849RTMboJFki81W
         1EPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnu7LIlanBlBaVdK3NNEPm47j9xSZJQGsB3mAWrFBhSOgrxSSJsEc2P4HJts3EyCsRQIcsWyOPgYSyJODbnR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsuS4ysAudthXw3CWxa26VKT2fWc8r05fVzOJIQlxIE83+KSs
	ML9CxvA1xITDjCT2sQYhLudQnZ3yuYMpa1cJE12sswlmk9DmFV8+l8ANr6ps5G8=
X-Gm-Gg: ASbGncvx1cdu968ZBmajczie8ZD/VOr51vTvbPbnMqvPEWWUCx3rUnmumtvjvf1XTB8
	Y2kPT6BGKjKwiCEZvAOz0O61r840GfepvJUjhEWtIyOsq7Lc4OmKCTPAgSHKCjUuzvjYyV9Hj8g
	RrIPfJtvChko8jBie6Z0TK8d+cSUIYrhZV4O29rkD/HmfiEp88+XP9TQBlI4iJ8k+5T87Z6RlPL
	rvJ6BsA24rFBBJ+8GyViRbdZLsWh41Hv4b+3Fh+CwbOiqpJh7BalDSBt55BVQeXaowAbdyofbJp
	DYGMe47FPeF42Dy98TZoh9zL3Qo+aaIGjTrDb30lm3gOX2yA
X-Google-Smtp-Source: AGHT+IHQIolOk+n262eCIIoMGQ54RpktEuMS5r9p2G6tZQeOFE8Ai42mQoK9PW7YbvD0WD0iY5WqEA==
X-Received: by 2002:a17:90b:2752:b0:305:2d9d:81c9 with SMTP id 98e67ed59e1d1-309ed2805d0mr1116420a91.16.1745454500436;
        Wed, 23 Apr 2025 17:28:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee7c4054sm83013a91.23.2025.04.23.17.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:20 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	pabeni@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v4 3/3] selftests: drv-net: Test that NAPI ID is non-zero
Date: Thu, 24 Apr 2025 00:27:33 +0000
Message-ID: <20250424002746.16891-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424002746.16891-1-jdamato@fastly.com>
References: <20250424002746.16891-1-jdamato@fastly.com>
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
 .../testing/selftests/drivers/net/napi_id.py  | 23 +++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index ec746f374e85..72d2124fd513 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+napi_id_helper
 xdp_helper
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
index 000000000000..356bac46ba04
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/napi_id.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port, NetNSEnter
+
+def test_napi_id(cfg) -> None:
+    port = rand_port()
+    listen_cmd = f"{cfg.test_dir}/napi_id_helper {cfg.addr_v['4']} {port}"
+
+    with bkg(listen_cmd, ksft_wait=3) as server:
+        cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=cfg.remote, shell=True)
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


