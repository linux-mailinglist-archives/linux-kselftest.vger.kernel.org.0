Return-Path: <linux-kselftest+bounces-21638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA889C0D9A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EA6286238
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB83219CBE;
	Thu,  7 Nov 2024 18:12:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6D219C8E;
	Thu,  7 Nov 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003150; cv=none; b=pP7AVT+2QkgFj4GnJxtxFx1U/TeUlVujLgvd1UOw1dOBi8wmNbrR8oW7LiGSwATHP3IvJKM2kxejq48KkEClkFpml2go/I18gkHieW4dXzFYtsHYnugsmItA2ObgTANneuJM3UL55nnc4s4MxPIX+mp5UxuxwD5OLSuLCFA6y+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003150; c=relaxed/simple;
	bh=WEVapGRSibcZWnAdVZddqFwRKnfxfw/1NS5vjEqInk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZpaa2LoqRdJyhZNq0LgfP+UjvprmgIQlDB91N9yZDHRLU7o3vlPw4PUlWue8hQXDjj2HirwKCHwGvCcw5sRPw3GGkJ9J8gQxfUNc1Q8iJNb/z7TWh0NG1XM59eD9wbDEII1Eupoyq9a/ZW/+MiX+LKsNhoAVXTh777eSZlM0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so998772b3a.1;
        Thu, 07 Nov 2024 10:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003148; x=1731607948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx/2wnbdQkN8QIuIPvLKCg6kXWPOICXSJLx031omQYg=;
        b=Tj0i9yj6pePhg9vzsQGcUN+3wdeGYuz2yj6O9O2X+YzW59xocecyD0XRz3iubD7XyU
         CXtPAuMZEoJTIt6V5CqYxiopqmAxVfEFHttH1Q8uqXnMa4IL2/K7zGaG6vNQaAV3yk7T
         P1Y2X2UikAUVj5bEpZX+xpNj1JDRBUwbUr7szUq6JC4RtNpyDuJiJOnTR54mZejp83YR
         81pXaDy1PB1l8YcFtO10I9xz4SyDAySf2MatOKGvzoGmZqoL3LcVJFy1uY6X2toBz+jV
         ApYMsKTfW3mcyxlNbP+NUdz4I4rH2UmsYJ5dLG7RCOoxr7YogcphkqCFA3NBgFxgEHGo
         qh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8zgzKoYTsd1riwuyf77qQQ4acZbHXOky+btR7JKb5SoBa1J/K8aNZNEVUySWfxUrZKYdkOqnKwxWKBZ+SxHpu@vger.kernel.org, AJvYcCWAolXk9pJ1F/bUEzDw2uzLGr2V2fF9S5CiXAG3KZljpq5vZWwvqo2lC/R6Wvf/y+jT9c6twuosSet702A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85khEF+VLsAsFoY9eu09RVH63nnK5KCjKzy0lGAIfvU5M0qVE
	hHHLYy3907U0EiFqZBoCdoEW0pESH5xAO8CgyGHDL7JqvKruM7mHvE4+
X-Google-Smtp-Source: AGHT+IGaWDZqmfbW85mkzCyEVanG3EM2BoxuAf/uYsm7sCeaTKZTZkIR3DakFqzP8SMfT4gbBpyovQ==
X-Received: by 2002:a05:6a00:84d:b0:720:9a03:b6dc with SMTP id d2e1a72fcca58-72412986e46mr408154b3a.18.1731003147709;
        Thu, 07 Nov 2024 10:12:27 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18f24sm1866818b3a.152.2024.11.07.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:27 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 12/12] selftests: ncdevmem: Add automated test
Date: Thu,  7 Nov 2024 10:12:11 -0800
Message-ID: <20241107181211.3934153-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only RX side for now and small message to test the setup.
In the future, we can extend it to TX side and to testing
both sides with a couple of megs of data.

  make \
  	-C tools/testing/selftests \
  	TARGETS="drivers/hw/net" \
  	install INSTALL_PATH=~/tmp/ksft

  scp ~/tmp/ksft ${HOST}:
  scp ~/tmp/ksft ${PEER}:

  cfg+="NETIF=${DEV}\n"
  cfg+="LOCAL_V6=${HOST_IP}\n"
  cfg+="REMOTE_V6=${PEER_IP}\n"
  cfg+="REMOTE_TYPE=ssh\n"
  cfg+="REMOTE_ARGS=root@${PEER}\n"

  echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
  ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.py"

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/devmem.py        | 45 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 182348f4bd40..1c6a77480923 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -3,6 +3,7 @@
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
+	devmem.py \
 	ethtool.sh \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
new file mode 100755
index 000000000000..1223f0f5c10c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -0,0 +1,45 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, KsftSkipEx
+from lib.py import NetDrvEpEnv
+from lib.py import bkg, cmd, rand_port, wait_port_listen
+from lib.py import ksft_disruptive
+
+
+def require_devmem(cfg):
+    if not hasattr(cfg, "_devmem_probed"):
+        port = rand_port()
+        probe_command = f"./ncdevmem -f {cfg.ifname}"
+        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
+        cfg._devmem_probed = True
+
+    if not cfg._devmem_supported:
+        raise KsftSkipEx("Test requires devmem support")
+
+
+@ksft_disruptive
+def check_rx(cfg) -> None:
+    cfg.require_v6()
+    require_devmem(cfg)
+
+    port = rand_port()
+    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
+
+    with bkg(listen_cmd) as socat:
+        wait_port_listen(port)
+        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
+
+    ksft_eq(socat.stdout.strip(), "hello\nworld")
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([check_rx],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.0


