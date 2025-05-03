Return-Path: <linux-kselftest+bounces-32270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84280AA7DED
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74A01B65C08
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87570838;
	Sat,  3 May 2025 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0heVtPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C48134AC;
	Sat,  3 May 2025 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236139; cv=none; b=sQ74qzl/jYck/0DL3QH2+LJKs+xwhNN/euER8MLpgMhPT4m3ib8grlr51Qs/3XMut7UJtJdfZaOyFSobpHWeAWejDJ4abGyT4MZ6xKoPocdYgQ5Lzlk3TJN+U5eVlRBny3yqM3PwfUkIVVboe4hS4p0/rMPtlhHa8UMA687KKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236139; c=relaxed/simple;
	bh=K167g7fRemdb/WjUQxfGyL4vXoA+rt1mXfrmOgKxWGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxWeWoYs3hcUbFupJYWhud5tkSyAdcU0cpKysedbpom9t3a/eeb+onPKleR8uXOM3KbV8rr28Hgqk8HtwrY7ekY7ohZFfFdn9AtZBvdzTTFZrmod8wQjrMUFnYRNyY0/mIO5ZPxUA4KgZfDdfJTUK1CkUhszKc4anBvP7GW9ZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0heVtPP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1794439f8f.0;
        Fri, 02 May 2025 18:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746236135; x=1746840935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj7Tv0PMAv5wN2mQctk8ok8E4ZG10HhCwkVt+fUKixg=;
        b=l0heVtPPgQV+yxrQgCR6M8GYHW52pknDXz07m+XbkyV4OiK7UXLgKUbo57pUpHcuDJ
         QIxJrp614+t5Hl/DaJsebaN65lA2Nyv3aZMZnqBT+jdy7dvX+08BoEzfVW2/+zMNJ1BJ
         9qzHPrQn0jUL5MKUnA2aHpXe2mhhSRFb8kYtZIYIveb/A5/7niG/ryNYyS4tRM/4B7Zg
         SK4tFG1Z1nzHcds+qQ5AqOxlvICpGLaQFBJ2WSbA0KskUKbAsZ/EQoUW+whGew5lguQ8
         yA9jJdcfhZ+xPGhNNHki7cky9mf9tOEhqYNk8lYcQyFO7oxziAmeEMRdyLZ3x+jstw9H
         YgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746236135; x=1746840935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj7Tv0PMAv5wN2mQctk8ok8E4ZG10HhCwkVt+fUKixg=;
        b=Z8KtlzFeNdnLr63vRik9Y5N5xECHmzTY9J2afLhMH40SWig6XmxO8H7aoQqeontUpr
         az3VOBXisM3xs5FIuaIe4vsy8swRzhYrdrINMkr4gl1tPpKSG6M7rrOnLEpQSEAuRNwl
         kqhUwfCNg64skovxmO4P1GHPLhDKhP0/vOFuIFh0+jqrA5G7sJBoxVHxZRETfyvJdOEr
         pAz2RHu6RoJ+qo5DbP4boN8ZAa1JwGZ8Jhhn8V+4BQqFZZnvvaR7K1V7Q0ZOab+3JsnU
         BOpYRlrR6teo8hIfcMJR8mamfJF0d29sgROv+XPBcT6UaQOFLH455E5A9bLcUHbazpPe
         yDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ps5TBqXBR1Y24GwrrG3ghPnJ1LmG59bOSXd3mfmMweUETua+5RffDVPQ38+xR5Gj8xkOOrXQHbKS2rcwyx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFw0Yn86CV7f8YKtBsprxzPFJeKaXkw3penbU6YPGuL60HmrI
	0NBJtoI0f/oWFMsUoMIX02JUP91Y9QhJfHPQlnSN3QnKri/NgJtqwQakPoAY
X-Gm-Gg: ASbGnct+7vmwm5dJ9VWVyXfwmZszkiAUVS8c4Y9OxZdtvEPMYqk39ZrS5+bolC/kdTK
	76m3BK6ZQyG6D6uZIhTOM76A4h/DyS3OVbot2Wsh/lTcL6r2S9TOT3EbCLE5b7N6OCpnigztkdV
	ijkIhjWhKWbDEndkFzGSg1FMrITaOEoIGDJ4o6ngWmBIiU4sItSO6O4t8fN2vO/ltdqhSp1gKTB
	8r/x2+gI+7EtJuu6D043JhChnXYU2S9V3M0S2XVLi3kmEsmKLZmdX7d6BWeEp3z28CluNS4aCtb
	wlY9dcylbfk/TNlzq0dw6QeIPp6vDGIki9ypw6AL05DIHo4g
X-Google-Smtp-Source: AGHT+IH4gwCCZ6L77cFPD83z/oLaEFSZBiISpUZp1xuE+vCdGzJee8S0L9fpNB6GCgxypDTBHc7xzA==
X-Received: by 2002:a05:6000:1cca:b0:3a0:7d82:d454 with SMTP id ffacd0b85a97d-3a09ceb0099mr697383f8f.20.1746236135348;
        Fri, 02 May 2025 18:35:35 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b2449dsm3441410f8f.101.2025.05.02.18.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 18:35:33 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/3] selftests: drv: net: add version indicator
Date: Fri,  2 May 2025 18:35:18 -0700
Message-ID: <20250503013518.1722913-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the test result does not differentiate between the cases when
either one of the address families are configured or if both the address
families are configured. Ideally, the result should report if a
particular case was skipped.

./drivers/net/ping.py
TAP version 13
1..7
ok 1 ping.test_default_v4 # SKIP Test requires IPv4 connectivity
ok 2 ping.test_default_v6
ok 3 ping.test_xdp_generic_sb
ok 4 ping.test_xdp_generic_mb
ok 5 ping.test_xdp_native_sb
ok 6 ping.test_xdp_native_mb
ok 7 ping.test_xdp_offload # SKIP device does not support offloaded XDP
Totals: pass:5 fail:0 xfail:0 xpass:0 skip:2 error:0

Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/ping.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index 16b7d3ab0fc8..af8df2313a3b 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -136,13 +136,23 @@ def set_interface_init(cfg) -> None:
     cmd(f"ip link set dev {cfg.ifname} xdpoffload off", shell=True)
     cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
 
-def test_default(cfg, netnl) -> None:
+def test_default_v4(cfg, netnl) -> None:
+    cfg.require_ipver("4")
+
     _set_offload_checksum(cfg, netnl, "off")
     _test_v4(cfg)
-    _test_v6(cfg)
     _test_tcp(cfg)
     _set_offload_checksum(cfg, netnl, "on")
     _test_v4(cfg)
+    _test_tcp(cfg)
+
+def test_default_v6(cfg, netnl) -> None:
+    cfg.require_ipver("6")
+
+    _set_offload_checksum(cfg, netnl, "off")
+    _test_v6(cfg)
+    _test_tcp(cfg)
+    _set_offload_checksum(cfg, netnl, "on")
     _test_v6(cfg)
     _test_tcp(cfg)
 
@@ -200,7 +210,8 @@ def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         get_interface_info(cfg)
         set_interface_init(cfg)
-        ksft_run([test_default,
+        ksft_run([test_default_v4,
+                  test_default_v6,
                   test_xdp_generic_sb,
                   test_xdp_generic_mb,
                   test_xdp_native_sb,
-- 
2.47.1


