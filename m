Return-Path: <linux-kselftest+bounces-34865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55ABAD8224
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 06:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF561188289A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 04:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A0253950;
	Fri, 13 Jun 2025 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuKtBDOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E242550CF
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749788910; cv=none; b=glaesZN2lI7x5pAMOYy+4kHm9iKWCOnWzzBc0msYNZDy3C3RFChWP60MS2rolUXzEnanulKzTxoOJd13mFXSEnkcpuzdMBcw97TCM+v6AroQJWEiweWYMNJqjvXwu9XVeHjJ1dForuA2uSYEufjIsCaVgvURFfyI7/8nzWOLt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749788910; c=relaxed/simple;
	bh=eefalO3G4OiFpVeK1OhrV+zsNM6sg42ryjlzlayMM5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O675Wc7HlTV/aYycWqr4M855j7fUsVbYkhcKzH6/jxKP00p/YCL3GWRV+vFGgXZknBJGXVspgzTI/Qm+r+2rBztzj1gNKGIScRLPE17dXD2WZrNSYtubh/IZGop/ONaUmkyqCJdZq4ubOYJPZQA2Q9r50WK0V14SdZ4vlf08JW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NuKtBDOY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2365ab89b52so6764905ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749788908; x=1750393708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9bzv7JyOJ1NSTMXlUhkU8Ue0cotpcV0fiBdvuBI6fY=;
        b=NuKtBDOYTjop8FTHFACc437r+PE4t2BQ9n6g1Gtj9DrpMluAOEjBXjxdCeuOEETBoh
         LrWZcAn6bIMhii7sufajVxq/28UAyiyQlkmlRHinZigte+3ddr4kBgLOb5hah/8p+wq1
         M9kMv5RMNEyzjNJcYwElEVoVLsPepVOj/6o1hiUWOEbcxH0D8+s8lhimyLs2ZpoqsjSZ
         bMy0cO/jzO49MmBkuN33aO6J44/tXbZM8r3Tj1jSYfvuCxGgZmaleRE5/nnADo/MisZn
         o/3LY8/sFBk/PMgX5setvXlOYQiVBtJfThooDfuL8bVGn8kumGo2mbgGkfpNSdqX4/ck
         1jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749788908; x=1750393708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9bzv7JyOJ1NSTMXlUhkU8Ue0cotpcV0fiBdvuBI6fY=;
        b=VC5/9cHAxyhjz7kTKuxvp89yCMFHpvcxapyp0963lF3FjpdICRx8X50IdNQ4hRGDwM
         eofNDarjAEhLwBAyYgrjNT5z6c0ETX4HQh86/lLvprgKny1nXQkolQsIR5RdfIF0C+RR
         iE4IQQvN9FxX46B/86/lQ9ottF/nFlpX0oXT1S0/1HpZcqrYEv1oXl0tuwR+CKOGorey
         BGWedzjd3TRXZpPSODH9WNAI/JcsAE1byFsr7TF/f/oZB790Cd7ybM0HF8TKxrewXL7A
         6JYJgin3MBRwEG8m07I4Btfv0yVnlCgH/MPoFvf1ullhjn6nxpCFUHGNeFTUYgsIverH
         wqSg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Z+iv/R87oAoTRkiDqz3DrYonJ3ySffo10XkaRYueBdjyfHxYRq1wFPLd/XCXGn4j40XOja0filXSHlcsf2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymovq0ZjX3h3vitOcMS1UB25BlzO46j3gdDSidHyPZu4RQ7dCG
	b1dm4vbnqxfdjXmth+dOgPUBFYKRA+dpq24gprzg/N8ox4Vf17w0sesYD7UU6WR5ZOG+12XQkaz
	uB51bY7myBR9puR3hVeH7ypKj3w==
X-Google-Smtp-Source: AGHT+IGyyz5hzVb+Gw9DlZKIpJVnCKZ5FRSxqKvtgVQiBYZmdgGwtr/P2z6jskIGb13atSDb8novtGRRWQRJiJKEsQ==
X-Received: from plbbg3.prod.google.com ([2002:a17:902:8e83:b0:235:13ac:d4ee])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cec3:b0:234:a992:96d9 with SMTP id d9443c01a7336-2365d8a1688mr20356755ad.17.1749788907997;
 Thu, 12 Jun 2025 21:28:27 -0700 (PDT)
Date: Fri, 13 Jun 2025 04:28:04 +0000
In-Reply-To: <20250613042804.3259045-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613042804.3259045-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613042804.3259045-4-almasrymina@google.com>
Subject: [PATCH net-next v1 4/4] selftests: devmem: add ipv4 support to chunks test
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add ipv4 support to the recently added chunks tests, which was added as
ipv6 only.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 tools/testing/selftests/drivers/net/hw/devmem.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 7947650210a0..baa2f24240ba 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -51,15 +51,14 @@ def check_tx(cfg) -> None:
 
 @ksft_disruptive
 def check_tx_chunks(cfg) -> None:
-    cfg.require_ipver("6")
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"socat -U - TCP6-LISTEN:{port}"
+    listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
     with bkg(listen_cmd, exit_wait=True) as socat:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port} -z 3", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port} -z 3", host=cfg.remote, shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


