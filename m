Return-Path: <linux-kselftest+bounces-37963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF6B114ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783607BA9A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397E248F70;
	Thu, 24 Jul 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNrk5V0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687E246BD3;
	Thu, 24 Jul 2025 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753401112; cv=none; b=IDa/YIwH7zwL35j7i0bkYuu+2QynQe7lqZAPqPUMoq/XYGoydf23B3y1dN95LAJK59Su0d8NGDy5Hy6eTNph+RrEgZioKg2/Ia56QEGtSuylKB/DKxQtaeeGdrgEdUNNHxY2fbp+NF3ZohqDxTjgl+6ZTOqTokgV+vMHZV07JZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753401112; c=relaxed/simple;
	bh=RYDUdBqsUAxzj2uSXAxfyfBnURl9eyWaXntHpGSrNjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIoIgTzwYw71ww9hJ/IKE2dww3H7R1PoalWclf7vsBNzqtasnyzmilYKWVSvmJLtI+1+EVqAjbJ0qiZL5x4jjykWNOImya0b42A8ikQc9wqVKdnDRlxGD57TMyb7ATSNxBEoFBtcZzo0//H/3BnHFm+qP0nativ2NZyN7TSl5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNrk5V0j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so1038877f8f.1;
        Thu, 24 Jul 2025 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753401108; x=1754005908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGCKpGUb3Ub4JNi8bnezOVdjLhpUD56ZOhNKn0rve0o=;
        b=PNrk5V0jPpWxB2s7z/oGMIXy4BCzuj5hSG17RzGhB7AkQDPZvSJBvpiVv5VH15/bnI
         lEQ1A7DEPhToG8GI/3KBl87Bmmoa4jDSYkfrgX7n6e+IDvT1Bxzpw3gQWP/KvGBLEn/9
         rOw84aw/PPk1Bffz57pHBvaiI8UdKejf12hWYo8i+Vxas4Ip26NgB3WfV7eKdo6whiR1
         nnkh/30tmTC7vYfFIaLbkOOIZnouxT8mZI1vUG6EMEbEQysQzFSNPMTCAO18+KqGGb+5
         YamCYjPqqibzb9hgPyozwN01xa/H7K1GCh6nTHe8UglOpCI+N1/sy8MKufAd/YOTvK0D
         5f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753401108; x=1754005908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGCKpGUb3Ub4JNi8bnezOVdjLhpUD56ZOhNKn0rve0o=;
        b=WpeFo9+hT03HBS77H1GAlKP+7IVhpRI7SinNd7adW7aPPRG7q42oesatKSvjxy4f+5
         j1CSMNQgT1wkwPlQqnl6siadnn+ZXGSBqImwzMdpGQ7CS986w7rzQK3Aaa9HpwMS2tHb
         AwdHru47h52Rmyox0eC5kQpl+ONtscbEz6h5iEYjtfUD0pbAZCNunEWlFPC/lGhZqLBK
         csQIpnGbKOfYpOcJKUoIdC5iEEpdWsZXaJUki+RIrX0aTB5S9re3rXHeHbU0IYQyOvka
         Xmuht9296gqoq3LEuYEmNcxw6BWEmoRk6kHpHMT8VEWoxkoJI9aBzYBThjdRj7+QFawf
         v8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCViGjVQcPDsKxOeA5jTJImhSrgCjAL6igA43xnybPh2nd6qBzbJ7BkEerONtNsp5SPIOedFqrPZi54xrwpQjAmb@vger.kernel.org, AJvYcCXfKigTamwQPlu1XGbzue1kjMjpJ9fQPRA93Rfr/NEwm5LWyV6s6Q5weD8OZPwjbbNlZKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqv+u8Qrh6bzVjYErsKaKOdCBoabska+iRXoOgfEPwtxmqSrMo
	mg4UsxADN+XI3sVKrunl8v2CEArzyRXNS9NGDJ8jnhm8pukQwMST9kMvpeYe3rZZ
X-Gm-Gg: ASbGncu2PBuiNumnrBfLm6nBFbvJy6IoWiT3u0aAti37OO96pdvc3AE/3F4adi2kULT
	+aE6JX49aJyt60V5v6EMc4UWU3Ux1qvIhG6WszukLKnV4sM/cjGhxJBboN8gfdr1xjkYeSGKcvk
	Y541fqm/vcNVkAZR83wTbZDCIiZNhi+VMRLm1Y/zzNVQUWOFt3ZE27tan6c/WtzMImuai+yrtTO
	qyzc/KQvVVQM3v0CZ42QeuxwDkILgGAMH39LrU/254PrzZ015iQa4uPSaYLwRYO1NyRmRBvfzMf
	yB7kDXK0qNAXtN6xjzYAAsRE/XiV45XqsodVwAzm+CfAq/aoDQAewswdiI3H/hBWnIPWN2g1JmJ
	s3NhegYB/5tDHqHEy+7PE
X-Google-Smtp-Source: AGHT+IFoUNjDp3pBJLdlowBQ7RJOcMGZxwtyr73HjD5PKLDvrNQN0gQ5SeycG2FHVz3tzHAcP/cvfg==
X-Received: by 2002:a5d:584e:0:b0:3b6:17c0:f094 with SMTP id ffacd0b85a97d-3b7765ec9c3mr5346f8f.14.1753401108200;
        Thu, 24 Jul 2025 16:51:48 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcace8csm3473449f8f.54.2025.07.24.16.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:51:46 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.or,
	pabeni@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: Wait for bkg socat to start
Date: Thu, 24 Jul 2025 16:51:40 -0700
Message-ID: <20250724235140.2645885-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, UDP exchange is prone to failure when cmd attempt to send data
while socat in bkg is not ready. Since, the behavior is probabilistic, this
can result in flakiness for XDP tests. While testing
test_xdp_native_tx_mb() on netdevsim, a failure rate of around 1% in 500
500 iterations was observed.

Use wait_port_listen() to ensure that the bkg socat is started and ready to
receive before cmd start sending. With proposed changes, a re-run of the
same test passed 100% of time.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 887d662ad128..1dd8bf3bf6c9 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -13,7 +13,7 @@ from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr
 from lib.py import KsftFailEx, NetDrvEpEnv, EthtoolFamily, NlError
-from lib.py import bkg, cmd, rand_port
+from lib.py import bkg, cmd, rand_port, wait_port_listen
 from lib.py import ip, bpftool, defer
 
 
@@ -70,6 +70,7 @@ def _exchg_udp(cfg, port, test_string):
     tx_udp_cmd = f"echo -n {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
 
     with bkg(rx_udp_cmd, exit_wait=True) as nc:
+        wait_port_listen(port, proto="udp")
         cmd(tx_udp_cmd, host=cfg.remote, shell=True)
 
     return nc.stdout.strip()
@@ -310,6 +311,7 @@ def test_xdp_native_tx_mb(cfg):
     tx_udp = f"echo {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
 
     with bkg(rx_udp, host=cfg.remote, exit_wait=True) as rnc:
+        wait_port_listen(port, proto="udp", host=cfg.remote)
         cmd(tx_udp, host=cfg.remote, shell=True)
 
     stats = _get_stats(prog_info['maps']['map_xdp_stats'])
-- 
2.47.3


