Return-Path: <linux-kselftest+bounces-30044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E7A79BBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 08:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BB03ABAE4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679819F127;
	Thu,  3 Apr 2025 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAUkKyyH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B219D8A3;
	Thu,  3 Apr 2025 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660288; cv=none; b=eCRAvP7odYCC65a3FCiTzkN1orpeTGuXzM6wzZQpq/11lFzRq7t+peVON61BqQXrI3KfeQkltTwwRL0Sp+0v22ikAweBv8ENqprNvPHfNinTbG09iX7v3ygl1Zdu1kKfwkHSu+t/Q8maOXw7/3/lyavBUH7VjpknEVVLABJhy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660288; c=relaxed/simple;
	bh=MX3akoveBpk/g6fzPhVqkT1XvOiHRNKYkwBOefY2+BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuID8RPv+L/fQ48ZMz9sZTFd2gtnNRahYmmRO3UW/Ec0xGF74Zb4abqRJPGHvRwxD2GDfQAn4yN6wlhY8tun4SQMTCs1dQHOhtfIy0fhF7eeNxIEZleT0+hA8kzy2jSzL3Jr/D6jSBnjcL3DlZA7Y56VYAjn76/DBWeS0WbDeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAUkKyyH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224191d92e4so5162805ad.3;
        Wed, 02 Apr 2025 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743660286; x=1744265086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSW8mNF0B+bCZ674Cbi4bHO+4cmTiu59GXWSDpHNJV4=;
        b=QAUkKyyHmu7AgE09mkKV8MOWKlx0R4QspAcCgoTd7AWZQWwIO3vUCSIF48gzbOgVtr
         X71biA+CNjn54U3rPDqR2LJhhKfjCLMRFd2I6I9tuZxOYTnPz4YyemM4/aR6So/3BA4D
         vTUzB4DVx6HqVWjSlpRcjl/QcPC9KQCCIvHK7t/TZSjZQETyqcHAGx7J6yebhiDY0W0I
         ufCSQo3liEMfRu3GZAqZR85Jt5Gy9xHvTg95wI13oQOZHFLTSMXIlZ9Df2Ca4D9QB4EQ
         2ygxIPuatqmmd3BY5t/Xa1aX6QeEhYsYPedk+2W45tp5xWGDcoZu68QFRiHfrqFAefNw
         /m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743660286; x=1744265086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSW8mNF0B+bCZ674Cbi4bHO+4cmTiu59GXWSDpHNJV4=;
        b=CLHlYTgGJ6YWN3aCnhDa7T4XWENjdk+iqppTGHMsANH2iuJHaNxsJ3Xvg2nB9Xtat5
         2uygfAhXQUUmbfWgY0RXr4Fxv1OF9C7/dXz9/KlIpScCkKm3CkcGK7sZM2AGAbYZ4rLv
         bjFSlAyMTSleki/sZrP7E4XgG7P/N+KMVu1qe+K5B93iNswoPS26lbhHH34UVAhFIUlF
         AIO9KsvBQu3pFp19FFhsXhcFS6fgIButOHJPioO6txpTPwVo2ZulLkLw78xvem3TV9Tw
         C2XZUnx3leEWl/qG4q4PihfE6LP4DLe4KHA9VozIWeko725MVPO2OWoFMdMC5zAWwQlF
         OEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+AqlqgIC6mq53hgg1MG30qnN4bV0vWe8xuhhRMmb8YbXDwe4ejqK+yrskbf6QxRma6rgpor/6@vger.kernel.org, AJvYcCWakCFi/Om8/W/4Jy5HbeNOfHXXKX9KvAwCZGU9DpmFrVTHb8CrJ1/kJC34di9SKyzCwCBAXK8JljLSLPbSdbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpk956hzLPktfQTNSLXuhHw93B/G8n2F6ijsUJq/Y674nwMjx8
	8nLI3zzJxFDwWVVD0RS0bhmS4INbApbAHRhl9w9I0wm6wQC2xeWa
X-Gm-Gg: ASbGncuEFnUj/gQE63Xpys7FDEXay4vWGCC7WDeM9OvXdSfXJzPx9dCP0xvlXXD5Qpc
	7vwbGSwXRA0ZSvoFp34kRCQN18kbJXmtVRhySSpgxsYOnwx+xMTiMBGVP7XE+DfXxsZAhSZgiwl
	I23Lnh4aI9U6lrImsGECAblhf9s3gGfjXRcEHIwlh/TqNVOpwZbV/Tj2cnKtsXhg69s1WcILMQb
	bhVNwvIxi8ZQ+GZZLxx611UPBnNCJHguBh+CHsu8MirT9K0b4/hXClrg/7C4vjJFCDLxpTs1OhQ
	Ln/14dbCIzv0OfpBSrsPWMmFuYd/5OGr5A==
X-Google-Smtp-Source: AGHT+IHvMkGeAGIKqJ1OslvBnx2ENYo4vMaCu+L7pXWzG7OXj07BbI4fimHMIsbFMOAx1/Zp4PuPLw==
X-Received: by 2002:a17:902:f651:b0:224:1221:1ab4 with SMTP id d9443c01a7336-22977d9c36fmr24868545ad.22.1743660286001;
        Wed, 02 Apr 2025 23:04:46 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e3141sm615340b3a.173.2025.04.02.23.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:04:45 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	ecree.xilinx@gmail.com,
	almasrymina@google.com,
	daniel.zahka@gmail.com,
	jianbol@nvidia.com,
	gal@nvidia.com,
	michael.chan@broadcom.com,
	ap420073@gmail.com
Subject: [PATCH net 2/2] selftests: drv-net: test random value for hds-thresh
Date: Thu,  3 Apr 2025 06:04:23 +0000
Message-Id: <20250403060423.1209435-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403060423.1209435-1-ap420073@gmail.com>
References: <20250403060423.1209435-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hds.py has been testing 0(set_hds_thresh_zero()),
MAX(set_hds_thresh_max()), GT(set_hds_thresh_gt()) values for hds-thresh.
However if a hds-thresh value was already 0, set_hds_thresh_zero()
can't test properly.
So, it tests random value first and then tests 0, MAX, GT values.

Testing bnxt:
    TAP version 13
    1..13
    ok 1 hds.get_hds
    ok 2 hds.get_hds_thresh
    ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by
    the device
    ok 4 hds.set_hds_enable
    ok 5 hds.set_hds_thresh_random
    ok 6 hds.set_hds_thresh_zero
    ok 7 hds.set_hds_thresh_max
    ok 8 hds.set_hds_thresh_gt
    ok 9 hds.set_xdp
    ok 10 hds.enabled_set_xdp
    ok 11 hds.ioctl
    ok 12 hds.ioctl_set_xdp
    ok 13 hds.ioctl_enabled_set_xdp
    # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:1 error:0

Testing lo:
    TAP version 13
    1..13
    ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
    ok 2 hds.get_hds_thresh # SKIP hds-thresh not supported by device
    ok 3 hds.set_hds_disable # SKIP ring-set not supported by the device
    ok 4 hds.set_hds_enable # SKIP ring-set not supported by the device
    ok 5 hds.set_hds_thresh_random # SKIP hds-thresh not supported by
    device
    ok 6 hds.set_hds_thresh_zero # SKIP ring-set not supported by the
    device
    ok 7 hds.set_hds_thresh_max # SKIP hds-thresh not supported by
    device
    ok 8 hds.set_hds_thresh_gt # SKIP hds-thresh not supported by device
    ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
    ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by
    device
    ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
    ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by
    device
    ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported
    by device
    # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:13 error:0

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 tools/testing/selftests/drivers/net/hds.py | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 8b7f6acad15f..3ba8e4d69c4c 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -6,7 +6,7 @@ import os
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
 from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
-from lib.py import defer, ethtool, ip
+from lib.py import defer, ethtool, ip, random
 
 
 def _get_hds_mode(cfg, netnl) -> str:
@@ -109,6 +109,31 @@ def set_hds_thresh_zero(cfg, netnl) -> None:
 
     ksft_eq(0, rings['hds-thresh'])
 
+def set_hds_thresh_random(cfg, netnl) -> None:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    except NlError as e:
+        raise KsftSkipEx('ring-get not supported by device')
+    if 'hds-thresh' not in rings:
+        raise KsftSkipEx('hds-thresh not supported by device')
+    if 'hds-thresh-max' not in rings:
+        raise KsftSkipEx('hds-thresh-max not defined by device')
+
+    while True:
+        hds_thresh = random.randint(1, rings['hds-thresh-max'])
+        if hds_thresh != rings['hds-thresh']:
+            break
+
+    try:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': hds_thresh})
+    except NlError as e:
+        if e.error == errno.EINVAL:
+            raise KsftSkipEx("hds-thresh-set not supported by the device")
+        elif e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("ring-set not supported by the device")
+    rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    ksft_eq(hds_thresh, rings['hds-thresh'])
+
 def set_hds_thresh_max(cfg, netnl) -> None:
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
@@ -243,6 +268,7 @@ def main() -> None:
                   get_hds_thresh,
                   set_hds_disable,
                   set_hds_enable,
+                  set_hds_thresh_random,
                   set_hds_thresh_zero,
                   set_hds_thresh_max,
                   set_hds_thresh_gt,
-- 
2.34.1


