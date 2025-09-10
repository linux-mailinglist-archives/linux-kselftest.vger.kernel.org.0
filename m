Return-Path: <linux-kselftest+bounces-41094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F343DB50BAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12FE1656AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1F29C327;
	Wed, 10 Sep 2025 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx3SYaIq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34F29BD9E;
	Wed, 10 Sep 2025 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472258; cv=none; b=aCv+o+tz+s3WuQBoV9ojHlJ1KXEgD1ddS5wpazkwAfonxggcCyEFtcxeyS3I0aRGej8m8iBR945ggFuMOMOmfz57O2l1+ptJDEmkgQ7lWgzp5qo8FHduK7iO2d2mM79MBvqrw5qMSlLl49ylzZlU9+k5CIQcQZi35lOEgyQbBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472258; c=relaxed/simple;
	bh=D9tIOVoq6EUsBswfC9g9vPw2ns8b6DxKBVdTNrrawsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUq/pONdjKYtUwAdFVk+BBcc88gR1/m7U0o59CY8795jfFxzvfX3i/EdLKrmqoEfw52LZ3o6AF+OS29unWyifiMbKcTHCS4UgRmb43W4a0/PKaPIuhstQKhxQRFoLbWbGHLagOdziT0aHsOWGP1zKAApkPaa3C9JFVETRiq4pEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx3SYaIq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-327f87275d4so6233976a91.1;
        Tue, 09 Sep 2025 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472256; x=1758077056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/e2VV/MtHBw4hHLzMTY+8FG1iRe2U32Fp5A+11BjtE=;
        b=Vx3SYaIqLPYt+8+v7Upk+OOWumcV7ddF5zDaP0WzHFxF/3XQ/4xB4EkfN+cFT4ftVp
         ROvMdvpyOelJOT7+XJ5L2CvR613fqETKj1cEZpB9HaQCPKdY3ssy2vC6ppq0xPlqSyko
         Tx9pq4FJc8sfOBpr36stRLnUEQRns7kzTX9+K3wi+tAtUPO+4U/LIVAmPAJGLiLcdgyd
         A/wsiOkdDJNTM9UaeLdfWb7qL+l+aqdoDrq3zNjcIEwBW57i60QmmjGV396udP8DC6Vh
         13gj/7aFlzwTFK5/8F0vZ7lkREwNzuBMvROBhNPhvrT8smz+2aj1Tn2zUimQja9RxnV0
         O6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472256; x=1758077056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/e2VV/MtHBw4hHLzMTY+8FG1iRe2U32Fp5A+11BjtE=;
        b=W0HCti1hsTCPSqf9GeihAzCryMPoIB9h9ajACFnliJbhLH9+DMTtVTFKy9zm8x2AiE
         ztkTfHtLg83XTFW5mizZJgLceBUQzr410S8JITPcprtNa3PHf/chMOeIPSCrFNXPm82P
         kqkfeHIIq5HR7mvFsC+9WYGhYrRUgv1Goic6e+2BYPiiXq1KZ53Co4V0kV68z9vk3IDK
         EU1O8BDLBdEiOeAP3CFnSxGAEZyWB1oHAU/9/uhbLSgN81fwu4JFIL3E/5zlIEXzAa6+
         g5PnUMUJdf0Ieej2Qispl4OdidP422PIv1dcQya3yYU92Kj1DgWgXGiiNvd1rw4G4FXU
         5ynQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOln+5Q2f/3+IZVo4THjhCY1L0t1B1NYjXsDt2w7opyLj0+RJqfEvlIc9VzRymRpd6G969E6Jn7YaNBpRX9s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMyIhE6nw/GWUZiPsn7/KmHdL4vFOgjXKt0FWUmr7K7ECI6N2
	hFfrhP6sMgK5BZdwXJPy/QtONsu/1IZjmf2xElKrWv7rQgUHBiryk4bSfxIVwKqM
X-Gm-Gg: ASbGncu5Sjki/tMR1Z0mTarZF0OU4wkjcyP2k7w1liU8IRekz8TkBvOcZyVcBjvqHDH
	p6Tb2tvCgc2QSBeIsZ/zyWRA5ak9Nwtfop1Uq7afJoVpl6IQDO1dhiRb1tbfxSZFko3IHjFrSyt
	h3lUcDaueCXKKNfGJyR//b/eBoPGrVLwXVtrjfTWpWObl495ImkDNbSJK/qdD3WpzL2FavN0c7p
	cXhD+6O1EYICaLDyInOTvwI/DPetVPBCl60iXGhByI+GxG+gUDJtfX03MKFdsO++/QKM/5pPY4b
	7rzxueorD977ptMDm1SgDg66AjEUlJi5jFOBq7ybYXN/AO4cxumyVwrDpfrToE0eLdvrewJ6Gc6
	Q299REiXjjon8OFoXO8n3KrcQzB9gsx6qICoRB0shRNbCJ6ieA4Sx
X-Google-Smtp-Source: AGHT+IFjtN3yU/znp9HKa17q+iIi62HubbrIJSqUpeV+gr3m9oZMwl5tpNjurMjB20KDWtpfSZo2PA==
X-Received: by 2002:a17:90b:2d8d:b0:329:e9da:35e9 with SMTP id 98e67ed59e1d1-32d43ef6f0amr17273095a91.2.1757472256480;
        Tue, 09 Sep 2025 19:44:16 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a3f3facsm1065784a12.7.2025.09.09.19.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:44:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Qiuling Ren <qren@redhat.com>
Subject: [PATCHv2 net 1/2] bonding: set random address only when slaves already exist
Date: Wed, 10 Sep 2025 02:43:34 +0000
Message-ID: <20250910024336.400253-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 5c3bf6cba791 ("bonding: assign random address if device
address is same as bond"), bonding will erroneously randomize the MAC
address of the first interface added to the bond if fail_over_mac =
follow.

Correct this by additionally testing for the bond being empty before
randomizing the MAC.

Fixes: 5c3bf6cba791 ("bonding: assign random address if device address is same as bond")
Reported-by: Qiuling Ren <qren@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..8832bc9f107b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2132,6 +2132,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
 	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
 		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+		   bond_has_slaves(bond) &&
 		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
 		/* Set slave to random address to avoid duplicate mac
 		 * address in later fail over.
-- 
2.50.1


