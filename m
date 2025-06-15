Return-Path: <linux-kselftest+bounces-35027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479EADA392
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D7118904E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jun 2025 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F717280CF8;
	Sun, 15 Jun 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drVlCNEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F825FA31
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Jun 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750019724; cv=none; b=ENT8jgkV51Us0K36AGvdUVbqoWQG4sU0qaU2j0ZfxGqH/6k9GFfDUqESKr7Gx/5MUfLDNEl4BEK3nxNLm5ePG+sr19zpufVl3y5oyF0nUf85LKWWl5E72+eaTZLx6O5OZ79wRFLxjbm84/JSB6QHApkw858e2VyzO3rUGIV7byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750019724; c=relaxed/simple;
	bh=eefalO3G4OiFpVeK1OhrV+zsNM6sg42ryjlzlayMM5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u/uJw98GywScgdOxhg1tA21QUtKVB7yQUbyt5PJaXibYCqL+LWYr/hxnfR2A1dshyFSAoPpe6hXuY3QwxJzeuUno7fTVVciKoMh8Nd/dVaC0Ziq4e00apC6n/PP4K3GiMHrpK3nSUbQKlJyENqreqkvKqXCx7k8bcWywQXmeI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drVlCNEw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso2347455a12.0
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Jun 2025 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750019722; x=1750624522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9bzv7JyOJ1NSTMXlUhkU8Ue0cotpcV0fiBdvuBI6fY=;
        b=drVlCNEwi+aYMU3RtEU8vAfLv9hy77IXNTlyCUuyTUC0Ud+f0agJHYSkNecNI440qo
         sv2EmLPzUkwBVAzgbU+O5FlwG+UR6QSgK6rZfVTBvObPSFWC7lDWyYKVtRfhv7i98vUx
         ZAOynYmeFYsBX8MpDm2GeqLICj92sMOKQWfliJjRn4JVi+SF4A9G6JgGUfEYt/7UmM/X
         kVlXG40zYaiSxQMUR6TryBH1L+5wkNWTO7u9sCTW03BA2ONxZHs5cQAyEY/HKHB0MQFn
         MSCu9iemzu8RH0cDC8vunU13AFIDYqW6zVILby2M3b8R3PJro2j38KeEO2VUhXOHUjKr
         wf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750019722; x=1750624522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9bzv7JyOJ1NSTMXlUhkU8Ue0cotpcV0fiBdvuBI6fY=;
        b=rYB9HvzhK9rRGkg38rGoApw6a1rM3ufK7dKFMz73wGNd8Sx0GrszvWfhLIrExx43gx
         bcTQkc29bmcVPir0o+xPnmA7adhIiw5N+yUjR5OLQelh9zSnV/OyFT/eqgUqAfrXVL4R
         tRjw744DR/rHxkLDG+4gxdv68D5dBa2L3KkmB3/gDurJmhIB84kNy4d/jUr53qvlvvYY
         0R8xotT3L7cXyR0i1mQOpYaxi/s3y69e97qKCqS7i0LSax+bUT+M5cY50mrKWOYLKMwe
         CNCSH6yEdjFaa07e5TQn8yBtWrhCRXmC1Aq23ijvgoZUR4vQQ9Jv48+n+o2bLD8Nol1u
         LS3A==
X-Forwarded-Encrypted: i=1; AJvYcCUgVVrCz178AfaBuTZuUg9u8Ou5XCUUEjkiXzjhJAZdtiA0p0EcNVDbS8prhQ2mRb6Ap4nhFjtuT5XzxDItV3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5w/avfz+RRTZt2Zaqzg42Q3Xzk2C76TMVo8EBwe+rn6PE3i1f
	hNJw6TvUVy3ce6h+ijh0T7AtEkIP9K6AzggF/G4W/BonSczNJ9SJ2i5qhl6kmOozIkegRp0lNAa
	d8CeF3oO0va3rxpPZ+VBs7qabXg==
X-Google-Smtp-Source: AGHT+IEt/qXb9jMNJY8IcGPlKUWlFpMJOPx3Fz4X3s17m2n9/LIeU/6tW+VwfxsFfR76tm79sgQHIjNEQ26ycUgA6A==
X-Received: from pfbhd18.prod.google.com ([2002:a05:6a00:6592:b0:747:adac:b0dd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6e4a:b0:21f:5409:32f4 with SMTP id adf61e73a8af0-21fbd50a6a9mr10345731637.8.1750019722372;
 Sun, 15 Jun 2025 13:35:22 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:35:11 +0000
In-Reply-To: <20250615203511.591438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250615203511.591438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250615203511.591438-3-almasrymina@google.com>
Subject: [PATCH net-next v2 3/3] selftests: devmem: add ipv4 support to chunks test
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>
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


