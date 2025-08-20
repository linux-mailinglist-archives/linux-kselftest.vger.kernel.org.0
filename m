Return-Path: <linux-kselftest+bounces-39362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65BB2D807
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0F45C1AC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56EC2E0930;
	Wed, 20 Aug 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1flvnf/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EE12E0922;
	Wed, 20 Aug 2025 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681027; cv=none; b=g9Lh/DVVPJzK8TOO6RqSVL7U4KAeX7lQCkdn/kvKiltV7+XoBdMrfduSv19AR2+fW049QZKMBL6ym18h4QBFTCGQQwjW/k0dQcemk6Ticj5u06P8hMw93ECr1p6Vw6JI7biKpHAECD6jSGt8TpKlUR+DWnIoTYDdgj3bLgxGInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681027; c=relaxed/simple;
	bh=WSOBIYV3P7UzBotnBEX3dg6qKXFCYVYTcLeOiOhgmz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzKXBOXNm5n9MSlYkG3lMXkNCIqB60pAD/otduRK69TZkX9VQnJbEOxS66RkqQRaFUkQSB+uIdU5pumShHdnPDhKVjZQzvkFEF3+8w6frKEwoYaCwWtklG0PT9TqTjZPW8tMzcEhNEUDXM8/uPSc+NJIvtjRTMpNNmC6GqnbFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1flvnf/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244581c3b43so55400055ad.2;
        Wed, 20 Aug 2025 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681025; x=1756285825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oybvmwILJ9FHfOcDE3mUgfBE+Yl6W4C2NSfYGGiS2C8=;
        b=M1flvnf/Mv3RNsFgXPRjIbo6k72t13oGDI/guzzuRzeVoELgjqoPV8Fe2za8nERxtQ
         82PHhYf5UFYapx1RCo/NNWm8A2cbktI0up5ToN953dLoJpMKc6NHNMXFOsGe+W7VDV48
         7IP6KueSjdCYL5IAuW4wuTMy5QuEzkW0mf13rIA8BsLAM1nH5tlplzxu3SflWYCB/yNc
         fKFtThXSEn6W6e6jvcykmOBNVq2pNxE+3ALoZCMr6nYwlFtKoQnYVLp3aEJZcrn7nfV6
         A7AVhfKcAy3Cmvw3xyDXoDLpDH6I2eUV/WxccAKgoRm9IQJqv+U3JDk0uESQ9lF6jO4l
         NbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681025; x=1756285825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oybvmwILJ9FHfOcDE3mUgfBE+Yl6W4C2NSfYGGiS2C8=;
        b=CGpZ2EubJastgi5UzkyprKQAjLEnPSEF0dQrL2RAlL7VLZP8BBwkNLCMhWxbbCW6ef
         Ig8v8Lt+8rM1OJwTrFttfbw28OrpMa3TbUHFhkGin8AWB4MCG0lms75/uqDofA5S5yNV
         xE019R+iWM0ry4HqFqWEgBmG2zTKQBcvxjJU+DSY+HMypJR6U6q4DncSK7F5cyIX93Ch
         JnQE7D990Ud9E9Iz/zJXhZvsgmJ4VrkKW46F9MRnTEb3qzT1FVp/bV08Z4tO9v4dPCrd
         3lV7BHL/aPLTGZAf8eFDtsdrGG5hfCdb0Z1MlmJ8Fhd1IHXt9vmAND1IletA0dCpZl/R
         uAnA==
X-Forwarded-Encrypted: i=1; AJvYcCUpShFzkCJJvh45zGnW7nVmFYN4vYNVB3c5/I5Eibsvoz0i/N7ITC8lMN0BDXDNQeLjQ3tUlp+lCWiYgEfdN5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYgH+qGn5PYF5WZyoJ+8Shu1Hp+DlWWtyx9oDqQWNNKxvOtZ0
	PFMg13JGK5GIB5RY/Mak1DhaeqHwFCdSmfmjuqBnXTmTdShre4dKtddeSdmG/zXq
X-Gm-Gg: ASbGncuynthV+GoBM+YybITy69moh8TFuOFBGij3Cgd+5DGGbu+zi9czL7nU4LvfTxh
	pxQBMvnlNf84wbP5/6eo+7Wo+7PByB9t0IzmMkbLl3oIXXYlCfFBP+4WjYsLnB5stqrC8DkkbLt
	1cXfqlxRxhNesQ5CbSIcJV2xVHs2hgwLEMw+AID6o9iaO2ruPX71WPGBEBrmwxbNxgdc/j/FSp8
	nlU7+KZCCinwgscC3ja5+M1tDekxD7+8nTtjpmWpJTi+h4c4JmfYJkLARArjS7RddRQvS2cbwag
	u0QGsfFJN2dbL/SzEjj951zltag5oT+jGt/FmzUT4wtpVnu9K2v/s7NGh2KjnzI2axLZGgOwYph
	eAalIq0qjUhU+4ZMYUnPSZFo8BrcoJJY3FgstUL75Gg==
X-Google-Smtp-Source: AGHT+IHv0XzSOZ9cnuXCrQ1EAZpgiEmil1HjXOWGHrsUHeoKpy+U0yBAjHOOZmKKodqD8BI4VnDbDg==
X-Received: by 2002:a17:902:f550:b0:242:461b:7d4 with SMTP id d9443c01a7336-245ef153687mr33269965ad.15.1755681025256;
        Wed, 20 Aug 2025 02:10:25 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed339fb3sm20765765ad.13.2025.08.20.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:10:24 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Qiuling Ren <qren@redhat.com>
Subject: [PATCH net 1/2] bonding: set random address only when slaves already exist
Date: Wed, 20 Aug 2025 09:10:08 +0000
Message-ID: <20250820091009.393785-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 5c3bf6cba791 ("bonding: assign random address if device address is
same as bond") fixed an issue where, after releasing the first slave and
re-adding it to the bond with fail_over_mac=follow, both the active and
backup slaves could end up with duplicate MAC addresses. To avoid this,
the new slave was assigned a random address.

However, if this happens when adding the very first slave, the bond’s
hardware address is set to match the slave’s. Later, during the
fail_over_mac=follow check, the slave’s MAC is randomized because it
naturally matches the bond, which is incorrect.

The issue is normally hidden since the first slave usually becomes the
active one, which restores the bond's MAC address. However, if another
slave is selected as the initial active interface, the issue becomes visible.

Fix this by assigning a random address only when slaves already exist in
the bond.

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


