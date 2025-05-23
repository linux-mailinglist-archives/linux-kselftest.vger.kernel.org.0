Return-Path: <linux-kselftest+bounces-33694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8DAC2C0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0A189CF0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9582222DB;
	Fri, 23 May 2025 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2lWaYOg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7B221715
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041542; cv=none; b=poYvy/DCDEsQHm8aSPiTQwl1TTWhW9Qt3VNRShFcDeT0seCJia216J51aWdYTQ7cmYr9G7H5q+HetjtPxUz2KW6pk1yr1+OCXi9MmI15qE5Gx14tjbRctIPL+S9YyQIVqYfti1/DcIriiCL+pYzRKVlaMOARkQUMm7aRySXXCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041542; c=relaxed/simple;
	bh=ldkQQKsDkGAhHJXZx571WMeCR3RMcX+z4Wvjc5zN2jE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TwjhPmUTYWpTH//v6yoNOkGqu0ve1XMQT/HBTJvMyG0N4yLAifDpLsZiO8Nq+J9dIdFa3VrQBU8xq1X6ZmTVfTy0/aUEV56Nbo1imNL9VC/6iRdJ9Ir3jVFrLLTnVaSg8k97MAn5p5G4pQteE/8PuMxYidkxeDWM1pX3rhkUtgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2lWaYOg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231e6e1d988so5960215ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041540; x=1748646340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFit4se3dsmsa9HWMx2TSuaow40Adh4DQRq38+N1c8s=;
        b=u2lWaYOgHBWCiq0wl9OU39MUFic1B98eONiguqSoOin8Z7JukLMe2piVpvaoOy4Rn/
         0pjxhG5axvb1o2fMVao6JAn/SAXyF8LQk4FgWICu465WNaTn/obZm+UTB9UK5foe2C0F
         HSaM/egLdHwuHAtaHvz6kt5Au2C3TuFQ7jCrS8ozkQ6JT79D1uQIYRjk4dN1LJsi7IAh
         IY69lPbTcmQ4ZfDMqYZOx9iFmHxPeRy4PNsQEhXxbWewgr4RiVkSm2knC8Qrrc0IJjEE
         o6Rl6yi8eR1LtUg2+C2VfhX9ESKxu9OWGbhRxOKe/GqvWfHoIbeytWRglnSsQfzHKoXJ
         MLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041540; x=1748646340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFit4se3dsmsa9HWMx2TSuaow40Adh4DQRq38+N1c8s=;
        b=fc18RN+B5uBjIYWwAWMO+9ypYKOaik08V3zn9oh+ymYDQT9CM67Bz/Zo0/dfWenavx
         kocUgCFMK2FW+C4jKybkW28ly/YsgvXdc9NgvDhz9QErxnfsvTjo/075C7EqTfSk0R4s
         ywBdEUM7H0yX2ARuwDVooKI7WJ2kPw40rfyYJZm2TIY40k2AuBWuOlYlm8AGoVM/883i
         HvROEbFLydHmU1CTSUlFHK5SYtLnJHneGiPw9SeK1uic9tVbIj4iFNkWUESToxeQjlYG
         xDL+4OK2Fg5PLRa4u6mfURbiUmVsqsbheHzOnsXDntNfq2gmms2WlWjSA/ukpgjNjnJ5
         FDTw==
X-Forwarded-Encrypted: i=1; AJvYcCXZQcHfHyNm0vtffDmT0yneLGXwPF3OY4EgcDuuU0wbFeBC0dmQIIMyTKYwOy3ER+iNn5OviiXuGPKSQAMOZek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbX4y7Gg0QGH4eC3StQWyb5NHtT95uQIIfEILbg0Z6DlKk0aX
	22fQ2TjwCXM4BTK+H8ZvVR7Lw6jffBjgfJxN3nHCMhKaBolk7uiCHn0B7lbV0KQNpOQByMCERF9
	+yIP4hbzjDYoh6kuoHlzEneqx7g==
X-Google-Smtp-Source: AGHT+IHVEbxlP+HY5bODAxLKx8PUqiPk9HlkasKey/MBvVDDURED0/am87bZ3OsPQT+WnaEFbk9KFBHAAnfm2vQgGQ==
X-Received: from plbjk15.prod.google.com ([2002:a17:903:330f:b0:233:fdae:780f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3d0e:b0:231:7f29:bda0 with SMTP id d9443c01a7336-23414fca909mr16630345ad.52.1748041540566;
 Fri, 23 May 2025 16:05:40 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:23 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-8-almasrymina@google.com>
Subject: [PATCH net-next v2 7/8] net: devmem: ksft: upgrade rx test to send 1K data
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

The current test just sends "hello\nworld" and verifies that is the
string received on the RX side. That is fine, but improve the test a bit
by sending 1K data. The test should be improved further to send more
data, but for now this should be a welcome improvement.

The test will send a repeating pattern of 0x01, 0x02, ... 0x06. The
ncdevmem `-v 7` flag will verify this pattern. ncdevmem will provide
useful debugging info when the test fails, such as the frags received
and verified fine, and which frag exactly failed, what was the expected
byte pattern, and what is the actual byte pattern received. All this
debug information will be useful when the test fails.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---
 tools/testing/selftests/drivers/net/hw/devmem.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 553ebf669a71..0484bda63886 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -24,13 +24,15 @@ def check_rx(cfg) -> None:
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr}"
+    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port},bind={cfg.remote_addr}:{port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr} -v 7"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port},bind={cfg.remote_addr}:{port}", host=cfg.remote, shell=True)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | \
+            head -c 1K | {socat}", host=cfg.remote, shell=True)
 
-    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
+    ksft_eq(ncdevmem.ret, 0)
 
 
 @ksft_disruptive
-- 
2.49.0.1151.ga128411c76-goog


