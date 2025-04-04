Return-Path: <linux-kselftest+bounces-30103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D508FA7BC9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 14:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B913BBDD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D211E834C;
	Fri,  4 Apr 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjoIsTbb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260E1E5B81;
	Fri,  4 Apr 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769325; cv=none; b=G4UEIzwKkrPt9v+/uu1sYzBnn7vDZ+Q/sXBog/R6cMwAM6JFJ+wrYtIj6EQGdydjzKPNIWRP//2tCY4JZHDdZXn2UHso3t5hJecnlQKlkW35aJZ6dS3ZO3PfmeChpNeiqdHDkA6VHaPdoTPPcud1tAfsJuWfcP6Hkg9sSowY1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769325; c=relaxed/simple;
	bh=p5sc/QySjGO3XGz1fiGpxbzMCmdUqRKRG++X2nnM88c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYVV3GCL/1BPqBXzINUw4G5LNa/2SrquLx+ir3DOR3CEjodMz507K25uJQnad3OP7GpQcCqAzTxAoYsJ+bQWEVMdv2FONee1cBw1ISdo3i2aGnXzMr1C4Oq3assWBPfhs7sfF+Bd3yOGhYdTzpBLCqzvNqKm579ZHe9EZxPP4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjoIsTbb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso20639565ad.0;
        Fri, 04 Apr 2025 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743769323; x=1744374123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4eVm2q2oRGJJTuVlip+FF2RrsjPWjJb5ZVOZEw7tLg=;
        b=TjoIsTbbdzkiGTNef9gx2R3qD+V6DZsd4RV3I57PFuYajfe2FC3qn4nd30Qwzyj71Y
         Smi+Hm7g/KMzRZI5sbBT3nUKej9pXxGQ4aSj1UmUa+HWLODCQlZKuWXPe0Dcaul0Ng3F
         EOV6GdL4M/FfwTJH/hPrBBJzhHoij0t7oy51dhrcIzjOJB3Hs1dA0YP8KiGscVczVeB0
         CYSjA1sIsvJf2yXPbw7HzV7IHtVuKhRCiwnuwLAHx07JVxeCc3Lf6cdO/XuiICHLoPDH
         r+JtXudWULehDGRAm2A/k+yb87r2SEJqgKOleVAM/f7hJY1pgZJUpocAF4ZHQnXm8/Rv
         sgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743769323; x=1744374123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4eVm2q2oRGJJTuVlip+FF2RrsjPWjJb5ZVOZEw7tLg=;
        b=Iz1thKITczalo6Xv8NIIO/d2zGBKy0NYdu5WBFYy7H5qB7l+2cCA7ZN2+vlAokDnBO
         pZikqW6joSMzhAkuxA6gAiUCtc7mbSZ7Ib86QJN8FWe8arodXZOvh7Onc8agOHr7leri
         RO9wcwY3/iZCD/gocZaWDCqFqcg0Ady6hlzinHsafNEs/4EThjvy9jfiOm8aihqRphaX
         lPxK/bvEGErjKqPMc41RXTMknJ+xSkFwUDC47iFwBCDQux3xfwVZXu/BmEWgVXCqeP7i
         lFu+C4kiMCAcMGo/mL/32Gi4oqzZ18aF6KIGAP1UiLa1XPr8uoPo4hyTiHZe0ypxJqOk
         diMA==
X-Forwarded-Encrypted: i=1; AJvYcCWjUyClwvucyspmMgy3xCSG6QEUQDz3V1HdG8ZpzaZ2gmlH3IL6+/GhqS+QcFnw/cAOnctOq3gY@vger.kernel.org, AJvYcCX7vrKCFu5bTm08O6LDZakTZLPrHof3QYQutKKa3tcpvHiaczVZ2A+OanPvAKAvpof30hyeJJuNQNxjtsPhRlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzspnnyaPkR/6nSug+U1POz0s7lKv8K4TctOKh1is8VPiVhL6m9
	bQnq3FetJxh+d+CyLDI8D/BNTxLyo0Fh+npIAM+G1bYKk2ygxUdh
X-Gm-Gg: ASbGncueWeXRy1rKG6gGtZcAxVi8UF64VL3ij+Hu7HvVRgaCIwLXLDNagJeP/WRg4Ne
	7YjXJtfGjCPcqgZYjnqian3obOJ7JHkcGE+txKLP5+/XcFJ3ys6sw5XTPByQbMdIkp5LrxNnv7r
	4/uELBc6FlR0wKFXMX9wP8mZYCVeNGNlsR3aKDl26Wv81MajTkAK8epn3bIGh2PlciFtRGbk8TV
	cYnLMo7f3c6tPInf4dJ62bdYKZP4EXX6MH4yriZd60NtHV9v3VM8fviJ6o/DJuxejPijtkyMsRV
	4JPVNeGN3GV4efXyl3XtP/UlsMPiG7P66A==
X-Google-Smtp-Source: AGHT+IGmF9viqikP1tyzrHEX8CdtR5hu7TyGzabbOoAnEizQI9uN8Eo3+DeSgRygM3W7SW33eA9wtg==
X-Received: by 2002:a17:902:ce0e:b0:223:66bb:8993 with SMTP id d9443c01a7336-22a8a8dd619mr42872135ad.43.1743769322748;
        Fri, 04 Apr 2025 05:22:02 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727e1sm30755005ad.218.2025.04.04.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:22:01 -0700 (PDT)
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
Subject: [PATCH v2 net 1/2] net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh value always as 0.
Date: Fri,  4 Apr 2025 12:21:25 +0000
Message-Id: <20250404122126.1555648-2-ap420073@gmail.com>
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

When hds-thresh is configured, ethnl_set_rings() is called, and it calls
ethtool_ringparam_get_cfg() to get ringparameters from .get_ringparam()
callback and dev->cfg.
Both hds_config and hds_thresh values should be set from dev->cfg, not
from .get_ringparam().
But ethtool_ringparam_get_cfg() sets only hds_config from dev->cfg.
So, ethtool_ringparam_get_cfg() returns always a hds_thresh as 0.

If an input value of hds-thresh is 0, a hds_thresh value from
ethtool_ringparam_get_cfg() are same. So ethnl_set_rings() does
nothing and returns immediately.
It causes a bug that setting a hds-thresh value to 0 is not working.

Reproducer:
    modprobe netdevsim
    echo 1 > /sys/bus/netdevsim/new_device
    ethtool -G eth0 hds-thresh 100
    ethtool -G eth0 hds-thresh 0
    ethtool -g eth0
    #hds-thresh value should be 0, but it shows 100.

The tools/testing/selftests/drivers/net/hds.py can test it too with
applying a following patch for hds.py.

Fixes: 928459bbda19 ("net: ethtool: populate the default HDS params in the core")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

The ethtool command doesn't support hds-thresh option yet.
So, RFC[1] patch is needed to be applied.

v2:
 - No changes.

 net/ethtool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0cb6da1f692a..49bea6b45bd5 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -830,6 +830,7 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
+	kparam->hds_thresh = dev->cfg->hds_thresh;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
-- 
2.34.1


