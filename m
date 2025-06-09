Return-Path: <linux-kselftest+bounces-34493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32255AD23D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2978B7A16F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299921B9F2;
	Mon,  9 Jun 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE5HSZP7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996221ADB5;
	Mon,  9 Jun 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486349; cv=none; b=PD9cxr9ubX9vq7gtYue4YHkZZLnZV8EzHw+Pt/N1CQYiTSAYcLoQbsvNmpTP3I3GcAdE4g0HoPz0jbibxiux/ITwMjfgEP5gjNPl5xCJ+PXf3G5rhY6FR3JnZVn+0n/yXqdFZ/uh1OCuQ+3/5z9QZcwec0GocEt0H3JzjTWhQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486349; c=relaxed/simple;
	bh=gJFmnMD6We7T8CJJ9MqQYVPFTCjVQwwgiQcPRp9KYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHsDfRAL4DZmi7TgLDxj85mRykT5jJY+b5W3sPhUkcwt214LSgMs50+duhGPabsWknGAKvg99IvJ8TBHZ0GJlzzYlImjexXyPlZ3z+KP69aEZAd63ZOZXicmqAyPLc32c6lQ/NrVsZt0RNEisR8HG0NUQw5qRTQqjTR26fsysiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE5HSZP7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23633a6ac50so4301645ad.2;
        Mon, 09 Jun 2025 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749486346; x=1750091146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIpCecH4yJO034nC1LHMnR1mqJnd63DXTBjtuXwa8mc=;
        b=FE5HSZP7dqdPNVPKRkgpY6mnZrQD4hXKzPvYiMJeKLVRMuDWFRQ93lDpn9g0dMh1ng
         Fv6/gozhcn8xU6I0iIScqnshfkRjbN3um4JJZap2rGhJkpNxCNHFpvhORKdMJtY1FDvZ
         23yeIHoY/JbG5icayX+TLQsAHO9Z4Mq3PEeSyI2vgJcJXB13HNeAnM+4v3AAI9rsc4cV
         jINQwRnrVi+wkK+AjCYEQ58a2qsmrz8/geTlPls8AEykw76A06H6vElkaVfBcPNa+Q4p
         486BpzEMSrpDIQgGbSzs7llA1SkHykd+ZbhFf8GU+1LCDcaESbvErg//aiBj+bDrwNXW
         +kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749486346; x=1750091146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIpCecH4yJO034nC1LHMnR1mqJnd63DXTBjtuXwa8mc=;
        b=G+pXNhp4wCilAMQUh4hEmqQKsZYZVc52a9EZ0baiWl4dN7SDl2cQ/2IIEZ53F7mcCM
         GKvgku9H9rK9tQf4tLxxDNTLuU/Foy26ez95Wbpz4uo+ggXYTq4YOt5xEt7AnJMGpw3u
         QHw7iuWZzZIZigEl9DGskmQhNYXHTUHDOQaFwxNGn0UCYvbvq0uiVTsvf8BkyPsfMaw1
         O6hj3CRXl9qA9LHZdYMYaV9rB32nMj0VAlrboScvd2VJbEE7k0Qm4S/hUCV5YBnEPE3b
         TkfCkWAvD/fArCBnIqxJNpu1YTcPRk0OMG9kr+uhEUHgpq+SCoHITHvZ0rpYfXFiggj2
         J9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUji70a+UFpuQvqTv9h/GNC7dTW6nMrUhjodMIEiMqY49GqAgwjrfioB3TBX4DAKsTyMs3R4XQ2lHi+7GI=@vger.kernel.org, AJvYcCWGnKpMwzHPidODFJt6HYOqq+Wg7v6t4SxNBUzeeczY4RWfUdCTlGCmCQKxXEG/d8RH8VkpmqIn2gAXh/qSfprc@vger.kernel.org, AJvYcCWnMvwWauLACO7rx5kfieNenDsh1dibeNPB0amssOPQo4dIYTPkVkC/o5J9TzXosjBxwMSS97eoelBtlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2+P/cPK5HLmknnQ0mhnVx1nBzE7QMYQc5o7tl6CoUnO3gI+Y
	zrfK8xiIKfF14PsCMgADs6/AqZPqX2O6x0zrcP77Jyj7dVDDqpACNhoJJ6hx
X-Gm-Gg: ASbGncsCnWN8FpsMtUVRFDeUtuevzIL+gUK3PpM/Qfn2e55CEXdiFo17RGGfJc8atEF
	uDOQkSVbZjFeAnlgDJ3HzPVTCdOPk7hQl0W5eXkDJACVZpkfEWHh4GhkYuyO9TD06cDc8JEmfUo
	3mAOCR2TVHRDKSBB7jOZ/ruxLrLRjKnPdkhW9GG4TyMGUvEV+F9VR0XwSX2jph+Oj7qXd22wtmC
	X7KRlUhLWMEpEIme5wCykN6Bi7oKjXNy1yv4kLlB47VohKxFG1hYewrwmUrYmMHQrTmzqixrM/Z
	Lfz6TJHc6Iou2fNcfw1vnk8me64qeXYaKZzSjJf+AOWfJ5ZtPYHRYCUZRZuUVjxv0fqbruef9Oz
	zA5S82+QleVp7jLS4JpL2l3M=
X-Google-Smtp-Source: AGHT+IHYVWs/aBeS3lTlg3/K3udkjbze0k0eLP7AMX1rK05yCKVcKjArQ7KqvyIMbRkK2g9/HnBNFw==
X-Received: by 2002:a17:903:41c8:b0:234:e3b7:5cd2 with SMTP id d9443c01a7336-23601da9abbmr211770595ad.46.1749486346165;
        Mon, 09 Jun 2025 09:25:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603078936sm56017125ad.21.2025.06.09.09.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:25:45 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	mheib@redhat.com,
	ruanjinjie@huawei.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 2/4] net: remove redundant ASSERT_RTNL() in queue setup functions
Date: Mon,  9 Jun 2025 09:25:39 -0700
Message-ID: <20250609162541.1230022-3-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609162541.1230022-1-stfomichev@gmail.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing netdev_ops_assert_locked() already asserts that either
the RTNL lock or the per-device lock is held, making the explicit
ASSERT_RTNL() redundant.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/core/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd5..72997636b8ec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3179,7 +3179,6 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
@@ -3229,7 +3228,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 		return -EINVAL;
 
 	if (dev->reg_state == NETREG_REGISTERED) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
-- 
2.49.0


