Return-Path: <linux-kselftest+bounces-21120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275659B65E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F89284733
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9381FA270;
	Wed, 30 Oct 2024 14:27:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C641F9EBB;
	Wed, 30 Oct 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298462; cv=none; b=mytIsM66lT+8MwoTw3CxY6pvwI6M+0DjA3itQTiZQ+ZetIrhHlHMvHtObvGyBVARII4n1uYmyrwH6pfqzh8kbsTC+aPUGRIEt+u477VI0zILPWx/w19heb9Im96wZCvVtf3nDcSDovbZF9cdxOu3tl1Mv/4ivAE3lnC+5EOuxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298462; c=relaxed/simple;
	bh=k3NksgKMGGwSiQjqqQDiIoWxu2o4MtjaGnPwO3kHGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFtt4t+Q4WPxNHpNJw1/wK+1xPlY6hFhzTZaGE3R3dCKh2qgH17TwxMMeV08+EcJaOtpzX+l+BMu6VcavXg4da7/zlm8JrdyXNpkqF3uEuI6Czex2zOeXH9J4ML9GtcfinUyqFAY217wiRN3uNjNeHL8THuKvsFHEDVC3EKmA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so5144035a12.1;
        Wed, 30 Oct 2024 07:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298459; x=1730903259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3YqyV0YwGuilWF+8lpqEcTlB/FpyMoTdw0SNw6nZVo=;
        b=hBWfQHUe7ygOTl1jFrJirurdos6WzAOSd/MKc/YiyZKZ2ffCNcSfAm2dZuzOFPvyCu
         P5tctNe6eqBpn0i/Ve4X/RyII3Bu8ICBiX144M4Jf+Jw+t7C3RwaiWicdD7yPq4uS+Bv
         oD/A1bNXkf42wT3M56fQm3V9R8ifBb2LtPQkNgjYouKBudPcB0fKqAUGTCh/QnXGpvxd
         3tFaJhllDYUuuwclRbYw5WmBQvrDNeJ2jHOGEpRJX6AxNF8VrSDES9xDb/rFwczsB5sH
         beLSzgwEOfnebQecLQeu3WztYRJ0NjxGzlO3OCU9Qbz5gu1+Sh6eIjM3NnUf8KDtggRA
         DhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB8bx/Zax0THTk5tQFirphC46sRUjY0de91fjjhYgIeGMBFQif8bxTjbrpOg8X7c0xwASl/2oqqY1pMF9Y8Wel@vger.kernel.org, AJvYcCWDbiv8eSNXEK3zxE4Q1xTqYz5lpGWhP+tWCZw1CPugducTNEJZ620tvcic3Zz/o6QRudX+xmpSD3jJy1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUdSIf3ttiAdSEbPwlnFHxU0s/geonF8ZMTGzaG7VGUCn41Y9
	qhAm8VARWliLwC+BTLfEDR/PiDIRkI4djCV9zMT1rUnPoqASQNt9zVQRerc=
X-Google-Smtp-Source: AGHT+IFa0T3NhLLZTVYB47aMtxMkeD80BrpeKBP22/0bqgcXxhS+vEBtm3n6X1TYaNAhdmXADKD2sQ==
X-Received: by 2002:a05:6a21:1707:b0:1d9:d8d:d0a4 with SMTP id adf61e73a8af0-1d9a83a913emr19237362637.9.1730298459536;
        Wed, 30 Oct 2024 07:27:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720579397d8sm9346440b3a.86.2024.10.30.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:39 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 12/12] selftests: ncdevmem: Add automated test
Date: Wed, 30 Oct 2024 07:27:22 -0700
Message-ID: <20241030142722.2901744-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
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


