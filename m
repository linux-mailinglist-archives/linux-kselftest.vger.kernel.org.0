Return-Path: <linux-kselftest+bounces-42424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9F7BA1811
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F353D742228
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B9322C71;
	Thu, 25 Sep 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfJ5SpYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B57322A2A
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835020; cv=none; b=M+Mw0LFvaKK9ANK1eA32BQ1nG1/A029AqMp7/v6T9tURnHQBSFeky21WOnvu3D018SOlY5KBCbFD1TwqBJsXLCB2ryD2clkGRc10NyM8wxC3nQLqb+NM/ezop25wwyUAWXuwKmWqvDkkGBOTLmpKQeV5CHFW5480rSrnzDSPLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835020; c=relaxed/simple;
	bh=TibBUxjer8sn4SHd81lBBre6CGD0DuO16jKiKhsjTK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6OLl3Ui8larNS+ovhIH8imLDRFo1hUgVBrutcJlCgl7WReYdFbYuIsDpRiJHA19j+CJZ0ULGYI1I0kPow+ITDmDznN4FlOy8IE5HSVrSN6VSjnZRF2EVBND+hzbp43nSnTlm81KRvCaGV3OLg9aKq6xOyvePO1Cm6w2gCekw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfJ5SpYn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d6083cc69so19212727b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835018; x=1759439818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO0MHYB2g91WEo5u4+rJ17OMCJlsE7G9zuPzeJmEyd4=;
        b=IfJ5SpYnDvkGsnBuyrPePuWgNZngYeOo8vBm3/kNKvtVmMDSJGINZc9CVGMdC0T/EA
         AuFmtitpKU2jLMOBPAjbr3Mr0YEHTsCV1HoQTwThSwXkb5MuK2nlPQWDvfnFZdBjwZV5
         YnbgVoGjJNUkhokU8UdIeUQU7wBU05KF8pWVnmXslvpXsx2iyT5hbcvibt1ciA6luHQg
         0j9aDl9Tq/n8kyI8Zu5vCQPvm39YQfpJcrdsqn2WOlwDnoEtM06T9/sliw9LuKRvppeU
         qFrGtHo3Kkn1z1uRlJ7mcPTgxPRZITLGjJ+Ai2bqD0RXndzPDKo4j0lY+22pXX25wiKP
         Py/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835018; x=1759439818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO0MHYB2g91WEo5u4+rJ17OMCJlsE7G9zuPzeJmEyd4=;
        b=XXEu0tEvR/yUwaXl+CMXEsiTPMc894BJ3RFR2H6psCHzup1d9vHPRNXDxdXyos4BcO
         3oSxsDFkIle0L1HLSrCNBEN7wgr/E3ppUJjB3EPLEBpKoNXNNkq1PWzhqruVHgKgwqk4
         BIY5V/WzCotY3s2VK+Vl2LqqW480wk1+V6C3WpwzVHBjV3ToQZNovNn/p+/Djdl9fxXY
         aHOL1HFa6tqHBaJvkynaZpfLgFtaJhEgoDY5MnDdWGp6EZIVebCVYsgh8Uf7rw+3uZXZ
         In0L3ydPbLwRi3xp89+ATKtBzDC0aVb9OE/rL9RTzaUFNQZvd/CIGOd7yHZ0YoRbADH3
         674A==
X-Forwarded-Encrypted: i=1; AJvYcCXKihlJLmEgd2pV3nhDQEu/Fd6Nx9Cy5Wr/SJ+lFIuTsY0YnLgovNjg5zDzVCSUGq4YivPrT8y1Osx5tG4A6h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YW191/8/K/PGIq6C0ObZjul8RLt6wMVg3XOUIdEwOpy/thvh
	toXzfKDwUmPQjWvdn5ZHWBRYxNMJWAZr4hsZ5+xJUUI3b8iSNEqmYUBqFyn4XQ==
X-Gm-Gg: ASbGncv/l9p82QqjeECUGYxl19QOYdBYKSG9ERVje6QUi+3H+n8RmqU+KLpKrRFp1cq
	PHpdcGNWK70T/Az0lBjwTcmNbeTmvRfo+JhCJuvJvgpbsqCnKtD3IV7LG4d1u61DGHdUOD9v75s
	2WPcPZWYJ7jnQC5sAIuu1xstEWPPhVL07xyMRIKtxjV09pVDgXf2qpwPpJGsGcPIWXfbm4mOhVa
	i4aPDSYsi38UKGtFdz4biBQPov11QBcTlood+Cqjdz/jmRxtKZmMQlez9vAd/auzCP+wV5He5Ic
	gW6hM1yviJ/3qapBIMb8VF6iaDV8NLq17CvAfo2+M7CnvLAUwLADzYk16zSV2pyL6Xwioi98Pqb
	WWF43o9ZgDwp3A+3VA9ttk7ED83r/cbQh
X-Google-Smtp-Source: AGHT+IEZ0RMSsUoH+5O2rBo0k5lMsNm3odujpQYlX22DhoC1XTq5eVAG6pOnXtYG7QiO/j47Je32XQ==
X-Received: by 2002:a05:690c:4b82:b0:748:9715:f672 with SMTP id 00721157ae682-763fe75420amr52505507b3.24.1758835018099;
        Thu, 25 Sep 2025 14:16:58 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765be66afddsm7288797b3.30.2025.09.25.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:57 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 7/8] selftests: drv-net: psp: add test for auto-adjusting TCP MSS
Date: Thu, 25 Sep 2025 14:16:43 -0700
Message-ID: <20250925211647.3450332-8-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Test TCP MSS getting auto-adjusted. PSP adds an encapsulation overhead
of 40B per packet, when used in transport mode without any
virtualization cookie or other optional PSP header fields. The kernel
should adjust the MSS for a connection after PSP tx state is reached.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index f9647371b791..3eed986e587e 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -383,6 +383,43 @@ def data_send_disconnect(cfg):
         s.close()
 
 
+def _data_mss_adjust(cfg, ipver):
+    # First figure out what the MSS would be without any adjustments
+    s = _make_clr_conn(cfg, ipver)
+    s.send(b"0123456789abcdef" * 1024)
+    _check_data_rx(cfg, 16 * 1024)
+    mss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+    _close_conn(cfg, s)
+
+    s = _make_psp_conn(cfg, 0, ipver)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                     "dev-id": cfg.psp_dev_id,
+                                     "sock-fd": s.fileno()})
+        rx = rx_assoc['rx-key']
+        tx = _spi_xchg(s, rx)
+
+        rxmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, rxmss)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                          "version": 0,
+                          "tx-key": tx,
+                          "sock-fd": s.fileno()})
+
+        txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, txmss + 40)
+
+        data_len = _send_careful(cfg, s, 100)
+        _check_data_rx(cfg, data_len)
+        _check_data_outq(s, 0)
+
+        txmss = s.getsockopt(socket.IPPROTO_TCP, socket.TCP_MAXSEG)
+        ksft_eq(mss, txmss + 40)
+    finally:
+        _close_psp_conn(cfg, s)
+
+
 def data_stale_key(cfg):
     """ Test send on a double-rotated key """
 
@@ -421,6 +458,15 @@ def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     return test_case
 
 
+def ipver_test_builder(name, test_func, ipver):
+    """Build test cases for each IP version"""
+    def test_case(cfg):
+        cfg.require_ipver(ipver)
+        test_case.__name__ = f"{name}_ip{ipver}"
+        test_func(cfg, ipver)
+    return test_case
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.pspnl = PSPFamily()
@@ -459,6 +505,10 @@ def main() -> None:
                     for version in range(0, 4)
                     for ipver in ("4", "6")
                 ]
+                cases += [
+                    ipver_test_builder("data_mss_adjust", _data_mss_adjust, ipver)
+                    for ipver in ("4", "6")
+                ]
 
                 if cfg.psp_dev_id is not None:
                     ksft_run(cases=cases, globs=globals(),
-- 
2.47.3


