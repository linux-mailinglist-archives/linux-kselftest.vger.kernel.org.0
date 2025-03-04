Return-Path: <linux-kselftest+bounces-28203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CDA4DEE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205AD3AF1AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA01202C23;
	Tue,  4 Mar 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlUsRcar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419AD1FECDB;
	Tue,  4 Mar 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093894; cv=none; b=I/ULNbRPsWMgnn2/iNzQWj650gi1GJfFw3LVzfLtJC/NF0vMigl3y8FIyFTUxNear9De6rwd5ckI6MbKli58I3SN1myd6w67r+kwjZmeB2h1JGLTQ+XFThuT2RsD2lj86alv5NXkbrh7l97u9ca7qTLVWnafWryIZzEU6rVReQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093894; c=relaxed/simple;
	bh=rZSB8ttJc33k4p7Ftc2PQRAgzsvuJBhIKVv79k++F8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHK5uZ6w/PcL0SGdfdB2WJc1FBUITT3dVeTj2JcfwuKkbJ10HNl5z0nCQWpxTRIKuYSNsUFwMUmDoJSt66mmHrmDYTbqVJdpcaM9ViecYVB4bJBjpBMOnKruq8xI9vvVQdoX0bRa2UKR66B0z+6yokpxpk5HJR8hhpShIEjjp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlUsRcar; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22337bc9ac3so104926585ad.1;
        Tue, 04 Mar 2025 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741093892; x=1741698692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoBQMXTscKMSBK7mXc73SSB9UbMhqYi1iTf6fQEcMsQ=;
        b=OlUsRcar27PSEQ1qreMtXJCQiaLyBmQGi/cA2ccE187sNJ9F0/irXW+v8Y1gHjtnWJ
         9RsD5bHYasw4zOpPu97hLhCA0IIAkj03wvgUQ50l4/6twCDqNFryIZh29uX2dI1yQ/SL
         ELwOzVOFsMEcbcesT+wEUpEmsQXKaCLITvZz26Z0dxzFaZScduIz1GME+mnMJfMxbz7W
         muwu3LUh6o0XY3qIOql80lVHkpSt76WcLFqPCGt+YdkaZVCagrPD0YKi+4u6OFGywbHe
         oa/x2bVXJMUWTaMpWk2i5fm0wCp7ytbYDAFgHbs+epNmvPyGEKCrqseGSplsHQoIavW7
         hrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093892; x=1741698692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoBQMXTscKMSBK7mXc73SSB9UbMhqYi1iTf6fQEcMsQ=;
        b=F/g1DUFVQnX1BU14G/YT2A0bzK9Wefn+2lA/OHgAAgtsKfd9H4GJTC0t+wT4N572Wb
         kAy4qWSzo/8eE8OwkUPW+T3TZ3bqVyW3bTKRlhkAUyPcQtlZhDbJO2W9NsrWfaXekBF9
         cBZTK/VmTbvrUyLUlLSJjxF0y7pWcMZL5tHcsM/1RAraGHlS7szxSsUkDysvEWSSNJCw
         vB4g8t4WKqVOFggUkpimQfgXnRGejH5xHlgZTRiU2SZ4n+6+kXMtXx29YSINq28uvvYW
         kbCMq8lkMB0VwkgEbdchakyOphC21ebDFmgd4Ft1XUBqewU3k3nWoKFsqljDxqiC0ukU
         07Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVPS8nAsgZHJ5UrUeKTT/NOAYX/hfAcPiUZ7fR9aTIc8VKBhrIZ4FbaDXPFjUgpouzSA7zTbdl+AnrwYYnr8WAQ@vger.kernel.org, AJvYcCWHKaf43IioxeDBe9PZmEsEgtgV648RfJQnU7ZHZTmIYwG5kQtCQkV4RZ2SNE6lAV/m7DWi2KgudLn965c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7WXACygzgGdv1EBFBM0mNY6vmx6nJb+fHppjfQgK5mObtFRM
	qEmunVoSb7la9T2KfzHM/BsYOq3uSvVmRuLKPWtyxmjYFmBZbB7kJuv6du3e5r/lIg==
X-Gm-Gg: ASbGncuQxJi55C5Zp2QQ7dEJWQ7eBtr+VGfp65yA16q7+prrdAxEzM6F7QxDxTzS1T9
	xiT8uW3EEiv73m2tzDViWq2DVRAROZydbVfI/7pfKo2NvPoanyTXTvAZM+Xa7SkTNyj6qIhws2e
	tJ5fW0hK9VgaRpHdzZmPld+NXtgnf6Rs6cxynBMohhB+2kXVl46XEX31Hah7asdKpDG6h1Pks+O
	ozUCf4/q70yr371LepW+ySfGU/9+BsvpIKzpsRaMY9REjyDh8QoBZfKRVca9Qxum6fQ3CEXAWm+
	lfaxKxFqarXIlnQNLbg/YknPopU0vdpgcE2OEHfOeAc/XNo7brJIrmV+wjNXEinL
X-Google-Smtp-Source: AGHT+IEfsnSbzTHyDxFsr+hqkwQxcQYjceyAHDwsu2spopC0Uu00vPNa4OOk9Ujk6+K2F17feBA/Yg==
X-Received: by 2002:a17:902:d2cb:b0:220:dff2:18ee with SMTP id d9443c01a7336-22368f819abmr268409195ad.14.1741093892134;
        Tue, 04 Mar 2025 05:11:32 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a668sm10824199b3a.30.2025.03.04.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:11:31 -0800 (PST)
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
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 0/3] bond: fix xfrm offload issues
Date: Tue,  4 Mar 2025 13:11:17 +0000
Message-ID: <20250304131120.31135-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes the incorrect locks using in bond driver.
The second patch fixes the xfrm offload feature during setup active-backup
mode. The third patch add a ipsec offload testing.

v4: hold xs->lock for bond_ipsec_{del, add}_sa_all (Cosmin Ratiu)
    use the defer helpers in lib.sh for selftest (Petr Machata)
v3: move the ipsec deletion to bond_ipsec_free_sa (Cosmin Ratiu)
v2: do not turn carrier on if bond change link failed (Nikolay Aleksandrov)
    move the mutex lock to a work queue (Cosmin Ratiu)

Hangbin Liu (3):
  bonding: move IPsec deletion to bond_ipsec_free_sa
  bonding: fix xfrm offload feature setup on active-backup mode
  selftests: bonding: add ipsec offload test

 drivers/net/bonding/bond_main.c               |  55 +++++--
 drivers/net/bonding/bond_netlink.c            |  16 +-
 include/net/bonding.h                         |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 154 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 6 files changed, 208 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

-- 
2.46.0


