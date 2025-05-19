Return-Path: <linux-kselftest+bounces-33299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32215ABB34C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 04:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6720A7A99B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137C1F0E25;
	Mon, 19 May 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDGl+NRr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DC1E9B04
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622131; cv=none; b=MfHKeeKTHlNCG1P6Fq737CFw9funqoRpsUfEZHaGJRJvQCCe3OOmkDLVjIuyCjcYJnAUw0hJQD3wA+yTZfUOL1TpTNf+2bpNUIawl3COGUCp7+fKYt5vSaCg0JMt8QRhHjRzqIO9XgbhYVbK2dpqAy23d7jrTroy/ytiB3ZLJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622131; c=relaxed/simple;
	bh=6BzkwJjhMHJehkP1jcxnKavLT353dEzPvceqQkvdIdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g9lgCwFVCIoKW8Pc1EA12sDGNOSd/MraOjW414eXIRyvXA1q8lf7HLIfZZ2glHsPh5qwmoVMNxNDjadyf1ewc0bMt7BYSSUUSfF1KfK926VBqxKDqmlcQlG3J+8OTtHhR05x0hv9M5K+BG4uZsNZmxNZD89tLKinH5/nnguE9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QDGl+NRr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so4241236a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 18 May 2025 19:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622129; x=1748226929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/XD8ih8Lun8Jh7EfzFjhzSFOYTw1eL+7WAd/almRX4=;
        b=QDGl+NRrbuUSq0Ra6x1FhkqyPgu/s6MHlJDmXEkfk/MazRLHnjk8axxB9ye9uoO3hE
         7k7sAFdgzWU28F6WJlj+oEzN2o6pXpDc52DtkxpiJld3ZRpt0ip4dsRRnOshnZCxwdeV
         YUpK/taED9GwtwTtHlz4slqTbSYxMOgXMZhaOiBxwruqYLvG7WHmTpdPIsmOLwfAMZ3d
         GBQ2qz3fUNwPrBexYBRJn8joaHgnj8ikqjqBaJNx2DvFsH6qKipjNH9v6UsRQaka5ce5
         E2XayMsmHRwYg/gf1gOeFH2epo0VGzxMTFrRi2mupXYWc9U8oFSvYzZih0tlG45vTKXQ
         Qg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622129; x=1748226929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/XD8ih8Lun8Jh7EfzFjhzSFOYTw1eL+7WAd/almRX4=;
        b=uXvpQAmywk26D5fcMpuuOwDZC/N+K8XD5Zbrq3eNRJaVED6C0WrRBnNPqLRqOebGc8
         ckls/psiFRxnrfRQgBhCWdeAkSgN6EYektFRXnZGR6/lPzDU87gzEZ/RzTHi7joSW+95
         Nu1Rv+VusGfJvWvOPMOPSGyd2zCdi0ij5m4PWeFi7Nmd7YPlv7sk5mYR2au8K4zyeJQ8
         j4Y8vomrdGlxO3lGtGQp2qRO1Sxd0Kg9mO885imPw7EJva1GImp0anTie6SCaeQ76XVh
         7jWK60i10wXnkZ+CzGekNhOGWjKT9MX1LBiuU1zw8k5pqSNmfFwLpe2XuNS3fFEIa51E
         Ya0A==
X-Forwarded-Encrypted: i=1; AJvYcCUH9+59vJYRQByCDywZH2/B86mof+Xfh3z1uzdmtN6VFtkkfCm3NG9aqyXrmGjoAOpZusmc6iPqg5vRcmDH2Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Ele62Qa/Ojc7r0/kdPz85JlWQmkhlr3H6tFeqEslxddhTC3m
	AKJP/sVrQSiFNdQ446hBGZICpLhcWKL2raWpYiPyTtlzTZTDPSDDuAQeQz2+KCLHzIDQ2ecUUuZ
	f3lK1aWs20YTjLDAV4TMU2mmkLg==
X-Google-Smtp-Source: AGHT+IFayzQr6wJvEJqbgF2FAgyUkn6R53b1/7hz6ZHfYbnuHXWd9Bie02qYj6Dj1rPQWiCAL28/w/PqK+HGxqMS7g==
X-Received: from pfbiv22.prod.google.com ([2002:a05:6a00:66d6:b0:740:b061:1007])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d1f:b0:215:dfee:bb6a with SMTP id adf61e73a8af0-2170cde517bmr13396545637.28.1747622128931;
 Sun, 18 May 2025 19:35:28 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:13 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-6-almasrymina@google.com>
Subject: [PATCH net-next v1 5/9] net: devmem: ksft: add ipv4 support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

ncdevmem supports both ipv4 and ipv6, but the ksft is currently
ipv6-only. Propagate the ipv4 support to the ksft, so that folks that
are limited to these networks can also test.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 .../selftests/drivers/net/hw/devmem.py        | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index f5d7809400ea..850381e14d9e 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -18,30 +18,36 @@ def require_devmem(cfg):
         raise KsftSkipEx("Test requires devmem support")
 
 
-def check_rx(cfg) -> None:
-    cfg.require_ipver("6")
+def check_rx(cfg, ipver) -> None:
     require_devmem(cfg)
 
+    addr = cfg.addr_v[ipver]
+    if ipver == "6":
+        addr = "[" + addr + "]"
+
+    socat = f"socat -u - TCP{ipver}:{addr}:{port}"
+
     port = rand_port()
     listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
 
-    with bkg(listen_cmd) as socat:
+    with bkg(listen_cmd) as ncdevmem:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v['6']}]:{port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| {socat}", host=cfg.remote, shell=True)
 
-    ksft_eq(socat.stdout.strip(), "hello\nworld")
+    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
 
 
-def check_tx(cfg) -> None:
-    cfg.require_ipver("6")
+def check_tx(cfg, ipver) -> None:
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+    listen_cmd = f"socat -U - TCP{ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd, exit_wait=True) as socat:
+    addr = cfg.addr_v[ipver]
+
+    with bkg(listen_cmd) as socat:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {addr} -p {port}", host=cfg.remote, shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
@@ -51,8 +57,13 @@ def main() -> None:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/ncdevmem")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
+        if "4" in cfg.addr_v:
+            ipver = "4"
+        else:
+            ipver = "6"
+
         ksft_run([check_rx, check_tx],
-                 args=(cfg, ))
+                 args=(cfg, ipver))
     ksft_exit()
 
 
-- 
2.49.0.1101.gccaa498523-goog


