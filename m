Return-Path: <linux-kselftest+bounces-42038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C8B8E7C0
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 23:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE733B92CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3762D94A5;
	Sun, 21 Sep 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exP9qs56"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AF2D73B3
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491784; cv=none; b=aKobgk/qpTnLJ4XcDnF3QYRNrmGlgrBQHZd0BvfGzDJGRf7/3x8NHNnEySYx+xsmfFvZGG/zJ1DEn1sluW4JUMqO84tvCHCx5R/jbL53ol1Ps1+ZGq4WFe8ApfNn9+BjiZFeY35Nv8v1dQaDg42CCy+efdmliyRzZHCny1be3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491784; c=relaxed/simple;
	bh=5mhr6jsCmNwNcnFO+5SOJs2r7HZGP3JEvC2ipj5IjA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Telf9ARdhM6CfXc01RXlejETdArfUIrRC+COLKZbCgmh89Owxk1mqJN3/eTcF2whQKF63c+84ff2Mj6cPjOjVufT9uxKqiomqpk9Bgn5J1cZHpTzYG0eYV75XKvMbacErC0tpfRrZjSNBPNNGufUEXekuAR0EH01mhRzQRcZogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exP9qs56; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1870048f8f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491781; x=1759096581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIdf/p+W7Ujz2zhxctFos5mKw5BeHeIDmEYf9Zo81XM=;
        b=exP9qs56EheJ0KTyavSfU4CutrSm3AZGDYNksp9wcRVQqwpjuPXEnbFGpsTif0XOEj
         u97F3L0MneGN2XahP07v54YBvcxyxGbmYw/75jwiwHV+w0EOroaskCGD690GBiUbGzkJ
         JIL8Xy0qpxzObRNfNLDW0vCq/cdIRvXpQK+y6n9ilojXJqZ1ECqbG4spQPEJl/hb7qav
         2mKXShJ2Q9Ya4KmLyDf5/k+8ahg+CYkbqOkVIfni//AtjW1mSMPdk89XzTWPAk6XaYHS
         gODsMJwC5Bx019xmpU98NUsm2DYteFt7Bh1KFUZXnB7baUF2oBc/Zi+I/vm0GT8YNTxQ
         VTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491781; x=1759096581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIdf/p+W7Ujz2zhxctFos5mKw5BeHeIDmEYf9Zo81XM=;
        b=CZ+aOfbaCNzdHAxY7CIdx9RsIl+AIbHL8k8sOeqaxWFz/7K7DX0wOoKUp1wUktuG6V
         0R8s6oxUc/QFjzOjj2zdxf1KL9Sq8XGZwLcMCDo/a3iYDDLw+VaYm3LWPemefW5+kasB
         SNel8yGh+7RxyHyWUTwYee+tMpXSxQwMI7nkKz5AauQ9wc3Hdq6e0j+ciN1rq8aRXoce
         AMf36Wz56KHS1VRv1WbpTzbsFiSVAgp95kaE4JzfJWwpvw7FqFxYNuPtNCLGEkEjbVsY
         NCrbJW6ijnUH59/Uwj5qaWyvGT7tMNgF/+1JFhP1cQJlXhMcaoz2pG4cgdVhVOKhUMSo
         G9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqt9Y/y9uBsllqFdL2BkuKLc6n8larAEMebQkFZj/jZDf4AVPa2OiqlhVppiRg0GWVcyc+C+3jNfsfnSo/Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaU15ZH9bh0Y/tesPIR5LoAfLITqG3UTEG8bZsy96VCBchvfHx
	qWjr6xpV5yRDMYE21wGb4KaGqCnQ2f6hH2AbUGjKnne0yWLH1H4EvHlQ
X-Gm-Gg: ASbGncvCEm6BIg1QPV713Jx21RQ4/HJQe3sZJttc74AY43jwehZLtpATzBr9QhvU6kB
	Rtv4RLdPeb+5J9HaRSFfZPbJ2Mkf/as5M7VeF5upg1y0oXpcGxgzGgo7aZlADgcBnsShcV4x3Nj
	675AVocUbx4fIUkCQoRN3fTByvAjz0FOfGHOGIB2WtfxEIPX9zfFa23XsJFHox24vbU27sAzv1J
	2Ri1O+VRmtYki6DHlzbhE9tXomMvnterJuxT2wYh1OymedcUcDW41HgEf391FykO1ZmGsyBObIo
	ynIMCS2Pe29tJYIpiom/BgC9wY8fGkgOJWFpmCUAWBOMFI5aDO0WkBFOijkS7Lqv56IJoV6Ljfh
	Rrgagyi9O4YHhEkFUf2t6lAGPR9w=
X-Google-Smtp-Source: AGHT+IGmt6XLl3zQskh0zYm6CtZaqKN29aHDDxgwtm82G8MAOnuWyw277HU2wC6kT7gu0jDroko1Iw==
X-Received: by 2002:a05:6000:604:b0:3ea:80ec:8552 with SMTP id ffacd0b85a97d-3ee87327999mr8985604f8f.57.1758491781147;
        Sun, 21 Sep 2025 14:56:21 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:20 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:43 +0100
Subject: [PATCH net-next v2 3/6] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-3-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2084;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=WsXzbr4oh2tgdkoPqzROUayYBAGNEehpMnq5WhfJccU=;
 b=LhIkGrcYxDjv8+RfVaEAQ724BmARmMrU8Kdv7X/xIwney+vtPBHaNAwvzpolmZrkvi0FXESSg
 D+YOAd9sg0IBqJ2kuYBNebJb9FcO7xuXnyWVV4iCp34zyq0e4cZ4Wn9
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.
Mark the device that is down due to  NETDEV_UNREGISTER as
STATE_DEACTIVATED, this, should be the same as STATE_DISABLED from
a code perspective.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 688ed670b37b56ab4a03d43fb3de94ca0e6a8360..59d770bb4baa5f9616b10c0dfb39ed45a4eb7710 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1446,7 +1455,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->state = STATE_DISABLED;
+				nt->state = STATE_DEACTIVATED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}

-- 
2.51.0


