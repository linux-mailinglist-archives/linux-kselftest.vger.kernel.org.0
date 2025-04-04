Return-Path: <linux-kselftest+bounces-30104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED68A7BC9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C327B3B51E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA641EA7E7;
	Fri,  4 Apr 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2hJOmtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91CC1E1E04;
	Fri,  4 Apr 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769330; cv=none; b=qNAlROWzhlkSjteTr0Jon3uk8f+q9ERH4PPwdkGO1nKK7IpKFao37w98LFRhW5vW+oI0X4iMYxDVQiO/b2ePlZHiM0OzieuSKbj1yZN1QqR4qbjliAi8Yg4IEWBPNp9+8uoIlLn8I8T5H9lv86NVxN9LGw3qk0N0A7EI+TouWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769330; c=relaxed/simple;
	bh=CGMkfUQ1BJsR6QFNCZCn9JvwU1xKBTUfK+SGpGOn1eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RH4fUA3mGDKPlXNDZ6REiAYL4ch6KyN10oymDKjP0c3X5QGjk2rgfX5RaggFhTtAc8edKG3pQpafI11pIqu/jzhsD/VBEkFtKmZ+jpf+1Dfiw2LwdJ22OIwBzDGspflYH1KvQjjj5T9G8nfQynv0djp03+pLmxhG2rfXckLwrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2hJOmtJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so18565415ad.3;
        Fri, 04 Apr 2025 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743769328; x=1744374128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlMdCBVBpu8QB5HCWO/Kzs2JH53pWR8TGHRK8b5lUNg=;
        b=h2hJOmtJqPwJPtZ2ptMWk6m+WtUILyVlixRtuHBjw0zhtzfCA2Q4uX3T9qzpql12EW
         SBwgEa4T2pWN98SWCSJlID/1N9QX0ZOmlf34gMWI01/HUrblOII5Ejhu+o8TP6BGZCum
         El4AjNn9BbhUT/YDKoPKjYNmrfHHV/oHCBKvYBxpdVaVUw7WQGxAhg4fwSiZ4CsCEOon
         3sTrS3C29jpCL7v7OX+ZeMWpcL0TFz7x0YO4yKsUFrkxDP3lq65ZU0io1Hy8OcvwGv3v
         46ROBHim2u9X3WOQnzKpOYIVYsF061zrgXucCRF0AlyhzX/oHEZmmrm4Renzdpko7Z2J
         j1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743769328; x=1744374128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlMdCBVBpu8QB5HCWO/Kzs2JH53pWR8TGHRK8b5lUNg=;
        b=aNkujApiSbAW6SaCLLCTGftdrE9jQlaRqFp7swk11k2q+v409oPnH5rfSR59djpjjU
         aVjPIS4BgUfc/v9apviRRmpLzsanBoAi0TwUsi6dL4sIJsvY/FRbBK4v6oo8Ffv7jVfK
         81tSJ0uGCi7JfQ5TvAPgBAoJDn05W0fZWKHGVfKaQxcWyey4xloh/23icOebkgPED1VW
         1tIDOd0SacRDbpAf7zMsgJXyfGxslTTwmklB4PU/VhdXtjEir5B9CK7mp9cEVwFik47Y
         AUbevd3nOhOrJ7ZVuhO/Wd9aWmFHN6xSipHkUWh1Ph8otstjISlV9ASffyljCeqKa2Ku
         /iEw==
X-Forwarded-Encrypted: i=1; AJvYcCU4vM2HqG9fVXKJ9Kj/sWihnZ2pWnecEPtzKYDDbGbHcpq6JD0IKZUp33xp9tf85deYT7rIowl3@vger.kernel.org, AJvYcCVluApcKxpaYqpxGX1umf5fynGUgZtzbEMp3UUeK6jKthh4XHB6hlJ1GkcPXYeL1bwop/l3+A7WZDnAUxgg0YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+qPTdjkI/tyLfRcLVblqsp4NZD58CaOllDyreE0FH57D1HQI
	Fecv8J2t6MzLfNlWm/GNLRcQ3IUViOQ4PonWmOzEdtgBkwKZJU+/
X-Gm-Gg: ASbGncud5mQankZBdc6+CiIloPa/JISQFPu9mAcxNCbyxeJOI2O3IV8dqY8+qYZbL0Y
	SJxVSKIqebeXzoSLUyM4ee9wVXsecJrcWO2SCyA0o8IjaoQl+VTLDNgHuyMosOSZGjR7j5k8bZu
	MErauZp8+xCLMTMx1zyrbPqwlcMptKEML3IiVvGY3402Ilo8rP8F6xGkUVu034zrkWC27OKaCPA
	uATE0+EJ2uTC7HHnFU1Zl8cR4RrWNycR2xM/WpdI1C+heoltdfJkBHtaE16hl5qrFyxZa4x0IiF
	J4Chtjajvc5qN/z6douIc4KuUuSqAKjGnfySLNHundZ+
X-Google-Smtp-Source: AGHT+IF6Gb8DJI8SnjLXpTA8ofaDWo0sVpmynwuUsmhFvBRcb20geiEeY9YWCdzHWFcmuuPv8UjlCw==
X-Received: by 2002:a17:902:ce06:b0:224:3db:a296 with SMTP id d9443c01a7336-22a8a047ba3mr46120025ad.2.1743769327729;
        Fri, 04 Apr 2025 05:22:07 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727e1sm30755005ad.218.2025.04.04.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:22:07 -0700 (PDT)
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
Subject: [PATCH v2 net 2/2] selftests: drv-net: test random value for hds-thresh
Date: Fri,  4 Apr 2025 12:21:26 +0000
Message-Id: <20250404122126.1555648-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404122126.1555648-1-ap420073@gmail.com>
References: <20250404122126.1555648-1-ap420073@gmail.com>
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

v2:
 - Skips set_hds_thresh_random test when hds-thresh-max value is too
 small.
 - Change random range from 1-MAX to 1-(MAX-1).

 tools/testing/selftests/drivers/net/hds.py | 33 +++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 8b7f6acad15f..7c90a040ce45 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -6,7 +6,7 @@ import os
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
 from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
-from lib.py import defer, ethtool, ip
+from lib.py import defer, ethtool, ip, random
 
 
 def _get_hds_mode(cfg, netnl) -> str:
@@ -109,6 +109,36 @@ def set_hds_thresh_zero(cfg, netnl) -> None:
 
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
+    if rings['hds-thresh-max'] < 2:
+        raise KsftSkipEx('hds-thresh-max is too small')
+    elif rings['hds-thresh-max'] == 2:
+        hds_thresh = 1
+    else:
+        while True:
+            hds_thresh = random.randint(1, rings['hds-thresh-max'] - 1)
+            if hds_thresh != rings['hds-thresh']:
+                break
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
@@ -243,6 +273,7 @@ def main() -> None:
                   get_hds_thresh,
                   set_hds_disable,
                   set_hds_enable,
+                  set_hds_thresh_random,
                   set_hds_thresh_zero,
                   set_hds_thresh_max,
                   set_hds_thresh_gt,
-- 
2.34.1


