Return-Path: <linux-kselftest+bounces-21405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CAF9BBD28
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D081C22B82
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399861D4149;
	Mon,  4 Nov 2024 18:14:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E41D31BA;
	Mon,  4 Nov 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744090; cv=none; b=R97wWpWzGuDULFj8aN6cEnROhhZN5YthxatQZe2TnxdDadUjHxI/NVhUoFUCWdQq4VPYGnK0FwUMDkDJR7YGJtg9XLK7RAQeZz8Vcrt5zkKnPWlqchcOGnNNWcMZQg5T4YZjlGCsEnpuSLlLzaXlZ+BQ4VBlLqrzfywOCzUxkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744090; c=relaxed/simple;
	bh=k3NksgKMGGwSiQjqqQDiIoWxu2o4MtjaGnPwO3kHGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw3zLy/pvjABjkBQRbZc4wDH761VKXs8DaBFYV+Y2LiTkrcKpzq1NndtjM7ADd+0tkBLaI/X8MsH4Vev/kqaE1yYvmgm5mOpJ+p4iaTpMeoa3kKTyY2uAw55HjMm8JExW5yTUA9eoN5npw2Q2h+n8EgdygpOeEB/V61HYCwRg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c6f492d2dso49026135ad.0;
        Mon, 04 Nov 2024 10:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744087; x=1731348887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3YqyV0YwGuilWF+8lpqEcTlB/FpyMoTdw0SNw6nZVo=;
        b=Ei90Kslb4CMMLK3D8Lx50bHEMHWfOpXCLWRWtYSOO/B04GmGFDPusEf+UXDEiqWhSk
         KvYhhFImxVVln2munoB8hNWLlGvWvVrDLLn4YSYPozU8l/Hn5bVe6bu5kv8tW+gmtX/i
         ygxkB2kVgkUlo+Brc3I/1cH7BK8NzNET0QNgqFpPOli/H7UBqiSX9tHWhFrkQLH8qeVs
         wDjfppT7f1eikadchVlD68/5S+U2rNchV61STT5OttTGtR6PJVsmfYazX5qqzDmS0ICT
         14NspBHl6mf4EZwC5HqTRzMTxiTkP30xhiHUmYG7241GsrAnDRSNF4Q1Ik2Y2gSxJ+1H
         QN5g==
X-Forwarded-Encrypted: i=1; AJvYcCXIe/KJNT5UEkSZ1x8p1/iV32HrxV/bjQM7yRVOAuiRay0ZFnYi2Mjwi6AyIVj2WhZYxmuEj/keRc8fiV8=@vger.kernel.org, AJvYcCXKvQYW94GqmMObBvCtGWfgCEOWCbyYYc2Pl6FBFgq++d9oFzrtfI4CzDohFfBnbbBNk0k+RpfgZIT+PAK4tyuv@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOYO9HuihxpASZaEzYQgE2A+dAylFsnS0MpBOz2jTqbkQRVmd
	LYrZVC2HxEcyqzt02chm+vTwJJ6zxpjQ+Bwkthy1kjMQuw14qRDd4Wyu
X-Google-Smtp-Source: AGHT+IHRCEF9Wme8C0aZgb892OYe/X4v+cIm86yN2WycRf+lICWUp822HUIdb27Af1bRxlCqJd5o1g==
X-Received: by 2002:a17:903:2cd:b0:207:6fd:57d5 with SMTP id d9443c01a7336-2111af38936mr160079935ad.36.1730744087533;
        Mon, 04 Nov 2024 10:14:47 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057086e5sm63678585ad.75.2024.11.04.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:47 -0800 (PST)
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
	petrm@nvidia.com
Subject: [PATCH net-next v7 12/12] selftests: ncdevmem: Add automated test
Date: Mon,  4 Nov 2024 10:14:30 -0800
Message-ID: <20241104181430.228682-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
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
index 000000000000..1416c31ff81e
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
+    with bkg(listen_cmd) as nc:
+        wait_port_listen(port)
+        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=cfg.remote, shell=True)
+
+    ksft_eq(nc.stdout.strip(), "hello\nworld")
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


