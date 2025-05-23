Return-Path: <linux-kselftest+bounces-33693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B6AC2C04
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C10B4A8434
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022D221571;
	Fri, 23 May 2025 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kp46d2K5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55195220F3F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041540; cv=none; b=qsretpapGk1rrFhy7iAoQPJxbE81dbPhgiLk5vjyC0y23XTSd7hQANRj5A6N4pog/0GGgh1euulibzVBuhidme6K+HrOhcPoA2gw6y32cDKxm5+p2GCbGZ5Nk2gDHbo7xObUoKNsz4qcSTLVd3RfnObkL9tpmWIkJhMZdP35LHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041540; c=relaxed/simple;
	bh=PGtt9R/6JfJeszrvD0Vt1f7tbDi7oeGP/GPYQOO0a24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+zYwaPmTesRNaZvDQF482bLaZBeI9OhvJNrSaveOcn0Bj46BG0cUp15eV6yLMS4dEzLzi20xmwDKcd4qO6Wtl5k5xnzoDTHgDzkiK17MxdSmerBvLC24pcpMou7XbpVmXFNMpCERmIFw1K4zHAsBry5QVJ4ujurTfJqp7bghG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kp46d2K5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231d0c0fdedso2178465ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041539; x=1748646339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2RRh+/pmMlr+/9c1WquG879UR6TlmrH7OSbqN+4ntc=;
        b=kp46d2K5MO/6fpHTzUqPey1AgIt7Nlto1zldFf2T08vuHrjrNFWWNqFxqrrXqT9QG+
         GBPcQARoJShygE0crgOUndm/vEyPMnGwe36bHgs/eqqzN2HvT4T5REmNUjxxu7cjjarv
         Lm4vwpKa/Rz68TZokH4aiglAHizxOnycL51jP26yXybr1YEh3PkU/JyNSCu2rInYzjIZ
         q2nfT4WXVFJZ8NUmt7E83Zy3KVHb6EcpHNZAe6OQpLcT05srzK1SlUqD8EI4JGMOAXj/
         FBjy+0m85wX6KWKN8L4B9seIu6wJg417qtG6Nr/OKrnDCbGLhPjiaEC7B5AphVQ4oHTt
         ckkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041539; x=1748646339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2RRh+/pmMlr+/9c1WquG879UR6TlmrH7OSbqN+4ntc=;
        b=FArPX0VAnwvOPtnADBLDKJ8ormMmBaqo+nLzMWazsM1I8IDSdf6N8abglrNJGa0LrQ
         p88Bjp2MVxqhcCqiQ3hDT2gTzHa4tfFa/FR9gBoxX/SdyNs0swci3P8nENaFRN1gdSGL
         3vXld6WsNniZmsZOGL3TJi9+QkxLx4r25n2oeqIxRqkPQyEGv7dIlGn8ShyFzdUUWzB4
         vQNRxzDTMnwohMpjIt3sn5HNBauHAgfaEckBno8i+poJS6Umlip+IJEy/7x6XbQ/DP03
         tKT2hNwsfiasDgpZpeiYQmFfk5+aHD0a402XFN6C0e0/WtF0TeOCH9ebeDspLcx988dY
         XBFw==
X-Forwarded-Encrypted: i=1; AJvYcCUeJkZViIO4SrDrIkjTO4ZfnGX2kGKKu/qNERqUnRCh1seIC4P44mfcBZglCwqTnae+T6swIeorOvDO/0GK27U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2F27XSqCK2DK7tDMkfT3tXX+87+Gjoa9lO4o9XRT4zCAM9fm+
	JLsvf2QWxJGX8Aqz4WOhom2PsnY84xVdUv6DXzbZH0Wtgd6aGwoLvVuxQnL0gbcD2Dpam2k1I7y
	R6H9iDREnpHfsdBOWDoW6m/Iprg==
X-Google-Smtp-Source: AGHT+IHVsH+9q9leeBNnpPJqS1fD8D2RsLmkgZl1oWqFMbkXUFg3g4wWlhT0WJZW0fnCAI5MdSjgKwrRZzAv4AbXjA==
X-Received: from plhk15.prod.google.com ([2002:a17:902:d58f:b0:22e:1633:9684])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:228d:b0:224:1157:6d26 with SMTP id d9443c01a7336-23414f3a8d9mr19684705ad.4.1748041538874;
 Fri, 23 May 2025 16:05:38 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:22 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-7-almasrymina@google.com>
Subject: [PATCH net-next v2 6/8] net: devmem: ksft: add 5 tuple FS support
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


fix 5-tuple


fix 5-tuple

---
 tools/testing/selftests/drivers/net/hw/devmem.py  |  4 ++--
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 6effb9e33fd8..553ebf669a71 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -24,11 +24,11 @@ def check_rx(cfg) -> None:
     require_devmem(cfg)
 
     port = rand_port()
-    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port}"
+    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr} -p {port} -c {cfg.remote_addr}"
 
     with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port}", host=cfg.remote, shell=True)
+        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port},bind={cfg.remote_addr}:{port}", host=cfg.remote, shell=True)
 
     ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
 
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index ca723722a810..3c7529de8d48 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -370,7 +370,8 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 		server_addr = strrchr(server_addr, ':') + 1;
 	}
 
-	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+	/* Try configure 5-tuple */
+	if (run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
 			   ifname,
 			   type,
 			   client_ip ? "src-ip" : "",
@@ -378,7 +379,17 @@ static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 			   server_addr,
 			   client_ip ? "src-port" : "",
 			   client_ip ? port : "",
-			   port, start_queue);
+			   port, start_queue))
+		/* If that fails, try configure 3-tuple */
+		if (run_command("sudo ethtool -N %s flow-type %s dst-ip %s dst-port %s queue %d >&2",
+				ifname,
+				type,
+				server_addr,
+				port, start_queue))
+			/* If that fails, return error */
+			return -1;
+
+	return 0;
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
-- 
2.49.0.1151.ga128411c76-goog


