Return-Path: <linux-kselftest+bounces-44859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE204C38793
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 01:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEB514F25E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3B1B4223;
	Thu,  6 Nov 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoZr23Kz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C3198E91
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388774; cv=none; b=F9leFTPK7UDTjN6VDvQ0EFI1miSUU4nY6tyYyydnXCAzDt5RmoOkYNP8on0a2SzSSEqspUxrufSBc601887SDWqslEAorKg/d4kdTa+WELrf4TXWOo0uptUC8z3kI6l7rNAThsnY4Ua/yg60Fp2WjxUXKaNqrxN9HdvysPvb9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388774; c=relaxed/simple;
	bh=bcETCkepaF74e7lPUMskBIH6KkDLfN5id3lvNhxFZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4H8/nuAU2pAPYf3zbI7lolRvpmbvehdkmRokGE4mutb6ObNX39WYw3Ai/PZV8jdMbz9v6HsEFaoKMbHYz4tOEDvvGsx4MoS1odCnBmjQGmIdg+BTcSyQ8xYIyyR4IUBcrZF2EV4eGPSfI6fhU5f7GD3LLQGaIO/9LUMI7Fu3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoZr23Kz; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63cf0df1abbso445358d50.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 16:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388772; x=1762993572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=AoZr23KzUWN59YOfbzp7y0Y04/tJgWDRFFCOSUMgeTvZxyVlnZ8502wg/vsX8HNQC/
         fjr4jKs5/vdBGMULFbUEwvkpNI8JMFbrhA6uR+XsbniuslywQVmKXSTLxqnw9WkJ15N1
         z+45Mjp+iTAKxo88o4zEHog1OUgFU48BS+qMElH6nXJuH4jDFSFATmeAzCudxvFa0XdR
         gBIyg3/ttkMfqwgOdw7DeimP7nwDjJwVrAJtYJbZk70Iaa20NxHF1HtW9BVvhFoCwIK/
         IhZiKeMuFz55MDVo8UqvajR0wFjr0uDKjCOU9K4lJHoXUVqrvdggoYwbzISi26IlQ3pg
         jX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388772; x=1762993572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=NV0xECJ0YFAm1MKW9sZDnoaoS6LYbx4XfwSDqqGCjulB2h/qUr2so1aUDezanDFiBl
         fzRKPblzZj3ldAupd9FFoJQmX4oXFvrXlnb40SK4+dsncF/ex4y/090u+YV2xitvlfa0
         eAAM5mKujGRz4hyRLdwWttAkhEUxfpNdto+xF9fb0Ujwrs8gfP8lMG3MGSDIfHzDDiG6
         Mg3mXvgJe9fzARr2Xk1TqvzmzLABG7mjxHvRqa46JQcIjsx3iSBQqJa9suYt1MRGkqzA
         9ZSgHtk4qJOVdBpZpU9Il/XsB58ledzKbRXZSTm0BqCtr6giw4IZiJnuuprB+GlmMyD2
         cZXg==
X-Forwarded-Encrypted: i=1; AJvYcCUQTh194AndUMejJ44pKLFNI20vewb+V30P0/4BQZdDnpwjOg9237tECgYxjB8nFkcQGqEkYcSetEv7s0Mzt54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgSi3N4rmXko7krCIhxZt2lJ1SpTfbFAO1LUbKSiCEwEfKp9sL
	k7R5XWCXkblWeqdf4Awg6r0DWjhuv59W1psreW2Gf6hqCinWSfRBQg8V
X-Gm-Gg: ASbGnct970UPyqxgyqJC7JDLyLwcNIMTSXwv4Thj6DLHhI9LkSWldxrSOyNOjYcq8c8
	EmbUZLRs6iERC+mtOaphnLYE9iHOExfxE9XE9W8Mv9U52jRPAU3xvyeoD9C9B9MSwTfVAY47Fx/
	Ymz8lnlC/a1z7cRqJvWb374Xess7stgnnRSA2nRJ3TBZupJDbMgaGV62hGFQ7QVc1uxFU4PY+lX
	Do9nI2JyVj/TkUAbrt3SH1/Rr9SWvHX8y6wO8mcggIvDGjMQegP3mL/9kGY56ejjii8iROdV2tN
	jV7KSMCoqQPTnV/e9uokioSNOBPQawoAbp775w0T21buTa8YtTVZL+IBFchtm3Wc9cKMlLAxVYl
	lvarJ8RILyHX5qW0cMa6naftURlUqFl8pJRu6bNSvI7tU+3rCZaLATMtViiu1iwvOHBHIQRvFeA
	HvscCBs2gR
X-Google-Smtp-Source: AGHT+IGUs2EGrmJcpX8sLWFVHcWr4tdUrasTklxf9Bp0ULYKHhGWtlazRWy3T6CE6OmD8o7jNEYSVw==
X-Received: by 2002:a05:690e:155b:10b0:63f:beb2:9519 with SMTP id 956f58d0204a3-63fd34b5e50mr3795617d50.5.1762388771781;
        Wed, 05 Nov 2025 16:26:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b142d5cfsm3513297b3.26.2025.11.05.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:11 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
Date: Wed,  5 Nov 2025 16:26:03 -0800
Message-ID: <20251106002608.1578518-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106002608.1578518-1-daniel.zahka@gmail.com>
References: <20251106002608.1578518-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add assertions to existing test cases to cover key rotations and
'stale-events'.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 4ae7a785ff10..06559ef49b9a 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -109,6 +109,10 @@ def _check_data_outq(s, exp_len, force_wait=False):
         time.sleep(0.01)
     ksft_eq(outq, exp_len)
 
+
+def _get_stat(cfg, key):
+    return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
+
 #
 # Test case boiler plate
 #
@@ -171,11 +175,16 @@ def dev_rotate(cfg):
     """ Test key rotation """
     _init_psp_dev(cfg)
 
+    prev_rotations = _get_stat(cfg, 'key-rotations')
+
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
 
+    cur_rotations = _get_stat(cfg, 'key-rotations')
+    ksft_eq(cur_rotations, prev_rotations + 2)
+
 
 def dev_rotate_spi(cfg):
     """ Test key rotation and SPI check """
@@ -475,6 +484,7 @@ def data_stale_key(cfg):
     """ Test send on a double-rotated key """
     _init_psp_dev(cfg)
 
+    prev_stale = _get_stat(cfg, 'stale-events')
     s = _make_psp_conn(cfg)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
@@ -495,6 +505,9 @@ def data_stale_key(cfg):
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
 
+        cur_stale = _get_stat(cfg, 'stale-events')
+        ksft_gt(cur_stale, prev_stale)
+
         s.send(b'0123456789' * 200)
         _check_data_outq(s, 2000, force_wait=True)
     finally:
-- 
2.47.3


