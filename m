Return-Path: <linux-kselftest+bounces-43794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B400BFE0F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647623A88DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7BE34EF0F;
	Wed, 22 Oct 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRmGSpHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D52F6162
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161864; cv=none; b=RTA9Am/kFwibG9XCC60+cu24S9Yd/AGnCybXTqO1yXi4yh7jEFlyu6Ljw2OxpPUwqVE7mesgULCfvUc1Bf3TPUMHuim4Katd1xW9qi9CX1c3wBXmCWf4gw38AI2Ko6KS9u7DSrKxQXjILpLM1HqvcEolvs9fco+yMdaOjE7In7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161864; c=relaxed/simple;
	bh=bcETCkepaF74e7lPUMskBIH6KkDLfN5id3lvNhxFZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkOdfykoA3GOshUDQF6XYRRKeET/yRfcCWIbOGzzl3eUvKop+23kYgdA6/eTbab3b/eoSoMAm3+NMoSmWqx+br7JZWnlo8dIVQNwmxBc+oEEfBt0BntPjypif73T02caBRS10FdtoI7YWd5pnt8+yDMEk0ruKqRS7EomnvgSP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRmGSpHG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-783fa3aa35cso72929017b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161862; x=1761766662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=RRmGSpHGECwssHo7YN/L1ireNJBiNgqQ7dG12C97JVndH58KGFnZTBOZuk5ORwOT0j
         gz/Cel8H9ux/G8COyIaZhwB6o/ruxbde9PnHygKif9/QrRj2x6LXjBLffEuJNm3CFBug
         T5+3aO7oN93kUIJGGbJ1epbj2HgH/57s8yumlfO18M/NDCOKPN297Irp0nqo3/8CgnQB
         dKgx/gw8mrUsICkoJBZM17eRyqIzRJ/vGIdgJDsiisuWPgACCtrtrli+bryWOvCCt1UU
         g4ytnoaUGTF2QU9cJUSn6VY4ERZkpepx+1phvkosMM+0OwkRupveY3gDkBYB7acRVtbk
         rEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161862; x=1761766662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=kh3Cb6V+ilp0gINlmsUhee7Co4ylnDL4O0P6gsyp/cRtEb9Ygf8SkNkaw1QsLLCByl
         7Ne52i2wuYAM3OT62EBtvvueBShqzqTHUwoeiM0fohoXxrWgNI/5yMuW8RpdwYP22ILV
         LSfqhFFlL9ibXnPYYSTttwtAz1wBkL1YTvO8td9+D5OMKJIeT3q42Vz6wDFeMsKJVvXs
         BWUCc1HZS+x+djCDkwJi0t+q9NfQxDwvMMsClUXXbkxzxTkVPhHqUcSnRLjFzEgIwcb8
         wl37LU+rEvxgqMITWUfTZMFU2/F2KqC3+iyC7TwFGOsYNLrysoDv+p89qsze75R0VJYF
         peIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0F5nydUiGerjWMj6MhqUXLeZp9YPELVTr9oxy7z4v2aPcVDoVpQeGBTmr3JKd7pFSFrrugawLzl2NDEqjCLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpe0G+9oiiYOz5GqUXdxqZujfDRqka4DjmaDZrhEGZIHs4gJOs
	/o5+5d5JeJ4PHhmtzoiuANtDlu4iCsSy6YTelrpp7hDZNCsHzBPqRVPj
X-Gm-Gg: ASbGncslZzmhu+yB/l3qksqaNqiWxd20jtFNwKpxO3YIuqaYsvc2D/QNBIT861cn4kC
	XA2iFH24bUTlr667ogGmDHQzu8aIj74hpoBYI8SCyx3ikJhnEEtQ7D2phwynjO7jS+J17gefzVa
	FzfoHPwfQQ+bVDhd8uYqj1jblnZ000SdoEXlldrrMx7RTqso/nPdo4vGQXO0gYwjZvedi2oQKcv
	6yJxTCV9c7oxr/kVKnN4xxA29FyhUX18AOg1Fy0cyq46iv9e2NlmEuUh77BbG+m5EfSLeE47/o8
	cUWZqXnSPArcqRACXXx6siuxAb1pl1DFTI978Ti3+kGMWS8v+tCBKhl2B22ZxcuMykvqxnLh71F
	3SaynCjzLhNBLOGg/ngyci76PzjFLZF6GiOj2tW4N77BYyODVngdYK/zFrPZoeHlMHHnCV+K3u2
	nE51nL61fB
X-Google-Smtp-Source: AGHT+IHuIBTC+KTWMIo782PCGuFHTHGZpiuw/6yIAqiR/83g0m8JQNgJ3MXPn9qZp2MKYT9i5/JjZA==
X-Received: by 2002:a05:690c:905:b0:783:72c4:5bce with SMTP id 00721157ae682-785cdd00091mr261117b3.64.1761161862109;
        Wed, 22 Oct 2025 12:37:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd70a004sm284887b3.60.2025.10.22.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:37:41 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
Date: Wed, 22 Oct 2025 12:37:34 -0700
Message-ID: <20251022193739.1376320-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022193739.1376320-1-daniel.zahka@gmail.com>
References: <20251022193739.1376320-1-daniel.zahka@gmail.com>
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


