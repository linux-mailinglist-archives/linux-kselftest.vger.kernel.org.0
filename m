Return-Path: <linux-kselftest+bounces-30043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B56A79BBD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 08:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED82B1708FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190219E83C;
	Thu,  3 Apr 2025 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVEDU+yw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703882E3365;
	Thu,  3 Apr 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743660282; cv=none; b=GjF5s+Pl/ag4maoX45qJfO+/6KEspIO9gwoSElFGJ4DSmAs88+bO/Vr4iKtcxhcNQ5QC39S3SqaDcYNMKj6op9LzOBgx5+x0MQXFiwoSDu9Tg2EMiETBNMSWJhkqrEQ6fvTJIik/HBhAvYCa7CbhxnhDOXEq2oGvBop63shtZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743660282; c=relaxed/simple;
	bh=EDye05dsnyrMncweEzXTa0ZsocH3DBIYBUZadMP5ZOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5lYSP+DqE0klDg3cbiv1bmici4krCuPBv0j/y1Et7clxngLQ4VUdCtr8xmSpS7UASXWVG8INe1Cb1JVT+kWPqYelRc9QFOmpdpFDIr6kY2yfslnCO/J45rk3c/T0TBZqqDwZOuKubDMKBsZSNG9ltEnwlcWesrIFd61V1HXKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVEDU+yw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227aaa82fafso5577715ad.2;
        Wed, 02 Apr 2025 23:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743660281; x=1744265081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMWz8BrcdL/ag4zgf9L4Rza6vwBAXPSPwY8SyGUExDc=;
        b=nVEDU+yww+2RGO5lx59/WvNYXCJv9IKFCizB48hwP3jipgHHpHiRs1OrEpP/5urBCP
         Gs7hZ5K+l2VPnIoPM75CF15hjRplht5MQeVw6wal/NvAqjuNLEyli4P99Mr5P11lY4hv
         XupDaU8nIcDQQR5MwVi1mIOhO2ewUmp29atqVHnKla+XOTwncpQnXW7jYAxDihWWjVFx
         7vrH+684wJsoa/I9D5xLuJLQw1X8sEq1GG56IoLdsE+JIeplc2/hT1Ara38cCdBL9mDx
         RCReAogVRXQhoLAQTBL99QpdhYjYCMw02UTYFlIAozq424y8QR36msPmEg/WDf95E2ou
         EuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743660281; x=1744265081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMWz8BrcdL/ag4zgf9L4Rza6vwBAXPSPwY8SyGUExDc=;
        b=k84V17yxrumHaa/ucg/BqHP4Q1CvgdyfAbTGD9Y1BW1u/x7Stp/EcCIfXFaHjZclIg
         lC5SKjYEXYvqcZNm9cWw+hAKGyCte6m04wsosdjZyB24eGZ4+ueLZD23Pzgq2Qaer0w1
         DNeWdJVko+alkNiyPVc7BAI5DTLJ6hqL6TQlVNDEpnJNkHFR4UQaASR48wVPg+GIKkxE
         JO3JeFFKauEtgkiFPX5Yx2pCinkIKZrme62uqXDcNrivKa9HJbd0p8P4Cs4aqDDaZzRR
         BMwYexe5YFzmhHLBDIvhrfurp0bad6YNro418medktI+kj3HItEGcUhl+Eu5Lp8D6VBX
         t0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwDGt/O0UZ6TAgVLTFazln5c2wc5V9lYdjQKdH0aPK1DmKUK6ncQtAD0XLGCyUEbZuqh/lmiFA3roK6MBWZdY=@vger.kernel.org, AJvYcCXdMbHyp5VQoHQ6yWv+v39kxcnRg2RUm+bKjRfP8n45Tr9DQRuy2dySIpF5wfFjivaEsTyHayKK@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNwRizxHIu8VWrSECH56dqOJzRc6m9BwYQHMILxg+P8yPx5qt
	UYnTdMNz5oqUwWSdx6AcBubJeBC9fIRyJENRuVrLVdYJUc5jHGqc
X-Gm-Gg: ASbGnctQsGcNH4xXfSFGpI+zdN+WgH3qBN7DGicypFxyntGVxYF/f16iHCHPojuK5MQ
	Ewic4mRqPVEwaW+QeapzshAE+dh8yEc5RaLYA2uVDpvKQccpBvcQ7YFB9nJPSrC8eJwQqS0KZNM
	1ZIwCLy882hm0TZ78CR5LdZLbXk8Az5VFFEt9HGgu6DxQ47zWdubbfbDCkujAPqaqxc6wjz0ZcI
	25U9NuzIMaJGAwL4TFwFlsIBGEeEWIAGeP0ikSRzZuACNQAzVVZpsSYKtaLp28Rv7FXjZujwhTa
	aX9kY9Mkp3y1EgKzAQdlT0SyWApCD8ZmuA==
X-Google-Smtp-Source: AGHT+IF6HC0JY72zZoF5DR3ldPATrzb+moz+S8Ga7FYjv2fp6tWgfdKHWYCuA3oJrb+geNUx+2ouIA==
X-Received: by 2002:a17:903:1a04:b0:223:6657:5008 with SMTP id d9443c01a7336-22977dab04cmr23444235ad.24.1743660280477;
        Wed, 02 Apr 2025 23:04:40 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e3141sm615340b3a.173.2025.04.02.23.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 23:04:39 -0700 (PDT)
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
Subject: [PATCH net 1/2] net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh value always as 0.
Date: Thu,  3 Apr 2025 06:04:22 +0000
Message-Id: <20250403060423.1209435-2-ap420073@gmail.com>
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


