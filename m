Return-Path: <linux-kselftest+bounces-33301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE7ABB354
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 04:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B5F3B4076
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 02:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47062080C1;
	Mon, 19 May 2025 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQUVFN4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFB1F5828
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622134; cv=none; b=igKK8+2QArvnquyKG4NZ9Hmj4soiPf/6m7qtekdrpP+cwCr7UADzIKBmuAy79+YwTmbgJ2mF5Q86XrjLLwW0SaCgEzL+Z2fWoIa17VKGsNmkh09gaN6C/+pmb3850vk9QBPgMnS7avE7DZ8VDJFWQyjAbhR8+GE5BBDB5WE6O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622134; c=relaxed/simple;
	bh=lXhPuDqZ8lFiqJJEDrc+fi8w2H175fq+dRDihzDr1bM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxlDz5++Hnh26JQs9+sQqrP9rQhOTCcdYaqVKFW0ajRF4cc74VcLn6b1MkMx2yZkwCbdgRT6+MdriO9Gjf4AhCQR+cTj9gmMJtKAs/c5mF0CjexY5i+sQBA3X/o4P+H9WiaPy6QF+vVdQJ1ZTpjljMhDc9tGsDrzDqVE1Uo2Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQUVFN4K; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740270e168aso3414136b3a.1
        for <linux-kselftest@vger.kernel.org>; Sun, 18 May 2025 19:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622132; x=1748226932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6AvReAJLKB2KWx4p7QNdhXPE+oF5Pp4I3dIzKrTOjY=;
        b=YQUVFN4K9FtwrdqaVkZcfeEOuiXBuM8F3imqbqDtx6xkpeHDfDr3CbRkD+m9Lu/y3Z
         yyXJZYGfrgroFEyHREsXvcOfkuFkHRlSUHCLnzAUVBmX8L+BMBrCiEK5YC3Uv3BthgUu
         zx2HMwhnKdkWWJsJ/XQ07ZnwOkGLZ8XzmZCnZ6zRZgIJGllxedrmRxB9XSvuGp/R1nBn
         FREGOqoLlKGDBDwjVIjXuGqcxvpGrmEkMr7uLKAze0ImSRmh2E2BHjUJjp4lp3NqQMcC
         emaL7hdJ/qGQVzsTBO/8rhaW1PdSE7ybKgaogD3We8LgRSPWzSY61Q4b65p55CuDZDp7
         uNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622132; x=1748226932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6AvReAJLKB2KWx4p7QNdhXPE+oF5Pp4I3dIzKrTOjY=;
        b=eZMApeRMqvfYj609khcKiuEw/qGlURyz0vdtu7hWX9vjbtcm/pyi2NhQ8nYnDqPG30
         iD+8EVoqrqEKbdUFwQLQI7JGOEcMYw+oavg8vgamBJIUgSS+iOo3giGo4Uc0EYUbDWcn
         evlXwvu6GHuT4ap52tPyi93DhygoY6EMwmf5lRc7JC90W9devjaUhWNLrMWaRNob3ys7
         plMMC8GPmOtgUZ5fVEX5847ZolD5pBlaM3TER27eKq3m6vBRBtX7Ityabim+2TYq2Dpw
         s0zl0h+s9qBnzdryi/aG4fDFnoPQyX2eU1Rz/1a29EwRXwafB5fJWP/4WXU0snQ0xL/X
         j5gw==
X-Forwarded-Encrypted: i=1; AJvYcCX0IzeWuVQEBfuANkpZt8frChQUYDCdum+FgUt1CZ6A4l9+gXA34EtyOxFr5F6SmQQt9fTieNuQwxXbWWoVDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLbycPO9ftTOL5g16sPVbyNb30p8Z97Mw0Bv2vKZjrEKRWewM
	4mU9XTVnKtUeR1axne+N5aa52zBRSlDH6dCYlEedXfG0BXYT61QeVzRKl2tKzPn6QAc7bosyt7k
	LrrMBZFPHuNO6UO+K2TQUuPNY2w==
X-Google-Smtp-Source: AGHT+IHeYzRMmOkX7+lsgG9BfNqeH5NnQHkDsXjIYRGrh345Z62LvP2j6VviMlp6xHOXPHOb4h2WAzbno9NKL1vt+Q==
X-Received: from pfblw5.prod.google.com ([2002:a05:6a00:7505:b0:732:2279:bc82])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9186:b0:742:4770:bfbb with SMTP id d2e1a72fcca58-742a98a3213mr15212907b3a.18.1747622132372;
 Sun, 18 May 2025 19:35:32 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:15 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-8-almasrymina@google.com>
Subject: [PATCH net-next v1 7/9] net: devmem: ksft: add 5 tuple FS support
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

ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
FS support, but the ksft is currently 3-tuple only. Support drivers that
have 5-tuple FS supported by adding a ksft arg.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 .../testing/selftests/drivers/net/hw/devmem.py  | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 39b5241463aa..40fe5b525d51 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -21,14 +21,27 @@ def require_devmem(cfg):
 def check_rx(cfg, ipver) -> None:
     require_devmem(cfg)
 
+    fs_5_tuple = False
+    if "FLOW_STEERING_5_TUPLE" in cfg.env:
+        fs_5_tuple = cfg.env["FLOW_STEERING_5_TUPLE"]
+
     addr = cfg.addr_v[ipver]
+    remote_addr = cfg.remote_addr_v[ipver]
+    port = rand_port()
+
     if ipver == "6":
         addr = "[" + addr + "]"
+        remote_addr = "[" + remote_addr + "]"
 
     socat = f"socat -u - TCP{ipver}:{addr}:{port}"
 
-    port = rand_port()
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
+    if fs_5_tuple:
+        socat += f",bind={remote_addr}:{port}"
+
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {addr} -p {port}"
+
+    if fs_5_tuple:
+        listen_cmd += f" -c {remote_addr}"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
-- 
2.49.0.1101.gccaa498523-goog


