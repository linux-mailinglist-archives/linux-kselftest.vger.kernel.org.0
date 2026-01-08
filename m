Return-Path: <linux-kselftest+bounces-48491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74FD01D47
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A6F302E718
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9D42C3FA;
	Thu,  8 Jan 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="N9ekjVxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69642A136
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864018; cv=none; b=Q3rDBqBJUx++7c8Xd95O7ZtP8foKH5PTjrlrp6sAK6BrXd9qSRIYauEMiXftiGzfcl2rsb7WMzRpoqglzX9gZ5jgTA+qKyu9v8s6IfFSJH7jFoneIuK4aOLmzmLrSaijQDOu7BdPW0By99GGQJZhC+hnBoxeWpVTuR4hzZ8X7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864018; c=relaxed/simple;
	bh=DG8cT5egglUbcMbgq3vHZoCNJC5DKE2cmf1JYXKnNvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhziZ8lsWBi8N6np9BU1w0khaqvmv+dkmo+OTaOuQ9Qdfn75nYrU82FvbmWtGKVo54V7rXFkIM3HRdjExTpn6pp91M434T50oQ9I23fcxq+oxX/TuS+4Gnrq5+Mvx1xOvZiyj0RbFsdCrsd0ccU5bLKKR9fNi7iI3wYrK6PtOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=N9ekjVxv; arc=none smtp.client-ip=74.125.82.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f99.google.com with SMTP id a92af1059eb24-11f0d900dc4so102311c88.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW9SsgZLsT56tsZ5FPzuxlQOX/d2/F2cU00tFSPwIi8=;
        b=N9ekjVxvI371zSTfO5zIZJIn21fYH8SVGNE2PKYBYMtPdIZIXBJqCBwIUm1OWWIYTu
         ykqjXURg0imrkLWLBEm3gXvLST+v9pvOYlIWbSJebYcEPM8BfqZSDnp1Ug/Yvm7eJdTI
         pB318qsLeH47gh5zKnT/SPMcL6TDIHFuG4K76+ECUSlHxMFBujJ6IwXCq33RwiyYuWuU
         HVuNlUW6BkHTpThlAGHR0gyhJhuKu/m0IE78RKGvjDUOuYAi7WyTsa6rqdC/2YNn2dfg
         ulVgbqyxbJ31xbEy98/TlbfzXQcIgsaIcwitywRJxp9dNbiachS+xSVVgNJ0B3rLDA+k
         WBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gW9SsgZLsT56tsZ5FPzuxlQOX/d2/F2cU00tFSPwIi8=;
        b=vz50ai3hCLLVqR8Sh3Wmv8sbzmFXBDEoiESsH6a5EwIgY3/j6GALhq7GMvHNpSQ3HY
         D+h3Hb9XrINyZL83ju0Zb4dXBPDn4fAmj42+9Zo+QF7gAh5KaWNpfRymNCZeyvPJX0G5
         jaBiFzYbIip8Qzq8BlAASIOIXuVtkdnWZ0AHTYiwpqX0xS2WNWDxxzOJ6x4w9eNcmBaz
         TFzPhnakl9VQotjivU9I9sjzKhHv4xur3o4QvO9zOmQ6C3ZTa2VjOgvfWj71PUStkev7
         gVk3IWUFsWZuUg2rCDNV3gJIWiOkLmqcryzlC82Id1mmxorWHzNTVQIXbcbc/P4Vx6n0
         72lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4+haHRkM1b0LYdiQf9V28PtHUL0/jg6waayMGke4uZSvqUbicrvf+2dXG7lsbv4j0h1xBALOl3pm/67WR8rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZh75eRgsZVWDjslP5y7T+hINi933xoDFgLrkOgKW7D0HJM+fv
	5Qmi5VQ2cfM1LXywqlMtO9oc1W7FOMECqbTEE9HCUwcJhD2gP4BIFLL7AP/VrTxQyaub0/bPi51
	ZVp38KCi6xmv2zyS1q+z3EUxbLKpkshyODvyC
X-Gm-Gg: AY/fxX6Ry/wALb7cgaOBO5ipu8HKatvnFrF6w827RxhFt395u9b6kt6mAn7+bzvxEWa
	D73XTwzPoUxRXGTWcn6j+aqsRzqHHhtjd0GDqWmn47bB4uQ/6JjFCbJHOd8Odo75ufj8fs+Q2Ct
	5F/B3mkYDRf0wqshg8usPrI3/yS2j84stKjrpO8KNE1w3GuXTk9+kVF1KnvTTMZejDCVljaBnbE
	rsIN9Utc07HnImEfFRJqx9h8dabav8h3Aqy1eeBwEpmoxUTS3CqE7cS+wI66zkkCm/2uud4gy4K
	vprX3ayO1moAvD+rvXrO4QL070NUZnpR60cWvti45JrQiV3l4z1lSlh6PoYSLx+HWN7POegdBY2
	KV3tu5ZZrEF+XSYkEih4xRzbfOwr2DXOcDQv5zZoh+Q==
X-Google-Smtp-Source: AGHT+IE/kBJmAenA7OHV8bMZchiak2YgUNV0Jh2fIqSK7t7BrW+Oj0EwFqF849WShUKzill49TjNtmW2L7qy
X-Received: by 2002:a05:7022:619c:b0:119:e55a:95a3 with SMTP id a92af1059eb24-121f8b92076mr2680115c88.5.1767863996918;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f2489521sm1704761c88.3.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 78FB63400F7;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 732EBE42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 10/19] ublk: support UBLK_F_INTEGRITY
Date: Thu,  8 Jan 2026 02:19:38 -0700
Message-ID: <20260108091948.1099139-11-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Now that all the components of the ublk integrity feature have been
implemented, add UBLK_F_INTEGRITY to UBLK_F_ALL, conditional on block
layer integrity support (CONFIG_BLK_DEV_INTEGRITY). This allows ublk
servers to create ublk devices with UBLK_F_INTEGRITY set and
UBLK_U_CMD_GET_FEATURES to report the feature as supported.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: make feature conditional on CONFIG_BLK_DEV_INTEGRITY]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2a8a6a9c0281..08674c29cfdc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -73,11 +73,12 @@
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
-- 
2.45.2


