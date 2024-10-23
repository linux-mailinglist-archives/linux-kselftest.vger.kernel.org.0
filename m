Return-Path: <linux-kselftest+bounces-20481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345739ACF43
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96EB286B93
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5121D1E9D;
	Wed, 23 Oct 2024 15:44:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599F1CF29B;
	Wed, 23 Oct 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698259; cv=none; b=m2XQldZQcbgUR89mMX6CuBh1/82OczMMqJjCANgP0n+6m3GMZQrhZjhFn3EFNVopJfBW2Xce8KjGkTICojurndMfrd5Th9739PSpRXAh3ntBz6imlP3vGaMSTtvnxIgpQSm5cRgcdJByeOXqr5bs6ND1RQ/vx1v7MA0RqKM3P9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698259; c=relaxed/simple;
	bh=k3NksgKMGGwSiQjqqQDiIoWxu2o4MtjaGnPwO3kHGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3r2u7aeQf61NhFf3dRv537Uj4Cq0oCcN7OgMswKvpIu4DfoXqVb0FjTX1ehPIv7MmJzgZsQTcrCg/LPiJONNuHlBm5JCBPBC4rcsBe5vxKqryalZtiZ0vshneaNACPN3MeVWDgRQCQFnidXYkiLaZdvjuuRT56nkfO1igZai9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c6f492d2dso81004595ad.0;
        Wed, 23 Oct 2024 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698257; x=1730303057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3YqyV0YwGuilWF+8lpqEcTlB/FpyMoTdw0SNw6nZVo=;
        b=NDX9XE9CFSH16J/AwLJa6RmvNVaM3WuWVNaOYcO4t6n1rCioKBQin5NZwkNRmq3QUp
         5Uhtns9r9HZJc+6l+Vte9dNjEgxn9tYqfQrGOKwgFZ5tePvL1Ff2l9Pe1VAdbJncvIIg
         XmcNjmMaH2ElqjIWM1Ma8iK8175xAtB93D/Xd2AJgaUASldymPLNyQhOcxR+Oe0J6jN8
         YsY8B8RRpXhjvaxQDqrUc0ks+usdmhEpi6HRpmYrZjT4x4ZOZmEzAG8gVZEu0XAhSXdb
         EkIFdnDsi5dZiGOImRLHAQpIsEGeisp1P+56j0d6kfVPFbzgD0YRWBbgZ3/39JnS6NHH
         1GbA==
X-Forwarded-Encrypted: i=1; AJvYcCUm4S9CGv4fzPM/yCUF4FxO2xItvuaWOXNoQ+qUUcYOiKtDGUgCroIiL2LgSAh3nWOyG2mhs+Mmqq4JgELGHOGW@vger.kernel.org, AJvYcCVbOe21gStxYkEXzezx/NsCRRiN5oSJMZGB8nWscKJZmsy+vB6Gt/rPu0NPDsw2hIQ3xbrDhpfcGA014hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXzXex5UBDx6b75IUHhwJhY5vyNPGMEOXgNmEMN8C/tlyZNKv
	nzgSoe3MvfkrE7wQ6MvHmgX7QUL0F1Ct/3j6N4Z8gseKoSPHPVIhP1KVsT0=
X-Google-Smtp-Source: AGHT+IG5tIKpYeuEz6ZLsiWpOGSrUCthd3VQ2flnhUoELbeYmk26pijtnqS/JXJt/3edd7064c+NAA==
X-Received: by 2002:a17:902:ce86:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20fa9e246e0mr30293045ad.18.1729698257223;
        Wed, 23 Oct 2024 08:44:17 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bcb75sm59576405ad.176.2024.10.23.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:16 -0700 (PDT)
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
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 12/12] selftests: ncdevmem: Add automated test
Date: Wed, 23 Oct 2024 08:44:02 -0700
Message-ID: <20241023154402.441510-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
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


