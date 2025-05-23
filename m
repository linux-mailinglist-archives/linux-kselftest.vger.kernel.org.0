Return-Path: <linux-kselftest+bounces-33691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F189AC2C00
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D38F7B7F60
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00522068A;
	Fri, 23 May 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfgZa8iZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30821D3DB
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041537; cv=none; b=VATMwDMRqCzV/hZB3hDTO1CzRc3rGQUCmBqjeaC9AZUR4A4R3P7cG6SMPYXGYkpef7LIwlwsFgv0CLfSbfKMib870fJkhMURuZ8muI1d/hySaTkiwXy7NNPRgq33VL4FnMhg2vFh61gGV2YgoVV1kx8E3EsMgpWwgpgY0s7GNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041537; c=relaxed/simple;
	bh=fIlnjHiVt66jMZHOXCtcWJq9iDhh9E2OfaIuTmFUKBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8gshP5sauc2EUqMjvEjQvmgFU4IeVEMoOOT9dS+PRBuvJ8nS5QB5Fdi2POgUtzMjdmII2fhedrgYGFqQedVmGpKbI6g5AvZeJAf+W8AKwo9Ip7v/MuXefbbkeGb+os8CldFtBSr/5G4kYE638jk1sNLhz6jkGCPpdI+SpIg+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfgZa8iZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26f30486f0so359369a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041535; x=1748646335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8sdft2buoZW74We3vtEkvC8v0SQ5B0W9UWiowkjja8=;
        b=vfgZa8iZcpw1VyNThOV6kro0eOHzte7hM6MvCpV0y5ua3l7Oq0zeCnx8XW2eTlJyZW
         WcAqy0CuTKLE5ZK91l01NtRd3IO7CujKfR2Jx43XgCy7xYRxhQOuzzXL7dIGbnTLGAtN
         7t8D3tHgcOI7g5ADAthwTqd91JY/B0QZNIVCHgrTPbBy6tNuavzeEiyyPD99ylulG7rU
         SqmdSEJ0nggzjLongXQ+3PdP6Y8a9kjd3EGphFFF8ZlbHULykEnfd/yegy38rmR82lcn
         j6rT1WF426ba5sIL/5XJ6RejziwlbnwgeCJ1VxDtlEooxPAu6E1v/v3l5TCUFZQ70pCk
         9BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041535; x=1748646335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8sdft2buoZW74We3vtEkvC8v0SQ5B0W9UWiowkjja8=;
        b=W3e8aFkEjTUjf4pA5frocvzO6SwCqY+Ljfd6AJ0jUaxqcve4c3g6/FxYdaZtTyk/jw
         yvaHsiNJ13Ojv3Y86xsfVXUAgGvCJkR04dgcc9opgoa7/MhtNE383ILwD5joVYDNFzZ2
         o7QKwP3knM0gY25ncO849r1M1LORcAlO8+JeZvmcezu6BfEhPUb4SeHNSuGZv+jOTQWL
         LSMhQIj+CSMTsZjVv2KO/XGshAO2MN6/VCi2kLDxdPJH9+VkEvA9zym9ExZu5gs1Z/Hf
         TkQDpNiPzIC5k/09Fx/cgBC6syo669w+IEhHZ7KOvpnTVSPrvfwD6IoLzHGnIm+F+tdy
         dWqA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtuxDVGOg4jhTfiFZGcM8VWVhoeEYvALrYnUWYOk6OuHmyylr4GCxzEmrcYwyUS+vMAl2r4DtPEsrXSvHKcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oeXALMXAuctlTUzTUCRx+muGK2vDxmcC0NegF6w2qhf7NIo8
	MSrnkNgaI/VRVXPxmHzVTjdpRmhGv3YTIJGBlFha/pdVLk1zWUfVRo3MkYtKVjZZ//NPiSpQ/Pi
	lcIl7+tfzzUPBrBMphv2ETMAb/w==
X-Google-Smtp-Source: AGHT+IFJs+ZhchzXRGJVcyEK6P/BPOUVSXu7jFxFlu1YtOZP4EdE+NQsj52iCebn4YmWRq4ge9eEJOy4WdeS3R2Oeg==
X-Received: from pldt12.prod.google.com ([2002:a17:903:40cc:b0:220:d668:ff81])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:acf:b0:22f:9f6a:7cf with SMTP id d9443c01a7336-2341500d143mr15462135ad.52.1748041535501;
 Fri, 23 May 2025 16:05:35 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:20 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-5-almasrymina@google.com>
Subject: [PATCH net-next v2 4/8] net: devmem: ksft: add ipv4 support
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

v2:
- Use cfg.addr and cfg.remote_addr instead of doing ipv4 and ipv6
  special handling (Jakub)
---
 tools/testing/selftests/drivers/net/hw/devmem.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 7fc686cf47a2..9b3e2c78f457 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -21,30 +21,28 @@ def require_devmem(cfg):
 
 @ksft_disruptive
 def check_rx(cfg) -> None:
-    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port}"
 
-    with bkg(listen_cmd) as socat:
+    with bkg(listen_cmd) as ncdevmem:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v['6']}]:{port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port}", host=cfg.remote, shell=True)
 
-    ksft_eq(socat.stdout.strip(), "hello\nworld")
+    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
 
 
 @ksft_disruptive
 def check_tx(cfg) -> None:
-    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+    listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd, exit_wait=True) as socat:
+    with bkg(listen_cmd) as socat:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port}", host=cfg.remote, shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
-- 
2.49.0.1151.ga128411c76-goog


