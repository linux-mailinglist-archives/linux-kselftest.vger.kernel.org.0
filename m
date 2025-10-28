Return-Path: <linux-kselftest+bounces-44157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E609EC12206
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848604F5521
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950851E9B3F;
	Tue, 28 Oct 2025 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWVGCeLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACD43ABC
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609626; cv=none; b=KtOQIMcfjzCY9XYEzvp6eNH/nurPkg0hb3RhEl8LnFvcJDsohGVFmxSSh3sSIldGzGddTa7hgMLIPQSu3emVD5Ei2VDH2lXi3Ejpl3UidhapCX0AI5iZzuKp+b2doEY1DVnAEfEdNC26AgXzjR4wrpWvcnI+RBEiXH4QF9aF/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609626; c=relaxed/simple;
	bh=bcETCkepaF74e7lPUMskBIH6KkDLfN5id3lvNhxFZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEPRcByBSNpiZehj2pSzfke8hibkjEbPjJoipCMgSj28jyjjidG9DCicJ4fkQ7FxUVbb6CD68rov2VSHBgThpzvOPLBqJpAUCCMVEGKBkNtBsSZAgmzEmveNGrCD7YmC6gWOy4dZDxf9px2awesWH+D6sxTj/S04vKsj0TIMq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWVGCeLX; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e16fbdd50so5005183d50.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609623; x=1762214423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=LWVGCeLXfF1jJPfpWH9nlwfD9/8dVFUUr0vaLTfLZb1ouBFs2JGsaiVG10UN/7B/WJ
         xJjm5DLAL7GSZIxNCF8jfs4G4axwLR8/sRkxR7SXnwxAEggqpphSt5pzZXFUyMK5DBL2
         GjTFZX9ISxEa7T7oO9DcCtHbbU01DM9WwkTiVf7TXSbqLTyUKYZQTnbTuj3JAcKjYnZf
         0XbCBDh61zkQM4Kaigkxa9zPziq+UELBy2zTcWb8VpanuKmRUAk1Dm+fbsuayJRXBIRD
         jhumMlpM/pZ3KDJgL3nyxWosUYF+81JzvVrRYWm0CIzq+APir7pFhH/Pf7xSIeZKUk/P
         gT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609623; x=1762214423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=WyNWGGEKiitVEfi9rxkJY7DAI+cP9M9KHn0dB4YxAPA3Tv9HVmB8eZ/cq4cBJCIoYF
         Wm02x1foJmY2DP+n1Rsr2G0+MSFjAkLVPY8jmNpMz0It4hkA2kPcPDLJ4kEAgC7zrqY4
         ivScVYpz1Cjl5yVE9AWec9q9JJ7qGZnSLnDkclCNJ324b25gjYJk7d3lLTTG3PpbVcat
         CFVioBc+Byn1cyRcQeGNURSm9L6nP2Xm9PsTVGpeWQqKoIoREnQagyPiaF+b+amhw8Ey
         OyY4VG+Mo0guFlscebFjiyZgxKU/ZQw03ea5AZ2dubw9icouBO/Imf13NJ79T0chxvNT
         3TUA==
X-Forwarded-Encrypted: i=1; AJvYcCWP7DwCAAQ7W6OboGoOzmW5HmqnUnSctG0wOumi7oSKWc4R2zKKaTXNLu4XkQ23nSIkPX5cYKXPYVANu16j0Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQl7JnrXWO4k2lPIZQM6J2MXDYAyfJmfFubsK1JShFyo0KaAbp
	s8CwnKn1iKRSsqXWH5sfPZ/24qi4cs+USqMzlow/B5pI6K7Z9qqmTbGh
X-Gm-Gg: ASbGncs8GhRCIgUHNrmfDheMAXI7wOAgzCEKl3qCQe1LR6h+XvJ4ySap2ewciXFkV5G
	XNgtorC5DgRYInhDzH06Rexua5XqmKg2kwCWbrkv/Yu/qCtZaJ1ZrX9K/6fu3CX8c3dHEkRc9B/
	TsAzCI+jkIcWPjeJW1BO42UZtFiSfV5h1fznbaK5Cg8fwexly3wOxlojOHBVt0zNAMkQe6XQS5p
	DO9Qhhp1l+obfNBlGELZYUxi9J7gsDGrtQl78Ap+bvyF0Gf/u6Lht6JLJCfKS51MBaAlTaEzo7Z
	MTTyXGYgPnXcy5GcBOEGmoJgvtxsjDthEsmyTMIZtShC7Y+2QTvRg+aWjLvr48ybJhYrEXfLabk
	V9rc4Q/zVs4SyRt8N1QMernuBB4aDrguB32YimmoWYK2U0I2jISRZPKIZ5y1lUtrRbtTL4YDJJp
	vXZdYXDmQftfwitfe7ay8=
X-Google-Smtp-Source: AGHT+IFM7FoSp+6n8D1h1RGRzyioBT8sthh2seeo+TigunDqVeBpnwtLnUyA0CdAXQqwjeY66Eaicw==
X-Received: by 2002:a05:690e:1652:b0:63e:a2b:70db with SMTP id 956f58d0204a3-63f6b9ee47amr1322903d50.27.1761609623183;
        Mon, 27 Oct 2025 17:00:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c3cc4a1sm2776554d50.11.2025.10.27.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:22 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
Date: Mon, 27 Oct 2025 17:00:13 -0700
Message-ID: <20251028000018.3869664-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028000018.3869664-1-daniel.zahka@gmail.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
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


