Return-Path: <linux-kselftest+bounces-43112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34740BD812C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895FE1922D73
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7D30F7EB;
	Tue, 14 Oct 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG9Ls7mc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085430DEB0
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428951; cv=none; b=m3dw5i51b7t/uNGgrjYfklvzbiZTiGBuIV+UUJfUBkUxUk/svwsV6BWRIRbY+Wgqqb1zQ3Lwb0ha0sDUpnJTwFss+h1PO49zbKK6Sl/ykbEddMTKDOyO/Di13YoQgjb3xpaaOuQ/jb8Q7P22gbF+qrLZk7NIF3H8yvuxUpTN1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428951; c=relaxed/simple;
	bh=zm7I7mmq5AscDvbVH2A6TlacZ/3e2PAL3DahCNCm4U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPPciohkxt/aydLCC7E2obxOgBrPBIYHDIs50KIZunxSyXhZtID3mGclRp+HdPYZ/YMEZ1UtAfUoqlvGTxQ7HAOWt0m70ZIfLcKjEMXl2mR1gigP7WlqT5U9hRyzmyBDMpoxYatTX9uuTC9tt9zWzQR9ZUdI7vJZlCIETgfk8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG9Ls7mc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so6198658a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428949; x=1761033749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GyH1jrLC1slm1gXZQb4T5nA8guMeRrq7L+/TaRkyp8=;
        b=iG9Ls7mctgOgLwPHiCZwYMrLi9mhkQgr4Cj8JReCXY3TIIYu9srrHvJDYH2gCyQHyY
         omNg5p8UGaUsHWvnUe+1kWqX2q2cdFgzftSPLV0/zbK5W2g9fd17JS6o7CiFLoHfsx/2
         eJ45MghGMUF8JPt78CYpiRTH5I32cVI/wHCA6IILhWAKpQzG2BGSEj3N9yXfstNHXI+o
         t/dhDyUu/U3W02iZjZZ9ZVmNPH49DaaTesQqpbhCJN2jMIM2BPx4WDu0V555Tb8Atgvl
         vY63UpmvvK9EzaqqobGeMnN1sgYMxVmU2ugLNFCEeNmsC9rc3RMrF5cw+8AxgA1cIh8m
         wFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428949; x=1761033749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GyH1jrLC1slm1gXZQb4T5nA8guMeRrq7L+/TaRkyp8=;
        b=fXxn6E5yZdFWxmgNS65uupaQ+lgdcvV+glbyzcCFVIgMGR2GhOVZgvu8s4xpnU7Tya
         vumq9bER1ZDhr0YhKh05aLv2kmd8CXLu8AlTNjc0XVm/B527ih/kMKTalkhy0cxSi/Ob
         nwIR08WESnBaqotvKSVfaBPj7rRd05EgfHL1H76qs3gH16ibehJ1jvElWXOVqsdek/tW
         8UmxkKaygnGNSFZNfasRZDjRF2mlCsciS0qL276tpYZXkHO10kq8t9v1+QfU3V5EIDan
         EyH9mCYjS19YHvriV5PdW0CqLp//oSsTenrifCcjfgU9DmfUi519cpLfbtZ252pmM+ld
         W5TA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2NtzKJQRyjtMUWFm2cxqQv4cdL002Fjzd8JKAVmPTpK28InmeVWK6sPG0Es86GgEijl/VBmm6LK8Q2b6LPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+79CHdDWpu1Jwa5/ZDnLUKPnx1fMNeHDnbhejS+qDRc/KF20
	hnPAJJmMcYxRm8QVoYpnL4M8u0y5pX4htMgbXsYIMeVYLiDZ66qEiD/2
X-Gm-Gg: ASbGnctDEn+hZhhLRYEstbRY3b4MzcTKvGk/Yb73q5G3fnhHkBj7QCaQH0QfOi4xusX
	2dnYOVkMPGyKMN92zOtaOYjoIa2mK7TMH7j6TlUWDdw0Ivm6f0YZDzNruOMVnoYI1Zb01nbPej5
	vsBTQ4ArhTMC4fCJWqv5vG7JwGeyIq0DiKVB1UgtpWrlr0We+lgEdqo5M+ospsmYnBnMmehljTK
	SRG/rc7UgkbsALO0QxbQdtCGLjdRZ68el3LVPU/zOXiElfuF/KJfxhI2YmEYd1/xyM4mu/ei3tL
	a8TKtIVuCIWjySJMpl3BpODE4swfVJ5X2+IvAWsMPP+LkwqrPNWR1sgiK+B3bi78CiQ9OEcH7df
	4frorukEhfOb3UVu4+MWZC+kJHZAJlWZ113JarxzZJXZA7f6RNwjBvyqf
X-Google-Smtp-Source: AGHT+IHgLYdPneakAA8pkp65cfa+3QOkYNTGyvgYvXWd6kxyTFqG4Cd7C1Vhd1fBH4ZNLOQ1Qrmfhg==
X-Received: by 2002:a17:90b:3b84:b0:32d:d8de:191e with SMTP id 98e67ed59e1d1-33b51165115mr31684698a91.10.1760428949390;
        Tue, 14 Oct 2025 01:02:29 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:28 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 0/4] net: common feature compute for upper interface
Date: Tue, 14 Oct 2025 08:02:13 +0000
Message-ID: <20251014080217.47988-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high-level virtual drivers need to compute features from their
lower devices, but each currently has its own implementation and may
miss some feature computations. This patch set introduces a common function
to compute features for such devices.

Currently, bonding, team, and bridge have been updated to use the new
helper.

v4:
* update needed_{headroom, tailroom} in the common helper (Ido Schimmel)
* remove unneeded err in team (Stanislav Fomichev)
* remove selftest as `ethtool -k` does not test the dev->*_features. We
  can add back the selftest when there is a good way to test. (Sabrina Dubroca)

v3:
a) fix hw_enc_features asign order (Sabrina Dubroca)
b) set virtual dev feature defination in netdev_features.h (Jakub Kicinski)
c) remove unneeded err in team_del_slave (Stanislav Fomichev)
d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)

v2:
a) remove hard_header_len setting. I will set needed_headroom for bond/team
   in a separate patch as bridge has it's own ways. (Ido Schimmel)
b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)

Hangbin Liu (4):
  net: add a common function to compute features from lowers devices
  bonding: use common function to compute the features
  team: use common function to compute the features
  net: bridge: use common function to compute the features

 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 drivers/net/team/team_core.c    | 83 ++-------------------------
 include/linux/netdev_features.h | 18 ++++++
 include/linux/netdevice.h       |  1 +
 net/bridge/br_if.c              | 22 +-------
 net/core/dev.c                  | 95 +++++++++++++++++++++++++++++++
 6 files changed, 127 insertions(+), 191 deletions(-)

-- 
2.50.1


