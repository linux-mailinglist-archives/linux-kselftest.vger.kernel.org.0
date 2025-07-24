Return-Path: <linux-kselftest+bounces-37931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE54B10342
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100E71886486
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4A273D75;
	Thu, 24 Jul 2025 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h58J0Wne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED91A4F3C;
	Thu, 24 Jul 2025 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345023; cv=none; b=E21hWCqWGnberLQYITkbU1nmC0mIshA5Cl1KZF2h9pjwD4DDt32LOplGCfbZhltRRP8JlEf0QqDx7KHNsCtWE/5d6V1mEoV67GzYrQi/9sM6Bolg/cIuS5cbus8daMCfwiGRM8h7/A92EucDcAyw/SsZ5rpZGbjyHVAdmNxcZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345023; c=relaxed/simple;
	bh=wptEVqnmBc1ZGct6J0t7hxveJYyKzsJlWIx61MzWRbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANITx5XHVHflHQ7NWiBU4GuL6qiczeqxTK/HwJD1ig+9NY54+vkd1VH762g931ruDyIabZjy/2Jn3MraZgrsVd9w71ELkAl5eWRVGdXb/DZqu4BUlsUHzDKINTti0cLDmaLLtnwUS364Zb/g7ACcwwWjvLFgHj6pNkZd/DD6Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h58J0Wne; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e92cso494606b3a.1;
        Thu, 24 Jul 2025 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753345021; x=1753949821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bemT7jVEV2L5HIRvoWrvjFbWT8mOk0f0AWRK4b4eQmE=;
        b=h58J0Wne4z4iql3a80RHtQ5nnhC7akV74/1GoqhQi91WPmTQCmsEmmZ5b0jonl2LRw
         rhNpVfCNM/CY3b6j50H929BCYqvyZULt+qVpHon7T/cVV4MLXYQrxbIMOr1i7JWTH/8d
         FtceHQ2fh4+sOS1EHPfnykXzdX45iowSG6gnYbjTyRpnpRwIWZniVYWziLuVGbT+OpmY
         p9uwXDMPgMXGiSbUNYw7+zSxJ9hMpt2SSopf5AptjHJxxVGOWwljgWbWffKxqXTs6f5H
         p8wODh7oyonbd/cJOIe4CRcUa3FmHecpc6b73kg8IkAFwObG/l46/mKOH4NlapZYtTbT
         ZS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345021; x=1753949821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bemT7jVEV2L5HIRvoWrvjFbWT8mOk0f0AWRK4b4eQmE=;
        b=GupURPd5DpiDu5v5dBa8bGmp3l1/I0SMbgnbi5xksQwIz314US/qKlfwwmylKlVxC6
         tWE0tub49dT/DuRUcMbu1O6qtqA1rGhPySEekNIm/JNyaxr+9CO8krrQ3M2pHehTHvK4
         zlGUn38S0WdJ7TJHYRdGhU4E3aFG1PeKlcEDVhi419EkL7MtF9zMqkGHJ2QIrhfN0ndD
         rh55SaW0HPBaWa1KEWgBhvgOxDJBnB21N89upRGjaFmkwAzIacDA0KwkjBEfpBamKGCc
         Xs8rW5J+K2q+/F1EqjBchjih2ncLOYbZqIYrR4SCWSFqlaM5joe6CZ97Pk8/B05gmkiP
         wiNg==
X-Forwarded-Encrypted: i=1; AJvYcCU52K3UK8zlxLtWo0sT1lnuQt41NAX9QEdLJzx3B+ojgJqH99cR/UFuAm/zPYSczdzQnJBetWsozwkpRArS@vger.kernel.org, AJvYcCUtW/LgS9t2SVCF6T9MEXGXOenin+4g2G4xK0BPzqmnXa0W6mS0zFbYICkK50HaNvSMzqei/CBO4xs=@vger.kernel.org, AJvYcCVFveJhSlr3FGzXu80o3SUEDxZxhPietO4IVOavVKA8HRLnS923wdvrCBLSxo7YHjPGvm10hpkYalnPxnIwbEQL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw400bkIuvugCKayM0HwHN2T3azKezLow/7HPvgXt9FoKbD+4Ww
	qzqrUZqoe4zyQxsdiO4/BdxAoYPClIBrvRe360r8lFLgfa/orhtSeUXSRYx33Hbe
X-Gm-Gg: ASbGnctR8j1bcIF3l7tjX47K2fYPkll80KFGUGt8zl6zFtuGDtsEKPPHy+g2JdnV3Bv
	a5aH8r2RfRsntaGSIA2jg5gQLMIr6yQVjW6EMkdIdPeJkNdx/BZBsuzFQZyhLNBZHml/crozkX/
	HYY6oLDcdmmSSrrGCJ9JZRmkZ4OTiHIB3tZVNr1xZGQumjd/okBidVjgOOpCmWFouUZwpBwCmLM
	lV3M2NWFFahOen/ydnPq9nWp8TgjeWvhy0fe0uV8J2OgRQay593vSUgCVPuSs2Hzz62/gYkTnGd
	FstdTnwKrffX9HvCXRIuUrK7Ias2sSBAQM7NecYDeAOv1Yw3NK2Od9vbPfkwUD8A/TWNnQUsXaR
	KJM77W65WSRnAy/qCgG7sJfLbBF/2B/RaI/XgyKGhGrQ4yjY=
X-Google-Smtp-Source: AGHT+IHaYBCozI7SqHxrLah+Edbfhj9bliokCAp+L0ubN3e6km2nUgJuI2Xx4ak+xa7g2BmQyMxOHQ==
X-Received: by 2002:a05:6a20:6a0a:b0:239:d43:4815 with SMTP id adf61e73a8af0-23d490e7f3amr10149916637.28.1753345020922;
        Thu, 24 Jul 2025 01:17:00 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7bbeesm1074704b3a.24.2025.07.24.01.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:17:00 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] bonding: support aggregator selection based on port priority
Date: Thu, 24 Jul 2025 08:16:29 +0000
Message-ID: <20250724081632.12921-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new per-port bonding option: `ad_actor_port_prio`.

It allows users to configure the actor's port priority, which can then be used
by the bonding driver for aggregator selection based on port priority.

This provides finer control over LACP aggregator choice, especially in setups
with multiple eligible aggregators over 2 switches.

Hangbin Liu (3):
  bonding: add support for per-port LACP actor priority
  bonding: support aggregator selection based on port priority
  selftests: bonding: add test for LACP actor port priority

 Documentation/networking/bonding.rst          | 18 ++++-
 drivers/net/bonding/bond_3ad.c                | 31 ++++++++
 drivers/net/bonding/bond_netlink.c            | 16 ++++
 drivers/net/bonding/bond_options.c            | 36 +++++++++
 include/net/bond_3ad.h                        |  2 +
 include/net/bond_options.h                    |  1 +
 include/uapi/linux/if_link.h                  |  1 +
 .../selftests/drivers/net/bonding/Makefile    |  3 +-
 .../drivers/net/bonding/bond_lacp_prio.sh     | 73 +++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 24 ------
 tools/testing/selftests/net/lib.sh            | 24 ++++++
 11 files changed, 203 insertions(+), 26 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh

-- 
2.46.0


