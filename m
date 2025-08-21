Return-Path: <linux-kselftest+bounces-39421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F68B2EAD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 03:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C097A6449
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34910248F58;
	Thu, 21 Aug 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZWawssi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B024466C;
	Thu, 21 Aug 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740428; cv=none; b=ojlDNpd8zXkXA5AgxQdQa+8F0iLLdR6DlIKu0qnlIUOU4LPnuzrweEIxSKDEOBuLMnTrBzxMuBNWnmKy4dKhro1jTvrz76DVxp9n6H+MIKsbVBiB+hXfMceeoIjB0aXjndPmwmq//udcZle00vqaJVgJ2DPgn7bxwfNyc/g7CkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740428; c=relaxed/simple;
	bh=GHNwKEw1yjbzxiAKCI3k7prX27zl5VullgWv+UjZO8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhByUi97sUA5sJmwVNhtE87EvcUAtodTj4dqHRjPWU7/PBZN34/XU2bhwHL3fXO5ghYYYW+JKZ6gQdPbbPpcxIIVoD75AD36AdVSOgW6FN4aTCfjBFQvtkQww279srHQv+bpYY3AvqVFtv9Hxb5Pt3nWJNwQNbeAUOGAPH3dFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZWawssi; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381e0a227so305016a34.0;
        Wed, 20 Aug 2025 18:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755740425; x=1756345225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATlUyc/yVrz9SFl40s76YJ9pVhEaYN1JhkZsZuAHo0I=;
        b=MZWawssixT/6/pw3CSufT8rqN09eWV/7i5y687FFlucgLSu7JPV5OWCT79ZTqtIGii
         XkC/06zzymoILyguSHFcisakFjUGC0xwe2EBK9VJ9/mj+2X3mfou6XY4h6OPIqRzk6hB
         htW/KXjnwu7kCLyHqTXWX0wCUW+fN/YzwyLqx8syOF4pr5kYb3EZw7Q/JEG4w7i1DOBZ
         oImEO1zXvj/9ys0sQl/ZWk6eQY9B17fAluTIzICDw2HPJGtsq821wFLWzJ2adQelXzFL
         v8u7yPPsBK3texH/RNXNIlCyOGcYq3IE61LEV9UV/SpZq3Uv7zcnjQ2Kys2nVMAbjAjf
         V2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740425; x=1756345225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATlUyc/yVrz9SFl40s76YJ9pVhEaYN1JhkZsZuAHo0I=;
        b=QNiN0rmhk90tBw0ENpu132VIhqZwcY9JJXWFKT/v1u6A2qzl4QBh/XYVk2FeHIztsC
         82OCl0Qs4wX3RgolJmQJEYOtwvEqzvGSDeP/444voaBCZKafxK0YnjxoIdZwEXRHjgY0
         LBW8EWc3glG+wnxYKI6FvHZGwVyF+gZdI59BPq2CbtzowhyNtpX1dU7xfirCeEogxcSR
         Ll/JNKiLxztu384Wm2FEcWkmTbU9hXwD/9b8ecF7CublNfX78sFn4FjYqGXO1xXtEZDx
         IYyAMP7ZDfbuQiDE0DK8yTkWjetg9lmNOVE+EwU3XSomriGFl7pHycDB+/9XkTwoC0ww
         8gTg==
X-Forwarded-Encrypted: i=1; AJvYcCV3BZEQ9GqWkeQamCEKNSzKHn0ryJxp/udJfuIA89Equ40kChg8e93iqox0FBe2lBNcpuF2lMmH8ljk8ZYbSAs=@vger.kernel.org, AJvYcCWfbCdDGrUFZFxKh+fRYTxJtS+JerzdnNxOxELASlbbvgkqSR/a9rJ3KZbQcBnnFzka4M/gPs++@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoSabIyijpF2JYPKHgvhMMqcqTCyAUe1ZmNkoaH8skHJVHy+8
	FAlBhEEWn193YLPRIZj4Lafwup6ZXRvVZohVYe6nYFzwtPSSu1WfIRau
X-Gm-Gg: ASbGncvkhm77B2XR8ax4pwIZZBGcOZjNfP2FuVOmzpCHIlZmefu19mHoCF+v1Vk/dGe
	WI+5SFJ17WIOr5nIXohb4DU6Dvx9WKfsyM76+MHypmwu/ZwOUXBgredEn5Vp4jzZ7E2qBEzEi7E
	1NSvwbWZZjAdr3kyHUe8XXImdmhHVQzQwT1shINjkOtN3gLG3t33jvL3XSITiC5vHXlXCOeh9fK
	GQgw2n7oKNTLiQlXNQK+ZvmHz79TdDWxfMQqOAmKorkuEzH8wKFuD7o+Z9tpAJyh1SiKg1vGIn8
	xZhR0tnf3e5L77SKO6Rw46QRRbh8RvylXwqulRk6z0P+ZJYgtPFu4Ky0NEAQizQOrm8zPbgeha3
	YvfoRVbrE9Yr3jfNUMHHSnFfqacLq4Q==
X-Google-Smtp-Source: AGHT+IFJY1Moc72ARm197SI24ptfUHJZX6YVBOBYGRxzMAAuJPobz9iFEM6Ovu/05iyUCBsQXUJUhQ==
X-Received: by 2002:a05:6830:6081:b0:744:f0db:a1b0 with SMTP id 46e09a7af769-744f6b01a3amr386843a34.32.1755740425562;
        Wed, 20 Aug 2025 18:40:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74391bd1c80sm3167085a34.17.2025.08.20.18.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:40:25 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/3] selftests: drv-net: xdp: Extract common XDP_TX setup/validation.
Date: Wed, 20 Aug 2025 18:40:21 -0700
Message-ID: <20250821014023.1481662-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
References: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation of single-buffer XDP_TX tests, refactor common test code
into the _test_xdp_native_tx method. Add support for multiple payload
sizes, and additional validation for RX packet count. Pass the -n flag
to echo to avoid adding an extra byte into the TX packet.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 47 ++++++++++++++++------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 1dd8bf3bf6c9..ea4da9024f9f 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -290,34 +290,55 @@ def test_xdp_native_drop_mb(cfg):
     _test_drop(cfg, bpf_info, 8000)
 
 
-def test_xdp_native_tx_mb(cfg):
+def _test_xdp_native_tx(cfg, bpf_info, payload_lens):
     """
-    Tests the XDP_TX action for a multi-buff case.
+    Tests the XDP_TX action.
 
     Args:
         cfg: Configuration object containing network settings.
+        bpf_info: BPFProgInfo object containing the BPF program metadata.
+        payload_lens: Array of packet lengths to send.
     """
     cfg.require_cmd("socat", remote=True)
-
-    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
     _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
     _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
 
-    test_string = ''.join(random.choice(string.ascii_lowercase) for _ in range(8000))
-    rx_udp = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport STDOUT"
-    tx_udp = f"echo {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
+    expected_pkts = 0
+    for payload_len in payload_lens:
+        test_string = "".join(
+            random.choice(string.ascii_lowercase) for _ in range(payload_len)
+        )
+
+        rx_udp = f"socat -{cfg.addr_ipver} -T 2 " + \
+                 f"-u UDP-RECV:{port},reuseport STDOUT"
+        tx_udp = f"echo -n {test_string} | socat -t 2 " + \
+                 f"-u STDIN UDP:{cfg.baddr}:{port}"
+
+        with bkg(rx_udp, host=cfg.remote, exit_wait=True) as rnc:
+            wait_port_listen(port, proto="udp", host=cfg.remote)
+            cmd(tx_udp, host=cfg.remote, shell=True)
+
+        ksft_eq(rnc.stdout.strip(), test_string, "UDP packet exchange failed")
 
-    with bkg(rx_udp, host=cfg.remote, exit_wait=True) as rnc:
-        wait_port_listen(port, proto="udp", host=cfg.remote)
-        cmd(tx_udp, host=cfg.remote, shell=True)
+        expected_pkts += 1
+        stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
+        ksft_eq(stats[XDPStats.RX.value], expected_pkts, "RX stats mismatch")
+        ksft_eq(stats[XDPStats.TX.value], expected_pkts, "TX stats mismatch")
 
-    stats = _get_stats(prog_info['maps']['map_xdp_stats'])
 
-    ksft_eq(rnc.stdout.strip(), test_string, "UDP packet exchange failed")
-    ksft_eq(stats[XDPStats.TX.value], 1, "TX stats mismatch")
+def test_xdp_native_tx_mb(cfg):
+    """
+    Tests the XDP_TX action for a multi-buff case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o",
+                           "xdp.frags", 9000)
+    _test_xdp_native_tx(cfg, bpf_info, [8000])
 
 
 def _validate_res(res, offset_lst, pkt_sz_lst):
-- 
2.47.3


